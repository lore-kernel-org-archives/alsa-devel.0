From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: max98927: replace codec to component"
	to the asoc tree
Date: Mon, 12 Feb 2018 12:41:14 +0000
Message-ID: <E1elDQ2-0004n8-95@debutante>
References: <87inblz4s7.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 8DBB7267BF6
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:41:16 +0100 (CET)
In-Reply-To: <87inblz4s7.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: max98927: replace codec to component

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

>From ec4bf5acbb32f298029c14283f02b409d7354fb9 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 04:09:04 +0000
Subject: [PATCH] ASoC: max98927: replace codec to component

Now we can replace Codec to Component. Let's do it.

Note:
	xxx_codec_xxx()		->	xxx_component_xxx()
	.idle_bias_off = 0	->	.idle_bias_on = 1
	.ignore_pmdown_time = 0	->	.use_pmdown_time = 1
	-			->	.endianness = 1
	-			->	.non_legacy_dai_naming = 1

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max98927.c | 82 +++++++++++++++++++++------------------------
 sound/soc/codecs/max98927.h |  2 +-
 2 files changed, 40 insertions(+), 44 deletions(-)

diff --git a/sound/soc/codecs/max98927.c b/sound/soc/codecs/max98927.c
index f701fdc81175..065303a46535 100644
--- a/sound/soc/codecs/max98927.c
+++ b/sound/soc/codecs/max98927.c
@@ -142,14 +142,14 @@ static struct reg_default max98927_reg[] = {
 
 static int max98927_dai_set_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
-	struct max98927_priv *max98927 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = codec_dai->component;
+	struct max98927_priv *max98927 = snd_soc_component_get_drvdata(component);
 	unsigned int mode = 0;
 	unsigned int format = 0;
 	bool use_pdm = false;
 	unsigned int invert = 0;
 
-	dev_dbg(codec->dev, "%s: fmt 0x%08X\n", __func__, fmt);
+	dev_dbg(component->dev, "%s: fmt 0x%08X\n", __func__, fmt);
 
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
 	case SND_SOC_DAIFMT_CBS_CFS:
@@ -160,7 +160,7 @@ static int max98927_dai_set_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 		mode = MAX98927_PCM_MASTER_MODE_MASTER;
 		break;
 	default:
-		dev_err(codec->dev, "DAI clock mode unsupported\n");
+		dev_err(component->dev, "DAI clock mode unsupported\n");
 		return -EINVAL;
 	}
 
@@ -176,7 +176,7 @@ static int max98927_dai_set_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 		invert = MAX98927_PCM_MODE_CFG_PCM_BCLKEDGE;
 		break;
 	default:
-		dev_err(codec->dev, "DAI invert mode unsupported\n");
+		dev_err(component->dev, "DAI invert mode unsupported\n");
 		return -EINVAL;
 	}
 
