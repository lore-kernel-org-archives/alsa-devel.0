From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8988: replace codec to component" to
	the asoc tree
Date: Mon, 12 Feb 2018 12:47:44 +0000
Message-ID: <E1elDWK-0005ib-5O@debutante>
References: <87607l4b53.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 87886267615
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:47:46 +0100 (CET)
In-Reply-To: <87607l4b53.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: wm8988: replace codec to component

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

>From ab38ff38bc77330c009f918680501b9dc37a9b3e Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 03:07:26 +0000
Subject: [PATCH] ASoC: wm8988: replace codec to component

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
 sound/soc/codecs/wm8988.c | 127 +++++++++++++++++++++-------------------------
 1 file changed, 57 insertions(+), 70 deletions(-)

diff --git a/sound/soc/codecs/wm8988.c b/sound/soc/codecs/wm8988.c
index b0d0219532f2..62200117444b 100644
--- a/sound/soc/codecs/wm8988.c
+++ b/sound/soc/codecs/wm8988.c
@@ -119,7 +119,7 @@ struct wm8988_priv {
 	const struct snd_pcm_hw_constraint_list *sysclk_constraints;
 };
 
-#define wm8988_reset(c)	snd_soc_write(c, WM8988_RESET, 0)
+#define wm8988_reset(c)	snd_soc_component_write(c, WM8988_RESET, 0)
 
 /*
  * WM8988 Controls
@@ -244,16 +244,16 @@ SOC_DOUBLE_R_TLV("Output 2 Playback Volume", WM8988_LOUT2V, WM8988_ROUT2V,
 static int wm8988_lrc_control(struct snd_soc_dapm_widget *w,
 			      struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
-	u16 adctl2 = snd_soc_read(codec, WM8988_ADCTL2);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	u16 adctl2 = snd_soc_component_read32(component, WM8988_ADCTL2);
 
 	/* Use the DAC to gate LRC if active, otherwise use ADC */
-	if (snd_soc_read(codec, WM8988_PWR2) & 0x180)
+	if (snd_soc_component_read32(component, WM8988_PWR2) & 0x180)
 		adctl2 &= ~0x4;
 	else
 		adctl2 |= 0x4;
 
-	return snd_soc_write(codec, WM8988_ADCTL2, adctl2);
+	return snd_soc_component_write(component, WM8988_ADCTL2, adctl2);
 }
 
 static const char *wm8988_line_texts[] = {
@@ -555,8 +555,8 @@ static const struct snd_pcm_hw_constraint_list constraints_12 = {
 static int wm8988_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 		int clk_id, unsigned int freq, int dir)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
-	struct wm8988_priv *wm8988 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = codec_dai->component;
+	struct wm8988_priv *wm8988 = snd_soc_component_get_drvdata(component);
 
 	switch (freq) {
 	case 11289600:
@@ -587,7 +587,7 @@ static int wm8988_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 static int wm8988_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		unsigned int fmt)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
+	struct snd_soc_component *component = codec_dai->component;
 	u16 iface = 0;
 
 	/* set master/slave audio interface */
@@ -638,21 +638,21 @@ static int wm8988_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		return -EINVAL;
 	}
 
