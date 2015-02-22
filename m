From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: wm8804: Split out bus drivers
Date: Sun, 22 Feb 2015 16:43:21 +0000
Message-ID: <1424623402-473-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 166FA2607E9
 for <alsa-devel@alsa-project.org>; Sun, 22 Feb 2015 17:45:14 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

From: Charles Keepax <ckeepax@gmail.com>

Simplify dependencies by using new style split out bus interfaces.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/Kconfig      |   18 +++++-
 sound/soc/codecs/Makefile     |    4 +
 sound/soc/codecs/wm8804-i2c.c |   64 +++++++++++++++++++
 sound/soc/codecs/wm8804-spi.c |   56 ++++++++++++++++
 sound/soc/codecs/wm8804.c     |  139 +++++------------------------------------
 sound/soc/codecs/wm8804.h     |    7 ++
 6 files changed, 162 insertions(+), 126 deletions(-)
 create mode 100644 sound/soc/codecs/wm8804-i2c.c
 create mode 100644 sound/soc/codecs/wm8804-spi.c

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index ea9f0e3..0bddd92 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -141,7 +141,8 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_WM8770 if SPI_MASTER
 	select SND_SOC_WM8776 if SND_SOC_I2C_AND_SPI
 	select SND_SOC_WM8782
-	select SND_SOC_WM8804 if SND_SOC_I2C_AND_SPI
+	select SND_SOC_WM8804_I2C if I2C
+	select SND_SOC_WM8804_SPI if SPI_MASTER
 	select SND_SOC_WM8900 if I2C
 	select SND_SOC_WM8903 if I2C
 	select SND_SOC_WM8904 if I2C
@@ -744,8 +745,19 @@ config SND_SOC_WM8782
 	tristate
 
 config SND_SOC_WM8804
-	tristate "Wolfson Microelectronics WM8804 S/PDIF transceiver"
-	depends on SND_SOC_I2C_AND_SPI
+	tristate
+
+config SND_SOC_WM8804_I2C
+	tristate "Wolfson Microelectronics WM8804 S/PDIF transceiver I2C"
+	depends on I2C
+	select SND_SOC_WM8804
+	select REGMAP_I2C
+
+config SND_SOC_WM8804_SPI
+	tristate "Wolfson Microelectronics WM8804 S/PDIF transceiver SPI"
+	depends on SPI_MASTER
+	select SND_SOC_WM8804
+	select REGMAP_SPI
 
 config SND_SOC_WM8900
 	tristate
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 69b8666..7acb6c1 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -145,6 +145,8 @@ snd-soc-wm8770-objs := wm8770.o
 snd-soc-wm8776-objs := wm8776.o
 snd-soc-wm8782-objs := wm8782.o
 snd-soc-wm8804-objs := wm8804.o
+snd-soc-wm8804-i2c-objs := wm8804-i2c.o
+snd-soc-wm8804-spi-objs := wm8804-spi.o
 snd-soc-wm8900-objs := wm8900.o
 snd-soc-wm8903-objs := wm8903.o
 snd-soc-wm8904-objs := wm8904.o
@@ -323,6 +325,8 @@ obj-$(CONFIG_SND_SOC_WM8770)	+= snd-soc-wm8770.o
 obj-$(CONFIG_SND_SOC_WM8776)	+= snd-soc-wm8776.o
 obj-$(CONFIG_SND_SOC_WM8782)	+= snd-soc-wm8782.o
 obj-$(CONFIG_SND_SOC_WM8804)	+= snd-soc-wm8804.o
+obj-$(CONFIG_SND_SOC_WM8804_I2C) += snd-soc-wm8804-i2c.o
+obj-$(CONFIG_SND_SOC_WM8804_SPI) += snd-soc-wm8804-spi.o
 obj-$(CONFIG_SND_SOC_WM8900)	+= snd-soc-wm8900.o
 obj-$(CONFIG_SND_SOC_WM8903)	+= snd-soc-wm8903.o
 obj-$(CONFIG_SND_SOC_WM8904)	+= snd-soc-wm8904.o
