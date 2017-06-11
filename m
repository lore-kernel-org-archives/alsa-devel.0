From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/2] ALSA: pcm: probe events when parameters
	are changed actually
Date: Sun, 11 Jun 2017 23:56:13 +0900
Message-ID: <20170611145613.24929-3-o-takashi@sakamocchi.jp>
References: <20170611145613.24929-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id BD78B26696B
 for <alsa-devel@alsa-project.org>; Sun, 11 Jun 2017 16:56:18 +0200 (CEST)
In-Reply-To: <20170611145613.24929-1-o-takashi@sakamocchi.jp>
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

At present, trace events are probed even if corresponding parameter is
not actually changed. This is inconvenient.

This commit improves the behaviour.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/pcm_native.c | 56 +++++++++++++++++++++++++------------------------
 1 file changed, 29 insertions(+), 27 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 425f54827e78..5099078dde93 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -278,12 +278,12 @@ static int constrain_mask_params(struct snd_pcm_substream *substream,
 		changed = snd_mask_refine(m, constrs_mask(constrs, k));
 		if (changed < 0)
 			return changed;
-
-		trace_hw_mask_param(substream, k, 0, &old_mask, m);
+		if (changed == 0)
+			continue;
 
 		/* Set corresponding flag so that the caller gets it. */
-		if (changed)
-			params->cmask |= 1 << k;
+		trace_hw_mask_param(substream, k, 0, &old_mask, m);
+		params->cmask |= 1 << k;
 	}
 
 	return 0;
@@ -314,12 +314,12 @@ static int constrain_interval_params(struct snd_pcm_substream *substream,
 		changed = snd_interval_refine(i, constrs_interval(constrs, k));
 		if (changed < 0)
 			return changed;
-
-		trace_hw_interval_param(substream, k, 0, &old_interval, i);
+		if (changed == 0)
+			continue;
 
 		/* Set corresponding flag so that the caller gets it. */
-		if (changed)
-			params->cmask |= 1 << k;
+		trace_hw_interval_param(substream, k, 0, &old_interval, i);
+		params->cmask |= 1 << k;
 	}
 
 	return 0;
@@ -409,29 +409,29 @@ static int constrain_params_by_rules(struct snd_pcm_substream *substream,
 		if (changed < 0)
 			return changed;
 
-		if (hw_is_mask(r->var)) {
-			trace_hw_mask_param(substream, r->var, k + 1,
-				&old_mask, hw_param_mask(params, r->var));
-		}
-		if (hw_is_interval(r->var)) {
-			trace_hw_interval_param(substream, r->var, k + 1,
-				&old_interval, hw_param_interval(params, r->var));
-		}
-
-		rstamps[k] = stamp;
-
 		/*
-		 * When the parameters is changed, notify it to the caller
+		 * When the parameter is changed, notify it to the caller
 		 * by corresponding returned bit, then preparing for next
 		 * iteration.
 		 */
 		if (changed && r->var >= 0) {
+			if (hw_is_mask(r->var)) {
+				trace_hw_mask_param(substream, r->var,
+					k + 1, &old_mask,
+					hw_param_mask(params, r->var));
+			}
+			if (hw_is_interval(r->var)) {
+				trace_hw_interval_param(substream, r->var,
+					k + 1, &old_interval,
+					hw_param_interval(params, r->var));
+			}
+
 			params->cmask |= (1 << r->var);
 			vstamps[r->var] = stamp;
 			again = true;
 		}
 
-		stamp++;
+		rstamps[k] = stamp++;
 	}
 
 	/* Iterate to evaluate all rules till no parameters are changed. */
@@ -604,7 +604,7 @@ static int snd_pcm_hw_params_choose(struct snd_pcm_substream *pcm,
 	const int *v;
 	struct snd_mask old_mask;
 	struct snd_interval old_interval;
-	int err;
+	int changed;
 
 	for (v = vars; *v != -1; v++) {
 		/* Keep old parameter to trace. */
@@ -617,13 +617,15 @@ static int snd_pcm_hw_params_choose(struct snd_pcm_substream *pcm,
 				old_interval = *hw_param_interval(params, *v);
 		}
 		if (*v != SNDRV_PCM_HW_PARAM_BUFFER_SIZE)
-			err = snd_pcm_hw_param_first(pcm, params, *v, NULL);
+			changed = snd_pcm_hw_param_first(pcm, params, *v, NULL);
 		else
-			err = snd_pcm_hw_param_last(pcm, params, *v, NULL);
-		if (snd_BUG_ON(err < 0))
-			return err;
+			changed = snd_pcm_hw_param_last(pcm, params, *v, NULL);
+		if (snd_BUG_ON(changed < 0))
+			return changed;
+		if (changed == 0)
+			continue;
 
-		/* Trace the parameter. */
+		/* Trace the changed parameter. */
 		if (hw_is_mask(*v)) {
 			trace_hw_mask_param(pcm, *v, 0, &old_mask,
 					    hw_param_mask(params, *v));
-- 
2.11.0
