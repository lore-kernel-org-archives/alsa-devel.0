From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH] ASoC: rt5663: Use the set_jack() instead of
	the export function
Date: Tue, 15 May 2018 14:00:15 +0800
Message-ID: <1526364015-28504-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id CE7D7266F4E
 for <alsa-devel@alsa-project.org>; Tue, 15 May 2018 08:00:24 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: Oder Chiou <oder_chiou@realtek.com>, jack.yu@realtek.com, alsa-devel@alsa-project.org, cychiang@google.com, shumingf@realtek.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch replaces the export function with the new API set_jack().

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5663.c                           | 5 ++---
 sound/soc/codecs/rt5663.h                           | 2 --
 sound/soc/intel/boards/kbl_rt5663_max98927.c        | 3 ++-
 sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c | 2 +-
 4 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/rt5663.c b/sound/soc/codecs/rt5663.c
index f0cef52..eefa918 100644
--- a/sound/soc/codecs/rt5663.c
+++ b/sound/soc/codecs/rt5663.c
@@ -1857,7 +1857,7 @@ static irqreturn_t rt5663_irq(int irq, void *data)
 }
 
 int rt5663_set_jack_detect(struct snd_soc_component *component,
-	struct snd_soc_jack *hs_jack)
+	struct snd_soc_jack *hs_jack, void *data)
 {
 	struct rt5663_priv *rt5663 = snd_soc_component_get_drvdata(component);
 
@@ -1867,7 +1867,6 @@ int rt5663_set_jack_detect(struct snd_soc_component *component,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(rt5663_set_jack_detect);
 
 static bool rt5663_check_jd_status(struct snd_soc_component *component)
 {
@@ -3244,10 +3243,10 @@ static const struct snd_soc_component_driver soc_component_dev_rt5663 = {
 	.num_dapm_widgets	= ARRAY_SIZE(rt5663_dapm_widgets),
 	.dapm_routes		= rt5663_dapm_routes,
 	.num_dapm_routes	= ARRAY_SIZE(rt5663_dapm_routes),
+	.set_jack		= rt5663_set_jack_detect,
 	.use_pmdown_time	= 1,
 	.endianness		= 1,
 	.non_legacy_dai_naming	= 1,
-
 };
 
 static const struct regmap_config rt5663_v2_regmap = {
diff --git a/sound/soc/codecs/rt5663.h b/sound/soc/codecs/rt5663.h
index 865203c..794cf3f 100644
--- a/sound/soc/codecs/rt5663.h
+++ b/sound/soc/codecs/rt5663.h
@@ -1125,8 +1125,6 @@ enum {
 	RT5663_AD_STEREO_FILTER = 0x2,
 };
 
-int rt5663_set_jack_detect(struct snd_soc_component *component,
-	struct snd_soc_jack *hs_jack);
 int rt5663_sel_asrc_clk_src(struct snd_soc_component *component,
 	unsigned int filter_mask, unsigned int clk_src);
 
diff --git a/sound/soc/intel/boards/kbl_rt5663_max98927.c b/sound/soc/intel/boards/kbl_rt5663_max98927.c
index 513cc65..3a61252 100644
--- a/sound/soc/intel/boards/kbl_rt5663_max98927.c
+++ b/sound/soc/intel/boards/kbl_rt5663_max98927.c
@@ -299,7 +299,8 @@ static int kabylake_rt5663_codec_init(struct snd_soc_pcm_runtime *rtd)
 	snd_jack_set_key(jack->jack, SND_JACK_BTN_2, KEY_VOLUMEUP);
 	snd_jack_set_key(jack->jack, SND_JACK_BTN_3, KEY_VOLUMEDOWN);
 
-	rt5663_set_jack_detect(component, &ctx->kabylake_headset);
+	snd_soc_component_set_jack(component, &ctx->kabylake_headset, NULL);
+
 	return ret;
 }
 
diff --git a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
index e8382d6..92f5fb2 100644
--- a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
+++ b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
@@ -200,7 +200,7 @@ static int kabylake_rt5663_codec_init(struct snd_soc_pcm_runtime *rtd)
 	snd_jack_set_key(jack->jack, SND_JACK_BTN_2, KEY_VOLUMEUP);
 	snd_jack_set_key(jack->jack, SND_JACK_BTN_3, KEY_VOLUMEDOWN);
 
-	rt5663_set_jack_detect(component, &ctx->kabylake_headset);
+	snd_soc_component_set_jack(component, &ctx->kabylake_headset, NULL);
 
 	ret = snd_soc_dapm_ignore_suspend(&rtd->card->dapm, "DMIC");
 	if (ret)
-- 
2.7.4
