From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH v2 3/8] ALSA: pcm: add a helper function to
	apply parameter rules
Date: Fri,  9 Jun 2017 06:37:01 +0900
Message-ID: <20170608213706.5420-4-o-takashi@sakamocchi.jp>
References: <20170608213706.5420-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id C4C0B267339
 for <alsa-devel@alsa-project.org>; Thu,  8 Jun 2017 23:37:23 +0200 (CEST)
In-Reply-To: <20170608213706.5420-1-o-takashi@sakamocchi.jp>
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

Application of rules to parameters of PCM substream is done in a call of
snd_pcm_hw_refine(), while the function includes much codes and is not
enough friendly to readers.

This commit splits the codes to a separated function so that readers can
get it easily. I leave desicion into compilers to merge the function into
its callee.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/pcm_native.c | 77 +++++++++++++++++++++++++++++--------------------
 1 file changed, 45 insertions(+), 32 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 7e811ace6bf2..000e6e9a0c2b 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -319,43 +319,23 @@ static int constrain_interval_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-int snd_pcm_hw_refine(struct snd_pcm_substream *substream, 
-		      struct snd_pcm_hw_params *params)
+static int constrain_params_by_rules(struct snd_pcm_substream *substream,
+				     struct snd_pcm_hw_params *params)
 {
+	struct snd_pcm_hw_constraints *constrs =
+					&substream->runtime->hw_constraints;
 	unsigned int k;
-	struct snd_pcm_hardware *hw;
-	struct snd_interval *i = NULL;
-	struct snd_mask *m = NULL;
-	struct snd_pcm_hw_constraints *constrs = &substream->runtime->hw_constraints;
 	unsigned int rstamps[constrs->rules_num];
 	unsigned int vstamps[SNDRV_PCM_HW_PARAM_LAST_INTERVAL + 1];
 	unsigned int stamp = 2;
-	int changed, again;
-	int err;
-
-	struct snd_mask __maybe_unused old_mask;
-	struct snd_interval __maybe_unused old_interval;
-
-	params->info = 0;
-	params->fifo_size = 0;
-	if (params->rmask & (1 << SNDRV_PCM_HW_PARAM_SAMPLE_BITS))
-		params->msbits = 0;
-	if (params->rmask & (1 << SNDRV_PCM_HW_PARAM_RATE)) {
-		params->rate_num = 0;
-		params->rate_den = 0;
-	}
-
-	err = constrain_mask_params(substream, params);
-	if (err < 0)
-		return err;
-
-	err = constrain_interval_params(substream, params);
-	if (err < 0)
-		return err;
+	struct snd_mask old_mask;
+	struct snd_interval old_interval;
+	int again;
+	int changed;
 
 	for (k = 0; k < constrs->rules_num; k++)
 		rstamps[k] = 0;
-	for (k = 0; k <= SNDRV_PCM_HW_PARAM_LAST_INTERVAL; k++) 
+	for (k = 0; k <= SNDRV_PCM_HW_PARAM_LAST_INTERVAL; k++)
 		vstamps[k] = (params->rmask & (1 << k)) ? 1 : 0;
 	do {
 		again = 0;
@@ -405,6 +385,39 @@ int snd_pcm_hw_refine(struct snd_pcm_substream *substream,
 			stamp++;
 		}
 	} while (again);
+
+	return 0;
+}
+
+int snd_pcm_hw_refine(struct snd_pcm_substream *substream,
+		      struct snd_pcm_hw_params *params)
+{
+	struct snd_pcm_hardware *hw;
+	struct snd_interval *i = NULL;
+	struct snd_mask *m = NULL;
+	int err;
+
+	params->info = 0;
+	params->fifo_size = 0;
+	if (params->rmask & (1 << SNDRV_PCM_HW_PARAM_SAMPLE_BITS))
+		params->msbits = 0;
+	if (params->rmask & (1 << SNDRV_PCM_HW_PARAM_RATE)) {
+		params->rate_num = 0;
+		params->rate_den = 0;
+	}
+
+	err = constrain_mask_params(substream, params);
+	if (err < 0)
+		return err;
+
+	err = constrain_interval_params(substream, params);
+	if (err < 0)
+		return err;
+
+	err = constrain_params_by_rules(substream, params);
+	if (err < 0)
+		return err;
+
 	if (!params->msbits) {
 		i = hw_param_interval(params, SNDRV_PCM_HW_PARAM_SAMPLE_BITS);
 		if (snd_interval_single(i))
@@ -432,10 +445,10 @@ int snd_pcm_hw_refine(struct snd_pcm_substream *substream,
 		i = hw_param_interval(params, SNDRV_PCM_HW_PARAM_CHANNELS);
 		if (snd_mask_min(m) == snd_mask_max(m) &&
                     snd_interval_min(i) == snd_interval_max(i)) {
-			changed = substream->ops->ioctl(substream,
+			err = substream->ops->ioctl(substream,
 					SNDRV_PCM_IOCTL1_FIFO_SIZE, params);
-			if (changed < 0)
-				return changed;
+			if (err < 0)
+				return err;
 		}
 	}
 	params->rmask = 0;
-- 
2.11.0
