From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/3] ALSA: pcm: calculate non-mask/non-interval
	parameters always when possible
Date: Fri,  9 Jun 2017 09:34:39 +0900
Message-ID: <20170609003440.4178-3-o-takashi@sakamocchi.jp>
References: <20170609003440.4178-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id E72132674B7
 for <alsa-devel@alsa-project.org>; Fri,  9 Jun 2017 02:34:48 +0200 (CEST)
In-Reply-To: <20170609003440.4178-1-o-takashi@sakamocchi.jp>
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

A structure for parameters of PCM runtime has parameters which are
not classified as mask/interval type. They are decided only when
corresponding normal parameters have unique values.
 * struct snd_pcm_hw_params.msbits
 * struct snd_pcm_hw_params.rate_num
 * struct snd_pcm_hw_params.rate_den
 * struct snd_pcm_hw_params.fifo_size

Current implementation of hw_params ioctl sometimes doesn't decide these
parameters even if corresponding parameters are fixed, because these
parameters are evaluated before a call of snd_pcm_hw_params_choose().

This commit adds a helper function to process the parameters and call it
in proper positions.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/pcm_native.c | 70 +++++++++++++++++++++++++++++++------------------
 1 file changed, 44 insertions(+), 26 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 87a507f12f2f..dfe6113a6a60 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -440,12 +440,45 @@ static int constrain_params_by_rules(struct snd_pcm_substream *substream,
 	return 0;
 }
 
+static int fixup_unreferenced_params(struct snd_pcm_substream *substream,
+				     struct snd_pcm_hw_params *params)
+{
+	const struct snd_interval *i;
+	const struct snd_mask *m;
+	int err;
+
+	if (!params->msbits) {
+		i = hw_param_interval_c(params, SNDRV_PCM_HW_PARAM_SAMPLE_BITS);
+		if (snd_interval_single(i))
+			params->msbits = snd_interval_value(i);
+	}
+
+	if (!params->rate_den) {
+		i = hw_param_interval_c(params, SNDRV_PCM_HW_PARAM_RATE);
+		if (snd_interval_single(i)) {
+			params->rate_num = snd_interval_value(i);
+			params->rate_den = 1;
+		}
+	}
+
+	if (!params->fifo_size) {
+		m = hw_param_mask_c(params, SNDRV_PCM_HW_PARAM_FORMAT);
+		i = hw_param_interval_c(params, SNDRV_PCM_HW_PARAM_CHANNELS);
+		if (snd_mask_single(m) && snd_interval_single(i)) {
+			err = substream->ops->ioctl(substream,
+					SNDRV_PCM_IOCTL1_FIFO_SIZE, params);
+			if (err < 0)
+				return err;
+		}
+	}
+
+	return 0;
+}
+
 int snd_pcm_hw_refine(struct snd_pcm_substream *substream,
 		      struct snd_pcm_hw_params *params)
 {
 	struct snd_pcm_hardware *hw;
-	const struct snd_interval *i;
-	const struct snd_mask *m;
 	int err;
 
 	params->info = 0;
@@ -469,20 +502,6 @@ int snd_pcm_hw_refine(struct snd_pcm_substream *substream,
 	if (err < 0)
 		return err;
 
-	if (!params->msbits) {
-		i = hw_param_interval_c(params, SNDRV_PCM_HW_PARAM_SAMPLE_BITS);
-		if (snd_interval_single(i))
-			params->msbits = snd_interval_value(i);
-	}
-
-	if (!params->rate_den) {
-		i = hw_param_interval_c(params, SNDRV_PCM_HW_PARAM_RATE);
-		if (snd_interval_single(i)) {
-			params->rate_num = snd_interval_value(i);
-			params->rate_den = 1;
-		}
-	}
-
 	hw = &substream->runtime->hw;
 	if (!params->info) {
 		params->info = hw->info & ~(SNDRV_PCM_INFO_FIFO_IN_FRAMES |
@@ -491,16 +510,7 @@ int snd_pcm_hw_refine(struct snd_pcm_substream *substream,
 			params->info &= ~(SNDRV_PCM_INFO_MMAP |
 					  SNDRV_PCM_INFO_MMAP_VALID);
 	}
-	if (!params->fifo_size) {
-		m = hw_param_mask_c(params, SNDRV_PCM_HW_PARAM_FORMAT);
-		i = hw_param_interval_c(params, SNDRV_PCM_HW_PARAM_CHANNELS);
-		if (snd_mask_single(m) && snd_interval_single(i)) {
-			err = substream->ops->ioctl(substream,
-					SNDRV_PCM_IOCTL1_FIFO_SIZE, params);
-			if (err < 0)
-				return err;
-		}
-	}
+
 	params->rmask = 0;
 	return 0;
 }
@@ -517,6 +527,8 @@ static int snd_pcm_hw_refine_user(struct snd_pcm_substream *substream,
 		return PTR_ERR(params);
 
 	err = snd_pcm_hw_refine(substream, params);
+	if (err >= 0)
+		err = fixup_unreferenced_params(substream, params);
 	if (copy_to_user(_params, params, sizeof(*params))) {
 		if (!err)
 			err = -EFAULT;
@@ -596,6 +608,10 @@ static int snd_pcm_hw_params(struct snd_pcm_substream *substream,
 	if (err < 0)
 		goto _error;
 
+	err = fixup_unreferenced_params(substream, params);
+	if (err < 0)
+		goto _error;
+
 	if (substream->ops->hw_params != NULL) {
 		err = substream->ops->hw_params(substream, params);
 		if (err < 0)
@@ -3621,6 +3637,8 @@ static int snd_pcm_hw_refine_old_user(struct snd_pcm_substream *substream,
 	}
 	snd_pcm_hw_convert_from_old_params(params, oparams);
 	err = snd_pcm_hw_refine(substream, params);
+	if (err >= 0)
+		err = fixup_unreferenced_params(substream, params);
 	snd_pcm_hw_convert_to_old_params(oparams, params);
 	if (copy_to_user(_oparams, oparams, sizeof(*oparams))) {
 		if (!err)
-- 
2.11.0
