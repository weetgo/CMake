# Copyright (c) 2014 Stefan.Eilemann@epfl.ch
# [DEPRECATED] Writes ProjectInfo.cmake for installed html docs.
#
# The generated ProjectInfo.cmake was used by Doxygit.cmake for the manual
# generation of an html index page. Since Doxygit has been deprecated in favor
# of a Jekyll-generated index page on github.io (GitHub pages) this file shall
# be removed too at some later point.
#
# Input Variables:
# * ${UPPER_PROJECT_NAME}_MATURITY EP, RD or RS
# * ${UPPER_PROJECT_NAME}_PACKAGE_URL pointing to the package repository
# * ${UPPER_PROJECT_NAME}_ISSUES_URL pointing to the ticket tracker

include(GithubInfo)

if(NOT ${UPPER_PROJECT_NAME}_MATURITY)
  set(${UPPER_PROJECT_NAME}_MATURITY EP)
endif()
if(DPUT_HOST AND NOT ${UPPER_PROJECT_NAME}_PACKAGE_URL)
  string(REPLACE "/" "/+archive/" ${UPPER_PROJECT_NAME}_PACKAGE_URL
    ${DPUT_HOST})
  string(REPLACE "ppa:" "https://launchpad.net/~"
    ${UPPER_PROJECT_NAME}_PACKAGE_URL ${${UPPER_PROJECT_NAME}_PACKAGE_URL})
endif()

configure_file(${CMAKE_CURRENT_LIST_DIR}/ProjectInfo.in.cmake
  ${PROJECT_BINARY_DIR}/ProjectInfo.cmake)

add_custom_target(project_info_${PROJECT_NAME}
  ${CMAKE_COMMAND} -E copy_if_different
  ${PROJECT_BINARY_DIR}/ProjectInfo.cmake ${PROJECT_BINARY_DIR}/doc/html)
set_target_properties(project_info_${PROJECT_NAME} PROPERTIES
  EXCLUDE_FROM_DEFAULT_BUILD ON FOLDER ${PROJECT_NAME}/zzphony)
