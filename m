From: Michael Williamson <michael.williamson@criticallink.com>
Subject: [RFC PATCH 1/1] ASoC: dsd1791: Introduce driver for TI
	DSD1791 stereo codec
Date: Wed, 14 Dec 2011 18:40:43 -0500
Message-ID: <1323906043-28408-2-git-send-email-michael.williamson@criticallink.com>
References: <1323906043-28408-1-git-send-email-michael.williamson@criticallink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qw0-f51.google.com (mail-qw0-f51.google.com
	[209.85.216.51])
	by alsa0.perex.cz (Postfix) with ESMTP id B3DD3103835
	for <alsa-devel@alsa-project.org>; Thu, 15 Dec 2011 00:42:56 +0100 (CET)
Received: by qadz3 with SMTP id z3so1029529qad.17
	for <alsa-devel@alsa-project.org>; Wed, 14 Dec 2011 15:42:55 -0800 (PST)
In-Reply-To: <1323906043-28408-1-git-send-email-michael.williamson@criticallink.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Michael Williamson <michael.williamson@criticallink.com>, lrg@ti.com, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

This patch introduces a (spi) codec driver for the Texas Instruments
DSD1791 24 bit audio stereo DAC.

Testing for basic operation using 16 and 24 bit I2S mode has been
performed.

http://www.ti.com/product/dsd1791

Signed-off-by: Michael Williamson <michael.williamson@criticallink.com>
---
 sound/soc/codecs/Kconfig   |    4 +
 sound/soc/codecs/Makefile  |    2 +
 sound/soc/codecs/dsd1791.c |  282 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 288 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/codecs/dsd1791.c

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 4584514..95b7969 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -33,6 +33,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_CX20442
 	select SND_SOC_DA7210 if I2C
 	select SND_SOC_DFBMCS320
+	select SND_SOC_DSD1791 if SPI_MASTER
 	select SND_SOC_JZ4740_CODEC if SOC_JZ4740
 	select SND_SOC_LM4857 if I2C
 	select SND_SOC_MAX98088 if I2C
@@ -205,6 +206,9 @@ config SND_SOC_DA7210
 config SND_SOC_DFBMCS320
 	tristate
 
+config SND_SOC_DSD1791
+	tristate
+
 config SND_SOC_DMIC
 	tristate
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index a2c7842..d6b5f6a 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -21,6 +21,7 @@ snd-soc-cx20442-objs := cx20442.o
 snd-soc-da7210-objs := da7210.o
 snd-soc-dfbmcs320-objs := dfbmcs320.o
 snd-soc-dmic-objs := dmic.o
+snd-soc-dsd1791-objs := dsd1791.o
 snd-soc-l3-objs := l3.o
 snd-soc-max98088-objs := max98088.o
 snd-soc-max98095-objs := max98095.o
@@ -120,6 +121,7 @@ obj-$(CONFIG_SND_SOC_CS4271)	+= snd-soc-cs4271.o
 obj-$(CONFIG_SND_SOC_CX20442)	+= snd-soc-cx20442.o
 obj-$(CONFIG_SND_SOC_DA7210)	+= snd-soc-da7210.o
 obj-$(CONFIG_SND_SOC_DFBMCS320)	+= snd-soc-dfbmcs320.o
+obj-$(CONFIG_SND_SOC_DSD1791)	+= snd-soc-dsd1791.o
 obj-$(CONFIG_SND_SOC_DMIC)	+= snd-soc-dmic.o
 obj-$(CONFIG_SND_SOC_L3)	+= snd-soc-l3.o
 obj-$(CONFIG_SND_SOC_JZ4740_CODEC)	+= snd-soc-jz4740-codec.o
