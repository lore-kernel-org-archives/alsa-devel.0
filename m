From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8776: replace codec to component" to
	the asoc tree
Date: Mon, 12 Feb 2018 12:50:38 +0000
Message-ID: <E1elDZ8-0006F7-Tp@debutante>
References: <87vafl4bdt.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 5755E268021
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:50:41 +0100 (CET)
In-Reply-To: <87vafl4bdt.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: wm8776: replace codec to component

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

>From 51e42c952e872ebcdbbb2418f652e9c678612072 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 03:02:13 +0000
Subject: [PATCH] ASoC: wm8776: replace codec to component

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
 sound/soc/codecs/wm8776.c | 105 ++++++++++++++++++++--------------------------
 1 file changed, 46 insertions(+), 59 deletions(-)

diff --git a/sound/soc/codecs/wm8776.c b/sound/soc/codecs/wm8776.c
index ae30480b3976..fb357e23f221 100644
--- a/sound/soc/codecs/wm8776.c
+++ b/sound/soc/codecs/wm8776.c
@@ -78,9 +78,9 @@ static bool wm8776_volatile(struct device *dev, unsigned int reg)
 	}
 }
 
-static int wm8776_reset(struct snd_soc_codec *codec)
+static int wm8776_reset(struct snd_soc_component *component)
 {
-	return snd_soc_write(codec, WM8776_RESET, 0);
+	return snd_soc_component_write(component, WM8776_RESET, 0);
 }
 
 static const DECLARE_TLV_DB_SCALE(hp_tlv, -12100, 100, 1);
@@ -166,7 +166,7 @@ static const struct snd_soc_dapm_route routes[] = {
 
 static int wm8776_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
-	struct snd_soc_codec *codec = dai->codec;
+	struct snd_soc_component *component = dai->component;
 	int reg, iface, master;
 
 	switch (dai->driver->id) {
@@ -224,8 +224,8 @@ static int wm8776_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	}
 
 	/* Finally, write out the values */
-	snd_soc_update_bits(codec, reg, 0xf, iface);
-	snd_soc_update_bits(codec, WM8776_MSTRCTRL, 0x180, master);
+	snd_soc_component_update_bits(component, reg, 0xf, iface);
+	snd_soc_component_update_bits(component, WM8776_MSTRCTRL, 0x180, master);
 
 	return 0;
 }
