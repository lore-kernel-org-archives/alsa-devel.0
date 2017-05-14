From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH RFC 14/21] ALSA: pcm: use helper function to
	refer parameter as read-only
Date: Sun, 14 May 2017 17:57:49 +0900
Message-ID: <20170514085756.22382-15-o-takashi@sakamocchi.jp>
References: <20170514085756.22382-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id C12A3266B09
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

ALSA pcm core has hw_param_interval_c() to pick up parameter with const
qualifier for safe programming.

This commit applies it to the cases.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/oss/pcm_oss.c | 4 ++--
 sound/core/pcm_drm_eld.c | 8 ++++----
 sound/core/pcm_lib.c     | 3 ++-
 sound/core/pcm_native.c  | 3 ++-
 4 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/sound/core/oss/pcm_oss.c b/sound/core/oss/pcm_oss.c
index 36baf96..2a47351 100644
--- a/sound/core/oss/pcm_oss.c
+++ b/sound/core/oss/pcm_oss.c
@@ -799,7 +799,7 @@ static int snd_pcm_oss_period_size(struct snd_pcm_substream *substream,
 static int choose_rate(struct snd_pcm_substream *substream,
 		       struct snd_pcm_hw_params *params, unsigned int best_rate)
 {
-	struct snd_interval *it;
+	const struct snd_interval *it;
 	struct snd_pcm_hw_params *save;
 	unsigned int rate, prev;
 
@@ -807,7 +807,7 @@ static int choose_rate(struct snd_pcm_substream *substream,
 	if (save == NULL)
 		return -ENOMEM;
 	*save = *params;
-	it = hw_param_interval(save, SNDRV_PCM_HW_PARAM_RATE);
+	it = hw_param_interval_c(save, SNDRV_PCM_HW_PARAM_RATE);
 
 	/* try multiples of the best rate */
 	rate = best_rate;
diff --git a/sound/core/pcm_drm_eld.c b/sound/core/pcm_drm_eld.c
index e70379f..9881d08 100644
--- a/sound/core/pcm_drm_eld.c
+++ b/sound/core/pcm_drm_eld.c
@@ -29,13 +29,13 @@ static int eld_limit_rates(struct snd_pcm_hw_params *params,
 			   struct snd_pcm_hw_rule *rule)
 {
 	struct snd_interval *r = hw_param_interval(params, rule->var);
-	struct snd_interval *c;
+	const struct snd_interval *c;
 	unsigned int rate_mask = 7, i;
 	const u8 *sad, *eld = rule->private;
 
 	sad = drm_eld_sad(eld);
 	if (sad) {
-		c = hw_param_interval(params, SNDRV_PCM_HW_PARAM_CHANNELS);
+		c = hw_param_interval_c(params, SNDRV_PCM_HW_PARAM_CHANNELS);
 
 		for (i = drm_eld_sad_count(eld); i > 0; i--, sad += 3) {
 			unsigned max_channels = sad_max_channels(sad);
@@ -57,7 +57,7 @@ static int eld_limit_channels(struct snd_pcm_hw_params *params,
 			      struct snd_pcm_hw_rule *rule)
 {
 	struct snd_interval *c = hw_param_interval(params, rule->var);
-	struct snd_interval *r;
+	const struct snd_interval *r;
 	struct snd_interval t = { .min = 1, .max = 2, .integer = 1, };
 	unsigned int i;
 	const u8 *sad, *eld = rule->private;
@@ -67,7 +67,7 @@ static int eld_limit_channels(struct snd_pcm_hw_params *params,
 		unsigned int rate_mask = 0;
 
 		/* Convert the rate interval to a mask */
-		r = hw_param_interval(params, SNDRV_PCM_HW_PARAM_RATE);
+		r = hw_param_interval_c(params, SNDRV_PCM_HW_PARAM_RATE);
 		for (i = 0; i < ARRAY_SIZE(eld_rates); i++)
 			if (r->min <= eld_rates[i] && r->max >= eld_rates[i])
 				rate_mask |= BIT(i);
diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index a62f1f4..9659fa6 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -1415,7 +1415,8 @@ static int snd_pcm_hw_rule_msbits(struct snd_pcm_hw_params *params,
 	unsigned int l = (unsigned long) rule->private;
 	int width = l & 0xffff;
 	unsigned int msbits = l >> 16;
-	struct snd_interval *i = hw_param_interval(params, SNDRV_PCM_HW_PARAM_SAMPLE_BITS);
+	const struct snd_interval *i =
+		hw_param_interval_c(params, SNDRV_PCM_HW_PARAM_SAMPLE_BITS);
 
 	if (!snd_interval_single(i))
 		return 0;
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 028d6a5..65133c2 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -2073,7 +2073,8 @@ static int snd_pcm_hw_rule_format(struct snd_pcm_hw_params *params,
 				  struct snd_pcm_hw_rule *rule)
 {
 	unsigned int k;
-	struct snd_interval *i = hw_param_interval(params, rule->deps[0]);
+	const struct snd_interval *i =
+				hw_param_interval_c(params, rule->deps[0]);
 	struct snd_mask m;
 	struct snd_mask *mask = hw_param_mask(params, SNDRV_PCM_HW_PARAM_FORMAT);
 	snd_mask_any(&m);
-- 
2.9.3
