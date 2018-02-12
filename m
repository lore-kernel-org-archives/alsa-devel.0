From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8731: replace codec to component" to
	the asoc tree
Date: Mon, 12 Feb 2018 12:49:42 +0000
Message-ID: <E1elDYE-00068x-Vl@debutante>
References: <87r2q94bch.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 4DC20267F87
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:49:45 +0100 (CET)
In-Reply-To: <87r2q94bch.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: wm8731: replace codec to component

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

>From cde596c7c07343789e3e0f1c09fc7d3c756c88d0 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 03:03:01 +0000
Subject: [PATCH] ASoC: wm8731: replace codec to component

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
 sound/soc/codecs/wm8731.c | 101 +++++++++++++++++++++++-----------------------
 1 file changed, 50 insertions(+), 51 deletions(-)

diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
index 4f9a1eb28120..7c8fad865d6b 100644
--- a/sound/soc/codecs/wm8731.c
+++ b/sound/soc/codecs/wm8731.c
@@ -88,9 +88,9 @@ static SOC_ENUM_SINGLE_DECL(wm8731_insel_enum,
 
 static int wm8731_deemph[] = { 0, 32000, 44100, 48000 };
 
-static int wm8731_set_deemph(struct snd_soc_codec *codec)
+static int wm8731_set_deemph(struct snd_soc_component *component)
 {
-	struct wm8731_priv *wm8731 = snd_soc_codec_get_drvdata(codec);
+	struct wm8731_priv *wm8731 = snd_soc_component_get_drvdata(component);
 	int val, i, best;
 
 	/* If we're using deemphasis select the nearest available sample
@@ -110,17 +110,17 @@ static int wm8731_set_deemph(struct snd_soc_codec *codec)
 		val = 0;
 	}
 
-	dev_dbg(codec->dev, "Set deemphasis %d (%dHz)\n",
+	dev_dbg(component->dev, "Set deemphasis %d (%dHz)\n",
 		best, wm8731_deemph[best]);
 
-	return snd_soc_update_bits(codec, WM8731_APDIGI, 0x6, val);
+	return snd_soc_component_update_bits(component, WM8731_APDIGI, 0x6, val);
 }
 
 static int wm8731_get_deemph(struct snd_kcontrol *kcontrol,
 			     struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
-	struct wm8731_priv *wm8731 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct wm8731_priv *wm8731 = snd_soc_component_get_drvdata(component);
 
 	ucontrol->value.integer.value[0] = wm8731->deemph;
 
@@ -130,8 +130,8 @@ static int wm8731_get_deemph(struct snd_kcontrol *kcontrol,
 static int wm8731_put_deemph(struct snd_kcontrol *kcontrol,
 			     struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
-	struct wm8731_priv *wm8731 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct wm8731_priv *wm8731 = snd_soc_component_get_drvdata(component);
 	unsigned int deemph = ucontrol->value.integer.value[0];
 	int ret = 0;
 
@@ -142,7 +142,7 @@ static int wm8731_put_deemph(struct snd_kcontrol *kcontrol,
 	if (wm8731->deemph != deemph) {
 		wm8731->deemph = deemph;
 
-		wm8731_set_deemph(codec);
+		wm8731_set_deemph(component);
 
 		ret = 1;
 	}
@@ -214,8 +214,8 @@ SND_SOC_DAPM_INPUT("LLINEIN"),
 static int wm8731_check_osc(struct snd_soc_dapm_widget *source,
 			    struct snd_soc_dapm_widget *sink)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(source->dapm);
-	struct wm8731_priv *wm8731 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(source->dapm);
+	struct wm8731_priv *wm8731 = snd_soc_component_get_drvdata(component);
 
 	return wm8731->sysclk_type == WM8731_SYSCLK_XTAL;
 }
@@ -337,16 +337,16 @@ static int wm8731_hw_params(struct snd_pcm_substream *substream,
 			    struct snd_pcm_hw_params *params,
 			    struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct wm8731_priv *wm8731 = snd_soc_codec_get_drvdata(codec);
-	u16 iface = snd_soc_read(codec, WM8731_IFACE) & 0xfff3;
+	struct snd_soc_component *component = dai->component;
+	struct wm8731_priv *wm8731 = snd_soc_component_get_drvdata(component);
+	u16 iface = snd_soc_component_read32(component, WM8731_IFACE) & 0xfff3;
 	int i = get_coeff(wm8731->sysclk, params_rate(params));
 	u16 srate = (coeff_div[i].sr << 2) |
 		(coeff_div[i].bosr << 1) | coeff_div[i].usb;
 
 	wm8731->playback_fs = params_rate(params);
 
-	snd_soc_write(codec, WM8731_SRATE, srate);
+	snd_soc_component_write(component, WM8731_SRATE, srate);
 
 	/* bit size */
 	switch (params_width(params)) {
@@ -363,30 +363,30 @@ static int wm8731_hw_params(struct snd_pcm_substream *substream,
 		break;
 	}
 
-	wm8731_set_deemph(codec);
+	wm8731_set_deemph(component);
 
-	snd_soc_write(codec, WM8731_IFACE, iface);
+	snd_soc_component_write(component, WM8731_IFACE, iface);
 	return 0;
 }
 
 static int wm8731_mute(struct snd_soc_dai *dai, int mute)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	u16 mute_reg = snd_soc_read(codec, WM8731_APDIGI) & 0xfff7;
+	struct snd_soc_component *component = dai->component;
+	u16 mute_reg = snd_soc_component_read32(component, WM8731_APDIGI) & 0xfff7;
 
 	if (mute)
-		snd_soc_write(codec, WM8731_APDIGI, mute_reg | 0x8);
+		snd_soc_component_write(component, WM8731_APDIGI, mute_reg | 0x8);
 	else
-		snd_soc_write(codec, WM8731_APDIGI, mute_reg);
+		snd_soc_component_write(component, WM8731_APDIGI, mute_reg);
 	return 0;
 }
 
 static int wm8731_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 		int clk_id, unsigned int freq, int dir)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
