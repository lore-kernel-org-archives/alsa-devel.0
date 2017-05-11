From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH RFC 23/26] ASoC: blackfin: Convert to
	copy_silence ops
Date: Thu, 11 May 2017 23:09:22 +0200
Message-ID: <20170511210925.18208-24-tiwai@suse.de>
References: <20170511210925.18208-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 0D95C267014
 for <alsa-devel@alsa-project.org>; Thu, 11 May 2017 23:09:32 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id AF9C0AEE8
 for <alsa-devel@alsa-project.org>; Thu, 11 May 2017 21:09:30 +0000 (UTC)
In-Reply-To: <20170511210925.18208-1-tiwai@suse.de>
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

Replace the copy and the silence ops with the new merged ops.
The silence is performed only CONFIG_SND_BF5XX_MMAP_SUPPORT is set
(since copy_silence ops is set only with this config), so in
bf5xx-ac97.c we have a bit tricky macro for a slight optimization.

Note that we don't need to take in_kernel into account on this
architecture, so the conversion is easy otherwise.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/blackfin/bf5xx-ac97-pcm.c |  6 ++---
 sound/soc/blackfin/bf5xx-ac97.c     | 18 ++++++++++-----
 sound/soc/blackfin/bf5xx-i2s-pcm.c  | 46 ++++++++++++-------------------------
 3 files changed, 30 insertions(+), 40 deletions(-)

diff --git a/sound/soc/blackfin/bf5xx-ac97-pcm.c b/sound/soc/blackfin/bf5xx-ac97-pcm.c
index 02ad2606fa19..2fdffa7d376c 100644
--- a/sound/soc/blackfin/bf5xx-ac97-pcm.c
+++ b/sound/soc/blackfin/bf5xx-ac97-pcm.c
@@ -280,8 +280,8 @@ static int bf5xx_pcm_mmap(struct snd_pcm_substream *substream,
 }
 #else
 static	int bf5xx_pcm_copy(struct snd_pcm_substream *substream, int channel,
-		    snd_pcm_uframes_t pos,
-		    void __user *buf, snd_pcm_uframes_t count)
+			   snd_pcm_uframes_t pos, void __user *buf,
+			   snd_pcm_uframes_t count, bool in_kernel)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	unsigned int chan_mask = ac97_chan_mask[runtime->channels - 1];
@@ -309,7 +309,7 @@ static struct snd_pcm_ops bf5xx_pcm_ac97_ops = {
 #if defined(CONFIG_SND_BF5XX_MMAP_SUPPORT)
 	.mmap		= bf5xx_pcm_mmap,
 #else
-	.copy		= bf5xx_pcm_copy,
+	.copy_silence	= bf5xx_pcm_copy,
 #endif
 };
 
diff --git a/sound/soc/blackfin/bf5xx-ac97.c b/sound/soc/blackfin/bf5xx-ac97.c
index a040cfe29fc0..d1f11d9ecb07 100644
--- a/sound/soc/blackfin/bf5xx-ac97.c
+++ b/sound/soc/blackfin/bf5xx-ac97.c
@@ -43,35 +43,41 @@
 
 static struct sport_device *ac97_sport_handle;
 
