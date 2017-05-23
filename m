From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ALSA: gus: remove unused local flag
Date: Tue, 23 May 2017 22:40:20 +0900
Message-ID: <20170523134020.941-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id B5AB92670DB
 for <alsa-devel@alsa-project.org>; Tue, 23 May 2017 15:40:25 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

ALSA driver series for devices of Gravis Ultra Sound includes local
variable 'snd_gf1_pcm_use_dma'. Although this is a flag to change
behaviours of local implementations for 'struct snd_pcm_ops.copy' and
'struct snd_pcm_ops.silence', it's invariable during module lifetime.

This commit removes this local variable and the relevant operations.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/isa/gus/gus_pcm.c | 49 ++++++++++++++++++++++---------------------------
 1 file changed, 22 insertions(+), 27 deletions(-)

diff --git a/sound/isa/gus/gus_pcm.c b/sound/isa/gus/gus_pcm.c
index 33c1891f469a..0cc3f272edf1 100644
--- a/sound/isa/gus/gus_pcm.c
+++ b/sound/isa/gus/gus_pcm.c
@@ -61,8 +61,6 @@ struct gus_pcm_private {
 	int final_volume;
 };
 
-static int snd_gf1_pcm_use_dma = 1;
-
 static void snd_gf1_pcm_block_change_ack(struct snd_gus_card * gus, void *private_data)
 {
 	struct gus_pcm_private *pcmp = private_data;
@@ -363,7 +361,9 @@ static int snd_gf1_pcm_playback_copy(struct snd_pcm_substream *substream,
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct gus_pcm_private *pcmp = runtime->private_data;
+	struct snd_gus_card *gus = pcmp->gus;
 	unsigned int bpos, len;
+	int w16, invert;
 	
 	bpos = samples_to_bytes(runtime, pos) + (voice * (pcmp->dma_size / 2));
 	len = samples_to_bytes(runtime, count);
@@ -373,18 +373,14 @@ static int snd_gf1_pcm_playback_copy(struct snd_pcm_substream *substream,
 		return -EIO;
 	if (copy_from_user(runtime->dma_area + bpos, src, len))
 		return -EFAULT;
-	if (snd_gf1_pcm_use_dma && len > 32) {
-		return snd_gf1_pcm_block_change(substream, bpos, pcmp->memory + bpos, len);
-	} else {
-		struct snd_gus_card *gus = pcmp->gus;
-		int err, w16, invert;
-
-		w16 = (snd_pcm_format_width(runtime->format) == 16);
-		invert = snd_pcm_format_unsigned(runtime->format);
-		if ((err = snd_gf1_pcm_poke_block(gus, runtime->dma_area + bpos, pcmp->memory + bpos, len, w16, invert)) < 0)
-			return err;
-	}
-	return 0;
+	if (len > 32)
+		return snd_gf1_pcm_block_change(substream, bpos,
+						pcmp->memory + bpos, len);
+
+	w16 = (snd_pcm_format_width(runtime->format) == 16);
+	invert = snd_pcm_format_unsigned(runtime->format);
+	return snd_gf1_pcm_poke_block(gus, runtime->dma_area + bpos,
+				      pcmp->memory + bpos, len, w16, invert);
 }
 
 static int snd_gf1_pcm_playback_silence(struct snd_pcm_substream *substream,
@@ -394,7 +390,9 @@ static int snd_gf1_pcm_playback_silence(struct snd_pcm_substream *substream,
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct gus_pcm_private *pcmp = runtime->private_data;
+	struct snd_gus_card *gus = pcmp->gus;
 	unsigned int bpos, len;
+	int w16, invert;
 	
 	bpos = samples_to_bytes(runtime, pos) + (voice * (pcmp->dma_size / 2));
 	len = samples_to_bytes(runtime, count);
@@ -402,19 +400,16 @@ static int snd_gf1_pcm_playback_silence(struct snd_pcm_substream *substream,
 		return -EIO;
 	if (snd_BUG_ON(bpos + len > pcmp->dma_size))
 		return -EIO;
-	snd_pcm_format_set_silence(runtime->format, runtime->dma_area + bpos, count);
-	if (snd_gf1_pcm_use_dma && len > 32) {
-		return snd_gf1_pcm_block_change(substream, bpos, pcmp->memory + bpos, len);
-	} else {
-		struct snd_gus_card *gus = pcmp->gus;
-		int err, w16, invert;
-
-		w16 = (snd_pcm_format_width(runtime->format) == 16);
-		invert = snd_pcm_format_unsigned(runtime->format);
-		if ((err = snd_gf1_pcm_poke_block(gus, runtime->dma_area + bpos, pcmp->memory + bpos, len, w16, invert)) < 0)
-			return err;
-	}
-	return 0;
+	snd_pcm_format_set_silence(runtime->format, runtime->dma_area + bpos,
+				   count);
+	if (len > 32)
+		return snd_gf1_pcm_block_change(substream, bpos,
+						pcmp->memory + bpos, len);
+
+	w16 = (snd_pcm_format_width(runtime->format) == 16);
+	invert = snd_pcm_format_unsigned(runtime->format);
+	return snd_gf1_pcm_poke_block(gus, runtime->dma_area + bpos,
+				      pcmp->memory + bpos, len, w16, invert);
 }
 
 static int snd_gf1_pcm_playback_hw_params(struct snd_pcm_substream *substream,
-- 
2.11.0
