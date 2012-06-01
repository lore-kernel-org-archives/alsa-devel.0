From: "Guido Trentalancia" <guido@trentalancia.com>
Subject: alsa-plugins-1.0.25: fix building with ffmpeg >= 0.11
Date: Fri, 01 Jun 2012 16:35:40 +0200
Message-ID: <201206011435.q51EZeMT027666@vivaldi01.register.it>
Reply-To: Guido Trentalancia <guido@trentalancia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hostingsmtp.register.it (hostingsmtp06.register.it
	[81.88.50.247]) by alsa0.perex.cz (Postfix) with ESMTP id 0B8E710400C
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Jun 2012 16:35:47 +0200 (CEST)
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

alsa-plugins version 1.0.25 cannot build with latest ffmpeg version 0.11 because a few CH_LAYOUT_* aliases to AV_CH_LAYOUT_* defines have been removed from the ffmpeg libavcodec header files.

A bug has been opened in the bug tracking system (#0005587):

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=5587

Here is an example patch to fix the issue:

Ffmpeg 0.11 (LIBAVCODEC_VERSION_MAJOR = 54) removed the CH_LAYOUT_* aliases for the AV_CH_LAYOUT_* defines.

diff -pru alsa-plugins-1.0.25-original/a52/pcm_a52.c alsa-plugins-1.0.25-for-ffmpeg-0.11/a52/pcm_a52.c
--- alsa-plugins-1.0.25-original/a52/pcm_a52.c	2012-01-25 08:57:07.000000000 +0100
+++ alsa-plugins-1.0.25-for-ffmpeg-0.11/a52/pcm_a52.c	2012-06-01 14:59:47.096671464 +0200
@@ -441,7 +441,21 @@ static int a52_prepare(snd_pcm_ioplug_t
 #else
   rec->avctx->sample_fmt = SAMPLE_FMT_S16;
 #endif
-#if LIBAVCODEC_VERSION_MAJOR > 52 || (LIBAVCODEC_VERSION_MAJOR == 52 && LIBAVCODEC_VERSION_MINOR >= 3)
+#if (LIBAVCODEC_VERSION_MAJOR >= 54)
+	switch (io->channels) {
+	case 2:
+		rec->avctx->channel_layout = AV_CH_LAYOUT_STEREO;
+		break;
+	case 4:
+		rec->avctx->channel_layout = AV_CH_LAYOUT_QUAD;
+		break;
+	case 6:
+		rec->avctx->channel_layout = AV_CH_LAYOUT_5POINT1;
+		break;
+	default:
+		break;
+	}
+#elif (LIBAVCODEC_VERSION_MAJOR > 52 && LIBAVCODEC_VERSION_MAJOR < 54) || (LIBAVCODEC_VERSION_MAJOR == 52 && LIBAVCODEC_VERSION_MINOR >= 3)
	switch (io->channels) {
 	case 2:
 		rec->avctx->channel_layout = CH_LAYOUT_STEREO; 
