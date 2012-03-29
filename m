From: Ashish Chavan <ashish.chavan@kpitcummins.com>
Subject: [PATCH v2] ASoC: da7210: Add support for spi regmap
Date: Thu, 29 Mar 2012 19:06:29 +0530
Message-ID: <1333028189.19925.10.camel@matrix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from am1outboundpool.messaging.microsoft.com
	(am1ehsobe003.messaging.microsoft.com [213.199.154.206])
	by alsa0.perex.cz (Postfix) with ESMTP id 665C510441B
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Mar 2012 15:25:12 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, lrg <lrg@ti.com>, alsa-devel <alsa-devel@alsa-project.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "kuninori.morimoto.gx" <kuninori.morimoto.gx@renesas.com>, David Dajun Chen <david.chen@diasemi.com>
List-Id: alsa-devel@alsa-project.org

This patch adds support for spi regmap feature to existing da7210
driver.

Signed-off-by: Ashish Chavan <ashish.chavan@kpitcummins.com>
Signed-off-by: David Dajun Chen <dchen@diasemi.com>
---
Changes since v1:

- used regmap_register_patch() to write special register sequences
- used devm_kzalloc() instead of kzalloc()
- used devm_regmap_init_spi() instead of regmap_init_spi()
- removed "-codec" from codec name string
---
 sound/soc/codecs/da7210.c |  154 ++++++++++++++++++++++++++++++++++++++------
 1 files changed, 133 insertions(+), 21 deletions(-)

diff --git a/sound/soc/codecs/da7210.c b/sound/soc/codecs/da7210.c
index 7843711..8e45aa9 100644
--- a/sound/soc/codecs/da7210.c
+++ b/sound/soc/codecs/da7210.c
@@ -17,6 +17,7 @@
 
 #include <linux/delay.h>
 #include <linux/i2c.h>
+#include <linux/spi/spi.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
 #include <linux/module.h>
@@ -27,6 +28,7 @@
 #include <sound/tlv.h>
 
 /* DA7210 register space */
+#define DA7210_PAGE_CONTROL		0x00
 #define DA7210_CONTROL			0x01
 #define DA7210_STATUS			0x02
 #define DA7210_STARTUP1			0x03
@@ -631,6 +633,7 @@ struct da7210_priv {
 };
 
 static struct reg_default da7210_reg_defaults[] = {
+	{ 0x00, 0x00 },
 	{ 0x01, 0x11 },
 	{ 0x03, 0x00 },
 	{ 0x04, 0x00 },
@@ -928,13 +931,6 @@ static int da7210_probe(struct snd_soc_codec *codec)
 	 */
 
 	/*
-	 * make sure that DA7210 use bypass mode before start up
-	 */
-	snd_soc_write(codec, DA7210_STARTUP1, 0);
-	snd_soc_write(codec, DA7210_PLL_DIV3,
-		     DA7210_MCLK_RANGE_10_20_MHZ | DA7210_PLL_BYP);
-
-	/*
 	 * ADC settings
 	 */
 
@@ -1025,16 +1021,6 @@ static int da7210_probe(struct snd_soc_codec *codec)
 		     DA7210_MCLK_RANGE_10_20_MHZ | DA7210_PLL_BYP);
 	snd_soc_update_bits(codec, DA7210_PLL, DA7210_PLL_EN, DA7210_PLL_EN);
 
-	/* As suggested by Dialog */
-	/* unlock */
-	regmap_write(da7210->regmap, DA7210_A_HID_UNLOCK,	0x8B);
-	regmap_write(da7210->regmap, DA7210_A_TEST_UNLOCK,	0xB4);
-	regmap_write(da7210->regmap, DA7210_A_PLL1,		0x01);
-	regmap_write(da7210->regmap, DA7210_A_CP_MODE,		0x7C);
-	/* re-lock */
-	regmap_write(da7210->regmap, DA7210_A_HID_UNLOCK,	0x00);
-	regmap_write(da7210->regmap, DA7210_A_TEST_UNLOCK,	0x00);
-
 	/* Activate all enabled subsystem */
 	snd_soc_write(codec, DA7210_STARTUP1, DA7210_SC_MST_EN);
 
