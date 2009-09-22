From: miguel.aguilar@ridgerun.com
Subject: [PATCH 1/4] ASoC: ALSA ASoC CQ0093 Voice Codec Driver
Date: Tue, 22 Sep 2009 13:28:58 -0600
Message-ID: <1253647738-32527-1-git-send-email-miguel.aguilar@ridgerun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.navvo.net (mail.navvo.net [74.208.67.6])
	by alsa0.perex.cz (Postfix) with ESMTP id E029C103824
	for <alsa-devel@alsa-project.org>;
	Tue, 22 Sep 2009 21:29:05 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: nsnehaprabha@ti.com, davinci-linux-open-source@linux.davincidsp.com, alsa-devel@alsa-project.org
Cc: santiago.nunez@ridgerun.com, todd.fischer@ridgerun.com, diego.dompe@ridgerun.com, clark.becker@ridgerun.com, Miguel Aguilar <miguel.aguilar@ridgerun.com>
List-Id: alsa-devel@alsa-project.org

From: Miguel Aguilar <miguel.aguilar@ridgerun.com>

This patch adds support for the Voice Codec CQ0093.

This driver was tested on a DM355 EVM rev C.

Signed-off-by: Miguel Aguilar <miguel.aguilar@ridgerun.com>
---
 sound/soc/codecs/Kconfig  |    4 +
 sound/soc/codecs/Makefile |    2 +
 sound/soc/codecs/cq93vc.c |  377 +++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/cq93vc.h |   23 +++
 4 files changed, 406 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/codecs/cq93vc.c
 create mode 100644 sound/soc/codecs/cq93vc.h

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 0edca93..55d1287 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -19,6 +19,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_AK4104 if SPI_MASTER
 	select SND_SOC_AK4535 if I2C
 	select SND_SOC_AK4642 if I2C
+	select SND_SOC_CQ0093VC if ARCH_DAVINCI_DM365
 	select SND_SOC_CS4270 if I2C
 	select SND_SOC_MAX9877 if I2C
 	select SND_SOC_PCM3008
@@ -96,6 +97,9 @@ config SND_SOC_AK4535
 config SND_SOC_AK4642
 	tristate
 
+config SND_SOC_CQ0093VC
+	tristate
+
 # Cirrus Logic CS4270 Codec
 config SND_SOC_CS4270
 	tristate
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index fb4af28..a3e713c 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -6,6 +6,7 @@ snd-soc-ad73311-objs := ad73311.o
 snd-soc-ak4104-objs := ak4104.o
 snd-soc-ak4535-objs := ak4535.o
 snd-soc-ak4642-objs := ak4642.o
+snd-soc-cq93vc-objs := cq93vc.o
 snd-soc-cs4270-objs := cs4270.o
 snd-soc-cx20442-objs := cx20442.o
 snd-soc-l3-objs := l3.o
@@ -56,6 +57,7 @@ obj-$(CONFIG_SND_SOC_AD73311) += snd-soc-ad73311.o
 obj-$(CONFIG_SND_SOC_AK4104)	+= snd-soc-ak4104.o
 obj-$(CONFIG_SND_SOC_AK4535)	+= snd-soc-ak4535.o
 obj-$(CONFIG_SND_SOC_AK4642)	+= snd-soc-ak4642.o
+obj-$(CONFIG_SND_SOC_CQ0093VC)	+= snd-soc-cq93vc.o
 obj-$(CONFIG_SND_SOC_CS4270)	+= snd-soc-cs4270.o
 obj-$(CONFIG_SND_SOC_CX20442)	+= snd-soc-cx20442.o
 obj-$(CONFIG_SND_SOC_L3)	+= snd-soc-l3.o
