From: Hugo Villeneuve <hugo@hugovil.com>
Subject: [PATCH] ARM DaVinci: Add PCM3008 ALSA SoC driver for
	the Lyrtech SFFSDR board
Date: Mon, 17 Nov 2008 19:27:59 -0500
Message-ID: <1226968079-1624-1-git-send-email-hugo@hugovil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.hugovil.com (201-217-static-ppp.3menatwork.com
	[64.235.217.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 7FDCC243BC
	for <alsa-devel@alsa-project.org>; Tue, 18 Nov 2008 01:27:58 +0100 (CET)
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
Cc: davinci-linux-open-source@linux.davincidsp.com, Hugo Villeneuve <hugo.villeneuve@lyrtech.com>
List-Id: alsa-devel@alsa-project.org

The PCM3008 is used on the Lyrtech SFFSDR board, in conjunction with an
FPGA that generates the bit clock and the master clock

Signed-off-by: Hugo Villeneuve <hugo.villeneuve@lyrtech.com>
---
 sound/soc/codecs/Kconfig           |    4 +
 sound/soc/codecs/Makefile          |    2 +
 sound/soc/codecs/pcm3008.c         |  223 ++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/pcm3008.h         |   25 ++++
 sound/soc/davinci/Kconfig          |    9 ++
 sound/soc/davinci/Makefile         |    2 +
 sound/soc/davinci/davinci-sffsdr.c |  145 +++++++++++++++++++++++
 7 files changed, 410 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/codecs/pcm3008.c
 create mode 100644 sound/soc/codecs/pcm3008.h
 create mode 100644 sound/soc/davinci/davinci-sffsdr.c

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 5df7402..dc58ce2 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -80,6 +80,10 @@ config SND_SOC_TWL4030
 	tristate
 	depends on TWL4030_CORE
 
+config SND_SOC_PCM3008
+	tristate
+	depends on SFFSDR_FPGA
+
 config SND_SOC_UDA1380
         tristate
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 3b9b58a..7af88e7 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -3,6 +3,7 @@ snd-soc-ad1980-objs := ad1980.o
 snd-soc-ad73311-objs := ad73311.o
 snd-soc-ak4535-objs := ak4535.o
 snd-soc-cs4270-objs := cs4270.o
+snd-soc-pcm3008-objs := pcm3008.o
 snd-soc-ssm2602-objs := ssm2602.o
 snd-soc-tlv320aic23-objs := tlv320aic23.o
 snd-soc-tlv320aic26-objs := tlv320aic26.o
@@ -26,6 +27,7 @@ obj-$(CONFIG_SND_SOC_AD1980)	+= snd-soc-ad1980.o
 obj-$(CONFIG_SND_SOC_AD73311) += snd-soc-ad73311.o
 obj-$(CONFIG_SND_SOC_AK4535)	+= snd-soc-ak4535.o
 obj-$(CONFIG_SND_SOC_CS4270)	+= snd-soc-cs4270.o
+obj-$(CONFIG_SND_SOC_PCM3008)	+= snd-soc-pcm3008.o
 obj-$(CONFIG_SND_SOC_SSM2602)	+= snd-soc-ssm2602.o
 obj-$(CONFIG_SND_SOC_TLV320AIC23)	+= snd-soc-tlv320aic23.o
 obj-$(CONFIG_SND_SOC_TLV320AIC26)	+= snd-soc-tlv320aic26.o
diff --git a/sound/soc/codecs/pcm3008.c b/sound/soc/codecs/pcm3008.c
new file mode 100644
index 0000000..20d8b94
--- /dev/null
+++ b/sound/soc/codecs/pcm3008.c
@@ -0,0 +1,223 @@
+/*
+ * ALSA Soc PCM3008 codec support
+ *
+ * Author:	Hugo Villeneuve
+ * Copyright (C) 2008 Lyrtech inc
+ *
+ * Based on AC97 Soc codec, original copyright follow:
+ *
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
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/initval.h>
+#include <sound/soc.h>
+#include <asm/gpio.h>
+#include <asm/plat-sffsdr/sffsdr-fpga.h>
+
+#include "pcm3008.h"
+
+#define PCM3008_VERSION "0.1"
+
+#define PCM3008_RATES (SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 |	\
+		       SNDRV_PCM_RATE_48000)
+
+static int pcm3008_hw_params(struct snd_pcm_substream *substream,
+			     struct snd_pcm_hw_params *params)
+{
+	int fs;
+
+	/* Fsref can be 32000, 44100 or 48000. */
+	fs = params_rate(params);
+
+	printk(KERN_INFO "pcm3008_hw_params: rate = %d Hz\n", fs);
+
+	return sffsdr_fpga_set_codec_fs(fs);
+}
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
+	.ops = {
+		.hw_params = pcm3008_hw_params,
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
+	printk(KERN_INFO "pcm3008_soc_suspend(): TODO\n");
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
+	printk(KERN_INFO "pcm3008_soc_resume(): TODO\n");
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
index 0000000..81c82c9
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
+	u8 dem0_pin;
+	u8 dem1_pin;
+	u8 pdad_pin;
+	u8 pdda_pin;
+};
+
+extern struct snd_soc_codec_device soc_codec_dev_pcm3008;
+extern struct snd_soc_dai pcm3008_dai;
+
+#endif
diff --git a/sound/soc/davinci/Kconfig b/sound/soc/davinci/Kconfig
index 8f7e338..7978b81 100644
--- a/sound/soc/davinci/Kconfig
+++ b/sound/soc/davinci/Kconfig
@@ -17,3 +17,12 @@ config SND_DAVINCI_SOC_EVM
 	help
 	  Say Y if you want to add support for SoC audio on TI
 	  DaVinci EVM platform.
+
+config SND_DAVINCI_SOC_SFFSDR
+	tristate "SoC Audio support for SFFSDR"
+	depends on SND_DAVINCI_SOC && MACH_DAVINCI_SFFSDR
+	select SND_DAVINCI_SOC_I2S
+	select SND_SOC_PCM3008
+	help
+	  Say Y if you want to add support for SoC audio on
+	  Lyrtech SFFSDR board.
diff --git a/sound/soc/davinci/Makefile b/sound/soc/davinci/Makefile
index ca772e5..ca8bae1 100644
--- a/sound/soc/davinci/Makefile
+++ b/sound/soc/davinci/Makefile
@@ -7,5 +7,7 @@ obj-$(CONFIG_SND_DAVINCI_SOC_I2S) += snd-soc-davinci-i2s.o
 
 # DAVINCI Machine Support
 snd-soc-evm-objs := davinci-evm.o
+snd-soc-sffsdr-objs := davinci-sffsdr.o
 
 obj-$(CONFIG_SND_DAVINCI_SOC_EVM) += snd-soc-evm.o
+obj-$(CONFIG_SND_DAVINCI_SOC_SFFSDR) += snd-soc-sffsdr.o
diff --git a/sound/soc/davinci/davinci-sffsdr.c b/sound/soc/davinci/davinci-sffsdr.c
new file mode 100644
index 0000000..b232388
--- /dev/null
+++ b/sound/soc/davinci/davinci-sffsdr.c
@@ -0,0 +1,145 @@
+/*
+ * ASoC driver for Lyrtech SFFSDR board.
+ *
+ * Author:      Vladimir Barinov, <vbarinov@ru.mvista.com>
+ * Copyright:   (C) 2007 MontaVista Software, Inc., <source@mvista.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/timer.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+
+#include <asm/gpio.h>
+#include <asm/dma.h>
+#include <mach/mcbsp.h>
+#include <mach/edma.h>
+
+#include "../codecs/pcm3008.h"
+#include "davinci-pcm.h"
+#include "davinci-i2s.h"
+
+static int sffsdr_hw_params(struct snd_pcm_substream *substream,
+			    struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	int ret = 0;
+
+	/* Set cpu DAI configuration:
+	 * CLKX and CLKR are the inputs for the Sample Rate Generator.
+	 * FSX and FSR are outputs, driven by the sample Rate Generator. */
+	ret = snd_soc_dai_set_fmt(cpu_dai,
+				  SND_SOC_DAIFMT_RIGHT_J |
+				  SND_SOC_DAIFMT_CBM_CFS |
+				  SND_SOC_DAIFMT_IB_NF);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static struct snd_soc_ops sffsdr_ops = {
+	.hw_params = sffsdr_hw_params,
+};
+
+/* davinci-sffsdr digital audio interface glue - connects codec <--> CPU */
+static struct snd_soc_dai_link sffsdr_dai = {
+	.name = "PCM3008", /* Codec name */
+	.stream_name = "PCM3008 HiFi",
+	.cpu_dai = &davinci_i2s_dai,
+	.codec_dai = &pcm3008_dai,
+	.ops = &sffsdr_ops,
+};
+
+/* davinci-sffsdr audio machine driver */
+static struct snd_soc_machine snd_soc_machine_sffsdr = {
+	.name = "DaVinci SFFSDR",
+	.dai_link = &sffsdr_dai,
+	.num_links = 1,
+};
+
+/* sffsdr audio private data */
+static struct pcm3008_setup_data sffsdr_pcm3008_setup = {
+	.dem0_pin = GPIO(45),
+	.dem1_pin = GPIO(46),
+	.pdad_pin = GPIO(47),
+	.pdda_pin = GPIO(38),
+};
+
+/* sffsdr audio subsystem */
+static struct snd_soc_device sffsdr_snd_devdata = {
+	.machine = &snd_soc_machine_sffsdr,
+	.platform = &davinci_soc_platform,
+	.codec_dev = &soc_codec_dev_pcm3008,
+	.codec_data = &sffsdr_pcm3008_setup,
+};
+
+static struct resource sffsdr_snd_resources[] = {
+	{
+		.start = DAVINCI_MCBSP_BASE,
+		.end = DAVINCI_MCBSP_BASE + SZ_8K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+};
+
+static struct evm_snd_platform_data sffsdr_snd_data = {
+	.tx_dma_ch	= DAVINCI_DMA_MCBSP_TX,
+	.rx_dma_ch	= DAVINCI_DMA_MCBSP_RX,
+};
+
+static struct platform_device *sffsdr_snd_device;
+
+static int __init sffsdr_init(void)
+{
+	int ret;
+
+	sffsdr_snd_device = platform_device_alloc("soc-audio", 0);
+	if (!sffsdr_snd_device) {
+		printk(KERN_ERR "platform device allocation failed\n");
+		return -ENOMEM;
+	}
+
+	platform_set_drvdata(sffsdr_snd_device, &sffsdr_snd_devdata);
+	sffsdr_snd_devdata.dev = &sffsdr_snd_device->dev;
+	sffsdr_snd_device->dev.platform_data = &sffsdr_snd_data;
+
+	ret = platform_device_add_resources(sffsdr_snd_device,
+					    sffsdr_snd_resources,
+					    ARRAY_SIZE(sffsdr_snd_resources));
+	if (ret) {
+		printk(KERN_ERR "platform device add ressources failed\n");
+		goto error;
+	}
+
+	ret = platform_device_add(sffsdr_snd_device);
+	if (ret)
+		goto error;
+
+	return ret;
+
+error:
+	platform_device_put(sffsdr_snd_device);
+	return ret;
+}
+
+static void __exit sffsdr_exit(void)
+{
+	platform_device_unregister(sffsdr_snd_device);
+}
+
+module_init(sffsdr_init);
+module_exit(sffsdr_exit);
+
+MODULE_AUTHOR("Hugo Villeneuve");
+MODULE_DESCRIPTION("Lyrtech SFFSDR ASoC driver");
+MODULE_LICENSE("GPL");
-- 
1.5.5
