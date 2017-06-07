From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 1/8] ALSA: pcm: add a helper function to
	constrain mask-type parameters
Date: Thu,  8 Jun 2017 08:10:19 +0900
Message-ID: <20170607231026.23383-2-o-takashi@sakamocchi.jp>
References: <20170607231026.23383-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 0103926721F
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

Application of constraints to mask-type parameters for PCM substream is
done in a call of snd_pcm_hw_refine(), while the function includes much
codes and is not enough friendly to readers.

This commit splits the codes to a separated function so that readers can
get it easily. I leave desicion into compilers to merge the function into
its callee.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/pcm_native.c | 57 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 38 insertions(+), 19 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 2bde07a4a87f..b3e8aab3915e 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -253,6 +253,40 @@ static bool hw_support_mmap(struct snd_pcm_substream *substream)
 	return true;
 }
 
+static int constrain_mask_params(struct snd_pcm_substream *substream,
+				 struct snd_pcm_hw_params *params)
+{
+	struct snd_pcm_hw_constraints *constrs =
+					&substream->runtime->hw_constraints;
+	struct snd_mask *m;
+	unsigned int k;
+	int changed;
+
+	struct snd_mask __maybe_unused old_mask;
+
+	for (k = SNDRV_PCM_HW_PARAM_FIRST_MASK; k <= SNDRV_PCM_HW_PARAM_LAST_MASK; k++) {
+		m = hw_param_mask(params, k);
+		if (snd_mask_empty(m))
+			return -EINVAL;
+		if (!(params->rmask & (1 << k)))
+			continue;
+
+		if (trace_hw_mask_param_enabled())
+			old_mask = *m;
+
+		changed = snd_mask_refine(m, constrs_mask(constrs, k));
+
+		trace_hw_mask_param(substream, k, 0, &old_mask, m);
+
+		if (changed)
+			params->cmask |= 1 << k;
+		if (changed < 0)
+			return changed;
+	}
+
+	return 0;
+}
+
 int snd_pcm_hw_refine(struct snd_pcm_substream *substream, 
 		      struct snd_pcm_hw_params *params)
 {
@@ -265,6 +299,7 @@ int snd_pcm_hw_refine(struct snd_pcm_substream *substream,
 	unsigned int vstamps[SNDRV_PCM_HW_PARAM_LAST_INTERVAL + 1];
 	unsigned int stamp = 2;
 	int changed, again;
+	int err;
 
 	struct snd_mask __maybe_unused old_mask;
 	struct snd_interval __maybe_unused old_interval;
@@ -278,25 +313,9 @@ int snd_pcm_hw_refine(struct snd_pcm_substream *substream,
 		params->rate_den = 0;
 	}
 
-	for (k = SNDRV_PCM_HW_PARAM_FIRST_MASK; k <= SNDRV_PCM_HW_PARAM_LAST_MASK; k++) {
-		m = hw_param_mask(params, k);
-		if (snd_mask_empty(m))
-			return -EINVAL;
-		if (!(params->rmask & (1 << k)))
-			continue;
-
-		if (trace_hw_mask_param_enabled())
-			old_mask = *m;
-
-		changed = snd_mask_refine(m, constrs_mask(constrs, k));
-
-		trace_hw_mask_param(substream, k, 0, &old_mask, m);
-
-		if (changed)
-			params->cmask |= 1 << k;
-		if (changed < 0)
-			return changed;
-	}
+	err = constrain_mask_params(substream, params);
+	if (err < 0)
+		return err;
 
 	for (k = SNDRV_PCM_HW_PARAM_FIRST_INTERVAL; k <= SNDRV_PCM_HW_PARAM_LAST_INTERVAL; k++) {
 		i = hw_param_interval(params, k);
-- 
2.11.0
