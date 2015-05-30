From: Sergey Kiselev <sergey.kiselev@intel.com>
Subject: [PATCH] ASoC: wm8731: initialize the hardware when
 loading the codec driver; use regmap for I/O
Date: Sat, 30 May 2015 00:34:55 -0700
Message-ID: <20150530003455.4c4d67eb444b1ceb45d3148c@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id A148C2605B8
 for <alsa-devel@alsa-project.org>; Sat, 30 May 2015 09:34:57 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Liam@alsa-project.org, liam.r.girdwood@linux.intel.com, Mark Brown <broonie@kernel.org>, Girdwood@alsa-project.org, Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Hi,

This patch moves the request supplies and hardware reset and initialization
from wm8731_probe to wm8731_i2c_probe and wm8731_spi_probe. So that the
codec hardware is initialized when loading the codec driver, and not when
loading the machine driver.
The I/O is converted to regmap_write and regmap_update_bits. (Mostly as a side
effect, since snd_soc_write and friends won't work before snd_soc_register_codec
is called)

Signed-off-by: Sergey Kiselev <sergey.kiselev@intel.com>
---
 wm8731.c |  107 ++++++++++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 72 insertions(+), 35 deletions(-)

diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
index 2245b6a..05fa4d6 100644
--- a/sound/soc/codecs/wm8731.c
+++ b/sound/soc/codecs/wm8731.c
@@ -84,7 +84,7 @@ static bool wm8731_writeable(struct device *dev, unsigned int reg)
 	return reg <= WM8731_RESET;
 }
 
-#define wm8731_reset(c)	snd_soc_write(c, WM8731_RESET, 0)
+#define wm8731_reset(m)	regmap_write(m, WM8731_RESET, 0)
 
 static const char *wm8731_input_select[] = {"Line In", "Mic"};
 
@@ -118,7 +118,7 @@ static int wm8731_set_deemph(struct snd_soc_codec *codec)
 	dev_dbg(codec->dev, "Set deemphasis %d (%dHz)\n",
 		best, wm8731_deemph[best]);
 
-	return snd_soc_update_bits(codec, WM8731_APDIGI, 0x6, val);
+	return regmap_update_bits(wm8731->regmap, WM8731_APDIGI, 0x6, val);
 }
 
 static int wm8731_get_deemph(struct snd_kcontrol *kcontrol,
@@ -344,7 +344,7 @@ static int wm8731_hw_params(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_codec *codec = dai->codec;
 	struct wm8731_priv *wm8731 = snd_soc_codec_get_drvdata(codec);
-	u16 iface = snd_soc_read(codec, WM8731_IFACE) & 0xfff3;
+	unsigned int format = 0;
 	int i = get_coeff(wm8731->sysclk, params_rate(params));
 	u16 srate = (coeff_div[i].sr << 2) |
 		(coeff_div[i].bosr << 1) | coeff_div[i].usb;
@@ -358,28 +358,27 @@ static int wm8731_hw_params(struct snd_pcm_substream *substream,
 	case 16:
 		break;
 	case 20:
-		iface |= 0x0004;
+		format = 0x4;
 		break;
 	case 24:
-		iface |= 0x0008;
+		format = 0x8;
 		break;
 	}
 
 	wm8731_set_deemph(codec);
 
-	snd_soc_write(codec, WM8731_IFACE, iface);
-	return 0;
+	return regmap_update_bits(wm8731->regmap, WM8731_IFACE, 0x0c, format);
 }
 
 static int wm8731_mute(struct snd_soc_dai *dai, int mute)
 {
 	struct snd_soc_codec *codec = dai->codec;
-	u16 mute_reg = snd_soc_read(codec, WM8731_APDIGI) & 0xfff7;
+	struct wm8731_priv *wm8731 = snd_soc_codec_get_drvdata(codec);
 
 	if (mute)
-		snd_soc_write(codec, WM8731_APDIGI, mute_reg | 0x8);
+		regmap_update_bits(wm8731->regmap, WM8731_APDIGI, 0x8, 0x8);
 	else
-		snd_soc_write(codec, WM8731_APDIGI, mute_reg);
+		regmap_update_bits(wm8731->regmap, WM8731_APDIGI, 0x8, 0);
 	return 0;
 }
 
@@ -431,6 +430,7 @@ static int wm8731_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		unsigned int fmt)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
+	struct wm8731_priv *wm8731 = snd_soc_codec_get_drvdata(codec);
 	u16 iface = 0;
 
 	/* set master/slave audio interface */