+#ifdef CONFIG_SND_BF5XX_MMAP_SUPPORT
+#define GET_VAL(src)	(*src++)		/* copy only */
+#else
+#define GET_VAL(src)	(src ? *src++ : 0)	/* copy/silence */
+#endif
+
 void bf5xx_pcm_to_ac97(struct ac97_frame *dst, const __u16 *src,
 		size_t count, unsigned int chan_mask)
 {
 	while (count--) {
 		dst->ac97_tag = TAG_VALID;
 		if (chan_mask & SP_FL) {
-			dst->ac97_pcm_r = *src++;
+			dst->ac97_pcm_r = GET_VAL(src);
 			dst->ac97_tag |= TAG_PCM_RIGHT;
 		}
 		if (chan_mask & SP_FR) {
-			dst->ac97_pcm_l = *src++;
+			dst->ac97_pcm_l = GET_VAL(src);
 			dst->ac97_tag |= TAG_PCM_LEFT;
 
 		}
 #if defined(CONFIG_SND_BF5XX_MULTICHAN_SUPPORT)
 		if (chan_mask & SP_SR) {
-			dst->ac97_sl = *src++;
+			dst->ac97_sl = GET_VAL(src);
 			dst->ac97_tag |= TAG_PCM_SL;
 		}
 		if (chan_mask & SP_SL) {
-			dst->ac97_sr = *src++;
+			dst->ac97_sr = GET_VAL(src);
 			dst->ac97_tag |= TAG_PCM_SR;
 		}
 		if (chan_mask & SP_LFE) {
-			dst->ac97_lfe = *src++;
+			dst->ac97_lfe = GET_VAL(src);
 			dst->ac97_tag |= TAG_PCM_LFE;
 		}
 		if (chan_mask & SP_FC) {
-			dst->ac97_center = *src++;
+			dst->ac97_center = GET_VAL(src);
 			dst->ac97_tag |= TAG_PCM_CENTER;
 		}
 #endif
diff --git a/sound/soc/blackfin/bf5xx-i2s-pcm.c b/sound/soc/blackfin/bf5xx-i2s-pcm.c
index 6cba211da32e..5686c29fb058 100644
--- a/sound/soc/blackfin/bf5xx-i2s-pcm.c
+++ b/sound/soc/blackfin/bf5xx-i2s-pcm.c
@@ -226,7 +226,8 @@ static int bf5xx_pcm_mmap(struct snd_pcm_substream *substream,
 }
 
 static int bf5xx_pcm_copy(struct snd_pcm_substream *substream, int channel,
-	snd_pcm_uframes_t pos, void *buf, snd_pcm_uframes_t count)
+			  snd_pcm_uframes_t pos, void *buf,
+			  snd_pcm_uframes_t count, bool in_kernel)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_pcm_runtime *runtime = substream->runtime;
@@ -245,8 +246,14 @@ static int bf5xx_pcm_copy(struct snd_pcm_substream *substream, int channel,
 
 			while (count--) {
 				for (i = 0; i < runtime->channels; i++) {
-					memcpy(dst + dma_data->map[i] *
-						sample_size, src, sample_size);
+					if (!buf)
+						memset(dst + dma_data->map[i] *
+						       sample_size, 0,
+						       sample_size);
+					else
+						memcpy(dst + dma_data->map[i] *
+						       sample_size, src,
+						       sample_size);
 					src += sample_size;
 				}
 				dst += 8 * sample_size;
@@ -276,34 +283,12 @@ static int bf5xx_pcm_copy(struct snd_pcm_substream *substream, int channel,
 			dst = buf;
 		}
 
-		memcpy(dst, src, frames_to_bytes(runtime, count));
-	}
-
-	return 0;
-}
-
-static int bf5xx_pcm_silence(struct snd_pcm_substream *substream,
-	int channel, snd_pcm_uframes_t pos, snd_pcm_uframes_t count)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	unsigned int sample_size = runtime->sample_bits / 8;
-	void *buf = runtime->dma_area;
-	struct bf5xx_i2s_pcm_data *dma_data;
-	unsigned int offset, samples;
-
-	dma_data = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
-
-	if (dma_data->tdm_mode) {
-		offset = pos * 8 * sample_size;
-		samples = count * 8;
-	} else {
-		offset = frames_to_bytes(runtime, pos);
-		samples = count * runtime->channels;
+		if (!buf)
+			memset(dst, 0, frames_to_bytes(runtime, count));
+		else
+			memcpy(dst, src, frames_to_bytes(runtime, count));
 	}
 
-	snd_pcm_format_set_silence(runtime->format, buf + offset, samples);
-
 	return 0;
 }
 
@@ -316,8 +301,7 @@ static struct snd_pcm_ops bf5xx_pcm_i2s_ops = {
 	.trigger	= bf5xx_pcm_trigger,
 	.pointer	= bf5xx_pcm_pointer,
 	.mmap		= bf5xx_pcm_mmap,
-	.copy		= bf5xx_pcm_copy,
-	.silence	= bf5xx_pcm_silence,
+	.copy_silence	= bf5xx_pcm_copy,
 };
 
 static int bf5xx_pcm_i2s_new(struct snd_soc_pcm_runtime *rtd)
-- 
2.12.2