-	snd_soc_write(codec, WM8988_IFACE, iface);
+	snd_soc_component_write(component, WM8988_IFACE, iface);
 	return 0;
 }
 
 static int wm8988_pcm_startup(struct snd_pcm_substream *substream,
 			      struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct wm8988_priv *wm8988 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct wm8988_priv *wm8988 = snd_soc_component_get_drvdata(component);
 
 	/* The set of sample rates that can be supported depends on the
 	 * MCLK supplied to the CODEC - enforce this.
 	 */
 	if (!wm8988->sysclk) {
-		dev_err(codec->dev,
+		dev_err(component->dev,
 			"No MCLK configured, call set_sysclk() on init\n");
 		return -EINVAL;
 	}
@@ -668,10 +668,10 @@ static int wm8988_pcm_hw_params(struct snd_pcm_substream *substream,
 				struct snd_pcm_hw_params *params,
 				struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct wm8988_priv *wm8988 = snd_soc_codec_get_drvdata(codec);
-	u16 iface = snd_soc_read(codec, WM8988_IFACE) & 0x1f3;
-	u16 srate = snd_soc_read(codec, WM8988_SRATE) & 0x180;
+	struct snd_soc_component *component = dai->component;
+	struct wm8988_priv *wm8988 = snd_soc_component_get_drvdata(component);
+	u16 iface = snd_soc_component_read32(component, WM8988_IFACE) & 0x1f3;
+	u16 srate = snd_soc_component_read32(component, WM8988_SRATE) & 0x180;
 	int coeff;
 
 	coeff = get_coeff(wm8988->sysclk, params_rate(params));
@@ -680,7 +680,7 @@ static int wm8988_pcm_hw_params(struct snd_pcm_substream *substream,
 		srate |= 0x40;
 	}
 	if (coeff < 0) {
-		dev_err(codec->dev,
+		dev_err(component->dev,
 			"Unable to configure sample rate %dHz with %dHz MCLK\n",
 			params_rate(params), wm8988->sysclk);
 		return coeff;
@@ -702,9 +702,9 @@ static int wm8988_pcm_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	/* set iface & srate */
-	snd_soc_write(codec, WM8988_IFACE, iface);
+	snd_soc_component_write(component, WM8988_IFACE, iface);
 	if (coeff >= 0)
-		snd_soc_write(codec, WM8988_SRATE, srate |
+		snd_soc_component_write(component, WM8988_SRATE, srate |
 			(coeff_div[coeff].sr << 1) | coeff_div[coeff].usb);
 
 	return 0;
@@ -712,21 +712,21 @@ static int wm8988_pcm_hw_params(struct snd_pcm_substream *substream,
 
 static int wm8988_mute(struct snd_soc_dai *dai, int mute)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	u16 mute_reg = snd_soc_read(codec, WM8988_ADCDAC) & 0xfff7;
+	struct snd_soc_component *component = dai->component;
+	u16 mute_reg = snd_soc_component_read32(component, WM8988_ADCDAC) & 0xfff7;
 
 	if (mute)
-		snd_soc_write(codec, WM8988_ADCDAC, mute_reg | 0x8);
+		snd_soc_component_write(component, WM8988_ADCDAC, mute_reg | 0x8);
 	else
-		snd_soc_write(codec, WM8988_ADCDAC, mute_reg);
+		snd_soc_component_write(component, WM8988_ADCDAC, mute_reg);
 	return 0;
 }
 
-static int wm8988_set_bias_level(struct snd_soc_codec *codec,
+static int wm8988_set_bias_level(struct snd_soc_component *component,
 				 enum snd_soc_bias_level level)
 {
-	struct wm8988_priv *wm8988 = snd_soc_codec_get_drvdata(codec);
-	u16 pwr_reg = snd_soc_read(codec, WM8988_PWR1) & ~0x1c1;
+	struct wm8988_priv *wm8988 = snd_soc_component_get_drvdata(component);
+	u16 pwr_reg = snd_soc_component_read32(component, WM8988_PWR1) & ~0x1c1;
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
@@ -734,26 +734,26 @@ static int wm8988_set_bias_level(struct snd_soc_codec *codec,
 
 	case SND_SOC_BIAS_PREPARE:
 		/* VREF, VMID=2x50k, digital enabled */
-		snd_soc_write(codec, WM8988_PWR1, pwr_reg | 0x00c0);
+		snd_soc_component_write(component, WM8988_PWR1, pwr_reg | 0x00c0);
 		break;
 
 	case SND_SOC_BIAS_STANDBY:
-		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_OFF) {
+		if (snd_soc_component_get_bias_level(component) == SND_SOC_BIAS_OFF) {
 			regcache_sync(wm8988->regmap);
 
 			/* VREF, VMID=2x5k */
-			snd_soc_write(codec, WM8988_PWR1, pwr_reg | 0x1c1);
+			snd_soc_component_write(component, WM8988_PWR1, pwr_reg | 0x1c1);
 
 			/* Charge caps */
 			msleep(100);
 		}
 
 		/* VREF, VMID=2*500k, digital stopped */
-		snd_soc_write(codec, WM8988_PWR1, pwr_reg | 0x0141);
+		snd_soc_component_write(component, WM8988_PWR1, pwr_reg | 0x0141);
 		break;
 
 	case SND_SOC_BIAS_OFF:
-		snd_soc_write(codec, WM8988_PWR1, 0x0000);
+		snd_soc_component_write(component, WM8988_PWR1, 0x0000);
 		break;
 	}
 	return 0;
@@ -792,39 +792,40 @@ static struct snd_soc_dai_driver wm8988_dai = {
 	.symmetric_rates = 1,
 };
 
-static int wm8988_probe(struct snd_soc_codec *codec)
+static int wm8988_probe(struct snd_soc_component *component)
 {
 	int ret = 0;
 
-	ret = wm8988_reset(codec);
+	ret = wm8988_reset(component);
 	if (ret < 0) {
-		dev_err(codec->dev, "Failed to issue reset\n");
+		dev_err(component->dev, "Failed to issue reset\n");
 		return ret;
 	}
 
 	/* set the update bits (we always update left then right) */
-	snd_soc_update_bits(codec, WM8988_RADC, 0x0100, 0x0100);
-	snd_soc_update_bits(codec, WM8988_RDAC, 0x0100, 0x0100);
-	snd_soc_update_bits(codec, WM8988_ROUT1V, 0x0100, 0x0100);
-	snd_soc_update_bits(codec, WM8988_ROUT2V, 0x0100, 0x0100);
-	snd_soc_update_bits(codec, WM8988_RINVOL, 0x0100, 0x0100);
+	snd_soc_component_update_bits(component, WM8988_RADC, 0x0100, 0x0100);
+	snd_soc_component_update_bits(component, WM8988_RDAC, 0x0100, 0x0100);
+	snd_soc_component_update_bits(component, WM8988_ROUT1V, 0x0100, 0x0100);
+	snd_soc_component_update_bits(component, WM8988_ROUT2V, 0x0100, 0x0100);
+	snd_soc_component_update_bits(component, WM8988_RINVOL, 0x0100, 0x0100);
 
 	return 0;
 }
 
-static const struct snd_soc_codec_driver soc_codec_dev_wm8988 = {
-	.probe =	wm8988_probe,
-	.set_bias_level = wm8988_set_bias_level,
-	.suspend_bias_off = true,
-
-	.component_driver = {
-		.controls		= wm8988_snd_controls,
-		.num_controls		= ARRAY_SIZE(wm8988_snd_controls),
-		.dapm_widgets		= wm8988_dapm_widgets,
-		.num_dapm_widgets	= ARRAY_SIZE(wm8988_dapm_widgets),
-		.dapm_routes		= wm8988_dapm_routes,
-		.num_dapm_routes	= ARRAY_SIZE(wm8988_dapm_routes),
-	},
+static const struct snd_soc_component_driver soc_component_dev_wm8988 = {
+	.probe			= wm8988_probe,
+	.set_bias_level		= wm8988_set_bias_level,
+	.controls		= wm8988_snd_controls,
+	.num_controls		= ARRAY_SIZE(wm8988_snd_controls),
+	.dapm_widgets		= wm8988_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(wm8988_dapm_widgets),
+	.dapm_routes		= wm8988_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(wm8988_dapm_routes),
+	.suspend_bias_off	= 1,
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 static const struct regmap_config wm8988_regmap = {
@@ -859,23 +860,16 @@ static int wm8988_spi_probe(struct spi_device *spi)
 
 	spi_set_drvdata(spi, wm8988);
 
-	ret = snd_soc_register_codec(&spi->dev,
-			&soc_codec_dev_wm8988, &wm8988_dai, 1);
+	ret = devm_snd_soc_register_component(&spi->dev,
+			&soc_component_dev_wm8988, &wm8988_dai, 1);
 	return ret;
 }
 
-static int wm8988_spi_remove(struct spi_device *spi)
-{
-	snd_soc_unregister_codec(&spi->dev);
-	return 0;
-}
-
 static struct spi_driver wm8988_spi_driver = {
 	.driver = {
 		.name	= "wm8988",
 	},
 	.probe		= wm8988_spi_probe,
-	.remove		= wm8988_spi_remove,
 };
 #endif /* CONFIG_SPI_MASTER */
 
@@ -900,17 +894,11 @@ static int wm8988_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
-	ret =  snd_soc_register_codec(&i2c->dev,
-			&soc_codec_dev_wm8988, &wm8988_dai, 1);
+	ret = devm_snd_soc_register_component(&i2c->dev,
+			&soc_component_dev_wm8988, &wm8988_dai, 1);
 	return ret;
 }
 
-static int wm8988_i2c_remove(struct i2c_client *client)
-{
-	snd_soc_unregister_codec(&client->dev);
-	return 0;
-}
-
 static const struct i2c_device_id wm8988_i2c_id[] = {
 	{ "wm8988", 0 },
 	{ }
@@ -922,7 +910,6 @@ static struct i2c_driver wm8988_i2c_driver = {
 		.name = "wm8988",
 	},
 	.probe =    wm8988_i2c_probe,
-	.remove =   wm8988_i2c_remove,
 	.id_table = wm8988_i2c_id,
 };
 #endif
-- 
2.16.1
