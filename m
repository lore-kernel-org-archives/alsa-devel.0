From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: max98373: replace codec to component"
	to the asoc tree
Date: Mon, 12 Feb 2018 12:40:57 +0000
Message-ID: <E1elDPl-0004lO-9a@debutante>
References: <87fu6pz4r4.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 69195267681
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:40:59 +0100 (CET)
In-Reply-To: <87fu6pz4r4.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: max98373: replace codec to component

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

>From 41572b5455be5da603b671a04be267cb4bd8633b Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 04:09:48 +0000
Subject: [PATCH] ASoC: max98373: replace codec to component

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
 sound/soc/codecs/max98373.c | 75 ++++++++++++++++++++-------------------------
 1 file changed, 34 insertions(+), 41 deletions(-)

diff --git a/sound/soc/codecs/max98373.c b/sound/soc/codecs/max98373.c
index 562e88765129..a92586106932 100644
--- a/sound/soc/codecs/max98373.c
+++ b/sound/soc/codecs/max98373.c
@@ -112,12 +112,12 @@ static struct reg_default max98373_reg[] = {
 
 static int max98373_dai_set_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
-	struct max98373_priv *max98373 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = codec_dai->component;
+	struct max98373_priv *max98373 = snd_soc_component_get_drvdata(component);
 	unsigned int format = 0;
 	unsigned int invert = 0;
 
-	dev_dbg(codec->dev, "%s: fmt 0x%08X\n", __func__, fmt);
+	dev_dbg(component->dev, "%s: fmt 0x%08X\n", __func__, fmt);
 
 	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
 	case SND_SOC_DAIFMT_NB_NF:
@@ -126,7 +126,7 @@ static int max98373_dai_set_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 		invert = MAX98373_PCM_MODE_CFG_PCM_BCLKEDGE;
 		break;
 	default:
-		dev_err(codec->dev, "DAI invert mode unsupported\n");
+		dev_err(component->dev, "DAI invert mode unsupported\n");
 		return -EINVAL;
 	}
 
@@ -177,10 +177,10 @@ static int max98373_get_bclk_sel(int bclk)
 	return 0;
 }
 