-	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
-	struct wm8731_priv *wm8731 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = codec_dai->component;
+	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
+	struct wm8731_priv *wm8731 = snd_soc_component_get_drvdata(component);
 
 	switch (clk_id) {
 	case WM8731_SYSCLK_XTAL:
@@ -429,7 +429,7 @@ static int wm8731_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 static int wm8731_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		unsigned int fmt)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
+	struct snd_soc_component *component = codec_dai->component;
 	u16 iface = 0;
 
 	/* set master/slave audio interface */
@@ -481,14 +481,14 @@ static int wm8731_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	}
 
 	/* set iface */
-	snd_soc_write(codec, WM8731_IFACE, iface);
+	snd_soc_component_write(component, WM8731_IFACE, iface);
 	return 0;
 }
 
-static int wm8731_set_bias_level(struct snd_soc_codec *codec,
+static int wm8731_set_bias_level(struct snd_soc_component *component,
 				 enum snd_soc_bias_level level)
 {
-	struct wm8731_priv *wm8731 = snd_soc_codec_get_drvdata(codec);
+	struct wm8731_priv *wm8731 = snd_soc_component_get_drvdata(component);
 	int ret;
 	u16 reg;
 
@@ -503,7 +503,7 @@ static int wm8731_set_bias_level(struct snd_soc_codec *codec,
 	case SND_SOC_BIAS_PREPARE:
 		break;
 	case SND_SOC_BIAS_STANDBY:
-		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_OFF) {
+		if (snd_soc_component_get_bias_level(component) == SND_SOC_BIAS_OFF) {
 			ret = regulator_bulk_enable(ARRAY_SIZE(wm8731->supplies),
 						    wm8731->supplies);
 			if (ret != 0)
@@ -513,13 +513,13 @@ static int wm8731_set_bias_level(struct snd_soc_codec *codec,
 		}
 
 		/* Clear PWROFF, gate CLKOUT, everything else as-is */
-		reg = snd_soc_read(codec, WM8731_PWR) & 0xff7f;
-		snd_soc_write(codec, WM8731_PWR, reg | 0x0040);
+		reg = snd_soc_component_read32(component, WM8731_PWR) & 0xff7f;
+		snd_soc_component_write(component, WM8731_PWR, reg | 0x0040);
 		break;
 	case SND_SOC_BIAS_OFF:
 		if (wm8731->mclk)
 			clk_disable_unprepare(wm8731->mclk);
-		snd_soc_write(codec, WM8731_PWR, 0xffff);
+		snd_soc_component_write(component, WM8731_PWR, 0xffff);
 		regulator_bulk_disable(ARRAY_SIZE(wm8731->supplies),
 				       wm8731->supplies);
 		regcache_mark_dirty(wm8731->regmap);
@@ -531,7 +531,7 @@ static int wm8731_set_bias_level(struct snd_soc_codec *codec,
 static int wm8731_startup(struct snd_pcm_substream *substream,
 	struct snd_soc_dai *dai)
 {
-	struct wm8731_priv *wm8731 = snd_soc_codec_get_drvdata(dai->codec);
+	struct wm8731_priv *wm8731 = snd_soc_component_get_drvdata(dai->component);
 
 	if (wm8731->constraints)
 		snd_pcm_hw_constraint_list(substream->runtime, 0,
@@ -628,18 +628,19 @@ static int wm8731_hw_init(struct device *dev, struct wm8731_priv *wm8731)
 	return ret;
 }
 
-static const struct snd_soc_codec_driver soc_codec_dev_wm8731 = {
-	.set_bias_level = wm8731_set_bias_level,
-	.suspend_bias_off = true,
-
-	.component_driver = {
-		.controls		= wm8731_snd_controls,
-		.num_controls		= ARRAY_SIZE(wm8731_snd_controls),
-		.dapm_widgets		= wm8731_dapm_widgets,
-		.num_dapm_widgets	= ARRAY_SIZE(wm8731_dapm_widgets),
-		.dapm_routes		= wm8731_intercon,
-		.num_dapm_routes	= ARRAY_SIZE(wm8731_intercon),
-	},
+static const struct snd_soc_component_driver soc_component_dev_wm8731 = {
+	.set_bias_level		= wm8731_set_bias_level,
+	.controls		= wm8731_snd_controls,
+	.num_controls		= ARRAY_SIZE(wm8731_snd_controls),
+	.dapm_widgets		= wm8731_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(wm8731_dapm_widgets),
+	.dapm_routes		= wm8731_intercon,
+	.num_dapm_routes	= ARRAY_SIZE(wm8731_intercon),
+	.suspend_bias_off	= 1,
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 static const struct of_device_id wm8731_of_match[] = {
@@ -704,8 +705,8 @@ static int wm8731_spi_probe(struct spi_device *spi)
 	if (ret != 0)
 		return ret;
 
-	ret = snd_soc_register_codec(&spi->dev,
-			&soc_codec_dev_wm8731, &wm8731_dai, 1);
+	ret = devm_snd_soc_register_component(&spi->dev,
+			&soc_component_dev_wm8731, &wm8731_dai, 1);
 	if (ret != 0) {
 		dev_err(&spi->dev, "Failed to register CODEC: %d\n", ret);
 		return ret;
@@ -716,7 +717,6 @@ static int wm8731_spi_probe(struct spi_device *spi)
 
 static int wm8731_spi_remove(struct spi_device *spi)
 {
-	snd_soc_unregister_codec(&spi->dev);
 	return 0;
 }
 
@@ -775,8 +775,8 @@ static int wm8731_i2c_probe(struct i2c_client *i2c,
 	if (ret != 0)
 		return ret;
 
-	ret = snd_soc_register_codec(&i2c->dev,
-			&soc_codec_dev_wm8731, &wm8731_dai, 1);
+	ret = devm_snd_soc_register_component(&i2c->dev,
+			&soc_component_dev_wm8731, &wm8731_dai, 1);
 	if (ret != 0) {
 		dev_err(&i2c->dev, "Failed to register CODEC: %d\n", ret);
 		return ret;
@@ -787,7 +787,6 @@ static int wm8731_i2c_probe(struct i2c_client *i2c,
 
 static int wm8731_i2c_remove(struct i2c_client *client)
 {
-	snd_soc_unregister_codec(&client->dev);
 	return 0;
 }
 
-- 
2.16.1
