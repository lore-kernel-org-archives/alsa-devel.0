From: Anton Khirnov <anton@khirnov.net>
Subject: [PATCH 2/4] a52: fix some usage of deprecated/removed
	lavc API.
Date: Sun, 11 Nov 2012 11:30:02 +0100
Message-ID: <1352629804-19880-3-git-send-email-anton@khirnov.net>
References: <1352629804-19880-1-git-send-email-anton@khirnov.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lain.khirnov.net (lain.khirnov.net [176.97.15.12])
 by alsa0.perex.cz (Postfix) with ESMTP id 8159F2615CF
 for <alsa-devel@alsa-project.org>; Sun, 11 Nov 2012 11:30:16 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by lain.khirnov.net (Postfix) with ESMTP id 5BE0BC16CB
 for <alsa-devel@alsa-project.org>; Sun, 11 Nov 2012 11:30:16 +0100 (CET)
Received: from lain.khirnov.net ([127.0.0.1])
 by localhost (mail.khirnov.net [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ILa8S-Hi9+at for <alsa-devel@alsa-project.org>;
 Sun, 11 Nov 2012 11:30:13 +0100 (CET)
Received: from daenerys.khirnov.net (daenerys.khirnov.net
 [IPv6:2002:b061:f0a:2:bc67:f85b:493c:acab])
 by lain.khirnov.net (Postfix) with ESMTP id AEF1AC16CD
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

---
 a52/pcm_a52.c |   12 ++++++------
 configure.in  |    6 +++---
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/a52/pcm_a52.c b/a52/pcm_a52.c
index c1dd96e..9fd326c 100644
--- a/a52/pcm_a52.c
+++ b/a52/pcm_a52.c
@@ -26,6 +26,7 @@
 #include <alsa/pcm_external.h>
 #include <alsa/pcm_plugin.h>
 #include <libavcodec/avcodec.h>
+#include <libavutil/audioconvert.h>
 
 struct a52_ctx {
 	snd_pcm_ioplug_t io;
@@ -424,7 +425,7 @@ static int a52_prepare(snd_pcm_ioplug_t *io)
 
 	a52_free(rec);
 
-	rec->avctx = avcodec_alloc_context();
+	rec->avctx = avcodec_alloc_context3(rec->codec);
 	if (! rec->avctx)
 		return -ENOMEM;
 
@@ -434,19 +435,19 @@ static int a52_prepare(snd_pcm_ioplug_t *io)
   rec->avctx->sample_fmt = AV_SAMPLE_FMT_S16;
 	switch (io->channels) {
 	case 2:
-		rec->avctx->channel_layout = CH_LAYOUT_STEREO;
+		rec->avctx->channel_layout = AV_CH_LAYOUT_STEREO;
 		break;
 	case 4:
-		rec->avctx->channel_layout = CH_LAYOUT_QUAD;
+		rec->avctx->channel_layout = AV_CH_LAYOUT_QUAD;
 		break;
 	case 6:
-		rec->avctx->channel_layout = CH_LAYOUT_5POINT1;
+		rec->avctx->channel_layout = AV_CH_LAYOUT_5POINT1;
 		break;
 	default:
 		break;
 	}
 
-	if (avcodec_open(rec->avctx, rec->codec) < 0)
+	if (avcodec_open2(rec->avctx, rec->codec, NULL) < 0)
 		return -EINVAL;
 
 	rec->inbuf = malloc(rec->avctx->frame_size * 2 * io->channels);
@@ -691,7 +692,6 @@ SND_PCM_PLUGIN_DEFINE_FUNC(a52)
 	rec->channels = channels;
 	rec->format = format;
 
-	avcodec_init();
 	avcodec_register_all();
 
 	rec->codec = avcodec_find_encoder_by_name("ac3_fixed");
diff --git a/configure.in b/configure.in
index 2b422df..0a3d424 100644
--- a/configure.in
+++ b/configure.in
@@ -67,7 +67,7 @@ AC_ARG_ENABLE([avcodec],
       AS_HELP_STRING([--disable-avcodec], [Don't build plugins depending on avcodec (a52)]))
 
 if test "x$enable_avcodec" != "xno"; then
-  PKG_CHECK_MODULES(AVCODEC, [libavcodec >= 53.34.0], [HAVE_AVCODEC=yes], [HAVE_AVCODEC=no])
+  PKG_CHECK_MODULES(AVCODEC, [libavcodec >= 53.34.0 libavutil >= 51.21.0], [HAVE_AVCODEC=yes], [HAVE_AVCODEC=no])
 fi
 
 if test "x$HAVE_AVCODEC" = "xno"; then
@@ -84,8 +84,8 @@ if test "x$HAVE_AVCODEC" = "xno"; then
   LDFLAGS_saved="$LDFLAGS"
   CFLAGS="$CFLAGS $AVCODEC_CFLAGS"
   LDFLAGS="$LDFLAGS $AVCODEC_LIBS"
-  AVCODEC_LIBS="$AVCODEC_LIBS -lavcodec"
-  AC_CHECK_LIB([avcodec], [avcodec_open], [HAVE_AVCODEC=yes], [HAVE_AVCODEC=no])
+  AVCODEC_LIBS="$AVCODEC_LIBS -lavutil -lavcodec"
+  AC_CHECK_LIB([avcodec], [avcodec_open2], [HAVE_AVCODEC=yes], [HAVE_AVCODEC=no])
   CFLAGS="$CFLAGS_saved"
   LDFLAGS="$LDFLAGS_saved"
 fi
-- 
1.7.10.4
