From: Jeremy McDermond <nh6z@nh6z.net>
Subject: [PATCH v2 2/3] ASoC: tlv320aic32x4: Break out I2C
	support into separate module
Date: Mon, 18 Apr 2016 17:24:05 -0700
Message-ID: <1461025446-7693-3-git-send-email-nh6z@nh6z.net>
References: <1461025446-7693-1-git-send-email-nh6z@nh6z.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.xenotropic.com (mail.xenotropic.com [198.178.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 1FDE52654B5
 for <alsa-devel@alsa-project.org>; Tue, 19 Apr 2016 02:24:24 +0200 (CEST)
In-Reply-To: <1461025446-7693-1-git-send-email-nh6z@nh6z.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, lgirdwood@gmail.com, broonie@kernel.org
Cc: Jeremy McDermond <nh6z@nh6z.net>
List-Id: alsa-devel@alsa-project.org

To prepare for abstracting adding SPI support, the I2C pieces needs to
be in its own moudle.  This patch moves common probe code into aic32x4_probe
and common removal code into aic32x4_remove.  It also creates a static
regmap config structure to be copied in the I2C specific driver.

Signed-off-by: Jeremy McDermond <nh6z@nh6z.net>
---
 sound/soc/codecs/Kconfig             |  7 +++-
 sound/soc/codecs/Makefile            |  2 +
 sound/soc/codecs/tlv320aic32x4-i2c.c | 74 +++++++++++++++++++++++++++++++++++
 sound/soc/codecs/tlv320aic32x4.c     | 76 ++++++++++++------------------------
 sound/soc/codecs/tlv320aic32x4.h     |  7 ++++
 5 files changed, 113 insertions(+), 53 deletions(-)
 create mode 100644 sound/soc/codecs/tlv320aic32x4-i2c.c

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index fe32cca..e313fdd 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -120,7 +120,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_TAS5713 if I2C
 	select SND_SOC_TLV320AIC26 if SPI_MASTER
 	select SND_SOC_TLV320AIC31XX if I2C
-	select SND_SOC_TLV320AIC32X4 if I2C
+	select SND_SOC_TLV320AIC32X4_I2C if I2C
 	select SND_SOC_TLV320AIC3X if I2C
 	select SND_SOC_TPA6130A2 if I2C
 	select SND_SOC_TLV320DAC33 if I2C
@@ -703,6 +703,11 @@ config SND_SOC_TLV320AIC31XX
 config SND_SOC_TLV320AIC32X4
 	tristate
 
+config SND_SOC_TLV320AIC32X4_I2C
+	tristate
+	depends on I2C
+	select SND_SOC_TLV320AIC32X4
+
 config SND_SOC_TLV320AIC3X
 	tristate "Texas Instruments TLV320AIC3x CODECs"
 	depends on I2C
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index dbb213d..2f7c4c1 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -125,6 +125,7 @@ snd-soc-tlv320aic23-spi-objs := tlv320aic23-spi.o
 snd-soc-tlv320aic26-objs := tlv320aic26.o
 snd-soc-tlv320aic31xx-objs := tlv320aic31xx.o
 snd-soc-tlv320aic32x4-objs := tlv320aic32x4.o
+snd-soc-tlv320aic32x4-i2c-objs := tlv320aic32x4-i2c.o
 snd-soc-tlv320aic3x-objs := tlv320aic3x.o
 snd-soc-tlv320dac33-objs := tlv320dac33.o
 snd-soc-ts3a227e-objs := ts3a227e.o
@@ -320,6 +321,7 @@ obj-$(CONFIG_SND_SOC_TLV320AIC23_SPI)	+= snd-soc-tlv320aic23-spi.o
 obj-$(CONFIG_SND_SOC_TLV320AIC26)	+= snd-soc-tlv320aic26.o
 obj-$(CONFIG_SND_SOC_TLV320AIC31XX)     += snd-soc-tlv320aic31xx.o
 obj-$(CONFIG_SND_SOC_TLV320AIC32X4)     += snd-soc-tlv320aic32x4.o
+obj-$(CONFIG_SND_SOC_TLV320AIC32X4_I2C)	+= snd-soc-tlv320aic32x4-i2c.o
 obj-$(CONFIG_SND_SOC_TLV320AIC3X)	+= snd-soc-tlv320aic3x.o
 obj-$(CONFIG_SND_SOC_TLV320DAC33)	+= snd-soc-tlv320dac33.o
 obj-$(CONFIG_SND_SOC_TS3A227E)	+= snd-soc-ts3a227e.o
diff --git a/sound/soc/codecs/tlv320aic32x4-i2c.c b/sound/soc/codecs/tlv320aic32x4-i2c.c
new file mode 100644
index 0000000..59606cf
--- /dev/null
+++ b/sound/soc/codecs/tlv320aic32x4-i2c.c
@@ -0,0 +1,74 @@
+/*
+ * linux/sound/soc/codecs/tlv320aic32x4-i2c.c
+ *
+ * Copyright 2011 NW Digital Radio
+ *
+ * Author: Jeremy McDermond <nh6z@nh6z.net>
+ *
+ * Based on sound/soc/codecs/wm8974 and TI driver for kernel 2.6.27.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/regmap.h>
+#include <sound/soc.h>
+
+#include "tlv320aic32x4.h"
+
+static int aic32x4_i2c_probe(struct i2c_client *i2c,
+			     const struct i2c_device_id *id)
+{
+	struct regmap *regmap;
+	struct regmap_config config;
+
+	config = aic32x4_regmap_config;
+	config.reg_bits = 8;
+	config.val_bits = 8;
+
+	regmap = devm_regmap_init_i2c(i2c, &config);
+	return aic32x4_probe(&i2c->dev, regmap);
+}
+
+static int aic32x4_i2c_remove(struct i2c_client *i2c)
+{
+	return aic32x4_remove(&i2c->dev);
+}
+
+static const struct i2c_device_id aic32x4_i2c_id[] = {
+	{ "tlv320aic32x4", 0 },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(i2c, aic32x4_i2c_id);
+
+static const struct of_device_id aic32x4_of_id[] = {
+	{ .compatible = "ti,tlv320aic32x4", },
+	{ /* senitel */ }
+};
+MODULE_DEVICE_TABLE(of, aic32x4_of_id);
+
+static struct i2c_driver aic32x4_i2c_driver = {
+	.driver = {
+		.name = "tlv320aic32x4",
+		.of_match_table = aic32x4_of_id,
+	},
+	.probe =    aic32x4_i2c_probe,
+	.remove =   aic32x4_i2c_remove,
+	.id_table = aic32x4_i2c_id,
+};
+
+module_i2c_driver(aic32x4_i2c_driver);
+
+MODULE_DESCRIPTION("ASoC TLV320AIC32x4 codec driver I2C");
+MODULE_AUTHOR("Jeremy McDermond <nh6z@nh6z.net>");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index 9d5b08b..c6b6d55 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -30,7 +30,6 @@
 #include <linux/pm.h>
 #include <linux/gpio.h>
 #include <linux/of_gpio.h>