@@ -1055,7 +1041,26 @@ static struct snd_soc_codec_driver soc_codec_dev_da7210 = {
 	.num_dapm_routes	= ARRAY_SIZE(da7210_audio_map),
 };
 
-static struct regmap_config da7210_regmap = {
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+
+static struct reg_default da7210_regmap_i2c_patch[] = {
+
+	/* System controller master disable */
+	{ DA7210_STARTUP1, 0x00 },
+	/* make sure that DA7210 use bypass mode before start up */
+	{ DA7210_PLL_DIV3, DA7210_MCLK_RANGE_10_20_MHZ | DA7210_PLL_BYP },
+
+	/* to unlock */
+	{ DA7210_A_HID_UNLOCK, 0x8B},
+	{ DA7210_A_TEST_UNLOCK, 0xB4},
+	{ DA7210_A_PLL1, 0x01},
+	{ DA7210_A_CP_MODE, 0x7C},
+	/* to re-lock */
+	{ DA7210_A_HID_UNLOCK, 0x00},
+	{ DA7210_A_TEST_UNLOCK, 0x00},
+};
+
+static const struct regmap_config da7210_regmap_config_i2c = {
 	.reg_bits = 8,
 	.val_bits = 8,
 
@@ -1066,7 +1071,6 @@ static struct regmap_config da7210_regmap = {
 	.cache_type = REGCACHE_RBTREE,
 };
 
-#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 static int __devinit da7210_i2c_probe(struct i2c_client *i2c,
 			   	      const struct i2c_device_id *id)
 {
@@ -1080,13 +1084,18 @@ static int __devinit da7210_i2c_probe(struct i2c_client *i2c,
 
 	i2c_set_clientdata(i2c, da7210);
 
-	da7210->regmap = regmap_init_i2c(i2c, &da7210_regmap);
+	da7210->regmap = regmap_init_i2c(i2c, &da7210_regmap_config_i2c);
 	if (IS_ERR(da7210->regmap)) {
 		ret = PTR_ERR(da7210->regmap);
 		dev_err(&i2c->dev, "regmap_init() failed: %d\n", ret);
 		return ret;
 	}
 
+	ret = regmap_register_patch(da7210->regmap, da7210_regmap_i2c_patch,
+				    ARRAY_SIZE(da7210_regmap_i2c_patch));
+	if (ret != 0)
+		dev_warn(&i2c->dev, "Failed to apply regmap patch: %d\n", ret);
+
 	ret =  snd_soc_register_codec(&i2c->dev,
 			&soc_codec_dev_da7210, &da7210_dai, 1);
 	if (ret < 0) {
@@ -1119,7 +1128,7 @@ MODULE_DEVICE_TABLE(i2c, da7210_i2c_id);
 /* I2C codec control layer */
 static struct i2c_driver da7210_i2c_driver = {
 	.driver = {
-		.name = "da7210-codec",
+		.name = "da7210",
 		.owner = THIS_MODULE,
 	},
 	.probe		= da7210_i2c_probe,
@@ -1128,12 +1137,112 @@ static struct i2c_driver da7210_i2c_driver = {
 };
 #endif
 
+#if defined(CONFIG_SPI_MASTER)
+
+static struct reg_default da7210_regmap_spi_patch[] = {
+	/* Dummy read to give two pulses over nCS for SPI */
+	{ DA7210_AUX2, 0x00 },
+	{ DA7210_AUX2, 0x00 },
+
+	/* System controller master disable */
+	{ DA7210_STARTUP1, 0x00 },
+	/* make sure that DA7210 use bypass mode before start up */
+	{ DA7210_PLL_DIV3, DA7210_MCLK_RANGE_10_20_MHZ | DA7210_PLL_BYP },
+
+	/* to set PAGE1 of SPI register space */
+	{ DA7210_PAGE_CONTROL, 0x80 },
+	/* to unlock */
+	{ DA7210_A_HID_UNLOCK, 0x8B},
+	{ DA7210_A_TEST_UNLOCK, 0xB4},
+	{ DA7210_A_PLL1, 0x01},
+	{ DA7210_A_CP_MODE, 0x7C},
+	/* to re-lock */
+	{ DA7210_A_HID_UNLOCK, 0x00},
+	{ DA7210_A_TEST_UNLOCK, 0x00},
+	/* to set back PAGE0 of SPI register space */
+	{ DA7210_PAGE_CONTROL, 0x00 },
+};
+
+static const struct regmap_config da7210_regmap_config_spi = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.read_flag_mask = 0x01,
+	.write_flag_mask = 0x00,
+
+	.reg_defaults = da7210_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(da7210_reg_defaults),
+	.volatile_reg = da7210_volatile_register,
+	.readable_reg = da7210_readable_register,
+	.cache_type = REGCACHE_RBTREE,
+};
+
+static int __devinit da7210_spi_probe(struct spi_device *spi)
+{
+	struct da7210_priv *da7210;
+	int ret;
+
+	da7210 = devm_kzalloc(&spi->dev, sizeof(struct da7210_priv),
+			      GFP_KERNEL);
+	if (!da7210)
+		return -ENOMEM;
+
+	spi_set_drvdata(spi, da7210);
+	da7210->regmap = devm_regmap_init_spi(spi, &da7210_regmap_config_spi);
+	if (IS_ERR(da7210->regmap)) {
+		ret = PTR_ERR(da7210->regmap);
+		dev_err(&spi->dev, "Failed to register regmap: %d\n", ret);
+		return ret;
+	}
+
+	ret = regmap_register_patch(da7210->regmap, da7210_regmap_spi_patch,
+				    ARRAY_SIZE(da7210_regmap_spi_patch));
+	if (ret != 0)
+		dev_warn(&spi->dev, "Failed to apply regmap patch: %d\n", ret);
+
+	ret =  snd_soc_register_codec(&spi->dev,
+			&soc_codec_dev_da7210, &da7210_dai, 1);
+	if (ret < 0)
+		goto err_regmap;
+
+	return ret;
+
+err_regmap:
+	regmap_exit(da7210->regmap);
+
+	return ret;
+}
+
+static int __devexit da7210_spi_remove(struct spi_device *spi)
+{
+	struct da7210_priv *da7210 = spi_get_drvdata(spi);
+	snd_soc_unregister_codec(&spi->dev);
+	regmap_exit(da7210->regmap);
+	return 0;
+}
+
+static struct spi_driver da7210_spi_driver = {
+	.driver = {
+		.name = "da7210",
+		.owner = THIS_MODULE,
+	},
+	.probe = da7210_spi_probe,
+	.remove = __devexit_p(da7210_spi_remove)
+};
+#endif
+
 static int __init da7210_modinit(void)
 {
 	int ret = 0;
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 	ret = i2c_add_driver(&da7210_i2c_driver);
 #endif
+#if defined(CONFIG_SPI_MASTER)
+	ret = spi_register_driver(&da7210_spi_driver);
+	if (ret) {
+		printk(KERN_ERR "Failed to register da7210 SPI driver: %d\n",
+		       ret);
+	}
+#endif
 	return ret;
 }
 module_init(da7210_modinit);
@@ -1143,6 +1252,9 @@ static void __exit da7210_exit(void)
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 	i2c_del_driver(&da7210_i2c_driver);
 #endif
+#if defined(CONFIG_SPI_MASTER)
+	spi_unregister_driver(&da7210_spi_driver);
+#endif
 }
 module_exit(da7210_exit);
 
-- 
1.7.1
