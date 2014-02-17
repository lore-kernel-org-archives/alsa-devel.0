From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 4/4] ASoC: adav80x: Split SPI and I2C code into
	different modules
Date: Mon, 17 Feb 2014 13:16:56 +0100
Message-ID: <1392639416-11293-4-git-send-email-lars@metafoo.de>
References: <1392639416-11293-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-011.synserver.de (smtp-out-234.synserver.de
 [212.40.185.234])
 by alsa0.perex.cz (Postfix) with ESMTP id 56BF0261B2F
 for <alsa-devel@alsa-project.org>; Mon, 17 Feb 2014 13:16:49 +0100 (CET)
In-Reply-To: <1392639416-11293-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

There are a few known (minor) problems with having the support code for both I2C
and SPI in the same module:
    * We need to be extra careful to make sure to not build the driver into the
      kernel if one of the subsystems is build as a module (Currently only SPI
      can be build as a module).
    * The module init path error handling is rather ugly. E.g. what should be
      done if either the SPI or the I2C driver fails to register. Most drivers
      that implement SPI and I2C in the same module currently fallback to
      undefined behavior in that case. Splitting the the driver into two
	  modules, one for each bus, allows the registration of the other bus drive
      to continue without problems if one of them fails.

This patch splits the ADAV80X driver into 3 modules. One core module that
implements the device logic, but is independent of the bus method used. And one
module for SPI and I2C each that registers the drivers and sets up the regmap
struct for the bus.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/blackfin/Kconfig |   3 +-
 sound/soc/codecs/Kconfig   |  11 ++++-
 sound/soc/codecs/Makefile  |   4 ++
 sound/soc/codecs/adav801.c |  53 ++++++++++++++++++++
 sound/soc/codecs/adav803.c |  50 +++++++++++++++++++
 sound/soc/codecs/adav80x.c | 117 +++------------------------------------------
 sound/soc/codecs/adav80x.h |   7 +++
 7 files changed, 133 insertions(+), 112 deletions(-)
 create mode 100644 sound/soc/codecs/adav801.c
 create mode 100644 sound/soc/codecs/adav803.c

diff --git a/sound/soc/blackfin/Kconfig b/sound/soc/blackfin/Kconfig
index 89f7748..6347d59 100644
--- a/sound/soc/blackfin/Kconfig
+++ b/sound/soc/blackfin/Kconfig
@@ -47,7 +47,8 @@ config SND_SOC_BFIN_EVAL_ADAV80X
 	tristate "Support for the EVAL-ADAV80X boards on Blackfin eval boards"
 	depends on SND_BF5XX_I2S && SND_SOC_I2C_AND_SPI
 	select SND_BF5XX_SOC_I2S
-	select SND_SOC_ADAV80X
+	select SND_SOC_ADAV801 if SPI_MASTER
+	select SND_SOC_ADAV803 if I2C
 	help
 	  Say Y if you want to add support for the Analog Devices EVAL-ADAV801 or
 	  EVAL-ADAV803 board connected to one of the Blackfin evaluation boards
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index a9b75c5..6d01f91 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -23,7 +23,8 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_AD1980 if SND_SOC_AC97_BUS
 	select SND_SOC_AD73311
 	select SND_SOC_ADAU1373 if I2C
-	select SND_SOC_ADAV80X if SND_SOC_I2C_AND_SPI
+	select SND_SOC_ADAV801 if SPI_MASTER
+	select SND_SOC_ADAV803 if I2C
 	select SND_SOC_ADAU1701 if I2C
 	select SND_SOC_ADS117X
 	select SND_SOC_AK4104 if SPI_MASTER
@@ -213,6 +214,14 @@ config SND_SOC_ADAU1373
 config SND_SOC_ADAV80X
 	tristate
 
+config SND_SOC_ADAV801
+	tristate
+	select SND_SOC_ADAV80X
+
+config SND_SOC_ADAV803
+	tristate
+	select SND_SOC_ADAV80X
+
 config SND_SOC_ADS117X
 	tristate
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 6be463b..c33cf8a 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -10,6 +10,8 @@ snd-soc-ad73311-objs := ad73311.o
 snd-soc-adau1701-objs := adau1701.o
 snd-soc-adau1373-objs := adau1373.o
 snd-soc-adav80x-objs := adav80x.o
+snd-soc-adav801-objs := adav801.o
+snd-soc-adav803-objs := adav803.o
 snd-soc-ads117x-objs := ads117x.o
 snd-soc-ak4104-objs := ak4104.o
 snd-soc-ak4535-objs := ak4535.o
@@ -146,6 +148,8 @@ obj-$(CONFIG_SND_SOC_AD73311) += snd-soc-ad73311.o
 obj-$(CONFIG_SND_SOC_ADAU1373)	+= snd-soc-adau1373.o
 obj-$(CONFIG_SND_SOC_ADAU1701)  += snd-soc-adau1701.o
 obj-$(CONFIG_SND_SOC_ADAV80X)  += snd-soc-adav80x.o
