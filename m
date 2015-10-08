From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH alsa-utils] build: Do not try to detect
	cross-compiler
Date: Thu,  8 Oct 2015 12:14:05 -0400
Message-ID: <1444320845-3691-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.gentoo.org (smtp.gentoo.org [140.211.166.183])
 by alsa0.perex.cz (Postfix) with ESMTP id 80732264F30
 for <alsa-devel@alsa-project.org>; Thu,  8 Oct 2015 18:14:13 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, raj.khem@gmail.com
List-Id: alsa-devel@alsa-project.org

From: Mike Frysinger <vapier@chromium.org>

cross compilers are passed via path may not be a gcc based cross
compiler in such cases this check fails and try's to force gcc based
cross compiler detection, This code is a convenience that limits the
build system.

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
Note: this is the same fix that landed in alsa-lib.

 configure.ac | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/configure.ac b/configure.ac
index 8c2d1a5..79a9aaf 100644
--- a/configure.ac
+++ b/configure.ac
@@ -12,20 +12,6 @@ AM_GNU_GETTEXT_VERSION([0.15])
 
 dnl Checks for programs.
 
-dnl try to gues cross-compiler if not set
-if test "x$target" != "x$host" -a -z "`echo $CC | grep -e '-gcc'`";
-then
-  AC_MSG_CHECKING(for cross-compiler)
-
-  which ${program_prefix}gcc >/dev/null 2>&1 && CC=${program_prefix}gcc
-  which ${target_cpu}-${target_os}-gcc >/dev/null 2>&1 \
-  && CC=${target_cpu}-${target-os}-gcc
-  which ${target_cpu}-${target_vendor}-${target_os}-gcc >/dev/null 2>&1 \
-  && CC=${target_cpu}-${target_vendor}-${target_os}-gcc
-
-  AC_MSG_RESULT($CC)
-fi
-
 AC_PROG_CC
 dnl AC_PROG_CXX
 AC_PROG_INSTALL
-- 
2.5.2
