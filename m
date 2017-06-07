From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 6/8] ALSA: pcm: adaption of code formatting
Date: Thu,  8 Jun 2017 08:10:24 +0900
Message-ID: <20170607231026.23383-7-o-takashi@sakamocchi.jp>
References: <20170607231026.23383-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 5C2CD267230
 for <alsa-devel@alsa-project.org>; Thu,  8 Jun 2017 01:10:42 +0200 (CEST)
In-Reply-To: <20170607231026.23383-1-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com
List-Id: alsa-devel@alsa-project.org

This commit modifies current code according to fashion in kernel land:
 - within 80 characters per line as possible
 - removal of trailing linear white spaces
 - use int type variable for loop counter
 - use prefix operator for numerical increment

For readability:
 - use bool type variable instead of int type variable assigned to 0/1
 - move variable definition from loop to top of the function definition

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/pcm_native.c | 39 +++++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 6fa5947d7db8..7c74c293cab7 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -259,12 +259,13 @@ static int constrain_mask_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_constraints *constrs =
 					&substream->runtime->hw_constraints;
 	struct snd_mask *m;
-	unsigned int k;
+	int k;
 	int changed;
 
 	struct snd_mask __maybe_unused old_mask;
 
-	for (k = SNDRV_PCM_HW_PARAM_FIRST_MASK; k <= SNDRV_PCM_HW_PARAM_LAST_MASK; k++) {
+	for (k = SNDRV_PCM_HW_PARAM_FIRST_MASK;
+	     k <= SNDRV_PCM_HW_PARAM_LAST_MASK; ++k) {
 		m = hw_param_mask(params, k);
 		if (snd_mask_empty(m))
 			return -EINVAL;
@@ -293,12 +294,13 @@ static int constrain_interval_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_constraints *constrs =
 					&substream->runtime->hw_constraints;
 	struct snd_interval *i;
-	unsigned int k;
+	int k;
 	int changed;
 
 	struct snd_interval __maybe_unused old_interval;
 
-	for (k = SNDRV_PCM_HW_PARAM_FIRST_INTERVAL; k <= SNDRV_PCM_HW_PARAM_LAST_INTERVAL; k++) {
+	for (k = SNDRV_PCM_HW_PARAM_FIRST_INTERVAL;
+	     k <= SNDRV_PCM_HW_PARAM_LAST_INTERVAL; ++k) {
 		i = hw_param_interval(params, k);
 		if (snd_interval_empty(i))
 			return -EINVAL;
@@ -326,25 +328,28 @@ static int constrain_params_by_rules(struct snd_pcm_substream *substream,
 {
 	struct snd_pcm_hw_constraints *constrs =
 					&substream->runtime->hw_constraints;
-	unsigned int k;
+	int k;
 	unsigned int rstamps[constrs->rules_num];
 	unsigned int vstamps[SNDRV_PCM_HW_PARAM_LAST_INTERVAL + 1];
-	unsigned int stamp = 2;
-	int again;
+	unsigned int stamp;
+	struct snd_pcm_hw_rule *r;
+	int d;
+	bool again;
 	int changed;
 
 	struct snd_mask __maybe_unused old_mask;
 	struct snd_interval __maybe_unused old_interval;
 
-	for (k = 0; k < constrs->rules_num; k++)
+	for (k = 0; k < constrs->rules_num; ++k)
 		rstamps[k] = 0;
-	for (k = 0; k <= SNDRV_PCM_HW_PARAM_LAST_INTERVAL; k++) 
+	for (k = 0; k <= SNDRV_PCM_HW_PARAM_LAST_INTERVAL; ++k)
 		vstamps[k] = (params->rmask & (1 << k)) ? 1 : 0;
+
+	stamp = 2;
 retry:
-	again = 0;
+	again = false;
 	for (k = 0; k < constrs->rules_num; k++) {
-		struct snd_pcm_hw_rule *r = &constrs->rules[k];
-		unsigned int d;
+		r = &constrs->rules[k];
 		if (r->cond && !(r->cond & params->flags))
 			continue;
 		for (d = 0; r->deps[d] >= 0; d++) {
@@ -378,7 +383,7 @@ static int constrain_params_by_rules(struct snd_pcm_substream *substream,
 		if (changed && r->var >= 0) {
 			params->cmask |= (1 << r->var);
 			vstamps[r->var] = stamp;
-			again = 1;
+			again = true;
 		}
 		if (changed < 0)
 			return changed;
@@ -397,7 +402,6 @@ int snd_pcm_hw_refine(struct snd_pcm_substream *substream,
 	struct snd_pcm_hardware *hw;
 	struct snd_interval *i = NULL;
 	struct snd_mask *m = NULL;
-	int changed;
 	int err;
 
 	struct snd_mask __maybe_unused old_mask;
@@ -451,16 +455,15 @@ int snd_pcm_hw_refine(struct snd_pcm_substream *substream,
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
 	return 0;
 }
-
 EXPORT_SYMBOL(snd_pcm_hw_refine);
 
 static int snd_pcm_hw_refine_user(struct snd_pcm_substream *substream,
-- 
2.11.0
