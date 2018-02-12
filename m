From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8728: replace codec to component" to
	the asoc tree
Date: Mon, 12 Feb 2018 12:49:09 +0000
Message-ID: <E1elDXh-00065u-VM@debutante>
References: <87o9ld4bbm.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 333B0267F35
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:49:12 +0100 (CET)
In-Reply-To: <87o9ld4bbm.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: wm8728: replace codec to component

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

>From 6b41308015b28658d28584bc174aab45e8202fa6 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 03:03:32 +0000
Subject: [PATCH] ASoC: wm8728: replace codec to component

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
 sound/soc/codecs/wm8728.c | 82 ++++++++++++++++++++---------------------------
 1 file changed, 34 insertions(+), 48 deletions(-)

diff --git a/sound/soc/codecs/wm8728.c b/sound/soc/codecs/wm8728.c
index 797cc6e7c70f..839aee35ab56 100644
--- a/sound/soc/codecs/wm8728.c
+++ b/sound/soc/codecs/wm8728.c
@@ -74,13 +74,13 @@ static const struct snd_soc_dapm_route wm8728_intercon[] = {
 
 static int wm8728_mute(struct snd_soc_dai *dai, int mute)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	u16 mute_reg = snd_soc_read(codec, WM8728_DACCTL);
+	struct snd_soc_component *component = dai->component;
+	u16 mute_reg = snd_soc_component_read32(component, WM8728_DACCTL);
 
 	if (mute)
-		snd_soc_write(codec, WM8728_DACCTL, mute_reg | 1);
+		snd_soc_component_write(component, WM8728_DACCTL, mute_reg | 1);
 	else
-		snd_soc_write(codec, WM8728_DACCTL, mute_reg & ~1);
+		snd_soc_component_write(component, WM8728_DACCTL, mute_reg & ~1);
 
 	return 0;
 }
@@ -89,8 +89,8 @@ static int wm8728_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params,
 	struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	u16 dac = snd_soc_read(codec, WM8728_DACCTL);
+	struct snd_soc_component *component = dai->component;
+	u16 dac = snd_soc_component_read32(component, WM8728_DACCTL);
 
 	dac &= ~0x18;
 
@@ -107,7 +107,7 @@ static int wm8728_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	snd_soc_write(codec, WM8728_DACCTL, dac);
+	snd_soc_component_write(component, WM8728_DACCTL, dac);
 
 	return 0;
 }
@@ -115,8 +115,8 @@ static int wm8728_hw_params(struct snd_pcm_substream *substream,
 static int wm8728_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		unsigned int fmt)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
-	u16 iface = snd_soc_read(codec, WM8728_IFCTL);
+	struct snd_soc_component *component = codec_dai->component;
+	u16 iface = snd_soc_component_read32(component, WM8728_IFCTL);
 
 	/* Currently only I2S is supported by the driver, though the
 	 * hardware is more flexible.
@@ -156,24 +156,24 @@ static int wm8728_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		return -EINVAL;
 	}
 
-	snd_soc_write(codec, WM8728_IFCTL, iface);
+	snd_soc_component_write(component, WM8728_IFCTL, iface);
 	return 0;
 }
 
-static int wm8728_set_bias_level(struct snd_soc_codec *codec,
+static int wm8728_set_bias_level(struct snd_soc_component *component,
 				 enum snd_soc_bias_level level)
 {
-	struct wm8728_priv *wm8728 = snd_soc_codec_get_drvdata(codec);
+	struct wm8728_priv *wm8728 = snd_soc_component_get_drvdata(component);
 	u16 reg;
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
 	case SND_SOC_BIAS_PREPARE:
 	case SND_SOC_BIAS_STANDBY:
-		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_OFF) {
+		if (snd_soc_component_get_bias_level(component) == SND_SOC_BIAS_OFF) {
 			/* Power everything up... */
-			reg = snd_soc_read(codec, WM8728_DACCTL);
-			snd_soc_write(codec, WM8728_DACCTL, reg & ~0x4);
+			reg = snd_soc_component_read32(component, WM8728_DACCTL);
+			snd_soc_component_write(component, WM8728_DACCTL, reg & ~0x4);
 
 			/* ..then sync in the register cache. */
 			regcache_sync(wm8728->regmap);
