From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH RFT] ASoC: cs4271: Split SPI and I2C code into
 different modules
Date: Mon, 06 Oct 2014 23:09:47 +0800
Message-ID: <1412608187.4950.5.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f181.google.com (mail-pd0-f181.google.com
 [209.85.192.181])
 by alsa0.perex.cz (Postfix) with ESMTP id B5CD926056D
 for <alsa-devel@alsa-project.org>; Mon,  6 Oct 2014 17:09:53 +0200 (CEST)
Received: by mail-pd0-f181.google.com with SMTP id z10so3433130pdj.12
 for <alsa-devel@alsa-project.org>; Mon, 06 Oct 2014 08:09:51 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Brian Austin <brian.austin@cirrus.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Alexander Sverdlin <subaparts@yandex.ru>, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>
List-Id: alsa-devel@alsa-project.org

Currently the cs4271 driver depends on SND_SOC_I2C_AND_SPI.
So the driver cannot be built as built-in if CONFIG_I2C=m.
Split SPI and I2C code into different modules to avoid this issue.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/cirrus/Kconfig      |   3 +-
 sound/soc/codecs/Kconfig      |  18 ++++-
 sound/soc/codecs/Makefile     |   4 ++
 sound/soc/codecs/cs4271-i2c.c |  62 +++++++++++++++++
 sound/soc/codecs/cs4271-spi.c |  55 +++++++++++++++
 sound/soc/codecs/cs4271.c     | 155 +++++-------------------------------------
 sound/soc/codecs/cs4271.h     |  11 +++
 7 files changed, 167 insertions(+), 141 deletions(-)
 create mode 100644 sound/soc/codecs/cs4271-i2c.c
 create mode 100644 sound/soc/codecs/cs4271-spi.c
 create mode 100644 sound/soc/codecs/cs4271.h

diff --git a/sound/soc/cirrus/Kconfig b/sound/soc/cirrus/Kconfig
index 5477c54..7b7fbcd 100644
--- a/sound/soc/cirrus/Kconfig
+++ b/sound/soc/cirrus/Kconfig
@@ -36,7 +36,8 @@ config SND_EP93XX_SOC_EDB93XX
 	tristate "SoC Audio support for Cirrus Logic EDB93xx boards"
 	depends on SND_EP93XX_SOC && (MACH_EDB9301 || MACH_EDB9302 || MACH_EDB9302A || MACH_EDB9307A || MACH_EDB9315A)
 	select SND_EP93XX_SOC_I2S
-	select SND_SOC_CS4271
+	select SND_SOC_CS4271_I2C if I2C
+	select SND_SOC_CS4271_SPI if SPI_MASTER
 	help
 	  Say Y or M here if you want to add support for I2S audio on the
 	  Cirrus Logic EDB93xx boards.
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 351bf48..5ca5f98 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -50,7 +50,8 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_CS42L73 if I2C
 	select SND_SOC_CS4265 if I2C
 	select SND_SOC_CS4270 if I2C
-	select SND_SOC_CS4271 if SND_SOC_I2C_AND_SPI
+	select SND_SOC_CS4271_I2C if I2C
+	select SND_SOC_CS4271_SPI if SPI_MASTER
 	select SND_SOC_CS42XX8_I2C if I2C
 	select SND_SOC_CX20442 if TTY
 	select SND_SOC_DA7210 if I2C
@@ -370,8 +371,19 @@ config SND_SOC_CS4270_VD33_ERRATA
 	depends on SND_SOC_CS4270
 
 config SND_SOC_CS4271
-	tristate "Cirrus Logic CS4271 CODEC"
-	depends on SND_SOC_I2C_AND_SPI
+	tristate
+
+config SND_SOC_CS4271_I2C
+	tristate "Cirrus Logic CS4271 CODEC (I2C)"
+	depends on I2C
+	select SND_SOC_CS4271
+	select REGMAP_I2C
+
+config SND_SOC_CS4271_SPI
+	tristate "Cirrus Logic CS4271 CODEC (SPI)"
+	depends on SPI_MASTER
+	select SND_SOC_CS4271
+	select REGMAP_SPI
 
 config SND_SOC_CS42XX8
 	tristate
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 5dce451..ac7ec31 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -41,6 +41,8 @@ snd-soc-cs42l73-objs := cs42l73.o
 snd-soc-cs4265-objs := cs4265.o
 snd-soc-cs4270-objs := cs4270.o
 snd-soc-cs4271-objs := cs4271.o