@@ -268,7 +268,7 @@ static int max98927_get_bclk_sel(int bclk)
 static int max98927_set_clock(struct max98927_priv *max98927,
 	struct snd_pcm_hw_params *params)
 {
-	struct snd_soc_codec *codec = max98927->codec;
+	struct snd_soc_component *component = max98927->component;
 	/* BCLK/LRCLK ratio calculation */
 	int blr_clk_ratio = params_channels(params) * max98927->ch_size;
 	int value;
@@ -281,7 +281,7 @@ static int max98927_set_clock(struct max98927_priv *max98927,
 				break;
 		}
 		if (i == ARRAY_SIZE(rate_table)) {
-			dev_err(codec->dev, "failed to find proper clock rate.\n");
+			dev_err(component->dev, "failed to find proper clock rate.\n");
 			return -EINVAL;
 		}
 		regmap_update_bits(max98927->regmap,
@@ -294,7 +294,7 @@ static int max98927_set_clock(struct max98927_priv *max98927,
 		/* BCLK configuration */
 		value = max98927_get_bclk_sel(blr_clk_ratio);
 		if (!value) {
-			dev_err(codec->dev, "format unsupported %d\n",
+			dev_err(component->dev, "format unsupported %d\n",
 				params_format(params));
 			return -EINVAL;
 		}
@@ -311,8 +311,8 @@ static int max98927_dai_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params,
 	struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct max98927_priv *max98927 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct max98927_priv *max98927 = snd_soc_component_get_drvdata(component);
 	unsigned int sampling_rate = 0;
 	unsigned int chan_sz = 0;
 
@@ -328,7 +328,7 @@ static int max98927_dai_hw_params(struct snd_pcm_substream *substream,
 		chan_sz = MAX98927_PCM_MODE_CFG_CHANSZ_32;
 		break;
 	default:
-		dev_err(codec->dev, "format unsupported %d\n",
+		dev_err(component->dev, "format unsupported %d\n",
 			params_format(params));
 		goto err;
 	}
@@ -339,7 +339,7 @@ static int max98927_dai_hw_params(struct snd_pcm_substream *substream,
 		MAX98927_R0020_PCM_MODE_CFG,
 		MAX98927_PCM_MODE_CFG_CHANSZ_MASK, chan_sz);
 
-	dev_dbg(codec->dev, "format supported %d",
+	dev_dbg(component->dev, "format supported %d",
 		params_format(params));
 
 	/* sampling rate configuration */
@@ -372,7 +372,7 @@ static int max98927_dai_hw_params(struct snd_pcm_substream *substream,
 		sampling_rate = MAX98927_PCM_SR_SET1_SR_48000;
 		break;
 	default:
-		dev_err(codec->dev, "rate %d not supported\n",
+		dev_err(component->dev, "rate %d not supported\n",
 			params_rate(params));
 		goto err;
 	}
@@ -407,8 +407,8 @@ static int max98927_dai_tdm_slot(struct snd_soc_dai *dai,
 	unsigned int tx_mask, unsigned int rx_mask,
 	int slots, int slot_width)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct max98927_priv *max98927 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct max98927_priv *max98927 = snd_soc_component_get_drvdata(component);
 	int bsel = 0;
 	unsigned int chan_sz = 0;
 
@@ -417,7 +417,7 @@ static int max98927_dai_tdm_slot(struct snd_soc_dai *dai,
 	/* BCLK configuration */
 	bsel = max98927_get_bclk_sel(slots * slot_width);
 	if (bsel == 0) {
-		dev_err(codec->dev, "BCLK %d not supported\n",
+		dev_err(component->dev, "BCLK %d not supported\n",
 			slots * slot_width);
 		return -EINVAL;
 	}
@@ -439,7 +439,7 @@ static int max98927_dai_tdm_slot(struct snd_soc_dai *dai,
 		chan_sz = MAX98927_PCM_MODE_CFG_CHANSZ_32;
 		break;
 	default:
-		dev_err(codec->dev, "format unsupported %d\n",
+		dev_err(component->dev, "format unsupported %d\n",
 			slot_width);
 		return -EINVAL;
 	}
@@ -483,8 +483,8 @@ static int max98927_dai_tdm_slot(struct snd_soc_dai *dai,
 static int max98927_dai_set_sysclk(struct snd_soc_dai *dai,
 	int clk_id, unsigned int freq, int dir)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct max98927_priv *max98927 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct max98927_priv *max98927 = snd_soc_component_get_drvdata(component);
 
 	max98927->sysclk = freq;
 	return 0;
@@ -500,8 +500,8 @@ static const struct snd_soc_dai_ops max98927_dai_ops = {
 static int max98927_dac_event(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
-	struct max98927_priv *max98927 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct max98927_priv *max98927 = snd_soc_component_get_drvdata(component);
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
@@ -677,11 +677,11 @@ static struct snd_soc_dai_driver max98927_dai[] = {
 	}
 };
 
-static int max98927_probe(struct snd_soc_codec *codec)
+static int max98927_probe(struct snd_soc_component *component)
 {
-	struct max98927_priv *max98927 = snd_soc_codec_get_drvdata(codec);
+	struct max98927_priv *max98927 = snd_soc_component_get_drvdata(component);
 
-	max98927->codec = codec;
+	max98927->component = component;
 
 	/* Software Reset */
 	regmap_write(max98927->regmap,
@@ -823,16 +823,18 @@ static const struct dev_pm_ops max98927_pm = {
 	SET_SYSTEM_SLEEP_PM_OPS(max98927_suspend, max98927_resume)
 };
 
-static const struct snd_soc_codec_driver soc_codec_dev_max98927 = {
-	.probe = max98927_probe,
-	.component_driver = {
-		.controls = max98927_snd_controls,
-		.num_controls = ARRAY_SIZE(max98927_snd_controls),
-		.dapm_widgets = max98927_dapm_widgets,
-		.num_dapm_widgets = ARRAY_SIZE(max98927_dapm_widgets),
-		.dapm_routes = max98927_audio_map,
-		.num_dapm_routes = ARRAY_SIZE(max98927_audio_map),
-	},
+static const struct snd_soc_component_driver soc_component_dev_max98927 = {
+	.probe			= max98927_probe,
+	.controls		= max98927_snd_controls,
+	.num_controls		= ARRAY_SIZE(max98927_snd_controls),
+	.dapm_widgets		= max98927_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(max98927_dapm_widgets),
+	.dapm_routes		= max98927_audio_map,
+	.num_dapm_routes	= ARRAY_SIZE(max98927_audio_map),
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 static const struct regmap_config max98927_regmap = {
@@ -914,20 +916,15 @@ static int max98927_i2c_probe(struct i2c_client *i2c,
 	max98927_slot_config(i2c, max98927);
 
 	/* codec registeration */
-	ret = snd_soc_register_codec(&i2c->dev, &soc_codec_dev_max98927,
+	ret = devm_snd_soc_register_component(&i2c->dev,
+		&soc_component_dev_max98927,
 		max98927_dai, ARRAY_SIZE(max98927_dai));
 	if (ret < 0)
-		dev_err(&i2c->dev, "Failed to register codec: %d\n", ret);
+		dev_err(&i2c->dev, "Failed to register component: %d\n", ret);
 
 	return ret;
 }
 
-static int max98927_i2c_remove(struct i2c_client *client)
-{
-	snd_soc_unregister_codec(&client->dev);
-	return 0;
-}
-
 static const struct i2c_device_id max98927_i2c_id[] = {
 	{ "max98927", 0},
 	{ },
@@ -959,7 +956,6 @@ static struct i2c_driver max98927_i2c_driver = {
 		.pm = &max98927_pm,
 	},
 	.probe  = max98927_i2c_probe,
-	.remove = max98927_i2c_remove,
 	.id_table = max98927_i2c_id,
 };
 
diff --git a/sound/soc/codecs/max98927.h b/sound/soc/codecs/max98927.h
index 9ea839735433..42a9a244a9db 100644
--- a/sound/soc/codecs/max98927.h
+++ b/sound/soc/codecs/max98927.h
@@ -258,7 +258,7 @@
 
 struct max98927_priv {
 	struct regmap *regmap;
-	struct snd_soc_codec *codec;
+	struct snd_soc_component *component;
 	struct max98927_pdata *pdata;
 	unsigned int spk_gain;
 	unsigned int sysclk;
-- 
2.16.1