-#include <linux/i2c.h>
 #include <linux/cdev.h>
 #include <linux/slab.h>
 #include <linux/clk.h>
@@ -287,14 +286,12 @@ static const struct regmap_range_cfg aic32x4_regmap_pages[] = {
 	},
 };
 
-static const struct regmap_config aic32x4_regmap = {
-	.reg_bits = 8,
-	.val_bits = 8,
-
+const struct regmap_config aic32x4_regmap_config = {
 	.max_register = AIC32X4_RMICPGAVOL,
 	.ranges = aic32x4_regmap_pages,
 	.num_ranges = ARRAY_SIZE(aic32x4_regmap_pages),
 };
+EXPORT_SYMBOL(aic32x4_regmap_config);
 
 static inline int aic32x4_get_divs(int mclk, int rate)
 {
@@ -777,24 +774,22 @@ error_ldo:
 	return ret;
 }
 
-static int aic32x4_i2c_probe(struct i2c_client *i2c,
-			     const struct i2c_device_id *id)
+int aic32x4_probe(struct device *dev, struct regmap *regmap)
 {
-	struct aic32x4_pdata *pdata = i2c->dev.platform_data;
 	struct aic32x4_priv *aic32x4;
-	struct device_node *np = i2c->dev.of_node;
+	struct aic32x4_pdata *pdata = dev->platform_data;
+	struct device_node *np = dev->of_node;
 	int ret;
 
-	aic32x4 = devm_kzalloc(&i2c->dev, sizeof(struct aic32x4_priv),
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	aic32x4 = devm_kzalloc(dev, sizeof(struct aic32x4_priv),
 			       GFP_KERNEL);
 	if (aic32x4 == NULL)
 		return -ENOMEM;
 
-	aic32x4->regmap = devm_regmap_init_i2c(i2c, &aic32x4_regmap);
-	if (IS_ERR(aic32x4->regmap))
-		return PTR_ERR(aic32x4->regmap);
-
-	i2c_set_clientdata(i2c, aic32x4);
+	dev_set_drvdata(dev, aic32x4);
 
 	if (pdata) {
 		aic32x4->power_cfg = pdata->power_cfg;
@@ -804,7 +799,7 @@ static int aic32x4_i2c_probe(struct i2c_client *i2c,
 	} else if (np) {
 		ret = aic32x4_parse_dt(aic32x4, np);
 		if (ret) {
-			dev_err(&i2c->dev, "Failed to parse DT node\n");
+			dev_err(dev, "Failed to parse DT node\n");
 			return ret;
 		}
 	} else {
@@ -814,71 +809,48 @@ static int aic32x4_i2c_probe(struct i2c_client *i2c,
 		aic32x4->rstn_gpio = -1;
 	}
 
-	aic32x4->mclk = devm_clk_get(&i2c->dev, "mclk");
+	aic32x4->mclk = devm_clk_get(dev, "mclk");
 	if (IS_ERR(aic32x4->mclk)) {
-		dev_err(&i2c->dev, "Failed getting the mclk. The current implementation does not support the usage of this codec without mclk\n");
+		dev_err(dev, "Failed getting the mclk. The current implementation does not support the usage of this codec without mclk\n");
 		return PTR_ERR(aic32x4->mclk);
 	}
 
 	if (gpio_is_valid(aic32x4->rstn_gpio)) {
-		ret = devm_gpio_request_one(&i2c->dev, aic32x4->rstn_gpio,
+		ret = devm_gpio_request_one(dev, aic32x4->rstn_gpio,
 				GPIOF_OUT_INIT_LOW, "tlv320aic32x4 rstn");
 		if (ret != 0)
 			return ret;
 	}
 
-	ret = aic32x4_setup_regulators(&i2c->dev, aic32x4);
+	ret = aic32x4_setup_regulators(dev, aic32x4);
 	if (ret) {
-		dev_err(&i2c->dev, "Failed to setup regulators\n");
+		dev_err(dev, "Failed to setup regulators\n");
 		return ret;
 	}
 
-	ret = snd_soc_register_codec(&i2c->dev,
+	ret = snd_soc_register_codec(dev,
 			&soc_codec_dev_aic32x4, &aic32x4_dai, 1);
 	if (ret) {
-		dev_err(&i2c->dev, "Failed to register codec\n");
+		dev_err(dev, "Failed to register codec\n");
 		aic32x4_disable_regulators(aic32x4);
 		return ret;
 	}
 
-	i2c_set_clientdata(i2c, aic32x4);
-
 	return 0;
 }
+EXPORT_SYMBOL(aic32x4_probe);
 
-static int aic32x4_i2c_remove(struct i2c_client *client)
+int aic32x4_remove(struct device *dev)
 {
-	struct aic32x4_priv *aic32x4 = i2c_get_clientdata(client);
+	struct aic32x4_priv *aic32x4 = dev_get_drvdata(dev);
 
 	aic32x4_disable_regulators(aic32x4);
 
-	snd_soc_unregister_codec(&client->dev);
+	snd_soc_unregister_codec(dev);
+
 	return 0;
 }
-
-static const struct i2c_device_id aic32x4_i2c_id[] = {
-	{ "tlv320aic32x4", 0 },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, aic32x4_i2c_id);
-
-static const struct of_device_id aic32x4_of_id[] = {
-	{ .compatible = "ti,tlv320aic32x4", },
-	{ /* senitel */ }
-};
-MODULE_DEVICE_TABLE(of, aic32x4_of_id);
-
-static struct i2c_driver aic32x4_i2c_driver = {
-	.driver = {
-		.name = "tlv320aic32x4",
-		.of_match_table = aic32x4_of_id,
-	},
-	.probe =    aic32x4_i2c_probe,
-	.remove =   aic32x4_i2c_remove,
-	.id_table = aic32x4_i2c_id,
-};
-
-module_i2c_driver(aic32x4_i2c_driver);
+EXPORT_SYMBOL(aic32x4_remove);
 
 MODULE_DESCRIPTION("ASoC tlv320aic32x4 codec driver");
 MODULE_AUTHOR("Javier Martin <javier.martin@vista-silicon.com>");
diff --git a/sound/soc/codecs/tlv320aic32x4.h b/sound/soc/codecs/tlv320aic32x4.h
index 995f033..a197dd5 100644
--- a/sound/soc/codecs/tlv320aic32x4.h
+++ b/sound/soc/codecs/tlv320aic32x4.h
@@ -10,6 +10,13 @@
 #ifndef _TLV320AIC32X4_H
 #define _TLV320AIC32X4_H
 
+struct device;
+struct regmap_config;
+
+extern const struct regmap_config aic32x4_regmap_config;
+int aic32x4_probe(struct device *dev, struct regmap *regmap);
+int aic32x4_remove(struct device *dev);
+
 /* tlv320aic32x4 register space (in decimal to match datasheet) */
 
 #define AIC32X4_PAGE1		128
-- 
2.5.0
