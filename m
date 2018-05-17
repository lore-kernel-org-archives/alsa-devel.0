From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5663: Use the set_jack() instead of
	the export function" to the asoc tree
Date: Thu, 17 May 2018 17:40:38 +0100 (BST)
Message-ID: <20180517164038.AE84044007E@finisterre.ee.mobilebroadband>
References: <1526364015-28504-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 137D12676B6
 for <alsa-devel@alsa-project.org>; Thu, 17 May 2018 18:40:42 +0200 (CEST)
In-Reply-To: <1526364015-28504-1-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>
Cc: jack.yu@realtek.com, alsa-devel@alsa-project.org, cychiang@google.com, lgirdwood@gmail.com, broonie@kernel.org, shumingf@realtek.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5663: Use the set_jack() instead of the export function

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 37a0491116994ba92ec94a98aa6bfbe8f8d7236f Mon Sep 17 00:00:00 2001
From: Oder Chiou <oder_chiou@realtek.com>
Date: Tue, 15 May 2018 14:00:15 +0800
Subject: [PATCH] ASoC: rt5663: Use the set_jack() instead of the export
 function

The patch replaces the export function with the new API set_jack().

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5663.c                           | 5 ++---
 sound/soc/codecs/rt5663.h                           | 2 --
 sound/soc/intel/boards/kbl_rt5663_max98927.c        | 3 ++-
 sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c | 2 +-
 4 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/rt5663.c b/sound/soc/codecs/rt5663.c
index f0cef52ec03e..eefa9187c895 100644
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
index 865203cc2034..794cf3fadf31 100644
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
index 513cc65a77be..3a61252fe450 100644
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
index e8382d6bbd8c..92f5fb2ae0a3 100644
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
2.17.0
