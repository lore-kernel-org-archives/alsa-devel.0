From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: pcm512x: Split out bus drivers
Date: Fri,  7 Mar 2014 11:46:08 +0800
Message-ID: <1394163968-18217-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BECA326593D
 for <alsa-devel@alsa-project.org>; Fri,  7 Mar 2014 04:46:24 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

Move to the new style of defining the bus interfaces in separate modules
in order to simplify dependencies.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/Kconfig       |  18 +++++-
 sound/soc/codecs/Makefile      |   4 ++
 sound/soc/codecs/pcm512x-i2c.c |  71 ++++++++++++++++++++++
 sound/soc/codecs/pcm512x-spi.c |  69 +++++++++++++++++++++
 sound/soc/codecs/pcm512x.c     | 133 +++--------------------------------------
 sound/soc/codecs/pcm512x.h     |   9 +++
 6 files changed, 175 insertions(+), 129 deletions(-)
 create mode 100644 sound/soc/codecs/pcm512x-i2c.c
 create mode 100644 sound/soc/codecs/pcm512x-spi.c

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index f2383eb..3a6046f 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -66,7 +66,8 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_PCM1681 if I2C
 	select SND_SOC_PCM1792A if SPI_MASTER
 	select SND_SOC_PCM3008
-	select SND_SOC_PCM512x if SND_SOC_I2C_AND_SPI
+	select SND_SOC_PCM512x_I2C if I2C
+	select SND_SOC_PCM512x_SPI if SPI_MASTER
 	select SND_SOC_RT5631 if I2C
 	select SND_SOC_RT5640 if I2C
 	select SND_SOC_SGTL5000 if I2C
@@ -362,8 +363,19 @@ config SND_SOC_PCM3008
        tristate
 
 config SND_SOC_PCM512x
-       tristate "Texas Instruments PCM512x CODECs"
-       select REGMAP
+	tristate
+
+config SND_SOC_PCM512x_I2C
+	tristate "Texas Instruments PCM512x CODECs - I2C"
+	depends on I2C
+	select SND_SOC_PCM512x
+	select REGMAP_I2C
+
+config SND_SOC_PCM512x_SPI
+	tristate "Texas Instruments PCM512x CODECs - SPI"
+	depends on SPI_MASTER
+	select SND_SOC_PCM512x
+	select REGMAP_SPI
 
 config SND_SOC_RT5631
 	tristate
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 6af7a55..ac7025c 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -54,6 +54,8 @@ snd-soc-pcm1681-objs := pcm1681.o
 snd-soc-pcm1792a-codec-objs := pcm1792a.o
 snd-soc-pcm3008-objs := pcm3008.o
 snd-soc-pcm512x-objs := pcm512x.o
+snd-soc-pcm512x-i2c-objs := pcm512x-i2c.o
+snd-soc-pcm512x-spi-objs := pcm512x-spi.o
 snd-soc-rt5631-objs := rt5631.o
 snd-soc-rt5640-objs := rt5640.o
 snd-soc-sgtl5000-objs := sgtl5000.o
@@ -197,6 +199,8 @@ obj-$(CONFIG_SND_SOC_PCM1681)	+= snd-soc-pcm1681.o
 obj-$(CONFIG_SND_SOC_PCM1792A)	+= snd-soc-pcm1792a-codec.o
 obj-$(CONFIG_SND_SOC_PCM3008)	+= snd-soc-pcm3008.o
 obj-$(CONFIG_SND_SOC_PCM512x)	+= snd-soc-pcm512x.o
+obj-$(CONFIG_SND_SOC_PCM512x_I2C)	+= snd-soc-pcm512x-i2c.o
+obj-$(CONFIG_SND_SOC_PCM512x_SPI)	+= snd-soc-pcm512x-spi.o
 obj-$(CONFIG_SND_SOC_RT5631)	+= snd-soc-rt5631.o
 obj-$(CONFIG_SND_SOC_RT5640)	+= snd-soc-rt5640.o
 obj-$(CONFIG_SND_SOC_SGTL5000)  += snd-soc-sgtl5000.o
