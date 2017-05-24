From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH RFC 08/11] ALSA: gus: an examples change for
	drivers which support non-interleaved buffer
Date: Wed, 24 May 2017 09:52:52 +0900
Message-ID: <20170524005255.31223-9-o-takashi@sakamocchi.jp>
References: <20170524005255.31223-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id DBEC92671B1
 for <alsa-devel@alsa-project.org>; Wed, 24 May 2017 02:53:04 +0200 (CEST)
In-Reply-To: <20170524005255.31223-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is an example of new operation for copy_frames callback, in a case
of drivers for non-interleaved frame alignment.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/isa/gus/gus_pcm.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/sound/isa/gus/gus_pcm.c b/sound/isa/gus/gus_pcm.c
index 33c1891f469a..08bc1f9931a2 100644
--- a/sound/isa/gus/gus_pcm.c
+++ b/sound/isa/gus/gus_pcm.c
@@ -417,6 +417,63 @@ static int snd_gf1_pcm_playback_silence(struct snd_pcm_substream *substream,
 	return 0;
 }
 
+static int playback_copy_frames(struct snd_pcm_substream *substream,
+				unsigned int hwoff, unsigned long data,
+				unsigned int off, snd_pcm_uframes_t count)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct gus_pcm_private *pcmp = runtime->private_data;
+	struct snd_gus_card *gus = pcmp->gus;
+	char __user **bufs = (char __user **)data;
+	char __user *buf;
+	unsigned int channels = runtime->channels;
+	unsigned int len = samples_to_bytes(runtime, count);
+	unsigned int bpos;
+	char *dst;
+	int w16;
+	int invert;
+	int c;
+	int err;
+
+	w16 = !!(snd_pcm_format_width(runtime->format) == 16);
+	invert = snd_pcm_format_unsigned(runtime->format);
+
+	for (c = 0; c < channels; ++c) {
+		bpos = samples_to_bytes(runtime, hwoff) +
+						c * (pcmp->dma_size / 2);
+		if (snd_BUG_ON(bpos > pcmp->dma_size))
+			return -EIO;
+		if (snd_BUG_ON(bpos + len > pcmp->dma_size))
+			return -EIO;
+		dst = runtime->dma_area + bpos;
+
+		if (bufs == NULL || bufs[c] == NULL) {
+			snd_pcm_format_set_silence(runtime->format,
+						   runtime->dma_area + bpos,
+						   count);
+		} else {
+			buf = bufs[c] + samples_to_bytes(runtime, off);
+
+			if (copy_from_user(runtime->dma_area + bpos, buf, len))
+				return -EFAULT;
+		}
+
+		if (len > 32) {
+			err = snd_gf1_pcm_block_change(substream, bpos,
+						pcmp->memory + bpos, len);
+		} else {
+			err = snd_gf1_pcm_poke_block(gus,
+						runtime->dma_area + bpos,
+						pcmp->memory + bpos, len, w16,
+						invert);
+		}
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+}
+
 static int snd_gf1_pcm_playback_hw_params(struct snd_pcm_substream *substream,
 					  struct snd_pcm_hw_params *hw_params)
 {
@@ -838,6 +895,7 @@ static struct snd_pcm_ops snd_gf1_pcm_playback_ops = {
 	.pointer =	snd_gf1_pcm_playback_pointer,
 	.copy =		snd_gf1_pcm_playback_copy,
 	.silence =	snd_gf1_pcm_playback_silence,
+	.copy_frames =	playback_copy_frames,
 };
 
 static struct snd_pcm_ops snd_gf1_pcm_capture_ops = {
-- 
2.11.0
