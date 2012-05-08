From: Ola Lilja <ola.o.lilja@stericsson.com>
Subject: [PATCH 11/11] ASoC: Ux500: Add machine-driver
Date: Tue, 8 May 2012 15:57:37 +0200
Message-ID: <1336485457-27441-1-git-send-email-ola.o.lilja@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog103.obsmtp.com (eu1sys200aog103.obsmtp.com
	[207.126.144.115])
	by alsa0.perex.cz (Postfix) with ESMTP id 426081043EB
	for <alsa-devel@alsa-project.org>;
	Tue,  8 May 2012 15:57:42 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: alsa-devel@alsa-project.org

Add machine-driver for ST-Ericsson U8500 platform, including
support for the AB8500-codec.

Signed-off-by: Ola Lilja <ola.o.lilja@stericsson.com>
---
 sound/soc/ux500/Kconfig         |   11 ++
 sound/soc/ux500/Makefile        |    3 +-
 sound/soc/ux500/mop500.c        |  117 +++++++++++++++++
 sound/soc/ux500/mop500_ab8500.c |  270 +++++++++++++++++++++++++++++++++++++++
 sound/soc/ux500/mop500_ab8500.h |   21 +++
 5 files changed, 421 insertions(+), 1 deletions(-)
 create mode 100644 sound/soc/ux500/mop500.c
 create mode 100644 sound/soc/ux500/mop500_ab8500.c
 create mode 100644 sound/soc/ux500/mop500_ab8500.h

diff --git a/sound/soc/ux500/Kconfig b/sound/soc/ux500/Kconfig
index 59da6ce..c158e39 100644
--- a/sound/soc/ux500/Kconfig
+++ b/sound/soc/ux500/Kconfig
@@ -21,3 +21,14 @@ config SND_SOC_UX500_PLAT_DMA
 	help
 		Say Y if you want to enable the Ux500 platform-driver.
 
++config SND_SOC_UX500_MACH_MOP500
++	tristate "Machine - MOP500 (Ux500 + AB8500)"
+ 	depends on AB8500_CORE && AB8500_GPADC && SND_SOC_UX500
+ 	select SND_SOC_AB8500_CODEC
+ 	select SND_SOC_UX500_PLAT_MSP_I2S
+ 	select SND_SOC_UX500_PLAT_DMA
+ 	help
+		Select this to enable the MOP500 machine-driver.
+		This will enable platform-drivers for: Ux500
+		This will enable codec-drivers for: AB8500
+
diff --git a/sound/soc/ux500/Makefile b/sound/soc/ux500/Makefile
index 0c66a44..cce0c11 100644
--- a/sound/soc/ux500/Makefile
+++ b/sound/soc/ux500/Makefile
@@ -6,4 +6,5 @@ obj-$(CONFIG_SND_SOC_UX500_PLAT_MSP_I2S) += snd-soc-ux500-plat-msp-i2s.o
 snd-soc-ux500-plat-dma-objs := ux500_pcm.o
 obj-$(CONFIG_SND_SOC_UX500_PLAT_DMA) += snd-soc-ux500-plat-dma.o
 
