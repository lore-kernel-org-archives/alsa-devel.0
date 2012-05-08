From: Ola Lilja <ola.o.lilja@stericsson.com>
Subject: [PATCH 08/11] ASoC: Ux500: Add MSP I2S-driver
Date: Tue, 8 May 2012 15:57:18 +0200
Message-ID: <1336485438-27332-1-git-send-email-ola.o.lilja@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog106.obsmtp.com (eu1sys200aog106.obsmtp.com
	[207.126.144.121])
	by alsa0.perex.cz (Postfix) with ESMTP id 8D86D10436B
	for <alsa-devel@alsa-project.org>;
	Tue,  8 May 2012 15:57:22 +0200 (CEST)
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

Add driver for running I2S with the MSP-block.

Signed-off-by: Ola Lilja <ola.o.lilja@stericsson.com>
---
 sound/soc/Kconfig               |    1 +
 sound/soc/Makefile              |    1 +
 sound/soc/ux500/Kconfig         |   16 +
 sound/soc/ux500/Makefile        |    6 +
 sound/soc/ux500/ux500_msp_dai.c |  843 +++++++++++++++++++++++++++++++++++++++
 sound/soc/ux500/ux500_msp_dai.h |   79 ++++
 sound/soc/ux500/ux500_msp_i2s.c |  742 ++++++++++++++++++++++++++++++++++
 sound/soc/ux500/ux500_msp_i2s.h |  553 +++++++++++++++++++++++++
 8 files changed, 2241 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/ux500/Kconfig
 create mode 100644 sound/soc/ux500/Makefile
 create mode 100644 sound/soc/ux500/ux500_msp_dai.c
 create mode 100644 sound/soc/ux500/ux500_msp_dai.h
 create mode 100644 sound/soc/ux500/ux500_msp_i2s.c
 create mode 100644 sound/soc/ux500/ux500_msp_i2s.h

diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
index 91c9855..359eb0f 100644
--- a/sound/soc/Kconfig
+++ b/sound/soc/Kconfig
@@ -48,6 +48,7 @@ source "sound/soc/s6000/Kconfig"
 source "sound/soc/sh/Kconfig"
 source "sound/soc/tegra/Kconfig"
 source "sound/soc/txx9/Kconfig"
+source "sound/soc/ux500/Kconfig"
 
 # Supported codecs
 source "sound/soc/codecs/Kconfig"
diff --git a/sound/soc/Makefile b/sound/soc/Makefile
index 2feaf37..f5fe621 100644
--- a/sound/soc/Makefile
+++ b/sound/soc/Makefile
@@ -25,3 +25,4 @@ obj-$(CONFIG_SND_SOC)	+= s6000/
 obj-$(CONFIG_SND_SOC)	+= sh/
 obj-$(CONFIG_SND_SOC)	+= tegra/
 obj-$(CONFIG_SND_SOC)	+= txx9/
