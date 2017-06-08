From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH v2 6/8] ALSA: pcm: adaption of code formatting
Date: Fri,  9 Jun 2017 06:37:04 +0900
Message-ID: <20170608213706.5420-7-o-takashi@sakamocchi.jp>
References: <20170608213706.5420-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 4041B2673C0
 for <alsa-devel@alsa-project.org>; Thu,  8 Jun 2017 23:37:29 +0200 (CEST)
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

This commit modifies current for readability in below aspects:
 - use bool type variable instead of int type variable assigned to 0/1
 - move variable definition from loop to top of the function definition

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/pcm_native.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index db4cdd114ed4..40560e579d33 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -328,9 +328,11 @@ static int constrain_params_by_rules(struct snd_pcm_substream *substream,
 	unsigned int rstamps[constrs->rules_num];
 	unsigned int vstamps[SNDRV_PCM_HW_PARAM_LAST_INTERVAL + 1];
 	unsigned int stamp = 2;
+	struct snd_pcm_hw_rule *r;
+	unsigned int d;
 	struct snd_mask old_mask;
 	struct snd_interval old_interval;
-	int again;
+	bool again;
 	int changed;
 
 	for (k = 0; k < constrs->rules_num; k++)
@@ -338,10 +340,9 @@ static int constrain_params_by_rules(struct snd_pcm_substream *substream,
 	for (k = 0; k <= SNDRV_PCM_HW_PARAM_LAST_INTERVAL; k++)
 		vstamps[k] = (params->rmask & (1 << k)) ? 1 : 0;
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
@@ -375,7 +376,7 @@ static int constrain_params_by_rules(struct snd_pcm_substream *substream,
 		if (changed && r->var >= 0) {
 			params->cmask |= (1 << r->var);
 			vstamps[r->var] = stamp;
-			again = 1;
+			again = true;
 		}
 		if (changed < 0)
 			return changed;
@@ -453,7 +454,6 @@ int snd_pcm_hw_refine(struct snd_pcm_substream *substream,
 	params->rmask = 0;
 	return 0;
 }
-
 EXPORT_SYMBOL(snd_pcm_hw_refine);
 
 static int snd_pcm_hw_refine_user(struct snd_pcm_substream *substream,
-- 
2.11.0
