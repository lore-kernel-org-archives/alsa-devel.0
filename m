From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: adav80x: Convert to direct regmap API
	usage
Date: Fri, 20 Sep 2013 12:29:40 +0100
Message-ID: <1379676580-19008-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 0ACF72655DF
 for <alsa-devel@alsa-project.org>; Fri, 20 Sep 2013 13:29:56 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, device-drivers-devel@blackfin.uclinux.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

As part of a move towards eliminating the ASoC level I/O code convert to
use regmap directly.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/adav80x.c | 244 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 186 insertions(+), 58 deletions(-)

diff --git a/sound/soc/codecs/adav80x.c b/sound/soc/codecs/adav80x.c
index 15b012d0..5d9e913 100644
--- a/sound/soc/codecs/adav80x.c
+++ b/sound/soc/codecs/adav80x.c
@@ -115,22 +115,146 @@
 
 #define ADAV80X_PLL_OUTE_SYSCLKPD(x)		BIT(2 - (x))
 
-static u8 adav80x_default_regs[] = {
-	0x00, 0x00, 0x00, 0x00, 0x01, 0x01, 0x02, 0x01, 0x80, 0x26, 0x00, 0x00,
-	0x02, 0x40, 0x20, 0x00, 0x09, 0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x04, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0xd1, 0x92, 0xb1, 0x37,
-	0x48, 0xd2, 0xfb, 0xca, 0xd2, 0x15, 0xe8, 0x29, 0xb9, 0x6a, 0xda, 0x2b,
-	0xb7, 0xc0, 0x11, 0x65, 0x5c, 0xf6, 0xff, 0x8d, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xa5, 0x00, 0x00,
-	0x00, 0xe8, 0x46, 0xe1, 0x5b, 0xd3, 0x43, 0x77, 0x93, 0xa7, 0x44, 0xee,
-	0x32, 0x12, 0xc0, 0x11, 0x00, 0x00, 0x00, 0x00, 0xff, 0xff, 0x3f, 0x3f,
-	0x00, 0x00, 0x00, 0x00, 0xff, 0xff, 0x00, 0x1d, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x52, 0x00,
+static const struct reg_default adav80x_default_regs[] = {
+	{ 0, 0x00 },
+	{ 1, 0x00 },
+	{ 2, 0x00 },
+	{ 3, 0x00 },
+	{ 4, 0x01 },
+	{ 5, 0x01 },
+	{ 6, 0x02 },
+	{ 7, 0x01 },
+	{ 8, 0x80 },
+	{ 9, 0x26 },
+	{ 10, 0x00 },
+	{ 11, 0x00 },
+	{ 12, 0x02 },
+	{ 13, 0x40 },
+	{ 14, 0x20 },
+	{ 15, 0x00 },
+	{ 16, 0x09 },
+	{ 17, 0x08 },
+	{ 18, 0x00 },
+	{ 19, 0x00 },
+	{ 20, 0x00 },
+	{ 21, 0x00 },
+	{ 22, 0x00 },
+	{ 23, 0x00 },
+	{ 24, 0x04 },
+	{ 25, 0x00 },
+	{ 26, 0x01 },
+	{ 27, 0x00 },
+	{ 28, 0x00 },
+	{ 29, 0x00 },
+	{ 30, 0x00 },
+	{ 31, 0x00 },
+	{ 32, 0xd1 },
+	{ 33, 0x92 },
+	{ 34, 0xb1 },
+	{ 35, 0x37 },
+	{ 36, 0x48 },
+	{ 37, 0xd2 },
+	{ 38, 0xfb },
+	{ 39, 0xca },
+	{ 40, 0xd2 },
+	{ 41, 0x15 },
+	{ 42, 0xe8 },
+	{ 43, 0x29 },
+	{ 44, 0xb9 },
+	{ 45, 0x6a },
+	{ 46, 0xda },
+	{ 47, 0x2b },
+	{ 48, 0xb7 },
+	{ 49, 0xc0 },
+	{ 50, 0x11 },
+	{ 51, 0x65 },
+	{ 52, 0x5c },
+	{ 53, 0xf6 },
+	{ 54, 0xff },
+	{ 55, 0x8d },
+	{ 56, 0x00 },
+	{ 57, 0x00 },
+	{ 58, 0x00 },
+	{ 59, 0x00 },
+	{ 60, 0x00 },
+	{ 61, 0x00 },
+	{ 62, 0x00 },
+	{ 63, 0x00 },
+	{ 64, 0x00 },
+	{ 65, 0x00 },
+	{ 66, 0x00 },
+	{ 67, 0x00 },
+	{ 68, 0x00 },
+	{ 69, 0x00 },
+	{ 70, 0x00 },
+	{ 71, 0x00 },
+	{ 72, 0x00 },
+	{ 73, 0x00 },
+	{ 74, 0x00 },
+	{ 75, 0x00 },
+	{ 76, 0x00 },
+	{ 77, 0x00 },
+	{ 78, 0x00 },
+	{ 79, 0x00 },
+	{ 80, 0x00 },
+	{ 81, 0xa5 },
+	{ 82, 0x00 },
+	{ 83, 0x00 },
+	{ 84, 0x00 },
+	{ 85, 0xe8 },
+	{ 86, 0x46 },
+	{ 87, 0xe1 },
+	{ 88, 0x5b },
+	{ 89, 0xd3 },
+	{ 90, 0x43 },
+	{ 91, 0x77 },
+	{ 92, 0x93 },
+	{ 93, 0xa7 },
+	{ 94, 0x44 },
+	{ 95, 0xee },
+	{ 96, 0x32 },
+	{ 97, 0x12 },
+	{ 98, 0xc0 },
+	{ 99, 0x11 },
+	{ 100, 0x00 },
+	{ 101, 0x00 },
+	{ 102, 0x00 },
+	{ 103, 0x00 },
+	{ 104, 0xff },
+	{ 105, 0xff },
+	{ 106, 0x3f },
+	{ 107, 0x3f },
+	{ 108, 0x00 },
+	{ 109, 0x00 },
+	{ 110, 0x00 },
+	{ 111, 0x00 },
+	{ 112, 0xff },
+	{ 113, 0xff },
+	{ 114, 0x00 },
+	{ 115, 0x1d },
+	{ 116, 0x00 },
+	{ 117, 0x00 },
+	{ 118, 0x00 },
+	{ 119, 0x00 },
+	{ 120, 0x00 },
+	{ 121, 0x00 },
+	{ 122, 0x00 },
+	{ 123, 0x00 },
+	{ 124, 0x52 },
+	{ 125, 0x00 },
+};
+
+static const struct regmap_config adav80x_regmap = {
+	.reg_bits = 7,
+	.val_bits = 9,
+
+	.reg_defaults = adav80x_default_regs,
+	.num_reg_defaults = ARRAY_SIZE(adav80x_default_regs),
+	.max_register = ARRAY_SIZE(adav80x_default_regs) - 1,
 };
 
 struct adav80x {
-	enum snd_soc_control_type control_type;
+	struct regmap *regmap;
 
 	enum adav80x_clk_src clk_src;
 	unsigned int sysclk;
@@ -777,14 +901,9 @@ static struct snd_soc_dai_driver adav80x_dais[] = {
 
 static int adav80x_probe(struct snd_soc_codec *codec)
 {
-	int ret;
 	struct adav80x *adav80x = snd_soc_codec_get_drvdata(codec);
 
-	ret = snd_soc_codec_set_cache_io(codec, 7, 9, adav80x->control_type);
-	if (ret) {
-		dev_err(codec->dev, "failed to set cache I/O: %d\n", ret);
-		return ret;
-	}
+	codec->control_data = adav80x->regmap;
 
 	/* Force PLLs on for SYSCLK output */
 	snd_soc_dapm_force_enable_pin(&codec->dapm, "PLL1");
@@ -800,14 +919,25 @@ static int adav80x_probe(struct snd_soc_codec *codec)
 
 static int adav80x_suspend(struct snd_soc_codec *codec)
 {
-	return adav80x_set_bias_level(codec, SND_SOC_BIAS_OFF);
+	struct adav80x *adav80x = snd_soc_codec_get_drvdata(codec);
+	int ret;
+
+	ret = adav80x_set_bias_level(codec, SND_SOC_BIAS_OFF);
+
+	regcache_cache_only(adav80x->regmap, true);
+
+	return ret;
 }
 
 static int adav80x_resume(struct snd_soc_codec *codec)
 {
+	struct adav80x *adav80x = snd_soc_codec_get_drvdata(codec);
+
+	regcache_cache_only(adav80x->regmap, false);
+
 	adav80x_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-	codec->cache_sync = 1;
-	snd_soc_cache_sync(codec);
+
+	regcache_sync(adav80x->regmap);
 
 	return 0;
 }
@@ -827,10 +957,6 @@ static struct snd_soc_codec_driver adav80x_codec_driver = {
 	.set_pll = adav80x_set_pll,
 	.set_sysclk = adav80x_set_sysclk,
 
-	.reg_word_size = sizeof(u8),
-	.reg_cache_size = ARRAY_SIZE(adav80x_default_regs),
-	.reg_cache_default = adav80x_default_regs,
-
 	.controls = adav80x_controls,
 	.num_controls = ARRAY_SIZE(adav80x_controls),
 	.dapm_widgets = adav80x_dapm_widgets,
@@ -839,34 +965,6 @@ static struct snd_soc_codec_driver adav80x_codec_driver = {
 	.num_dapm_routes = ARRAY_SIZE(adav80x_dapm_routes),
 };
 
-static int adav80x_bus_probe(struct device *dev,
-			     enum snd_soc_control_type control_type)
-{
-	struct adav80x *adav80x;
-	int ret;
-
-	adav80x = kzalloc(sizeof(*adav80x), GFP_KERNEL);
-	if (!adav80x)
-		return -ENOMEM;
-
-	dev_set_drvdata(dev, adav80x);
-	adav80x->control_type = control_type;
-
-	ret = snd_soc_register_codec(dev, &adav80x_codec_driver,
-		adav80x_dais, ARRAY_SIZE(adav80x_dais));
-	if (ret)
-		kfree(adav80x);
-
-	return ret;
-}
-
-static int adav80x_bus_remove(struct device *dev)
-{
-	snd_soc_unregister_codec(dev);
-	kfree(dev_get_drvdata(dev));
-	return 0;
-}
-
 #if defined(CONFIG_SPI_MASTER)
 static const struct spi_device_id adav80x_spi_id[] = {
 	{ "adav801", 0 },
@@ -876,12 +974,27 @@ MODULE_DEVICE_TABLE(spi, adav80x_spi_id);
 
 static int adav80x_spi_probe(struct spi_device *spi)
 {
-	return adav80x_bus_probe(&spi->dev, SND_SOC_SPI);
+	struct adav80x *adav80x;
+
+	adav80x = devm_kzalloc(&spi->dev, sizeof(*adav80x), GFP_KERNEL);
+	if (!adav80x)
+		return -ENOMEM;
+
+	adav80x->regmap = devm_regmap_init_spi(spi, &adav80x_regmap);
+	if (IS_ERR(adav80x->regmap))
+		return PTR_ERR(adav80x->regmap);
+
+	dev_set_drvdata(&spi->dev, adav80x);
+
+	return snd_soc_register_codec(&spi->dev, &adav80x_codec_driver,
+				      adav80x_dais, ARRAY_SIZE(adav80x_dais));
 }
 
 static int adav80x_spi_remove(struct spi_device *spi)
 {
-	return adav80x_bus_remove(&spi->dev);
+	snd_soc_unregister_codec(&spi->dev);
+
+	return 0;
 }
 
 static struct spi_driver adav80x_spi_driver = {
@@ -905,12 +1018,27 @@ MODULE_DEVICE_TABLE(i2c, adav80x_i2c_id);
 static int adav80x_i2c_probe(struct i2c_client *client,
 			     const struct i2c_device_id *id)
 {
-	return adav80x_bus_probe(&client->dev, SND_SOC_I2C);
+	struct adav80x *adav80x;
+
+	adav80x = devm_kzalloc(&client->dev, sizeof(*adav80x), GFP_KERNEL);
+	if (!adav80x)
+		return -ENOMEM;
+
+	adav80x->regmap = devm_regmap_init_i2c(client, &adav80x_regmap);
+	if (IS_ERR(adav80x->regmap))
+		return PTR_ERR(adav80x->regmap);
+
+	dev_set_drvdata(&client->dev, adav80x);
+
+	return snd_soc_register_codec(&client->dev, &adav80x_codec_driver,
+				      adav80x_dais, ARRAY_SIZE(adav80x_dais));
 }
 
 static int adav80x_i2c_remove(struct i2c_client *client)
 {
-	return adav80x_bus_remove(&client->dev);
+	snd_soc_unregister_codec(&client->dev);
+
+	return 0;
 }
 
 static struct i2c_driver adav80x_i2c_driver = {
-- 
1.8.4.rc3
