From: =?UTF-8?q?Diego=20Elio=20Petten=C3=B2?= <flameeyes@gmail.com>
Subject: [alsa-lib PATCH] Update attributes.m4 to avoid
	warnings with autoconf-2.68
Date: Thu, 20 Jan 2011 15:47:03 +0100
Message-ID: <1295534823-31657-1-git-send-email-flameeyes@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id CE3B32450E
	for <alsa-devel@alsa-project.org>; Thu, 20 Jan 2011 15:47:07 +0100 (CET)
Received: by wwe15 with SMTP id 15so660895wwe.20
	for <alsa-devel@alsa-project.org>; Thu, 20 Jan 2011 06:47:07 -0800 (PST)
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

---
 m4/attributes.m4 |   21 +++++++++++++++------
 1 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/m4/attributes.m4 b/m4/attributes.m4
index e86456a..82b4a3c 100644
--- a/m4/attributes.m4
+++ b/m4/attributes.m4
@@ -25,7 +25,7 @@ dnl License when using or distributing such scripts, even though portions
 dnl of the text of the Macro appear in them. The GNU General Public
 dnl License (GPL) does govern all other use of the material that
 dnl constitutes the Autoconf Macro.
-dnl 
+dnl
 dnl This special exception to the GPL applies to versions of the
 dnl Autoconf Macro released by this project. When you make and
 dnl distribute a modified version of the Autoconf Macro, you may extend
@@ -39,7 +39,7 @@ AC_DEFUN([CC_CHECK_CFLAGS_SILENT], [
   AC_CACHE_VAL(AS_TR_SH([cc_cv_cflags_$1]),
     [ac_save_CFLAGS="$CFLAGS"
      CFLAGS="$CFLAGS $1"
-     AC_COMPILE_IFELSE([int a;],
+     AC_LINK_IFELSE([AC_LANG_SOURCE([int main() { return 0; }])],
        [eval "AS_TR_SH([cc_cv_cflags_$1])='yes'"],
        [eval "AS_TR_SH([cc_cv_cflags_$1])='no'"])
      CFLAGS="$ac_save_CFLAGS"
@@ -89,7 +89,7 @@ AC_DEFUN([CC_CHECK_LDFLAGS], [
     AS_TR_SH([cc_cv_ldflags_$1]),
     [ac_save_LDFLAGS="$LDFLAGS"
      LDFLAGS="$LDFLAGS $1"
-     AC_LINK_IFELSE([int main() { return 1; }],
+     AC_LINK_IFELSE([AC_LANG_SOURCE([int main() { return 1; }])],
        [eval "AS_TR_SH([cc_cv_ldflags_$1])='yes'"],
        [eval "AS_TR_SH([cc_cv_ldflags_$1])="])
      LDFLAGS="$ac_save_LDFLAGS"
@@ -147,7 +147,7 @@ AC_DEFUN([CC_CHECK_ATTRIBUTE], [
     AS_TR_SH([cc_cv_attribute_$1]),
     [ac_save_CFLAGS="$CFLAGS"
      CFLAGS="$CFLAGS $cc_cv_werror"
-     AC_COMPILE_IFELSE([$3],
+     AC_COMPILE_IFELSE([AC_LANG_SOURCE([$3])],
        [eval "AS_TR_SH([cc_cv_attribute_$1])='yes'"],
        [eval "AS_TR_SH([cc_cv_attribute_$1])='no'"])
      CFLAGS="$ac_save_CFLAGS"
@@ -165,7 +165,16 @@ AC_DEFUN([CC_CHECK_ATTRIBUTE], [
 AC_DEFUN([CC_ATTRIBUTE_CONSTRUCTOR], [
   CC_CHECK_ATTRIBUTE(
     [constructor],,
-    [void __attribute__((constructor)) ctor() { int a; }],
+    [extern void foo();
+     void __attribute__((constructor)) ctor() { foo(); }],
+    [$1], [$2])
+])
+
+AC_DEFUN([CC_ATTRIBUTE_DESTRUCTOR], [
+  CC_CHECK_ATTRIBUTE(
+    [destructor],,
+    [extern void foo();
+     void __attribute__((destructor)) dtor() { foo(); }],
     [$1], [$2])
 ])
 
@@ -257,7 +266,7 @@ AC_DEFUN([CC_FLAG_VISIBILITY], [
 	cc_cv_flag_visibility='yes',
 	cc_cv_flag_visibility='no')
      CFLAGS="$cc_flag_visibility_save_CFLAGS"])
-  
+
   AS_IF([test "x$cc_cv_flag_visibility" = "xyes"],
     [AC_DEFINE([SUPPORT_FLAG_VISIBILITY], 1,
        [Define this if the compiler supports the -fvisibility flag])
-- 
1.7.4.rc2
