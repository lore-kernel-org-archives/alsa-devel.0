From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/6] ASoC: Add PCM3008 ALSA SoC driver
Date: Wed, 19 Nov 2008 13:36:29 +0000
Message-ID: <1227101793-3768-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081119133427.GA3687@rakim.wolfsonmicro.main>
	<1227101793-3768-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E51401037F1
	for <alsa-devel@alsa-project.org>; Wed, 19 Nov 2008 14:36:34 +0100 (CET)
In-Reply-To: <1227101793-3768-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Hugo Villeneuve <hugo@hugovil.com>
List-Id: alsa-devel@alsa-project.org

From: Hugo Villeneuve <hugo@hugovil.com>

The PCM3008 is a 16-bit stereo audio codec. It accepts
left-justified format for ADC, and right-justified format
for DAC. Independent power-down modes for ADC and DAC are
provided, as well as a digital de-emphasis filter (4 modes).

[Merged Makefile & Kconfig, changed asm/gpio.h to linux/gpio.h -- broonie]

Signed-off-by: Hugo Villeneuve <hugo@hugovil.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/Kconfig   |    4 +
 sound/soc/codecs/Makefile  |    2 +
 sound/soc/codecs/pcm3008.c |  201 ++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/pcm3008.h |   25 ++++++
 4 files changed, 232 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/codecs/pcm3008.c
 create mode 100644 sound/soc/codecs/pcm3008.h

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 04f49f5..bf68052 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -5,6 +5,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_AD73311 if I2C
 	select SND_SOC_AK4535 if I2C
 	select SND_SOC_CS4270 if I2C
+	select SND_SOC_PCM3008
 	select SND_SOC_SSM2602 if I2C
 	select SND_SOC_TLV320AIC23 if I2C
 	select SND_SOC_TLV320AIC26 if SPI_MASTER
@@ -70,6 +71,9 @@ config SND_SOC_CS4270_VD33_ERRATA
 config SND_SOC_L3
        tristate
 
+config SND_SOC_PCM3008
+       tristate
+
 config SND_SOC_SSM2602
 	tristate
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index de65723..9a20fdd 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -4,6 +4,7 @@ snd-soc-ad73311-objs := ad73311.o
 snd-soc-ak4535-objs := ak4535.o
 snd-soc-cs4270-objs := cs4270.o
 snd-soc-l3-objs := l3.o
+snd-soc-pcm3008-objs := pcm3008.o
 snd-soc-ssm2602-objs := ssm2602.o
 snd-soc-tlv320aic23-objs := tlv320aic23.o
 snd-soc-tlv320aic26-objs := tlv320aic26.o
@@ -30,6 +31,7 @@ obj-$(CONFIG_SND_SOC_AD73311) += snd-soc-ad73311.o
 obj-$(CONFIG_SND_SOC_AK4535)	+= snd-soc-ak4535.o
 obj-$(CONFIG_SND_SOC_CS4270)	+= snd-soc-cs4270.o
 obj-$(CONFIG_SND_SOC_L3)	+= snd-soc-l3.o
+obj-$(CONFIG_SND_SOC_PCM3008)	+= snd-soc-pcm3008.o
 obj-$(CONFIG_SND_SOC_SSM2602)	+= snd-soc-ssm2602.o
 obj-$(CONFIG_SND_SOC_TLV320AIC23)	+= snd-soc-tlv320aic23.o
 obj-$(CONFIG_SND_SOC_TLV320AIC26)	+= snd-soc-tlv320aic26.o