@@ -243,8 +243,8 @@ static int wm8776_hw_params(struct snd_pcm_substream *substream,
 			    struct snd_pcm_hw_params *params,
 			    struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct wm8776_priv *wm8776 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct wm8776_priv *wm8776 = snd_soc_component_get_drvdata(component);
 	int iface_reg, iface;
 	int ratio_shift, master;
 	int i;
@@ -279,13 +279,13 @@ static int wm8776_hw_params(struct snd_pcm_substream *substream,
 		iface = 0x30;
 		break;
 	default:
-		dev_err(codec->dev, "Unsupported sample size: %i\n",
+		dev_err(component->dev, "Unsupported sample size: %i\n",
 			params_width(params));
 		return -EINVAL;
 	}
 
 	/* Only need to set MCLK/LRCLK ratio if we're master */
-	if (snd_soc_read(codec, WM8776_MSTRCTRL) & master) {
+	if (snd_soc_component_read32(component, WM8776_MSTRCTRL) & master) {
 		for (i = 0; i < ARRAY_SIZE(mclk_ratios); i++) {
 			if (wm8776->sysclk[dai->driver->id] / params_rate(params)
 			    == mclk_ratios[i])
@@ -293,37 +293,37 @@ static int wm8776_hw_params(struct snd_pcm_substream *substream,
 		}
 
 		if (i == ARRAY_SIZE(mclk_ratios)) {
-			dev_err(codec->dev,
+			dev_err(component->dev,
 				"Unable to configure MCLK ratio %d/%d\n",
 				wm8776->sysclk[dai->driver->id], params_rate(params));
 			return -EINVAL;
 		}
 
-		dev_dbg(codec->dev, "MCLK is %dfs\n", mclk_ratios[i]);
+		dev_dbg(component->dev, "MCLK is %dfs\n", mclk_ratios[i]);
 
-		snd_soc_update_bits(codec, WM8776_MSTRCTRL,
+		snd_soc_component_update_bits(component, WM8776_MSTRCTRL,
 				    0x7 << ratio_shift, i << ratio_shift);
 	} else {
-		dev_dbg(codec->dev, "DAI in slave mode\n");
+		dev_dbg(component->dev, "DAI in slave mode\n");
 	}
 
-	snd_soc_update_bits(codec, iface_reg, 0x30, iface);
+	snd_soc_component_update_bits(component, iface_reg, 0x30, iface);
 
 	return 0;
 }
 
 static int wm8776_mute(struct snd_soc_dai *dai, int mute)
 {
-	struct snd_soc_codec *codec = dai->codec;
+	struct snd_soc_component *component = dai->component;
 
-	return snd_soc_write(codec, WM8776_DACMUTE, !!mute);
+	return snd_soc_component_write(component, WM8776_DACMUTE, !!mute);
 }
 
 static int wm8776_set_sysclk(struct snd_soc_dai *dai,
 			     int clk_id, unsigned int freq, int dir)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct wm8776_priv *wm8776 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct wm8776_priv *wm8776 = snd_soc_component_get_drvdata(component);
 
 	if (WARN_ON(dai->driver->id >= ARRAY_SIZE(wm8776->sysclk)))
 		return -EINVAL;
@@ -333,10 +333,10 @@ static int wm8776_set_sysclk(struct snd_soc_dai *dai,
 	return 0;
 }
 
-static int wm8776_set_bias_level(struct snd_soc_codec *codec,
+static int wm8776_set_bias_level(struct snd_soc_component *component,
 				 enum snd_soc_bias_level level)
 {
-	struct wm8776_priv *wm8776 = snd_soc_codec_get_drvdata(codec);
+	struct wm8776_priv *wm8776 = snd_soc_component_get_drvdata(component);
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
@@ -344,16 +344,16 @@ static int wm8776_set_bias_level(struct snd_soc_codec *codec,
 	case SND_SOC_BIAS_PREPARE:
 		break;
 	case SND_SOC_BIAS_STANDBY:
-		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_OFF) {
+		if (snd_soc_component_get_bias_level(component) == SND_SOC_BIAS_OFF) {
 			regcache_sync(wm8776->regmap);
 
 			/* Disable the global powerdown; DAPM does the rest */
-			snd_soc_update_bits(codec, WM8776_PWRDOWN, 1, 0);
+			snd_soc_component_update_bits(component, WM8776_PWRDOWN, 1, 0);
 		}
 
 		break;
 	case SND_SOC_BIAS_OFF:
-		snd_soc_update_bits(codec, WM8776_PWRDOWN, 1, 1);
+		snd_soc_component_update_bits(component, WM8776_PWRDOWN, 1, 1);
 		break;
 	}
 
@@ -407,37 +407,38 @@ static struct snd_soc_dai_driver wm8776_dai[] = {
 	},
 };
 
-static int wm8776_probe(struct snd_soc_codec *codec)
+static int wm8776_probe(struct snd_soc_component *component)
 {
 	int ret = 0;
 
-	ret = wm8776_reset(codec);
+	ret = wm8776_reset(component);
 	if (ret < 0) {
-		dev_err(codec->dev, "Failed to issue reset: %d\n", ret);
+		dev_err(component->dev, "Failed to issue reset: %d\n", ret);
 		return ret;
 	}
 
 	/* Latch the update bits; right channel only since we always
 	 * update both. */
-	snd_soc_update_bits(codec, WM8776_HPRVOL, 0x100, 0x100);
-	snd_soc_update_bits(codec, WM8776_DACRVOL, 0x100, 0x100);
+	snd_soc_component_update_bits(component, WM8776_HPRVOL, 0x100, 0x100);
+	snd_soc_component_update_bits(component, WM8776_DACRVOL, 0x100, 0x100);
 
 	return ret;
 }
 
-static const struct snd_soc_codec_driver soc_codec_dev_wm8776 = {
-	.probe = 	wm8776_probe,
-	.set_bias_level = wm8776_set_bias_level,
-	.suspend_bias_off = true,
-
-	.component_driver = {
-		.controls		= wm8776_snd_controls,
-		.num_controls		= ARRAY_SIZE(wm8776_snd_controls),
-		.dapm_widgets		= wm8776_dapm_widgets,
-		.num_dapm_widgets	= ARRAY_SIZE(wm8776_dapm_widgets),
-		.dapm_routes		= routes,
-		.num_dapm_routes	= ARRAY_SIZE(routes),
-	},
+static const struct snd_soc_component_driver soc_component_dev_wm8776 = {
+	.probe			= wm8776_probe,
+	.set_bias_level		= wm8776_set_bias_level,
+	.controls		= wm8776_snd_controls,
+	.num_controls		= ARRAY_SIZE(wm8776_snd_controls),
+	.dapm_widgets		= wm8776_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(wm8776_dapm_widgets),
+	.dapm_routes		= routes,
+	.num_dapm_routes	= ARRAY_SIZE(routes),
+	.suspend_bias_off	= 1,
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 static const struct of_device_id wm8776_of_match[] = {
@@ -475,25 +476,18 @@ static int wm8776_spi_probe(struct spi_device *spi)
 
 	spi_set_drvdata(spi, wm8776);
 
-	ret = snd_soc_register_codec(&spi->dev,
-			&soc_codec_dev_wm8776, wm8776_dai, ARRAY_SIZE(wm8776_dai));
+	ret = devm_snd_soc_register_component(&spi->dev,
+			&soc_component_dev_wm8776, wm8776_dai, ARRAY_SIZE(wm8776_dai));
 
 	return ret;
 }
 
-static int wm8776_spi_remove(struct spi_device *spi)
-{
-	snd_soc_unregister_codec(&spi->dev);
-	return 0;
-}
-
 static struct spi_driver wm8776_spi_driver = {
 	.driver = {
 		.name	= "wm8776",
 		.of_match_table = wm8776_of_match,
 	},
 	.probe		= wm8776_spi_probe,
-	.remove		= wm8776_spi_remove,
 };
 #endif /* CONFIG_SPI_MASTER */
 
@@ -515,18 +509,12 @@ static int wm8776_i2c_probe(struct i2c_client *i2c,
 
 	i2c_set_clientdata(i2c, wm8776);
 
-	ret =  snd_soc_register_codec(&i2c->dev,
-			&soc_codec_dev_wm8776, wm8776_dai, ARRAY_SIZE(wm8776_dai));
+	ret = devm_snd_soc_register_component(&i2c->dev,
+			&soc_component_dev_wm8776, wm8776_dai, ARRAY_SIZE(wm8776_dai));
 
 	return ret;
 }
 
-static int wm8776_i2c_remove(struct i2c_client *client)
-{
-	snd_soc_unregister_codec(&client->dev);
-	return 0;
-}
-
 static const struct i2c_device_id wm8776_i2c_id[] = {
 	{ "wm8775", WM8775 },
 	{ "wm8776", WM8776 },
@@ -540,7 +528,6 @@ static struct i2c_driver wm8776_i2c_driver = {
 		.of_match_table = wm8776_of_match,
 	},
 	.probe =    wm8776_i2c_probe,
-	.remove =   wm8776_i2c_remove,
 	.id_table = wm8776_i2c_id,
 };
 #endif
-- 
2.16.1