diff --git a/sound/soc/codecs/cq93vc.c b/sound/soc/codecs/cq93vc.c
new file mode 100644
index 0000000..e64af25
--- /dev/null
+++ b/sound/soc/codecs/cq93vc.c
@@ -0,0 +1,377 @@
+/*
+ * ALSA SoC CQ0093 Voice Codec Driver
+ *
+ * Copyright (C) 2009 Texas Instruments.
+ *
+ * Author: Miguel Aguilar <miguel.aguilar@ridgerun.com>
+ *
+ * Initial code: Hui Geng
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/delay.h>
+#include <linux/pm.h>
+#include <linux/i2c.h>
+#include <linux/platform_device.h>
+#include <linux/device.h>
+#include <linux/clk.h>
+
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-dai.h>
+#include <sound/soc-dapm.h>
+#include <sound/initval.h>
+
+#include <mach/dm365.h>
+
+#include "cq93vc.h"
+
+#define AUDIO_NAME "cq0093"
+#define CQ93VC_VERSION "0.1"
+
+/*
+ * Voice codec registers
+ *
+ * The base address for the registers used by this driver is shifted
+ * 0x80 from the original Voice Codec base adress since the first region
+ * of the Voice Codec registers is used by the Voice Codec Interface driver.
+ */
+#define VC_REG05	0x14 /* PGA and MIC Gain Control  */
+#define VC_REG09	0x24 /* Digital Soft Mute/Attenuation Control */
+#define VC_REG12	0x30 /* Voice Codec Up/Down */
+
+/* Registers bits */
+#define PGA_GAIN	0x07
+#define DIG_ATTEN	0x3F
+#define MUTE		0x40
+#define POWER_ALL_ON	0xFD
+
+/* Codec private data */
+struct cq93vc_priv {
+	void __iomem		*base;
+	unsigned int		sysclk;
+	resource_size_t		pbase;
+	size_t			base_size;
+};
+
+/*
+ * Read to the cq0093 register space
+ */
+static inline unsigned int cq93vc_read(struct snd_soc_codec *codec,
+						unsigned int reg)
+{
+	struct cq93vc_priv *cq93vc = codec->private_data;
+
+	return __raw_readb(cq93vc->base + reg);
+}
+
+/*
+ * Write to the cq0093 register space
+ */
+static int cq93vc_write(struct snd_soc_codec *codec, unsigned int reg,
+		       unsigned int value)
+{
+	struct cq93vc_priv *cq93vc = codec->private_data;
+
+	__raw_writeb(value, cq93vc->base + reg);
+	return 0;
+}
+
+static int cq93vc_hw_params(struct snd_pcm_substream *substream,
+			   struct snd_pcm_hw_params *params,
+			   struct snd_soc_dai *dai)
+{
+	return 0;
+}
+
+static const struct snd_kcontrol_new cq93vc_snd_controls[] = {
+	SOC_SINGLE("PGA Capture Volume", VC_REG05, 0, 0x03, 0),
+	SOC_SINGLE("Mono DAC Playback Volume", VC_REG09, 0, 0x3f, 0),
+};
+
+static int cq93vc_mute(struct snd_soc_dai *dai, int mute)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	u8 reg = cq93vc_read(codec, VC_REG09) & ~MUTE;
+
+	if (mute)
+		cq93vc_write(codec, VC_REG09, reg | MUTE);
+	else
+		cq93vc_write(codec, VC_REG09, reg);
+
+	return 0;
+}
+
+static int cq93vc_add_controls(struct snd_soc_codec *codec)
+{
+	int err, i;
+
+	for (i = 0; i < ARRAY_SIZE(cq93vc_snd_controls); i++) {
+		err = snd_ctl_add(codec->card,
+				  snd_soc_cnew(&cq93vc_snd_controls[i],
+						codec, NULL));
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+}
+
+static int cq93vc_set_dai_sysclk(struct snd_soc_dai *codec_dai,
+				int clk_id, unsigned int freq, int dir)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	struct cq93vc_priv *cq93vc = codec->private_data;
+
+	switch (freq) {
+	case 22579200:
+	case 27000000:
+	case 33868800:
+		cq93vc->sysclk = freq;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int cq93vc_set_bias_level(struct snd_soc_codec *codec,
+				enum snd_soc_bias_level level)
+{
+	switch (level) {
+	case SND_SOC_BIAS_ON:
+		/* all power is driven by DAPM system */
+		cq93vc_write(codec, VC_REG12, POWER_ALL_ON);
+		break;
+	case SND_SOC_BIAS_PREPARE:
+		break;
+	case SND_SOC_BIAS_STANDBY:
+		/*
+		 * all power is driven by DAPM system,
+		 * so output power is safe if bypass was set
+		 */
+		cq93vc_write(codec, VC_REG12, 0x0);
+		break;
+	case SND_SOC_BIAS_OFF:
+		/* force all power off */
+		cq93vc_write(codec, VC_REG12, 0x0);
+		break;
+	}
+	codec->bias_level = level;
+
+	return 0;
+}
+
+#define CQ93VC_RATES	(SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000)
+#define CQ93VC_FORMATS	(SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S16_LE)
+
+static struct snd_soc_dai_ops cq93vc_dai_ops = {
+	.hw_params	= cq93vc_hw_params,
+	.digital_mute	= cq93vc_mute,
+	.set_sysclk	= cq93vc_set_dai_sysclk,
+};
+
+struct snd_soc_dai cq93vc_dai = {
+	.name = "cq93vc",
+	.playback = {
+		.stream_name = "Playback",
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = CQ93VC_RATES,
+		.formats = CQ93VC_FORMATS,},
+	.capture = {
+		.stream_name = "Capture",
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = CQ93VC_RATES,
+		.formats = CQ93VC_FORMATS,},
+	.ops = &cq93vc_dai_ops,
+};
+EXPORT_SYMBOL_GPL(cq93vc_dai);
+
+static int cq93vc_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec = socdev->card->codec;
+
+	cq93vc_set_bias_level(codec, SND_SOC_BIAS_OFF);
+
+	return 0;
+}
+
+static int cq93vc_resume(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec = socdev->card->codec;
+
+	cq93vc_set_bias_level(codec, codec->suspend_bias_level);
+
+	return 0;
+}
+
+static struct snd_soc_device *cq93vc_socdev;
+
+static int cq93vc_probe(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct device *dev = &pdev->dev;
+	struct cq93vc_priv *cq93vc;
+	struct snd_soc_codec *codec;
+	struct resource *res, *mem;
+	int ret;
+
+	dev_info(dev, "CQ0093 Voice Codec %s\n", CQ93VC_VERSION);
+
+	cq93vc = kzalloc(sizeof(struct cq93vc_priv), GFP_KERNEL);
+	if (cq93vc == NULL) {
+		dev_dbg(dev, "%s: could not allocate memory for private data\n",
+			pdev->name);
+		return -ENOMEM;
+	}
+
+	codec = kzalloc(sizeof(struct snd_soc_codec), GFP_KERNEL);
+	if (codec == NULL) {
+		dev_dbg(dev, "%s: could not allocate memory for codec data\n",
+			pdev->name);
+		ret = -ENOMEM;
+		goto fail1;
+	}
+
+	res = cq93vc_resources;
+
+	cq93vc->pbase = res->start;
+	cq93vc->base_size = resource_size(res);
+
+	mem = request_mem_region(cq93vc->pbase,
+					cq93vc->base_size, "cq93vc");
+	if (!mem) {
+		dev_dbg(dev,"%s: voice codec registers at %08x are not free\n",
+				pdev->name, cq93vc->pbase);
+		ret = -EBUSY;
+		goto fail2;
+	}
+
+	cq93vc->base = ioremap(cq93vc->pbase, cq93vc->base_size);
+	if (cq93vc->base == NULL) {
+		dev_dbg(dev,"%s: can't ioremap mem resource.\n",
+				pdev->name);
+		ret = -ENOMEM;
+		goto fail3;
+	}
+
+	mutex_init(&codec->mutex);
+	codec->private_data = cq93vc;
+	codec->name = "cq93vc";
+	codec->owner = THIS_MODULE;
+	codec->read = cq93vc_read;
+	codec->write = cq93vc_write;
+	codec->set_bias_level = cq93vc_set_bias_level;
+	codec->dai = &cq93vc_dai;
+	codec->num_dai = 1;
+	INIT_LIST_HEAD(&codec->dapm_widgets);
+	INIT_LIST_HEAD(&codec->dapm_paths);
+
+	socdev->card->codec = codec;
+
+	/* Register pcms */
+	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
+	if (ret < 0) {
+		dev_err(dev, "%s: failed to create pcms\n", pdev->name);
+		goto fail4;
+	}
+
+	/* Set the PGA Gain to 18 dB */
+	cq93vc_write(codec, VC_REG05, PGA_GAIN);
+
+	/* Set the DAC digital attenuation to 0 dB */
+	cq93vc_write(codec, VC_REG09, DIG_ATTEN);
+
+	/* Set controls */
+	cq93vc_add_controls(codec);
+
+	/* Off, with power on */
+	cq93vc_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+
+	/* Register sound card */
+	ret = snd_soc_init_card(socdev);
+	if (ret < 0) {
+		dev_err(dev, "%s: failed to register card\n", pdev->name);
+		goto fail5;
+	}
+
+	cq93vc_socdev = socdev;
+
+	return 0;
+fail5:
+	snd_soc_free_pcms(socdev);
+	snd_soc_dapm_free(socdev);
+fail4:
+	iounmap(cq93vc->base);
+fail3:
+	release_mem_region(cq93vc->pbase, cq93vc->base_size);
+fail2:
+	kfree(codec);
+fail1:
+	kfree(cq93vc);
+
+	return ret;
+}
+
+static int cq93vc_remove(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec = socdev->card->codec;
+	struct cq93vc_priv *cq93vc = codec->private_data;
+
+	/* Power down chip */
+	if (codec->control_data)
+		cq93vc_set_bias_level(codec, SND_SOC_BIAS_OFF);
+
+	snd_soc_free_pcms(socdev);
+	snd_soc_dapm_free(socdev);
+
+	iounmap(cq93vc->base);
+	release_mem_region(cq93vc->pbase, cq93vc->base_size);
+
+	kfree(codec);
+	kfree(cq93vc);
+
+	cq93vc_socdev = NULL;
+
+	snd_soc_unregister_dai(&cq93vc_dai);
+
+	return 0;
+}
+
+struct snd_soc_codec_device soc_codec_dev_cq93vc = {
+	.probe = cq93vc_probe,
+	.remove = cq93vc_remove,
+	.suspend = cq93vc_suspend,
+	.resume = cq93vc_resume,
+};
+EXPORT_SYMBOL_GPL(soc_codec_dev_cq93vc);
+
+static __init int cq93vc_init(void)
+{
+	return snd_soc_register_dai(&cq93vc_dai);
+}
+module_init(cq93vc_init);
+
+static __exit void cq93vc_exit(void)
+{
+	snd_soc_unregister_dai(&cq93vc_dai);
+}
+module_exit(cq93vc_exit);
+
+MODULE_DESCRIPTION("Texas Instruments DaVinci ASoC CQ0093 Voice Codec Driver");
+MODULE_AUTHOR("Miguel Aguilar");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/cq93vc.h b/sound/soc/codecs/cq93vc.h
new file mode 100644
index 0000000..8d37763
--- /dev/null
+++ b/sound/soc/codecs/cq93vc.h
@@ -0,0 +1,23 @@
+/*
+ * ALSA SoC CQ0093 Voice Codec Driver
+ *
+ * Copyright (C) 2009 Texas Instruments.
+ *
+ * Author: Miguel Aguilar <miguel.aguilar@ridgerun.com>
+ *
+ * Initial code: Hui Geng
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef _CQ93VC_H
+#define _CQ93VC_H
+
+extern struct snd_soc_dai cq93vc_dai;
+extern struct snd_soc_codec_device soc_codec_dev_cq93vc;
+extern struct resource cq93vc_resources[];
+
+#endif
-- 
1.6.0.4
