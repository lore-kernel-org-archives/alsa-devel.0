From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH RFC 09/21] ALSA: pcm: add comment about
	application of rule to PCM parameters
Date: Sun, 14 May 2017 17:57:44 +0900
Message-ID: <20170514085756.22382-10-o-takashi@sakamocchi.jp>
References: <20170514085756.22382-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 9D174266AFE
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

Drivers add rules of parameters to runtime of PCM substream, when
applications open ALSA PCM character device. When applications call
ioctl(2) with SNDRV_PCM_IOCTL_HW_REFINE or SNDRV_PCM_IOCTL_HW_PARAMS, the
rules are applied to the parameters and return the result to user space.

The rule can have dependency between parameters. Additionally, it can have
condition flags about application of rules. Userspace applications can
indicate the flags to suppress change of parameters.

This commit attempts to describe the mechanism.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/pcm_native.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index f644fbe..7044ae5 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -275,6 +275,8 @@ static int constrain_mask_params(struct snd_pcm_substream *substream,
 		m = hw_param_mask(params, k);
 		if (snd_mask_empty(m))
 			return -EINVAL;
+
+		/* This parameter is not requested to change by application. */
 		if (!(params->rmask & (1 << k)))
 			continue;
 
@@ -286,6 +288,7 @@ static int constrain_mask_params(struct snd_pcm_substream *substream,
 
 		trace_hw_params_mask(substream, k, -1, &old_mask, m);
 
+		/* Set corresponding flag so that applications get it. */
 		if (changed)
 			params->cmask |= 1 << k;
 		if (changed < 0)
@@ -310,6 +313,8 @@ static int constrain_interval_params(struct snd_pcm_substream *substream,
 		i = hw_param_interval(params, k);
 		if (snd_interval_empty(i))
 			return -EINVAL;
+
+		/* This parameter is not requested to change by application. */
 		if (!(params->rmask & (1 << k)))
 			continue;
 
@@ -321,6 +326,7 @@ static int constrain_interval_params(struct snd_pcm_substream *substream,
 
 		trace_hw_params_interval(substream, k, -1, &old_interval, i);
 
+		/* Set corresponding flag so that applications get it. */
 		if (changed)
 			params->cmask |= 1 << k;
 		if (changed < 0)
@@ -346,17 +352,54 @@ static int constrain_params_by_rules(struct snd_pcm_substream *substream,
 	struct snd_interval __maybe_unused old_interval;
 	struct snd_mask __maybe_unused old_mask;
 
+	/*
+	 * Each application of rule has own sequence number.
+	 *
+	 * Each member of 'rstamps' array represents the sequence number of
+	 * recent application of corresponding rule.
+	 */
 	for (k = 0; k < constrs->rules_num; k++)
 		rstamps[k] = 0;
+
+	/*
+	 * Each member of 'vstamps' array represents the sequence number of
+	 * recent application of rule in which corresponding parameters were
+	 * changed.
+	 *
+	 * In initial state, elements corresponding to parameters requested by
+	 * application is 1. For unrequested parameters, corresponding members
+	 * have 0 so that the parameters are never changed anymore.
+	 */
 	for (k = 0; k <= SNDRV_PCM_HW_PARAM_LAST_INTERVAL; k++)
 		vstamps[k] = (params->rmask & (1 << k)) ? 1 : 0;
+
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
@@ -389,6 +432,12 @@ static int constrain_params_by_rules(struct snd_pcm_substream *substream,
 		}
 
 		rstamps[k] = stamp;
+
+		/*
+		 * When some parameters are changed, notify it to applications
+		 * in user space by returned bits, then preparing for next
+		 * iteration.
+		 */
 		if (changed && r->var >= 0) {
 			params->cmask |= (1 << r->var);
 			vstamps[r->var] = stamp;
@@ -396,9 +445,11 @@ static int constrain_params_by_rules(struct snd_pcm_substream *substream,
 		}
 		if (changed < 0)
 			return changed;
+
 		stamp++;
 	}
 
+	/* Iterate to evaluate all rules till no parameters are changed. */
 	if (again)
 		goto retry;
 
-- 
2.9.3
