From: Ola Lilja <ola.o.lilja@stericsson.com>
Subject: [PATCH 16/16] ASoC: Ux500: Add machine-driver
Date: Tue, 13 Mar 2012 16:11:43 +0100
Message-ID: <1331651503-16917-17-git-send-email-ola.o.lilja@stericsson.com>
References: <1331651503-16917-2-git-send-email-ola.o.lilja@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog111.obsmtp.com (eu1sys200aog111.obsmtp.com
	[207.126.144.131])
	by alsa0.perex.cz (Postfix) with ESMTP id BBD7C10438D
	for <alsa-devel@alsa-project.org>; Tue, 13 Mar 2012 16:12:57 +0100 (CET)
In-Reply-To: <1331651503-16917-2-git-send-email-ola.o.lilja@stericsson.com>
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
 sound/soc/ux500/Kconfig        |    8 +
 sound/soc/ux500/Makefile       |   13 +
 sound/soc/ux500/u8500.c        |  150 ++++++++
 sound/soc/ux500/ux500_ab8500.c |  828 ++++++++++++++++++++++++++++++++++++++++
 sound/soc/ux500/ux500_ab8500.h |   25 ++
 5 files changed, 1024 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/ux500/u8500.c
 create mode 100644 sound/soc/ux500/ux500_ab8500.c
 create mode 100644 sound/soc/ux500/ux500_ab8500.h

diff --git a/sound/soc/ux500/Kconfig b/sound/soc/ux500/Kconfig
index 6c0271c..f651564 100644
--- a/sound/soc/ux500/Kconfig
+++ b/sound/soc/ux500/Kconfig
@@ -23,6 +23,14 @@ config SND_SOC_UX500_PLATFORM
 	help
 		Say Y if you want to enable the Ux500 platform-driver.
 
+config SND_SOC_UX500_AB8500
+	bool "Codec/Machine - AB8500 (MSA)"
+	depends on SND_SOC_UX500_MSP_I2S && SND_SOC_UX500_PLATFORM && AB8500_CORE && AB8500_GPADC
+	select SND_SOC_AB8500
+	default n
+	help
+	   Select this to enable the Ux500 machine-driver and the AB8500 codec-driver.
+
 config SND_SOC_UX500_DEBUG
 	bool "Activate Ux500 platform debug-mode (pr_debug)"
 	depends on SND_SOC_UX500
diff --git a/sound/soc/ux500/Makefile b/sound/soc/ux500/Makefile
index 72e806e..7c1cce6 100644
--- a/sound/soc/ux500/Makefile
+++ b/sound/soc/ux500/Makefile
@@ -3,6 +3,9 @@
 ifdef CONFIG_SND_SOC_UX500_DEBUG
 CFLAGS_ux500_msp_dai.o := -DDEBUG
 CFLAGS_ux500_msp_i2s.o := -DDEBUG
+CFLAGS_ux500_pcm.o := -DDEBUG
+CFLAGS_u8500.o := -DDEBUG
+CFLAGS_ux500_ab8500.o := -DDEBUG
 endif
 
 ifdef CONFIG_SND_SOC_UX500_MSP_I2S
@@ -15,3 +18,13 @@ snd-soc-ux500-platform-dma-objs := ux500_pcm.o
 obj-$(CONFIG_SND_SOC_UX500_PLATFORM) += snd-soc-ux500-platform-dma.o
 endif
 
