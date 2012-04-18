From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH] configure.in: use AS_HELP_STRING everywhere
Date: Wed, 18 Apr 2012 10:29:18 -0400
Message-ID: <1334759358-23649-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.gentoo.org (smtp.gentoo.org [140.211.166.183])
	by alsa0.perex.cz (Postfix) with ESMTP id B8238243AC
	for <alsa-devel@alsa-project.org>;
	Wed, 18 Apr 2012 16:28:31 +0200 (CEST)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by smtp.gentoo.org (Postfix) with ESMTP id D54F21B401F
	for <alsa-devel@alsa-project.org>; Wed, 18 Apr 2012 14:28:29 +0000 (UTC)
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

This macro takes care of spacing for us.

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 configure.in |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/configure.in b/configure.in
index 9404df0..e7bb4ca 100644
--- a/configure.in
+++ b/configure.in
@@ -76,7 +76,7 @@ CURSES_CFLAGS=""
 alsamixer=
 if test "$have_mixer" = "yes"; then
 AC_ARG_ENABLE(alsamixer,
-     [  --disable-alsamixer     Disable alsamixer compilation],
+     AS_HELP_STRING([--disable-alsamixer], [Disable alsamixer compilation]),
      [case "${enableval}" in
        yes) alsamixer=true ;;
        no)  alsamixer=false ;;
@@ -87,7 +87,7 @@ AM_CONDITIONAL(ALSAMIXER, test x$alsamixer = xtrue)
 
 dnl Disable alsaconf
 AC_ARG_ENABLE(alsaconf,
-     [  --disable-alsaconf      Disable alsaconf packaging],
+     AS_HELP_STRING([--disable-alsaconf], [Disable alsaconf packaging]),
      [case "${enableval}" in
        yes) alsaconf=true ;;
        no)  alsaconf=false ;;
@@ -97,7 +97,7 @@ AM_CONDITIONAL(ALSACONF, test x$alsaconf = xtrue)
 
 dnl Disable alsaloop
 AC_ARG_ENABLE(alsaloop,
-     [  --disable-alsaloop      Disable alsaloop packaging],
+     AS_HELP_STRING([--disable-alsaloop], [Disable alsaloop packaging]),
      [case "${enableval}" in
        yes) alsaloop=true ;;
        no)  alsaloop=false ;;
@@ -124,7 +124,7 @@ dnl Checks for header files.
 AC_HEADER_STDC
 if test x$alsamixer = xtrue; then
   AC_ARG_WITH(curses,
-    [  --with-curses libname   Specify the curses library to use (default=auto)],
+    AS_HELP_STRING([--with-curses=libname], [Specify the curses library to use (default=auto)]),
     curseslib="$withval",
     curseslib="auto")
   CURSESLIBDIR=""
@@ -283,7 +283,7 @@ mydatadir="$dir/alsa"
 AC_DEFINE_UNQUOTED(DATADIR, "$mydatadir", [directory containing alsa configuration])
 
 AC_ARG_WITH(testsound,
-  [  --with-testsound=file        give the path of test sound file for alsaconf],
+  AS_HELP_STRING([--with-testsound=file], [give the path of test sound file for alsaconf]),
   TESTSOUND="$withval",
   TESTSOUND="$dir/test.wav")
 AC_SUBST(TESTSOUND)
-- 
1.7.8.5
