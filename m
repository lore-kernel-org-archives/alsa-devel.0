From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 8/8] ALSA: pcm: add comment about application
	of rule to PCM parameters
Date: Thu,  8 Jun 2017 08:10:26 +0900
Message-ID: <20170607231026.23383-9-o-takashi@sakamocchi.jp>
References: <20170607231026.23383-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 51B1426722D
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

Drivers add rules of parameters to runtime of PCM substream, when
applications open ALSA PCM character device. When applications call
ioctl(2) with SNDRV_PCM_IOCTL_HW_REFINE or SNDRV_PCM_IOCTL_HW_PARAMS, the
rules are applied to the parameters and return the result to user space.

The rule can have dependency between parameters. Additionally, it can have
condition flags about application of rules. Userspace applications can
indicate the flags to suppress change of parameters.

This commit attempts to describe the mechanism in a shape of code
comments.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/pcm_native.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index a56319df89d9..8f0d9f237f20 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -269,6 +269,8 @@ static int constrain_mask_params(struct snd_pcm_substream *substream,
 		m = hw_param_mask(params, k);
 		if (snd_mask_empty(m))
 			return -EINVAL;
+
+		/* This parameter is not requested to change by a caller. */
 		if (!(params->rmask & (1 << k)))
 			continue;
 
@@ -279,6 +281,7 @@ static int constrain_mask_params(struct snd_pcm_substream *substream,
 
 		trace_hw_mask_param(substream, k, 0, &old_mask, m);
 
+		/* Set corresponding flag so that the caller gets it. */
 		if (changed)
 			params->cmask |= 1 << k;
 		if (changed < 0)
@@ -304,6 +307,8 @@ static int constrain_interval_params(struct snd_pcm_substream *substream,
 		i = hw_param_interval(params, k);
 		if (snd_interval_empty(i))
 			return -EINVAL;
+
+		/* This parameter is not requested to change by a caller. */
 		if (!(params->rmask & (1 << k)))
 			continue;
 
@@ -314,6 +319,7 @@ static int constrain_interval_params(struct snd_pcm_substream *substream,
 
 		trace_hw_interval_param(substream, k, 0, &old_interval, i);
 
+		/* Set corresponding flag so that the caller gets it. */
 		if (changed)
 			params->cmask |= 1 << k;
 		if (changed < 0)
@@ -340,18 +346,54 @@ static int constrain_params_by_rules(struct snd_pcm_substream *substream,
 	struct snd_mask __maybe_unused old_mask;
 	struct snd_interval __maybe_unused old_interval;
 
+	/*
+	 * Each application of rule has own sequence number.
+	 *
+	 * Each member of 'rstamps' array represents the sequence number of
+	 * recent application of corresponding rule.
+	 */
 	for (k = 0; k < constrs->rules_num; ++k)
 		rstamps[k] = 0;
+
+	/*
+	 * Each member of 'vstamps' array represents the sequence number of
+	 * recent application of rule in which corresponding parameters were
+	 * changed.
+	 *
+	 * In initial state, elements corresponding to parameters requested by
+	 * a caller is 1. For unrequested parameters, corresponding members
+	 * have 0 so that the parameters are never changed anymore.
+	 */
 	for (k = 0; k <= SNDRV_PCM_HW_PARAM_LAST_INTERVAL; ++k)
 		vstamps[k] = (params->rmask & (1 << k)) ? 1 : 0;
 
+	/* Due to the above design, actual sequence number starts at 2. */
 	stamp = 2;
 retry:
+	/* Apply all rules in order. */
 	again = false;
 	for (k = 0; k < constrs->rules_num; k++) {
 		r = &constrs->rules[k];
+
+		/*
+		 * Check condition bits of this rule. When the rule has
+		 * some condition bits, parameter without the bits is
+		 * never processed. SNDRV_PCM_HW_PARAMS_NO_PERIOD_WAKEUP
+		 * is an example of the condition bits.
+		 */
 		if (r->cond && !(r->cond & params->flags))
 			continue;
+
+		/*
+		 * The 'deps' array includes maximum three dependencies
+		 * to SNDRV_PCM_HW_PARAM_XXXs for this rule. The fourth
+		 * member of this array is a sentinel and should be
+		 * negative value.
+		 *
+		 * This rule should be processed in this time when dependent
+		 * parameters were changed at former applications of the other
+		 * rules.
+		 */
 		for (d = 0; r->deps[d] >= 0; d++) {
 			if (vstamps[r->deps[d]] > rstamps[k])
 				break;
@@ -380,6 +422,12 @@ static int constrain_params_by_rules(struct snd_pcm_substream *substream,
 		}
 
 		rstamps[k] = stamp;
+
+		/*
+		 * When the parameters is changed, notify it to the caller
+		 * by corresponding returned bit, then preparing for next
+		 * iteration.
+		 */
 		if (changed && r->var >= 0) {
 			params->cmask |= (1 << r->var);
 			vstamps[r->var] = stamp;
@@ -390,6 +438,7 @@ static int constrain_params_by_rules(struct snd_pcm_substream *substream,
 		stamp++;
 	}
 
+	/* Iterate to evaluate all rules till no parameters are changed. */
 	if (again)
 		goto retry;
 
-- 
2.11.0
