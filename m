From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Convert WM8753 to direct regmap API usage
Date: Wed, 23 Nov 2011 11:53:41 +0000
Message-ID: <1322049221-23206-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8400D103B01
	for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2011 12:53:46 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, openmoko-kernel@lists.openmoko.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8753.c |  185 +++++++++++++++++++++++++++++++++------------
 1 files changed, 138 insertions(+), 47 deletions(-)

diff --git a/sound/soc/codecs/wm8753.c b/sound/soc/codecs/wm8753.c
index 13156c83..2821928 100644
--- a/sound/soc/codecs/wm8753.c
+++ b/sound/soc/codecs/wm8753.c
@@ -40,6 +40,7 @@
 #include <linux/i2c.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/regmap.h>
 #include <linux/spi/spi.h>
 #include <linux/slab.h>
 #include <sound/core.h>
@@ -66,28 +67,86 @@ static int wm8753_voice_write_dai_fmt(struct snd_soc_codec *codec,
  * We can't read the WM8753 register space when we
  * are using 2 wire for device control, so we cache them instead.
  */
-static const u16 wm8753_reg[] = {
-	0x0000, 0x0008, 0x0000, 0x000a,
-	0x000a, 0x0033, 0x0000, 0x0007,
-	0x00ff, 0x00ff, 0x000f, 0x000f,
-	0x007b, 0x0000, 0x0032, 0x0000,
-	0x00c3, 0x00c3, 0x00c0, 0x0000,
-	0x0000, 0x0000, 0x0000, 0x0000,
-	0x0000, 0x0000, 0x0000, 0x0000,
-	0x0000, 0x0000, 0x0000, 0x0000,
-	0x0055, 0x0005, 0x0050, 0x0055,
-	0x0050, 0x0055, 0x0050, 0x0055,
-	0x0079, 0x0079, 0x0079, 0x0079,
-	0x0079, 0x0000, 0x0000, 0x0000,
-	0x0000, 0x0097, 0x0097, 0x0000,
-	0x0004, 0x0000, 0x0083, 0x0024,
-	0x01ba, 0x0000, 0x0083, 0x0024,
-	0x01ba, 0x0000, 0x0000, 0x0000
+static const struct reg_default wm8753_reg_defaults[] = {
+	{ 0x00, 0x0000 },
+	{ 0x01, 0x0008 },
+	{ 0x02, 0x0000 },
+	{ 0x03, 0x000a },
+	{ 0x04, 0x000a },
+	{ 0x05, 0x0033 },
+	{ 0x06, 0x0000 },
+	{ 0x07, 0x0007 },
+	{ 0x08, 0x00ff },
+	{ 0x09, 0x00ff },
+	{ 0x0a, 0x000f },
+	{ 0x0b, 0x000f },
+	{ 0x0c, 0x007b },
+	{ 0x0d, 0x0000 },
+	{ 0x0e, 0x0032 },
+	{ 0x0f, 0x0000 },
+	{ 0x10, 0x00c3 },
+	{ 0x11, 0x00c3 },
+	{ 0x12, 0x00c0 },
+	{ 0x13, 0x0000 },
+	{ 0x14, 0x0000 },
+	{ 0x15, 0x0000 },
+	{ 0x16, 0x0000 },
+	{ 0x17, 0x0000 },
+	{ 0x18, 0x0000 },
+	{ 0x19, 0x0000 },
+	{ 0x1a, 0x0000 },
+	{ 0x1b, 0x0000 },
+	{ 0x1c, 0x0000 },
+	{ 0x1d, 0x0000 },
+	{ 0x1e, 0x0000 },
+	{ 0x1f, 0x0000 },
+	{ 0x20, 0x0055 },
+	{ 0x21, 0x0005 },
+	{ 0x22, 0x0050 },
+	{ 0x23, 0x0055 },
+	{ 0x24, 0x0050 },
+	{ 0x25, 0x0055 },
+	{ 0x26, 0x0050 },
+	{ 0x27, 0x0055 },
+	{ 0x28, 0x0079 },
+	{ 0x29, 0x0079 },
+	{ 0x2a, 0x0079 },
+	{ 0x2b, 0x0079 },
+	{ 0x2c, 0x0079 },
+	{ 0x2d, 0x0000 },
+	{ 0x2e, 0x0000 },
+	{ 0x2f, 0x0000 },
+	{ 0x30, 0x0000 },
+	{ 0x31, 0x0097 },
+	{ 0x32, 0x0097 },
+	{ 0x33, 0x0000 },
+	{ 0x34, 0x0004 },
+	{ 0x35, 0x0000 },
+	{ 0x36, 0x0083 },
+	{ 0x37, 0x0024 },
+	{ 0x38, 0x01ba },
+	{ 0x39, 0x0000 },
+	{ 0x3a, 0x0083 },
+	{ 0x3b, 0x0024 },
+	{ 0x3c, 0x01ba },
+	{ 0x3d, 0x0000 },
+	{ 0x3e, 0x0000 },
+	{ 0x3f, 0x0000 },
 };
 
+static bool wm8753_volatile(struct device *dev, unsigned int reg)
+{
+	return reg == WM8753_RESET;
+}
+
+static bool wm8753_writeable(struct device *dev, unsigned int reg)
+{
+	return reg <= WM8753_ADCTL2;
+}
+
 /* codec private data */
 struct wm8753_priv {
-	enum snd_soc_control_type control_type;
+	struct regmap *regmap;
 	unsigned int sysclk;
 	unsigned int pcmclk;
 
@@ -1384,25 +1443,15 @@ static void wm8753_work(struct work_struct *work)
 static int wm8753_suspend(struct snd_soc_codec *codec, pm_message_t state)
 {
 	wm8753_set_bias_level(codec, SND_SOC_BIAS_OFF);
+	codec->cache_sync = 1;
 	return 0;
 }
 
 static int wm8753_resume(struct snd_soc_codec *codec)
 {
-	u16 *reg_cache = codec->reg_cache;
-	int i;
-
-	/* Sync reg_cache with the hardware */
-	for (i = 1; i < ARRAY_SIZE(wm8753_reg); i++) {
-		if (i == WM8753_RESET)
-			continue;
-
-		/* No point in writing hardware default values back */
-		if (reg_cache[i] == wm8753_reg[i])
-			continue;
+	struct wm8753_priv *wm8753 = snd_soc_codec_get_drvdata(codec);
 
-		snd_soc_write(codec, i, reg_cache[i]);
-	}
+	regcache_sync(wm8753->regmap);
 
 	wm8753_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
@@ -1424,7 +1473,7 @@ static int wm8753_probe(struct snd_soc_codec *codec)
 
 	INIT_DELAYED_WORK(&codec->dapm.delayed_work, wm8753_work);
 
-	ret = snd_soc_codec_set_cache_io(codec, 7, 9, wm8753->control_type);
+	ret = snd_soc_codec_set_cache_io(codec, 7, 9, SND_SOC_REGMAP);
 	if (ret < 0) {
 		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
 		return ret;
@@ -1474,9 +1523,6 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8753 = {
 	.suspend =	wm8753_suspend,
 	.resume =	wm8753_resume,
 	.set_bias_level = wm8753_set_bias_level,
-	.reg_cache_size = ARRAY_SIZE(wm8753_reg),
-	.reg_word_size = sizeof(u16),
-	.reg_cache_default = wm8753_reg,
 
 	.controls = wm8753_snd_controls,
 	.num_controls = ARRAY_SIZE(wm8753_snd_controls),
@@ -1492,6 +1538,19 @@ static const struct of_device_id wm8753_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, wm8753_of_match);
 
+static const struct regmap_config wm8753_regmap = {
+	.reg_bits = 7,
+	.val_bits = 9,
+
+	.max_register = WM8753_ADCTL2,
+	.writeable_reg = wm8753_writeable,
+	.volatile_reg = wm8753_volatile,
+
+	.cache_type = REGCACHE_RBTREE,
+	.reg_defaults = wm8753_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(wm8753_reg_defaults),
+};
+
 #if defined(CONFIG_SPI_MASTER)
 static int __devinit wm8753_spi_probe(struct spi_device *spi)
 {
@@ -1502,20 +1561,36 @@ static int __devinit wm8753_spi_probe(struct spi_device *spi)
 	if (wm8753 == NULL)
 		return -ENOMEM;
 
-	wm8753->control_type = SND_SOC_SPI;
 	spi_set_drvdata(spi, wm8753);
 
-	ret = snd_soc_register_codec(&spi->dev,
-			&soc_codec_dev_wm8753, wm8753_dai, ARRAY_SIZE(wm8753_dai));
-	if (ret < 0)
-		kfree(wm8753);
+	wm8753->regmap = regmap_init_spi(spi, &wm8753_regmap);
+	if (IS_ERR(wm8753->regmap)) {
+		ret = PTR_ERR(wm8753->regmap);
+		dev_err(&spi->dev, "Failed to allocate register map: %d\n",
+			ret);
+		goto err;
+	}
+
+	ret = snd_soc_register_codec(&spi->dev, &soc_codec_dev_wm8753,
+				     wm8753_dai, ARRAY_SIZE(wm8753_dai));
+	if (ret != 0) {
+		dev_err(&spi->dev, "Failed to register CODEC: %d\n", ret);
+		goto err_regmap;
+	}
+err_regmap:
+	regmap_exit(wm8753->regmap);
+err:
+	kfree(wm8753);
 	return ret;
 }
 
 static int __devexit wm8753_spi_remove(struct spi_device *spi)
 {
+	struct wm8753_priv *wm8753 = spi_get_drvdata(spi);
+
 	snd_soc_unregister_codec(&spi->dev);
-	kfree(spi_get_drvdata(spi));
+	regmap_exit(wm8753->regmap);
+	kfree(wm8753);
 	return 0;
 }
 
@@ -1542,19 +1617,35 @@ static __devinit int wm8753_i2c_probe(struct i2c_client *i2c,
 		return -ENOMEM;
 
 	i2c_set_clientdata(i2c, wm8753);
-	wm8753->control_type = SND_SOC_I2C;
 
-	ret =  snd_soc_register_codec(&i2c->dev,
-			&soc_codec_dev_wm8753, wm8753_dai, ARRAY_SIZE(wm8753_dai));
-	if (ret < 0)
-		kfree(wm8753);
+	wm8753->regmap = regmap_init_i2c(i2c, &wm8753_regmap);
+	if (IS_ERR(wm8753->regmap)) {
+		ret = PTR_ERR(wm8753->regmap);
+		dev_err(&i2c->dev, "Failed to allocate register map: %d\n",
+			ret);
+		goto err;
+	}
+
+	ret = snd_soc_register_codec(&i2c->dev, &soc_codec_dev_wm8753,
+				     wm8753_dai, ARRAY_SIZE(wm8753_dai));
+	if (ret != 0) {
+		dev_err(&i2c->dev, "Failed to register CODEC: %d\n", ret);
+		goto err_regmap;
+	}
+err_regmap:
+	regmap_exit(wm8753->regmap);
+err:
+	kfree(wm8753);
 	return ret;
 }
 
 static __devexit int wm8753_i2c_remove(struct i2c_client *client)
 {
+	struct wm8753_priv *wm8753 = i2c_get_clientdata(client);
+
 	snd_soc_unregister_codec(&client->dev);
-	kfree(i2c_get_clientdata(client));
+	regmap_exit(wm8753->regmap);
+	kfree(wm8753);
 	return 0;
 }
 
-- 
1.7.7.3
