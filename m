From: plevine457@gmail.com
Subject: [PATCH - Fix typo in configure.ac 1/1] PATCH - Fix
	typo in configure.ac
Date: Tue, 25 Sep 2018 01:22:40 -0400
Message-ID: <5ba9c647.1c69fb81.1df8f.531b@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, Peter Levine <plevine457@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Peter Levine <plevine457@gmail.com>

Signed-off-by: Peter Levine <plevine457@gmail.com>

diff --git a/configure.ac b/configure.ac
index 3e2d233..cc3740b 100644
--- a/configure.ac
+++ b/configure.ac
@@ -90,7 +90,7 @@ if test "$use_maemo_rm" = "yes"; then
 fi
 
 AC_ARG_ENABLE([libav],
-      AS_HELP_STRING([--disable-avlib], [Do not build plugins depending on libav/ffmpeg (a52,lavrate...)]))
+      AS_HELP_STRING([--disable-libav], [Do not build plugins depending on libav/ffmpeg (a52,lavrate...)]))
 
 if test "x$enable_libav" != "xno"; then
   PKG_CHECK_MODULES(LIBAV, [libavcodec libavutil libavresample], [HAVE_LIBAV=yes], [HAVE_LIBAV=no])
-- 
2.19.0
