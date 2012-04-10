From: Stephen Warren <swarren@wwwdotorg.org>
Subject: [PATCH V2 2/3] ASoC: tegra: add tegra30-i2s driver
Date: Tue, 10 Apr 2012 16:32:00 -0600
Message-ID: <1334097121-18897-2-git-send-email-swarren@wwwdotorg.org>
References: <1334097121-18897-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 101F3103FDC
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Apr 2012 00:32:14 +0200 (CEST)
In-Reply-To: <1334097121-18897-1-git-send-email-swarren@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

From: Stephen Warren <swarren@nvidia.com>

This provides an ASoC DAI interface for Tegra 30's I2S controller.

Includes a squashed bugfix from Sumit Bhattacharya <sumitb@nvidia.com>

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
v2:
* Remove use of tegra30_ahub_is_probed() API. Rely on the AHUB bus driver
  instantiating I2S.
* Added runtime PM support
* Add nvidia,ahub-cif-ids property to DT binding instead of calculating IDs
  based on register address.
---
 .../bindings/sound/nvidia,tegra30-i2s.txt          |   15 +
 sound/soc/tegra/tegra30_i2s.c                      |  536 ++++++++++++++++++++
 sound/soc/tegra/tegra30_i2s.h                      |  242 +++++++++
 3 files changed, 793 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra30-i2s.txt
 create mode 100644 sound/soc/tegra/tegra30_i2s.c
 create mode 100644 sound/soc/tegra/tegra30_i2s.h

diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra30-i2s.txt b/Documentation/devicetree/bindings/sound/nvidia,tegra30-i2s.txt
new file mode 100644
index 0000000..dfa6c03
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra30-i2s.txt
@@ -0,0 +1,15 @@
+NVIDIA Tegra30 I2S controller
+
+Required properties:
+- compatible : "nvidia,tegra30-i2s"
+- reg : Should contain I2S registers location and length
+- nvidia,ahub-cif-ids : The list of AHUB CIF IDs for this port, rx (playback)
+  first, tx (capture) second. See nvidia,tegra30-ahub.txt for values.
+
+Example:
+
+i2s@70002800 {
+	compatible = "nvidia,tegra30-i2s";
+	reg = <0x70080300 0x100>;
+	nvidia,ahub-cif-ids = <4 4>;
+};
diff --git a/sound/soc/tegra/tegra30_i2s.c b/sound/soc/tegra/tegra30_i2s.c
new file mode 100644
index 0000000..8596032
--- /dev/null
+++ b/sound/soc/tegra/tegra30_i2s.c
@@ -0,0 +1,536 @@
+/*
+ * tegra30_i2s.c - Tegra30 I2S driver
+ *
+ * Author: Stephen Warren <swarren@nvidia.com>
+ * Copyright (c) 2010-2012, NVIDIA CORPORATION.  All rights reserved.
+ *
+ * Based on code copyright/by:
+ *
+ * Copyright (c) 2009-2010, NVIDIA Corporation.
+ * Scott Peterson <speterson@nvidia.com>
+ *
+ * Copyright (C) 2010 Google, Inc.
+ * Iliyan Malchev <malchev@google.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+
+#include "tegra30_ahub.h"
+#include "tegra30_i2s.h"
+
+#define DRV_NAME "tegra30-i2s"
+
+static inline void tegra30_i2s_write(struct tegra30_i2s *i2s, u32 reg, u32 val)
+{
+	regmap_write(i2s->regmap, reg, val);
+}
+
+static inline u32 tegra30_i2s_read(struct tegra30_i2s *i2s, u32 reg)
+{
+	u32 val;
+	regmap_read(i2s->regmap, reg, &val);
+	return val;
+}
+
+static int tegra30_i2s_runtime_suspend(struct device *dev)
+{
+	struct tegra30_i2s *i2s = dev_get_drvdata(dev);
+
+	regcache_cache_only(i2s->regmap, true);
+
+	clk_disable(i2s->clk_i2s);
+
+	return 0;
+}
+
+static int tegra30_i2s_runtime_resume(struct device *dev)
+{
+	struct tegra30_i2s *i2s = dev_get_drvdata(dev);
+	int ret;
+
+	ret = clk_enable(i2s->clk_i2s);
+	if (ret) {
+		dev_err(dev, "clk_enable failed: %d\n", ret);
+		return ret;
+	}
+
+	regcache_cache_only(i2s->regmap, false);
+
+	return 0;
+}
+
+int tegra30_i2s_startup(struct snd_pcm_substream *substream,
+			struct snd_soc_dai *dai)
+{
+	struct tegra30_i2s *i2s = snd_soc_dai_get_drvdata(dai);
+	int ret;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		ret = tegra30_ahub_allocate_tx_fifo(&i2s->playback_fifo_cif,
+					&i2s->playback_dma_data.addr,
+					&i2s->playback_dma_data.req_sel);
+		i2s->playback_dma_data.wrap = 4;
+		i2s->playback_dma_data.width = 32;
+		tegra30_ahub_set_rx_cif_source(i2s->playback_i2s_cif,
+					       i2s->playback_fifo_cif);
+	} else {
+		ret = tegra30_ahub_allocate_rx_fifo(&i2s->capture_fifo_cif,
+					&i2s->capture_dma_data.addr,
+					&i2s->capture_dma_data.req_sel);
+		i2s->capture_dma_data.wrap = 4;
+		i2s->capture_dma_data.width = 32;
+		tegra30_ahub_set_rx_cif_source(i2s->capture_fifo_cif,
+					       i2s->capture_i2s_cif);
+	}
+
+	return ret;
+}
+
+void tegra30_i2s_shutdown(struct snd_pcm_substream *substream,
+			struct snd_soc_dai *dai)
+{
+	struct tegra30_i2s *i2s = snd_soc_dai_get_drvdata(dai);
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		tegra30_ahub_unset_rx_cif_source(i2s->playback_i2s_cif);
+		tegra30_ahub_free_tx_fifo(i2s->playback_fifo_cif);
+	} else {
+		tegra30_ahub_unset_rx_cif_source(i2s->capture_fifo_cif);
+		tegra30_ahub_free_rx_fifo(i2s->capture_fifo_cif);
+	}
+}
+
+static int tegra30_i2s_set_fmt(struct snd_soc_dai *dai,
+				unsigned int fmt)
+{
+	struct tegra30_i2s *i2s = snd_soc_dai_get_drvdata(dai);
+
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_NB_NF:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	i2s->reg_ctrl &= ~TEGRA30_I2S_CTRL_MASTER_ENABLE;
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBS_CFS:
+		i2s->reg_ctrl |= TEGRA30_I2S_CTRL_MASTER_ENABLE;
+		break;
+	case SND_SOC_DAIFMT_CBM_CFM:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	i2s->reg_ctrl &= ~(TEGRA30_I2S_CTRL_FRAME_FORMAT_MASK |
+			   TEGRA30_I2S_CTRL_LRCK_MASK);
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_DSP_A:
+		i2s->reg_ctrl |= TEGRA30_I2S_CTRL_FRAME_FORMAT_FSYNC;
+		i2s->reg_ctrl |= TEGRA30_I2S_CTRL_LRCK_L_LOW;
+		break;
+	case SND_SOC_DAIFMT_DSP_B:
+		i2s->reg_ctrl |= TEGRA30_I2S_CTRL_FRAME_FORMAT_FSYNC;
+		i2s->reg_ctrl |= TEGRA30_I2S_CTRL_LRCK_R_LOW;
+		break;
+	case SND_SOC_DAIFMT_I2S:
+		i2s->reg_ctrl |= TEGRA30_I2S_CTRL_FRAME_FORMAT_LRCK;
+		i2s->reg_ctrl |= TEGRA30_I2S_CTRL_LRCK_L_LOW;
+		break;
+	case SND_SOC_DAIFMT_RIGHT_J:
+		i2s->reg_ctrl |= TEGRA30_I2S_CTRL_FRAME_FORMAT_LRCK;
+		i2s->reg_ctrl |= TEGRA30_I2S_CTRL_LRCK_L_LOW;
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		i2s->reg_ctrl |= TEGRA30_I2S_CTRL_FRAME_FORMAT_LRCK;
+		i2s->reg_ctrl |= TEGRA30_I2S_CTRL_LRCK_L_LOW;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int tegra30_i2s_hw_params(struct snd_pcm_substream *substream,
+				 struct snd_pcm_hw_params *params,
+				 struct snd_soc_dai *dai)
+{
+	struct device *dev = substream->pcm->card->dev;
+	struct tegra30_i2s *i2s = snd_soc_dai_get_drvdata(dai);
+	u32 val;
+	int ret, sample_size, srate, i2sclock, bitcnt;
+
+	if (params_channels(params) != 2)
+		return -EINVAL;
+
+	i2s->reg_ctrl &= ~TEGRA30_I2S_CTRL_BIT_SIZE_MASK;
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+		i2s->reg_ctrl |= TEGRA30_I2S_CTRL_BIT_SIZE_16;
+		sample_size = 16;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	srate = params_rate(params);
+
+	/* Final "* 2" required by Tegra hardware */
+	i2sclock = srate * params_channels(params) * sample_size * 2;
+
+	bitcnt = (i2sclock / (2 * srate)) - 1;
+	if (bitcnt < 0 || bitcnt > TEGRA30_I2S_TIMING_CHANNEL_BIT_COUNT_MASK_US)
+		return -EINVAL;
+
+	ret = clk_set_rate(i2s->clk_i2s, i2sclock);
+	if (ret) {
+		dev_err(dev, "Can't set I2S clock rate: %d\n", ret);
+		return ret;
+	}
+
+	val = bitcnt << TEGRA30_I2S_TIMING_CHANNEL_BIT_COUNT_SHIFT;
+
+	if (i2sclock % (2 * srate))
+		val |= TEGRA30_I2S_TIMING_NON_SYM_ENABLE;
+
+	tegra30_i2s_write(i2s, TEGRA30_I2S_TIMING, val);
+
+	val = (0 << TEGRA30_AUDIOCIF_CTRL_FIFO_THRESHOLD_SHIFT) |
+	      (1 << TEGRA30_AUDIOCIF_CTRL_AUDIO_CHANNELS_SHIFT) |
+	      (1 << TEGRA30_AUDIOCIF_CTRL_CLIENT_CHANNELS_SHIFT) |
+	      TEGRA30_AUDIOCIF_CTRL_AUDIO_BITS_16 |
+	      TEGRA30_AUDIOCIF_CTRL_CLIENT_BITS_16;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		val |= TEGRA30_AUDIOCIF_CTRL_DIRECTION_RX;
+		tegra30_i2s_write(i2s, TEGRA30_I2S_CIF_RX_CTRL, val);
+	} else {
+		val |= TEGRA30_AUDIOCIF_CTRL_DIRECTION_TX;
+		tegra30_i2s_write(i2s, TEGRA30_I2S_CIF_TX_CTRL, val);
+	}
+
+	val = (1 << TEGRA30_I2S_OFFSET_RX_DATA_OFFSET_SHIFT) |
+	      (1 << TEGRA30_I2S_OFFSET_TX_DATA_OFFSET_SHIFT);
+	tegra30_i2s_write(i2s, TEGRA30_I2S_OFFSET, val);
+
+	return 0;
+}
+
+static void tegra30_i2s_start_playback(struct tegra30_i2s *i2s)
+{
+	tegra30_ahub_enable_tx_fifo(i2s->playback_fifo_cif);
+	i2s->reg_ctrl |= TEGRA30_I2S_CTRL_XFER_EN_TX;
+	tegra30_i2s_write(i2s, TEGRA30_I2S_CTRL, i2s->reg_ctrl);
+}
+
+static void tegra30_i2s_stop_playback(struct tegra30_i2s *i2s)
+{
+	tegra30_ahub_disable_tx_fifo(i2s->playback_fifo_cif);
+	i2s->reg_ctrl &= ~TEGRA30_I2S_CTRL_XFER_EN_TX;
+	tegra30_i2s_write(i2s, TEGRA30_I2S_CTRL, i2s->reg_ctrl);
+}
+
+static void tegra30_i2s_start_capture(struct tegra30_i2s *i2s)
+{
+	tegra30_ahub_enable_rx_fifo(i2s->capture_fifo_cif);
+	i2s->reg_ctrl |= TEGRA30_I2S_CTRL_XFER_EN_RX;
+	tegra30_i2s_write(i2s, TEGRA30_I2S_CTRL, i2s->reg_ctrl);
+}
+
+static void tegra30_i2s_stop_capture(struct tegra30_i2s *i2s)
+{
+	tegra30_ahub_disable_rx_fifo(i2s->capture_fifo_cif);
+	i2s->reg_ctrl &= ~TEGRA30_I2S_CTRL_XFER_EN_RX;
+	tegra30_i2s_write(i2s, TEGRA30_I2S_CTRL, i2s->reg_ctrl);
+}
+
+static int tegra30_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
+				struct snd_soc_dai *dai)
+{
+	struct tegra30_i2s *i2s = snd_soc_dai_get_drvdata(dai);
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+	case SNDRV_PCM_TRIGGER_RESUME:
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+			tegra30_i2s_start_playback(i2s);
+		else
+			tegra30_i2s_start_capture(i2s);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+			tegra30_i2s_stop_playback(i2s);
+		else
+			tegra30_i2s_stop_capture(i2s);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int tegra30_i2s_probe(struct snd_soc_dai *dai)
+{
+	struct tegra30_i2s *i2s = snd_soc_dai_get_drvdata(dai);
+
+	dai->capture_dma_data = &i2s->capture_dma_data;
+	dai->playback_dma_data = &i2s->playback_dma_data;
+
+	return 0;
+}
+
+static struct snd_soc_dai_ops tegra30_i2s_dai_ops = {
+	.startup	= tegra30_i2s_startup,
+	.shutdown	= tegra30_i2s_shutdown,
+	.set_fmt	= tegra30_i2s_set_fmt,
+	.hw_params	= tegra30_i2s_hw_params,
+	.trigger	= tegra30_i2s_trigger,
+};
+
+static const struct snd_soc_dai_driver tegra30_i2s_dai_template = {
+	.probe = tegra30_i2s_probe,
+	.playback = {
+		.channels_min = 2,
+		.channels_max = 2,
+		.rates = SNDRV_PCM_RATE_8000_96000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+	},
+	.capture = {
+		.channels_min = 2,
+		.channels_max = 2,
+		.rates = SNDRV_PCM_RATE_8000_96000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+	},
+	.ops = &tegra30_i2s_dai_ops,
+	.symmetric_rates = 1,
+};
+
+static bool tegra30_i2s_wr_rd_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case TEGRA30_I2S_CTRL:
+	case TEGRA30_I2S_TIMING:
+	case TEGRA30_I2S_OFFSET:
+	case TEGRA30_I2S_CH_CTRL:
+	case TEGRA30_I2S_SLOT_CTRL:
+	case TEGRA30_I2S_CIF_RX_CTRL:
+	case TEGRA30_I2S_CIF_TX_CTRL:
+	case TEGRA30_I2S_FLOWCTL:
+	case TEGRA30_I2S_TX_STEP:
+	case TEGRA30_I2S_FLOW_STATUS:
+	case TEGRA30_I2S_FLOW_TOTAL:
+	case TEGRA30_I2S_FLOW_OVER:
+	case TEGRA30_I2S_FLOW_UNDER:
+	case TEGRA30_I2S_LCOEF_1_4_0:
+	case TEGRA30_I2S_LCOEF_1_4_1:
+	case TEGRA30_I2S_LCOEF_1_4_2:
+	case TEGRA30_I2S_LCOEF_1_4_3:
+	case TEGRA30_I2S_LCOEF_1_4_4:
+	case TEGRA30_I2S_LCOEF_1_4_5:
+	case TEGRA30_I2S_LCOEF_2_4_0:
+	case TEGRA30_I2S_LCOEF_2_4_1:
+	case TEGRA30_I2S_LCOEF_2_4_2:
+		return true;
+	default:
+		return false;
+	};
+}
+
+static bool tegra30_i2s_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case TEGRA30_I2S_FLOW_STATUS:
+	case TEGRA30_I2S_FLOW_TOTAL:
+	case TEGRA30_I2S_FLOW_OVER:
+	case TEGRA30_I2S_FLOW_UNDER:
+		return true;
+	default:
+		return false;
+	};
+}
+
+static const struct regmap_config tegra30_i2s_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = TEGRA30_I2S_LCOEF_2_4_2,
+	.writeable_reg = tegra30_i2s_wr_rd_reg,
+	.readable_reg = tegra30_i2s_wr_rd_reg,
+	.volatile_reg = tegra30_i2s_volatile_reg,
+	.cache_type = REGCACHE_RBTREE,
+};
+
+static __devinit int tegra30_i2s_platform_probe(struct platform_device *pdev)
+{
+	struct tegra30_i2s *i2s;
+	u32 cif_ids[2];
+	struct resource *mem, *memregion;
+	void __iomem *regs;
+	int ret;
+
+	i2s = devm_kzalloc(&pdev->dev, sizeof(struct tegra30_i2s), GFP_KERNEL);
+	if (!i2s) {
+		dev_err(&pdev->dev, "Can't allocate tegra30_i2s\n");
+		ret = -ENOMEM;
+		goto err;
+	}
+	dev_set_drvdata(&pdev->dev, i2s);
+
+	i2s->dai = tegra30_i2s_dai_template;
+	i2s->dai.name = dev_name(&pdev->dev);
+
+	ret = of_property_read_u32_array(pdev->dev.of_node,
+					 "nvidia,ahub-cif-ids", cif_ids,
+					 ARRAY_SIZE(cif_ids));
+	if (ret < 0)
+		goto err;
+
+	i2s->playback_i2s_cif = cif_ids[0];
+	i2s->capture_i2s_cif = cif_ids[1];
+
+	i2s->clk_i2s = clk_get(&pdev->dev, NULL);
+	if (IS_ERR(i2s->clk_i2s)) {
+		dev_err(&pdev->dev, "Can't retrieve i2s clock\n");
+		ret = PTR_ERR(i2s->clk_i2s);
+		goto err;
+	}
+
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!mem) {
+		dev_err(&pdev->dev, "No memory resource\n");
+		ret = -ENODEV;
+		goto err_clk_put;
+	}
+
+	memregion = devm_request_mem_region(&pdev->dev, mem->start,
+					    resource_size(mem), DRV_NAME);
+	if (!memregion) {
+		dev_err(&pdev->dev, "Memory region already claimed\n");
+		ret = -EBUSY;
+		goto err_clk_put;
+	}
+
+	regs = devm_ioremap(&pdev->dev, mem->start, resource_size(mem));
+	if (!regs) {
+		dev_err(&pdev->dev, "ioremap failed\n");
+		ret = -ENOMEM;
+		goto err_clk_put;
+	}
+
+	i2s->regmap = devm_regmap_init_mmio(&pdev->dev, regs,
+					    &tegra30_i2s_regmap_config);
+	if (IS_ERR(i2s->regmap)) {
+		dev_err(&pdev->dev, "regmap init failed\n");
+		ret = PTR_ERR(i2s->regmap);
+		goto err_clk_put;
+	}
+	regcache_cache_only(i2s->regmap, true);
+
+	pm_runtime_enable(&pdev->dev);
+	if (!pm_runtime_enabled(&pdev->dev)) {
+		ret = tegra30_i2s_runtime_resume(&pdev->dev);
+		if (ret)
+			goto err_pm_disable;
+	}
+
+	ret = snd_soc_register_dai(&pdev->dev, &i2s->dai);
+	if (ret) {
+		dev_err(&pdev->dev, "Could not register DAI: %d\n", ret);
+		ret = -ENOMEM;
+		goto err_suspend;
+	}
+
+	ret = tegra_pcm_platform_register(&pdev->dev);
+	if (ret) {
+		dev_err(&pdev->dev, "Could not register PCM: %d\n", ret);
+		goto err_unregister_dai;
+	}
+
+	return 0;
+
+err_unregister_dai:
+	snd_soc_unregister_dai(&pdev->dev);
+err_suspend:
+	if (!pm_runtime_status_suspended(&pdev->dev))
+		tegra30_i2s_runtime_suspend(&pdev->dev);
+err_pm_disable:
+	pm_runtime_disable(&pdev->dev);
+err_clk_put:
+	clk_put(i2s->clk_i2s);
+err:
+	return ret;
+}
+
+static int __devexit tegra30_i2s_platform_remove(struct platform_device *pdev)
+{
+	struct tegra30_i2s *i2s = dev_get_drvdata(&pdev->dev);
+
+	pm_runtime_disable(&pdev->dev);
+	if (!pm_runtime_status_suspended(&pdev->dev))
+		tegra30_i2s_runtime_suspend(&pdev->dev);
+
+	tegra_pcm_platform_unregister(&pdev->dev);
+	snd_soc_unregister_dai(&pdev->dev);
+
+	clk_put(i2s->clk_i2s);
+
+	return 0;
+}
+
+static const struct of_device_id tegra30_i2s_of_match[] __devinitconst = {
+	{ .compatible = "nvidia,tegra30-i2s", },
+	{},
+};
+
+static const struct dev_pm_ops tegra30_i2s_pm_ops __devinitconst = {
+	SET_RUNTIME_PM_OPS(tegra30_i2s_runtime_suspend,
+			   tegra30_i2s_runtime_resume, NULL)
+};
+
+static struct platform_driver tegra30_i2s_driver = {
+	.driver = {
+		.name = DRV_NAME,
+		.owner = THIS_MODULE,
+		.of_match_table = tegra30_i2s_of_match,
+		.pm = &tegra30_i2s_pm_ops,
+	},
+	.probe = tegra30_i2s_platform_probe,
+	.remove = __devexit_p(tegra30_i2s_platform_remove),
+};
+module_platform_driver(tegra30_i2s_driver);
+
+MODULE_AUTHOR("Stephen Warren <swarren@nvidia.com>");
+MODULE_DESCRIPTION("Tegra30 I2S ASoC driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:" DRV_NAME);
+MODULE_DEVICE_TABLE(of, tegra30_i2s_of_match);
diff --git a/sound/soc/tegra/tegra30_i2s.h b/sound/soc/tegra/tegra30_i2s.h
new file mode 100644
index 0000000..91adf29
--- /dev/null
+++ b/sound/soc/tegra/tegra30_i2s.h
@@ -0,0 +1,242 @@
+/*
+ * tegra30_i2s.h - Definitions for Tegra30 I2S driver
+ *
+ * Copyright (c) 2011,2012, NVIDIA CORPORATION.  All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef __TEGRA30_I2S_H__
+#define __TEGRA30_I2S_H__
+
+#include "tegra_pcm.h"
+
+/* Register offsets from TEGRA30_I2S*_BASE */
+
+#define TEGRA30_I2S_CTRL				0x0
+#define TEGRA30_I2S_TIMING				0x4
+#define TEGRA30_I2S_OFFSET				0x08
+#define TEGRA30_I2S_CH_CTRL				0x0c
+#define TEGRA30_I2S_SLOT_CTRL				0x10
+#define TEGRA30_I2S_CIF_RX_CTRL				0x14
+#define TEGRA30_I2S_CIF_TX_CTRL				0x18
+#define TEGRA30_I2S_FLOWCTL				0x1c
+#define TEGRA30_I2S_TX_STEP				0x20
+#define TEGRA30_I2S_FLOW_STATUS				0x24
+#define TEGRA30_I2S_FLOW_TOTAL				0x28
+#define TEGRA30_I2S_FLOW_OVER				0x2c
+#define TEGRA30_I2S_FLOW_UNDER				0x30
+#define TEGRA30_I2S_LCOEF_1_4_0				0x34
+#define TEGRA30_I2S_LCOEF_1_4_1				0x38
+#define TEGRA30_I2S_LCOEF_1_4_2				0x3c
+#define TEGRA30_I2S_LCOEF_1_4_3				0x40
+#define TEGRA30_I2S_LCOEF_1_4_4				0x44
+#define TEGRA30_I2S_LCOEF_1_4_5				0x48
+#define TEGRA30_I2S_LCOEF_2_4_0				0x4c
+#define TEGRA30_I2S_LCOEF_2_4_1				0x50
+#define TEGRA30_I2S_LCOEF_2_4_2				0x54
+
+/* Fields in TEGRA30_I2S_CTRL */
+
+#define TEGRA30_I2S_CTRL_XFER_EN_TX			(1 << 31)
+#define TEGRA30_I2S_CTRL_XFER_EN_RX			(1 << 30)
+#define TEGRA30_I2S_CTRL_CG_EN				(1 << 29)
+#define TEGRA30_I2S_CTRL_SOFT_RESET			(1 << 28)
+#define TEGRA30_I2S_CTRL_TX_FLOWCTL_EN			(1 << 27)
+
+#define TEGRA30_I2S_CTRL_OBS_SEL_SHIFT			24
+#define TEGRA30_I2S_CTRL_OBS_SEL_MASK			(7 << TEGRA30_I2S_CTRL_OBS_SEL_SHIFT)
+
+#define TEGRA30_I2S_FRAME_FORMAT_LRCK			0
+#define TEGRA30_I2S_FRAME_FORMAT_FSYNC			1
+
+#define TEGRA30_I2S_CTRL_FRAME_FORMAT_SHIFT		12
+#define TEGRA30_I2S_CTRL_FRAME_FORMAT_MASK		(7                              << TEGRA30_I2S_CTRL_FRAME_FORMAT_SHIFT)
+#define TEGRA30_I2S_CTRL_FRAME_FORMAT_LRCK		(TEGRA30_I2S_FRAME_FORMAT_LRCK  << TEGRA30_I2S_CTRL_FRAME_FORMAT_SHIFT)
+#define TEGRA30_I2S_CTRL_FRAME_FORMAT_FSYNC		(TEGRA30_I2S_FRAME_FORMAT_FSYNC << TEGRA30_I2S_CTRL_FRAME_FORMAT_SHIFT)
+
+#define TEGRA30_I2S_CTRL_MASTER_ENABLE			(1 << 10)
+
+#define TEGRA30_I2S_LRCK_LEFT_LOW			0
+#define TEGRA30_I2S_LRCK_RIGHT_LOW			1
+
+#define TEGRA30_I2S_CTRL_LRCK_SHIFT			9
+#define TEGRA30_I2S_CTRL_LRCK_MASK			(1                          << TEGRA30_I2S_CTRL_LRCK_SHIFT)
+#define TEGRA30_I2S_CTRL_LRCK_L_LOW			(TEGRA30_I2S_LRCK_LEFT_LOW  << TEGRA30_I2S_CTRL_LRCK_SHIFT)
+#define TEGRA30_I2S_CTRL_LRCK_R_LOW			(TEGRA30_I2S_LRCK_RIGHT_LOW << TEGRA30_I2S_CTRL_LRCK_SHIFT)
+
+#define TEGRA30_I2S_CTRL_LPBK_ENABLE			(1 << 8)
+
+#define TEGRA30_I2S_BIT_CODE_LINEAR			0
+#define TEGRA30_I2S_BIT_CODE_ULAW			1
+#define TEGRA30_I2S_BIT_CODE_ALAW			2
+
+#define TEGRA30_I2S_CTRL_BIT_CODE_SHIFT			4
+#define TEGRA30_I2S_CTRL_BIT_CODE_MASK			(3                           << TEGRA30_I2S_CTRL_BIT_CODE_SHIFT)
+#define TEGRA30_I2S_CTRL_BIT_CODE_LINEAR		(TEGRA30_I2S_BIT_CODE_LINEAR << TEGRA30_I2S_CTRL_BIT_CODE_SHIFT)
+#define TEGRA30_I2S_CTRL_BIT_CODE_ULAW			(TEGRA30_I2S_BIT_CODE_ULAW   << TEGRA30_I2S_CTRL_BIT_CODE_SHIFT)
+#define TEGRA30_I2S_CTRL_BIT_CODE_ALAW			(TEGRA30_I2S_BIT_CODE_ALAW   << TEGRA30_I2S_CTRL_BIT_CODE_SHIFT)
+
+#define TEGRA30_I2S_BITS_8				1
+#define TEGRA30_I2S_BITS_12				2
+#define TEGRA30_I2S_BITS_16				3
+#define TEGRA30_I2S_BITS_20				4
+#define TEGRA30_I2S_BITS_24				5
+#define TEGRA30_I2S_BITS_28				6
+#define TEGRA30_I2S_BITS_32				7
+
+/* Sample container size; see {RX,TX}_MASK field in CH_CTRL below */
+#define TEGRA30_I2S_CTRL_BIT_SIZE_SHIFT			0
+#define TEGRA30_I2S_CTRL_BIT_SIZE_MASK			(7                   << TEGRA30_I2S_CTRL_BIT_SIZE_SHIFT)
+#define TEGRA30_I2S_CTRL_BIT_SIZE_8			(TEGRA30_I2S_BITS_8  << TEGRA30_I2S_CTRL_BIT_SIZE_SHIFT)
+#define TEGRA30_I2S_CTRL_BIT_SIZE_12			(TEGRA30_I2S_BITS_12 << TEGRA30_I2S_CTRL_BIT_SIZE_SHIFT)
+#define TEGRA30_I2S_CTRL_BIT_SIZE_16			(TEGRA30_I2S_BITS_16 << TEGRA30_I2S_CTRL_BIT_SIZE_SHIFT)
+#define TEGRA30_I2S_CTRL_BIT_SIZE_20			(TEGRA30_I2S_BITS_20 << TEGRA30_I2S_CTRL_BIT_SIZE_SHIFT)
+#define TEGRA30_I2S_CTRL_BIT_SIZE_24			(TEGRA30_I2S_BITS_24 << TEGRA30_I2S_CTRL_BIT_SIZE_SHIFT)
+#define TEGRA30_I2S_CTRL_BIT_SIZE_28			(TEGRA30_I2S_BITS_28 << TEGRA30_I2S_CTRL_BIT_SIZE_SHIFT)
+#define TEGRA30_I2S_CTRL_BIT_SIZE_32			(TEGRA30_I2S_BITS_32 << TEGRA30_I2S_CTRL_BIT_SIZE_SHIFT)
+
+/* Fields in TEGRA30_I2S_TIMING */
+
+#define TEGRA30_I2S_TIMING_NON_SYM_ENABLE		(1 << 12)
+#define TEGRA30_I2S_TIMING_CHANNEL_BIT_COUNT_SHIFT	0
+#define TEGRA30_I2S_TIMING_CHANNEL_BIT_COUNT_MASK_US	0x7fff
+#define TEGRA30_I2S_TIMING_CHANNEL_BIT_COUNT_MASK	(TEGRA30_I2S_TIMING_CHANNEL_BIT_COUNT_MASK_US << TEGRA30_I2S_TIMING_CHANNEL_BIT_COUNT_SHIFT)
+
+/* Fields in TEGRA30_I2S_OFFSET */
+
+#define TEGRA30_I2S_OFFSET_RX_DATA_OFFSET_SHIFT		16
+#define TEGRA30_I2S_OFFSET_RX_DATA_OFFSET_MASK_US	0x7ff
+#define TEGRA30_I2S_OFFSET_RX_DATA_OFFSET_MASK		(TEGRA30_I2S_OFFSET_RX_DATA_OFFSET_MASK_US << TEGRA30_I2S_OFFSET_RX_DATA_OFFSET_SHIFT)
+#define TEGRA30_I2S_OFFSET_TX_DATA_OFFSET_SHIFT		0
+#define TEGRA30_I2S_OFFSET_TX_DATA_OFFSET_MASK_US	0x7ff
+#define TEGRA30_I2S_OFFSET_TX_DATA_OFFSET_MASK		(TEGRA30_I2S_OFFSET_TX_DATA_OFFSET_MASK_US << TEGRA30_I2S_OFFSET_TX_DATA_OFFSET_SHIFT)
+
+/* Fields in TEGRA30_I2S_CH_CTRL */
+
+/* (FSYNC width - 1) in bit clocks */
+#define TEGRA30_I2S_CH_CTRL_FSYNC_WIDTH_SHIFT		24
+#define TEGRA30_I2S_CH_CTRL_FSYNC_WIDTH_MASK_US		0xff
+#define TEGRA30_I2S_CH_CTRL_FSYNC_WIDTH_MASK		(TEGRA30_I2S_CH_CTRL_FSYNC_WIDTH_MASK_US << TEGRA30_I2S_CH_CTRL_FSYNC_WIDTH_SHIFT)
+
+#define TEGRA30_I2S_HIGHZ_NO				0
+#define TEGRA30_I2S_HIGHZ_YES				1
+#define TEGRA30_I2S_HIGHZ_ON_HALF_BIT_CLK		2
+
+#define TEGRA30_I2S_CH_CTRL_HIGHZ_CTRL_SHIFT		12
+#define TEGRA30_I2S_CH_CTRL_HIGHZ_CTRL_MASK		(3                                 << TEGRA30_I2S_CH_CTRL_HIGHZ_CTRL_SHIFT)
+#define TEGRA30_I2S_CH_CTRL_HIGHZ_CTRL_NO		(TEGRA30_I2S_HIGHZ_NO              << TEGRA30_I2S_CH_CTRL_HIGHZ_CTRL_SHIFT)
+#define TEGRA30_I2S_CH_CTRL_HIGHZ_CTRL_YES		(TEGRA30_I2S_HIGHZ_YES             << TEGRA30_I2S_CH_CTRL_HIGHZ_CTRL_SHIFT)
+#define TEGRA30_I2S_CH_CTRL_HIGHZ_CTRL_ON_HALF_BIT_CLK	(TEGRA30_I2S_HIGHZ_ON_HALF_BIT_CLK << TEGRA30_I2S_CH_CTRL_HIGHZ_CTRL_SHIFT)
+
+#define TEGRA30_I2S_MSB_FIRST				0
+#define TEGRA30_I2S_LSB_FIRST				1
+
+#define TEGRA30_I2S_CH_CTRL_RX_BIT_ORDER_SHIFT		10
+#define TEGRA30_I2S_CH_CTRL_RX_BIT_ORDER_MASK		(1                     << TEGRA30_I2S_CH_CTRL_RX_BIT_ORDER_SHIFT)
+#define TEGRA30_I2S_CH_CTRL_RX_BIT_ORDER_MSB_FIRST	(TEGRA30_I2S_MSB_FIRST << TEGRA30_I2S_CH_CTRL_RX_BIT_ORDER_SHIFT)
+#define TEGRA30_I2S_CH_CTRL_RX_BIT_ORDER_LSB_FIRST	(TEGRA30_I2S_LSB_FIRST << TEGRA30_I2S_CH_CTRL_RX_BIT_ORDER_SHIFT)
+#define TEGRA30_I2S_CH_CTRL_TX_BIT_ORDER_SHIFT		9
+#define TEGRA30_I2S_CH_CTRL_TX_BIT_ORDER_MASK		(1                     << TEGRA30_I2S_CH_CTRL_TX_BIT_ORDER_SHIFT)
+#define TEGRA30_I2S_CH_CTRL_TX_BIT_ORDER_MSB_FIRST	(TEGRA30_I2S_MSB_FIRST << TEGRA30_I2S_CH_CTRL_TX_BIT_ORDER_SHIFT)
+#define TEGRA30_I2S_CH_CTRL_TX_BIT_ORDER_LSB_FIRST	(TEGRA30_I2S_LSB_FIRST << TEGRA30_I2S_CH_CTRL_TX_BIT_ORDER_SHIFT)
+
+#define TEGRA30_I2S_POS_EDGE				0
+#define TEGRA30_I2S_NEG_EDGE				1
+
+#define TEGRA30_I2S_CH_CTRL_EGDE_CTRL_SHIFT		8
+#define TEGRA30_I2S_CH_CTRL_EGDE_CTRL_MASK		(1                    << TEGRA30_I2S_CH_CTRL_EGDE_CTRL_SHIFT)
+#define TEGRA30_I2S_CH_CTRL_EGDE_CTRL_POS_EDGE		(TEGRA30_I2S_POS_EDGE << TEGRA30_I2S_CH_CTRL_EGDE_CTRL_SHIFT)
+#define TEGRA30_I2S_CH_CTRL_EGDE_CTRL_NEG_EDGE		(TEGRA30_I2S_NEG_EDGE << TEGRA30_I2S_CH_CTRL_EGDE_CTRL_SHIFT)
+
+/* Sample size is # bits from BIT_SIZE minus this field */
+#define TEGRA30_I2S_CH_CTRL_RX_MASK_BITS_SHIFT		4
+#define TEGRA30_I2S_CH_CTRL_RX_MASK_BITS_MASK_US	7
+#define TEGRA30_I2S_CH_CTRL_RX_MASK_BITS_MASK		(TEGRA30_I2S_CH_CTRL_RX_MASK_BITS_MASK_US << TEGRA30_I2S_CH_CTRL_RX_MASK_BITS_SHIFT)
+
+#define TEGRA30_I2S_CH_CTRL_TX_MASK_BITS_SHIFT		0
+#define TEGRA30_I2S_CH_CTRL_TX_MASK_BITS_MASK_US	7
+#define TEGRA30_I2S_CH_CTRL_TX_MASK_BITS_MASK		(TEGRA30_I2S_CH_CTRL_TX_MASK_BITS_MASK_US << TEGRA30_I2S_CH_CTRL_TX_MASK_BITS_SHIFT)
+
+/* Fields in TEGRA30_I2S_SLOT_CTRL */
+
+/* Number of slots in frame, minus 1 */
+#define TEGRA30_I2S_SLOT_CTRL_TOTAL_SLOTS_SHIFT		16
+#define TEGRA30_I2S_SLOT_CTRL_TOTAL_SLOTS_MASK_US	7
+#define TEGRA30_I2S_SLOT_CTRL_TOTAL_SLOTS_MASK		(TEGRA30_I2S_SLOT_CTRL_TOTAL_SLOT_MASK_US << TEGRA30_I2S_SLOT_CTRL_TOTAL_SLOT_SHIFT)
+
+/* TDM mode slot enable bitmask */
+#define TEGRA30_I2S_SLOT_CTRL_RX_SLOT_ENABLES_SHIFT	8
+#define TEGRA30_I2S_SLOT_CTRL_RX_SLOT_ENABLES_MASK	(0xff << TEGRA30_I2S_SLOT_CTRL_RX_SLOT_ENABLES_SHIFT)
+
+#define TEGRA30_I2S_SLOT_CTRL_TX_SLOT_ENABLES_SHIFT	0
+#define TEGRA30_I2S_SLOT_CTRL_TX_SLOT_ENABLES_MASK	(0xff << TEGRA30_I2S_SLOT_CTRL_TX_SLOT_ENABLES_SHIFT)
+
+/* Fields in TEGRA30_I2S_CIF_RX_CTRL */
+/* Uses field from TEGRA30_AUDIOCIF_CTRL_* in tegra30_ahub.h */
+
+/* Fields in TEGRA30_I2S_CIF_TX_CTRL */
+/* Uses field from TEGRA30_AUDIOCIF_CTRL_* in tegra30_ahub.h */
+
+/* Fields in TEGRA30_I2S_FLOWCTL */
+
+#define TEGRA30_I2S_FILTER_LINEAR			0
+#define TEGRA30_I2S_FILTER_QUAD				1
+
+#define TEGRA30_I2S_FLOWCTL_FILTER_SHIFT		31
+#define TEGRA30_I2S_FLOWCTL_FILTER_MASK			(1                         << TEGRA30_I2S_FLOWCTL_FILTER_SHIFT)
+#define TEGRA30_I2S_FLOWCTL_FILTER_LINEAR		(TEGRA30_I2S_FILTER_LINEAR << TEGRA30_I2S_FLOWCTL_FILTER_SHIFT)
+#define TEGRA30_I2S_FLOWCTL_FILTER_QUAD			(TEGRA30_I2S_FILTER_QUAD   << TEGRA30_I2S_FLOWCTL_FILTER_SHIFT)
+
+/* Fields in TEGRA30_I2S_TX_STEP */
+
+#define TEGRA30_I2S_TX_STEP_SHIFT			0
+#define TEGRA30_I2S_TX_STEP_MASK_US			0xffff
+#define TEGRA30_I2S_TX_STEP_MASK			(TEGRA30_I2S_TX_STEP_MASK_US << TEGRA30_I2S_TX_STEP_SHIFT)
+
+/* Fields in TEGRA30_I2S_FLOW_STATUS */
+
+#define TEGRA30_I2S_FLOW_STATUS_UNDERFLOW		(1 << 31)
+#define TEGRA30_I2S_FLOW_STATUS_OVERFLOW		(1 << 30)
+#define TEGRA30_I2S_FLOW_STATUS_MONITOR_INT_EN		(1 << 4)
+#define TEGRA30_I2S_FLOW_STATUS_COUNTER_CLR		(1 << 3)
+#define TEGRA30_I2S_FLOW_STATUS_MONITOR_CLR		(1 << 2)
+#define TEGRA30_I2S_FLOW_STATUS_COUNTER_EN		(1 << 1)
+#define TEGRA30_I2S_FLOW_STATUS_MONITOR_EN		(1 << 0)
+
+/*
+ * There are no fields in TEGRA30_I2S_FLOW_TOTAL, TEGRA30_I2S_FLOW_OVER,
+ * TEGRA30_I2S_FLOW_UNDER; they are counters taking the whole register.
+ */
+
+/* Fields in TEGRA30_I2S_LCOEF_* */
+
+#define TEGRA30_I2S_LCOEF_COEF_SHIFT			0
+#define TEGRA30_I2S_LCOEF_COEF_MASK_US			0xffff
+#define TEGRA30_I2S_LCOEF_COEF_MASK			(TEGRA30_I2S_LCOEF_COEF_MASK_US << TEGRA30_I2S_LCOEF_COEF_SHIFT)
+
+struct tegra30_i2s {
+	struct snd_soc_dai_driver dai;
+	int cif_id;
+	struct clk *clk_i2s;
+	enum tegra30_ahub_txcif capture_i2s_cif;
+	enum tegra30_ahub_rxcif capture_fifo_cif;
+	struct tegra_pcm_dma_params capture_dma_data;
+	enum tegra30_ahub_rxcif playback_i2s_cif;
+	enum tegra30_ahub_txcif playback_fifo_cif;
+	struct tegra_pcm_dma_params playback_dma_data;
+	struct regmap *regmap;
+	u32 reg_ctrl;
+};
+
+#endif
-- 
1.7.0.4
