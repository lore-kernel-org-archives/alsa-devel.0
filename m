From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH RFC 03/21] ALSA: pcm: add a helper function to
	apply parameter rules
Date: Sun, 14 May 2017 17:57:38 +0900
Message-ID: <20170514085756.22382-4-o-takashi@sakamocchi.jp>
References: <20170514085756.22382-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 16DEE2665D5
 for <alsa-devel@alsa-project.org>; Sun, 14 May 2017 10:58:01 +0200 (CEST)
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

Application of rules to parameters of PCM substream is done in a call of
snd_pcm_hw_refine(), while the function includes much codes and is not
enough friendly to readers.

This commit splits the codes to a separated function so that readers can
get it easily. I leave desicion into compilers to merge the function into
its callee.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/pcm_native.c | 62 +++++++++++++++++++++++++++++++------------------
 1 file changed, 40 insertions(+), 22 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index b828e94..78afdf1 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -349,35 +349,19 @@ static int constrain_interval_params(struct snd_pcm_hw_constraints *constrs,
 	return 0;
 }
 
-int snd_pcm_hw_refine(struct snd_pcm_substream *substream, 
-		      struct snd_pcm_hw_params *params)
+static int constrain_params_by_rules(struct snd_pcm_hw_constraints *constrs,
+				     struct snd_pcm_hw_params *params)
 {
 	unsigned int k;
-	struct snd_pcm_hardware *hw;
-	struct snd_mask *m = NULL;
-	struct snd_interval *i = NULL;
-	struct snd_pcm_hw_constraints *constrs = &substream->runtime->hw_constraints;
 	unsigned int rstamps[constrs->rules_num];
 	unsigned int vstamps[SNDRV_PCM_HW_PARAM_LAST_INTERVAL + 1];
 	unsigned int stamp = 2;
 	int changed, again;
 
-	params->info = 0;
-	params->fifo_size = 0;
-	if (params->rmask & (1 << SNDRV_PCM_HW_PARAM_SAMPLE_BITS))
-		params->msbits = 0;
-	if (params->rmask & (1 << SNDRV_PCM_HW_PARAM_RATE)) {
-		params->rate_num = 0;
-		params->rate_den = 0;
-	}
-
-	changed = constrain_mask_params(constrs, params);
-	if (changed < 0)
-		return changed;
-
-	changed = constrain_interval_params(constrs, params);
-	if (changed < 0)
-		return changed;
+#ifdef RULES_DEBUG
+	struct snd_mask *m = NULL;
+	struct snd_interval *i = NULL;
+#endif
 
 	for (k = 0; k < constrs->rules_num; k++)
 		rstamps[k] = 0;
@@ -445,6 +429,40 @@ int snd_pcm_hw_refine(struct snd_pcm_substream *substream,
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
+	struct snd_mask *m = NULL;
+	struct snd_interval *i = NULL;
+	struct snd_pcm_hw_constraints *constrs = &substream->runtime->hw_constraints;
+	int changed;
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
+	changed = constrain_mask_params(constrs, params);
+	if (changed < 0)
+		return changed;
+
+	changed = constrain_interval_params(constrs, params);
+	if (changed < 0)
+		return changed;
+
+	changed = constrain_params_by_rules(constrs, params);
+	if (changed < 0)
+		return changed;
+
 	if (!params->msbits) {
 		i = hw_param_interval(params, SNDRV_PCM_HW_PARAM_SAMPLE_BITS);
 		if (snd_interval_single(i))
-- 
2.9.3