@@ -181,8 +181,8 @@ static int wm8728_set_bias_level(struct snd_soc_codec *codec,
 		break;
 
 	case SND_SOC_BIAS_OFF:
-		reg = snd_soc_read(codec, WM8728_DACCTL);
-		snd_soc_write(codec, WM8728_DACCTL, reg | 0x4);
+		reg = snd_soc_component_read32(component, WM8728_DACCTL);
+		snd_soc_component_write(component, WM8728_DACCTL, reg | 0x4);
 		break;
 	}
 	return 0;
@@ -211,18 +211,19 @@ static struct snd_soc_dai_driver wm8728_dai = {
 	.ops = &wm8728_dai_ops,
 };
 
-static const struct snd_soc_codec_driver soc_codec_dev_wm8728 = {
-	.set_bias_level = wm8728_set_bias_level,
-	.suspend_bias_off = true,
-
-	.component_driver = {
-		.controls		= wm8728_snd_controls,
-		.num_controls		= ARRAY_SIZE(wm8728_snd_controls),
-		.dapm_widgets		= wm8728_dapm_widgets,
-		.num_dapm_widgets	= ARRAY_SIZE(wm8728_dapm_widgets),
-		.dapm_routes		= wm8728_intercon,
-		.num_dapm_routes	= ARRAY_SIZE(wm8728_intercon),
-	},
+static const struct snd_soc_component_driver soc_component_dev_wm8728 = {
+	.set_bias_level		= wm8728_set_bias_level,
+	.controls		= wm8728_snd_controls,
+	.num_controls		= ARRAY_SIZE(wm8728_snd_controls),
+	.dapm_widgets		= wm8728_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(wm8728_dapm_widgets),
+	.dapm_routes		= wm8728_intercon,
+	.num_dapm_routes	= ARRAY_SIZE(wm8728_intercon),
+	.suspend_bias_off	= 1,
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 static const struct of_device_id wm8728_of_match[] = {
@@ -258,26 +259,18 @@ static int wm8728_spi_probe(struct spi_device *spi)
 
 	spi_set_drvdata(spi, wm8728);
 
-	ret = snd_soc_register_codec(&spi->dev,
-			&soc_codec_dev_wm8728, &wm8728_dai, 1);
+	ret = devm_snd_soc_register_component(&spi->dev,
+			&soc_component_dev_wm8728, &wm8728_dai, 1);
 
 	return ret;
 }
 
-static int wm8728_spi_remove(struct spi_device *spi)
-{
-	snd_soc_unregister_codec(&spi->dev);
-
-	return 0;
-}
-
 static struct spi_driver wm8728_spi_driver = {
 	.driver = {
 		.name	= "wm8728",
 		.of_match_table = wm8728_of_match,
 	},
 	.probe		= wm8728_spi_probe,
-	.remove		= wm8728_spi_remove,
 };
 #endif /* CONFIG_SPI_MASTER */
 
@@ -299,18 +292,12 @@ static int wm8728_i2c_probe(struct i2c_client *i2c,
 
 	i2c_set_clientdata(i2c, wm8728);
 
-	ret =  snd_soc_register_codec(&i2c->dev,
-			&soc_codec_dev_wm8728, &wm8728_dai, 1);
+	ret =  devm_snd_soc_register_component(&i2c->dev,
+			&soc_component_dev_wm8728, &wm8728_dai, 1);
 
 	return ret;
 }
 
-static int wm8728_i2c_remove(struct i2c_client *client)
-{
-	snd_soc_unregister_codec(&client->dev);
-	return 0;
-}
-
 static const struct i2c_device_id wm8728_i2c_id[] = {
 	{ "wm8728", 0 },
 	{ }
@@ -323,7 +310,6 @@ static struct i2c_driver wm8728_i2c_driver = {
 		.of_match_table = wm8728_of_match,
 	},
 	.probe =    wm8728_i2c_probe,
-	.remove =   wm8728_i2c_remove,
 	.id_table = wm8728_i2c_id,
 };
 #endif
-- 
2.16.1
