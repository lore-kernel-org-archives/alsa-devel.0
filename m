From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 4/8] ALSA: pcm: use goto statement instead of
	while statement to reduce indentation
Date: Thu,  8 Jun 2017 08:10:22 +0900
Message-ID: <20170607231026.23383-5-o-takashi@sakamocchi.jp>
References: <20170607231026.23383-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id F23E926721E
 for <alsa-devel@alsa-project.org>; Thu,  8 Jun 2017 01:10:38 +0200 (CEST)
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

In a process to calculate parameters of PCM substream, application of all
rules is iterated several times till parameter dependencies are satisfied.
In current implementation, two loops are used for the design, however this
brings two-level indentation and decline readability.

This commit attempts to reduce the indentation by using goto statement,
instead of outer while loop.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/pcm_native.c | 86 +++++++++++++++++++++++++------------------------
 1 file changed, 44 insertions(+), 42 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 76041faf95df..ae6499f1a049 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -340,54 +340,56 @@ static int constrain_params_by_rules(struct snd_pcm_substream *substream,
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
-			if (!doit)
-				continue;
+		}
+		if (!doit)
+			continue;
 
-			if (trace_hw_mask_param_enabled()) {
-				if (hw_is_mask(r->var))
-					old_mask = *hw_param_mask(params, r->var);
-			}
-			if (trace_hw_interval_param_enabled()) {
-				if (hw_is_interval(r->var))
-					old_interval = *hw_param_interval(params, r->var);
-			}
+		if (trace_hw_mask_param_enabled()) {
+			if (hw_is_mask(r->var))
+				old_mask = *hw_param_mask(params, r->var);
+		}
+		if (trace_hw_interval_param_enabled()) {
+			if (hw_is_interval(r->var))
+				old_interval = *hw_param_interval(params, r->var);
+		}
 
-			changed = r->func(params, r);
+		changed = r->func(params, r);
 
-			if (hw_is_mask(r->var)) {
-				trace_hw_mask_param(substream, r->var, k + 1,
-					&old_mask, hw_param_mask(params, r->var));
-			}
-			if (hw_is_interval(r->var)) {
-				trace_hw_interval_param(substream, r->var, k + 1,
-					&old_interval, hw_param_interval(params, r->var));
-			}
+		if (hw_is_mask(r->var)) {
+			trace_hw_mask_param(substream, r->var, k + 1,
+				&old_mask, hw_param_mask(params, r->var));
+		}
+		if (hw_is_interval(r->var)) {
+			trace_hw_interval_param(substream, r->var, k + 1,
+				&old_interval, hw_param_interval(params, r->var));
+		}
 
-			rstamps[k] = stamp;
-			if (changed && r->var >= 0) {
-				params->cmask |= (1 << r->var);
-				vstamps[r->var] = stamp;
-				again = 1;
-			}
-			if (changed < 0)
-				return changed;
-			stamp++;
+		rstamps[k] = stamp;
+		if (changed && r->var >= 0) {
+			params->cmask |= (1 << r->var);
+			vstamps[r->var] = stamp;
+			again = 1;
 		}
-	} while (again);
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
2.11.0