diff --git a/sound/soc/codecs/pcm3008.c b/sound/soc/codecs/pcm3008.c
new file mode 100644
index 0000000..2b26e1d
--- /dev/null
+++ b/sound/soc/codecs/pcm3008.c
@@ -0,0 +1,201 @@
+/*
+ * ALSA Soc PCM3008 codec support
+ *
+ * Author:	Hugo Villeneuve
+ * Copyright (C) 2008 Lyrtech inc
+ *
+ * Based on AC97 Soc codec, original copyright follow:
+ * Copyright 2005 Wolfson Microelectronics PLC.
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ * Generic PCM3008 support.
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/gpio.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/initval.h>
+#include <sound/soc.h>
+
+#include "pcm3008.h"
+
+#define PCM3008_VERSION "0.2"
+
+#define PCM3008_RATES (SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 |	\
+		       SNDRV_PCM_RATE_48000)
+
+struct snd_soc_dai pcm3008_dai = {
+	.name = "PCM3008 HiFi",
+	.type = SND_SOC_DAI_I2S,
+	.playback = {
+		.stream_name = "PCM3008 Playback",
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = PCM3008_RATES,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+	},
+	.capture = {
+		.stream_name = "PCM3008 Capture",
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = PCM3008_RATES,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+	},
+};
+EXPORT_SYMBOL_GPL(pcm3008_dai);
+
+static void pcm3008_gpio_free(struct pcm3008_setup_data *setup)
+{
+	gpio_free(setup->dem0_pin);
+	gpio_free(setup->dem1_pin);
+	gpio_free(setup->pdad_pin);
+	gpio_free(setup->pdda_pin);
+}
+
+static int pcm3008_soc_probe(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec;
+	struct pcm3008_setup_data *setup = socdev->codec_data;
+	int ret = 0;
+
+	printk(KERN_INFO "PCM3008 SoC Audio Codec %s\n", PCM3008_VERSION);
+
+	socdev->codec = kzalloc(sizeof(struct snd_soc_codec), GFP_KERNEL);
+	if (!socdev->codec)
+		return -ENOMEM;
+
+	codec = socdev->codec;
+	mutex_init(&codec->mutex);
+
+	codec->name = "PCM3008";
+	codec->owner = THIS_MODULE;
+	codec->dai = &pcm3008_dai;
+	codec->num_dai = 1;
+	codec->write = NULL;
+	codec->read = NULL;
+	INIT_LIST_HEAD(&codec->dapm_widgets);
+	INIT_LIST_HEAD(&codec->dapm_paths);
+
+	/* Register PCMs. */
+	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
+	if (ret < 0) {
+		printk(KERN_ERR "pcm3008: failed to create pcms\n");
+		goto pcm_err;
+	}
+
+	/* Register Card. */
+	ret = snd_soc_register_card(socdev);
+	if (ret < 0) {
+		printk(KERN_ERR "pcm3008: failed to register card\n");
+		goto card_err;
+	}
+
+	/* DEM1  DEM0  DE-EMPHASIS_MODE
+	 * Low   Low   De-emphasis 44.1 kHz ON
+	 * Low   High  De-emphasis OFF
+	 * High  Low   De-emphasis 48 kHz ON
+	 * High  High  De-emphasis 32 kHz ON
+	 */
+
+	/* Configure DEM0 GPIO (turning OFF DAC De-emphasis). */
+	ret = gpio_request(setup->dem0_pin, "codec_dem0");
+	if (ret == 0)
+		ret = gpio_direction_output(setup->dem0_pin, 1);
+	if (ret != 0)
+		goto gpio_err;
+
+	/* Configure DEM1 GPIO (turning OFF DAC De-emphasis). */
+	ret = gpio_request(setup->dem1_pin, "codec_dem1");
+	if (ret == 0)
+		ret = gpio_direction_output(setup->dem1_pin, 0);
+	if (ret != 0)
+		goto gpio_err;
+
+	/* Configure PDAD GPIO. */
+	ret = gpio_request(setup->pdad_pin, "codec_pdad");
+	if (ret == 0)
+		ret = gpio_direction_output(setup->pdad_pin, 1);
+	if (ret != 0)
+		goto gpio_err;
+
+	/* Configure PDDA GPIO. */
+	ret = gpio_request(setup->pdda_pin, "codec_pdda");
+	if (ret == 0)
+		ret = gpio_direction_output(setup->pdda_pin, 1);
+	if (ret != 0)
+		goto gpio_err;
+
+	return ret;
+
+gpio_err:
+	pcm3008_gpio_free(setup);
+card_err:
+	snd_soc_free_pcms(socdev);
+pcm_err:
+	kfree(socdev->codec);
+
+	return ret;
+}
+
+static int pcm3008_soc_remove(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec = socdev->codec;
+	struct pcm3008_setup_data *setup = socdev->codec_data;
+
+	if (!codec)
+		return 0;
+
+	pcm3008_gpio_free(setup);
+	snd_soc_free_pcms(socdev);
+	kfree(socdev->codec);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int pcm3008_soc_suspend(struct platform_device *pdev, pm_message_t msg)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct pcm3008_setup_data *setup = socdev->codec_data;
+
+	gpio_set_value(setup->pdad_pin, 0);
+	gpio_set_value(setup->pdda_pin, 0);
+
+	return 0;
+}
+
+static int pcm3008_soc_resume(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct pcm3008_setup_data *setup = socdev->codec_data;
+
+	gpio_set_value(setup->pdad_pin, 1);
+	gpio_set_value(setup->pdda_pin, 1);
+
+	return 0;
+}
+#else
+#define pcm3008_soc_suspend NULL
+#define pcm3008_soc_resume NULL
+#endif
+
+struct snd_soc_codec_device soc_codec_dev_pcm3008 = {
+	.probe = 	pcm3008_soc_probe,
+	.remove = 	pcm3008_soc_remove,
+	.suspend =	pcm3008_soc_suspend,
+	.resume =	pcm3008_soc_resume,
+};
+EXPORT_SYMBOL_GPL(soc_codec_dev_pcm3008);
+
+MODULE_DESCRIPTION("Soc PCM3008 driver");
+MODULE_AUTHOR("Hugo Villeneuve");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/pcm3008.h b/sound/soc/codecs/pcm3008.h
new file mode 100644
index 0000000..d04e87d
--- /dev/null
+++ b/sound/soc/codecs/pcm3008.h
@@ -0,0 +1,25 @@
+/*
+ * PCM3008 ALSA SoC Layer
+ *
+ * Author:	Hugo Villeneuve
+ * Copyright (C) 2008 Lyrtech inc
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __LINUX_SND_SOC_PCM3008_H
+#define __LINUX_SND_SOC_PCM3008_H
+
+struct pcm3008_setup_data {
+	unsigned dem0_pin;
+	unsigned dem1_pin;
+	unsigned pdad_pin;
+	unsigned pdda_pin;
+};
+
+extern struct snd_soc_codec_device soc_codec_dev_pcm3008;
+extern struct snd_soc_dai pcm3008_dai;
+
+#endif
-- 
1.5.6.5
