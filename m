From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH RFC 06/21] ALSA: pcm: use goto statement
	instead of while statement to reduce indentation
Date: Sun, 14 May 2017 17:57:41 +0900
Message-ID: <20170514085756.22382-7-o-takashi@sakamocchi.jp>
References: <20170514085756.22382-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 85D6B266AF9
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

In a process to calculate parameters of PCM substream, application of all
rules is iterated several times till parameter dependencies are satisfied.
In current implementation, two loops are used for the design, however this
brings two-level indentation and decline readability.

This commit attempts to reduce the indentation by using goto statement,
instead of outer while loop.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/pcm_native.c | 95 +++++++++++++++++++++++++------------------------
 1 file changed, 49 insertions(+), 46 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 3fd2a63..4de9498 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -345,58 +345,61 @@ static int constrain_params_by_rules(struct snd_pcm_substream *substream,
 		rstamps[k] = 0;
 	for (k = 0; k <= SNDRV_PCM_HW_PARAM_LAST_INTERVAL; k++) 
 		vstamps[k] = (params->rmask & (1 << k)) ? 1 : 0;
-	do {
-		again = 0;
-		for (k = 0; k < constrs->rules_num; k++) {
-			struct snd_pcm_hw_rule *r = &constrs->rules[k];
-			unsigned int d;
-			int doit = 0;
-			if (r->cond && !(r->cond & params->flags))
-				continue;
-			for (d = 0; r->deps[d] >= 0; d++) {
-				if (vstamps[r->deps[d]] > rstamps[k]) {
-					doit = 1;
-					break;
-				}
-			}
-			if (!doit)
-				continue;
 
-			/* Keep old parameter to trace. */
-			if (trace_hw_params_mask_enabled()) {
-				if (hw_is_mask(r->var))
-					old_mask = *hw_param_mask(params, r->var);
-			}
-			if (trace_hw_params_interval_enabled()) {
-				if (hw_is_interval(r->var))
-					old_interval = *hw_param_interval(params, r->var);
+retry:
+	again = 0;
+	for (k = 0; k < constrs->rules_num; k++) {
+		struct snd_pcm_hw_rule *r = &constrs->rules[k];
+		unsigned int d;
+		int doit = 0;
+		if (r->cond && !(r->cond & params->flags))
+			continue;
+		for (d = 0; r->deps[d] >= 0; d++) {
+			if (vstamps[r->deps[d]] > rstamps[k]) {
+				doit = 1;
+				break;
 			}
+		}
+		if (!doit)
+			continue;
 
-			changed = r->func(params, r);
+		/* Keep old parameter to trace. */
+		if (trace_hw_params_mask_enabled()) {
+			if (hw_is_mask(r->var))
+				old_mask = *hw_param_mask(params, r->var);
+		}
+		if (trace_hw_params_interval_enabled()) {
+			if (hw_is_interval(r->var))
+				old_interval = *hw_param_interval(params, r->var);
+		}
 
-			/* Trace the parameter. */
-			if (hw_is_mask(r->var)) {
-				trace_hw_params_mask(substream, r->var, k,
-						&old_mask,
-						hw_param_mask(params, r->var));
-			}
-			if (hw_is_interval(r->var)) {
-				trace_hw_params_interval(substream, r->var, k,
-						&old_interval,
-						hw_param_interval(params, r->var));
-			}
+		changed = r->func(params, r);
 
-			rstamps[k] = stamp;
-			if (changed && r->var >= 0) {
-				params->cmask |= (1 << r->var);
-				vstamps[r->var] = stamp;
-				again = 1;
-			}
-			if (changed < 0)
-				return changed;
-			stamp++;
+		/* Trace the parameter. */
+		if (hw_is_mask(r->var)) {
+			trace_hw_params_mask(substream, r->var, k,
+					     &old_mask,
+					     hw_param_mask(params, r->var));
+		}
+		if (hw_is_interval(r->var)) {
+			trace_hw_params_interval(substream, r->var, k,
+						 &old_interval,
+						 hw_param_interval(params, r->var));
 		}
-	} while (again);
+
+		rstamps[k] = stamp;
+		if (changed && r->var >= 0) {
+			params->cmask |= (1 << r->var);
+			vstamps[r->var] = stamp;
+			again = 1;
+		}
+		if (changed < 0)
+			return changed;
+		stamp++;
+	}
+
+	if (again)
+		goto retry;
 
 	return 0;
 }
-- 
2.9.3