diff --git a/sound/soc/codecs/pcm512x-i2c.c b/sound/soc/codecs/pcm512x-i2c.c
new file mode 100644
index 0000000..4d62230
--- /dev/null
+++ b/sound/soc/codecs/pcm512x-i2c.c
@@ -0,0 +1,71 @@
+/*
+ * Driver for the PCM512x CODECs
+ *
+ * Author:	Mark Brown <broonie@linaro.org>
+ *		Copyright 2014 Linaro Ltd
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/i2c.h>
+
+#include "pcm512x.h"
+
+static int pcm512x_i2c_probe(struct i2c_client *i2c,
+			     const struct i2c_device_id *id)
+{
+	struct regmap *regmap;
+
+	regmap = devm_regmap_init_i2c(i2c, &pcm512x_regmap);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	return pcm512x_probe(&i2c->dev, regmap);
+}
+
+static int pcm512x_i2c_remove(struct i2c_client *i2c)
+{
+	pcm512x_remove(&i2c->dev);
+	return 0;
+}
+
+static const struct i2c_device_id pcm512x_i2c_id[] = {
+	{ "pcm5121", },
+	{ "pcm5122", },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, pcm512x_i2c_id);
+
+static const struct of_device_id pcm512x_of_match[] = {
+	{ .compatible = "ti,pcm5121", },
+	{ .compatible = "ti,pcm5122", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, pcm512x_of_match);
+
+static struct i2c_driver pcm512x_i2c_driver = {
+	.probe 		= pcm512x_i2c_probe,
+	.remove 	= pcm512x_i2c_remove,
+	.id_table	= pcm512x_i2c_id,
+	.driver		= {
+		.name	= "pcm512x",
+		.owner	= THIS_MODULE,
+		.of_match_table = pcm512x_of_match,
+		.pm     = &pcm512x_pm_ops,
+	},
+};
+
+module_i2c_driver(pcm512x_i2c_driver);
+
+MODULE_DESCRIPTION("ASoC PCM512x codec driver - I2C");
+MODULE_AUTHOR("Mark Brown <broonie@linaro.org>");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/codecs/pcm512x-spi.c b/sound/soc/codecs/pcm512x-spi.c
new file mode 100644
index 0000000..f297058
--- /dev/null
+++ b/sound/soc/codecs/pcm512x-spi.c
@@ -0,0 +1,69 @@
+/*
+ * Driver for the PCM512x CODECs
+ *
+ * Author:	Mark Brown <broonie@linaro.org>
+ *		Copyright 2014 Linaro Ltd
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/spi/spi.h>
+
+#include "pcm512x.h"
+
+static int pcm512x_spi_probe(struct spi_device *spi)
+{
+	struct regmap *regmap;
+	int ret;
+
+	regmap = devm_regmap_init_spi(spi, &pcm512x_regmap);
+	if (IS_ERR(regmap)) {
+		ret = PTR_ERR(regmap);
+		return ret;
+	}
+
+	return pcm512x_probe(&spi->dev, regmap);
+}
+
+static int pcm512x_spi_remove(struct spi_device *spi)
+{
+	pcm512x_remove(&spi->dev);
+	return 0;
+}
+
+static const struct spi_device_id pcm512x_spi_id[] = {
+	{ "pcm5121", },
+	{ "pcm5122", },
+	{ },
+};
+MODULE_DEVICE_TABLE(spi, pcm512x_spi_id);
+
+static const struct of_device_id pcm512x_of_match[] = {
+	{ .compatible = "ti,pcm5121", },
+	{ .compatible = "ti,pcm5122", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, pcm512x_of_match);
+
+static struct spi_driver pcm512x_spi_driver = {
+	.probe		= pcm512x_spi_probe,
+	.remove		= pcm512x_spi_remove,
+	.id_table	= pcm512x_spi_id,
+	.driver = {
+		.name	= "pcm512x",
+		.owner	= THIS_MODULE,
+		.of_match_table = pcm512x_of_match,
+		.pm     = &pcm512x_pm_ops,
+	},
+};
+
+module_spi_driver(pcm512x_spi_driver);
diff --git a/sound/soc/codecs/pcm512x.c b/sound/soc/codecs/pcm512x.c
index a035ba8..0014d14 100644
--- a/sound/soc/codecs/pcm512x.c
+++ b/sound/soc/codecs/pcm512x.c
@@ -18,11 +18,9 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/clk.h>
-#include <linux/i2c.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
-#include <linux/spi/spi.h>
 #include <sound/soc.h>
 #include <sound/soc-dapm.h>
 #include <sound/tlv.h>
@@ -375,7 +373,7 @@ static const struct regmap_range_cfg pcm512x_range = {
 	.window_start = 0, .window_len = 0x100,
 };
 
-static const struct regmap_config pcm512x_regmap = {
+const struct regmap_config pcm512x_regmap = {
 	.reg_bits = 8,
 	.val_bits = 8,
 
@@ -391,14 +389,7 @@ static const struct regmap_config pcm512x_regmap = {
 	.cache_type = REGCACHE_RBTREE,
 };
 
-static const struct of_device_id pcm512x_of_match[] = {
-	{ .compatible = "ti,pcm5121", },
-	{ .compatible = "ti,pcm5122", },
-	{ }
-};
-MODULE_DEVICE_TABLE(of, pcm512x_of_match);
-
-static int pcm512x_probe(struct device *dev, struct regmap *regmap)
+int pcm512x_probe(struct device *dev, struct regmap *regmap)
 {
 	struct pcm512x_priv *pcm512x;
 	int i, ret;
@@ -510,8 +501,9 @@ err:
 				     pcm512x->supplies);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(pcm512x_probe);
 
-static void pcm512x_remove(struct device *dev)
+void pcm512x_remove(struct device *dev)
 {
 	struct pcm512x_priv *pcm512x = dev_get_drvdata(dev);
 
@@ -522,6 +514,7 @@ static void pcm512x_remove(struct device *dev)
 	regulator_bulk_disable(ARRAY_SIZE(pcm512x->supplies),
 			       pcm512x->supplies);
 }
+EXPORT_SYMBOL_GPL(pcm512x_remove);
 
 static int pcm512x_suspend(struct device *dev)
 {
@@ -585,122 +578,10 @@ static int pcm512x_resume(struct device *dev)
 	return 0;
 }
 
-static const struct dev_pm_ops pcm512x_pm_ops = {
+const struct dev_pm_ops pcm512x_pm_ops = {
 	SET_RUNTIME_PM_OPS(pcm512x_suspend, pcm512x_resume, NULL)
 };
-
-#if IS_ENABLED(CONFIG_I2C)
-static int pcm512x_i2c_probe(struct i2c_client *i2c,
-			     const struct i2c_device_id *id)
-{
-	struct regmap *regmap;
-
-	regmap = devm_regmap_init_i2c(i2c, &pcm512x_regmap);
-	if (IS_ERR(regmap))
-		return PTR_ERR(regmap);
-
-	return pcm512x_probe(&i2c->dev, regmap);
-}
-
-static int pcm512x_i2c_remove(struct i2c_client *i2c)
-{
-	pcm512x_remove(&i2c->dev);
-	return 0;
-}
-
-static const struct i2c_device_id pcm512x_i2c_id[] = {
-	{ "pcm5121", },
-	{ "pcm5122", },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, pcm512x_i2c_id);
-
-static struct i2c_driver pcm512x_i2c_driver = {
-	.probe 		= pcm512x_i2c_probe,
-	.remove 	= pcm512x_i2c_remove,
-	.id_table	= pcm512x_i2c_id,
-	.driver		= {
-		.name	= "pcm512x",
-		.owner	= THIS_MODULE,
-		.of_match_table = pcm512x_of_match,
-		.pm     = &pcm512x_pm_ops,
-	},
-};
-#endif
-
-#if defined(CONFIG_SPI_MASTER)
-static int pcm512x_spi_probe(struct spi_device *spi)
-{
-	struct regmap *regmap;
-	int ret;
-
-	regmap = devm_regmap_init_spi(spi, &pcm512x_regmap);
-	if (IS_ERR(regmap)) {
-		ret = PTR_ERR(regmap);
-		return ret;
-	}
-
-	return pcm512x_probe(&spi->dev, regmap);
-}
-
-static int pcm512x_spi_remove(struct spi_device *spi)
-{
-	pcm512x_remove(&spi->dev);
-	return 0;
-}
-
-static const struct spi_device_id pcm512x_spi_id[] = {
-	{ "pcm5121", },
-	{ "pcm5122", },
-	{ },
-};
-MODULE_DEVICE_TABLE(spi, pcm512x_spi_id);
-
-static struct spi_driver pcm512x_spi_driver = {
-	.probe		= pcm512x_spi_probe,
-	.remove		= pcm512x_spi_remove,
-	.id_table	= pcm512x_spi_id,
-	.driver = {
-		.name	= "pcm512x",
-		.owner	= THIS_MODULE,
-		.of_match_table = pcm512x_of_match,
-		.pm     = &pcm512x_pm_ops,
-	},
-};
-#endif
-
-static int __init pcm512x_modinit(void)
-{
-	int ret = 0;
-
-#if IS_ENABLED(CONFIG_I2C)
-	ret = i2c_add_driver(&pcm512x_i2c_driver);
-	if (ret) {
-		printk(KERN_ERR "Failed to register pcm512x I2C driver: %d\n",
-		       ret);
-	}
-#endif
-#if defined(CONFIG_SPI_MASTER)
-	ret = spi_register_driver(&pcm512x_spi_driver);
-	if (ret != 0) {
-		printk(KERN_ERR "Failed to register pcm512x SPI driver: %d\n",
-		       ret);
-	}
-#endif
-	return ret;
-}
-module_init(pcm512x_modinit);
-
-static void __exit pcm512x_exit(void)
-{
-#if IS_ENABLED(CONFIG_I2C)
-	i2c_del_driver(&pcm512x_i2c_driver);
-#endif
-#if defined(CONFIG_SPI_MASTER)
-	spi_unregister_driver(&pcm512x_spi_driver);
-#endif
-}
-module_exit(pcm512x_exit);
+EXPORT_SYMBOL_GPL(pcm512x_pm_ops);
 
 MODULE_DESCRIPTION("ASoC PCM512x codec driver");
 MODULE_AUTHOR("Mark Brown <broonie@linaro.org>");
diff --git a/sound/soc/codecs/pcm512x.h b/sound/soc/codecs/pcm512x.h
index ac4a52c..6ee76aa 100644
--- a/sound/soc/codecs/pcm512x.h
+++ b/sound/soc/codecs/pcm512x.h
@@ -17,6 +17,9 @@
 #ifndef _SND_SOC_PCM512X
 #define _SND_SOC_PCM512X
 
+#include <linux/pm.h>
+#include <linux/regmap.h>
+
 #define PCM512x_VIRT_BASE 0x100
 #define PCM512x_PAGE_LEN  0x100
 #define PCM512x_PAGE_BASE(n)  (PCM512x_VIRT_BASE + (PCM512x_PAGE_LEN * n))
@@ -159,4 +162,10 @@
 #define PCM512x_AGBR_SHIFT 0
 #define PCM512x_AGBL_SHIFT 4
 
+extern const struct dev_pm_ops pcm512x_pm_ops;
+extern const struct regmap_config pcm512x_regmap;
+
+int pcm512x_probe(struct device *dev, struct regmap *regmap);
+void pcm512x_remove(struct device *dev);
+
 #endif
-- 
1.9.0
