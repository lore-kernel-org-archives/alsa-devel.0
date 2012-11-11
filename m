From: Anton Khirnov <anton@khirnov.net>
Subject: [PATCH 4/4] a52: support new versions of libavcodec.
Date: Sun, 11 Nov 2012 11:30:04 +0100
Message-ID: <1352629804-19880-5-git-send-email-anton@khirnov.net>
References: <1352629804-19880-1-git-send-email-anton@khirnov.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lain.khirnov.net (lain.khirnov.net [176.97.15.12])
 by alsa0.perex.cz (Postfix) with ESMTP id 0DFC22615DC
 for <alsa-devel@alsa-project.org>; Sun, 11 Nov 2012 11:30:19 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by lain.khirnov.net (Postfix) with ESMTP id DC941C1587
 for <alsa-devel@alsa-project.org>; Sun, 11 Nov 2012 11:30:18 +0100 (CET)
Received: from lain.khirnov.net ([127.0.0.1])
 by localhost (mail.khirnov.net [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id X7JXAX4jG-Mr for <alsa-devel@alsa-project.org>;
 Sun, 11 Nov 2012 11:30:16 +0100 (CET)
Received: from daenerys.khirnov.net (daenerys.khirnov.net
 [IPv6:2002:b061:f0a:2:bc67:f85b:493c:acab])
 by lain.khirnov.net (Postfix) with ESMTP id E396AC16CE
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

AC3 encoder in recent libavcodec versions requires planar
(non-interleaved) input.
---
 a52/pcm_a52.c |  120 +++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 82 insertions(+), 38 deletions(-)

diff --git a/a52/pcm_a52.c b/a52/pcm_a52.c
index b9ffddb..b60ec2e 100644
--- a/a52/pcm_a52.c
+++ b/a52/pcm_a52.c
@@ -28,6 +28,9 @@
 #include <libavcodec/avcodec.h>
 #include <libavutil/audioconvert.h>
 #include <libavutil/mem.h>
+#include <libavutil/samplefmt.h>
+
+#define MAX_CHANNELS 6
 
 struct a52_ctx {
 	snd_pcm_ioplug_t io;
@@ -35,11 +38,11 @@ struct a52_ctx {
 	AVCodec *codec;
 	AVCodecContext *avctx;
 	AVFrame *frame;
+	int planar;
 	snd_pcm_format_t format;
 	unsigned int channels;
 	unsigned int rate;
 	unsigned int bitrate;
-	short *inbuf;
 	unsigned char *outbuf;
 	int outbuf_size;
 	snd_pcm_uframes_t transfer;
@@ -109,11 +112,16 @@ static int a52_drain(snd_pcm_ioplug_t *io)
 	int err;
 
 	if (rec->filled) {
+		int planes = rec->planar ? io->channels : 1;
+		int blocksize = 2 * (rec->planar ? 1 : io->channels);
+		int i;
+
 		if ((err = write_out_pending(io, rec)) < 0)
 			return err;
 		/* remaining data must be converted and sent out */
-		memset(rec->inbuf + rec->filled * io->channels, 0,
-		       (rec->avctx->frame_size - rec->filled) * io->channels * 2);
+		for (i = 0; i < planes; i++)
+			memset(rec->frame->data[i] + rec->filled * blocksize, 0,
+				   (rec->avctx->frame_size - rec->filled) * blocksize);
 		convert_data(rec);
 	}
 	err = write_out_pending(io, rec);
@@ -151,6 +159,12 @@ static int fill_data(snd_pcm_ioplug_t *io,
 		     unsigned int offset, unsigned int size,
 		     int interleaved)
 {
+	static unsigned int ch_index[3][6] = {
+		{ 0, 1 },
+		{ 0, 1, 2, 3 },
+		/* current libavcodec expects SMPTE order */
+		{ 0, 1, 4, 5, 2, 3 },
+	};
 	struct a52_ctx *rec = io->private_data;
 	unsigned int len = rec->avctx->frame_size - rec->filled;
 	short *src, *dst;
@@ -163,35 +177,42 @@ static int fill_data(snd_pcm_ioplug_t *io,
 	if (size > len)
 		size = len;
 
-	dst = rec->inbuf + rec->filled * io->channels;
-	if (interleaved) {
-		memcpy(dst, areas->addr + offset * io->channels * 2,
-		       size * io->channels * 2);
-	} else {
-		unsigned int i, ch, dst_step;
-		short *dst1;
-		static unsigned int ch_index[3][6] = {
-			{ 0, 1 },
-			{ 0, 1, 2, 3 },
-			/* current libavcodec expects SMPTE order */
-			{ 0, 1, 4, 5, 2, 3 },
-		};
-		/* flatten copy to n-channel interleaved */
-		dst_step = io->channels;
-		for (ch = 0; ch < io->channels; ch++, dst++) {
+	if (rec->planar) {
+		unsigned int i;
+
+		for (i = 0; i < io->channels; i++) {
 			const snd_pcm_channel_area_t *ap;
-			ap = &areas[ch_index[io->channels / 2 - 1][ch]];
-			dst1 = dst;
-			src = (short *)(ap->addr +
-					(ap->first + offset * ap->step) / 8);
-			src_step = ap->step / 16; /* in word */
-			for (i = 0; i < size; i++) {
-				*dst1 = *src;
-				src += src_step;
-				dst1 += dst_step;
+			ap = &areas[ch_index[io->channels / 2 - 1][i]];
+			memcpy(rec->frame->data[i], ap->addr +
+				   (ap->first + offset * ap->step) / 8, size * 2);
+		}
+	} else {
+		dst = (short*)(rec->frame->data[0] + rec->filled * io->channels * 2);
+		if (interleaved) {
+			memcpy(dst, areas->addr + offset * io->channels * 2,
+				   size * io->channels * 2);
+		} else {
+			unsigned int i, ch, dst_step;
+			short *dst1;
+
+			/* flatten copy to n-channel interleaved */
+			dst_step = io->channels;
+			for (ch = 0; ch < io->channels; ch++, dst++) {
+				const snd_pcm_channel_area_t *ap;
+				ap = &areas[ch_index[io->channels / 2 - 1][ch]];
+				dst1 = dst;
+				src = (short *)(ap->addr +
+						(ap->first + offset * ap->step) / 8);
+				src_step = ap->step / 16; /* in word */
+				for (i = 0; i < size; i++) {
+					*dst1 = *src;
+					src += src_step;
+					dst1 += dst_step;
+				}
 			}
 		}
 	}
+
 	rec->filled += size;
 	if (rec->filled == rec->avctx->frame_size) {
 		convert_data(rec);
@@ -410,14 +431,14 @@ static void a52_free(struct a52_ctx *rec)
 		av_free(rec->avctx);
 		rec->avctx = NULL;
 	}
+	if (rec->frame)
+		av_freep(&rec->frame->data[0]);
 #if LIBAVCODEC_VERSION_INT >= AV_VERSION_INT(54, 28, 0)
 	avcodec_free_frame(&rec->frame);
 #else
 	av_freep(&rec->frame);
 #endif
 
-	free(rec->inbuf);
-	rec->inbuf = NULL;
 	free(rec->outbuf);
 	rec->outbuf = NULL;
 }
@@ -430,6 +451,7 @@ static void a52_free(struct a52_ctx *rec)
 static int a52_prepare(snd_pcm_ioplug_t *io)
 {
 	struct a52_ctx *rec = io->private_data;
+	int err;
 
 	a52_free(rec);
 
@@ -444,7 +466,7 @@ static int a52_prepare(snd_pcm_ioplug_t *io)
 	rec->avctx->bit_rate = rec->bitrate * 1000;
 	rec->avctx->sample_rate = io->rate;
 	rec->avctx->channels = io->channels;
-  rec->avctx->sample_fmt = AV_SAMPLE_FMT_S16;
+	rec->avctx->sample_fmt = rec->codec->sample_fmts[0];
 	switch (io->channels) {
 	case 2:
 		rec->avctx->channel_layout = AV_CH_LAYOUT_STEREO;
@@ -462,16 +484,18 @@ static int a52_prepare(snd_pcm_ioplug_t *io)
 	if (avcodec_open2(rec->avctx, rec->codec, NULL) < 0)
 		return -EINVAL;
 
-	rec->inbuf = malloc(rec->avctx->frame_size * 2 * io->channels);
-	if (! rec->inbuf)
-		return -ENOMEM;
+	err = av_samples_alloc(rec->frame->data, rec->frame->linesize,
+						   io->channels, rec->avctx->frame_size,
+						   rec->avctx->sample_fmt, 32);
+	if (err < 0)
+		return - ENOMEM;
+
 	rec->outbuf_size = rec->avctx->frame_size * 4;
 	rec->outbuf = malloc(rec->outbuf_size);
 	if (! rec->outbuf)
 		return -ENOMEM;
 
-	rec->frame->data[0]     = (uint8_t*)rec->inbuf;
-	rec->frame->linesize[0] = rec->avctx->frame_size * 2 * io->channels;
+	rec->planar = av_sample_fmt_is_planar(rec->avctx->sample_fmt);
 	rec->frame->nb_samples  = rec->avctx->frame_size;
 
 	rec->transfer = 0;
@@ -550,19 +574,31 @@ static snd_pcm_ioplug_callback_t a52_ops = {
 
 static int a52_set_hw_constraint(struct a52_ctx *rec)
 {
-	unsigned int accesses[] = {
+	unsigned int accesses_all[] = {
 		SND_PCM_ACCESS_MMAP_INTERLEAVED,
 		SND_PCM_ACCESS_MMAP_NONINTERLEAVED,
 		SND_PCM_ACCESS_RW_INTERLEAVED,
 		SND_PCM_ACCESS_RW_NONINTERLEAVED
 	};
+	unsigned int accesses_planar[] = {
+		SND_PCM_ACCESS_MMAP_NONINTERLEAVED,
+		SND_PCM_ACCESS_RW_NONINTERLEAVED,
+	};
+	unsigned int *accesses = accesses_all;
+	int accesses_size = ARRAY_SIZE(accesses_all);
 	unsigned int formats[] = { SND_PCM_FORMAT_S16 };
 	int err;
 	snd_pcm_uframes_t buffer_max;
 	unsigned int period_bytes, max_periods;
 
+
+	if (av_sample_fmt_is_planar(rec->codec->sample_fmts[0])) {
+		accesses = accesses_planar;
+		accesses_size = ARRAY_SIZE(accesses_planar);
+	}
+
 	if ((err = snd_pcm_ioplug_set_param_list(&rec->io, SND_PCM_IOPLUG_HW_ACCESS,
-						 ARRAY_SIZE(accesses), accesses)) < 0 ||
+						 accesses_size, accesses)) < 0 ||
 	    (err = snd_pcm_ioplug_set_param_list(&rec->io, SND_PCM_IOPLUG_HW_FORMAT,
 						 ARRAY_SIZE(formats), formats)) < 0 ||
 	    (err = snd_pcm_ioplug_set_param_minmax(&rec->io, SND_PCM_IOPLUG_HW_CHANNELS,
@@ -721,6 +757,14 @@ SND_PCM_PLUGIN_DEFINE_FUNC(a52)
 		goto error;
 	}
 
+	if (!rec->codec->sample_fmts ||
+		(rec->codec->sample_fmts[0] != AV_SAMPLE_FMT_S16 &&
+		 rec->codec->sample_fmts[0] != AV_SAMPLE_FMT_S16P)) {
+		SNDERR("AC3 encoder does not support s16 audio.");
+		err = -EINVAL;
+		goto error;
+	}
+
 	if (! pcm_string) {
 		snprintf(devstr, sizeof(devstr),
 			 "iec958:{AES0 0x%x AES1 0x%x AES2 0x%x AES3 0x%x %s%s}",
-- 
1.7.10.4