+obj-$(CONFIG_SND_SOC_ADAV801)  += snd-soc-adav801.o
+obj-$(CONFIG_SND_SOC_ADAV803)  += snd-soc-adav803.o
 obj-$(CONFIG_SND_SOC_ADS117X)	+= snd-soc-ads117x.o
 obj-$(CONFIG_SND_SOC_AK4104)	+= snd-soc-ak4104.o
 obj-$(CONFIG_SND_SOC_AK4535)	+= snd-soc-ak4535.o
diff --git a/sound/soc/codecs/adav801.c b/sound/soc/codecs/adav801.c
new file mode 100644
index 0000000..790fce3
--- /dev/null
+++ b/sound/soc/codecs/adav801.c
@@ -0,0 +1,53 @@
+/*
+ * ADAV801 audio driver
+ *
+ * Copyright 2014 Analog Devices Inc.
+ *
+ * Licensed under the GPL-2.
+ */
+
+#include <linux/module.h>
+#include <linux/spi/spi.h>
+#include <linux/regmap.h>
+
+#include <sound/soc.h>
+
+#include "adav80x.h"
+
+static const struct spi_device_id adav80x_spi_id[] = {
+	{ "adav801", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, adav80x_spi_id);
+
+static int adav80x_spi_probe(struct spi_device *spi)
+{
+	struct regmap_config config;
+
+	config = adav80x_regmap_config;
+	config.read_flag_mask = 0x01;
+
+	return adav80x_bus_probe(&spi->dev, devm_regmap_init_spi(spi, &config));
+}
+
+static int adav80x_spi_remove(struct spi_device *spi)
+{
+	snd_soc_unregister_codec(&spi->dev);
+	return 0;
+}
+
+static struct spi_driver adav80x_spi_driver = {
+	.driver = {
+		.name	= "adav801",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= adav80x_spi_probe,
+	.remove		= adav80x_spi_remove,
+	.id_table	= adav80x_spi_id,
+};
+module_spi_driver(adav80x_spi_driver);
+
+MODULE_DESCRIPTION("ASoC ADAV801 driver");
+MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
+MODULE_AUTHOR("Yi Li <yi.li@analog.com>>");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/adav803.c b/sound/soc/codecs/adav803.c
new file mode 100644
index 0000000..66d9fce
--- /dev/null
+++ b/sound/soc/codecs/adav803.c
@@ -0,0 +1,50 @@
+/*
+ * ADAV803 audio driver
+ *
+ * Copyright 2014 Analog Devices Inc.
+ *
+ * Licensed under the GPL-2.
+ */
+
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/regmap.h>
+
+#include <sound/soc.h>
+
+#include "adav80x.h"
+
+static const struct i2c_device_id adav803_id[] = {
+	{ "adav803", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, adav803_id);
+
+static int adav803_probe(struct i2c_client *client,
+			     const struct i2c_device_id *id)
+{
+	return adav80x_bus_probe(&client->dev,
+		devm_regmap_init_i2c(client, &adav80x_regmap_config));
+}
+
+static int adav803_remove(struct i2c_client *client)
+{
+	snd_soc_unregister_codec(&client->dev);
+	return 0;
+}
+
+static struct i2c_driver adav803_driver = {
+	.driver = {
+		.name = "adav803",
+		.owner = THIS_MODULE,
+	},
+	.probe = adav803_probe,
+	.remove = adav803_remove,
+	.id_table = adav803_id,
+};
+module_i2c_driver(adav803_driver);
+
+MODULE_DESCRIPTION("ASoC ADAV803 driver");
+MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
+MODULE_AUTHOR("Yi Li <yi.li@analog.com>>");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/adav80x.c b/sound/soc/codecs/adav80x.c
index a4bd051..09d5609 100644
--- a/sound/soc/codecs/adav80x.c
+++ b/sound/soc/codecs/adav80x.c
@@ -8,17 +8,15 @@
  * Licensed under the GPL-2 or later.
  */
 
-#include <linux/init.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
-#include <linux/i2c.h>
-#include <linux/spi/spi.h>
+#include <linux/regmap.h>
 #include <linux/slab.h>
-#include <sound/core.h>
+
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
-#include <sound/tlv.h>
 #include <sound/soc.h>
+#include <sound/tlv.h>
 
 #include "adav80x.h"
 
@@ -864,10 +862,9 @@ static struct snd_soc_codec_driver adav80x_codec_driver = {
 	.num_dapm_routes = ARRAY_SIZE(adav80x_dapm_routes),
 };
 
-static int adav80x_bus_probe(struct device *dev, struct regmap *regmap)
+int adav80x_bus_probe(struct device *dev, struct regmap *regmap)
 {
 	struct adav80x *adav80x;
-	int ret;
 
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
@@ -882,9 +879,9 @@ static int adav80x_bus_probe(struct device *dev, struct regmap *regmap)
 	return snd_soc_register_codec(dev, &adav80x_codec_driver,
 		adav80x_dais, ARRAY_SIZE(adav80x_dais));
 }
+EXPORT_SYMBOL_GPL(adav80x_bus_probe);
 
-#if defined(CONFIG_SPI_MASTER)
-static const struct regmap_config adav80x_spi_regmap_config = {
+const struct regmap_config adav80x_regmap_config = {
 	.val_bits = 8,
 	.pad_bits = 1,
 	.reg_bits = 7,
@@ -896,107 +893,7 @@ static const struct regmap_config adav80x_spi_regmap_config = {
 	.reg_defaults = adav80x_reg_defaults,
 	.num_reg_defaults = ARRAY_SIZE(adav80x_reg_defaults),
 };
-
-static const struct spi_device_id adav80x_spi_id[] = {
-	{ "adav801", 0 },
-	{ }
-};
-MODULE_DEVICE_TABLE(spi, adav80x_spi_id);
-
-static int adav80x_spi_probe(struct spi_device *spi)
-{
-	return adav80x_bus_probe(&spi->dev,
-		devm_regmap_init_spi(spi, &adav80x_spi_regmap_config));
-}
-
-static int adav80x_spi_remove(struct spi_device *spi)
-{
-	snd_soc_unregister_codec(dev);
-	return 0;
-}
-
-static struct spi_driver adav80x_spi_driver = {
-	.driver = {
-		.name	= "adav801",
-		.owner	= THIS_MODULE,
-	},
-	.probe		= adav80x_spi_probe,
-	.remove		= adav80x_spi_remove,
-	.id_table	= adav80x_spi_id,
-};
-#endif
-
-#if IS_ENABLED(CONFIG_I2C)
-static const struct regmap_config adav80x_i2c_regmap_config = {
-	.val_bits = 8,
-	.pad_bits = 1,
-	.reg_bits = 7,
-
-	.max_register = ADAV80X_PLL_OUTE,
-
-	.cache_type = REGCACHE_RBTREE,
-	.reg_defaults = adav80x_reg_defaults,
-	.num_reg_defaults = ARRAY_SIZE(adav80x_reg_defaults),
-};
-
-static const struct i2c_device_id adav80x_i2c_id[] = {
-	{ "adav803", 0 },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, adav80x_i2c_id);
-
-static int adav80x_i2c_probe(struct i2c_client *client,
-			     const struct i2c_device_id *id)
-{
-	return adav80x_bus_probe(&client->dev,
-		devm_regmap_init_i2c(client, &adav80x_i2c_regmap_config));
-}
-
-static int adav80x_i2c_remove(struct i2c_client *client)
-{
-	snd_soc_unregister_codec(dev);
-	return 0;
-}
-
-static struct i2c_driver adav80x_i2c_driver = {
-	.driver = {
-		.name = "adav803",
-		.owner = THIS_MODULE,
-	},
-	.probe = adav80x_i2c_probe,
-	.remove = adav80x_i2c_remove,
-	.id_table = adav80x_i2c_id,
-};
-#endif
-
-static int __init adav80x_init(void)
-{
-	int ret = 0;
-
-#if IS_ENABLED(CONFIG_I2C)
-	ret = i2c_add_driver(&adav80x_i2c_driver);
-	if (ret)
-		return ret;
-#endif
-
-#if defined(CONFIG_SPI_MASTER)
-	ret = spi_register_driver(&adav80x_spi_driver);
-#endif
-
-	return ret;
-}
-module_init(adav80x_init);
-
-static void __exit adav80x_exit(void)
-{
-#if IS_ENABLED(CONFIG_I2C)
-	i2c_del_driver(&adav80x_i2c_driver);
-#endif
-#if defined(CONFIG_SPI_MASTER)
-	spi_unregister_driver(&adav80x_spi_driver);
-#endif
-}
-module_exit(adav80x_exit);
+EXPORT_SYMBOL_GPL(adav80x_regmap_config);
 
 MODULE_DESCRIPTION("ASoC ADAV80x driver");
 MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
diff --git a/sound/soc/codecs/adav80x.h b/sound/soc/codecs/adav80x.h
index adb0fc7..8a1d7c0 100644
--- a/sound/soc/codecs/adav80x.h
+++ b/sound/soc/codecs/adav80x.h
@@ -9,6 +9,13 @@
 #ifndef _ADAV80X_H
 #define _ADAV80X_H
 
+#include <linux/regmap.h>
+
+struct device;
+
+extern const struct regmap_config adav80x_regmap_config;
+int adav80x_bus_probe(struct device *dev, struct regmap *regmap);
+
 enum adav80x_pll_src {
 	ADAV80X_PLL_SRC_XIN,
 	ADAV80X_PLL_SRC_XTAL,
-- 
1.8.0