diff --git a/sound/soc/codecs/wm8804-i2c.c b/sound/soc/codecs/wm8804-i2c.c
new file mode 100644
index 0000000..5bd4af2
--- /dev/null
+++ b/sound/soc/codecs/wm8804-i2c.c
@@ -0,0 +1,64 @@
+/*
+ * wm8804-i2c.c  --  WM8804 S/PDIF transceiver driver - I2C
+ *
+ * Copyright 2015 Cirrus Logic Inc
+ *
+ * Author: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/i2c.h>
+
+#include "wm8804.h"
+
+static int wm8804_i2c_probe(struct i2c_client *i2c,
+			    const struct i2c_device_id *id)
+{
+	struct regmap *regmap;
+
+	regmap = devm_regmap_init_i2c(i2c, &wm8804_regmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	return wm8804_probe(&i2c->dev, regmap);
+}
+
+static int wm8804_i2c_remove(struct i2c_client *i2c)
+{
+	wm8804_remove(&i2c->dev);
+	return 0;
+}
+
+static const struct i2c_device_id wm8804_i2c_id[] = {
+	{ "wm8804", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, wm8804_i2c_id);
+
+static const struct of_device_id wm8804_of_match[] = {
+	{ .compatible = "wlf,wm8804", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, wm8804_of_match);
+
+static struct i2c_driver wm8804_i2c_driver = {
+	.driver = {
+		.name = "wm8804",
+		.owner = THIS_MODULE,
+		.of_match_table = wm8804_of_match,
+	},
+	.probe = wm8804_i2c_probe,
+	.remove = wm8804_i2c_remove,
+	.id_table = wm8804_i2c_id
+};
+
+module_i2c_driver(wm8804_i2c_driver);
+
+MODULE_DESCRIPTION("ASoC WM8804 driver - I2C");
+MODULE_AUTHOR("Charles Keepax <ckeepax@opensource.wolfsonmicro.com>");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/wm8804-spi.c b/sound/soc/codecs/wm8804-spi.c
new file mode 100644
index 0000000..287e11e
--- /dev/null
+++ b/sound/soc/codecs/wm8804-spi.c
@@ -0,0 +1,56 @@
+/*
+ * wm8804-spi.c  --  WM8804 S/PDIF transceiver driver - SPI
+ *
+ * Copyright 2015 Cirrus Logic Inc
+ *
+ * Author: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/spi/spi.h>
+
+#include "wm8804.h"
+
+static int wm8804_spi_probe(struct spi_device *spi)
+{
+	struct regmap *regmap;
+
+	regmap = devm_regmap_init_spi(spi, &wm8804_regmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	return wm8804_probe(&spi->dev, regmap);
+}
+
+static int wm8804_spi_remove(struct spi_device *spi)
+{
+	wm8804_remove(&spi->dev);
+	return 0;
+}
+
+static const struct of_device_id wm8804_of_match[] = {
+	{ .compatible = "wlf,wm8804", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, wm8804_of_match);
+
+static struct spi_driver wm8804_spi_driver = {
+	.driver = {
+		.name = "wm8804",
+		.owner = THIS_MODULE,
+		.of_match_table = wm8804_of_match,
+	},
+	.probe = wm8804_spi_probe,
+	.remove = wm8804_spi_remove
+};
+
+module_spi_driver(wm8804_spi_driver);
+
+MODULE_DESCRIPTION("ASoC WM8804 driver - SPI");
+MODULE_AUTHOR("Charles Keepax <ckeepax@opensource.wolfsonmicro.com>");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/wm8804.c b/sound/soc/codecs/wm8804.c
index b2b0e68..b5a04fc 100644
--- a/sound/soc/codecs/wm8804.c
+++ b/sound/soc/codecs/wm8804.c
@@ -15,10 +15,7 @@
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/pm.h>
-#include <linux/i2c.h>
 #include <linux/of_device.h>
-#include <linux/spi/spi.h>
-#include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <sound/core.h>
@@ -518,7 +515,7 @@ static int wm8804_set_bias_level(struct snd_soc_codec *codec,
 	return 0;
 }
 
-static int wm8804_remove(struct snd_soc_codec *codec)
+static int wm8804_codec_remove(struct snd_soc_codec *codec)
 {
 	struct wm8804_priv *wm8804;
 	int i;
@@ -531,7 +528,7 @@ static int wm8804_remove(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static int wm8804_probe(struct snd_soc_codec *codec)
+static int wm8804_codec_probe(struct snd_soc_codec *codec)
 {
 	struct wm8804_priv *wm8804;
 	int i, id1, id2, ret;
@@ -649,8 +646,8 @@ static struct snd_soc_dai_driver wm8804_dai = {
 };
 
 static const struct snd_soc_codec_driver soc_codec_dev_wm8804 = {
-	.probe = wm8804_probe,
-	.remove = wm8804_remove,
+	.probe = wm8804_codec_probe,
+	.remove = wm8804_codec_remove,
 	.set_bias_level = wm8804_set_bias_level,
 	.idle_bias_off = true,
 
@@ -658,13 +655,7 @@ static const struct snd_soc_codec_driver soc_codec_dev_wm8804 = {
 	.num_controls = ARRAY_SIZE(wm8804_snd_controls),
 };
 
-static const struct of_device_id wm8804_of_match[] = {
-	{ .compatible = "wlf,wm8804", },
-	{ }
-};
-MODULE_DEVICE_TABLE(of, wm8804_of_match);
-
-static const struct regmap_config wm8804_regmap_config = {
+const struct regmap_config wm8804_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
 
@@ -675,128 +666,30 @@ static const struct regmap_config wm8804_regmap_config = {
 	.reg_defaults = wm8804_reg_defaults,
 	.num_reg_defaults = ARRAY_SIZE(wm8804_reg_defaults),
 };
+EXPORT_SYMBOL_GPL(wm8804_regmap_config);
 
-#if defined(CONFIG_SPI_MASTER)
-static int wm8804_spi_probe(struct spi_device *spi)
+int wm8804_probe(struct device *dev, struct regmap *regmap)
 {
 	struct wm8804_priv *wm8804;
-	int ret;
 
-	wm8804 = devm_kzalloc(&spi->dev, sizeof *wm8804, GFP_KERNEL);
+	wm8804 = devm_kzalloc(dev, sizeof(*wm8804), GFP_KERNEL);
 	if (!wm8804)
 		return -ENOMEM;
 
-	wm8804->regmap = devm_regmap_init_spi(spi, &wm8804_regmap_config);
-	if (IS_ERR(wm8804->regmap)) {
-		ret = PTR_ERR(wm8804->regmap);
-		return ret;
-	}
-
-	spi_set_drvdata(spi, wm8804);
+	dev_set_drvdata(dev, wm8804);
 
-	ret = snd_soc_register_codec(&spi->dev,
-				     &soc_codec_dev_wm8804, &wm8804_dai, 1);
-
-	return ret;
-}
-
-static int wm8804_spi_remove(struct spi_device *spi)
-{
-	snd_soc_unregister_codec(&spi->dev);
-	return 0;
-}
-
-static struct spi_driver wm8804_spi_driver = {
-	.driver = {
-		.name = "wm8804",
-		.owner = THIS_MODULE,
-		.of_match_table = wm8804_of_match,
-	},
-	.probe = wm8804_spi_probe,
-	.remove = wm8804_spi_remove
-};
-#endif
-
-#if IS_ENABLED(CONFIG_I2C)
-static int wm8804_i2c_probe(struct i2c_client *i2c,
-			    const struct i2c_device_id *id)
-{
-	struct wm8804_priv *wm8804;
-	int ret;
-
-	wm8804 = devm_kzalloc(&i2c->dev, sizeof *wm8804, GFP_KERNEL);
-	if (!wm8804)
-		return -ENOMEM;
+	wm8804->regmap = regmap;
 
-	wm8804->regmap = devm_regmap_init_i2c(i2c, &wm8804_regmap_config);
-	if (IS_ERR(wm8804->regmap)) {
-		ret = PTR_ERR(wm8804->regmap);
-		return ret;
-	}
-
-	i2c_set_clientdata(i2c, wm8804);
-
-	ret = snd_soc_register_codec(&i2c->dev,
-				     &soc_codec_dev_wm8804, &wm8804_dai, 1);
-	return ret;
-}
-
-static int wm8804_i2c_remove(struct i2c_client *i2c)
-{
-	snd_soc_unregister_codec(&i2c->dev);
-	return 0;
-}
-
-static const struct i2c_device_id wm8804_i2c_id[] = {
-	{ "wm8804", 0 },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, wm8804_i2c_id);
-
-static struct i2c_driver wm8804_i2c_driver = {
-	.driver = {
-		.name = "wm8804",
-		.owner = THIS_MODULE,
-		.of_match_table = wm8804_of_match,
-	},
-	.probe = wm8804_i2c_probe,
-	.remove = wm8804_i2c_remove,
-	.id_table = wm8804_i2c_id
-};
-#endif
-
-static int __init wm8804_modinit(void)
-{
-	int ret = 0;
-
-#if IS_ENABLED(CONFIG_I2C)
-	ret = i2c_add_driver(&wm8804_i2c_driver);
-	if (ret) {
-		printk(KERN_ERR "Failed to register wm8804 I2C driver: %d\n",
-		       ret);
-	}
-#endif
-#if defined(CONFIG_SPI_MASTER)
-	ret = spi_register_driver(&wm8804_spi_driver);
-	if (ret != 0) {
-		printk(KERN_ERR "Failed to register wm8804 SPI driver: %d\n",
-		       ret);
-	}
-#endif
-	return ret;
+	return snd_soc_register_codec(dev, &soc_codec_dev_wm8804,
+				      &wm8804_dai, 1);
 }
-module_init(wm8804_modinit);
+EXPORT_SYMBOL_GPL(wm8804_probe);
 
-static void __exit wm8804_exit(void)
+void wm8804_remove(struct device *dev)
 {
-#if IS_ENABLED(CONFIG_I2C)
-	i2c_del_driver(&wm8804_i2c_driver);
-#endif
-#if defined(CONFIG_SPI_MASTER)
-	spi_unregister_driver(&wm8804_spi_driver);
-#endif
+	snd_soc_unregister_codec(dev);
 }
-module_exit(wm8804_exit);
+EXPORT_SYMBOL_GPL(wm8804_remove);
 
 MODULE_DESCRIPTION("ASoC WM8804 driver");
 MODULE_AUTHOR("Dimitris Papastamos <dp@opensource.wolfsonmicro.com>");
diff --git a/sound/soc/codecs/wm8804.h b/sound/soc/codecs/wm8804.h
index e72d4f4..a39a256 100644
--- a/sound/soc/codecs/wm8804.h
+++ b/sound/soc/codecs/wm8804.h
@@ -13,6 +13,8 @@
 #ifndef _WM8804_H
 #define _WM8804_H
 
+#include <linux/regmap.h>
+
 /*
  * Register values.
  */
@@ -62,4 +64,9 @@
 #define WM8804_MCLKDIV_256FS			0
 #define WM8804_MCLKDIV_128FS			1
 
+extern const struct regmap_config wm8804_regmap_config;
+
+int wm8804_probe(struct device *dev, struct regmap *regmap);
+void wm8804_remove(struct device *dev);
+
 #endif  /* _WM8804_H */
-- 
1.7.2.5
