From: Jeremy McDermond <nh6z@nh6z.net>
Subject: [PATCH] ASoC: tlv320aic32x4: Add SPI support
Date: Fri, 15 Apr 2016 18:10:06 -0700
Message-ID: <1460769006-9114-1-git-send-email-nh6z@nh6z.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.xenotropic.com (mail.xenotropic.com [198.178.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 857B02608B3
 for <alsa-devel@alsa-project.org>; Sat, 16 Apr 2016 03:10:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by mail.xenotropic.com (Postfix) with ESMTP id B426A20096
 for <alsa-devel@alsa-project.org>; Fri, 15 Apr 2016 18:01:46 -0700 (PDT)
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
Cc: Jeremy McDermond <nh6z@nh6z.net>
List-Id: alsa-devel@alsa-project.org

The TLV320AIC32x4 support the control channel over either SPI or I2C.
Added the proper interfacing with regmap to make the driver able to
handle either possibility.

Signed-off-by: Jeremy McDermond <nh6z@nh6z.net>
---
 sound/soc/codecs/Kconfig         |   5 +-
 sound/soc/codecs/tlv320aic32x4.c | 181 +++++++++++++++++++++++++++++++++++----
 2 files changed, 165 insertions(+), 21 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 907c804..1ddf7b8 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -129,7 +129,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_TLV320AIC23_SPI if SPI_MASTER
 	select SND_SOC_TLV320AIC26 if SPI_MASTER
 	select SND_SOC_TLV320AIC31XX if I2C
-	select SND_SOC_TLV320AIC32X4 if I2C
+	select SND_SOC_TLV320AIC32X4 if SND_SOC_I2C_AND_SPI
 	select SND_SOC_TLV320AIC3X if I2C
 	select SND_SOC_TPA6130A2 if I2C
 	select SND_SOC_TLV320DAC33 if I2C
@@ -768,7 +768,8 @@ config SND_SOC_TLV320AIC31XX
 	select REGMAP_I2C
 
 config SND_SOC_TLV320AIC32X4
-	tristate
+	tristate "Texas Instruments TLV320AIC32x4 CODECs"
+	depends on SND_SOC_I2C_AND_SPI
 
 config SND_SOC_TLV320AIC3X
 	tristate "Texas Instruments TLV320AIC3x CODECs"
diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index f2d3191..1c888b7 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -31,6 +31,7 @@
 #include <linux/gpio.h>
 #include <linux/of_gpio.h>
 #include <linux/i2c.h>
+#include <linux/spi/spi.h>
 #include <linux/cdev.h>
 #include <linux/slab.h>
 #include <linux/clk.h>
@@ -287,15 +288,6 @@ static const struct regmap_range_cfg aic32x4_regmap_pages[] = {
 	},
 };
 
-static const struct regmap_config aic32x4_regmap = {
-	.reg_bits = 8,
-	.val_bits = 8,
-
-	.max_register = AIC32X4_RMICPGAVOL,
-	.ranges = aic32x4_regmap_pages,
-	.num_ranges = ARRAY_SIZE(aic32x4_regmap_pages),
-};
-
 static inline int aic32x4_get_divs(int mclk, int rate)
 {
 	int i;
@@ -668,7 +660,7 @@ static struct snd_soc_codec_driver soc_codec_dev_aic32x4 = {
 };
 
 static int aic32x4_parse_dt(struct aic32x4_priv *aic32x4,
-		struct device_node *np)
+		struct device_node *np, struct device *dev)
 {
 	aic32x4->swapdacs = false;
 	aic32x4->micpga_routing = 0;
@@ -777,6 +769,23 @@ error_ldo:
 	return ret;
 }
 
+static const struct of_device_id aic32x4_of_id[] = {
+	{ .compatible = "ti,tlv320aic32x4", },
+	{ /* senitel */ }
+};
+MODULE_DEVICE_TABLE(of, aic32x4_of_id);
+
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+
+static const struct regmap_config aic32x4_i2c_regmap = {
+	.reg_bits = 8,
+	.val_bits = 8,
+
+	.max_register = AIC32X4_RMICPGAVOL,
+	.ranges = aic32x4_regmap_pages,
+	.num_ranges = ARRAY_SIZE(aic32x4_regmap_pages),
+};
+
 static int aic32x4_i2c_probe(struct i2c_client *i2c,
 			     const struct i2c_device_id *id)
 {
@@ -790,7 +799,7 @@ static int aic32x4_i2c_probe(struct i2c_client *i2c,
 	if (aic32x4 == NULL)
 		return -ENOMEM;
 
-	aic32x4->regmap = devm_regmap_init_i2c(i2c, &aic32x4_regmap);
+	aic32x4->regmap = devm_regmap_init_i2c(i2c, &aic32x4_i2c_regmap);
 	if (IS_ERR(aic32x4->regmap))
 		return PTR_ERR(aic32x4->regmap);
 
@@ -802,7 +811,7 @@ static int aic32x4_i2c_probe(struct i2c_client *i2c,
 		aic32x4->micpga_routing = pdata->micpga_routing;
 		aic32x4->rstn_gpio = pdata->rstn_gpio;
 	} else if (np) {
-		ret = aic32x4_parse_dt(aic32x4, np);
+		ret = aic32x4_parse_dt(aic32x4, np, &i2c->dev);
 		if (ret) {
 			dev_err(&i2c->dev, "Failed to parse DT node\n");
 			return ret;
@@ -862,12 +871,6 @@ static const struct i2c_device_id aic32x4_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, aic32x4_i2c_id);
 
-static const struct of_device_id aic32x4_of_id[] = {
-	{ .compatible = "ti,tlv320aic32x4", },
-	{ /* senitel */ }
-};
-MODULE_DEVICE_TABLE(of, aic32x4_of_id);
-
 static struct i2c_driver aic32x4_i2c_driver = {
 	.driver = {
 		.name = "tlv320aic32x4",
@@ -877,8 +880,148 @@ static struct i2c_driver aic32x4_i2c_driver = {
 	.remove =   aic32x4_i2c_remove,
 	.id_table = aic32x4_i2c_id,
 };
+#endif
 
-module_i2c_driver(aic32x4_i2c_driver);
+#if defined(CONFIG_SPI_MASTER)
+
+static const struct regmap_config aic32x4_spi_regmap = {
+	.reg_bits = 7,
+	.pad_bits = 1,
+	.val_bits = 8,
+	.read_flag_mask = 0x01,
+
+	.max_register = AIC32X4_RMICPGAVOL,
+	.ranges = aic32x4_regmap_pages,
+	.num_ranges = ARRAY_SIZE(aic32x4_regmap_pages),
+};
+
+static int aic32x4_spi_probe(struct spi_device *spi)
+{
+	struct aic32x4_pdata *pdata = spi->dev.platform_data;
+	struct aic32x4_priv *aic32x4;
+	struct device_node *np = spi->dev.of_node;
+	int ret;
+
+	aic32x4 = devm_kzalloc(&spi->dev, sizeof(struct aic32x4_priv),
+			       GFP_KERNEL);
+	if (aic32x4 == NULL)
+		return -ENOMEM;
+
+	aic32x4->regmap = devm_regmap_init_spi(spi, &aic32x4_spi_regmap);
+	if (IS_ERR(aic32x4->regmap))
+		return PTR_ERR(aic32x4->regmap);
+
+	spi_set_drvdata(spi, aic32x4);
+
+	if (pdata) {
+		aic32x4->power_cfg = pdata->power_cfg;
+		aic32x4->swapdacs = pdata->swapdacs;
+		aic32x4->micpga_routing = pdata->micpga_routing;
+		aic32x4->rstn_gpio = pdata->rstn_gpio;
+	} else if (np) {
+		ret = aic32x4_parse_dt(aic32x4, np, &spi->dev);
+		if (ret) {
+			dev_err(&spi->dev, "Failed to parse DT node\n");
+			return ret;
+		}
+	} else {
+		aic32x4->power_cfg = 0;
+		aic32x4->swapdacs = false;
+		aic32x4->micpga_routing = 0;
+		aic32x4->rstn_gpio = -1;
+	}
+
+	aic32x4->mclk = devm_clk_get(&spi->dev, "mclk");
+	if (IS_ERR(aic32x4->mclk)) {
+		dev_err(&spi->dev, "Failed getting the mclk. The current implementation does not support the usage of this codec without mclk\n");
+		return PTR_ERR(aic32x4->mclk);
+	}
+
+	if (gpio_is_valid(aic32x4->rstn_gpio)) {
+		ret = devm_gpio_request_one(&spi->dev, aic32x4->rstn_gpio,
+				GPIOF_OUT_INIT_LOW, "tlv320aic32x4 rstn");
+		if (ret != 0)
+			return ret;
+	}
+
+	ret = aic32x4_setup_regulators(&spi->dev, aic32x4);
+	if (ret) {
+		dev_err(&spi->dev, "Failed to setup regulators\n");
+		return ret;
+	}
+
+	ret = snd_soc_register_codec(&spi->dev,
+			&soc_codec_dev_aic32x4, &aic32x4_dai, 1);
+	if (ret) {
+		dev_err(&spi->dev, "Failed to register codec\n");
+		aic32x4_disable_regulators(aic32x4);
+		return ret;
+	}
+
+	spi_set_drvdata(spi, aic32x4);
+
+	return 0;
+}
+
+static int aic32x4_spi_remove(struct spi_device *dev)
+{
+	struct aic32x4_priv *aic32x4 = spi_get_drvdata(dev);
+
+	aic32x4_disable_regulators(aic32x4);
+
+	snd_soc_unregister_codec(&dev->dev);
+	return 0;
+}
+
+static const struct spi_device_id aic32x4_spi_id[] = {
+	{ "tlv320aic32x4", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, aic32x4_spi_id);
+
+static struct spi_driver aic32x4_spi_driver = {
+	.driver = {
+		.name = "tlv320aic32x4",
+		.owner = THIS_MODULE,
+		.of_match_table = aic32x4_of_id,
+	},
+	.probe =    aic32x4_spi_probe,
+	.remove =   aic32x4_spi_remove,
+	.id_table = aic32x4_spi_id,
+};
+#endif
+
+static int __init aic32x4_modinit(void)
+{
+	int ret = 0;
+
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+	ret = i2c_add_driver(&aic32x4_i2c_driver);
+	if (ret)
+		pr_err("Failed to register tlv320aic32x4 I2C driver: %d\n",
+		       ret);
+#endif
+#if defined(CONFIG_SPI_MASTER)
+	ret = spi_register_driver(&aic32x4_spi_driver);
+	if (ret)
+		pr_err("Failed to register tlv320aic32x4 SPI driver: %d\n",
+		       ret);
+#endif
+
+	return ret;
+}
+module_init(aic32x4_modinit);
+
+static void __exit aic32x4_exit(void)
+{
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+	i2c_del_driver(&aic32x4_i2c_driver);
+#endif
+#if defined(CONFIG_SPI_MASTER)
+	spi_unregister_driver(&aic32x4_spi_driver);
+#endif
+}
+module_exit(aic32x4_exit);
 
 MODULE_DESCRIPTION("ASoC tlv320aic32x4 codec driver");
 MODULE_AUTHOR("Javier Martin <javier.martin@vista-silicon.com>");
-- 
2.5.0