+snd-soc-cs4271-i2c-objs := cs4271-i2c.o
+snd-soc-cs4271-spi-objs := cs4271-spi.o
 snd-soc-cs42xx8-objs := cs42xx8.o
 snd-soc-cs42xx8-i2c-objs := cs42xx8-i2c.o
 snd-soc-cx20442-objs := cx20442.o
@@ -217,6 +219,8 @@ obj-$(CONFIG_SND_SOC_CS42L73)	+= snd-soc-cs42l73.o
 obj-$(CONFIG_SND_SOC_CS4265)	+= snd-soc-cs4265.o
 obj-$(CONFIG_SND_SOC_CS4270)	+= snd-soc-cs4270.o
 obj-$(CONFIG_SND_SOC_CS4271)	+= snd-soc-cs4271.o
+obj-$(CONFIG_SND_SOC_CS4271_I2C)	+= snd-soc-cs4271-i2c.o
+obj-$(CONFIG_SND_SOC_CS4271_SPI)	+= snd-soc-cs4271-spi.o
 obj-$(CONFIG_SND_SOC_CS42XX8)	+= snd-soc-cs42xx8.o
 obj-$(CONFIG_SND_SOC_CS42XX8_I2C) += snd-soc-cs42xx8-i2c.o
 obj-$(CONFIG_SND_SOC_CX20442)	+= snd-soc-cx20442.o
diff --git a/sound/soc/codecs/cs4271-i2c.c b/sound/soc/codecs/cs4271-i2c.c
new file mode 100644
index 0000000..b264da0
--- /dev/null
+++ b/sound/soc/codecs/cs4271-i2c.c
@@ -0,0 +1,62 @@
+/*
+ * CS4271 I2C audio driver
+ *
+ * Copyright (c) 2010 Alexander Sverdlin <subaparts@yandex.ru>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/regmap.h>
+#include <sound/soc.h>
+#include "cs4271.h"
+
+static int cs4271_i2c_probe(struct i2c_client *client,
+			     const struct i2c_device_id *id)
+{
+	struct regmap_config config;
+
+	config = cs4271_regmap_config;
+	config.reg_bits = 8;
+	config.val_bits = 8;
+
+	return cs4271_probe(&client->dev,
+			    devm_regmap_init_i2c(client, &config));
+}
+
+static int cs4271_i2c_remove(struct i2c_client *client)
+{
+	snd_soc_unregister_codec(&client->dev);
+	return 0;
+}
+
+static const struct i2c_device_id cs4271_i2c_id[] = {
+	{ "cs4271", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, cs4271_i2c_id);
+
+static struct i2c_driver cs4271_i2c_driver = {
+	.driver = {
+		.name = "cs4271",
+		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(cs4271_dt_ids),
+	},
+	.probe = cs4271_i2c_probe,
+	.remove = cs4271_i2c_remove,
+	.id_table = cs4271_i2c_id,
+};
+module_i2c_driver(cs4271_i2c_driver);
+
+MODULE_DESCRIPTION("ASoC CS4271 I2C Driver");
+MODULE_AUTHOR("Alexander Sverdlin <subaparts@yandex.ru>");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/cs4271-spi.c b/sound/soc/codecs/cs4271-spi.c
new file mode 100644
index 0000000..acd49d8
--- /dev/null
+++ b/sound/soc/codecs/cs4271-spi.c
@@ -0,0 +1,55 @@
+/*
+ * CS4271 SPI audio driver
+ *
+ * Copyright (c) 2010 Alexander Sverdlin <subaparts@yandex.ru>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/module.h>
+#include <linux/spi/spi.h>
+#include <linux/regmap.h>
+#include <sound/soc.h>
+#include "cs4271.h"
+
+static int cs4271_spi_probe(struct spi_device *spi)
+{
+	struct regmap_config config;
+
+	config = cs4271_regmap_config;
+	config.reg_bits = 16;
+	config.val_bits = 8;
+	config.read_flag_mask = 0x21;
+	config.write_flag_mask = 0x20;
+
+	return cs4271_probe(&spi->dev, devm_regmap_init_spi(spi, &config));
+}
+
+static int cs4271_spi_remove(struct spi_device *spi)
+{
+	snd_soc_unregister_codec(&spi->dev);
+	return 0;
+}
+
+static struct spi_driver cs4271_spi_driver = {
+	.driver = {
+		.name	= "cs4271",
+		.owner	= THIS_MODULE,
+		.of_match_table = of_match_ptr(cs4271_dt_ids),
+	},
+	.probe		= cs4271_spi_probe,
+	.remove		= cs4271_spi_remove,
+};
+module_spi_driver(cs4271_spi_driver);
+
+MODULE_DESCRIPTION("ASoC CS4271 SPI Driver");
+MODULE_AUTHOR("Alexander Sverdlin <subaparts@yandex.ru>");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/cs4271.c b/sound/soc/codecs/cs4271.c
index 93cec52..79a4efc 100644
--- a/sound/soc/codecs/cs4271.c
+++ b/sound/soc/codecs/cs4271.c
@@ -23,8 +23,6 @@
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/gpio.h>
-#include <linux/i2c.h>
-#include <linux/spi/spi.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/of_gpio.h>
@@ -32,6 +30,7 @@
 #include <sound/soc.h>
 #include <sound/tlv.h>
 #include <sound/cs4271.h>
+#include "cs4271.h"
 
 #define CS4271_PCM_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | \
 			    SNDRV_PCM_FMTBIT_S24_LE | \
@@ -527,14 +526,15 @@ static int cs4271_soc_resume(struct snd_soc_codec *codec)
 #endif /* CONFIG_PM */
 
 #ifdef CONFIG_OF
