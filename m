From: Ashish Chavan <ashish.chavan@kpitcummins.com>
Subject: [PATCH] ASoC: da7210: Add support for spi regmap
Date: Wed, 21 Mar 2012 21:22:50 +0530
Message-ID: <1332345170.21744.10.camel@matrix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from va3outboundpool.messaging.microsoft.com
	(va3ehsobe001.messaging.microsoft.com [216.32.180.11])
	by alsa0.perex.cz (Postfix) with ESMTP id 7FABB2457E
	for <alsa-devel@alsa-project.org>; Wed, 21 Mar 2012 16:41:43 +0100 (CET)
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
 sound/soc/codecs/da7210.c |   90 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 90 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/da7210.c b/sound/soc/codecs/da7210.c
index 7843711..0f13fc4 100644
--- a/sound/soc/codecs/da7210.c
+++ b/sound/soc/codecs/da7210.c
@@ -17,6 +17,7 @@
 
 #include <linux/delay.h>
 #include <linux/i2c.h>
+#include <linux/spi/spi.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
 #include <linux/module.h>
@@ -905,6 +906,9 @@ static int da7210_probe(struct snd_soc_codec *codec)
 {
 	struct da7210_priv *da7210 = snd_soc_codec_get_drvdata(codec);
 	int ret;
+#if defined(CONFIG_SPI_MASTER)
+	unsigned int val;
+#endif
 
 	dev_info(codec->dev, "DA7210 Audio Codec %s\n", DA7210_VERSION);
 
@@ -927,10 +931,23 @@ static int da7210_probe(struct snd_soc_codec *codec)
 	 *      DA7210_PLL_DIV3 :: DA7210_MCLK_RANGExxx
 	 */
 
+#if defined(CONFIG_SPI_MASTER)
+	/* Dummy read to give two pulses over nCS */
+	regmap_read(da7210->regmap, DA7210_STATUS, &val);
+	regmap_read(da7210->regmap, DA7210_STATUS, &val);
+	regmap_read(da7210->regmap, DA7210_STATUS, &val);
+#endif
+
 	/*
 	 * make sure that DA7210 use bypass mode before start up
 	 */
 	snd_soc_write(codec, DA7210_STARTUP1, 0);
+
+#if defined(CONFIG_SPI_MASTER)
+	/* Dummy read to complete last write operation */
+	regmap_read(da7210->regmap, DA7210_STATUS, &val);
+#endif
+
 	snd_soc_write(codec, DA7210_PLL_DIV3,
 		     DA7210_MCLK_RANGE_10_20_MHZ | DA7210_PLL_BYP);
 
@@ -1025,6 +1042,10 @@ static int da7210_probe(struct snd_soc_codec *codec)
 		     DA7210_MCLK_RANGE_10_20_MHZ | DA7210_PLL_BYP);
 	snd_soc_update_bits(codec, DA7210_PLL, DA7210_PLL_EN, DA7210_PLL_EN);
 
+#if defined(CONFIG_SPI_MASTER)
+	snd_soc_write(codec, 0x00, 0x80);
+#endif
+
 	/* As suggested by Dialog */
 	/* unlock */
 	regmap_write(da7210->regmap, DA7210_A_HID_UNLOCK,	0x8B);
@@ -1035,6 +1056,10 @@ static int da7210_probe(struct snd_soc_codec *codec)
 	regmap_write(da7210->regmap, DA7210_A_HID_UNLOCK,	0x00);
 	regmap_write(da7210->regmap, DA7210_A_TEST_UNLOCK,	0x00);
 
+#if defined(CONFIG_SPI_MASTER)
+	snd_soc_write(codec, 0x00, 0x00);
+#endif
+
 	/* Activate all enabled subsystem */
 	snd_soc_write(codec, DA7210_STARTUP1, DA7210_SC_MST_EN);
 
@@ -1128,12 +1153,74 @@ static struct i2c_driver da7210_i2c_driver = {
 };
 #endif
 
+#if defined(CONFIG_SPI_MASTER)
+static int __devinit da7210_spi_probe(struct spi_device *spi)
+{
+	struct da7210_priv *da7210;
+	int ret;
+
+	da7210 = kzalloc(sizeof(struct da7210_priv), GFP_KERNEL);
+	if (!da7210)
+		return -ENOMEM;
+
+	spi_set_drvdata(spi, da7210);
+
+	da7210_regmap.read_flag_mask = 0x01;
+	da7210_regmap.write_flag_mask = 0x00;
+	da7210->regmap = regmap_init_spi(spi, &da7210_regmap);
+	if (IS_ERR(da7210->regmap)) {
+		ret = PTR_ERR(da7210->regmap);
+		dev_err(&spi->dev, "Failed to register regmap: %d\n", ret);
+		goto err_alloc;
+	}
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
+err_alloc:
+	kfree(da7210);
+
+	return ret;
+}
+
+static int __devexit da7210_spi_remove(struct spi_device *spi)
+{
+	struct da7210_priv *da7210 = spi_get_drvdata(spi);
+	snd_soc_unregister_codec(&spi->dev);
+	regmap_exit(da7210->regmap);
+	kfree(da7210);
+	return 0;
+}
+
+static struct spi_driver da7210_spi_driver = {
+	.driver = {
+		.name = "da7210-codec",
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
@@ -1143,6 +1230,9 @@ static void __exit da7210_exit(void)
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
