From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8737: replace codec to component" to
	the asoc tree
Date: Mon, 12 Feb 2018 12:50:42 +0000
Message-ID: <E1elDZC-0006G0-8K@debutante>
References: <87wp014bea.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 926AC268026
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:50:44 +0100 (CET)
In-Reply-To: <87wp014bea.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: wm8737: replace codec to component

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

>From 840680dcc29e2d9b49aee0f2910e8e22cfdf0709 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 03:01:57 +0000
Subject: [PATCH] ASoC: wm8737: replace codec to component

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
 sound/soc/codecs/wm8737.c | 109 ++++++++++++++++++++--------------------------
 1 file changed, 47 insertions(+), 62 deletions(-)

diff --git a/sound/soc/codecs/wm8737.c b/sound/soc/codecs/wm8737.c
index f0cb1c4afe3c..e9ae821e7609 100644
--- a/sound/soc/codecs/wm8737.c
+++ b/sound/soc/codecs/wm8737.c
@@ -74,9 +74,9 @@ static bool wm8737_volatile(struct device *dev, unsigned int reg)
 	}
 }
 
-static int wm8737_reset(struct snd_soc_codec *codec)
+static int wm8737_reset(struct snd_soc_component *component)
 {
-	return snd_soc_write(codec, WM8737_RESET, 0);
+	return snd_soc_component_write(component, WM8737_RESET, 0);
 }
 
 static const DECLARE_TLV_DB_RANGE(micboost_tlv,
@@ -328,8 +328,8 @@ static int wm8737_hw_params(struct snd_pcm_substream *substream,
 			    struct snd_pcm_hw_params *params,
 			    struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct wm8737_priv *wm8737 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct wm8737_priv *wm8737 = snd_soc_component_get_drvdata(component);
 	int i;
 	u16 clocking = 0;
 	u16 af = 0;
@@ -348,7 +348,7 @@ static int wm8737_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	if (i == ARRAY_SIZE(coeff_div)) {
-		dev_err(codec->dev, "%dHz MCLK can't support %dHz\n",
+		dev_err(component->dev, "%dHz MCLK can't support %dHz\n",
 			wm8737->mclk, params_rate(params));
 		return -EINVAL;
 	}
@@ -371,8 +371,8 @@ static int wm8737_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	snd_soc_update_bits(codec, WM8737_AUDIO_FORMAT, WM8737_WL_MASK, af);
-	snd_soc_update_bits(codec, WM8737_CLOCKING,
+	snd_soc_component_update_bits(component, WM8737_AUDIO_FORMAT, WM8737_WL_MASK, af);
+	snd_soc_component_update_bits(component, WM8737_CLOCKING,
 			    WM8737_USB_MODE | WM8737_CLKDIV2 | WM8737_SR_MASK,
 			    clocking);
 
@@ -382,8 +382,8 @@ static int wm8737_hw_params(struct snd_pcm_substream *substream,
 static int wm8737_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 				 int clk_id, unsigned int freq, int dir)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
-	struct wm8737_priv *wm8737 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = codec_dai->component;
+	struct wm8737_priv *wm8737 = snd_soc_component_get_drvdata(component);
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(coeff_div); i++) {
@@ -394,7 +394,7 @@ static int wm8737_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 		}
 	}
 
-	dev_err(codec->dev, "MCLK rate %dHz not supported\n", freq);
+	dev_err(component->dev, "MCLK rate %dHz not supported\n", freq);
 
 	return -EINVAL;
 }
@@ -403,7 +403,7 @@ static int wm8737_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 static int wm8737_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		unsigned int fmt)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
+	struct snd_soc_component *component = codec_dai->component;
 	u16 af = 0;
 
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
@@ -445,16 +445,16 @@ static int wm8737_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		return -EINVAL;
 	}
 
-	snd_soc_update_bits(codec, WM8737_AUDIO_FORMAT,
+	snd_soc_component_update_bits(component, WM8737_AUDIO_FORMAT,
 			    WM8737_FORMAT_MASK | WM8737_LRP | WM8737_MS, af);
 
 	return 0;
 }
 