diff --git a/sound/soc/codecs/dsd1791.c b/sound/soc/codecs/dsd1791.c
new file mode 100644
index 0000000..dbba71b
--- /dev/null
+++ b/sound/soc/codecs/dsd1791.c
@@ -0,0 +1,282 @@
+/*
+ * ALSA SoC codec driver for Texas Instruments DSD1791.
+ *
+ * Author:      (C) Michael Williamson <michael.williamson@criticallink.com>
+ * Copyright:   (C) 2011 Critical Link, LLC
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/pm.h>
+#include <linux/spi/spi.h>
+#include <linux/platform_device.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/initval.h>
+#include <sound/tlv.h>
+
+#define DSD1791_REG_DIGATT_L	16
+#define DSD1791_REG_DIGATT_R	17
+#define DSD1791_REG_AUDFMT	18
+
+#define DSD1791_FMT_16RJ	(0<<4)
+#define DSD1791_FMT_20RJ	(1<<4)
+#define DSD1791_FMT_24RJ	(2<<4)
+#define DSD1791_FMT_24LJ	(3<<4)
+#define DSD1791_FMT_16I2S	(4<<4)
+#define DSD1791_FMT_24I2S	(5<<4)
+
+#define DSD1971_FORMAT_S16_LE	0
+#define DSD1971_FORMAT_S24_LE	1
+
+#define DSD1791_DAIFMT_I2S	0
+#define DSD1791_DAIFMT_RIGHT_J	1
+#define DSD1791_DAIFMT_LEFT_J	2
+
+struct dsd1791 {
+	struct spi_device *spi;
+	struct snd_soc_codec codec;
+	int mclk;
+	int dai_fmt;
+	int pcm_fmt;
+};
+
+/*
+ * write to the dsd1791 register space
+ */
+static int dsd1791_write(struct snd_soc_codec *codec, unsigned int reg,
+			 unsigned int value)
+{
+	struct dsd1791 *dsd1791 = snd_soc_codec_get_drvdata(codec);
+	u8 buffer[2];
+	int rc;
+
+	buffer[0] = (reg & 0x7F);
+	buffer[1] = value & 0xFF;
+	rc = spi_write(dsd1791->spi, buffer, 2);
+	if (rc) {
+		dev_err(&dsd1791->spi->dev, "DSD1791 reg write error (%d)\n",
+			rc);
+		return -EIO;
+	}
+	return 0;
+}
+
+/*
+ * read from the dsd1791 register space
+ */
+static unsigned int dsd1791_read(struct snd_soc_codec *codec,
+				 unsigned int reg)
+{
+	/*
+	 * DSD1791 read capablity requires multipurposing the ZEROL signal
+	 * from the codec.  This is a non-standard mode and is not supported
+	 * on any available hardware for testing.  For now, don't allow it.
+	 */
+	return -EIO;
+}
+
+static int dsd1791_set_format_word(struct dsd1791 *dsd1791,
+				   struct snd_soc_codec *codec)
+{
+	u8 fmt = 0;
+	switch (dsd1791->dai_fmt) {
+
+	case DSD1791_DAIFMT_I2S:
+		if (dsd1791->pcm_fmt == DSD1971_FORMAT_S16_LE)
+			fmt = DSD1791_FMT_16I2S;
+		else if (dsd1791->pcm_fmt == DSD1971_FORMAT_S24_LE)
+			fmt = DSD1791_FMT_24I2S;
+		else
+			return -EINVAL;
+		break;
+
+	case DSD1791_DAIFMT_RIGHT_J:
+		if (dsd1791->pcm_fmt == DSD1971_FORMAT_S16_LE)
+			fmt = DSD1791_FMT_16RJ;
+		else if (dsd1791->pcm_fmt == DSD1971_FORMAT_S24_LE)
+			fmt = DSD1791_FMT_24RJ;
+		else
+			return -EINVAL;
+		break;
+
+	case DSD1791_DAIFMT_LEFT_J:
+		if (dsd1791->pcm_fmt == DSD1971_FORMAT_S24_LE)
+			fmt = DSD1791_FMT_24LJ;
+		else
+			return -EINVAL;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+	return dsd1791_write(codec, DSD1791_REG_AUDFMT, fmt);
+}
+
+static int dsd1791_hw_params(struct snd_pcm_substream *substream,
+			     struct snd_pcm_hw_params *params,
+			     struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_codec *codec = rtd->codec;
+	struct dsd1791 *dsd1791 = snd_soc_codec_get_drvdata(codec);
+
+	switch (params_format(params)) {
+
+	case SNDRV_PCM_FORMAT_S16_LE:
+		dsd1791->pcm_fmt = DSD1971_FORMAT_S16_LE;
+		break;
+
+	case SNDRV_PCM_FORMAT_S24_LE:
+		dsd1791->pcm_fmt = DSD1971_FORMAT_S24_LE;
+		break;
+	default:
+		dev_dbg(&dsd1791->spi->dev, "bad format\n");
+		return -EINVAL;
+	}
+
+	return dsd1791_set_format_word(dsd1791, codec);
+}
+
+static int dsd1791_set_sysclk(struct snd_soc_dai *codec_dai,
+				int clk_id, unsigned int freq, int dir)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	struct dsd1791 *dsd1791 = snd_soc_codec_get_drvdata(codec);
+	dsd1791->mclk = freq;
+	return 0;
+}
+
+static int dsd1791_set_fmt(struct snd_soc_dai *codec_dai,
+			     unsigned int fmt)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	struct dsd1791 *dsd1791 = snd_soc_codec_get_drvdata(codec);
+
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		dsd1791->dai_fmt = DSD1791_DAIFMT_I2S;
+		break;
+	case SND_SOC_DAIFMT_RIGHT_J:
+		dsd1791->dai_fmt = DSD1791_DAIFMT_RIGHT_J;
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		dsd1791->dai_fmt = DSD1791_DAIFMT_LEFT_J;
+		break;
+	default:
+		dev_dbg(&dsd1791->spi->dev, "bad format\n");
+		return -EINVAL;
+	}
+
+	return dsd1791_set_format_word(dsd1791, codec);
+}
+
+#define DSD1791_RATES	SNDRV_PCM_RATE_8000_192000
+#define DSD1791_FORMATS	(SNDRV_PCM_FMTBIT_S16_LE |\
+			 SNDRV_PCM_FMTBIT_S24_LE)
+
+static struct snd_soc_dai_ops dsd1791_dai_ops = {
+	.hw_params	= dsd1791_hw_params,
+	.set_sysclk	= dsd1791_set_sysclk,
+	.set_fmt	= dsd1791_set_fmt,
+};
+
+struct snd_soc_dai_driver dsd1791_dai = {
+	.name = "dsd1791",
+	.playback = {
+		.stream_name = "Playback",
+		.channels_min = 2,
+		.channels_max = 2,
+		.rates = DSD1791_RATES,
+		.formats = DSD1791_FORMATS,
+	},
+	.ops = &dsd1791_dai_ops,
+};
+
+static const struct snd_kcontrol_new dsd1791_snd_controls[] = {
+};
+
+static int dsd1791_probe(struct snd_soc_codec *codec)
+{
+	int err;
+
+	err = snd_soc_add_controls(codec, dsd1791_snd_controls,
+		ARRAY_SIZE(dsd1791_snd_controls));
+	WARN_ON(err < 0);
+
+	return 0;
+}
+
+struct snd_soc_codec_driver dsd1791_soc_codec_dev = {
+	.probe = dsd1791_probe,
+	.read = dsd1791_read,
+	.write = dsd1791_write,
+	.reg_word_size = sizeof(u8),
+};
+
+static int dsd1791_spi_probe(struct spi_device *spi)
+{
+	struct dsd1791 *dsd1791;
+	int ret;
+
+	dev_info(&spi->dev, "probing dsd1791 spi device\n");
+
+	dsd1791 = kzalloc(sizeof *dsd1791, GFP_KERNEL);
+	if (!dsd1791)
+		return -ENOMEM;
+
+	dsd1791->spi = spi;
+	dev_set_drvdata(&spi->dev, dsd1791);
+
+	ret = snd_soc_register_codec(&spi->dev,
+		&dsd1791_soc_codec_dev, &dsd1791_dai, 1);
+
+	if (ret < 0) {
+		kfree(dsd1791);
+		dev_warn(&spi->dev, "Unable to register codec (%d)\n", ret);
+	} else
+		dev_info(&spi->dev, "SPI device initialized\n");
+	return 0;
+};
+
+static int dsd1791_spi_remove(struct spi_device *spi)
+{
+	snd_soc_unregister_codec(&spi->dev);
+	kfree(spi_get_drvdata(spi));
+	return 0;
+}
+
+static struct spi_driver dsd1791_spi = {
+	.driver = {
+		.name = "dsd1791-codec",
+		.owner = THIS_MODULE,
+	},
+	.probe = dsd1791_spi_probe,
+	.remove = dsd1791_spi_remove,
+};
+
+static int __init dsd1791_init(void)
+{
+	spi_register_driver(&dsd1791_spi);
+
+	return 0;
+}
+module_init(dsd1791_init);
+
+static void __exit dsd1791_exit(void)
+{
+	spi_unregister_driver(&dsd1791_spi);
+}
+module_exit(dsd1791_exit);
+
+MODULE_DESCRIPTION("ASoC DSD1791 codec driver");
+MODULE_AUTHOR("Michael Williamson");
+MODULE_LICENSE("GPL");
-- 
1.7.5.4