+obj-$(CONFIG_SND_SOC)	+= ux500/
diff --git a/sound/soc/ux500/Kconfig b/sound/soc/ux500/Kconfig
new file mode 100644
index 0000000..9b0ae4e
--- /dev/null
+++ b/sound/soc/ux500/Kconfig
@@ -0,0 +1,16 @@
+#
+# Ux500 SoC audio configuration
+#
+menuconfig SND_SOC_UX500
+	tristate "SoC Audio support for Ux500 platform"
+	depends on SND_SOC
+	help
+		Say Y if you want to enable ASoC-support for
+		any of the Ux500 platforms (e.g. U8500).
+
+config SND_SOC_UX500_PLAT_MSP_I2S
+	tristate "Platform - MSP (I2S)"
+	depends on SND_SOC_UX500
+	help
+		Say Y if you want to enable the Ux500 MSP I2S-driver.
+
diff --git a/sound/soc/ux500/Makefile b/sound/soc/ux500/Makefile
new file mode 100644
index 0000000..d8e9dd2
--- /dev/null
+++ b/sound/soc/ux500/Makefile
@@ -0,0 +1,6 @@
+# Ux500 Platform Support
+
+snd-soc-ux500-plat-msp-i2s-objs := ux500_msp_dai.o ux500_msp_i2s.o
+obj-$(CONFIG_SND_SOC_UX500_PLAT_MSP_I2S) += snd-soc-ux500-plat-msp-i2s.o
+
+
diff --git a/sound/soc/ux500/ux500_msp_dai.c b/sound/soc/ux500/ux500_msp_dai.c
new file mode 100644
index 0000000..93c6c40
--- /dev/null
+++ b/sound/soc/ux500/ux500_msp_dai.c
@@ -0,0 +1,843 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2012
+ *
+ * Author: Ola Lilja <ola.o.lilja@stericsson.com>,
+ *         Roger Nilsson <roger.xr.nilsson@stericsson.com>
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
+#include <linux/slab.h>
+#include <linux/bitops.h>
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+#include <linux/regulator/consumer.h>
+#include <linux/mfd/dbx500-prcmu.h>
+
+#include <mach/hardware.h>
+#include <mach/board-mop500-msp.h>
+
+#include <sound/soc.h>
+#include <sound/soc-dai.h>
+
+#include "ux500_msp_i2s.h"
+#include "ux500_msp_dai.h"
+
+static int setup_pcm_multichan(struct snd_soc_dai *dai,
+			struct ux500_msp_config *msp_config)
+{
+	struct ux500_msp_i2s_drvdata *drvdata = dev_get_drvdata(dai->dev);
+	struct msp_multichannel_config *multi =
+					&msp_config->multichannel_config;
+
+	if (drvdata->slots > 1) {
+		msp_config->multichannel_configured = 1;
+
+		multi->tx_multichannel_enable = true;
+		multi->rx_multichannel_enable = true;
+		multi->rx_comparison_enable_mode = MSP_COMPARISON_DISABLED;
+
+		multi->tx_channel_0_enable = drvdata->tx_mask;
+		multi->tx_channel_1_enable = 0;
+		multi->tx_channel_2_enable = 0;
+		multi->tx_channel_3_enable = 0;
+
+		multi->rx_channel_0_enable = drvdata->rx_mask;
+		multi->rx_channel_1_enable = 0;
+		multi->rx_channel_2_enable = 0;
+		multi->rx_channel_3_enable = 0;
+
+		dev_dbg(dai->dev,
+			"%s: Multichannel enabled. Slots: %d, TX: %u, RX: %u\n",
+			__func__, drvdata->slots, multi->tx_channel_0_enable,
+			multi->rx_channel_0_enable);
+	}
+
+	return 0;
+}
+
+static int setup_frameper(struct snd_soc_dai *dai, unsigned int rate,
+			struct msp_protdesc *prot_desc)
+{
+	struct ux500_msp_i2s_drvdata *drvdata = dev_get_drvdata(dai->dev);
+
+	switch (drvdata->slots) {
+	case 1:
+		switch (rate) {
+		case 8000:
+			prot_desc->frame_period =
+				FRAME_PER_SINGLE_SLOT_8_KHZ;
+			break;
+
+		case 16000:
+			prot_desc->frame_period =
+				FRAME_PER_SINGLE_SLOT_16_KHZ;
+			break;
+
+		case 44100:
+			prot_desc->frame_period =
+				FRAME_PER_SINGLE_SLOT_44_1_KHZ;
+			break;
+
+		case 48000:
+			prot_desc->frame_period =
+				FRAME_PER_SINGLE_SLOT_48_KHZ;
+			break;
+
+		default:
+			dev_err(dai->dev,
+				"%s: Error: Unsupported sample-rate (freq = %d)!\n",
+				__func__, rate);
+			return -EINVAL;
+		}
+		break;
+
+	case 2:
+		prot_desc->frame_period = FRAME_PER_2_SLOTS;
+		break;
+
+	case 8:
+		prot_desc->frame_period = FRAME_PER_8_SLOTS;
+		break;
+
+	case 16:
+		prot_desc->frame_period = FRAME_PER_16_SLOTS;
+		break;
+	default:
+		dev_err(dai->dev,
+			"%s: Error: Unsupported slot-count (slots = %d)!\n",
+			__func__, drvdata->slots);
+		return -EINVAL;
+	}
+
+	prot_desc->clocks_per_frame =
+			prot_desc->frame_period+1;
+
+	dev_dbg(dai->dev, "%s: Clocks per frame: %u\n",
+		__func__,
+		prot_desc->clocks_per_frame);
+
+	return 0;
+}
+
+static int setup_pcm_framing(struct snd_soc_dai *dai, unsigned int rate,
+			struct msp_protdesc *prot_desc)
+{
+	struct ux500_msp_i2s_drvdata *drvdata = dev_get_drvdata(dai->dev);
+
+	u32 frame_length = MSP_FRAME_LEN_1;
+	prot_desc->frame_width = 0;
+
+	switch (drvdata->slots) {
+	case 1:
+		frame_length = MSP_FRAME_LEN_1;
+		break;
+
+	case 2:
+		frame_length = MSP_FRAME_LEN_2;
+		break;
+
+	case 8:
+		frame_length = MSP_FRAME_LEN_8;
+		break;
+
+	case 16:
+		frame_length = MSP_FRAME_LEN_16;
+		break;
+	default:
+		dev_err(dai->dev,
+			"%s: Error: Unsupported slot-count (slots = %d)!\n",
+			__func__, drvdata->slots);
+		return -EINVAL;
+	}
+
+	prot_desc->tx_frame_len_1 = frame_length;
+	prot_desc->rx_frame_len_1 = frame_length;
+	prot_desc->tx_frame_len_2 = frame_length;
+	prot_desc->rx_frame_len_2 = frame_length;
+
+	prot_desc->tx_elem_len_1 = MSP_ELEM_LEN_16;
+	prot_desc->rx_elem_len_1 = MSP_ELEM_LEN_16;
+	prot_desc->tx_elem_len_2 = MSP_ELEM_LEN_16;
+	prot_desc->rx_elem_len_2 = MSP_ELEM_LEN_16;
+
+	return setup_frameper(dai, rate, prot_desc);
+}
+
+static int setup_clocking(struct snd_soc_dai *dai,
+			unsigned int fmt,
+			struct ux500_msp_config *msp_config)
+{
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_NB_NF:
+		break;
+
+	case SND_SOC_DAIFMT_NB_IF:
+		msp_config->tx_fsync_pol ^= 1 << TFSPOL_SHIFT;
+		msp_config->rx_fsync_pol ^= 1 << RFSPOL_SHIFT;
+
+		break;
+
+	default:
+		dev_err(dai->dev,
+			"%s: Error: Unsopported inversion (fmt = 0x%x)!\n",
+			__func__, fmt);
+
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBM_CFM:
+		dev_dbg(dai->dev, "%s: Codec is master.\n", __func__);
+
+		msp_config->iodelay = 0x20;
+		msp_config->rx_fsync_sel = 0;
+		msp_config->tx_fsync_sel = 1 << TFSSEL_SHIFT;
+		msp_config->tx_clk_sel = 0;
+		msp_config->rx_clk_sel = 0;
+		msp_config->srg_clk_sel = 0x2 << SCKSEL_SHIFT;
+
+		break;
+
+	case SND_SOC_DAIFMT_CBS_CFS:
+		dev_dbg(dai->dev, "%s: Codec is slave.\n", __func__);
+
+		msp_config->tx_clk_sel = TX_CLK_SEL_SRG;
+		msp_config->tx_fsync_sel = TX_SYNC_SRG_PROG;
+		msp_config->rx_clk_sel = RX_CLK_SEL_SRG;
+		msp_config->rx_fsync_sel = RX_SYNC_SRG;
+		msp_config->srg_clk_sel = 1 << SCKSEL_SHIFT;
+
+		break;
+
+	default:
+		dev_err(dai->dev, "%s: Error: Unsopported master (fmt = 0x%x)!\n",
+			__func__, fmt);
+
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int setup_pcm_protdesc(struct snd_soc_dai *dai,
+				unsigned int fmt,
+				struct msp_protdesc *prot_desc)
+{
+	prot_desc->rx_phase_mode = MSP_SINGLE_PHASE;
+	prot_desc->tx_phase_mode = MSP_SINGLE_PHASE;
+	prot_desc->rx_phase2_start_mode = MSP_PHASE2_START_MODE_IMEDIATE;
+	prot_desc->tx_phase2_start_mode = MSP_PHASE2_START_MODE_IMEDIATE;
+	prot_desc->rx_byte_order = MSP_BTF_MS_BIT_FIRST;
+	prot_desc->tx_byte_order = MSP_BTF_MS_BIT_FIRST;
+	prot_desc->tx_fsync_pol = MSP_FSYNC_POL(MSP_FSYNC_POL_ACT_HI);
+	prot_desc->rx_fsync_pol = MSP_FSYNC_POL_ACT_HI << RFSPOL_SHIFT;
+
+	if ((fmt & SND_SOC_DAIFMT_FORMAT_MASK) == SND_SOC_DAIFMT_DSP_A) {
+		dev_dbg(dai->dev, "%s: DSP_A.\n", __func__);
+		prot_desc->rx_clk_pol = MSP_RISING_EDGE;
+		prot_desc->tx_clk_pol = MSP_FALLING_EDGE;
+
+		prot_desc->rx_data_delay = MSP_DELAY_1;
+		prot_desc->tx_data_delay = MSP_DELAY_1;
+	} else {
+		dev_dbg(dai->dev, "%s: DSP_B.\n", __func__);
+		prot_desc->rx_clk_pol = MSP_FALLING_EDGE;
+		prot_desc->tx_clk_pol = MSP_RISING_EDGE;
+
+		prot_desc->rx_data_delay = MSP_DELAY_0;
+		prot_desc->tx_data_delay = MSP_DELAY_0;
+	}
+
+	prot_desc->rx_half_word_swap = MSP_SWAP_NONE;
+	prot_desc->tx_half_word_swap = MSP_SWAP_NONE;
+	prot_desc->compression_mode = MSP_COMPRESS_MODE_LINEAR;
+	prot_desc->expansion_mode = MSP_EXPAND_MODE_LINEAR;
+	prot_desc->frame_sync_ignore = MSP_FSYNC_IGNORE;
+
+	return 0;
+}
+
+static int setup_i2s_protdesc(struct msp_protdesc *prot_desc)
+{
+	prot_desc->rx_phase_mode = MSP_DUAL_PHASE;
+	prot_desc->tx_phase_mode = MSP_DUAL_PHASE;
+	prot_desc->rx_phase2_start_mode = MSP_PHASE2_START_MODE_FSYNC;
+	prot_desc->tx_phase2_start_mode = MSP_PHASE2_START_MODE_FSYNC;
+	prot_desc->rx_byte_order = MSP_BTF_MS_BIT_FIRST;
+	prot_desc->tx_byte_order = MSP_BTF_MS_BIT_FIRST;
+	prot_desc->tx_fsync_pol = MSP_FSYNC_POL(MSP_FSYNC_POL_ACT_LO);
+	prot_desc->rx_fsync_pol = MSP_FSYNC_POL_ACT_LO << RFSPOL_SHIFT;
+
+	prot_desc->rx_frame_len_1 = MSP_FRAME_LEN_1;
+	prot_desc->rx_frame_len_2 = MSP_FRAME_LEN_1;
+	prot_desc->tx_frame_len_1 = MSP_FRAME_LEN_1;
+	prot_desc->tx_frame_len_2 = MSP_FRAME_LEN_1;
+	prot_desc->rx_elem_len_1 = MSP_ELEM_LEN_16;
+	prot_desc->rx_elem_len_2 = MSP_ELEM_LEN_16;
+	prot_desc->tx_elem_len_1 = MSP_ELEM_LEN_16;
+	prot_desc->tx_elem_len_2 = MSP_ELEM_LEN_16;
+
+	prot_desc->rx_clk_pol = MSP_RISING_EDGE;
+	prot_desc->tx_clk_pol = MSP_FALLING_EDGE;
+
+	prot_desc->rx_data_delay = MSP_DELAY_0;
+	prot_desc->tx_data_delay = MSP_DELAY_0;
+
+	prot_desc->tx_half_word_swap = MSP_SWAP_NONE;
+	prot_desc->rx_half_word_swap = MSP_SWAP_NONE;
+	prot_desc->compression_mode = MSP_COMPRESS_MODE_LINEAR;
+	prot_desc->expansion_mode = MSP_EXPAND_MODE_LINEAR;
+	prot_desc->frame_sync_ignore = MSP_FSYNC_IGNORE;
+
+	return 0;
+}
+
+static int setup_msp_config(struct snd_pcm_substream *substream,
+			struct snd_soc_dai *dai,
+			struct ux500_msp_config *msp_config)
+{
+	struct ux500_msp_i2s_drvdata *drvdata = dev_get_drvdata(dai->dev);
+	struct msp_protdesc *prot_desc = &msp_config->protdesc;
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	unsigned int fmt = drvdata->fmt;
+	int ret;
+
+	memset(msp_config, 0, sizeof(*msp_config));
+
+	msp_config->f_inputclk = drvdata->master_clk;
+
+	msp_config->tx_fifo_config = TX_FIFO_ENABLE;
+	msp_config->rx_fifo_config = RX_FIFO_ENABLE;
+	msp_config->def_elem_len = 1;
+	msp_config->direction = substream->stream == SNDRV_PCM_STREAM_PLAYBACK ?
+				MSP_DIR_TX : MSP_DIR_RX;
+	msp_config->data_size = MSP_DATA_BITS_32;
+	msp_config->frame_freq = runtime->rate;
+
+	dev_dbg(dai->dev, "%s: f_inputclk = %u, frame_freq = %u.\n",
+	       __func__, msp_config->f_inputclk, msp_config->frame_freq);
+	/* To avoid division by zero */
+	prot_desc->clocks_per_frame = 1;
+
+	dev_dbg(dai->dev, "%s: rate: %u, channels: %d.\n", __func__,
+		runtime->rate, runtime->channels);
+	switch (fmt &
+		(SND_SOC_DAIFMT_FORMAT_MASK | SND_SOC_DAIFMT_MASTER_MASK)) {
+	case SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBS_CFS:
+		dev_dbg(dai->dev, "%s: SND_SOC_DAIFMT_I2S.\n", __func__);
+
+		msp_config->default_protdesc = 1;
+		msp_config->protocol = MSP_I2S_PROTOCOL;
+		break;
+
+	case SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBM_CFM:
+		dev_dbg(dai->dev, "%s: SND_SOC_DAIFMT_I2S.\n", __func__);
+
+		msp_config->data_size = MSP_DATA_BITS_16;
+		msp_config->protocol = MSP_I2S_PROTOCOL;
+
+		ret = setup_i2s_protdesc(prot_desc);
+		if (ret < 0)
+			return ret;
+
+		break;
+
+	case SND_SOC_DAIFMT_DSP_A | SND_SOC_DAIFMT_CBS_CFS:
+	case SND_SOC_DAIFMT_DSP_A | SND_SOC_DAIFMT_CBM_CFM:
+	case SND_SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_CBS_CFS:
+	case SND_SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_CBM_CFM:
+		dev_dbg(dai->dev, "%s: PCM format.\n", __func__);
+
+		msp_config->data_size = MSP_DATA_BITS_16;
+		msp_config->protocol = MSP_PCM_PROTOCOL;
+
+		ret = setup_pcm_protdesc(dai, fmt, prot_desc);
+		if (ret < 0)
+			return ret;
+
+		ret = setup_pcm_multichan(dai, msp_config);
+		if (ret < 0)
+			return ret;
+
+		ret = setup_pcm_framing(dai, runtime->rate, prot_desc);
+		if (ret < 0)
+			return ret;
+
+		break;
+
+	default:
+		dev_err(dai->dev, "%s: Error: Unsopported format (%d)!\n",
+			__func__, fmt);
+		return -EINVAL;
+	}
+
+	return setup_clocking(dai, fmt, msp_config);
+}
+
+static int ux500_msp_dai_startup(struct snd_pcm_substream *substream,
+				struct snd_soc_dai *dai)
+{
+	int ret = 0;
+	struct ux500_msp_i2s_drvdata *drvdata = dev_get_drvdata(dai->dev);
+
+	dev_dbg(dai->dev, "%s: MSP %d (%s): Enter.\n", __func__, dai->id,
+		snd_pcm_stream_str(substream));
+
+	/* Enable regulator */
+	ret = regulator_enable(drvdata->reg_vape);
+	if (ret != 0) {
+		dev_err(drvdata->msp->dev,
+			"%s: Failed to enable regulator!\n", __func__);
+		return ret;
+	}
+
+	/* Enable clock */
+	dev_dbg(dai->dev, "%s: Enabling MSP-clock.\n", __func__);
+	clk_enable(drvdata->clk);
+
+	return 0;
+}
+
+static void ux500_msp_dai_shutdown(struct snd_pcm_substream *substream,
+				struct snd_soc_dai *dai)
+{
+	int ret;
+	struct ux500_msp_i2s_drvdata *drvdata = dev_get_drvdata(dai->dev);
+	bool is_playback = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK);
+
+	dev_dbg(dai->dev, "%s: MSP %d (%s): Enter.\n", __func__, dai->id,
+		snd_pcm_stream_str(substream));
+
+	if (drvdata->vape_opp_constraint == 1) {
+		prcmu_qos_update_requirement(PRCMU_QOS_APE_OPP,
+					"ux500_msp_i2s", 50);
+		drvdata->vape_opp_constraint = 0;
+	}
+
+	if (ux500_msp_i2s_close(drvdata->msp,
+				is_playback ? MSP_DIR_TX : MSP_DIR_RX)) {
+		dev_err(dai->dev,
+			"%s: Error: MSP %d (%s): Unable to close i2s.\n",
+			__func__, dai->id, snd_pcm_stream_str(substream));
+	}
+
+	/* Disable clock */
+	clk_disable(drvdata->clk);
+
+	/* Disable regulator */
+	ret = regulator_disable(drvdata->reg_vape);
+	if (ret < 0)
+		dev_err(dai->dev,
+			"%s: ERROR: Failed to disable regulator (%d)!\n",
+			__func__, ret);
+}
+
+static int ux500_msp_dai_prepare(struct snd_pcm_substream *substream,
+				struct snd_soc_dai *dai)
+{
+	int ret = 0;
+	struct ux500_msp_i2s_drvdata *drvdata = dev_get_drvdata(dai->dev);
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct ux500_msp_config msp_config;
+
+	dev_dbg(dai->dev, "%s: MSP %d (%s): Enter (rate = %d).\n", __func__,
+		dai->id, snd_pcm_stream_str(substream), runtime->rate);
+
+	setup_msp_config(substream, dai, &msp_config);
+
+	ret = ux500_msp_i2s_open(drvdata->msp, &msp_config);
+	if (ret < 0) {
+		dev_err(dai->dev, "%s: Error: msp_setup failed (ret = %d)!\n",
+			__func__, ret);
+		return ret;
+	}
+
+	/* Set OPP-level */
+	if ((drvdata->fmt & SND_SOC_DAIFMT_MASTER_MASK) &&
+		(drvdata->msp->f_bitclk > 19200000)) {
+		/* If the bit-clock is higher than 19.2MHz, Vape should be
+		 * run in 100% OPP. Only when bit-clock is used (MSP master) */
+		prcmu_qos_update_requirement(PRCMU_QOS_APE_OPP,
+					"ux500-msp-i2s", 100);
+		drvdata->vape_opp_constraint = 1;
+	} else {
+		prcmu_qos_update_requirement(PRCMU_QOS_APE_OPP,
+					"ux500-msp-i2s", 50);
+		drvdata->vape_opp_constraint = 0;
+	}
+
+	return ret;
+}
+
+static int ux500_msp_dai_hw_params(struct snd_pcm_substream *substream,
+				struct snd_pcm_hw_params *params,
+				struct snd_soc_dai *dai)
+{
+	unsigned int mask, slots_active;
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct ux500_msp_i2s_drvdata *drvdata = dev_get_drvdata(dai->dev);
+
+	dev_dbg(dai->dev, "%s: MSP %d (%s): Enter.\n",
+			__func__, dai->id, snd_pcm_stream_str(substream));
+
+	switch (drvdata->fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		snd_pcm_hw_constraint_minmax(runtime,
+				SNDRV_PCM_HW_PARAM_CHANNELS,
+				1, 2);
+		break;
+
+	case SND_SOC_DAIFMT_DSP_B:
+	case SND_SOC_DAIFMT_DSP_A:
+		mask = substream->stream == SNDRV_PCM_STREAM_PLAYBACK ?
+			drvdata->tx_mask :
+			drvdata->rx_mask;
+
+		slots_active = hweight32(mask);
+		dev_dbg(dai->dev, "TDM-slots active: %d", slots_active);
+
+		snd_pcm_hw_constraint_minmax(runtime,
+				SNDRV_PCM_HW_PARAM_CHANNELS,
+				slots_active, slots_active);
+		break;
+
+	default:
+		dev_err(dai->dev,
+			"%s: Error: Unsupported protocol (fmt = 0x%x)!\n",
+			__func__, drvdata->fmt);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int ux500_msp_dai_set_dai_fmt(struct snd_soc_dai *dai,
+				unsigned int fmt)
+{
+	struct ux500_msp_i2s_drvdata *drvdata = dev_get_drvdata(dai->dev);
+
+	dev_dbg(dai->dev, "%s: MSP %d: Enter.\n", __func__, dai->id);
+
+	switch (fmt & (SND_SOC_DAIFMT_FORMAT_MASK |
+		SND_SOC_DAIFMT_MASTER_MASK)) {
+	case SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBS_CFS:
+	case SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBM_CFM:
+	case SND_SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_CBS_CFS:
+	case SND_SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_CBM_CFM:
+	case SND_SOC_DAIFMT_DSP_A | SND_SOC_DAIFMT_CBS_CFS:
+	case SND_SOC_DAIFMT_DSP_A | SND_SOC_DAIFMT_CBM_CFM:
+		break;
+
+	default:
+		dev_err(dai->dev,
+			"%s: Error: Unsupported protocol/master (fmt = 0x%x)!\n",
+			__func__, drvdata->fmt);
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_NB_NF:
+	case SND_SOC_DAIFMT_NB_IF:
+	case SND_SOC_DAIFMT_IB_IF:
+		break;
+
+	default:
+		dev_err(dai->dev,
+			"%s: Error: Unsupported inversion (fmt = 0x%x)!\n",
+			__func__, drvdata->fmt);
+		return -EINVAL;
+	}
+
+	drvdata->fmt = fmt;
+	return 0;
+}
+
+static int ux500_msp_dai_set_tdm_slot(struct snd_soc_dai *dai,
+				unsigned int tx_mask,
+				unsigned int rx_mask,
+				int slots, int slot_width)
+{
+	struct ux500_msp_i2s_drvdata *drvdata = dev_get_drvdata(dai->dev);
+	unsigned int cap;
+
+	switch (slots) {
+	case 1:
+		cap = 0x01;
+		break;
+	case 2:
+		cap = 0x03;
+		break;
+	case 8:
+		cap = 0xFF;
+		break;
+	case 16:
+		cap = 0xFFFF;
+		break;
+	default:
+		dev_err(dai->dev, "%s: Error: Unsupported slot-count (%d)!\n",
+			__func__, slots);
+		return -EINVAL;
+	}
+	drvdata->slots = slots;
+
+	if (!(slot_width == 16)) {
+		dev_err(dai->dev, "%s: Error: Unsupported slot-width (%d)!\n",
+			__func__, slot_width);
+		return -EINVAL;
+	}
+	drvdata->slot_width = slot_width;
+
+	drvdata->tx_mask = tx_mask & cap;
+	drvdata->rx_mask = rx_mask & cap;
+
+	return 0;
+}
+
+static int ux500_msp_dai_set_dai_sysclk(struct snd_soc_dai *dai,
+					int clk_id, unsigned int freq, int dir)
+{
+	struct ux500_msp_i2s_drvdata *drvdata = dev_get_drvdata(dai->dev);
+
+	dev_dbg(dai->dev, "%s: MSP %d: Enter. clk-id: %d, freq: %u.\n",
+		__func__, dai->id, clk_id, freq);
+
+	switch (clk_id) {
+	case UX500_MSP_MASTER_CLOCK:
+		drvdata->master_clk = freq;
+		break;
+
+	default:
+		dev_err(dai->dev, "%s: MSP %d: Invalid clk-id (%d)!\n",
+			__func__, dai->id, clk_id);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int ux500_msp_dai_trigger(struct snd_pcm_substream *substream,
+				int cmd, struct snd_soc_dai *dai)
+{
+	int ret = 0;
+	struct ux500_msp_i2s_drvdata *drvdata = dev_get_drvdata(dai->dev);
+
+	dev_dbg(dai->dev, "%s: MSP %d (%s): Enter (msp->id = %d, cmd = %d).\n",
+		__func__, dai->id, snd_pcm_stream_str(substream),
+		(int)drvdata->msp->id, cmd);
+
+	ret = ux500_msp_i2s_trigger(drvdata->msp, cmd, substream->stream);
+
+	return ret;
+}
+
+static int ux500_msp_dai_probe(struct snd_soc_dai *dai)
+{
+	struct ux500_msp_i2s_drvdata *drvdata = dev_get_drvdata(dai->dev);
+
+	drvdata->playback_dma_data.dma_cfg = drvdata->msp->dma_cfg_tx;
+	drvdata->capture_dma_data.dma_cfg = drvdata->msp->dma_cfg_rx;
+
+	dai->playback_dma_data = &drvdata->playback_dma_data;
+	dai->capture_dma_data = &drvdata->capture_dma_data;
+
+	drvdata->playback_dma_data.data_size = drvdata->slot_width;
+	drvdata->capture_dma_data.data_size = drvdata->slot_width;
+
+	return 0;
+}
+
+static struct snd_soc_dai_ops ux500_msp_dai_ops[] = {
+	{
+		.set_sysclk = ux500_msp_dai_set_dai_sysclk,
+		.set_fmt = ux500_msp_dai_set_dai_fmt,
+		.set_tdm_slot = ux500_msp_dai_set_tdm_slot,
+		.startup = ux500_msp_dai_startup,
+		.shutdown = ux500_msp_dai_shutdown,
+		.prepare = ux500_msp_dai_prepare,
+		.trigger = ux500_msp_dai_trigger,
+		.hw_params = ux500_msp_dai_hw_params,
+	}
+};
+
+static struct snd_soc_dai_driver ux500_msp_dai_drv[UX500_NBR_OF_DAI] = {
+	{
+		.name = "ux500-msp-i2s.0",
+		.probe = ux500_msp_dai_probe,
+		.id = 0,
+		.suspend = NULL,
+		.resume = NULL,
+		.playback = {
+			.channels_min = UX500_MSP_MIN_CHANNELS,
+			.channels_max = UX500_MSP_MAX_CHANNELS,
+			.rates = UX500_I2S_RATES,
+			.formats = UX500_I2S_FORMATS,
+		},
+		.capture = {
+			.channels_min = UX500_MSP_MIN_CHANNELS,
+			.channels_max = UX500_MSP_MAX_CHANNELS,
+			.rates = UX500_I2S_RATES,
+			.formats = UX500_I2S_FORMATS,
+		},
+		.ops = ux500_msp_dai_ops,
+	},
+	{
+		.name = "ux500-msp-i2s.1",
+		.probe = ux500_msp_dai_probe,
+		.id = 1,
+		.suspend = NULL,
+		.resume = NULL,
+		.playback = {
+			.channels_min = UX500_MSP_MIN_CHANNELS,
+			.channels_max = UX500_MSP_MAX_CHANNELS,
+			.rates = UX500_I2S_RATES,
+			.formats = UX500_I2S_FORMATS,
+		},
+		.capture = {
+			.channels_min = UX500_MSP_MIN_CHANNELS,
+			.channels_max = UX500_MSP_MAX_CHANNELS,
+			.rates = UX500_I2S_RATES,
+			.formats = UX500_I2S_FORMATS,
+		},
+		.ops = ux500_msp_dai_ops,
+	},
+	{
+		.name = "ux500-msp-i2s.2",
+		.id = 2,
+		.probe = ux500_msp_dai_probe,
+		.suspend = NULL,
+		.resume = NULL,
+		.playback = {
+			.channels_min = UX500_MSP_MIN_CHANNELS,
+			.channels_max = UX500_MSP_MAX_CHANNELS,
+			.rates = UX500_I2S_RATES,
+			.formats = UX500_I2S_FORMATS,
+		},
+		.capture = {
+			.channels_min = UX500_MSP_MIN_CHANNELS,
+			.channels_max = UX500_MSP_MAX_CHANNELS,
+			.rates = UX500_I2S_RATES,
+			.formats = UX500_I2S_FORMATS,
+		},
+		.ops = ux500_msp_dai_ops,
+	},
+	{
+		.name = "ux500-msp-i2s.3",
+		.probe = ux500_msp_dai_probe,
+		.id = 3,
+		.suspend = NULL,
+		.resume = NULL,
+		.playback = {
+			.channels_min = UX500_MSP_MIN_CHANNELS,
+			.channels_max = UX500_MSP_MAX_CHANNELS,
+			.rates = UX500_I2S_RATES,
+			.formats = UX500_I2S_FORMATS,
+		},
+		.capture = {
+			.channels_min = UX500_MSP_MIN_CHANNELS,
+			.channels_max = UX500_MSP_MAX_CHANNELS,
+			.rates = UX500_I2S_RATES,
+			.formats = UX500_I2S_FORMATS,
+		},
+		.ops = ux500_msp_dai_ops,
+	},
+};
+
+static int __devinit ux500_msp_drv_probe(struct platform_device *pdev)
+{
+	struct ux500_msp_i2s_drvdata *drvdata;
+	int ret = 0;
+
+	dev_dbg(&pdev->dev, "%s: Enter (pdev->name = %s).\n", __func__,
+		pdev->name);
+
+	drvdata = devm_kzalloc(&pdev->dev,
+				sizeof(struct ux500_msp_i2s_drvdata),
+				GFP_KERNEL);
+	drvdata->fmt = 0;
+	drvdata->slots = 1;
+	drvdata->tx_mask = 0x01;
+	drvdata->rx_mask = 0x01;
+	drvdata->slot_width = 16;
+	drvdata->master_clk = MSP_INPUT_FREQ_APB;
+
+	drvdata->reg_vape = devm_regulator_get(&pdev->dev, "v-ape");
+	if (IS_ERR(drvdata->reg_vape)) {
+		ret = (int)PTR_ERR(drvdata->reg_vape);
+		dev_err(&pdev->dev,
+			"%s: ERROR: Failed to get Vape supply (%d)!\n",
+			__func__, ret);
+		return ret;
+	}
+	prcmu_qos_add_requirement(PRCMU_QOS_APE_OPP, (char *)pdev->name, 50);
+
+	drvdata->clk = clk_get(&pdev->dev, NULL);
+	if (IS_ERR(drvdata->clk)) {
+		ret = (int)PTR_ERR(drvdata->clk);
+		dev_err(&pdev->dev, "%s: ERROR: clk_get failed (%d)!\n",
+			__func__, ret);
+		goto err_clk;
+	}
+
+	ret = ux500_msp_i2s_init_msp(pdev, &drvdata->msp,
+				pdev->dev.platform_data);
+	if (!drvdata->msp) {
+		dev_err(&pdev->dev,
+			"%s: ERROR: Failed to init MSP-struct (%d)!",
+			__func__, ret);
+		goto err_init_msp;
+	}
+	dev_set_drvdata(&pdev->dev, drvdata);
+
+	ret = snd_soc_register_dai(&pdev->dev,
+				&ux500_msp_dai_drv[drvdata->msp->id]);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Error: %s: Failed to register MSP%d!\n",
+			__func__, drvdata->msp->id);
+		goto err_init_msp;
+	}
+
+	return 0;
+
+err_init_msp:
+	clk_put(drvdata->clk);
+
+err_clk:
+	devm_regulator_put(drvdata->reg_vape);
+
+	return ret;
+}
+
+static int __devexit ux500_msp_drv_remove(struct platform_device *pdev)
+{
+	struct ux500_msp_i2s_drvdata *drvdata = dev_get_drvdata(&pdev->dev);
+
+	snd_soc_unregister_dais(&pdev->dev, ARRAY_SIZE(ux500_msp_dai_drv));
+
+	devm_regulator_put(drvdata->reg_vape);
+	prcmu_qos_remove_requirement(PRCMU_QOS_APE_OPP, "ux500_msp_i2s");
+
+	clk_put(drvdata->clk);
+
+	ux500_msp_i2s_cleanup_msp(pdev, drvdata->msp);
+
+	return 0;
+}
+
+static struct platform_driver msp_i2s_driver = {
+	.driver = {
+		.name = "ux500-msp-i2s",
+		.owner = THIS_MODULE,
+	},
+	.probe = ux500_msp_drv_probe,
+	.remove = ux500_msp_drv_remove,
+};
+module_platform_driver(msp_i2s_driver);
+
+MODULE_LICENSE("GPLv2");
diff --git a/sound/soc/ux500/ux500_msp_dai.h b/sound/soc/ux500/ux500_msp_dai.h
new file mode 100644
index 0000000..98202a3
--- /dev/null
+++ b/sound/soc/ux500/ux500_msp_dai.h
@@ -0,0 +1,79 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2012
+ *
+ * Author: Ola Lilja <ola.o.lilja@stericsson.com>,
+ *         Roger Nilsson <roger.xr.nilsson@stericsson.com>
+ *         for ST-Ericsson.
+ *
+ * License terms:
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ */
+
+#ifndef UX500_msp_dai_H
+#define UX500_msp_dai_H
+
+#include <linux/types.h>
+#include <linux/spinlock.h>
+
+#include "ux500_msp_i2s.h"
+
+#define UX500_NBR_OF_DAI	4
+
+#define UX500_I2S_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |	\
+			SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000)
+
+#define UX500_I2S_FORMATS (SNDRV_PCM_FMTBIT_S16_LE)
+
+#define FRAME_PER_SINGLE_SLOT_8_KHZ		31
+#define FRAME_PER_SINGLE_SLOT_16_KHZ	124
+#define FRAME_PER_SINGLE_SLOT_44_1_KHZ	63
+#define FRAME_PER_SINGLE_SLOT_48_KHZ	49
+#define FRAME_PER_2_SLOTS				31
+#define FRAME_PER_8_SLOTS				138
+#define FRAME_PER_16_SLOTS				277
+
+#ifndef CONFIG_SND_SOC_UX500_AB5500
+#define UX500_MSP_INTERNAL_CLOCK_FREQ  40000000
+#define UX500_MSP1_INTERNAL_CLOCK_FREQ UX500_MSP_INTERNAL_CLOCK_FREQ
+#else
+#define UX500_MSP_INTERNAL_CLOCK_FREQ 13000000
+#define UX500_MSP1_INTERNAL_CLOCK_FREQ (UX500_MSP_INTERNAL_CLOCK_FREQ * 2)
+#endif
+
+#define UX500_MSP_MIN_CHANNELS		1
+#define UX500_MSP_MAX_CHANNELS		8
+
+#define PLAYBACK_CONFIGURED		1
+#define CAPTURE_CONFIGURED		2
+
+enum ux500_msp_clock_id {
+	UX500_MSP_MASTER_CLOCK,
+};
+
+struct ux500_msp_i2s_drvdata {
+	struct ux500_msp *msp;
+	struct regulator *reg_vape;
+	struct ux500_msp_dma_params playback_dma_data;
+	struct ux500_msp_dma_params capture_dma_data;
+	unsigned int fmt;
+	unsigned int tx_mask;
+	unsigned int rx_mask;
+	int slots;
+	int slot_width;
+	u8 configured;
+	int data_delay;
+
+	/* Clocks */
+	unsigned int master_clk;
+	struct clk *clk;
+
+	/* Regulators */
+	int vape_opp_constraint;
+};
+
+int ux500_msp_dai_set_data_delay(struct snd_soc_dai *dai, int delay);
+
+#endif
diff --git a/sound/soc/ux500/ux500_msp_i2s.c b/sound/soc/ux500/ux500_msp_i2s.c
new file mode 100644
index 0000000..496dec1
--- /dev/null
+++ b/sound/soc/ux500/ux500_msp_i2s.c
@@ -0,0 +1,742 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2012
+ *
+ * Author: Ola Lilja <ola.o.lilja@stericsson.com>,
+ *         Roger Nilsson <roger.xr.nilsson@stericsson.com>,
+ *         Sandeep Kaushik <sandeep.kaushik@st.com>
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
+#include <linux/platform_device.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+
+#include <mach/hardware.h>
+#include <mach/board-mop500-msp.h>
+
+#include <sound/soc.h>
+
+#include "ux500_msp_i2s.h"
+
+ /* Protocol desciptors */
+static const struct msp_protdesc prot_descs[] = {
+	{ /* I2S */
+		MSP_SINGLE_PHASE,
+		MSP_SINGLE_PHASE,
+		MSP_PHASE2_START_MODE_IMEDIATE,
+		MSP_PHASE2_START_MODE_IMEDIATE,
+		MSP_BTF_MS_BIT_FIRST,
+		MSP_BTF_MS_BIT_FIRST,
+		MSP_FRAME_LEN_1,
+		MSP_FRAME_LEN_1,
+		MSP_FRAME_LEN_1,
+		MSP_FRAME_LEN_1,
+		MSP_ELEM_LEN_32,
+		MSP_ELEM_LEN_32,
+		MSP_ELEM_LEN_32,
+		MSP_ELEM_LEN_32,
+		MSP_DELAY_1,
+		MSP_DELAY_1,
+		MSP_RISING_EDGE,
+		MSP_FALLING_EDGE,
+		MSP_FSYNC_POL_ACT_LO,
+		MSP_FSYNC_POL_ACT_LO,
+		MSP_SWAP_NONE,
+		MSP_SWAP_NONE,
+		MSP_COMPRESS_MODE_LINEAR,
+		MSP_EXPAND_MODE_LINEAR,
+		MSP_FSYNC_IGNORE,
+		31,
+		15,
+		32,
+	}, { /* PCM */
+		MSP_DUAL_PHASE,
+		MSP_DUAL_PHASE,
+		MSP_PHASE2_START_MODE_FSYNC,
+		MSP_PHASE2_START_MODE_FSYNC,
+		MSP_BTF_MS_BIT_FIRST,
+		MSP_BTF_MS_BIT_FIRST,
+		MSP_FRAME_LEN_1,
+		MSP_FRAME_LEN_1,
+		MSP_FRAME_LEN_1,
+		MSP_FRAME_LEN_1,
+		MSP_ELEM_LEN_16,
+		MSP_ELEM_LEN_16,
+		MSP_ELEM_LEN_16,
+		MSP_ELEM_LEN_16,
+		MSP_DELAY_0,
+		MSP_DELAY_0,
+		MSP_RISING_EDGE,
+		MSP_FALLING_EDGE,
+		MSP_FSYNC_POL_ACT_HI,
+		MSP_FSYNC_POL_ACT_HI,
+		MSP_SWAP_NONE,
+		MSP_SWAP_NONE,
+		MSP_COMPRESS_MODE_LINEAR,
+		MSP_EXPAND_MODE_LINEAR,
+		MSP_FSYNC_IGNORE,
+		255,
+		0,
+		256,
+	}, { /* Companded PCM */
+		MSP_SINGLE_PHASE,
+		MSP_SINGLE_PHASE,
+		MSP_PHASE2_START_MODE_FSYNC,
+		MSP_PHASE2_START_MODE_FSYNC,
+		MSP_BTF_MS_BIT_FIRST,
+		MSP_BTF_MS_BIT_FIRST,
+		MSP_FRAME_LEN_1,
+		MSP_FRAME_LEN_1,
+		MSP_FRAME_LEN_1,
+		MSP_FRAME_LEN_1,
+		MSP_ELEM_LEN_8,
+		MSP_ELEM_LEN_8,
+		MSP_ELEM_LEN_8,
+		MSP_ELEM_LEN_8,
+		MSP_DELAY_0,
+		MSP_DELAY_0,
+		MSP_RISING_EDGE,
+		MSP_RISING_EDGE,
+		MSP_FSYNC_POL_ACT_HI,
+		MSP_FSYNC_POL_ACT_HI,
+		MSP_SWAP_NONE,
+		MSP_SWAP_NONE,
+		MSP_COMPRESS_MODE_LINEAR,
+		MSP_EXPAND_MODE_LINEAR,
+		MSP_FSYNC_IGNORE,
+		255,
+		0,
+		256,
+	},
+};
+
+static void set_prot_desc_tx(struct ux500_msp *msp,
+			struct msp_protdesc *protdesc,
+			enum msp_data_size data_size)
+{
+	u32 temp_reg = 0;
+
+	temp_reg |= MSP_P2_ENABLE_BIT(protdesc->tx_phase_mode);
+	temp_reg |= MSP_P2_START_MODE_BIT(protdesc->tx_phase2_start_mode);
+	temp_reg |= MSP_P1_FRAME_LEN_BITS(protdesc->tx_frame_len_1);
+	temp_reg |= MSP_P2_FRAME_LEN_BITS(protdesc->tx_frame_len_2);
+	if (msp->def_elem_len) {
+		temp_reg |= MSP_P1_ELEM_LEN_BITS(protdesc->tx_elem_len_1);
+		temp_reg |= MSP_P2_ELEM_LEN_BITS(protdesc->tx_elem_len_2);
+	} else {
+		temp_reg |= MSP_P1_ELEM_LEN_BITS(data_size);
+		temp_reg |= MSP_P2_ELEM_LEN_BITS(data_size);
+	}
+	temp_reg |= MSP_DATA_DELAY_BITS(protdesc->tx_data_delay);
+	temp_reg |= MSP_SET_ENDIANNES_BIT(protdesc->tx_byte_order);
+	temp_reg |= MSP_FSYNC_POL(protdesc->tx_fsync_pol);
+	temp_reg |= MSP_DATA_WORD_SWAP(protdesc->tx_half_word_swap);
+	temp_reg |= MSP_SET_COMPANDING_MODE(protdesc->compression_mode);
+	temp_reg |= MSP_SET_FSYNC_IGNORE(protdesc->frame_sync_ignore);
+
+	writel(temp_reg, msp->registers + MSP_TCF);
+}
+
+static void set_prot_desc_rx(struct ux500_msp *msp,
+			struct msp_protdesc *protdesc,
+			enum msp_data_size data_size)
+{
+	u32 temp_reg = 0;
+
+	temp_reg |= MSP_P2_ENABLE_BIT(protdesc->rx_phase_mode);
+	temp_reg |= MSP_P2_START_MODE_BIT(protdesc->rx_phase2_start_mode);
+	temp_reg |= MSP_P1_FRAME_LEN_BITS(protdesc->rx_frame_len_1);
+	temp_reg |= MSP_P2_FRAME_LEN_BITS(protdesc->rx_frame_len_2);
+	if (msp->def_elem_len) {
+		temp_reg |= MSP_P1_ELEM_LEN_BITS(protdesc->rx_elem_len_1);
+		temp_reg |= MSP_P2_ELEM_LEN_BITS(protdesc->rx_elem_len_2);
+	} else {
+		temp_reg |= MSP_P1_ELEM_LEN_BITS(data_size);
+		temp_reg |= MSP_P2_ELEM_LEN_BITS(data_size);
+	}
+
+	temp_reg |= MSP_DATA_DELAY_BITS(protdesc->rx_data_delay);
+	temp_reg |= MSP_SET_ENDIANNES_BIT(protdesc->rx_byte_order);
+	temp_reg |= MSP_FSYNC_POL(protdesc->rx_fsync_pol);
+	temp_reg |= MSP_DATA_WORD_SWAP(protdesc->rx_half_word_swap);
+	temp_reg |= MSP_SET_COMPANDING_MODE(protdesc->expansion_mode);
+	temp_reg |= MSP_SET_FSYNC_IGNORE(protdesc->frame_sync_ignore);
+
+	writel(temp_reg, msp->registers + MSP_RCF);
+}
+
+static int configure_protocol(struct ux500_msp *msp,
+			struct ux500_msp_config *config)
+{
+	struct msp_protdesc *protdesc;
+	enum msp_data_size data_size;
+	u32 temp_reg = 0;
+
+	data_size = config->data_size;
+	msp->def_elem_len = config->def_elem_len;
+	if (config->default_protdesc == 1) {
+		if (config->protocol >= MSP_INVALID_PROTOCOL) {
+			dev_err(msp->dev, "%s: ERROR: Invalid protocol!\n",
+				__func__);
+			return -EINVAL;
+		}
+		protdesc =
+		    (struct msp_protdesc *)&prot_descs[config->protocol];
+	} else {
+		protdesc = (struct msp_protdesc *)&config->protdesc;
+	}
+
+	if (data_size < MSP_DATA_BITS_DEFAULT || data_size > MSP_DATA_BITS_32) {
+		dev_err(msp->dev,
+			"%s: ERROR: Invalid data-size requested (data_size = %d)!\n",
+			__func__, data_size);
+		return -EINVAL;
+	}
+
+	if (config->direction & MSP_DIR_TX)
+		set_prot_desc_tx(msp, protdesc, data_size);
+	if (config->direction & MSP_DIR_RX)
+		set_prot_desc_rx(msp, protdesc, data_size);
+
+	/* The code below should not be separated. */
+	temp_reg = readl(msp->registers + MSP_GCR) & ~TX_CLK_POL_RISING;
+	temp_reg |= MSP_TX_CLKPOL_BIT(~protdesc->tx_clk_pol);
+	writel(temp_reg, msp->registers + MSP_GCR);
+	temp_reg = readl(msp->registers + MSP_GCR) & ~RX_CLK_POL_RISING;
+	temp_reg |= MSP_RX_CLKPOL_BIT(protdesc->rx_clk_pol);
+	writel(temp_reg, msp->registers + MSP_GCR);
+
+	return 0;
+}
+
+static int setup_bitclk(struct ux500_msp *msp, struct ux500_msp_config *config)
+{
+	u32 reg_val_GCR;
+	u32 frame_per = 0;
+	u32 sck_div = 0;
+	u32 frame_width = 0;
+	u32 temp_reg = 0;
+	struct msp_protdesc *protdesc = NULL;
+
+	reg_val_GCR = readl(msp->registers + MSP_GCR);
+	writel(reg_val_GCR & ~SRG_ENABLE, msp->registers + MSP_GCR);
+
+	if (config->default_protdesc)
+		protdesc =
+			(struct msp_protdesc *)&prot_descs[config->protocol];
+	else
+		protdesc = (struct msp_protdesc *)&config->protdesc;
+
+	switch (config->protocol) {
+	case MSP_PCM_PROTOCOL:
+	case MSP_PCM_COMPAND_PROTOCOL:
+		frame_width = protdesc->frame_width;
+		sck_div = config->f_inputclk / (config->frame_freq *
+			(protdesc->clocks_per_frame));
+		frame_per = protdesc->frame_period;
+		break;
+	case MSP_I2S_PROTOCOL:
+		frame_width = protdesc->frame_width;
+		sck_div = config->f_inputclk / (config->frame_freq *
+			(protdesc->clocks_per_frame));
+		frame_per = protdesc->frame_period;
+		break;
+	default:
+		dev_err(msp->dev, "%s: ERROR: Unknown protocol (%d)!\n",
+			__func__,
+			config->protocol);
+		return -EINVAL;
+	}
+
+	temp_reg = (sck_div - 1) & SCK_DIV_MASK;
+	temp_reg |= FRAME_WIDTH_BITS(frame_width);
+	temp_reg |= FRAME_PERIOD_BITS(frame_per);
+	writel(temp_reg, msp->registers + MSP_SRG);
+
+	msp->f_bitclk = (config->f_inputclk)/(sck_div + 1);
+
+	/* Enable bit-clock */
+	udelay(100);
+	reg_val_GCR = readl(msp->registers + MSP_GCR);
+	writel(reg_val_GCR | SRG_ENABLE, msp->registers + MSP_GCR);
+	udelay(100);
+
+	return 0;
+}
+
+static int configure_multichannel(struct ux500_msp *msp,
+				struct ux500_msp_config *config)
+{
+	struct msp_protdesc *protdesc;
+	struct msp_multichannel_config *mcfg;
+	u32 reg_val_MCR;
+
+	if (config->default_protdesc == 1) {
+		if (config->protocol >= MSP_INVALID_PROTOCOL) {
+			dev_err(msp->dev,
+				"%s: ERROR: Invalid protocol (%d)!\n",
+				__func__, config->protocol);
+			return -EINVAL;
+		}
+		protdesc = (struct msp_protdesc *)
+				&prot_descs[config->protocol];
+	} else {
+		protdesc = (struct msp_protdesc *)&config->protdesc;
+	}
+
+	mcfg = &config->multichannel_config;
+	if (mcfg->tx_multichannel_enable) {
+		if (protdesc->tx_phase_mode == MSP_SINGLE_PHASE) {
+			reg_val_MCR = readl(msp->registers + MSP_MCR);
+			writel(reg_val_MCR | (mcfg->tx_multichannel_enable ?
+						1 << TMCEN_BIT : 0),
+				msp->registers + MSP_MCR);
+			writel(mcfg->tx_channel_0_enable,
+				msp->registers + MSP_TCE0);
+			writel(mcfg->tx_channel_1_enable,
+				msp->registers + MSP_TCE1);
+			writel(mcfg->tx_channel_2_enable,
+				msp->registers + MSP_TCE2);
+			writel(mcfg->tx_channel_3_enable,
+				msp->registers + MSP_TCE3);
+		} else {
+			dev_err(msp->dev,
+				"%s: ERROR: Only single-phase supported (TX-mode: %d)!\n",
+				__func__, protdesc->tx_phase_mode);
+			return -EINVAL;
+		}
+	}
+	if (mcfg->rx_multichannel_enable) {
+		if (protdesc->rx_phase_mode == MSP_SINGLE_PHASE) {
+			reg_val_MCR = readl(msp->registers + MSP_MCR);
+			writel(reg_val_MCR | (mcfg->rx_multichannel_enable ?
+						1 << RMCEN_BIT : 0),
+				msp->registers + MSP_MCR);
+			writel(mcfg->rx_channel_0_enable,
+					msp->registers + MSP_RCE0);
+			writel(mcfg->rx_channel_1_enable,
+					msp->registers + MSP_RCE1);
+			writel(mcfg->rx_channel_2_enable,
+					msp->registers + MSP_RCE2);
+			writel(mcfg->rx_channel_3_enable,
+					msp->registers + MSP_RCE3);
+		} else {
+			dev_err(msp->dev,
+				"%s: ERROR: Only single-phase supported (RX-mode: %d)!\n",
+				__func__, protdesc->rx_phase_mode);
+			return -EINVAL;
+		}
+		if (mcfg->rx_comparison_enable_mode) {
+			reg_val_MCR = readl(msp->registers + MSP_MCR);
+			writel(reg_val_MCR |
+				(mcfg->rx_comparison_enable_mode << RCMPM_BIT),
+				msp->registers + MSP_MCR);
+
+			writel(mcfg->comparison_mask,
+					msp->registers + MSP_RCM);
+			writel(mcfg->comparison_value,
+					msp->registers + MSP_RCV);
+
+		}
+	}
+
+	return 0;
+}
+
+static int enable_msp(struct ux500_msp *msp, struct ux500_msp_config *config)
+{
+	int status = 0;
+	u32 reg_val_DMACR, reg_val_GCR;
+
+	/* Check msp state whether in RUN or CONFIGURED Mode */
+	if ((msp->msp_state == MSP_STATE_IDLE) && (msp->plat_init)) {
+		status = msp->plat_init();
+		if (status) {
+			dev_err(msp->dev, "%s: ERROR: Failed to init MSP (%d)!\n",
+				__func__, status);
+			return status;
+		}
+	}
+
+	/* Configure msp with protocol dependent settings */
+	configure_protocol(msp, config);
+	setup_bitclk(msp, config);
+	if (config->multichannel_configured == 1) {
+		status = configure_multichannel(msp, config);
+		if (status)
+			dev_warn(msp->dev,
+				"%s: WARN: configure_multichannel failed (%d)!\n",
+				__func__, status);
+	}
+
+	/* Make sure the correct DMA-directions are configured */
+	if ((config->direction & MSP_DIR_RX) && (!msp->dma_cfg_rx)) {
+		dev_err(msp->dev, "%s: ERROR: MSP RX-mode is not configured!",
+			__func__);
+		return -EINVAL;
+	}
+	if ((config->direction == MSP_DIR_TX) && (!msp->dma_cfg_tx)) {
+		dev_err(msp->dev, "%s: ERROR: MSP TX-mode is not configured!",
+			__func__);
+		return -EINVAL;
+	}
+
+	reg_val_DMACR = readl(msp->registers + MSP_DMACR);
+	if (config->direction & MSP_DIR_RX)
+		reg_val_DMACR |= RX_DMA_ENABLE;
+	if (config->direction & MSP_DIR_TX)
+		reg_val_DMACR |= TX_DMA_ENABLE;
+	writel(reg_val_DMACR, msp->registers + MSP_DMACR);
+
+	writel(config->iodelay, msp->registers + MSP_IODLY);
+
+	/* Enable frame generation logic */
+	reg_val_GCR = readl(msp->registers + MSP_GCR);
+	writel(reg_val_GCR | FRAME_GEN_ENABLE, msp->registers + MSP_GCR);
+
+	return status;
+}
+
+static void flush_fifo_rx(struct ux500_msp *msp)
+{
+	u32 reg_val_DR, reg_val_GCR, reg_val_FLR;
+	u32 limit = 32;
+
+	reg_val_GCR = readl(msp->registers + MSP_GCR);
+	writel(reg_val_GCR | RX_ENABLE, msp->registers + MSP_GCR);
+
+	reg_val_FLR = readl(msp->registers + MSP_FLR);
+	while (!(reg_val_FLR & RX_FIFO_EMPTY) && limit--) {
+		reg_val_DR = readl(msp->registers + MSP_DR);
+		reg_val_FLR = readl(msp->registers + MSP_FLR);
+	}
+
+	writel(reg_val_GCR, msp->registers + MSP_GCR);
+}
+
+static void flush_fifo_tx(struct ux500_msp *msp)
+{
+	u32 reg_val_TSTDR, reg_val_GCR, reg_val_FLR;
+	u32 limit = 32;
+
+	reg_val_GCR = readl(msp->registers + MSP_GCR);
+	writel(reg_val_GCR | TX_ENABLE, msp->registers + MSP_GCR);
+	writel(MSP_ITCR_ITEN | MSP_ITCR_TESTFIFO, msp->registers + MSP_ITCR);
+
+	reg_val_FLR = readl(msp->registers + MSP_FLR);
+	while (!(reg_val_FLR & TX_FIFO_EMPTY) && limit--) {
+		reg_val_TSTDR = readl(msp->registers + MSP_TSTDR);
+		reg_val_FLR = readl(msp->registers + MSP_FLR);
+	}
+	writel(0x0, msp->registers + MSP_ITCR);
+	writel(reg_val_GCR, msp->registers + MSP_GCR);
+}
+
+int ux500_msp_i2s_open(struct ux500_msp *msp,
+		struct ux500_msp_config *config)
+{
+	u32 old_reg, new_reg, mask;
+	int res;
+	unsigned int tx_sel, rx_sel, tx_busy, rx_busy;
+
+	if (in_interrupt()) {
+		dev_err(msp->dev,
+			"%s: ERROR: Open called in interrupt context!\n",
+			__func__);
+		return -1;
+	}
+
+	tx_sel = (config->direction & MSP_DIR_TX) > 0;
+	rx_sel = (config->direction & MSP_DIR_RX) > 0;
+	if (!tx_sel && !rx_sel) {
+		dev_err(msp->dev, "%s: Error: No direction selected!\n",
+			__func__);
+		return -EINVAL;
+	}
+
+	tx_busy = (msp->dir_busy & MSP_DIR_TX) > 0;
+	rx_busy = (msp->dir_busy & MSP_DIR_RX) > 0;
+	if (tx_busy && tx_sel) {
+		dev_err(msp->dev, "%s: Error: TX is in use!\n", __func__);
+		return -EBUSY;
+	}
+	if (rx_busy && rx_sel) {
+		dev_err(msp->dev, "%s: Error: RX is in use!\n", __func__);
+		return -EBUSY;
+	}
+
+	msp->dir_busy |= (tx_sel ? MSP_DIR_TX : 0) | (rx_sel ? MSP_DIR_RX : 0);
+
+	/* First do the global config register */
+	mask = RX_CLK_SEL_MASK | TX_CLK_SEL_MASK | RX_FSYNC_MASK |
+	    TX_FSYNC_MASK | RX_SYNC_SEL_MASK | TX_SYNC_SEL_MASK |
+	    RX_FIFO_ENABLE_MASK | TX_FIFO_ENABLE_MASK | SRG_CLK_SEL_MASK |
+	    LOOPBACK_MASK | TX_EXTRA_DELAY_MASK;
+
+	new_reg = (config->tx_clk_sel | config->rx_clk_sel |
+		config->rx_fsync_pol | config->tx_fsync_pol |
+		config->rx_fsync_sel | config->tx_fsync_sel |
+		config->rx_fifo_config | config->tx_fifo_config |
+		config->srg_clk_sel | config->loopback_enable |
+		config->tx_data_enable);
+
+	old_reg = readl(msp->registers + MSP_GCR);
+	old_reg &= ~mask;
+	new_reg |= old_reg;
+	writel(new_reg, msp->registers + MSP_GCR);
+
+	res = enable_msp(msp, config);
+	if (res < 0) {
+		dev_err(msp->dev, "%s: ERROR: enable_msp failed (%d)!\n",
+			__func__, res);
+		return -EBUSY;
+	}
+	if (config->loopback_enable & 0x80)
+		msp->loopback_enable = 1;
+
+	/* Flush FIFOs */
+	flush_fifo_tx(msp);
+	flush_fifo_rx(msp);
+
+	msp->msp_state = MSP_STATE_CONFIGURED;
+	return 0;
+}
+
+static void disable_msp_rx(struct ux500_msp *msp)
+{
+	u32 reg_val_GCR, reg_val_DMACR, reg_val_IMSC;
+
+	reg_val_GCR = readl(msp->registers + MSP_GCR);
+	writel(reg_val_GCR & ~RX_ENABLE, msp->registers + MSP_GCR);
+	reg_val_DMACR = readl(msp->registers + MSP_DMACR);
+	writel(reg_val_DMACR & ~RX_DMA_ENABLE, msp->registers + MSP_DMACR);
+	reg_val_IMSC = readl(msp->registers + MSP_IMSC);
+	writel(reg_val_IMSC &
+			~(RX_SERVICE_INT | RX_OVERRUN_ERROR_INT),
+			msp->registers + MSP_IMSC);
+
+	msp->dir_busy &= ~MSP_DIR_RX;
+}
+
+static void disable_msp_tx(struct ux500_msp *msp)
+{
+	u32 reg_val_GCR, reg_val_DMACR, reg_val_IMSC;
+
+	reg_val_GCR = readl(msp->registers + MSP_GCR);
+	writel(reg_val_GCR & ~TX_ENABLE, msp->registers + MSP_GCR);
+	reg_val_DMACR = readl(msp->registers + MSP_DMACR);
+	writel(reg_val_DMACR & ~TX_DMA_ENABLE, msp->registers + MSP_DMACR);
+	reg_val_IMSC = readl(msp->registers + MSP_IMSC);
+	writel(reg_val_IMSC &
+			~(TX_SERVICE_INT | TX_UNDERRUN_ERR_INT),
+			msp->registers + MSP_IMSC);
+
+	msp->dir_busy &= ~MSP_DIR_TX;
+}
+
+static int disable_msp(struct ux500_msp *msp, unsigned int dir)
+{
+	u32 reg_val_GCR;
+	int status = 0;
+	unsigned int disable_tx, disable_rx;
+
+	reg_val_GCR = readl(msp->registers + MSP_GCR);
+	disable_tx = dir & MSP_DIR_TX;
+	disable_rx = dir & MSP_DIR_TX;
+	if (disable_tx && disable_rx) {
+		reg_val_GCR = readl(msp->registers + MSP_GCR);
+		writel(reg_val_GCR | LOOPBACK_MASK,
+				msp->registers + MSP_GCR);
+
+		/* Flush TX-FIFO */
+		flush_fifo_tx(msp);
+
+		/* Disable TX-channel */
+		writel((readl(msp->registers + MSP_GCR) &
+			       (~TX_ENABLE)), msp->registers + MSP_GCR);
+
+		/* Flush RX-FIFO */
+		flush_fifo_rx(msp);
+
+		/* Disable Loopback and Receive channel */
+		writel((readl(msp->registers + MSP_GCR) &
+				(~(RX_ENABLE | LOOPBACK_MASK))),
+				msp->registers + MSP_GCR);
+
+		disable_msp_tx(msp);
+		disable_msp_rx(msp);
+	} else if (disable_tx)
+		disable_msp_tx(msp);
+	else if (disable_rx)
+		disable_msp_rx(msp);
+
+	return status;
+}
+
+int ux500_msp_i2s_trigger(struct ux500_msp *msp, int cmd, int direction)
+{
+	u32 reg_val_GCR, enable_bit;
+
+	if (msp->msp_state == MSP_STATE_IDLE) {
+		dev_err(msp->dev, "%s: ERROR: MSP is not configured!\n",
+			__func__);
+		return -EINVAL;
+	}
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		if (direction == SNDRV_PCM_STREAM_PLAYBACK)
+			enable_bit = TX_ENABLE;
+		else
+			enable_bit = RX_ENABLE;
+		reg_val_GCR = readl(msp->registers + MSP_GCR);
+		writel(reg_val_GCR | enable_bit, msp->registers + MSP_GCR);
+		break;
+
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		if (direction == SNDRV_PCM_STREAM_PLAYBACK)
+			disable_msp_tx(msp);
+		else
+			disable_msp_rx(msp);
+		break;
+	default:
+		return -EINVAL;
+		break;
+	}
+
+	return 0;
+}
+
+int ux500_msp_i2s_close(struct ux500_msp *msp, unsigned int dir)
+{
+	int status = 0;
+
+	dev_dbg(msp->dev, "%s: Enter (dir = 0x%01x).\n", __func__, dir);
+
+	status = disable_msp(msp, dir);
+	if (msp->dir_busy == 0) {
+		/* disable sample rate and frame generators */
+		msp->msp_state = MSP_STATE_IDLE;
+		writel((readl(msp->registers + MSP_GCR) &
+			       (~(FRAME_GEN_ENABLE | SRG_ENABLE))),
+			      msp->registers + MSP_GCR);
+		if (msp->plat_exit)
+			status = msp->plat_exit();
+			if (status)
+				dev_warn(msp->dev,
+					"%s: WARN: ux500_msp_i2s_exit failed (%d)!\n",
+					__func__, status);
+		writel(0, msp->registers + MSP_GCR);
+		writel(0, msp->registers + MSP_TCF);
+		writel(0, msp->registers + MSP_RCF);
+		writel(0, msp->registers + MSP_DMACR);
+		writel(0, msp->registers + MSP_SRG);
+		writel(0, msp->registers + MSP_MCR);
+		writel(0, msp->registers + MSP_RCM);
+		writel(0, msp->registers + MSP_RCV);
+		writel(0, msp->registers + MSP_TCE0);
+		writel(0, msp->registers + MSP_TCE1);
+		writel(0, msp->registers + MSP_TCE2);
+		writel(0, msp->registers + MSP_TCE3);
+		writel(0, msp->registers + MSP_RCE0);
+		writel(0, msp->registers + MSP_RCE1);
+		writel(0, msp->registers + MSP_RCE2);
+		writel(0, msp->registers + MSP_RCE3);
+	}
+
+	return status;
+
+}
+
+int ux500_msp_i2s_init_msp(struct platform_device *pdev,
+			struct ux500_msp **msp_p,
+			struct msp_i2s_platform_data *platform_data)
+{
+	int ret = 0;
+	struct resource *res = NULL;
+	struct i2s_controller *i2s_cont;
+	struct ux500_msp *msp;
+
+	dev_dbg(&pdev->dev, "%s: Enter (name: %s, id: %d).\n", __func__,
+		pdev->name, platform_data->id);
+
+	*msp_p = devm_kzalloc(&pdev->dev, sizeof(struct ux500_msp), GFP_KERNEL);
+	msp = *msp_p;
+
+	msp->id = platform_data->id;
+	msp->dev = &pdev->dev;
+	msp->plat_init = platform_data->msp_i2s_init;
+	msp->plat_exit = platform_data->msp_i2s_exit;
+	msp->dma_cfg_rx = platform_data->msp_i2s_dma_rx;
+	msp->dma_cfg_tx = platform_data->msp_i2s_dma_tx;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (res == NULL) {
+		dev_err(&pdev->dev, "%s: ERROR: Unable to get resource!\n",
+			__func__);
+		ret = -ENOMEM;
+		goto err_res;
+	}
+
+	msp->registers = ioremap(res->start, (res->end - res->start + 1));
+	if (msp->registers == NULL) {
+		dev_err(&pdev->dev, "%s: ERROR: ioremap failed!\n", __func__);
+		ret = -ENOMEM;
+		goto err_res;
+	}
+
+	msp->msp_state = MSP_STATE_IDLE;
+	msp->loopback_enable = 0;
+
+	/* I2S-controller is allocated and added in I2S controller class. */
+	i2s_cont = devm_kzalloc(&pdev->dev, sizeof(*i2s_cont), GFP_KERNEL);
+	if (!i2s_cont) {
+		dev_err(&pdev->dev,
+			"%s: ERROR: Failed to allocate I2S-controller!\n",
+			__func__);
+		goto err_i2s_cont;
+	}
+	i2s_cont->dev.parent = &pdev->dev;
+	i2s_cont->data = (void *)msp;
+	i2s_cont->id = (s16)msp->id;
+	snprintf(i2s_cont->name, sizeof(i2s_cont->name), "ux500-msp-i2s.%04x",
+		msp->id);
+	dev_dbg(&pdev->dev, "I2S device-name: '%s'\n", i2s_cont->name);
+	msp->i2s_cont = i2s_cont;
+
+	return 0;
+
+err_i2s_cont:
+	iounmap(msp->registers);
+
+err_res:
+	devm_kfree(&pdev->dev, msp);
+
+	return ret;
+}
+
+void ux500_msp_i2s_cleanup_msp(struct platform_device *pdev,
+			struct ux500_msp *msp)
+{
+	dev_dbg(msp->dev, "%s: Enter (id = %d).\n", __func__, msp->id);
+
+	device_unregister(&msp->i2s_cont->dev);
+	devm_kfree(&pdev->dev, msp->i2s_cont);
+
+	iounmap(msp->registers);
+
+	devm_kfree(&pdev->dev, msp);
+}
+
+MODULE_LICENSE("GPLv2");
diff --git a/sound/soc/ux500/ux500_msp_i2s.h b/sound/soc/ux500/ux500_msp_i2s.h
new file mode 100644
index 0000000..7f71b4a
--- /dev/null
+++ b/sound/soc/ux500/ux500_msp_i2s.h
@@ -0,0 +1,553 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2012
+ *
+ * Author: Ola Lilja <ola.o.lilja@stericsson.com>,
+ *         for ST-Ericsson.
+ *
+ * License terms:
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ */
+
+
+#ifndef UX500_MSP_I2S_H
+#define UX500_MSP_I2S_H
+
+#include <linux/platform_device.h>
+
+#include <mach/board-mop500-msp.h>
+
+#define MSP_INPUT_FREQ_APB 48000000
+
+/*** Stereo mode. Used for APB data accesses as 16 bits accesses (mono),
+ *   32 bits accesses (stereo).
+ ***/
+enum msp_stereo_mode {
+	MSP_MONO,
+	MSP_STEREO
+};
+
+/* Direction (Transmit/Receive mode) */
+enum msp_direction {
+	MSP_TX = 1,
+	MSP_RX = 2
+};
+
+/* Transmit and receive configuration register */
+#define MSP_BIG_ENDIAN           0x00000000
+#define MSP_LITTLE_ENDIAN        0x00001000
+#define MSP_UNEXPECTED_FS_ABORT  0x00000000
+#define MSP_UNEXPECTED_FS_IGNORE 0x00008000
+#define MSP_NON_MODE_BIT_MASK    0x00009000
+
+/* Global configuration register */
+#define RX_ENABLE             0x00000001
+#define RX_FIFO_ENABLE        0x00000002
+#define RX_SYNC_SRG           0x00000010
+#define RX_CLK_POL_RISING     0x00000020
+#define RX_CLK_SEL_SRG        0x00000040
+#define TX_ENABLE             0x00000100
+#define TX_FIFO_ENABLE        0x00000200
+#define TX_SYNC_SRG_PROG      0x00001800
+#define TX_SYNC_SRG_AUTO      0x00001000
+#define TX_CLK_POL_RISING     0x00002000
+#define TX_CLK_SEL_SRG        0x00004000
+#define TX_EXTRA_DELAY_ENABLE 0x00008000
+#define SRG_ENABLE            0x00010000
+#define FRAME_GEN_ENABLE      0x00100000
+#define SRG_CLK_SEL_APB       0x00000000
+#define RX_FIFO_SYNC_HI       0x00000000
+#define TX_FIFO_SYNC_HI       0x00000000
+#define SPI_CLK_MODE_NORMAL   0x00000000
+
+#define MSP_FRAME_SIZE_AUTO -1
+
+#define MSP_DR		0x00
+#define MSP_GCR		0x04
+#define MSP_TCF		0x08
+#define MSP_RCF		0x0c
+#define MSP_SRG		0x10
+#define MSP_FLR		0x14
+#define MSP_DMACR	0x18
+
+#define MSP_IMSC	0x20
+#define MSP_RIS		0x24
+#define MSP_MIS		0x28
+#define MSP_ICR		0x2c
+#define MSP_MCR		0x30
+#define MSP_RCV		0x34
+#define MSP_RCM		0x38
+
+#define MSP_TCE0	0x40
+#define MSP_TCE1	0x44
+#define MSP_TCE2	0x48
+#define MSP_TCE3	0x4c
+
+#define MSP_RCE0	0x60
+#define MSP_RCE1	0x64
+#define MSP_RCE2	0x68
+#define MSP_RCE3	0x6c
+#define MSP_IODLY	0x70
+
+#define MSP_ITCR	0x80
+#define MSP_ITIP	0x84
+#define MSP_ITOP	0x88
+#define MSP_TSTDR	0x8c
+
+#define MSP_PID0	0xfe0
+#define MSP_PID1	0xfe4
+#define MSP_PID2	0xfe8
+#define MSP_PID3	0xfec
+
+#define MSP_CID0	0xff0
+#define MSP_CID1	0xff4
+#define MSP_CID2	0xff8
+#define MSP_CID3	0xffc
+
+/* Protocol dependant parameters list */
+#define RX_ENABLE_MASK		BIT(0)
+#define RX_FIFO_ENABLE_MASK	BIT(1)
+#define RX_FSYNC_MASK		BIT(2)
+#define DIRECT_COMPANDING_MASK	BIT(3)
+#define RX_SYNC_SEL_MASK	BIT(4)
+#define RX_CLK_POL_MASK		BIT(5)
+#define RX_CLK_SEL_MASK		BIT(6)
+#define LOOPBACK_MASK		BIT(7)
+#define TX_ENABLE_MASK		BIT(8)
+#define TX_FIFO_ENABLE_MASK	BIT(9)
+#define TX_FSYNC_MASK		BIT(10)
+#define TX_MSP_TDR_TSR		BIT(11)
+#define TX_SYNC_SEL_MASK	(BIT(12) | BIT(11))
+#define TX_CLK_POL_MASK		BIT(13)
+#define TX_CLK_SEL_MASK		BIT(14)
+#define TX_EXTRA_DELAY_MASK	BIT(15)
+#define SRG_ENABLE_MASK		BIT(16)
+#define SRG_CLK_POL_MASK	BIT(17)
+#define SRG_CLK_SEL_MASK	(BIT(19) | BIT(18))
+#define FRAME_GEN_EN_MASK	BIT(20)
+#define SPI_CLK_MODE_MASK	(BIT(22) | BIT(21))
+#define SPI_BURST_MODE_MASK	BIT(23)
+
+#define RXEN_SHIFT		0
+#define RFFEN_SHIFT		1
+#define RFSPOL_SHIFT		2
+#define DCM_SHIFT		3
+#define RFSSEL_SHIFT		4
+#define RCKPOL_SHIFT		5
+#define RCKSEL_SHIFT		6
+#define LBM_SHIFT		7
+#define TXEN_SHIFT		8
+#define TFFEN_SHIFT		9
+#define TFSPOL_SHIFT		10
+#define TFSSEL_SHIFT		11
+#define TCKPOL_SHIFT		13
+#define TCKSEL_SHIFT		14
+#define TXDDL_SHIFT		15
+#define SGEN_SHIFT		16
+#define SCKPOL_SHIFT		17
+#define SCKSEL_SHIFT		18
+#define FGEN_SHIFT		20
+#define SPICKM_SHIFT		21
+#define TBSWAP_SHIFT		28
+
+#define RCKPOL_MASK		BIT(0)
+#define TCKPOL_MASK		BIT(0)
+#define SPICKM_MASK		(BIT(1) | BIT(0))
+#define MSP_RX_CLKPOL_BIT(n)     ((n & RCKPOL_MASK) << RCKPOL_SHIFT)
+#define MSP_TX_CLKPOL_BIT(n)     ((n & TCKPOL_MASK) << TCKPOL_SHIFT)
+
+#define P1ELEN_SHIFT		0
+#define P1FLEN_SHIFT		3
+#define DTYP_SHIFT		10
+#define ENDN_SHIFT		12
+#define DDLY_SHIFT		13
+#define FSIG_SHIFT		15
+#define P2ELEN_SHIFT		16
+#define P2FLEN_SHIFT		19
+#define P2SM_SHIFT		26
+#define P2EN_SHIFT		27
+#define FSYNC_SHIFT		15
+
+#define P1ELEN_MASK		0x00000007
+#define P2ELEN_MASK		0x00070000
+#define P1FLEN_MASK		0x00000378
+#define P2FLEN_MASK		0x03780000
+#define DDLY_MASK		0x00003000
+#define DTYP_MASK		0x00000600
+#define P2SM_MASK		0x04000000
+#define P2EN_MASK		0x08000000
+#define ENDN_MASK		0x00001000
+#define TFSPOL_MASK		0x00000400
+#define TBSWAP_MASK		0x30000000
+#define COMPANDING_MODE_MASK	0x00000c00
+#define FSYNC_MASK		0x00008000
+
+#define MSP_P1_ELEM_LEN_BITS(n)		(n & P1ELEN_MASK)
+#define MSP_P2_ELEM_LEN_BITS(n)		(((n) << P2ELEN_SHIFT) & P2ELEN_MASK)
+#define MSP_P1_FRAME_LEN_BITS(n)	(((n) << P1FLEN_SHIFT) & P1FLEN_MASK)
+#define MSP_P2_FRAME_LEN_BITS(n)	(((n) << P2FLEN_SHIFT) & P2FLEN_MASK)
+#define MSP_DATA_DELAY_BITS(n)		(((n) << DDLY_SHIFT) & DDLY_MASK)
+#define MSP_DATA_TYPE_BITS(n)		(((n) << DTYP_SHIFT) & DTYP_MASK)
+#define MSP_P2_START_MODE_BIT(n)	((n << P2SM_SHIFT) & P2SM_MASK)
+#define MSP_P2_ENABLE_BIT(n)		((n << P2EN_SHIFT) & P2EN_MASK)
+#define MSP_SET_ENDIANNES_BIT(n)	((n << ENDN_SHIFT) & ENDN_MASK)
+#define MSP_FSYNC_POL(n)		((n << TFSPOL_SHIFT) & TFSPOL_MASK)
+#define MSP_DATA_WORD_SWAP(n)		((n << TBSWAP_SHIFT) & TBSWAP_MASK)
+#define MSP_SET_COMPANDING_MODE(n)	((n << DTYP_SHIFT) & \
+						COMPANDING_MODE_MASK)
+#define MSP_SET_FSYNC_IGNORE(n)		((n << FSYNC_SHIFT) & FSYNC_MASK)
+
+/* Flag register */
+#define RX_BUSY			BIT(0)
+#define RX_FIFO_EMPTY		BIT(1)
+#define RX_FIFO_FULL		BIT(2)
+#define TX_BUSY			BIT(3)
+#define TX_FIFO_EMPTY		BIT(4)
+#define TX_FIFO_FULL		BIT(5)
+
+#define RBUSY_SHIFT		0
+#define RFE_SHIFT		1
+#define RFU_SHIFT		2
+#define TBUSY_SHIFT		3
+#define TFE_SHIFT		4
+#define TFU_SHIFT		5
+
+/* Multichannel control register */
+#define RMCEN_SHIFT		0
+#define RMCSF_SHIFT		1
+#define RCMPM_SHIFT		3
+#define TMCEN_SHIFT		5
+#define TNCSF_SHIFT		6
+
+/* Sample rate generator register */
+#define SCKDIV_SHIFT		0
+#define FRWID_SHIFT		10
+#define FRPER_SHIFT		16
+
+#define SCK_DIV_MASK		0x0000003FF
+#define FRAME_WIDTH_BITS(n)	(((n) << FRWID_SHIFT)  & 0x0000FC00)
+#define FRAME_PERIOD_BITS(n)	(((n) << FRPER_SHIFT) & 0x1FFF0000)
+
+/* DMA controller register */
+#define RX_DMA_ENABLE		BIT(0)
+#define TX_DMA_ENABLE		BIT(1)
+
+#define RDMAE_SHIFT		0
+#define TDMAE_SHIFT		1
+
+/* Interrupt Register */
+#define RX_SERVICE_INT		BIT(0)
+#define RX_OVERRUN_ERROR_INT	BIT(1)
+#define RX_FSYNC_ERR_INT	BIT(2)
+#define RX_FSYNC_INT		BIT(3)
+#define TX_SERVICE_INT		BIT(4)
+#define TX_UNDERRUN_ERR_INT	BIT(5)
+#define TX_FSYNC_ERR_INT	BIT(6)
+#define TX_FSYNC_INT		BIT(7)
+#define ALL_INT			0x000000ff
+
+/* MSP test control register */
+#define MSP_ITCR_ITEN		BIT(0)
+#define MSP_ITCR_TESTFIFO	BIT(1)
+
+#define RMCEN_BIT   0
+#define RMCSF_BIT   1
+#define RCMPM_BIT   3
+#define TMCEN_BIT   5
+#define TNCSF_BIT   6
+
+/* Single or dual phase mode */
+enum msp_phase_mode {
+	MSP_SINGLE_PHASE,
+	MSP_DUAL_PHASE
+};
+
+/* Frame length */
+enum msp_frame_length {
+	MSP_FRAME_LEN_1 = 0,
+	MSP_FRAME_LEN_2 = 1,
+	MSP_FRAME_LEN_4 = 3,
+	MSP_FRAME_LEN_8 = 7,
+	MSP_FRAME_LEN_12 = 11,
+	MSP_FRAME_LEN_16 = 15,
+	MSP_FRAME_LEN_20 = 19,
+	MSP_FRAME_LEN_32 = 31,
+	MSP_FRAME_LEN_48 = 47,
+	MSP_FRAME_LEN_64 = 63
+};
+
+/* Element length */
+enum msp_elem_length {
+	MSP_ELEM_LEN_8 = 0,
+	MSP_ELEM_LEN_10 = 1,
+	MSP_ELEM_LEN_12 = 2,
+	MSP_ELEM_LEN_14 = 3,
+	MSP_ELEM_LEN_16 = 4,
+	MSP_ELEM_LEN_20 = 5,
+	MSP_ELEM_LEN_24 = 6,
+	MSP_ELEM_LEN_32 = 7
+};
+
+enum msp_data_xfer_width {
+	MSP_DATA_TRANSFER_WIDTH_BYTE,
+	MSP_DATA_TRANSFER_WIDTH_HALFWORD,
+	MSP_DATA_TRANSFER_WIDTH_WORD
+};
+
+enum msp_frame_sync {
+	MSP_FSYNC_UNIGNORE = 0,
+	MSP_FSYNC_IGNORE = 1,
+};
+
+enum msp_phase2_start_mode {
+	MSP_PHASE2_START_MODE_IMEDIATE,
+	MSP_PHASE2_START_MODE_FSYNC
+};
+
+enum msp_btf {
+	MSP_BTF_MS_BIT_FIRST = 0,
+	MSP_BTF_LS_BIT_FIRST = 1
+};
+
+enum msp_fsync_pol {
+	MSP_FSYNC_POL_ACT_HI = 0,
+	MSP_FSYNC_POL_ACT_LO = 1
+};
+
+/* Data delay (in bit clock cycles) */
+enum msp_delay {
+	MSP_DELAY_0 = 0,
+	MSP_DELAY_1 = 1,
+	MSP_DELAY_2 = 2,
+	MSP_DELAY_3 = 3
+};
+
+/* Configurations of clocks (transmit, receive or sample rate generator) */
+enum msp_edge {
+	MSP_FALLING_EDGE = 0,
+	MSP_RISING_EDGE = 1,
+};
+
+enum msp_hws {
+	MSP_SWAP_NONE = 0,
+	MSP_SWAP_BYTE_PER_WORD = 1,
+	MSP_SWAP_BYTE_PER_HALF_WORD = 2,
+	MSP_SWAP_HALF_WORD_PER_WORD = 3
+};
+
+enum msp_compress_mode {
+	MSP_COMPRESS_MODE_LINEAR = 0,
+	MSP_COMPRESS_MODE_MU_LAW = 2,
+	MSP_COMPRESS_MODE_A_LAW = 3
+};
+
+enum msp_spi_burst_mode {
+	MSP_SPI_BURST_MODE_DISABLE = 0,
+	MSP_SPI_BURST_MODE_ENABLE = 1
+};
+
+enum msp_expand_mode {
+	MSP_EXPAND_MODE_LINEAR = 0,
+	MSP_EXPAND_MODE_LINEAR_SIGNED = 1,
+	MSP_EXPAND_MODE_MU_LAW = 2,
+	MSP_EXPAND_MODE_A_LAW = 3
+};
+
+#define MSP_FRAME_PERIOD_IN_MONO_MODE 256
+#define MSP_FRAME_PERIOD_IN_STEREO_MODE 32
+#define MSP_FRAME_WIDTH_IN_STEREO_MODE 16
+
+enum msp_protocol {
+	MSP_I2S_PROTOCOL,
+	MSP_PCM_PROTOCOL,
+	MSP_PCM_COMPAND_PROTOCOL,
+	MSP_INVALID_PROTOCOL
+};
+
+/*
+ * No of registers to backup during
+ * suspend resume
+ */
+#define MAX_MSP_BACKUP_REGS 36
+
+enum enum_i2s_controller {
+	MSP_0_I2S_CONTROLLER = 0,
+	MSP_1_I2S_CONTROLLER,
+	MSP_2_I2S_CONTROLLER,
+	MSP_3_I2S_CONTROLLER,
+};
+
+enum i2s_direction_t {
+	MSP_DIR_TX = 0x01,
+	MSP_DIR_RX = 0x02,
+};
+
+enum msp_data_size {
+	MSP_DATA_BITS_DEFAULT = -1,
+	MSP_DATA_BITS_8 = 0x00,
+	MSP_DATA_BITS_10,
+	MSP_DATA_BITS_12,
+	MSP_DATA_BITS_14,
+	MSP_DATA_BITS_16,
+	MSP_DATA_BITS_20,
+	MSP_DATA_BITS_24,
+	MSP_DATA_BITS_32,
+};
+
+enum msp_state {
+	MSP_STATE_IDLE = 0,
+	MSP_STATE_CONFIGURED = 1,
+	MSP_STATE_RUNNING = 2,
+};
+
+enum msp_rx_comparison_enable_mode {
+	MSP_COMPARISON_DISABLED = 0,
+	MSP_COMPARISON_NONEQUAL_ENABLED = 2,
+	MSP_COMPARISON_EQUAL_ENABLED = 3
+};
+
+struct msp_multichannel_config {
+	bool rx_multichannel_enable;
+	bool tx_multichannel_enable;
+	enum msp_rx_comparison_enable_mode rx_comparison_enable_mode;
+	u8 padding;
+	u32 comparison_value;
+	u32 comparison_mask;
+	u32 rx_channel_0_enable;
+	u32 rx_channel_1_enable;
+	u32 rx_channel_2_enable;
+	u32 rx_channel_3_enable;
+	u32 tx_channel_0_enable;
+	u32 tx_channel_1_enable;
+	u32 tx_channel_2_enable;
+	u32 tx_channel_3_enable;
+};
+
+struct msp_protdesc {
+	u32 rx_phase_mode;
+	u32 tx_phase_mode;
+	u32 rx_phase2_start_mode;
+	u32 tx_phase2_start_mode;
+	u32 rx_byte_order;
+	u32 tx_byte_order;
+	u32 rx_frame_len_1;
+	u32 rx_frame_len_2;
+	u32 tx_frame_len_1;
+	u32 tx_frame_len_2;
+	u32 rx_elem_len_1;
+	u32 rx_elem_len_2;
+	u32 tx_elem_len_1;
+	u32 tx_elem_len_2;
+	u32 rx_data_delay;
+	u32 tx_data_delay;
+	u32 rx_clk_pol;
+	u32 tx_clk_pol;
+	u32 rx_fsync_pol;
+	u32 tx_fsync_pol;
+	u32 rx_half_word_swap;
+	u32 tx_half_word_swap;
+	u32 compression_mode;
+	u32 expansion_mode;
+	u32 frame_sync_ignore;
+	u32 frame_period;
+	u32 frame_width;
+	u32 clocks_per_frame;
+};
+
+struct i2s_message {
+	enum i2s_direction_t i2s_direction;
+	void *txdata;
+	void *rxdata;
+	size_t txbytes;
+	size_t rxbytes;
+	int dma_flag;
+	int tx_offset;
+	int rx_offset;
+	bool cyclic_dma;
+	dma_addr_t buf_addr;
+	size_t buf_len;
+	size_t period_len;
+};
+
+struct i2s_controller {
+	struct module *owner;
+	unsigned int id;
+	unsigned int class;
+	const struct i2s_algorithm *algo; /* the algorithm to access the bus */
+	void *data;
+	struct mutex bus_lock;
+	struct device dev; /* the controller device */
+	char name[48];
+};
+
+struct ux500_msp_config {
+	unsigned int f_inputclk;
+	unsigned int rx_clk_sel;
+	unsigned int tx_clk_sel;
+	unsigned int srg_clk_sel;
+	unsigned int rx_fsync_pol;
+	unsigned int tx_fsync_pol;
+	unsigned int rx_fsync_sel;
+	unsigned int tx_fsync_sel;
+	unsigned int rx_fifo_config;
+	unsigned int tx_fifo_config;
+	unsigned int spi_clk_mode;
+	unsigned int spi_burst_mode;
+	unsigned int loopback_enable;
+	unsigned int tx_data_enable;
+	unsigned int default_protdesc;
+	struct msp_protdesc protdesc;
+	int multichannel_configured;
+	struct msp_multichannel_config multichannel_config;
+	unsigned int direction;
+	unsigned int protocol;
+	unsigned int frame_freq;
+	unsigned int frame_size;
+	enum msp_data_size data_size;
+	unsigned int def_elem_len;
+	unsigned int iodelay;
+	void (*handler) (void *data);
+	void *tx_callback_data;
+	void *rx_callback_data;
+};
+
+struct ux500_msp {
+	enum enum_i2s_controller id;
+	void __iomem *registers;
+	struct device *dev;
+	struct i2s_controller *i2s_cont;
+	struct stedma40_chan_cfg *dma_cfg_rx;
+	struct stedma40_chan_cfg *dma_cfg_tx;
+	struct dma_chan *tx_pipeid;
+	struct dma_chan *rx_pipeid;
+	enum msp_state msp_state;
+	int (*transfer) (struct ux500_msp *msp, struct i2s_message *message);
+	int (*plat_init) (void);
+	int (*plat_exit) (void);
+	struct timer_list notify_timer;
+	int def_elem_len;
+	unsigned int dir_busy;
+	int loopback_enable;
+	u32 backup_regs[MAX_MSP_BACKUP_REGS];
+	unsigned int f_bitclk;
+};
+
+struct ux500_msp_dma_params {
+	unsigned int data_size;
+	struct stedma40_chan_cfg *dma_cfg;
+};
+
+int ux500_msp_i2s_init_msp(struct platform_device *pdev,
+			struct ux500_msp **msp_p,
+			struct msp_i2s_platform_data *platform_data);
+void ux500_msp_i2s_cleanup_msp(struct platform_device *pdev,
+			struct ux500_msp *msp);
+int ux500_msp_i2s_open(struct ux500_msp *msp, struct ux500_msp_config *config);
+int ux500_msp_i2s_close(struct ux500_msp *msp,
+			unsigned int dir);
+int ux500_msp_i2s_trigger(struct ux500_msp *msp, int cmd,
+			int direction);
+
+#endif
-- 
1.7.8.3
