From: Anton Khirnov <anton@khirnov.net>
Subject: [PATCH 3/4] a52: use new audio encoding API
Date: Sun, 11 Nov 2012 11:30:03 +0100
Message-ID: <1352629804-19880-4-git-send-email-anton@khirnov.net>
References: <1352629804-19880-1-git-send-email-anton@khirnov.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lain.khirnov.net (lain.khirnov.net [176.97.15.12])
 by alsa0.perex.cz (Postfix) with ESMTP id 2FA992615D2
 for <alsa-devel@alsa-project.org>; Sun, 11 Nov 2012 11:30:17 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by lain.khirnov.net (Postfix) with ESMTP id 09030C1587
 for <alsa-devel@alsa-project.org>; Sun, 11 Nov 2012 11:30:17 +0100 (CET)
Received: from lain.khirnov.net ([127.0.0.1])
 by localhost (mail.khirnov.net [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jB6eRy5HLhhx for <alsa-devel@alsa-project.org>;
 Sun, 11 Nov 2012 11:30:15 +0100 (CET)
Received: from daenerys.khirnov.net (daenerys.khirnov.net
 [IPv6:2002:b061:f0a:2:bc67:f85b:493c:acab])
 by lain.khirnov.net (Postfix) with ESMTP id D233EC16D1
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
 a52/pcm_a52.c |   34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/a52/pcm_a52.c b/a52/pcm_a52.c
index 9fd326c..b9ffddb 100644
--- a/a52/pcm_a52.c
+++ b/a52/pcm_a52.c
@@ -27,12 +27,14 @@
 #include <alsa/pcm_plugin.h>
 #include <libavcodec/avcodec.h>
 #include <libavutil/audioconvert.h>
+#include <libavutil/mem.h>
 
 struct a52_ctx {
 	snd_pcm_ioplug_t io;
 	snd_pcm_t *slave;
 	AVCodec *codec;
 	AVCodecContext *avctx;
+	AVFrame *frame;
 	snd_pcm_format_t format;
 	unsigned int channels;
 	unsigned int rate;
@@ -51,24 +53,24 @@ struct a52_ctx {
 /* convert the PCM data to A52 stream in IEC958 */
 static void convert_data(struct a52_ctx *rec)
 {
-	int out_bytes;
+	AVPacket pkt = { .data = rec->outbuf + 8, .size = rec->outbuf_size - 8 };
+	int got_frame;
+
+	avcodec_encode_audio2(rec->avctx, &pkt, rec->frame, &got_frame);
 
-	out_bytes = avcodec_encode_audio(rec->avctx, rec->outbuf + 8,
-					 rec->outbuf_size - 8,
-					 rec->inbuf);
 	rec->outbuf[0] = 0xf8; /* sync words */
 	rec->outbuf[1] = 0x72;
 	rec->outbuf[2] = 0x4e;
 	rec->outbuf[3] = 0x1f;
 	rec->outbuf[4] = rec->outbuf[13] & 7; /* bsmod */
 	rec->outbuf[5] = 0x01; /* data type */
-	rec->outbuf[6] = ((out_bytes * 8) >> 8) & 0xff;
-	rec->outbuf[7] = (out_bytes * 8) & 0xff;
+	rec->outbuf[6] = ((pkt.size * 8) >> 8) & 0xff;
+	rec->outbuf[7] = (pkt.size * 8) & 0xff;
 	/* swap bytes for little-endian 16bit */
 	if (rec->format == SND_PCM_FORMAT_S16_LE)
-		swab(rec->outbuf, rec->outbuf, out_bytes + 8);
-	memset(rec->outbuf +  8 + out_bytes, 0,
-	       rec->outbuf_size - 8 - out_bytes);
+		swab(rec->outbuf, rec->outbuf, pkt.size + 8);
+	memset(rec->outbuf +  8 + pkt.size, 0,
+	       rec->outbuf_size - 8 - pkt.size);
 	rec->remain = rec->outbuf_size / 4;
 	rec->filled = 0;
 }
@@ -408,6 +410,12 @@ static void a52_free(struct a52_ctx *rec)
 		av_free(rec->avctx);
 		rec->avctx = NULL;
 	}
+#if LIBAVCODEC_VERSION_INT >= AV_VERSION_INT(54, 28, 0)
+	avcodec_free_frame(&rec->frame);
+#else
+	av_freep(&rec->frame);
+#endif
+
 	free(rec->inbuf);
 	rec->inbuf = NULL;
 	free(rec->outbuf);
@@ -429,6 +437,10 @@ static int a52_prepare(snd_pcm_ioplug_t *io)
 	if (! rec->avctx)
 		return -ENOMEM;
 
+	rec->frame = avcodec_alloc_frame();
+	if (!rec->frame)
+		return -ENOMEM;
+
 	rec->avctx->bit_rate = rec->bitrate * 1000;
 	rec->avctx->sample_rate = io->rate;
 	rec->avctx->channels = io->channels;
@@ -458,6 +470,10 @@ static int a52_prepare(snd_pcm_ioplug_t *io)
 	if (! rec->outbuf)
 		return -ENOMEM;
 
+	rec->frame->data[0]     = (uint8_t*)rec->inbuf;
+	rec->frame->linesize[0] = rec->avctx->frame_size * 2 * io->channels;
+	rec->frame->nb_samples  = rec->avctx->frame_size;
+
 	rec->transfer = 0;
 	rec->remain = 0;
 	rec->filled = 0;
-- 
1.7.10.4