@@ -482,7 +482,7 @@ static int wm8731_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	}
 
 	/* set iface */
-	snd_soc_write(codec, WM8731_IFACE, iface);
+	regmap_write(wm8731->regmap, WM8731_IFACE, iface);
 	return 0;
 }
 
@@ -491,7 +491,6 @@ static int wm8731_set_bias_level(struct snd_soc_codec *codec,
 {
 	struct wm8731_priv *wm8731 = snd_soc_codec_get_drvdata(codec);
 	int ret;
-	u16 reg;
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
@@ -511,13 +510,12 @@ static int wm8731_set_bias_level(struct snd_soc_codec *codec,
 		}
 
 		/* Clear PWROFF, gate CLKOUT, everything else as-is */
-		reg = snd_soc_read(codec, WM8731_PWR) & 0xff7f;
-		snd_soc_write(codec, WM8731_PWR, reg | 0x0040);
+		regmap_update_bits(wm8731->regmap, WM8731_PWR, 0xc0, 0x40);
 		break;
 	case SND_SOC_BIAS_OFF:
 		if (wm8731->mclk)
 			clk_disable_unprepare(wm8731->mclk);
-		snd_soc_write(codec, WM8731_PWR, 0xffff);
+		regmap_write(wm8731->regmap, WM8731_PWR, 0xff);
 		regulator_bulk_disable(ARRAY_SIZE(wm8731->supplies),
 				       wm8731->supplies);
 		regcache_mark_dirty(wm8731->regmap);
@@ -573,42 +571,53 @@ static struct snd_soc_dai_driver wm8731_dai = {
 
 static int wm8731_probe(struct snd_soc_codec *codec)
 {
-	struct wm8731_priv *wm8731 = snd_soc_codec_get_drvdata(codec);
-	int ret = 0, i;
+	wm8731_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+
+	return 0;
+}
+
+static int wm8731_request_supplies(struct device *dev,
+		struct wm8731_priv *wm8731)
+{
+	int ret = 0, i ;
 
 	for (i = 0; i < ARRAY_SIZE(wm8731->supplies); i++)
 		wm8731->supplies[i].supply = wm8731_supply_names[i];
 
-	ret = devm_regulator_bulk_get(codec->dev, ARRAY_SIZE(wm8731->supplies),
+	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(wm8731->supplies),
 				 wm8731->supplies);
 	if (ret != 0) {
-		dev_err(codec->dev, "Failed to request supplies: %d\n", ret);
+		dev_err(dev, "Failed to request supplies: %d\n", ret);
 		return ret;
 	}
 
 	ret = regulator_bulk_enable(ARRAY_SIZE(wm8731->supplies),
 				    wm8731->supplies);
 	if (ret != 0) {
-		dev_err(codec->dev, "Failed to enable supplies: %d\n", ret);
+		dev_err(dev, "Failed to enable supplies: %d\n", ret);
 		return ret;
 	}
 
-	ret = wm8731_reset(codec);
+	return 0;
+}
+
+static int wm8731_hw_init(struct device *dev, struct wm8731_priv *wm8731)
+{
+	int ret = 0;
+
+	ret = wm8731_reset(wm8731->regmap);
 	if (ret < 0) {
-		dev_err(codec->dev, "Failed to issue reset: %d\n", ret);
+		dev_err(dev, "Failed to issue reset: %d\n", ret);
 		goto err_regulator_enable;
 	}
 
-	wm8731_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-
-	/* Latch the update bits */
-	snd_soc_update_bits(codec, WM8731_LOUT1V, 0x100, 0);
-	snd_soc_update_bits(codec, WM8731_ROUT1V, 0x100, 0);
-	snd_soc_update_bits(codec, WM8731_LINVOL, 0x100, 0);
-	snd_soc_update_bits(codec, WM8731_RINVOL, 0x100, 0);
+	/* Clear POWEROFF, keep everything else disabled */
+	regmap_write(wm8731->regmap, WM8731_PWR, 0x7f);
 
 	/* Disable bypass path by default */
-	snd_soc_update_bits(codec, WM8731_APANA, 0x8, 0);
+	regmap_update_bits(wm8731->regmap, WM8731_APANA, 0x8, 0);
+
+	regcache_mark_dirty(wm8731->regmap);
 
 	/* Regulators will have been enabled by bias management */
 	regulator_bulk_disable(ARRAY_SIZE(wm8731->supplies), wm8731->supplies);
@@ -624,9 +633,7 @@ err_regulator_enable:
 /* power down chip */
 static int wm8731_remove(struct snd_soc_codec *codec)
 {
-	struct wm8731_priv *wm8731 = snd_soc_codec_get_drvdata(codec);
-
-	regulator_bulk_disable(ARRAY_SIZE(wm8731->supplies), wm8731->supplies);
+	wm8731_set_bias_level(codec, SND_SOC_BIAS_OFF);
 
 	return 0;
 }
@@ -690,6 +697,13 @@ static int wm8731_spi_probe(struct spi_device *spi)
 
 	mutex_init(&wm8731->lock);
 
+	spi_set_drvdata(spi, wm8731);
+
+	ret = wm8731_request_supplies(&spi->dev, wm8731);
+	if (ret != 0) {
+		return ret;
+	}
+
 	wm8731->regmap = devm_regmap_init_spi(spi, &wm8731_regmap);
 	if (IS_ERR(wm8731->regmap)) {
 		ret = PTR_ERR(wm8731->regmap);
@@ -698,7 +712,10 @@ static int wm8731_spi_probe(struct spi_device *spi)
 		return ret;
 	}
 
-	spi_set_drvdata(spi, wm8731);
+	ret = wm8731_hw_init(&spi->dev, wm8731);
+	if (ret != 0) {
+		return ret;
+	}
 
 	ret = snd_soc_register_codec(&spi->dev,
 			&soc_codec_dev_wm8731, &wm8731_dai, 1);
@@ -712,7 +729,12 @@ static int wm8731_spi_probe(struct spi_device *spi)
 
 static int wm8731_spi_remove(struct spi_device *spi)
 {
+	struct wm8731_priv *wm8731 = spi_get_drvdata(spi);
+
 	snd_soc_unregister_codec(&spi->dev);
+
+	regulator_bulk_disable(ARRAY_SIZE(wm8731->supplies), wm8731->supplies);
+
 	return 0;
 }
 
@@ -754,6 +776,13 @@ static int wm8731_i2c_probe(struct i2c_client *i2c,
 
 	mutex_init(&wm8731->lock);
 
+	i2c_set_clientdata(i2c, wm8731);
+
+	ret = wm8731_request_supplies(&i2c->dev, wm8731);
+	if (ret != 0) {
+		return ret;
+	}
+
 	wm8731->regmap = devm_regmap_init_i2c(i2c, &wm8731_regmap);
 	if (IS_ERR(wm8731->regmap)) {
 		ret = PTR_ERR(wm8731->regmap);
@@ -762,7 +791,10 @@ static int wm8731_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
-	i2c_set_clientdata(i2c, wm8731);
+	ret = wm8731_hw_init(&i2c->dev, wm8731);
+	if (ret != 0) {
+		return ret;
+	}
 
 	ret = snd_soc_register_codec(&i2c->dev,
 			&soc_codec_dev_wm8731, &wm8731_dai, 1);
@@ -776,7 +808,12 @@ static int wm8731_i2c_probe(struct i2c_client *i2c,
 
 static int wm8731_i2c_remove(struct i2c_client *client)
 {
+	struct wm8731_priv *wm8731 = i2c_get_clientdata(client);
+
 	snd_soc_unregister_codec(&client->dev);
+
+	regulator_bulk_disable(ARRAY_SIZE(wm8731->supplies), wm8731->supplies);
+
 	return 0;
 }
 

--
Sergey
