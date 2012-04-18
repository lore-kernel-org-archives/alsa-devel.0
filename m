From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH] configure.in: look for ncurses pkg-config first
Date: Wed, 18 Apr 2012 10:25:54 -0400
Message-ID: <1334759154-22302-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.gentoo.org (smtp.gentoo.org [140.211.166.183])
	by alsa0.perex.cz (Postfix) with ESMTP id AC15B243AC
	for <alsa-devel@alsa-project.org>;
	Wed, 18 Apr 2012 16:25:09 +0200 (CEST)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by smtp.gentoo.org (Postfix) with ESMTP id 6FD781B4012
	for <alsa-devel@alsa-project.org>; Wed, 18 Apr 2012 14:25:06 +0000 (UTC)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Newer ncurses installs pkg-config files, and these are much easier
to manage when cross-compiling, so default to searching for those.
If they can't be found, we fall back to the existing xxx-config.

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 configure.in |   64 +++++++++++++++++++++++++++++++++++++--------------------
 1 files changed, 41 insertions(+), 23 deletions(-)

diff --git a/configure.in b/configure.in
index 2208a95..9404df0 100644
--- a/configure.in
+++ b/configure.in
@@ -29,6 +29,7 @@ AC_PROG_INSTALL
 AC_PROG_MKDIR_P
 AC_PROG_LN_S
 AC_PROG_SED
+PKG_PROG_PKG_CONFIG
 AM_PATH_ALSA(1.0.24)
 AC_CHECK_FUNC([snd_ctl_elem_add_enumerated],
 	      , [AC_ERROR([No user enum control support in alsa-lib])])
@@ -130,34 +131,52 @@ if test x$alsamixer = xtrue; then
   NCURSESLIBSUFFIX=""
   CURSES_NLS="no"
   if test "$curseslib" = "ncursesw" -o \( "$curseslib" = "auto" -a "$USE_NLS" = "yes" \); then
-    AC_CHECK_PROG([ncursesw5_config], [ncursesw5-config], [yes])
-    if test "$ncursesw5_config" = "yes"; then
-      CURSESINC="<ncurses.h>"
-      CURSESLIB=`ncursesw5-config --libs`
-      CURSESLIBDIR=`ncursesw5-config --libdir`
-      CURSES_CFLAGS=`ncursesw5-config --cflags`
-      curseslib="ncursesw"
-    else
-      AC_CHECK_LIB(ncursesw, initscr,
-                 [ CURSESINC='<ncurses.h>'; CURSESLIB='-lncursesw'; curseslib="ncursesw"])
-    fi
+    dnl First try out pkg-config, then fall back to old config scripts.
+    PKG_CHECK_MODULES([NCURSESW], [ncursesw], [
+        CURSESINC="<ncurses.h>"
+        CURSESLIB="${NCURSESW_LIBS}"
+        CURSESLIBDIR=
+        CURSES_CFLAGS="${NCURSESW_CFLAGS}"
+        curseslib="ncursesw"
+      ], [
+        AC_CHECK_PROG([ncursesw5_config], [ncursesw5-config], [yes])
+        if test "$ncursesw5_config" = "yes"; then
+          CURSESINC="<ncurses.h>"
+          CURSESLIB=`ncursesw5-config --libs`
+          CURSESLIBDIR=`ncursesw5-config --libdir`
+          CURSES_CFLAGS=`ncursesw5-config --cflags`
+          curseslib="ncursesw"
+        else
+          AC_CHECK_LIB(ncursesw, initscr,
+                     [ CURSESINC='<ncurses.h>'; CURSESLIB='-lncursesw'; curseslib="ncursesw"])
+        fi
+      ])
     if test -n "$CURSESINC"; then
       NCURSESLIBSUFFIX="w"
       CURSES_NLS="yes"
     fi
   fi
   if test "$curseslib" = "ncurses" -o "$curseslib" = "auto"; then
-    AC_CHECK_PROG([ncurses5_config], [ncurses5-config], [yes])
-    if test "$ncurses5_config" = "yes"; then
-      CURSESINC="<ncurses.h>"
-      CURSESLIB=`ncurses5-config --libs`
-      CURSESLIBDIR=`ncurses5-config --libdir`
-      CURSES_CFLAGS=`ncurses5-config --cflags`
-      curseslib="ncurses"
-    else
-      AC_CHECK_LIB(ncurses, initscr,
-                 [ CURSESINC='<ncurses.h>'; CURSESLIB='-lncurses'; curseslib="ncurses"])
-    fi
+    dnl First try out pkg-config, then fall back to old config scripts.
+    PKG_CHECK_MODULES([NCURSES], [ncurses], [
+        CURSESINC="<ncurses.h>"
+        CURSESLIB="${NCURSES_LIBS}"
+        CURSESLIBDIR=
+        CURSES_CFLAGS="${NCURSES_CFLAGS}"
+        curseslib="ncurses"
+      ], [
+        AC_CHECK_PROG([ncurses5_config], [ncurses5-config], [yes])
+        if test "$ncurses5_config" = "yes"; then
+          CURSESINC="<ncurses.h>"
+          CURSESLIB=`ncurses5-config --libs`
+          CURSESLIBDIR=`ncurses5-config --libdir`
+          CURSES_CFLAGS=`ncurses5-config --cflags`
+          curseslib="ncurses"
+        else
+          AC_CHECK_LIB(ncurses, initscr,
+                     [ CURSESINC='<ncurses.h>'; CURSESLIB='-lncurses'; curseslib="ncurses"])
+        fi
+      ])
   fi
   if test "$curseslib" = "curses" -o "$curseslib" = "auto"; then
     AC_CHECK_LIB(curses, initscr,
@@ -287,7 +306,6 @@ SAVE_UTIL_VERSION
 AC_SUBST(LIBRT)
 
 dnl Check for systemd
-PKG_PROG_PKG_CONFIG
 AC_ARG_WITH([systemdsystemunitdir],
         AS_HELP_STRING([--with-systemdsystemunitdir=DIR], [Directory for systemd service files]),
         [], [with_systemdsystemunitdir=$($PKG_CONFIG --variable=systemdsystemunitdir systemd)])
-- 
1.7.8.5
