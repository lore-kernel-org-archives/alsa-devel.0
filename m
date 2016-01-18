From: Jacob Siverskog <jacob@teenage.engineering>
Subject: [PATCH 1/3] ASoC: pcm179x: Split into core and SPI
	parts
Date: Mon, 18 Jan 2016 16:57:35 +0100
Message-ID: <1453132657-18678-2-git-send-email-jacob@teenage.engineering>
References: <1453132657-18678-1-git-send-email-jacob@teenage.engineering>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f170.google.com (mail-lb0-f170.google.com
 [209.85.217.170])
 by alsa0.perex.cz (Postfix) with ESMTP id 40E65260564
 for <alsa-devel@alsa-project.org>; Mon, 18 Jan 2016 16:58:28 +0100 (CET)
Received: by mail-lb0-f170.google.com with SMTP id oh2so349744563lbb.3
 for <alsa-devel@alsa-project.org>; Mon, 18 Jan 2016 07:58:28 -0800 (PST)
In-Reply-To: <1453132657-18678-1-git-send-email-jacob@teenage.engineering>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Jacob Siverskog <jacob@teenage.engineering>, Mark Brown <broonie@kernel.org>, Johan Hovold <johan@kernel.org>, Michael Trimarchi <michael@amarulasolutions.com>
List-Id: alsa-devel@alsa-project.org

The pcm179x family supports both SPI and I2C for configuration. This
patch splits the driver into core and SPI parts, in preparation for
I2C support.

Reviewed-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Jacob Siverskog <jacob@teenage.engineering>
---
 sound/soc/codecs/Kconfig       | 11 ++++--
 sound/soc/codecs/Makefile      |  2 ++
 sound/soc/codecs/pcm179x-spi.c | 81 ++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/pcm179x.c     | 60 ++++---------------------------
 sound/soc/codecs/pcm179x.h     | 12 +++++++
 5 files changed, 110 insertions(+), 56 deletions(-)
 create mode 100644 sound/soc/codecs/pcm179x-spi.c

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 50693c8..eaf13cb 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -87,7 +87,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_ML26124 if I2C
 	select SND_SOC_NAU8825 if I2C
 	select SND_SOC_PCM1681 if I2C
-	select SND_SOC_PCM179X if SPI_MASTER
+	select SND_SOC_PCM179X_SPI if SPI_MASTER
 	select SND_SOC_PCM3008
 	select SND_SOC_PCM3168A_I2C if I2C
 	select SND_SOC_PCM3168A_SPI if SPI_MASTER
@@ -527,8 +527,15 @@ config SND_SOC_PCM1681
 	depends on I2C
 
 config SND_SOC_PCM179X
-	tristate "Texas Instruments PCM179X CODEC"
+	tristate
+
+config SND_SOC_PCM179X_SPI
+	tristate "Texas Instruments PCM179X CODEC family (SPI)"
 	depends on SPI_MASTER
+	select SND_SOC_PCM179X
+	help
+	  Enable support for Texas Instruments PCM179x CODEC family.
+	  Select this if your PCM179x is connected via an SPI bus.
 
 config SND_SOC_PCM3008
        tristate
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index d44f7d3..56e94d8 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -81,6 +81,7 @@ snd-soc-ml26124-objs := ml26124.o
 snd-soc-nau8825-objs := nau8825.o
 snd-soc-pcm1681-objs := pcm1681.o
 snd-soc-pcm179x-codec-objs := pcm179x.o
+snd-soc-pcm179x-spi-objs := pcm179x-spi.o
 snd-soc-pcm3008-objs := pcm3008.o
 snd-soc-pcm3168a-objs := pcm3168a.o
 snd-soc-pcm3168a-i2c-objs := pcm3168a-i2c.o
@@ -285,6 +286,7 @@ obj-$(CONFIG_SND_SOC_ML26124)	+= snd-soc-ml26124.o
 obj-$(CONFIG_SND_SOC_NAU8825)   += snd-soc-nau8825.o
 obj-$(CONFIG_SND_SOC_PCM1681)	+= snd-soc-pcm1681.o
 obj-$(CONFIG_SND_SOC_PCM179X)	+= snd-soc-pcm179x-codec.o