+ifdef CONFIG_SND_SOC_UX500_AB8500
+snd-soc-ux500-machine-objs += ux500_ab8500.o
+endif
+
+obj-y += snd-soc-ux500-machine.o
+
+ifdef CONFIG_SND_SOC_UX500_PLATFORM
+snd-soc-u8500-objs := u8500.o
+obj-$(CONFIG_SND_SOC_UX500_PLATFORM) += snd-soc-u8500.o
+endif
diff --git a/sound/soc/ux500/u8500.c b/sound/soc/ux500/u8500.c
new file mode 100644
index 0000000..5092698
--- /dev/null
+++ b/sound/soc/ux500/u8500.c
@@ -0,0 +1,150 @@
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
+#include <linux/io.h>
+#include <linux/spi/spi.h>
+
+#include <sound/soc.h>
+#include <sound/initval.h>
+
+#include "ux500_pcm.h"
+#include "ux500_msp_dai.h"
+
+#ifdef CONFIG_SND_SOC_UX500_AB8500
+#include <ux500_ab8500.h>
+#endif
+
+static struct platform_device *pdev;
+
+/* Create dummy devices for platform drivers */
+
+static struct platform_device ux500_pcm = {
+		.name = "ux500-pcm",
+		.id = 0,
+		.dev = {
+			.platform_data = NULL,
+		},
+};
+
+/* Define the whole U8500 soundcard, linking platform to the codec-drivers  */
+struct snd_soc_dai_link u8500_dai_links[] = {
+	#ifdef CONFIG_SND_SOC_UX500_AB8500
+	{
+	.name = "ab8500_0",
+	.stream_name = "ab8500_0",
+	.cpu_dai_name = "ux500-msp-i2s.1",
+	.codec_dai_name = "ab8500-codec-dai.0",
+	.platform_name = "ux500-pcm.0",
+	.codec_name = "ab8500-codec.0",
+	.init = ux500_ab8500_machine_init,
+	.ops = ux500_ab8500_ops,
+	},
+	{
+	.name = "ab8500_1",
+	.stream_name = "ab8500_1",
+	.cpu_dai_name = "ux500-msp-i2s.3",
+	.codec_dai_name = "ab8500-codec-dai.1",
+	.platform_name = "ux500-pcm.0",
+	.codec_name = "ab8500-codec.0",
+	.init = NULL,
+	.ops = ux500_ab8500_ops,
+	},
+	#endif
+};
+
+static struct snd_soc_card u8500_card = {
+	.name = "U8500-card",
+	.probe = NULL,
+	.dai_link = u8500_dai_links,
+	.num_links = ARRAY_SIZE(u8500_dai_links),
+};
+
+static int __init u8500_soc_init(void)
+{
+	int ret;
+
+	pr_debug("%s: Enter.\n", __func__);
+
+	pdev = platform_device_alloc("soc-audio", -1);
+	if (!pdev)
+		return -ENOMEM;
+	dev_dbg(&pdev->dev, "%s: Platform device 'soc-audio' allocated.\n", __func__);
+
+	dev_dbg(&pdev->dev, "%s: Card %s: Set platform drvdata.\n",
+		__func__,
+		u8500_card.name);
+	platform_set_drvdata(pdev, &u8500_card);
+
+	dev_dbg(&pdev->dev, "%s: Card %s: Add platform device.\n",
+		__func__,
+		u8500_card.name);
+	ret = platform_device_add(pdev);
+	if (ret) {
+		dev_err(&pdev->dev, "%s: Error: Failed to add platform device (%s).\n",
+			__func__,
+			u8500_card.name);
+		platform_device_put(pdev);
+	}
+
+	u8500_card.dev = &pdev->dev;
+
+	#ifdef CONFIG_SND_SOC_UX500_AB8500
+	dev_dbg(&pdev->dev, "%s: Calling init-function for AB8500 machine driver.\n",
+		__func__);
+	ret = ux500_ab8500_soc_machine_drv_init();
+	if (ret)
+		dev_err(&pdev->dev, "%s: ux500_ab8500_soc_machine_drv_init failed (%d).\n",
+			__func__, ret);
+	#endif
+
+	dev_dbg(&pdev->dev, "%s: Register device to generate a probe for Ux500-pcm platform.\n",
+		__func__);
+	platform_device_register(&ux500_pcm);
+
+	dev_dbg(&pdev->dev, "%s: Card %s: num_links = %d\n",
+		__func__,
+		u8500_card.name,
+		u8500_card.num_links);
+	dev_dbg(&pdev->dev, "%s: Card %s: DAI-link 0: name = %s\n",
+		__func__,
+		u8500_card.name,
+		u8500_card.dai_link[0].name);
+	dev_dbg(&pdev->dev, "%s: Card %s: DAI-link 0: stream_name = %s\n",
+		__func__,
+		u8500_card.name,
+		u8500_card.dai_link[0].stream_name);
+
+	return ret;
+}
+
+static void __exit u8500_soc_exit(void)
+{
+	pr_debug("%s: Enter.\n", __func__);
+
+	#ifdef CONFIG_SND_SOC_UX500_AB8500
+	pr_debug("%s: Calling exit-function for AB8500 machine driver.\n",
+		__func__);
+	ux500_ab8500_soc_machine_drv_cleanup();
+	#endif
+
+	pr_debug("%s: Unregister platform device (%s).\n",
+		__func__,
+		u8500_card.name);
+	platform_device_unregister(pdev);
+}
+
+module_init(u8500_soc_init);
+module_exit(u8500_soc_exit);
+
diff --git a/sound/soc/ux500/ux500_ab8500.c b/sound/soc/ux500/ux500_ab8500.c
new file mode 100644
index 0000000..faa05bc
--- /dev/null
+++ b/sound/soc/ux500/ux500_ab8500.c
@@ -0,0 +1,828 @@
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
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/regulator/consumer.h>
+
+#include <mach/hardware.h>
+
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/pcm.h>
+#include <sound/jack.h>
+#include <sound/pcm_params.h>
+
+#include "ux500_pcm.h"
+#include "ux500_msp_dai.h"
+#include "../codecs/ab8500_audio.h"
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
+/* Power-control */
+static DEFINE_MUTEX(power_lock);
+static int ab8500_power_count;
+
+/* Clocks */
+/* audioclk -> intclk -> sysclk/ulpclk */
+static int master_clock_sel;
+static struct clk *clk_ptr_audioclk;
+static struct clk *clk_ptr_intclk;
+static struct clk *clk_ptr_sysclk;
+static struct clk *clk_ptr_ulpclk;
+static struct clk *clk_ptr_gpio1;
+
+static const char * const enum_mclk[] = {
+	"SYSCLK",
+	"ULPCLK"
+};
+static SOC_ENUM_SINGLE_EXT_DECL(soc_enum_mclk, enum_mclk);
+
+/* ANC States */
+static const char * const enum_anc_state[] = {
+	"Unconfigured",
+	"Apply FIR and IIR",
+	"FIR and IIR are configured",
+	"Apply FIR",
+	"FIR is configured",
+	"Apply IIR",
+	"IIR is configured"
+};
+static SOC_ENUM_SINGLE_EXT_DECL(soc_enum_ancstate, enum_anc_state);
+enum anc_state {
+	ANC_UNCONFIGURED = 0,
+	ANC_APPLY_FIR_IIR = 1,
+	ANC_FIR_IIR_CONFIGURED = 2,
+	ANC_APPLY_FIR = 3,
+	ANC_FIR_CONFIGURED = 4,
+	ANC_APPLY_IIR = 5,
+	ANC_IIR_CONFIGURED = 6
+};
+static enum anc_state anc_status = ANC_UNCONFIGURED;
+
+/* Regulators */
+enum regulator_idx {
+	REGULATOR_AUDIO,
+	REGULATOR_DMIC,
+	REGULATOR_AMIC1,
+	REGULATOR_AMIC2
+};
+static struct regulator_bulk_data reg_info[4] = {
+	{	.consumer = NULL, .supply = "V-AUD"	},
+	{	.consumer = NULL, .supply = "V-DMIC"	},
+	{	.consumer = NULL, .supply = "V-AMIC1"	},
+	{	.consumer = NULL, .supply = "V-AMIC2"	}
+};
+static bool reg_enabled[4] =  {
+	false,
+	false,
+	false,
+	false
+};
+static int reg_claim[4];
+enum amic_idx { AMIC_1A, AMIC_1B, AMIC_2 };
+struct amic_conf {
+	enum regulator_idx reg_id;
+	bool enabled;
+	char *name;
+};
+static struct amic_conf amic_info[3] = {
+	{ REGULATOR_AMIC1, false, "amic1a" },
+	{ REGULATOR_AMIC1, false, "amic1b" },
+	{ REGULATOR_AMIC2, false, "amic2" }
+};
+
+/* Slot configuration */
+static unsigned int tx_slots = DEF_TX_SLOTS;
+static unsigned int rx_slots = DEF_RX_SLOTS;
+
+/* Regulators */
+
+static int enable_regulator(struct device *dev, enum regulator_idx idx)
+{
+	int ret;
+
+	if (reg_info[idx].consumer == NULL) {
+		dev_err(dev, "%s: Failure to enable regulator '%s'\n",
+			__func__, reg_info[idx].supply);
+		return -EIO;
+	}
+
+	if (reg_enabled[idx])
+		return 0;
+
+	ret = regulator_enable(reg_info[idx].consumer);
+	if (ret != 0) {
+		dev_err(dev, "%s: Failure to enable regulator '%s' (ret = %d)\n",
+			__func__, reg_info[idx].supply, ret);
+		return -EIO;
+	};
+
+	reg_enabled[idx] = true;
+	dev_dbg(dev, "%s: Enabled regulator '%s', status: %d, %d, %d, %d\n",
+		__func__,
+		reg_info[idx].supply,
+		(int)reg_enabled[0],
+		(int)reg_enabled[1],
+		(int)reg_enabled[2],
+		(int)reg_enabled[3]);
+	return 0;
+}
+
+static void disable_regulator(struct device *dev, enum regulator_idx idx)
+{
+	if (reg_info[idx].consumer == NULL) {
+		dev_err(dev, "%s: Failure to disable regulator '%s'\n",
+			__func__, reg_info[idx].supply);
+		return;
+	}
+
+	if (!reg_enabled[idx])
+		return;
+
+	regulator_disable(reg_info[idx].consumer);
+
+	reg_enabled[idx] = false;
+	dev_dbg(dev, "%s: Disabled regulator '%s', status: %d, %d, %d, %d\n",
+		__func__,
+		reg_info[idx].supply,
+		(int)reg_enabled[0],
+		(int)reg_enabled[1],
+		(int)reg_enabled[2],
+		(int)reg_enabled[3]);
+}
+
+static int create_regulators(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_codec *codec = rtd->codec;
+	struct device *dev = rtd->card->dev;
+	int i, status = 0;
+
+	dev_dbg(dev, "%s: Enter.\n", __func__);
+
+	for (i = 0; i < ARRAY_SIZE(reg_info); ++i)
+		reg_info[i].consumer = NULL;
+
+	for (i = 0; i < ARRAY_SIZE(reg_info); ++i) {
+		reg_info[i].consumer = regulator_get(codec->dev, reg_info[i].supply);
+		if (IS_ERR(reg_info[i].consumer)) {
+			status = PTR_ERR(reg_info[i].consumer);
+			dev_err(dev, "%s: ERROR: Failed to get regulator '%s' "
+				"(ret = %d)!\n", __func__, reg_info[i].supply,
+				status);
+			reg_info[i].consumer = NULL;
+			goto err_get;
+		}
+	}
+
+	return 0;
+
+err_get:
+
+	for (i = 0; i < ARRAY_SIZE(reg_info); ++i) {
+		if (reg_info[i].consumer) {
+			regulator_put(reg_info[i].consumer);
+			reg_info[i].consumer = NULL;
+		}
+	}
+
+	return status;
+}
+
+static int claim_amic_regulator(struct device *dev, enum amic_idx amic_id)
+{
+	enum regulator_idx reg_id = amic_info[amic_id].reg_id;
+	int ret = 0;
+
+	reg_claim[reg_id]++;
+	if (reg_claim[reg_id] > 1)
+		goto cleanup;
+
+	ret = enable_regulator(dev, reg_id);
+	if (ret < 0) {
+		dev_err(dev, "%s: Failed to claim %s for %s (ret = %d)!",
+			__func__, reg_info[reg_id].supply,
+			amic_info[amic_id].name, ret);
+		reg_claim[reg_id]--;
+	}
+
+cleanup:
+	amic_info[amic_id].enabled = (ret == 0);
+
+	return ret;
+}
+
+static void release_amic_regulator(struct device *dev, enum amic_idx amic_id)
+{
+	enum regulator_idx reg_id = amic_info[amic_id].reg_id;
+
+	reg_claim[reg_id]--;
+	if (reg_claim[reg_id] <= 0) {
+		disable_regulator(dev, reg_id);
+		reg_claim[reg_id] = 0;
+	}
+
+	amic_info[amic_id].enabled = false;
+}
+
+/* Power/clock control */
+
+static int ux500_ab8500_power_control_inc(struct snd_soc_codec *codec)
+{
+	int ret = 0;
+	struct device *dev = codec->card->dev;
+
+	dev_dbg(dev, "%s: Enter.\n", __func__);
+
+	mutex_lock(&power_lock);
+
+	ab8500_power_count++;
+	dev_dbg(dev, "%s: ab8500_power_count changed from %d to %d",
+		__func__, ab8500_power_count-1, ab8500_power_count);
+
+	if (ab8500_power_count == 1) {
+		/* Turn on audio-regulator */
+		ret = enable_regulator(dev, REGULATOR_AUDIO);
+		if (ret < 0)
+			goto reg_err;
+
+		ret = clk_set_parent(clk_ptr_intclk,
+				(master_clock_sel == 0) ? clk_ptr_sysclk : clk_ptr_ulpclk);
+		if (ret != 0) {
+			dev_err(dev, "%s: ERROR: Setting master-clock to %s failed (ret = %d)!",
+				__func__, (master_clock_sel == 0) ? "SYSCLK" : "ULPCLK", ret);
+			ret = -EIO;
+			goto clk_err;
+		}
+		dev_dbg(dev, "%s: Enabling master-clock (%s).",
+			__func__, (master_clock_sel == 0) ? "SYSCLK" : "ULPCLK");
+
+		/* Enable audio-clock */
+		ret = clk_enable(clk_ptr_audioclk);
+		if (ret != 0) {
+			dev_err(dev, "%s: ERROR: clk_enable failed (ret = %d)!",
+				__func__, ret);
+			ret = -EIO;
+			goto clk_err;
+		}
+
+		/* Power on audio-parts of AB8500 */
+		ab8500_audio_power_control(codec, true);
+		if (ret < 0)
+			goto pwr_err;
+	}
+
+	goto out;
+
+pwr_err:
+	clk_disable(clk_ptr_audioclk);
+
+clk_err:
+	disable_regulator(dev, REGULATOR_AUDIO);
+
+reg_err:
+	ab8500_power_count = 0;
+
+out:
+	mutex_unlock(&power_lock);
+
+	dev_dbg(dev, "%s: Exit.\n", __func__);
+
+	return ret;
+}
+
+static void ux500_ab8500_power_control_dec(struct snd_soc_codec *codec)
+{
+	struct device *dev = codec->card->dev;
+
+	dev_dbg(dev, "%s: Enter.\n", __func__);
+
+	mutex_lock(&power_lock);
+
+	ab8500_power_count--;
+
+	dev_dbg(dev, "%s: ab8500_power_count changed from %d to %d",
+		__func__,
+		ab8500_power_count+1,
+		ab8500_power_count);
+
+	if (ab8500_power_count == 0) {
+		/* Power off audio-parts of AB8500 */
+		ab8500_audio_power_control(codec, false);
+
+		/* Disable audio-clock */
+		dev_dbg(dev, "%s: Disabling master-clock (%s).",
+			__func__, (master_clock_sel == 0) ? "SYSCLK" : "ULPCLK");
+		clk_disable(clk_ptr_audioclk);
+
+		/* Turn off audio-regulator */
+		disable_regulator(dev, REGULATOR_AUDIO);
+	}
+
+	mutex_unlock(&power_lock);
+
+	dev_dbg(dev, "%s: Exit.\n", __func__);
+}
+
+/* Controls - Non-DAPM Non-ASoC */
+
+static int mclk_input_control_get(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	ucontrol->value.enumerated.item[0] = master_clock_sel;
+
+	return 0;
+}
+
+static int mclk_input_control_put(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	unsigned int val;
+
+	val = (ucontrol->value.enumerated.item[0] != 0);
+	if (master_clock_sel == val)
+		return 0;
+
+	master_clock_sel = val;
+
+	return 1;
+}
+
+static const struct snd_kcontrol_new mclk_input_control = \
+	SOC_ENUM_EXT("Master Clock Select", soc_enum_mclk,
+		mclk_input_control_get, mclk_input_control_put);
+
+static int anc_status_control_get(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+
+	mutex_lock(&codec->mutex);
+	ucontrol->value.integer.value[0] = anc_status;
+	mutex_unlock(&codec->mutex);
+
+	return 0;
+}
+
+static int anc_status_control_put(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct device *dev = codec->card->dev;
+	bool apply_fir, apply_iir;
+	int req, ret;
+
+	dev_dbg(dev, "%s: Enter.\n", __func__);
+
+	req = ucontrol->value.integer.value[0];
+	if (req != ANC_APPLY_FIR_IIR && req != ANC_APPLY_FIR &&
+		req != ANC_APPLY_IIR) {
+		dev_err(dev, "%s: ERROR: Unsupported status to set '%s'!\n",
+			__func__, enum_anc_state[req]);
+		return -EINVAL;
+	}
+	apply_fir = req == ANC_APPLY_FIR || req == ANC_APPLY_FIR_IIR;
+	apply_iir = req == ANC_APPLY_IIR || req == ANC_APPLY_FIR_IIR;
+
+	ret = ux500_ab8500_power_control_inc(codec);
+	if (ret < 0) {
+		dev_err(dev, "%s: ERROR: Failed to enable power (ret = %d)!\n",
+			__func__, ret);
+		goto cleanup;
+	}
+
+	mutex_lock(&codec->mutex);
+
+	ab8500_audio_anc_configure(codec, apply_fir, apply_iir);
+
+	if (apply_fir) {
+		if (anc_status == ANC_IIR_CONFIGURED)
+			anc_status = ANC_FIR_IIR_CONFIGURED;
+		else if (anc_status != ANC_FIR_IIR_CONFIGURED)
+			anc_status =  ANC_FIR_CONFIGURED;
+	}
+	if (apply_iir) {
+		if (anc_status == ANC_FIR_CONFIGURED)
+			anc_status = ANC_FIR_IIR_CONFIGURED;
+		else if (anc_status != ANC_FIR_IIR_CONFIGURED)
+			anc_status =  ANC_IIR_CONFIGURED;
+	}
+
+	mutex_unlock(&codec->mutex);
+
+	ux500_ab8500_power_control_dec(codec);
+
+cleanup:
+	if (ret < 0)
+		dev_err(dev, "%s: Unable to configure ANC! (ret = %d)\n",
+			__func__, ret);
+
+	dev_dbg(dev, "%s: Exit.\n", __func__);
+
+	return (ret < 0) ? ret : 1;
+}
+
+static const struct snd_kcontrol_new anc_status_control = \
+	SOC_ENUM_EXT("ANC Status", soc_enum_ancstate,
+		anc_status_control_get, anc_status_control_put);
+
+/* DAPM-events */
+
+static int dapm_audioreg_event(struct snd_soc_dapm_widget *w,
+			struct snd_kcontrol *k, int event)
+{
+	if (SND_SOC_DAPM_EVENT_ON(event))
+		ux500_ab8500_power_control_inc(w->codec);
+	else
+		ux500_ab8500_power_control_dec(w->codec);
+
+	return 0;
+}
+
+static int dapm_amicreg_event(struct device *dev, enum amic_idx amic_id, int event)
+{
+	int ret = 0;
+
+	if (SND_SOC_DAPM_EVENT_ON(event))
+		ret = claim_amic_regulator(dev, amic_id);
+	else if (amic_info[amic_id].enabled)
+		release_amic_regulator(dev, amic_id);
+
+	return ret;
+}
+
+static int dapm_amic1areg_event(struct snd_soc_dapm_widget *w,
+			struct snd_kcontrol *k, int event)
+{
+	return dapm_amicreg_event(w->dapm->dev, AMIC_1A, event);
+}
+
+static int dapm_amic1breg_event(struct snd_soc_dapm_widget *w,
+			struct snd_kcontrol *k, int event)
+{
+	return dapm_amicreg_event(w->dapm->dev, AMIC_1B, event);
+}
+
+static int dapm_amic2reg_event(struct snd_soc_dapm_widget *w,
+			struct snd_kcontrol *k, int event)
+{
+	return dapm_amicreg_event(w->dapm->dev, AMIC_2, event);
+}
+
+static int dapm_dmicreg_event(struct snd_soc_dapm_widget *w,
+			struct snd_kcontrol *k, int event)
+{
+	struct device *dev = w->dapm->dev;
+	int ret = 0;
+
+	if (SND_SOC_DAPM_EVENT_ON(event))
+		ret = enable_regulator(dev, REGULATOR_DMIC);
+	else
+		disable_regulator(dev, REGULATOR_DMIC);
+
+	return ret;
+}
+
+/* DAPM-widgets */
+
+static const struct snd_soc_dapm_widget ux500_ab8500_dapm_widgets[] = {
+	SND_SOC_DAPM_SUPPLY("AUDIO Regulator",
+			SND_SOC_NOPM, 0, 0, dapm_audioreg_event,
+			SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_SUPPLY("AMIC1A Regulator",
+			SND_SOC_NOPM, 0, 0, dapm_amic1areg_event,
+			SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_SUPPLY("AMIC1B Regulator",
+			SND_SOC_NOPM, 0, 0, dapm_amic1breg_event,
+			SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_SUPPLY("AMIC2 Regulator",
+			SND_SOC_NOPM, 0, 0, dapm_amic2reg_event,
+			SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_SUPPLY("DMIC Regulator",
+			SND_SOC_NOPM, 0, 0, dapm_dmicreg_event,
+			SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+};
+
+/* DAPM-routes */
+
+static const struct snd_soc_dapm_route ux500_ab8500_dapm_intercon[] = {
+
+	/* Power AB8500 audio-block when AD/DA is active */
+	{"DAC", NULL, "AUDIO Regulator"},
+	{"ADC", NULL, "AUDIO Regulator"},
+
+	/* Power configured regulator when an analog mic is enabled */
+	{"MIC1A Input", NULL, "AMIC1A Regulator"},
+	{"MIC1B Input", NULL, "AMIC1B Regulator"},
+	{"MIC2 Input", NULL, "AMIC2 Regulator"},
+
+	/* Power DMIC-regulator when any digital mic is enabled */
+	{"DMic 1", NULL, "DMIC Regulator"},
+	{"DMic 2", NULL, "DMIC Regulator"},
+	{"DMic 3", NULL, "DMIC Regulator"},
+	{"DMic 4", NULL, "DMIC Regulator"},
+	{"DMic 5", NULL, "DMIC Regulator"},
+	{"DMic 6", NULL, "DMIC Regulator"},
+};
+
+static int add_widgets(struct snd_soc_codec *codec)
+{
+	struct device *dev = codec->card->dev;
+	int ret;
+
+	ret = snd_soc_dapm_new_controls(&codec->dapm,
+			ux500_ab8500_dapm_widgets,
+			ARRAY_SIZE(ux500_ab8500_dapm_widgets));
+	if (ret < 0) {
+		dev_err(dev, "%s: Failed to create DAPM controls (%d).\n",
+			__func__, ret);
+		return ret;
+	}
+
+	ret = snd_soc_dapm_add_routes(&codec->dapm,
+				ux500_ab8500_dapm_intercon,
+				ARRAY_SIZE(ux500_ab8500_dapm_intercon));
+	if (ret < 0) {
+		dev_err(dev, "%s: Failed to add DAPM routes (%d).\n",
+			__func__, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+/* ASoC */
+
+int ux500_ab8500_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct device *dev = rtd->card->dev;
+	int ret = 0;
+
+	dev_dbg(dev, "%s: Enter\n", __func__);
+
+	if (IS_ERR(clk_ptr_sysclk)) {
+		dev_err(dev, "%s: ERROR: Clocks needed for streaming not available!",
+			__func__);
+		return -EAGAIN;
+	}
+
+	/* Enable gpio.1-clock (needed by DSP in burst mode) */
+	ret = clk_enable(clk_ptr_gpio1);
+	if (ret) {
+		dev_err(dev, "%s: ERROR: clk_enable(gpio.1) failed (ret = %d)!",
+			__func__, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+void ux500_ab8500_shutdown(struct snd_pcm_substream *substream)
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
+
+	clk_disable(clk_ptr_gpio1);
+}
+
+int ux500_ab8500_hw_params(struct snd_pcm_substream *substream,
+			struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct device *dev = rtd->card->dev;
+	unsigned int fmt, fmt_if1;
+	int channels, ret = 0, slots, slot_width, driver_mode;
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
+	/* Setup codec depending on driver-mode */
+	driver_mode = (channels == 8) ?
+		DRIVERMODE_CODEC_ONLY : DRIVERMODE_NORMAL;
+	dev_dbg(dev, "%s: Driver-mode: %s.\n", __func__,
+		(driver_mode == DRIVERMODE_NORMAL) ? "NORMAL" : "CODEC_ONLY");
+
+	ab8500_audio_set_bit_delay(codec_dai, 1);
+
+	if (driver_mode == DRIVERMODE_NORMAL) {
+		ab8500_audio_set_word_length(codec_dai, 16);
+		fmt = SND_SOC_DAIFMT_DSP_A |
+			SND_SOC_DAIFMT_CBM_CFM |
+			SND_SOC_DAIFMT_NB_NF |
+			SND_SOC_DAIFMT_CONT;
+	} else {
+		ab8500_audio_set_word_length(codec_dai, 20);
+		fmt = SND_SOC_DAIFMT_DSP_A |
+			SND_SOC_DAIFMT_CBM_CFM |
+			SND_SOC_DAIFMT_NB_NF |
+			SND_SOC_DAIFMT_GATED;
+	}
+
+	ret = snd_soc_dai_set_fmt(codec_dai, fmt);
+	if (ret < 0) {
+		dev_err(dev, "%s: ERROR: snd_soc_dai_set_fmt failed "
+			"for codec_dai (ret = %d)!\n", __func__, ret);
+		return ret;
+	}
+
+	ret = snd_soc_dai_set_fmt(cpu_dai, fmt);
+	if (ret < 0) {
+		dev_err(dev, "%s: ERROR: snd_soc_dai_set_fmt failed "
+			"for cpu_dai (ret = %d)!\n", __func__, ret);
+		return ret;
+	}
+
+	/* Setup TDM-slots */
+
+	is_playback = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK);
+	switch (channels) {
+	case 1:
+		slots = 16;
+		slot_width = 16;
+		tx_slots = (is_playback) ? TX_SLOT_MONO : 0;
+		rx_slots = (is_playback) ? 0 : RX_SLOT_MONO;
+		break;
+	case 2:
+		slots = 16;
+		slot_width = 16;
+		tx_slots = (is_playback) ? TX_SLOT_STEREO : 0;
+		rx_slots = (is_playback) ? 0 : RX_SLOT_STEREO;
+		break;
+	case 8:
+		slots = 16;
+		slot_width = 16;
+		tx_slots = (is_playback) ? TX_SLOT_8CH : 0;
+		rx_slots = (is_playback) ? 0 : RX_SLOT_8CH;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	dev_dbg(dev, "%s: CPU-DAI TDM: TX=0x%04X RX=0x%04x\n", __func__,
+		tx_slots, rx_slots);
+	ret = snd_soc_dai_set_tdm_slot(cpu_dai, tx_slots, rx_slots, slots, slot_width);
+	if (ret)
+		return ret;
+
+	dev_dbg(dev, "%s: CODEC-DAI TDM: TX=0x%04X RX=0x%04x\n", __func__,
+		tx_slots, rx_slots);
+	ret = snd_soc_dai_set_tdm_slot(codec_dai, tx_slots, rx_slots, slots, slot_width);
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
+struct snd_soc_ops ux500_ab8500_ops[] = {
+	{
+	.hw_params = ux500_ab8500_hw_params,
+	.startup = ux500_ab8500_startup,
+	.shutdown = ux500_ab8500_shutdown,
+	}
+};
+
+int ux500_ab8500_machine_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_codec *codec = rtd->codec;
+	struct device *dev = rtd->card->dev;
+	int ret;
+
+	dev_dbg(dev, "%s Enter.\n", __func__);
+
+	/* Add controls */
+	snd_ctl_add(codec->card->snd_card, snd_ctl_new1(&mclk_input_control, codec));
+	snd_ctl_add(codec->card->snd_card, snd_ctl_new1(&anc_status_control, codec));
+
+	ret = create_regulators(rtd);
+	if (ret < 0) {
+		dev_err(dev, "%s: ERROR: Failed to instantiate regulators (ret = %d)!\n",
+			__func__, ret);
+		return ret;
+	}
+
+	/* Get references to clock-nodes */
+	clk_ptr_sysclk = NULL;
+	clk_ptr_ulpclk = NULL;
+	clk_ptr_intclk = NULL;
+	clk_ptr_audioclk = NULL;
+	clk_ptr_gpio1 = NULL;
+	clk_ptr_sysclk = clk_get(codec->dev, "sysclk");
+	if (IS_ERR(clk_ptr_sysclk))
+		dev_warn(dev, "WARNING: clk_get failed for 'sysclk'!\n");
+	clk_ptr_ulpclk = clk_get(codec->dev, "ulpclk");
+	if (IS_ERR(clk_ptr_sysclk))
+		dev_warn(dev, "WARNING: clk_get failed for 'ulpclk'!\n");
+	clk_ptr_intclk = clk_get(codec->dev, "intclk");
+	if (IS_ERR(clk_ptr_audioclk))
+		dev_warn(dev, "WARNING: clk_get failed for 'intclk'!\n");
+	clk_ptr_audioclk = clk_get(codec->dev, "audioclk");
+	if (IS_ERR(clk_ptr_audioclk))
+		dev_warn(dev, "WARNING: clk_get failed for 'audioclk'!\n");
+	clk_ptr_gpio1 = clk_get_sys("gpio.1", NULL);
+	if (IS_ERR(clk_ptr_gpio1))
+		dev_warn(dev, "WARNING: clk_get failed for 'gpio1'!\n");
+
+	/* Set intclk default parent to ulpclk */
+	ret = clk_set_parent(clk_ptr_intclk, clk_ptr_ulpclk);
+	if (ret)
+		dev_warn(dev, "%s: WARNING: Setting intclk parent to ulpclk failed (ret = %d)!",
+			__func__,
+			ret);
+
+	master_clock_sel = 1;
+
+	ab8500_power_count = 0;
+
+	reg_claim[REGULATOR_AMIC1] = 0;
+	reg_claim[REGULATOR_AMIC2] = 0;
+
+	/* Add DAPM-widgets */
+	ret = add_widgets(codec);
+	if (ret < 0) {
+		dev_err(dev, "%s: Failed add widgets (%d).\n", __func__, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+int ux500_ab8500_soc_machine_drv_init(void)
+{
+	pr_debug("%s: Enter.\n", __func__);
+
+	return 0;
+}
+
+void ux500_ab8500_soc_machine_drv_cleanup(void)
+{
+	pr_debug("%s: Enter.\n", __func__);
+
+	regulator_bulk_free(ARRAY_SIZE(reg_info), reg_info);
+
+	if (clk_ptr_sysclk != NULL)
+		clk_put(clk_ptr_sysclk);
+	if (clk_ptr_ulpclk != NULL)
+		clk_put(clk_ptr_ulpclk);
+	if (clk_ptr_intclk != NULL)
+		clk_put(clk_ptr_intclk);
+	if (clk_ptr_audioclk != NULL)
+		clk_put(clk_ptr_audioclk);
+	if (clk_ptr_gpio1 != NULL)
+		clk_put(clk_ptr_gpio1);
+}
+
diff --git a/sound/soc/ux500/ux500_ab8500.h b/sound/soc/ux500/ux500_ab8500.h
new file mode 100644
index 0000000..4fffb8a
--- /dev/null
+++ b/sound/soc/ux500/ux500_ab8500.h
@@ -0,0 +1,25 @@
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
+#ifndef UX500_AB8500_H
+#define UX500_AB8500_H
+
+extern struct snd_soc_ops ux500_ab8500_ops[];
+
+int ux500_ab8500_machine_init(struct snd_soc_pcm_runtime *runtime);
+
+int ux500_ab8500_soc_machine_drv_init(void);
+
+void ux500_ab8500_soc_machine_drv_cleanup(void);
+
+#endif
-- 
1.7.8.3