-static int wm8737_set_bias_level(struct snd_soc_codec *codec,
+static int wm8737_set_bias_level(struct snd_soc_component *component,
 				 enum snd_soc_bias_level level)
 {
-	struct wm8737_priv *wm8737 = snd_soc_codec_get_drvdata(codec);
+	struct wm8737_priv *wm8737 = snd_soc_component_get_drvdata(component);
 	int ret;
 
 	switch (level) {
@@ -463,16 +463,16 @@ static int wm8737_set_bias_level(struct snd_soc_codec *codec,
 
 	case SND_SOC_BIAS_PREPARE:
 		/* VMID at 2*75k */
-		snd_soc_update_bits(codec, WM8737_MISC_BIAS_CONTROL,
+		snd_soc_component_update_bits(component, WM8737_MISC_BIAS_CONTROL,
 				    WM8737_VMIDSEL_MASK, 0);
 		break;
 
 	case SND_SOC_BIAS_STANDBY:
-		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_OFF) {
+		if (snd_soc_component_get_bias_level(component) == SND_SOC_BIAS_OFF) {
 			ret = regulator_bulk_enable(ARRAY_SIZE(wm8737->supplies),
 						    wm8737->supplies);
 			if (ret != 0) {
-				dev_err(codec->dev,
+				dev_err(component->dev,
 					"Failed to enable supplies: %d\n",
 					ret);
 				return ret;
@@ -481,12 +481,12 @@ static int wm8737_set_bias_level(struct snd_soc_codec *codec,
 			regcache_sync(wm8737->regmap);
 
 			/* Fast VMID ramp at 2*2.5k */
-			snd_soc_update_bits(codec, WM8737_MISC_BIAS_CONTROL,
+			snd_soc_component_update_bits(component, WM8737_MISC_BIAS_CONTROL,
 					    WM8737_VMIDSEL_MASK,
 					    2 << WM8737_VMIDSEL_SHIFT);
 
 			/* Bring VMID up */
-			snd_soc_update_bits(codec, WM8737_POWER_MANAGEMENT,
+			snd_soc_component_update_bits(component, WM8737_POWER_MANAGEMENT,
 					    WM8737_VMID_MASK |
 					    WM8737_VREF_MASK,
 					    WM8737_VMID_MASK |
@@ -496,14 +496,14 @@ static int wm8737_set_bias_level(struct snd_soc_codec *codec,
 		}
 
 		/* VMID at 2*300k */
-		snd_soc_update_bits(codec, WM8737_MISC_BIAS_CONTROL,
+		snd_soc_component_update_bits(component, WM8737_MISC_BIAS_CONTROL,
 				    WM8737_VMIDSEL_MASK,
 				    1 << WM8737_VMIDSEL_SHIFT);
 
 		break;
 
 	case SND_SOC_BIAS_OFF:
-		snd_soc_update_bits(codec, WM8737_POWER_MANAGEMENT,
+		snd_soc_component_update_bits(component, WM8737_POWER_MANAGEMENT,
 				    WM8737_VMID_MASK | WM8737_VREF_MASK, 0);
 
 		regulator_bulk_disable(ARRAY_SIZE(wm8737->supplies),
@@ -537,30 +537,30 @@ static struct snd_soc_dai_driver wm8737_dai = {
 	.ops = &wm8737_dai_ops,
 };
 
-static int wm8737_probe(struct snd_soc_codec *codec)
+static int wm8737_probe(struct snd_soc_component *component)
 {
-	struct wm8737_priv *wm8737 = snd_soc_codec_get_drvdata(codec);
+	struct wm8737_priv *wm8737 = snd_soc_component_get_drvdata(component);
 	int ret;
 
 	ret = regulator_bulk_enable(ARRAY_SIZE(wm8737->supplies),
 				    wm8737->supplies);
 	if (ret != 0) {
-		dev_err(codec->dev, "Failed to enable supplies: %d\n", ret);
+		dev_err(component->dev, "Failed to enable supplies: %d\n", ret);
 		goto err_get;
 	}
 
-	ret = wm8737_reset(codec);
+	ret = wm8737_reset(component);
 	if (ret < 0) {
-		dev_err(codec->dev, "Failed to issue reset\n");
+		dev_err(component->dev, "Failed to issue reset\n");
 		goto err_enable;
 	}
 
-	snd_soc_update_bits(codec, WM8737_LEFT_PGA_VOLUME, WM8737_LVU,
+	snd_soc_component_update_bits(component, WM8737_LEFT_PGA_VOLUME, WM8737_LVU,
 			    WM8737_LVU);
-	snd_soc_update_bits(codec, WM8737_RIGHT_PGA_VOLUME, WM8737_RVU,
+	snd_soc_component_update_bits(component, WM8737_RIGHT_PGA_VOLUME, WM8737_RVU,
 			    WM8737_RVU);
 
-	snd_soc_codec_force_bias_level(codec, SND_SOC_BIAS_STANDBY);
+	snd_soc_component_force_bias_level(component, SND_SOC_BIAS_STANDBY);
 
 	/* Bias level configuration will have done an extra enable */
 	regulator_bulk_disable(ARRAY_SIZE(wm8737->supplies), wm8737->supplies);
@@ -573,19 +573,20 @@ static int wm8737_probe(struct snd_soc_codec *codec)
 	return ret;
 }
 
-static const struct snd_soc_codec_driver soc_codec_dev_wm8737 = {
-	.probe		= wm8737_probe,
-	.set_bias_level = wm8737_set_bias_level,
-	.suspend_bias_off = true,
-
-	.component_driver = {
-		.controls		= wm8737_snd_controls,
-		.num_controls		= ARRAY_SIZE(wm8737_snd_controls),
-		.dapm_widgets		= wm8737_dapm_widgets,
-		.num_dapm_widgets	= ARRAY_SIZE(wm8737_dapm_widgets),
-		.dapm_routes		= intercon,
-		.num_dapm_routes	= ARRAY_SIZE(intercon),
-	},
+static const struct snd_soc_component_driver soc_component_dev_wm8737 = {
+	.probe			= wm8737_probe,
+	.set_bias_level		= wm8737_set_bias_level,
+	.controls		= wm8737_snd_controls,
+	.num_controls		= ARRAY_SIZE(wm8737_snd_controls),
+	.dapm_widgets		= wm8737_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(wm8737_dapm_widgets),
+	.dapm_routes		= intercon,
+	.num_dapm_routes	= ARRAY_SIZE(intercon),
+	.suspend_bias_off	= 1,
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 static const struct of_device_id wm8737_of_match[] = {
@@ -635,20 +636,13 @@ static int wm8737_i2c_probe(struct i2c_client *i2c,
 
 	i2c_set_clientdata(i2c, wm8737);
 
-	ret =  snd_soc_register_codec(&i2c->dev,
-				      &soc_codec_dev_wm8737, &wm8737_dai, 1);
+	ret = devm_snd_soc_register_component(&i2c->dev,
+				&soc_component_dev_wm8737, &wm8737_dai, 1);
 
 	return ret;
 
 }
 
-static int wm8737_i2c_remove(struct i2c_client *client)
-{
-	snd_soc_unregister_codec(&client->dev);
-
-	return 0;
-}
-
 static const struct i2c_device_id wm8737_i2c_id[] = {
 	{ "wm8737", 0 },
 	{ }
@@ -661,7 +655,6 @@ static struct i2c_driver wm8737_i2c_driver = {
 		.of_match_table = wm8737_of_match,
 	},
 	.probe =    wm8737_i2c_probe,
-	.remove =   wm8737_i2c_remove,
 	.id_table = wm8737_i2c_id,
 };
 #endif
@@ -693,26 +686,18 @@ static int wm8737_spi_probe(struct spi_device *spi)
 
 	spi_set_drvdata(spi, wm8737);
 
-	ret = snd_soc_register_codec(&spi->dev,
-				     &soc_codec_dev_wm8737, &wm8737_dai, 1);
+	ret = devm_snd_soc_register_component(&spi->dev,
+				&soc_component_dev_wm8737, &wm8737_dai, 1);
 
 	return ret;
 }
 
-static int wm8737_spi_remove(struct spi_device *spi)
-{
-	snd_soc_unregister_codec(&spi->dev);
-
-	return 0;
-}
-
 static struct spi_driver wm8737_spi_driver = {
 	.driver = {
 		.name	= "wm8737",
 		.of_match_table = wm8737_of_match,
 	},
 	.probe		= wm8737_spi_probe,
-	.remove		= wm8737_spi_remove,
 };
 #endif /* CONFIG_SPI_MASTER */
 
-- 
2.16.1