+obj-$(CONFIG_SND_SOC_PCM179X_SPI)	+= snd-soc-pcm179x-spi.o
 obj-$(CONFIG_SND_SOC_PCM3008)	+= snd-soc-pcm3008.o
 obj-$(CONFIG_SND_SOC_PCM3168A)	+= snd-soc-pcm3168a.o
 obj-$(CONFIG_SND_SOC_PCM3168A_I2C)	+= snd-soc-pcm3168a-i2c.o
diff --git a/sound/soc/codecs/pcm179x-spi.c b/sound/soc/codecs/pcm179x-spi.c
new file mode 100644
index 0000000..73641f5
--- /dev/null
+++ b/sound/soc/codecs/pcm179x-spi.c
@@ -0,0 +1,81 @@
+/*
+ * PCM179X ASoC SPI driver
+ *
+ * Copyright (c) Amarula Solutions B.V. 2013
+ *
+ *     Michael Trimarchi <michael@amarulasolutions.com>
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
+#include <linux/of.h>
+#include <linux/spi/spi.h>
+#include <linux/regmap.h>
+
+#include "pcm179x.h"
+
+static int pcm179x_spi_probe(struct spi_device *spi)
+{
+	struct pcm179x_private *pcm179x;
+	int ret;
+
+	pcm179x = devm_kzalloc(&spi->dev, sizeof(struct pcm179x_private),
+				GFP_KERNEL);
+	if (!pcm179x)
+		return -ENOMEM;
+
+	spi_set_drvdata(spi, pcm179x);
+
+	pcm179x->dev = &spi->dev;
+
+	pcm179x->regmap = devm_regmap_init_spi(spi, &pcm179x_regmap_config);
+	if (IS_ERR(pcm179x->regmap)) {
+		ret = PTR_ERR(pcm179x->regmap);
+		dev_err(&spi->dev, "Failed to register regmap: %d\n", ret);
+		return ret;
+	}
+
+	return pcm179x_common_init(pcm179x);
+}
+
+static int pcm179x_spi_remove(struct spi_device *spi)
+{
+	return pcm179x_common_exit(spi_get_drvdata(spi));
+}
+
+const struct of_device_id pcm179x_of_match[] = {
+	{ .compatible = "ti,pcm1792a", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, pcm179x_of_match);
+
+static const struct spi_device_id pcm179x_spi_ids[] = {
+	{ "pcm179x", 0 },
+	{ },
+};
+MODULE_DEVICE_TABLE(spi, pcm179x_spi_ids);
+
+static struct spi_driver pcm179x_spi_driver = {
+	.driver = {
+		.name = "pcm179x",
+		.of_match_table = of_match_ptr(pcm179x_of_match),
+	},
+	.id_table = pcm179x_spi_ids,
+	.probe = pcm179x_spi_probe,
+	.remove = pcm179x_spi_remove,
+};
+
+module_spi_driver(pcm179x_spi_driver);
+
+MODULE_DESCRIPTION("ASoC PCM179X SPI driver");
+MODULE_AUTHOR("Michael Trimarchi <michael@amarulasolutions.com>");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/pcm179x.c b/sound/soc/codecs/pcm179x.c
index a56c7b7..08bc6e0 100644
--- a/sound/soc/codecs/pcm179x.c
+++ b/sound/soc/codecs/pcm179x.c
@@ -20,7 +20,6 @@
 #include <linux/slab.h>
 #include <linux/kernel.h>
 #include <linux/device.h>
-#include <linux/spi/spi.h>
 
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -29,7 +28,6 @@
 #include <sound/soc.h>
 #include <sound/tlv.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 
 #include "pcm179x.h"
 
@@ -70,12 +68,6 @@ static bool pcm179x_writeable_reg(struct device *dev, unsigned register reg)
 	return accessible && reg != 0x16 && reg != 0x17;
 }
 
-struct pcm179x_private {
-	struct regmap *regmap;
-	unsigned int format;
-	unsigned int rate;
-};
-
 static int pcm179x_set_dai_fmt(struct snd_soc_dai *codec_dai,
                              unsigned int format)
 {
@@ -194,13 +186,7 @@ static struct snd_soc_dai_driver pcm179x_dai = {
 	.ops = &pcm179x_dai_ops,
 };
 
-static const struct of_device_id pcm179x_of_match[] = {
-	{ .compatible = "ti,pcm1792a", },
-	{ }
-};
-MODULE_DEVICE_TABLE(of, pcm179x_of_match);
-
-static const struct regmap_config pcm179x_regmap = {
+const struct regmap_config pcm179x_regmap_config = {
 	.reg_bits		= 8,
 	.val_bits		= 8,
 	.max_register		= 23,
@@ -209,6 +195,7 @@ static const struct regmap_config pcm179x_regmap = {
 	.writeable_reg		= pcm179x_writeable_reg,
 	.readable_reg		= pcm179x_accessible_reg,
 };
+EXPORT_SYMBOL_GPL(pcm179x_regmap_config);
 
 static struct snd_soc_codec_driver soc_codec_dev_pcm179x = {
 	.controls		= pcm179x_controls,
@@ -219,53 +206,18 @@ static struct snd_soc_codec_driver soc_codec_dev_pcm179x = {
 	.num_dapm_routes	= ARRAY_SIZE(pcm179x_dapm_routes),
 };
 
-static int pcm179x_spi_probe(struct spi_device *spi)
+int pcm179x_common_init(struct pcm179x_private *priv)
 {
-	struct pcm179x_private *pcm179x;
-	int ret;
-
-	pcm179x = devm_kzalloc(&spi->dev, sizeof(struct pcm179x_private),
-				GFP_KERNEL);
-	if (!pcm179x)
-		return -ENOMEM;
-
-	spi_set_drvdata(spi, pcm179x);
-
-	pcm179x->regmap = devm_regmap_init_spi(spi, &pcm179x_regmap);
-	if (IS_ERR(pcm179x->regmap)) {
-		ret = PTR_ERR(pcm179x->regmap);
-		dev_err(&spi->dev, "Failed to register regmap: %d\n", ret);
-		return ret;
-	}
-
-	return snd_soc_register_codec(&spi->dev,
+	return snd_soc_register_codec(priv->dev,
 			&soc_codec_dev_pcm179x, &pcm179x_dai, 1);
 }
 
-static int pcm179x_spi_remove(struct spi_device *spi)
+int pcm179x_common_exit(struct pcm179x_private *priv)
 {
-	snd_soc_unregister_codec(&spi->dev);
+	snd_soc_unregister_codec(priv->dev);
 	return 0;
 }
 
-static const struct spi_device_id pcm179x_spi_ids[] = {
-	{ "pcm179x", 0 },
-	{ },
-};
-MODULE_DEVICE_TABLE(spi, pcm179x_spi_ids);
-
-static struct spi_driver pcm179x_codec_driver = {
-	.driver = {
-		.name = "pcm179x",
-		.of_match_table = of_match_ptr(pcm179x_of_match),
-	},
-	.id_table = pcm179x_spi_ids,
-	.probe = pcm179x_spi_probe,
-	.remove = pcm179x_spi_remove,
-};
-
-module_spi_driver(pcm179x_codec_driver);
-
 MODULE_DESCRIPTION("ASoC PCM179X driver");
 MODULE_AUTHOR("Michael Trimarchi <michael@amarulasolutions.com>");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/pcm179x.h b/sound/soc/codecs/pcm179x.h
index c6fdc06..d1536e0 100644
--- a/sound/soc/codecs/pcm179x.h
+++ b/sound/soc/codecs/pcm179x.h
@@ -17,6 +17,13 @@
 #ifndef __PCM179X_H__
 #define __PCM179X_H__
 
+struct pcm179x_private {
+	struct device *dev;
+	struct regmap *regmap;
+	unsigned int format;
+	unsigned int rate;
+};
+
 #define PCM1792A_RATES (SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_8000_48000 | \
 			SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000 | \
 			SNDRV_PCM_RATE_192000)
@@ -24,4 +31,9 @@
 #define PCM1792A_FORMATS (SNDRV_PCM_FMTBIT_S32_LE | SNDRV_PCM_FMTBIT_S24_LE | \
 			  SNDRV_PCM_FMTBIT_S16_LE)
 
+extern const struct regmap_config pcm179x_regmap_config;
+
+int pcm179x_common_init(struct pcm179x_private *priv);
+int pcm179x_common_exit(struct pcm179x_private *priv);
+
 #endif
-- 
2.7.0
