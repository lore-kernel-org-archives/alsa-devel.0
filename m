From: Ola Lilja <ola.o.lilja@stericsson.com>
Subject: [PATCH] ASoC: Ux500: Add machine-driver
Date: Tue, 12 Jun 2012 08:50:08 +0200
Message-ID: <1339483808-5885-1-git-send-email-ola.o.lilja@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog120.obsmtp.com (eu1sys200aog120.obsmtp.com
	[207.126.144.149])
	by alsa0.perex.cz (Postfix) with ESMTP id 8F34724430
	for <alsa-devel@alsa-project.org>;
	Tue, 12 Jun 2012 08:50:22 +0200 (CEST)
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
 sound/soc/ux500/Kconfig         |   11 +
 sound/soc/ux500/Makefile        |    3 +
 sound/soc/ux500/mop500.c        |  113 ++++++++++
 sound/soc/ux500/mop500_ab8500.c |  431 +++++++++++++++++++++++++++++++++++++++
 sound/soc/ux500/mop500_ab8500.h |   22 ++
 5 files changed, 580 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/ux500/mop500.c
 create mode 100644 sound/soc/ux500/mop500_ab8500.c
 create mode 100644 sound/soc/ux500/mop500_ab8500.h

diff --git a/sound/soc/ux500/Kconfig b/sound/soc/ux500/Kconfig
index 1d38515..069330d 100644
--- a/sound/soc/ux500/Kconfig
+++ b/sound/soc/ux500/Kconfig
@@ -19,3 +19,14 @@ config SND_SOC_UX500_PLAT_DMA
 	select SND_SOC_DMAENGINE_PCM
 	help
 		Say Y if you want to enable the Ux500 platform-driver.
+
++config SND_SOC_UX500_MACH_MOP500
++	tristate "Machine - MOP500 (Ux500 + AB8500)"
+	depends on AB8500_CORE && AB8500_GPADC && SND_SOC_UX500
+	select SND_SOC_AB8500_CODEC
+	select SND_SOC_UX500_PLAT_MSP_I2S
+	select SND_SOC_UX500_PLAT_DMA
+	help
+		Select this to enable the MOP500 machine-driver.
+		This will enable platform-drivers for: Ux500
+		This will enable codec-drivers for: AB8500
diff --git a/sound/soc/ux500/Makefile b/sound/soc/ux500/Makefile
index 4634bf0..cce0c11 100644
--- a/sound/soc/ux500/Makefile
+++ b/sound/soc/ux500/Makefile
@@ -5,3 +5,6 @@ obj-$(CONFIG_SND_SOC_UX500_PLAT_MSP_I2S) += snd-soc-ux500-plat-msp-i2s.o
 
 snd-soc-ux500-plat-dma-objs := ux500_pcm.o
 obj-$(CONFIG_SND_SOC_UX500_PLAT_DMA) += snd-soc-ux500-plat-dma.o