-
+snd-soc-ux500-mach-mop500-objs := mop500.o mop500_ab8500.o
+obj-$(CONFIG_SND_SOC_UX500_MACH_MOP500) += snd-soc-ux500-mach-mop500.o
diff --git a/sound/soc/ux500/mop500.c b/sound/soc/ux500/mop500.c
new file mode 100644
index 0000000..5d632ff
--- /dev/null
+++ b/sound/soc/ux500/mop500.c
@@ -0,0 +1,117 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2012
+ *
+ * Author: Ola Lilja (ola.o.lilja@stericsson.com)
+ *         for ST-Ericsson.
+ *
+ * License terms:
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ */
+
+#include <asm/mach-types.h>
+
+#include <linux/module.h>
+#include <linux/io.h>
+#include <linux/spi/spi.h>
+
+#include <mach/board-mop500-audio.h>
+
+#include <sound/soc.h>
+#include <sound/initval.h>
+
+#include "ux500_pcm.h"
+#include "ux500_msp_dai.h"
+
+#include <mop500_ab8500.h>
+
+/* Define the whole MOP500 soundcard, linking platform to the codec-drivers  */
+struct snd_soc_dai_link mop500_dai_links[] = {
+	{
+		.name = "ab8500_0",
+		.stream_name = "ab8500_0",
+		.cpu_dai_name = "ux500-msp-i2s.1",
+		.codec_dai_name = "ab8500-codec-dai.0",
+		.platform_name = "ux500-pcm.0",
+		.codec_name = "ab8500-codec.0",
+		.init = mop500_ab8500_machine_init,
+		.ops = mop500_ab8500_ops,
+	},
+	{
+		.name = "ab8500_1",
+		.stream_name = "ab8500_1",
+		.cpu_dai_name = "ux500-msp-i2s.3",
+		.codec_dai_name = "ab8500-codec-dai.1",
+		.platform_name = "ux500-pcm.0",
+		.codec_name = "ab8500-codec.0",
+		.init = NULL,
+		.ops = mop500_ab8500_ops,
+	},
+};
+
+static struct snd_soc_card mop500_card = {
+	.name = "MOP500-card",
+	.probe = NULL,
+	.dai_link = mop500_dai_links,
+	.num_links = ARRAY_SIZE(mop500_dai_links),
+};
+
+static int __devinit mop500_probe(struct platform_device *pdev)
+{
+	int ret;
+
+	pr_debug("%s: Enter.\n", __func__);
+
+	dev_dbg(&pdev->dev, "%s: Enter.\n", __func__);
+
+	mop500_card.dev = &pdev->dev;
+
+	dev_dbg(&pdev->dev, "%s: Card %s: Set platform drvdata.\n",
+		__func__, mop500_card.name);
+	platform_set_drvdata(pdev, &mop500_card);
+
+	snd_soc_card_set_drvdata(&mop500_card, NULL);
+
+	dev_dbg(&pdev->dev, "%s: Card %s: num_links = %d\n",
+		__func__, mop500_card.name, mop500_card.num_links);
+	dev_dbg(&pdev->dev, "%s: Card %s: DAI-link 0: name = %s\n",
+		__func__, mop500_card.name, mop500_card.dai_link[0].name);
+	dev_dbg(&pdev->dev, "%s: Card %s: DAI-link 0: stream_name = %s\n",
+		__func__, mop500_card.name,
+		mop500_card.dai_link[0].stream_name);
+
+	ret = snd_soc_register_card(&mop500_card);
+	if (ret)
+		dev_err(&pdev->dev,
+			"Error: snd_soc_register_card failed (%d)!\n",
+			ret);
+
+	return ret;
+}
+
+static int __devexit mop500_remove(struct platform_device *pdev)
+{
+	struct snd_soc_card *mop500_card = platform_get_drvdata(pdev);
+
+	pr_debug("%s: Enter.\n", __func__);
+
+	snd_soc_unregister_card(mop500_card);
+	platform_set_drvdata(pdev, NULL);
+
+	return 0;
+}
+
+static struct platform_driver snd_soc_mop500_driver = {
+	.driver = {
+		.owner = THIS_MODULE,
+		.name = "snd-soc-mop500",
+	},
+	.probe = mop500_probe,
+	.remove = __devexit_p(mop500_remove),
+};
+
+module_platform_driver(snd_soc_mop500_driver);
+
+
diff --git a/sound/soc/ux500/mop500_ab8500.c b/sound/soc/ux500/mop500_ab8500.c
new file mode 100644
index 0000000..5b8151d
--- /dev/null
+++ b/sound/soc/ux500/mop500_ab8500.c
@@ -0,0 +1,270 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2012
+ *
+ * Author: Ola Lilja <ola.o.lilja@stericsson.com>,
+ *         Kristoffer Karlsson <kristoffer.karlsson@stericsson.com>
+ *         for ST-Ericsson.
+ *
+ * License terms:
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/io.h>
+
+#include <mach/hardware.h>
+#include <mach/board-mop500-audio.h>
+
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+
+#include "ux500_pcm.h"
+#include "ux500_msp_dai.h"
+#include "../codecs/ab8500-codec.h"
+
+#define TX_SLOT_MONO	0x0008
+#define TX_SLOT_STEREO	0x000a
+#define RX_SLOT_MONO	0x0001
+#define RX_SLOT_STEREO	0x0003
+#define TX_SLOT_8CH	0x00FF
+#define RX_SLOT_8CH	0x00FF
+
+#define DEF_TX_SLOTS	TX_SLOT_STEREO
+#define DEF_RX_SLOTS	RX_SLOT_MONO
+
+#define DRIVERMODE_NORMAL	0
+#define DRIVERMODE_CODEC_ONLY	1
+
+/* Slot configuration */
+static unsigned int tx_slots = DEF_TX_SLOTS;
+static unsigned int rx_slots = DEF_RX_SLOTS;
+
+static struct snd_kcontrol_new mop500_ab8500_ctrls[] = {
+	SOC_DAPM_PIN_SWITCH("Headset Left"),
+	SOC_DAPM_PIN_SWITCH("Headset Right"),
+	SOC_DAPM_PIN_SWITCH("Earpiece"),
+	SOC_DAPM_PIN_SWITCH("Speaker Left"),
+	SOC_DAPM_PIN_SWITCH("Speaker Right"),
+	SOC_DAPM_PIN_SWITCH("LineOut Left"),
+	SOC_DAPM_PIN_SWITCH("LineOut Right"),
+	SOC_DAPM_PIN_SWITCH("Vibra 1"),
+	SOC_DAPM_PIN_SWITCH("Vibra 2"),
+	SOC_DAPM_PIN_SWITCH("Mic 1"),
+	SOC_DAPM_PIN_SWITCH("Mic 2"),
+	SOC_DAPM_PIN_SWITCH("LineIn Left"),
+	SOC_DAPM_PIN_SWITCH("LineIn Right"),
+	SOC_DAPM_PIN_SWITCH("DMic 1"),
+	SOC_DAPM_PIN_SWITCH("DMic 2"),
+	SOC_DAPM_PIN_SWITCH("DMic 3"),
+	SOC_DAPM_PIN_SWITCH("DMic 4"),
+	SOC_DAPM_PIN_SWITCH("DMic 5"),
+	SOC_DAPM_PIN_SWITCH("DMic 6"),
+};
+
+/* ASoC */
+
+void mop500_ab8500_shutdown(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct device *dev = rtd->card->dev;
+
+	dev_dbg(dev, "%s: Enter\n", __func__);
+
+	/* Reset slots configuration to default(s) */
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		tx_slots = DEF_TX_SLOTS;
+	else
+		rx_slots = DEF_RX_SLOTS;
+}
+
+int mop500_ab8500_hw_params(struct snd_pcm_substream *substream,
+			struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct device *dev = rtd->card->dev;
+	unsigned int fmt, fmt_if1;
+	int channels, ret = 0, driver_mode, slots;
+	unsigned int sw_codec, sw_cpu;
+	bool is_playback;
+
+	dev_dbg(dev, "%s: Enter\n", __func__);
+
+	dev_dbg(dev, "%s: substream->pcm->name = %s\n"
+		"substream->pcm->id = %s.\n"
+		"substream->name = %s.\n"
+		"substream->number = %d.\n",
+		__func__,
+		substream->pcm->name,
+		substream->pcm->id,
+		substream->name,
+		substream->number);
+
+	channels = params_channels(params);
+
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S32_LE:
+		sw_cpu = 32;
+		break;
+
+	case SNDRV_PCM_FORMAT_S16_LE:
+		sw_cpu = 16;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	/* Setup codec depending on driver-mode */
+	driver_mode = (channels == 8) ?
+		DRIVERMODE_CODEC_ONLY : DRIVERMODE_NORMAL;
+	dev_dbg(dev, "%s: Driver-mode: %s.\n", __func__,
+		(driver_mode == DRIVERMODE_NORMAL) ? "NORMAL" : "CODEC_ONLY");
+
+	/* Setup format */
+
+	if (driver_mode == DRIVERMODE_NORMAL) {
+		fmt = SND_SOC_DAIFMT_DSP_A |
+			SND_SOC_DAIFMT_CBM_CFM |
+			SND_SOC_DAIFMT_NB_NF |
+			SND_SOC_DAIFMT_CONT;
+	} else {
+		fmt = SND_SOC_DAIFMT_DSP_A |
+			SND_SOC_DAIFMT_CBM_CFM |
+			SND_SOC_DAIFMT_NB_NF |
+			SND_SOC_DAIFMT_GATED;
+	}
+
+	ret = snd_soc_dai_set_fmt(codec_dai, fmt);
+	if (ret < 0) {
+		dev_err(dev,
+			"%s: ERROR: snd_soc_dai_set_fmt failed for codec_dai (ret = %d)!\n",
+			__func__, ret);
+		return ret;
+	}
+
+	ret = snd_soc_dai_set_fmt(cpu_dai, fmt);
+	if (ret < 0) {
+		dev_err(dev,
+			"%s: ERROR: snd_soc_dai_set_fmt failed for cpu_dai (ret = %d)!\n",
+			__func__, ret);
+		return ret;
+	}
+
+	/* Setup TDM-slots */
+
+	is_playback = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK);
+	switch (channels) {
+	case 1:
+		slots = 16;
+		tx_slots = (is_playback) ? TX_SLOT_MONO : 0;
+		rx_slots = (is_playback) ? 0 : RX_SLOT_MONO;
+		break;
+	case 2:
+		slots = 16;
+		tx_slots = (is_playback) ? TX_SLOT_STEREO : 0;
+		rx_slots = (is_playback) ? 0 : RX_SLOT_STEREO;
+		break;
+	case 8:
+		slots = 16;
+		tx_slots = (is_playback) ? TX_SLOT_8CH : 0;
+		rx_slots = (is_playback) ? 0 : RX_SLOT_8CH;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	sw_codec = (driver_mode == DRIVERMODE_NORMAL) ? sw_cpu : 20;
+
+	dev_dbg(dev, "%s: CPU-DAI TDM: TX=0x%04X RX=0x%04x\n", __func__,
+		tx_slots, rx_slots);
+	ret = snd_soc_dai_set_tdm_slot(cpu_dai, tx_slots, rx_slots, slots,
+				sw_cpu);
+	if (ret)
+		return ret;
+
+	dev_dbg(dev, "%s: CODEC-DAI TDM: TX=0x%04X RX=0x%04x\n", __func__,
+		tx_slots, rx_slots);
+	ret = snd_soc_dai_set_tdm_slot(codec_dai, tx_slots, rx_slots, slots,
+				sw_codec);
+	if (ret)
+		return ret;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		dev_dbg(dev, "%s: Setup IF1 for FM-radio.\n", __func__);
+		fmt_if1 = SND_SOC_DAIFMT_CBM_CFM | SND_SOC_DAIFMT_I2S;
+		ret = ab8500_audio_setup_if1(codec_dai->codec, fmt_if1, 16, 1);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+struct snd_soc_ops mop500_ab8500_ops[] = {
+	{
+		.hw_params = mop500_ab8500_hw_params,
+		.shutdown = mop500_ab8500_shutdown,
+	}
+};
+
+int mop500_ab8500_machine_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_codec *codec = rtd->codec;
+	struct device *dev = rtd->card->dev;
+	struct mop500_audio_platform_data *pdata;
+	int ret;
+
+	dev_dbg(dev, "%s Enter.\n", __func__);
+
+	/* Add controls */
+	ret = snd_soc_add_codec_controls(codec, mop500_ab8500_ctrls,
+			ARRAY_SIZE(mop500_ab8500_ctrls));
+	if (ret < 0) {
+		pr_err("%s: Failed to add machine-controls (%d)!\n",
+				__func__, ret);
+		return ret;
+	}
+
+	/* Setup AB8500 according to board-settings */
+	pdata = (struct mop500_audio_platform_data *)dev_get_platdata(dev);
+	ret = ab8500_audio_setup_mics(codec, &pdata->amics);
+	if (ret < 0) {
+		pr_err("%s: Failed to setup mics (%d)!\n", __func__, ret);
+		return ret;
+	}
+	ret = ab8500_audio_set_ear_cmv(codec, pdata->ear_cmv);
+	if (ret < 0) {
+		pr_err("%s: Failed to set earpiece CM-voltage (%d)!\n",
+			__func__, ret);
+		return ret;
+	}
+
+	ret = snd_soc_dapm_disable_pin(&codec->dapm, "Earpiece");
+	ret |= snd_soc_dapm_disable_pin(&codec->dapm, "Speaker Left");
+	ret |= snd_soc_dapm_disable_pin(&codec->dapm, "Speaker Right");
+	ret |= snd_soc_dapm_disable_pin(&codec->dapm, "LineOut Left");
+	ret |= snd_soc_dapm_disable_pin(&codec->dapm, "LineOut Right");
+	ret |= snd_soc_dapm_disable_pin(&codec->dapm, "Vibra 1");
+	ret |= snd_soc_dapm_disable_pin(&codec->dapm, "Vibra 2");
+	ret |= snd_soc_dapm_disable_pin(&codec->dapm, "Mic 1");
+	ret |= snd_soc_dapm_disable_pin(&codec->dapm, "Mic 2");
+	ret |= snd_soc_dapm_disable_pin(&codec->dapm, "LineIn Left");
+	ret |= snd_soc_dapm_disable_pin(&codec->dapm, "LineIn Right");
+	ret |= snd_soc_dapm_disable_pin(&codec->dapm, "DMic 1");
+	ret |= snd_soc_dapm_disable_pin(&codec->dapm, "DMic 2");
+	ret |= snd_soc_dapm_disable_pin(&codec->dapm, "DMic 3");
+	ret |= snd_soc_dapm_disable_pin(&codec->dapm, "DMic 4");
+	ret |= snd_soc_dapm_disable_pin(&codec->dapm, "DMic 5");
+	ret |= snd_soc_dapm_disable_pin(&codec->dapm, "DMic 6");
+
+	return ret;
+}
+
diff --git a/sound/soc/ux500/mop500_ab8500.h b/sound/soc/ux500/mop500_ab8500.h
new file mode 100644
index 0000000..642b5dd
--- /dev/null
+++ b/sound/soc/ux500/mop500_ab8500.h
@@ -0,0 +1,21 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2012
+ *
+ * Author: Ola Lilja <ola.o.lilja@stericsson.com>
+ *         for ST-Ericsson.
+ *
+ * License terms:
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ */
+
+#ifndef MOP500_AB8500_H
+#define MOP500_AB8500_H
+
+extern struct snd_soc_ops mop500_ab8500_ops[];
+
+int mop500_ab8500_machine_init(struct snd_soc_pcm_runtime *runtime);
+
+#endif
-- 
1.7.8.3
