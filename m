From: Daniel Kirchner <daniel@ekpyron.org>
Subject: alsa-plugins: pcm_a52.c uses recently removed
 avcodec_{alloc, free}_frame
Date: Wed, 9 Mar 2016 08:20:59 +0100
Message-ID: <20160309082059.6f82bd85@ekpyrosis>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net
 [217.70.183.197])
 by alsa0.perex.cz (Postfix) with ESMTP id 77447260673
 for <alsa-devel@alsa-project.org>; Wed,  9 Mar 2016 08:21:03 +0100 (CET)
Received: from mfilter43-d.gandi.net (mfilter43-d.gandi.net [217.70.178.174])
 by relay5-d.mail.gandi.net (Postfix) with ESMTP id 1B39441C0A1
 for <alsa-devel@alsa-project.org>; Wed,  9 Mar 2016 08:21:03 +0100 (CET)
Received: from relay5-d.mail.gandi.net ([IPv6:::ffff:217.70.183.197])
 by mfilter43-d.gandi.net (mfilter43-d.gandi.net [::ffff:10.0.15.180])
 (amavisd-new, port 10024)
 with ESMTP id h-pfhSm2k107 for <alsa-devel@alsa-project.org>;
 Wed,  9 Mar 2016 08:21:01 +0100 (CET)
Received: from ekpyrosis (55d45ee4.access.ecotel.net [85.212.94.228])
 (Authenticated sender: daniel@ekpyron.org)
 by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 7B0BD41C099
 for <alsa-devel@alsa-project.org>; Wed,  9 Mar 2016 08:21:01 +0100 (CET)
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

pcm_a52.c uses avcodec_alloc_frame and avcodec_free_frame that have
been replaced by av_frame_alloc and av_frame_free in recent versions of
libavcodec. The following patch should fix this while remaining
backwards compatible.


--- a/a52/pcm_a52.c.orig	2016-03-04 18:21:12.606805770 +0100
+++ b/a52/pcm_a52.c	2016-03-04 18:34:22.653240501 +0100
@@ -62,6 +62,11 @@
 #define AV_CODEC_ID_AC3 CODEC_ID_AC3
 #endif
 
+#if LIBAVCODEC_VERSION_INT < 0x371c01
+#define av_frame_alloc avcodec_alloc_frame
+#define av_frame_free avcodec_free_frame
+#endif
+
 struct a52_ctx {
 	snd_pcm_ioplug_t io;
 	snd_pcm_t *slave;
@@ -513,7 +518,7 @@
 		rec->inbuf = NULL;
 	}
 #if LIBAVCODEC_VERSION_INT >= AV_VERSION_INT(54, 28, 0)
-	avcodec_free_frame(&rec->frame);
+	av_frame_free(&rec->frame);
 #else
 	av_freep(&rec->frame);
 #endif
@@ -557,7 +562,7 @@
 {
 	struct a52_ctx *rec = io->private_data;
 #ifdef USE_AVCODEC_FRAME
-	rec->frame = avcodec_alloc_frame();
+	rec->frame = av_frame_alloc();
 	if (!rec->frame)
 		return -ENOMEM;
 	if (av_samples_alloc(rec->frame->data, rec->frame->linesize,