+
+snd-soc-ux500-mach-mop500-objs := mop500.o mop500_ab8500.o
+obj-$(CONFIG_SND_SOC_UX500_MACH_MOP500) += snd-soc-ux500-mach-mop500.o
diff --git a/sound/soc/ux500/mop500.c b/sound/soc/ux500/mop500.c
new file mode 100644
index 0000000..31c4d26
--- /dev/null
+++ b/sound/soc/ux500/mop500.c
@@ -0,0 +1,113 @@
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
+	mop500_ab8500_remove(mop500_card);
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
diff --git a/sound/soc/ux500/mop500_ab8500.c b/sound/soc/ux500/mop500_ab8500.c
new file mode 100644
index 0000000..78cce23
--- /dev/null
+++ b/sound/soc/ux500/mop500_ab8500.c
@@ -0,0 +1,431 @@
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
+#include <linux/clk.h>
+
+#include <mach/hardware.h>
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
+/* Clocks */
+static const char * const enum_mclk[] = {
+	"SYSCLK",
+	"ULPCLK"
+};
+enum mclk {
+	MCLK_SYSCLK,
+	MCLK_ULPCLK,
+};
+
+static SOC_ENUM_SINGLE_EXT_DECL(soc_enum_mclk, enum_mclk);
+
+/* Private data for machine-part MOP500<->AB8500 */
+struct mop500_ab8500_drvdata {
+	/* Clocks */
+	enum mclk mclk_sel;
+	struct clk *clk_ptr_intclk;
+	struct clk *clk_ptr_sysclk;
+	struct clk *clk_ptr_ulpclk;
+};
+
+static inline const char *get_mclk_str(enum mclk mclk_sel)
+{
+	switch (mclk_sel) {
+	case MCLK_SYSCLK:
+		return "SYSCLK";
+	case MCLK_ULPCLK:
+		return "ULPCLK";
+	default:
+		return "Unknown";
+	}
+}
+
+static int mop500_ab8500_set_mclk(struct device *dev,
+				struct mop500_ab8500_drvdata *drvdata)
+{
+	int status;
+	struct clk *clk_ptr;
+
+	if (IS_ERR(drvdata->clk_ptr_intclk)) {
+		dev_err(dev,
+			"%s: ERROR: intclk not initialized!\n", __func__);
+		return -EIO;
+	}
+
+	switch (drvdata->mclk_sel) {
+	case MCLK_SYSCLK:
+		clk_ptr = drvdata->clk_ptr_sysclk;
+		break;
+	case MCLK_ULPCLK:
+		clk_ptr = drvdata->clk_ptr_ulpclk;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (IS_ERR(clk_ptr)) {
+		dev_err(dev, "%s: ERROR: %s not initialized!\n", __func__,
+			get_mclk_str(drvdata->mclk_sel));
+		return -EIO;
+	}
+
+	status = clk_set_parent(drvdata->clk_ptr_intclk, clk_ptr);
+	if (status)
+		dev_err(dev,
+			"%s: ERROR: Setting intclk parent to %s failed (ret = %d)!",
+			__func__, get_mclk_str(drvdata->mclk_sel), status);
+	else
+		dev_dbg(dev,
+			"%s: intclk parent changed to %s.\n",
+			__func__, get_mclk_str(drvdata->mclk_sel));
+
+	return status;
+}
+
+/*
+ * Control-events
+ */
+
+static int mclk_input_control_get(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct mop500_ab8500_drvdata *drvdata =
+				snd_soc_card_get_drvdata(codec->card);
+
+	ucontrol->value.enumerated.item[0] = drvdata->mclk_sel;
+
+	return 0;
+}
+
+static int mclk_input_control_put(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct mop500_ab8500_drvdata *drvdata =
+				snd_soc_card_get_drvdata(codec->card);
+	unsigned int val = ucontrol->value.enumerated.item[0];
+
+	if (val > (unsigned int)MCLK_ULPCLK)
+		return -EINVAL;
+	if (drvdata->mclk_sel == val)
+		return 0;
+
+	drvdata->mclk_sel = val;
+
+	return 1;
+}
+
+/*
+ * Controls
+ */
+
+static struct snd_kcontrol_new mop500_ab8500_ctrls[] = {
+	SOC_ENUM_EXT("Master Clock Select",
+		soc_enum_mclk,
+		mclk_input_control_get, mclk_input_control_put),
+	/* Digital interface - Clocks */
+	SOC_SINGLE("Digital Interface Master Generator Switch",
+		AB8500_DIGIFCONF1, AB8500_DIGIFCONF1_ENMASTGEN,
+		1, 0),
+	SOC_SINGLE("Digital Interface 0 Bit-clock Switch",
+		AB8500_DIGIFCONF1, AB8500_DIGIFCONF1_ENFSBITCLK0,
+		1, 0),
+	SOC_SINGLE("Digital Interface 1 Bit-clock Switch",
+		AB8500_DIGIFCONF1, AB8500_DIGIFCONF1_ENFSBITCLK1,
+		1, 0),
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
+int mop500_ab8500_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+
+	/* Set audio-clock source */
+	return mop500_ab8500_set_mclk(rtd->card->dev,
+				snd_soc_card_get_drvdata(rtd->card));
+}
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
+	unsigned int fmt;
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
+	if (channels == 8)
+		driver_mode = DRIVERMODE_CODEC_ONLY;
+	else
+		driver_mode = DRIVERMODE_NORMAL;
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
+	if (driver_mode == DRIVERMODE_NORMAL)
+		sw_codec = sw_cpu;
+	else
+		sw_codec = 20;
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
+	return 0;
+}
+
+struct snd_soc_ops mop500_ab8500_ops[] = {
+	{
+		.hw_params = mop500_ab8500_hw_params,
+		.startup = mop500_ab8500_startup,
+		.shutdown = mop500_ab8500_shutdown,
+	}
+};
+
+int mop500_ab8500_machine_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_codec *codec = rtd->codec;
+	struct device *dev = rtd->card->dev;
+	struct mop500_ab8500_drvdata *drvdata;
+	int ret;
+
+	dev_dbg(dev, "%s Enter.\n", __func__);
+
+	/* Create driver private-data struct */
+	drvdata = devm_kzalloc(dev, sizeof(struct mop500_ab8500_drvdata),
+			GFP_KERNEL);
+	snd_soc_card_set_drvdata(rtd->card, drvdata);
+
+	/* Setup clocks */
+
+	drvdata->clk_ptr_sysclk = clk_get(dev, "sysclk");
+	if (IS_ERR(drvdata->clk_ptr_sysclk))
+		dev_warn(dev, "%s: WARNING: clk_get failed for 'sysclk'!\n",
+			__func__);
+	drvdata->clk_ptr_ulpclk = clk_get(dev, "ulpclk");
+	if (IS_ERR(drvdata->clk_ptr_ulpclk))
+		dev_warn(dev, "%s: WARNING: clk_get failed for 'ulpclk'!\n",
+			__func__);
+	drvdata->clk_ptr_intclk = clk_get(dev, "intclk");
+	if (IS_ERR(drvdata->clk_ptr_intclk))
+		dev_warn(dev, "%s: WARNING: clk_get failed for 'intclk'!\n",
+			__func__);
+
+	/* Set intclk default parent to ulpclk */
+	drvdata->mclk_sel = MCLK_ULPCLK;
+	ret = mop500_ab8500_set_mclk(dev, drvdata);
+	if (ret < 0)
+		dev_warn(dev, "%s: WARNING: mop500_ab8500_set_mclk!\n",
+			__func__);
+
+	drvdata->mclk_sel = MCLK_ULPCLK;
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
+void mop500_ab8500_remove(struct snd_soc_card *card)
+{
+	struct mop500_ab8500_drvdata *drvdata = snd_soc_card_get_drvdata(card);
+
+	if (drvdata->clk_ptr_sysclk != NULL)
+		clk_put(drvdata->clk_ptr_sysclk);
+	if (drvdata->clk_ptr_ulpclk != NULL)
+		clk_put(drvdata->clk_ptr_ulpclk);
+	if (drvdata->clk_ptr_intclk != NULL)
+		clk_put(drvdata->clk_ptr_intclk);
+
+	snd_soc_card_set_drvdata(card, drvdata);
+}
diff --git a/sound/soc/ux500/mop500_ab8500.h b/sound/soc/ux500/mop500_ab8500.h
new file mode 100644
index 0000000..cca5b33
--- /dev/null
+++ b/sound/soc/ux500/mop500_ab8500.h
@@ -0,0 +1,22 @@
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
+void mop500_ab8500_remove(struct snd_soc_card *card);
+
+#endif
-- 
1.7.8.3
