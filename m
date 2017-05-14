From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH RFC 08/21] ALSA: pcm: adaption of code
	formatting
Date: Sun, 14 May 2017 17:57:43 +0900
Message-ID: <20170514085756.22382-9-o-takashi@sakamocchi.jp>
References: <20170514085756.22382-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 8DC8F266AFC
 for <alsa-devel@alsa-project.org>; Sun, 14 May 2017 10:58:04 +0200 (CEST)
In-Reply-To: <20170514085756.22382-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de, lars@metafoo.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This commit modifies current code according to fashion in kernel land:
 - within 80 characters per line
 - indentation of function arguments with line break
 - removal of trailing linear white spaces
 - use int type variable for loop counter

For readability:
 - use bool type variable instead of int type variable assigned to 0/1
 - move variable definition from loop to top of the function definition

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/pcm_native.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 39ead67..f644fbe 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -265,12 +265,13 @@ static int constrain_mask_params(struct snd_pcm_substream *substream,
 				 struct snd_pcm_hw_params *params)
 {
 	struct snd_mask *m;
-	unsigned int k;
+	int k;
 	int changed;
 
 	struct snd_mask __maybe_unused old_mask;
 
-	for (k = SNDRV_PCM_HW_PARAM_FIRST_MASK; k <= SNDRV_PCM_HW_PARAM_LAST_MASK; k++) {
+	for (k = SNDRV_PCM_HW_PARAM_FIRST_MASK;
+	     k <= SNDRV_PCM_HW_PARAM_LAST_MASK; k++) {
 		m = hw_param_mask(params, k);
 		if (snd_mask_empty(m))
 			return -EINVAL;
@@ -299,12 +300,13 @@ static int constrain_interval_params(struct snd_pcm_substream *substream,
 				     struct snd_pcm_hw_params *params)
 {
 	struct snd_interval *i;
-	unsigned int k;
+	int k;
 	int changed;
 
 	struct snd_interval __maybe_unused old_interval;
 
-	for (k = SNDRV_PCM_HW_PARAM_FIRST_INTERVAL; k <= SNDRV_PCM_HW_PARAM_LAST_INTERVAL; k++) {
+	for (k = SNDRV_PCM_HW_PARAM_FIRST_INTERVAL;
+	     k <= SNDRV_PCM_HW_PARAM_LAST_INTERVAL; k++) {
 		i = hw_param_interval(params, k);
 		if (snd_interval_empty(i))
 			return -EINVAL;
@@ -332,25 +334,27 @@ static int constrain_params_by_rules(struct snd_pcm_substream *substream,
 				     struct snd_pcm_hw_constraints *constrs,
 				     struct snd_pcm_hw_params *params)
 {
-	unsigned int k;
+	int k;
 	unsigned int rstamps[constrs->rules_num];
 	unsigned int vstamps[SNDRV_PCM_HW_PARAM_LAST_INTERVAL + 1];
-	unsigned int stamp = 2;
-	int changed, again;
+	unsigned int stamp;
+	struct snd_pcm_hw_rule *r;
+	unsigned int d;
+	bool again;
+	int changed;
 
 	struct snd_interval __maybe_unused old_interval;
 	struct snd_mask __maybe_unused old_mask;
 
 	for (k = 0; k < constrs->rules_num; k++)
 		rstamps[k] = 0;
-	for (k = 0; k <= SNDRV_PCM_HW_PARAM_LAST_INTERVAL; k++) 
+	for (k = 0; k <= SNDRV_PCM_HW_PARAM_LAST_INTERVAL; k++)
 		vstamps[k] = (params->rmask & (1 << k)) ? 1 : 0;
-
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
@@ -388,7 +392,7 @@ static int constrain_params_by_rules(struct snd_pcm_substream *substream,
 		if (changed && r->var >= 0) {
 			params->cmask |= (1 << r->var);
 			vstamps[r->var] = stamp;
-			again = 1;
+			again = true;
 		}
 		if (changed < 0)
 			return changed;
@@ -407,7 +411,7 @@ int snd_pcm_hw_refine(struct snd_pcm_substream *substream,
 	struct snd_pcm_hardware *hw;
 	struct snd_mask *m = NULL;
 	struct snd_interval *i = NULL;
-	struct snd_pcm_hw_constraints *constrs = &substream->runtime->hw_constraints;
+	struct snd_pcm_hw_constraints *constrs;
 	int changed;
 
 	params->info = 0;
@@ -419,6 +423,7 @@ int snd_pcm_hw_refine(struct snd_pcm_substream *substream,
 		params->rate_den = 0;
 	}
 
+	constrs = &substream->runtime->hw_constraints;
 	changed = constrain_mask_params(substream, constrs, params);
 	if (changed < 0)
 		return changed;
-- 
2.9.3