-static int max98373_set_clock(struct snd_soc_codec *codec,
+static int max98373_set_clock(struct snd_soc_component *component,
 	struct snd_pcm_hw_params *params)
 {
-	struct max98373_priv *max98373 = snd_soc_codec_get_drvdata(codec);
+	struct max98373_priv *max98373 = snd_soc_component_get_drvdata(component);
 	/* BCLK/LRCLK ratio calculation */
 	int blr_clk_ratio = params_channels(params) * max98373->ch_size;
 	int value;
@@ -189,7 +189,7 @@ static int max98373_set_clock(struct snd_soc_codec *codec,
 		/* BCLK configuration */
 		value = max98373_get_bclk_sel(blr_clk_ratio);
 		if (!value) {
-			dev_err(codec->dev, "format unsupported %d\n",
+			dev_err(component->dev, "format unsupported %d\n",
 				params_format(params));
 			return -EINVAL;
 		}
@@ -206,8 +206,8 @@ static int max98373_dai_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params,
 	struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct max98373_priv *max98373 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct max98373_priv *max98373 = snd_soc_component_get_drvdata(component);
 	unsigned int sampling_rate = 0;
 	unsigned int chan_sz = 0;
 
@@ -223,7 +223,7 @@ static int max98373_dai_hw_params(struct snd_pcm_substream *substream,
 		chan_sz = MAX98373_PCM_MODE_CFG_CHANSZ_32;
 		break;
 	default:
-		dev_err(codec->dev, "format unsupported %d\n",
+		dev_err(component->dev, "format unsupported %d\n",
 			params_format(params));
 		goto err;
 	}
@@ -234,7 +234,7 @@ static int max98373_dai_hw_params(struct snd_pcm_substream *substream,
 		MAX98373_R2024_PCM_DATA_FMT_CFG,
 		MAX98373_PCM_MODE_CFG_CHANSZ_MASK, chan_sz);
 
-	dev_dbg(codec->dev, "format supported %d",
+	dev_dbg(component->dev, "format supported %d",
 		params_format(params));
 
 	/* sampling rate configuration */
@@ -267,7 +267,7 @@ static int max98373_dai_hw_params(struct snd_pcm_substream *substream,
 		sampling_rate = MAX98373_PCM_SR_SET1_SR_48000;
 		break;
 	default:
-		dev_err(codec->dev, "rate %d not supported\n",
+		dev_err(component->dev, "rate %d not supported\n",
 			params_rate(params));
 		goto err;
 	}
@@ -295,7 +295,7 @@ static int max98373_dai_hw_params(struct snd_pcm_substream *substream,
 			MAX98373_PCM_SR_SET2_IVADC_SR_MASK,
 			sampling_rate);
 
-	return max98373_set_clock(codec, params);
+	return max98373_set_clock(component, params);
 err:
 	return -EINVAL;
 }
@@ -304,8 +304,8 @@ static int max98373_dai_tdm_slot(struct snd_soc_dai *dai,
 	unsigned int tx_mask, unsigned int rx_mask,
 	int slots, int slot_width)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct max98373_priv *max98373 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct max98373_priv *max98373 = snd_soc_component_get_drvdata(component);
 	int bsel = 0;
 	unsigned int chan_sz = 0;
 	unsigned int mask;
@@ -319,7 +319,7 @@ static int max98373_dai_tdm_slot(struct snd_soc_dai *dai,
 	/* BCLK configuration */
 	bsel = max98373_get_bclk_sel(slots * slot_width);
 	if (bsel == 0) {
-		dev_err(codec->dev, "BCLK %d not supported\n",
+		dev_err(component->dev, "BCLK %d not supported\n",
 			slots * slot_width);
 		return -EINVAL;
 	}
@@ -341,7 +341,7 @@ static int max98373_dai_tdm_slot(struct snd_soc_dai *dai,
 		chan_sz = MAX98373_PCM_MODE_CFG_CHANSZ_32;
 		break;
 	default:
-		dev_err(codec->dev, "format unsupported %d\n",
+		dev_err(component->dev, "format unsupported %d\n",
 			slot_width);
 		return -EINVAL;
 	}
@@ -394,8 +394,8 @@ static const struct snd_soc_dai_ops max98373_dai_ops = {
 static int max98373_dac_event(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
-	struct max98373_priv *max98373 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct max98373_priv *max98373 = snd_soc_component_get_drvdata(component);
 
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
@@ -721,11 +721,9 @@ static struct snd_soc_dai_driver max98373_dai[] = {
 	}
 };
 
-static int max98373_probe(struct snd_soc_codec *codec)
+static int max98373_probe(struct snd_soc_component *component)
 {
-	struct max98373_priv *max98373 = snd_soc_codec_get_drvdata(codec);
-
-	codec->control_data = max98373->regmap;
+	struct max98373_priv *max98373 = snd_soc_component_get_drvdata(component);
 
 	/* Software Reset */
 	regmap_write(max98373->regmap,
@@ -828,16 +826,18 @@ static const struct dev_pm_ops max98373_pm = {
 	SET_SYSTEM_SLEEP_PM_OPS(max98373_suspend, max98373_resume)
 };
 
-static const struct snd_soc_codec_driver soc_codec_dev_max98373 = {
-	.probe = max98373_probe,
-	.component_driver = {
-		.controls = max98373_snd_controls,
-		.num_controls = ARRAY_SIZE(max98373_snd_controls),
-		.dapm_widgets = max98373_dapm_widgets,
-		.num_dapm_widgets = ARRAY_SIZE(max98373_dapm_widgets),
-		.dapm_routes = max98373_audio_map,
-		.num_dapm_routes = ARRAY_SIZE(max98373_audio_map),
-	},
+static const struct snd_soc_component_driver soc_codec_dev_max98373 = {
+	.probe			= max98373_probe,
+	.controls		= max98373_snd_controls,
+	.num_controls		= ARRAY_SIZE(max98373_snd_controls),
+	.dapm_widgets		= max98373_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(max98373_dapm_widgets),
+	.dapm_routes		= max98373_audio_map,
+	.num_dapm_routes	= ARRAY_SIZE(max98373_audio_map),
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 static const struct regmap_config max98373_regmap = {
@@ -920,7 +920,7 @@ static int max98373_i2c_probe(struct i2c_client *i2c,
 	max98373_slot_config(i2c, max98373);
 
 	/* codec registeration */
-	ret = snd_soc_register_codec(&i2c->dev, &soc_codec_dev_max98373,
+	ret = devm_snd_soc_register_component(&i2c->dev, &soc_codec_dev_max98373,
 		max98373_dai, ARRAY_SIZE(max98373_dai));
 	if (ret < 0)
 		dev_err(&i2c->dev, "Failed to register codec: %d\n", ret);
@@ -928,12 +928,6 @@ static int max98373_i2c_probe(struct i2c_client *i2c,
 	return ret;
 }
 
-static int max98373_i2c_remove(struct i2c_client *client)
-{
-	snd_soc_unregister_codec(&client->dev);
-	return 0;
-}
-
 static const struct i2c_device_id max98373_i2c_id[] = {
 	{ "max98373", 0},
 	{ },
@@ -965,7 +959,6 @@ static struct i2c_driver max98373_i2c_driver = {
 		.pm = &max98373_pm,
 	},
 	.probe = max98373_i2c_probe,
-	.remove = max98373_i2c_remove,
 	.id_table = max98373_i2c_id,
 };
 
-- 
2.16.1