-static const struct of_device_id cs4271_dt_ids[] = {
+const struct of_device_id cs4271_dt_ids[] = {
 	{ .compatible = "cirrus,cs4271", },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, cs4271_dt_ids);
+EXPORT_SYMBOL_GPL(cs4271_dt_ids);
 #endif
 
-static int cs4271_probe(struct snd_soc_codec *codec)
+static int cs4271_codec_probe(struct snd_soc_codec *codec)
 {
 	struct cs4271_private *cs4271 = snd_soc_codec_get_drvdata(codec);
 	struct cs4271_platform_data *cs4271plat = codec->dev->platform_data;
@@ -587,7 +587,7 @@ static int cs4271_probe(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static int cs4271_remove(struct snd_soc_codec *codec)
+static int cs4271_codec_remove(struct snd_soc_codec *codec)
 {
 	struct cs4271_private *cs4271 = snd_soc_codec_get_drvdata(codec);
 
@@ -599,8 +599,8 @@ static int cs4271_remove(struct snd_soc_codec *codec)
 };
 
 static struct snd_soc_codec_driver soc_codec_dev_cs4271 = {
-	.probe			= cs4271_probe,
-	.remove			= cs4271_remove,
+	.probe			= cs4271_codec_probe,
+	.remove			= cs4271_codec_remove,
 	.suspend		= cs4271_soc_suspend,
 	.resume			= cs4271_soc_resume,
 
@@ -642,14 +642,8 @@ static int cs4271_common_probe(struct device *dev,
 	return 0;
 }
 
-#if defined(CONFIG_SPI_MASTER)
-
-static const struct regmap_config cs4271_spi_regmap = {
-	.reg_bits = 16,
-	.val_bits = 8,
+const struct regmap_config cs4271_regmap_config = {
 	.max_register = CS4271_LASTREG,
-	.read_flag_mask = 0x21,
-	.write_flag_mask = 0x20,
 
 	.reg_defaults = cs4271_reg_defaults,
 	.num_reg_defaults = ARRAY_SIZE(cs4271_reg_defaults),
@@ -657,140 +651,27 @@ static const struct regmap_config cs4271_spi_regmap = {
 
 	.volatile_reg = cs4271_volatile_reg,
 };
+EXPORT_SYMBOL_GPL(cs4271_regmap_config);
 
-static int cs4271_spi_probe(struct spi_device *spi)
+int cs4271_probe(struct device *dev, struct regmap *regmap)
 {
 	struct cs4271_private *cs4271;
 	int ret;
 
-	ret = cs4271_common_probe(&spi->dev, &cs4271);
-	if (ret < 0)
-		return ret;
-
-	spi_set_drvdata(spi, cs4271);
-	cs4271->regmap = devm_regmap_init_spi(spi, &cs4271_spi_regmap);
-	if (IS_ERR(cs4271->regmap))
-		return PTR_ERR(cs4271->regmap);
-
-	return snd_soc_register_codec(&spi->dev, &soc_codec_dev_cs4271,
-		&cs4271_dai, 1);
-}
-
-static int cs4271_spi_remove(struct spi_device *spi)
-{
-	snd_soc_unregister_codec(&spi->dev);
-	return 0;
-}
-
-static struct spi_driver cs4271_spi_driver = {
-	.driver = {
-		.name	= "cs4271",
-		.owner	= THIS_MODULE,
-		.of_match_table = of_match_ptr(cs4271_dt_ids),
-	},
-	.probe		= cs4271_spi_probe,
-	.remove		= cs4271_spi_remove,
-};
-#endif /* defined(CONFIG_SPI_MASTER) */
-
-#if IS_ENABLED(CONFIG_I2C)
-static const struct i2c_device_id cs4271_i2c_id[] = {
-	{"cs4271", 0},
-	{}
-};
-MODULE_DEVICE_TABLE(i2c, cs4271_i2c_id);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
 
-static const struct regmap_config cs4271_i2c_regmap = {
-	.reg_bits = 8,
-	.val_bits = 8,
-	.max_register = CS4271_LASTREG,
-
-	.reg_defaults = cs4271_reg_defaults,
-	.num_reg_defaults = ARRAY_SIZE(cs4271_reg_defaults),
-	.cache_type = REGCACHE_RBTREE,
-
-	.volatile_reg = cs4271_volatile_reg,
-};
-
-static int cs4271_i2c_probe(struct i2c_client *client,
-			    const struct i2c_device_id *id)
-{
-	struct cs4271_private *cs4271;
-	int ret;
-
-	ret = cs4271_common_probe(&client->dev, &cs4271);
+	ret = cs4271_common_probe(dev, &cs4271);
 	if (ret < 0)
 		return ret;
 
-	i2c_set_clientdata(client, cs4271);
-	cs4271->regmap = devm_regmap_init_i2c(client, &cs4271_i2c_regmap);
-	if (IS_ERR(cs4271->regmap))
-		return PTR_ERR(cs4271->regmap);
+	dev_set_drvdata(dev, cs4271);
+	cs4271->regmap = regmap;
 
-	return snd_soc_register_codec(&client->dev, &soc_codec_dev_cs4271,
-		&cs4271_dai, 1);
-}
-
-static int cs4271_i2c_remove(struct i2c_client *client)
-{
-	snd_soc_unregister_codec(&client->dev);
-	return 0;
-}
-
-static struct i2c_driver cs4271_i2c_driver = {
-	.driver = {
-		.name	= "cs4271",
-		.owner	= THIS_MODULE,
-		.of_match_table = of_match_ptr(cs4271_dt_ids),
-	},
-	.id_table	= cs4271_i2c_id,
-	.probe		= cs4271_i2c_probe,
-	.remove		= cs4271_i2c_remove,
-};
-#endif /* IS_ENABLED(CONFIG_I2C) */
-
-/*
- * We only register our serial bus driver here without
- * assignment to particular chip. So if any of the below
- * fails, there is some problem with I2C or SPI subsystem.
- * In most cases this module will be compiled with support
- * of only one serial bus.
- */
-static int __init cs4271_modinit(void)
-{
-	int ret;
-
-#if IS_ENABLED(CONFIG_I2C)
-	ret = i2c_add_driver(&cs4271_i2c_driver);
-	if (ret) {
-		pr_err("Failed to register CS4271 I2C driver: %d\n", ret);
-		return ret;
-	}
-#endif
-
-#if defined(CONFIG_SPI_MASTER)
-	ret = spi_register_driver(&cs4271_spi_driver);
-	if (ret) {
-		pr_err("Failed to register CS4271 SPI driver: %d\n", ret);
-		return ret;
-	}
-#endif
-
-	return 0;
-}
-module_init(cs4271_modinit);
-
-static void __exit cs4271_modexit(void)
-{
-#if defined(CONFIG_SPI_MASTER)
-	spi_unregister_driver(&cs4271_spi_driver);
-#endif
-
-#if IS_ENABLED(CONFIG_I2C)
-	i2c_del_driver(&cs4271_i2c_driver);
-#endif
+	return snd_soc_register_codec(dev, &soc_codec_dev_cs4271, &cs4271_dai,
+				      1);
 }
-module_exit(cs4271_modexit);
+EXPORT_SYMBOL_GPL(cs4271_probe);
 
 MODULE_AUTHOR("Alexander Sverdlin <subaparts@yandex.ru>");
 MODULE_DESCRIPTION("Cirrus Logic CS4271 ALSA SoC Codec Driver");
diff --git a/sound/soc/codecs/cs4271.h b/sound/soc/codecs/cs4271.h
new file mode 100644
index 0000000..9adad8e
--- /dev/null
+++ b/sound/soc/codecs/cs4271.h
@@ -0,0 +1,11 @@
+#ifndef _CS4271_PRIV_H
+#define _CS4271_PRIV_H
+
+#include <linux/regmap.h>
+
+extern const struct of_device_id cs4271_dt_ids[];
+extern const struct regmap_config cs4271_regmap_config;
+
+int cs4271_probe(struct device *dev, struct regmap *regmap);
+
+#endif
-- 
1.9.1
