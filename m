From: Qais Yousef <qais.yousef@imgtec.com>
Subject: [TINYCOMPRESS][v2 PATCH 0/7] Convert build system to
	autotools
Date: Tue, 24 Mar 2015 10:32:27 +0000
Message-ID: <1427193154-6753-1-git-send-email-qais.yousef@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailapp01.imgtec.com (mailapp01.imgtec.com [195.59.15.196])
 by alsa0.perex.cz (Postfix) with ESMTP id DDBA3260436
 for <alsa-devel@alsa-project.org>; Tue, 24 Mar 2015 11:32:39 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: vinod.koul@intel.com
Cc: alsa-devel@alsa-project.org, Qais Yousef <qais.yousef@imgtec.com>
List-Id: alsa-devel@alsa-project.org

This series converts the build system to use autotools and splits the files into
lib and utils.

Also patch 5 fixes error handling code.

I can't test Android builds but both cross and native compiling worked for me.

I left AUTHORS, ChangeLog and NEWS files empty. I used the license header to fill COPYING.

Changes in v2:
 - Use -M option when generating the patches
 - Add Makefile.am to include directory that exports tinycompress.h
 - New patch (7) that fixes include dependency in tinycompress.h

Qais Yousef (7):
  Convert the build system to autotools
  add .gitignore file
  makefile.linux: delete as no longer necessary/used
  Android.mk: Update to use the new location of source files
  compress.c: fix check for errors from poll(), read() and write()
  src/lib/utils.c: remove this empty file
  tinycompress.h: explicitly include required headers

 .gitignore                          |  39 ++++
 AUTHORS                             |   0
 Android.mk                          |   6 +-
 COPYING                             |  51 +++++
 ChangeLog                           |   0
 INSTALL                             | 365 ++++++++++++++++++++++++++++++++++++
 Makefile.am                         |   3 +
 NEWS                                |   0
 autogen.sh                          |   6 +
 configure.ac                        |  32 ++++
 include/Makefile.am                 |   6 +
 include/tinycompress/tinycompress.h |   3 +
 m4/.place_holder                    |   0
 makefile.linux                      |  41 ----
 src/Makefile.am                     |   1 +
 src/lib/Makefile.am                 |   5 +
 compress.c => src/lib/compress.c    |  22 ++-
 src/utils/Makefile.am               |  11 ++
 cplay.c => src/utils/cplay.c        |   0
 crec.c => src/utils/crec.c          |   0
 utils.c                             |  62 ------
 21 files changed, 537 insertions(+), 116 deletions(-)
 create mode 100644 .gitignore
 create mode 100644 AUTHORS
 create mode 100644 COPYING
 create mode 100644 ChangeLog
 create mode 100644 INSTALL
 create mode 100644 Makefile.am
 create mode 100644 NEWS
 create mode 100755 autogen.sh
 create mode 100644 configure.ac
 create mode 100644 include/Makefile.am
 create mode 100644 m4/.place_holder
 delete mode 100644 makefile.linux
 create mode 100644 src/Makefile.am
 create mode 100644 src/lib/Makefile.am
 rename compress.c => src/lib/compress.c (98%)
 create mode 100644 src/utils/Makefile.am
 rename cplay.c => src/utils/cplay.c (100%)
 rename crec.c => src/utils/crec.c (100%)
 delete mode 100644 utils.c

-- 
2.1.0
