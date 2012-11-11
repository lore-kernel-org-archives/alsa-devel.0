From: Anton Khirnov <anton@khirnov.net>
Subject: [PATCH 1/4] a52: require libavcodec version >= 53.34
Date: Sun, 11 Nov 2012 11:30:01 +0100
Message-ID: <1352629804-19880-2-git-send-email-anton@khirnov.net>
References: <1352629804-19880-1-git-send-email-anton@khirnov.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lain.khirnov.net (lain.khirnov.net [176.97.15.12])
 by alsa0.perex.cz (Postfix) with ESMTP id 504DC2615CC
 for <alsa-devel@alsa-project.org>; Sun, 11 Nov 2012 11:30:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by lain.khirnov.net (Postfix) with ESMTP id 2934DC1587
 for <alsa-devel@alsa-project.org>; Sun, 11 Nov 2012 11:30:15 +0100 (CET)
Received: from lain.khirnov.net ([127.0.0.1])
 by localhost (mail.khirnov.net [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rxVTBD+jfp56 for <alsa-devel@alsa-project.org>;
 Sun, 11 Nov 2012 11:30:10 +0100 (CET)
Received: from daenerys.khirnov.net (daenerys.khirnov.net
 [IPv6:2002:b061:f0a:2:bc67:f85b:493c:acab])
 by lain.khirnov.net (Postfix) with ESMTP id 981AAC16CB
 for <alsa-devel@alsa-project.org>; Sun, 11 Nov 2012 11:30:10 +0100 (CET)
In-Reply-To: <1352629804-19880-1-git-send-email-anton@khirnov.net>
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
List-Id: alsa-devel@alsa-project.org

It is required for the new audio encoding API.
---
 a52/Makefile.am           |    3 +--
 a52/pcm_a52.c             |   13 +------------
 configure.in              |   15 +--------------
 rate-lavc/Makefile.am     |    3 +--
 rate-lavc/rate_lavcrate.c |    2 +-
 5 files changed, 5 insertions(+), 31 deletions(-)

diff --git a/a52/Makefile.am b/a52/Makefile.am
index 48567b4..f8c3663 100644
--- a/a52/Makefile.am
+++ b/a52/Makefile.am
@@ -2,8 +2,7 @@ asound_module_pcm_a52_LTLIBRARIES = libasound_module_pcm_a52.la
 
 asound_module_pcm_a52dir = @ALSA_PLUGIN_DIR@
 
-AM_CFLAGS = -Wall -g @ALSA_CFLAGS@ @AVCODEC_CFLAGS@ \
-	-DAVCODEC_HEADER="@AVCODEC_HEADER@"
+AM_CFLAGS = -Wall -g @ALSA_CFLAGS@ @AVCODEC_CFLAGS@
 AM_LDFLAGS = -module -avoid-version -export-dynamic -no-undefined $(LDFLAGS_NOUNDEFINED)
 
 libasound_module_pcm_a52_la_SOURCES = pcm_a52.c
diff --git a/a52/pcm_a52.c b/a52/pcm_a52.c
index 00c7c59..c1dd96e 100644
--- a/a52/pcm_a52.c
+++ b/a52/pcm_a52.c
@@ -25,7 +25,7 @@
 #include <alsa/asoundlib.h>
 #include <alsa/pcm_external.h>
 #include <alsa/pcm_plugin.h>
-#include AVCODEC_HEADER
+#include <libavcodec/avcodec.h>
 
 struct a52_ctx {
 	snd_pcm_ioplug_t io;
@@ -170,13 +170,8 @@ static int fill_data(snd_pcm_ioplug_t *io,
 		static unsigned int ch_index[3][6] = {
 			{ 0, 1 },
 			{ 0, 1, 2, 3 },
-#if LIBAVCODEC_VERSION_MAJOR > 52 || (LIBAVCODEC_VERSION_MAJOR == 52 && LIBAVCODEC_VERSION_MINOR >= 26)
 			/* current libavcodec expects SMPTE order */
 			{ 0, 1, 4, 5, 2, 3 },
-#else
-			/* libavcodec older than r18540 expects A52 order */
-			{ 0, 4, 1, 2, 3, 5 },
-#endif
 		};
 		/* flatten copy to n-channel interleaved */
 		dst_step = io->channels;
@@ -436,12 +431,7 @@ static int a52_prepare(snd_pcm_ioplug_t *io)
 	rec->avctx->bit_rate = rec->bitrate * 1000;
 	rec->avctx->sample_rate = io->rate;
 	rec->avctx->channels = io->channels;
-#if LIBAVCODEC_VERSION_MAJOR > 52 || (LIBAVCODEC_VERSION_MAJOR == 52 && LIBAVCODEC_VERSION_MINOR >= 95)
   rec->avctx->sample_fmt = AV_SAMPLE_FMT_S16;
-#else
-  rec->avctx->sample_fmt = SAMPLE_FMT_S16;
-#endif
-#if LIBAVCODEC_VERSION_MAJOR > 52 || (LIBAVCODEC_VERSION_MAJOR == 52 && LIBAVCODEC_VERSION_MINOR >= 3)
 	switch (io->channels) {
 	case 2:
 		rec->avctx->channel_layout = CH_LAYOUT_STEREO;
@@ -455,7 +445,6 @@ static int a52_prepare(snd_pcm_ioplug_t *io)
 	default:
 		break;
 	}
-#endif
 
 	if (avcodec_open(rec->avctx, rec->codec) < 0)
 		return -EINVAL;
diff --git a/configure.in b/configure.in
index 0bf0b8e..2b422df 100644
--- a/configure.in
+++ b/configure.in
@@ -67,7 +67,7 @@ AC_ARG_ENABLE([avcodec],
       AS_HELP_STRING([--disable-avcodec], [Don't build plugins depending on avcodec (a52)]))
 
 if test "x$enable_avcodec" != "xno"; then
-  PKG_CHECK_MODULES(AVCODEC, [libavcodec], [HAVE_AVCODEC=yes], [HAVE_AVCODEC=no])
+  PKG_CHECK_MODULES(AVCODEC, [libavcodec >= 53.34.0], [HAVE_AVCODEC=yes], [HAVE_AVCODEC=no])
 fi
 
 if test "x$HAVE_AVCODEC" = "xno"; then
@@ -90,21 +90,9 @@ if test "x$HAVE_AVCODEC" = "xno"; then
   LDFLAGS="$LDFLAGS_saved"
 fi
 
-if test $HAVE_AVCODEC = yes; then
-  AVCODEC_HEADER=""
-  AC_CHECK_HEADER([ffmpeg/avcodec.h], [AVCODEC_HEADER='<ffmpeg/avcodec.h>'])
-  if test -z "$AVCODEC_HEADER"; then
-    AC_CHECK_HEADER([libavcodec/avcodec.h], [AVCODEC_HEADER='<libavcodec/avcodec.h>'])
-  fi
-  if test -z "$AVCODEC_HEADER"; then
-    HAVE_AVCODEC=no
-  fi
-fi
-
 AM_CONDITIONAL(HAVE_AVCODEC, test x$HAVE_AVCODEC = xyes)
 AC_SUBST(AVCODEC_CFLAGS)
 AC_SUBST(AVCODEC_LIBS)
-AC_SUBST(AVCODEC_HEADER)
 
 PKG_CHECK_MODULES(speexdsp, [speexdsp >= 1.2], [HAVE_SPEEXDSP="yes"], [HAVE_SPEEXDSP=""])
 AM_CONDITIONAL(HAVE_SPEEXDSP, test "$HAVE_SPEEXDSP" = "yes")
@@ -214,7 +202,6 @@ echo "A52, lavc plugins:  $HAVE_AVCODEC"
 if test "$HAVE_AVCODEC" = "yes"; then
   echo "  AVCODEC_CFLAGS: $AVCODEC_CFLAGS"
   echo "  AVCODEC_LIBS: $AVCODEC_LIBS"
-  echo "  AVCODEC_HEADER: $AVCODEC_HEADER"
 fi
 echo "Speex rate plugin:  $PPH"
 echo "Speex preprocess plugin:  $HAVE_SPEEXDSP"
diff --git a/rate-lavc/Makefile.am b/rate-lavc/Makefile.am
index 5cffd44..e100556 100644
--- a/rate-lavc/Makefile.am
+++ b/rate-lavc/Makefile.am
@@ -2,8 +2,7 @@ asound_module_rate_lavcrate_LTLIBRARIES = libasound_module_rate_lavcrate.la
 
 asound_module_rate_lavcratedir = @ALSA_PLUGIN_DIR@
 
-AM_CFLAGS = -Wall -g @ALSA_CFLAGS@ @AVCODEC_CFLAGS@ \
-	-DAVCODEC_HEADER="@AVCODEC_HEADER@"
+AM_CFLAGS = -Wall -g @ALSA_CFLAGS@ @AVCODEC_CFLAGS@
 AM_LDFLAGS = -module -avoid-version -export-dynamic -no-undefined $(LDFLAGS_NOUNDEFINED)
 
 libasound_module_rate_lavcrate_la_SOURCES = rate_lavcrate.c
diff --git a/rate-lavc/rate_lavcrate.c b/rate-lavc/rate_lavcrate.c
index 14a2198..6f3e74d 100644
--- a/rate-lavc/rate_lavcrate.c
+++ b/rate-lavc/rate_lavcrate.c
@@ -19,7 +19,7 @@
 #include <stdio.h>
 #include <alsa/asoundlib.h>
 #include <alsa/pcm_rate.h>
-#include AVCODEC_HEADER
+#include <libavcodec/avcodec.h>
 #include "gcd.h"
 
 static int filter_size = 16;
-- 
1.7.10.4
