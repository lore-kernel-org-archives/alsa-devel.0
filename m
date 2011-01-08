From: Stephen Warren <swarren@nvidia.com>
Subject: [PATCH 4/7] ASoC: tegra: Add tegra-i2s driver
Date: Fri,  7 Jan 2011 22:36:14 -0700
Message-ID: <1294464977-25814-5-git-send-email-swarren@nvidia.com>
References: <1294464977-25814-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 18B25103856
	for <alsa-devel@alsa-project.org>; Sat,  8 Jan 2011 06:36:40 +0100 (CET)
In-Reply-To: <1294464977-25814-1-git-send-email-swarren@nvidia.com>
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
Cc: Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

This provides an ASoC DAI interface for Tegra's I2S controller.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 sound/soc/tegra/tegra_i2s.c |  502 +++++++++++++++++++++++++++++++++++++++++++
 sound/soc/tegra/tegra_i2s.h |  165 ++++++++++++++
 2 files changed, 667 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/tegra/tegra_i2s.c
 create mode 100644 sound/soc/tegra/tegra_i2s.h

diff --git a/sound/soc/tegra/tegra_i2s.c b/sound/soc/tegra/tegra_i2s.c
new file mode 100644
index 0000000..9b7a22a
--- /dev/null
+++ b/sound/soc/tegra/tegra_i2s.c
@@ -0,0 +1,502 @@
+/*
+ * tegra_i2s.c - Tegra I2S driver
+ *
+ * Author: Stephen Warren <swarren@nvidia.com>
+ * Copyright (C) 2010 - NVIDIA, Inc.
+ *
+ * Based on code copyright/by:
+ *
+ * Copyright (c) 2009-2010, NVIDIA Corporation.
+ * Scott Peterson <speterson@nvidia.com>
+ *
+ * Copyright (C) 2010 Google, Inc.
+ * Iliyan Malchev <malchev@google.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#include <linux/clk.h>
+#include <linux/module.h>
+#include <linux/debugfs.h>
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/seq_file.h>
+#include <linux/slab.h>
+#include <linux/io.h>
+#include <mach/iomap.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+
+#include "tegra_das.h"
+#include "tegra_i2s.h"
+
+#define DRV_NAME "tegra-i2s"
+
+static inline void tegra_i2s_write(struct tegra_i2s *i2s, u32 reg, u32 val)
+{
+	__raw_writel(val, i2s->regs + reg);
+}
+
+static inline u32 tegra_i2s_read(struct tegra_i2s *i2s, u32 reg)
+{
+	return __raw_readl(i2s->regs + reg);
+}
+
+#ifdef CONFIG_DEBUG_FS
+static int tegra_i2s_show(struct seq_file *s, void *unused)
+{
+#define REG(r) { r, #r }
+	static const struct {
+		int offset;
+		const char *name;
+	} regs[] = {
+		REG(TEGRA_I2S_CTRL),
+		REG(TEGRA_I2S_STATUS),
+		REG(TEGRA_I2S_TIMING),
+		REG(TEGRA_I2S_FIFO_SCR),
+		REG(TEGRA_I2S_PCM_CTRL),
+		REG(TEGRA_I2S_NW_CTRL),
+		REG(TEGRA_I2S_TDM_CTRL),
+		REG(TEGRA_I2S_TDM_TX_RX_CTRL),
+	};
+#undef REG
+
+	struct tegra_i2s *i2s = s->private;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(regs); i++) {
+		u32 val = tegra_i2s_read(i2s, regs[i].offset);
+		seq_printf(s, "%s = %08x\n", regs[i].name, val);
+	}
+
+	return 0;
+}
+
+static int tegra_i2s_debug_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, tegra_i2s_show, inode->i_private);
+}
+
+static const struct file_operations tegra_i2s_debug_fops = {
+	.open    = tegra_i2s_debug_open,
+	.read    = seq_read,
+	.llseek  = seq_lseek,
+	.release = single_release,
+};
+
+static void tegra_i2s_debug_add(struct tegra_i2s *i2s, int id)
+{
+	char name[] = DRV_NAME ".0";
+
+	snprintf(name, sizeof(name), DRV_NAME".%1d", id);
+	i2s->debug = debugfs_create_file(name, S_IRUGO, asoc_debugfs_root,
+						i2s, &tegra_i2s_debug_fops);
+}
+
+static void tegra_i2s_debug_remove(struct tegra_i2s *i2s)
+{
+	if (i2s->debug)
+		debugfs_remove(i2s->debug);
+}
+#else
+static inline void tegra_i2s_debug_add(struct tegra_i2s *i2s)
+{
+}
+
+static inline void tegra_i2s_debug_remove(struct tegra_i2s *i2s)
+{
+}
+#endif
+
+static int tegra_i2s_set_fmt(struct snd_soc_dai *dai,
+				unsigned int fmt)
+{
+	struct tegra_i2s *i2s = snd_soc_dai_get_drvdata(dai);
+
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_NB_NF:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	i2s->reg_ctrl &= ~TEGRA_I2S_CTRL_MASTER_ENABLE;
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBS_CFS:
+		i2s->reg_ctrl |= TEGRA_I2S_CTRL_MASTER_ENABLE;
+		break;
+	case SND_SOC_DAIFMT_CBM_CFM:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	i2s->reg_ctrl &= ~(TEGRA_I2S_CTRL_BIT_FORMAT_MASK | 
+				TEGRA_I2S_CTRL_LRCK_MASK);
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_DSP_A:
+		i2s->reg_ctrl |= TEGRA_I2S_CTRL_BIT_FORMAT_DSP;
+		i2s->reg_ctrl |= TEGRA_I2S_CTRL_LRCK_L_LOW;
+		break;
+	case SND_SOC_DAIFMT_DSP_B:
+		i2s->reg_ctrl |= TEGRA_I2S_CTRL_BIT_FORMAT_DSP;
+		i2s->reg_ctrl |= TEGRA_I2S_CTRL_LRCK_R_LOW;
+		break;
+	case SND_SOC_DAIFMT_I2S:
+		i2s->reg_ctrl |= TEGRA_I2S_CTRL_BIT_FORMAT_I2S;
+		i2s->reg_ctrl |= TEGRA_I2S_CTRL_LRCK_L_LOW;
+		break;
+	case SND_SOC_DAIFMT_RIGHT_J:
+		i2s->reg_ctrl |= TEGRA_I2S_CTRL_BIT_FORMAT_RJM;
+		i2s->reg_ctrl |= TEGRA_I2S_CTRL_LRCK_L_LOW;
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		i2s->reg_ctrl |= TEGRA_I2S_CTRL_BIT_FORMAT_LJM;
+		i2s->reg_ctrl |= TEGRA_I2S_CTRL_LRCK_L_LOW;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int tegra_i2s_hw_params(struct snd_pcm_substream *substream,
+				struct snd_pcm_hw_params *params,
+				struct snd_soc_dai *dai)
+{
+        struct device *dev = substream->pcm->card->dev;
+	struct tegra_i2s *i2s = snd_soc_dai_get_drvdata(dai);
+	u32 reg;
+	int ret, sample_size, srate, i2sclock, bitcnt;
+
+	i2s->reg_ctrl &= ~TEGRA_I2S_CTRL_BIT_SIZE_MASK;
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+		i2s->reg_ctrl |= TEGRA_I2S_CTRL_BIT_SIZE_16;
+		sample_size = 16;
+		break;
+	case SNDRV_PCM_FORMAT_S24_LE:
+		i2s->reg_ctrl |= TEGRA_I2S_CTRL_BIT_SIZE_24;
+		sample_size = 24;
+		break;
+	case SNDRV_PCM_FORMAT_S32_LE:
+		i2s->reg_ctrl |= TEGRA_I2S_CTRL_BIT_SIZE_32;
+		sample_size = 32;
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
+	ret = clk_set_rate(i2s->clk_i2s, i2sclock);
+	if (ret) {
+		dev_err(dev, "Can't set I2S clock rate: %d\n", ret);
+		return ret;
+	}
+
+	bitcnt = (i2sclock / (2 * srate)) - 1;
+	if (bitcnt < 0 || bitcnt > TEGRA_I2S_TIMING_CHANNEL_BIT_COUNT_MASK_US)
+		return -EINVAL;
+	reg = bitcnt << TEGRA_I2S_TIMING_CHANNEL_BIT_COUNT_SHIFT;
+
+	if (i2sclock % (2 * srate))
+		reg |= TEGRA_I2S_TIMING_NON_SYM_ENABLE;
+
+	tegra_i2s_write(i2s, TEGRA_I2S_TIMING, reg);
+
+	tegra_i2s_write(i2s, TEGRA_I2S_FIFO_SCR,
+		TEGRA_I2S_FIFO_SCR_FIFO2_ATN_LVL_FOUR_SLOTS |
+		TEGRA_I2S_FIFO_SCR_FIFO1_ATN_LVL_FOUR_SLOTS);
+
+	return 0;
+}
+
+static void tegra_i2s_start_playback(struct tegra_i2s *i2s)
+{
+	i2s->reg_ctrl |= TEGRA_I2S_CTRL_FIFO1_ENABLE;
+	tegra_i2s_write(i2s, TEGRA_I2S_CTRL, i2s->reg_ctrl);
+}
+
+static void tegra_i2s_stop_playback(struct tegra_i2s *i2s)
+{
+	i2s->reg_ctrl &= ~TEGRA_I2S_CTRL_FIFO1_ENABLE;
+	tegra_i2s_write(i2s, TEGRA_I2S_CTRL, i2s->reg_ctrl);
+}
+
+static void tegra_i2s_start_capture(struct tegra_i2s *i2s)
+{
+	i2s->reg_ctrl |= TEGRA_I2S_CTRL_FIFO2_ENABLE;
+	tegra_i2s_write(i2s, TEGRA_I2S_CTRL, i2s->reg_ctrl);
+}
+
+static void tegra_i2s_stop_capture(struct tegra_i2s *i2s)
+{
+	i2s->reg_ctrl &= ~TEGRA_I2S_CTRL_FIFO2_ENABLE;
+	tegra_i2s_write(i2s, TEGRA_I2S_CTRL, i2s->reg_ctrl);
+}
+
+static int tegra_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
+				struct snd_soc_dai *dai)
+{
+	struct tegra_i2s *i2s = snd_soc_dai_get_drvdata(dai);
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+	case SNDRV_PCM_TRIGGER_RESUME:
+		if (!i2s->clk_refs)
+			clk_enable(i2s->clk_i2s);
+		i2s->clk_refs++;
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+			tegra_i2s_start_playback(i2s);
+		else
+			tegra_i2s_start_capture(i2s);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+			tegra_i2s_stop_playback(i2s);
+		else
+			tegra_i2s_stop_capture(i2s);
+		i2s->clk_refs--;
+		if (!i2s->clk_refs)
+			clk_disable(i2s->clk_i2s);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int tegra_i2s_probe(struct snd_soc_dai *dai)
+{
+	struct tegra_i2s * i2s = snd_soc_dai_get_drvdata(dai);
+
+	dai->capture_dma_data = &i2s->capture_dma_data;
+	dai->playback_dma_data = &i2s->playback_dma_data;
+
+	return 0;
+}
+
+static struct snd_soc_dai_ops tegra_i2s_dai_ops = {
+	.set_fmt	= tegra_i2s_set_fmt,
+	.hw_params	= tegra_i2s_hw_params,
+	.trigger	= tegra_i2s_trigger,
+};
+
+struct snd_soc_dai_driver tegra_i2s_dai[] = {
+	{
+		.name = DRV_NAME ".0",
+		.probe = tegra_i2s_probe,
+		.playback = {
+			.channels_min = 2,
+			.channels_max = 2,
+			.rates = SNDRV_PCM_RATE_8000_96000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE,
+		},
+		.capture = {
+			.channels_min = 2,
+			.channels_max = 2,
+			.rates = SNDRV_PCM_RATE_8000_96000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE,
+		},
+		.ops = &tegra_i2s_dai_ops,
+		.symmetric_rates = 1,
+	},
+	{
+		.name = DRV_NAME ".1",
+		.probe = tegra_i2s_probe,
+		.playback = {
+			.channels_min = 2,
+			.channels_max = 2,
+			.rates = SNDRV_PCM_RATE_8000_96000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE,
+		},
+		.capture = {
+			.channels_min = 2,
+			.channels_max = 2,
+			.rates = SNDRV_PCM_RATE_8000_96000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE,
+		},
+		.ops = &tegra_i2s_dai_ops,
+		.symmetric_rates = 1,
+	},
+};
+
+static __devinit int tegra_i2s_platform_probe(struct platform_device *pdev)
+{
+	struct tegra_i2s * i2s;
+	char clk_name[12]; /* tegra-i2s.0 */
+	struct resource *mem, *memregion, *dmareq;
+	int ret;
+
+	if ((pdev->id < 0) ||
+		(pdev->id >= ARRAY_SIZE(tegra_i2s_dai))) {
+		dev_err(&pdev->dev, "ID %d out of range\n", pdev->id);
+		return -EINVAL;
+	}
+
+	/*
+	 * FIXME: Until a codec driver exists for the tegra DAS, hard-code a
+	 * 1:1 mapping between audio controllers and audio ports.
+	 */
+	ret = tegra_das_connect_dap_to_dac(TEGRA_DAS_DAP_ID_1 + pdev->id,
+					TEGRA_DAS_DAP_SEL_DAC1 + pdev->id);
+	if (ret) {
+		dev_err(&pdev->dev, "Can't set up DAP connection\n");
+		return ret;
+	}
+	ret = tegra_das_connect_dac_to_dap(TEGRA_DAS_DAC_ID_1 + pdev->id,
+					TEGRA_DAS_DAC_SEL_DAP1 + pdev->id);
+	if (ret) {
+		dev_err(&pdev->dev, "Can't set up DAC connection\n");
+		return ret;
+	}
+
+	i2s = kzalloc(sizeof(struct tegra_i2s), GFP_KERNEL);
+	if (!i2s) {
+		dev_err(&pdev->dev, "Can't allocate tegra_i2s\n");
+		ret = -ENOMEM;
+		goto exit;
+	}
+	dev_set_drvdata(&pdev->dev, i2s);
+
+	snprintf(clk_name, sizeof(clk_name), DRV_NAME ".%d", pdev->id);
+	i2s->clk_i2s = clk_get_sys(clk_name, NULL);
+	if (IS_ERR_OR_NULL(i2s->clk_i2s)) {
+		pr_err("Can't retrieve i2s clock\n");
+		ret = PTR_ERR(i2s->clk_i2s);
+		goto err_free;
+	}
+
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!mem) {
+		dev_err(&pdev->dev, "No memory resource\n");
+		ret = -ENODEV;
+		goto err_clk_put;
+	}
+
+	dmareq = platform_get_resource(pdev, IORESOURCE_DMA, 0);
+	if (!dmareq) {
+		dev_err(&pdev->dev, "No DMA resource\n");
+		ret = -ENODEV;
+		goto err_clk_put;
+	}
+
+	memregion = request_mem_region(mem->start, resource_size(mem),
+					DRV_NAME);
+	if (!memregion) {
+		dev_err(&pdev->dev, "Memory region already claimed\n");
+		ret = -EBUSY;
+		goto err_clk_put;
+	}
+
+	i2s->regs = ioremap(mem->start, resource_size(mem));
+	if (!i2s->regs) {
+		dev_err(&pdev->dev, "ioremap failed\n");
+		ret = -ENOMEM;
+		goto err_release;
+	}
+
+	i2s->capture_dma_data.addr = mem->start + TEGRA_I2S_FIFO2;
+	i2s->capture_dma_data.wrap = 4;
+	i2s->capture_dma_data.width = 32;
+	i2s->capture_dma_data.req_sel = dmareq->start;
+
+	i2s->playback_dma_data.addr = mem->start + TEGRA_I2S_FIFO1;
+	i2s->playback_dma_data.wrap = 4;
+	i2s->playback_dma_data.width = 32;
+	i2s->playback_dma_data.req_sel = dmareq->start;
+
+	i2s->reg_ctrl = TEGRA_I2S_CTRL_FIFO_FORMAT_PACKED;
+
+	ret = snd_soc_register_dai(&pdev->dev, &tegra_i2s_dai[pdev->id]);
+	if (ret) {
+		dev_err(&pdev->dev, "Could not register DAI: %d\n", ret);
+		ret = -ENOMEM;
+		goto err_unmap;
+	}
+
+	tegra_i2s_debug_add(i2s, pdev->id);
+
+	return 0;
+
+err_unmap:
+	iounmap(i2s->regs);
+err_release:
+	release_mem_region(mem->start, resource_size(mem));
+err_clk_put:
+	clk_put(i2s->clk_i2s);
+err_free:
+	kfree(i2s);
+exit:
+	return ret;
+}
+
+static int __devexit tegra_i2s_platform_remove(struct platform_device *pdev)
+{
+	struct tegra_i2s *i2s = dev_get_drvdata(&pdev->dev);
+	struct resource *res;
+
+	snd_soc_unregister_dai(&pdev->dev);
+
+	tegra_i2s_debug_remove(i2s);
+
+	iounmap(i2s->regs);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	release_mem_region(res->start, resource_size(res));
+
+	clk_put(i2s->clk_i2s);
+
+	kfree(i2s);
+
+	return 0;
+}
+
+static struct platform_driver tegra_i2s_driver = {
+	.driver = {
+		.name = DRV_NAME,
+		.owner = THIS_MODULE,
+	},
+	.probe = tegra_i2s_platform_probe,
+	.remove = __devexit_p(tegra_i2s_platform_remove),
+};
+
+static int __init snd_tegra_i2s_init(void)
+{
+	return platform_driver_register(&tegra_i2s_driver);
+}
+module_init(snd_tegra_i2s_init);
+
+static void __exit snd_tegra_i2s_exit(void)
+{
+	platform_driver_unregister(&tegra_i2s_driver);
+}
+module_exit(snd_tegra_i2s_exit);
+
+MODULE_AUTHOR("Stephen Warren <swarren@nvidia.com>");
+MODULE_DESCRIPTION("Tegra I2S ASoC driver");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/tegra/tegra_i2s.h b/sound/soc/tegra/tegra_i2s.h
new file mode 100644
index 0000000..2b38a09
--- /dev/null
+++ b/sound/soc/tegra/tegra_i2s.h
@@ -0,0 +1,165 @@
+/*
+ * tegra_i2s.h - Definitions for Tegra I2S driver
+ *
+ * Author: Stephen Warren <swarren@nvidia.com>
+ * Copyright (C) 2010 - NVIDIA, Inc.
+ *
+ * Based on code copyright/by:
+ *
+ * Copyright (c) 2009-2010, NVIDIA Corporation.
+ * Scott Peterson <speterson@nvidia.com>
+ *
+ * Copyright (C) 2010 Google, Inc.
+ * Iliyan Malchev <malchev@google.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#ifndef __TEGRA_I2S_H__
+#define __TEGRA_I2S_H__
+
+#include "tegra_pcm.h"
+
+/* Register offsets from TEGRA_I2S1_BASE and TEGRA_I2S2_BASE */
+
+#define TEGRA_I2S_CTRL					0x00
+#define TEGRA_I2S_STATUS				0x04
+#define TEGRA_I2S_TIMING				0x08
+#define TEGRA_I2S_FIFO_SCR				0x0c
+#define TEGRA_I2S_PCM_CTRL				0x10
+#define TEGRA_I2S_NW_CTRL				0x14
+#define TEGRA_I2S_TDM_CTRL				0x20
+#define TEGRA_I2S_TDM_TX_RX_CTRL			0x24
+#define TEGRA_I2S_FIFO1					0x40
+#define TEGRA_I2S_FIFO2					0x80
+
+/* Fields in TEGRA_I2S_CTRL */
+
+#define TEGRA_I2S_CTRL_FIFO2_TX_ENABLE			(1 << 30)
+#define TEGRA_I2S_CTRL_FIFO1_ENABLE			(1 << 29)
+#define TEGRA_I2S_CTRL_FIFO2_ENABLE			(1 << 28)
+#define TEGRA_I2S_CTRL_FIFO1_RX_ENABLE			(1 << 27)
+#define TEGRA_I2S_CTRL_FIFO_LPBK_ENABLE			(1 << 26)
+#define TEGRA_I2S_CTRL_MASTER_ENABLE			(1 << 25)
+
+#define TEGRA_I2S_LRCK_LEFT_LOW				0
+#define TEGRA_I2S_LRCK_RIGHT_LOW			1
+
+#define TEGRA_I2S_CTRL_LRCK_SHIFT			24
+#define TEGRA_I2S_CTRL_LRCK_MASK			(1                        << TEGRA_I2S_CTRL_LRCK_SHIFT)
+#define TEGRA_I2S_CTRL_LRCK_L_LOW			(TEGRA_I2S_LRCK_LEFT_LOW  << TEGRA_I2S_CTRL_LRCK_SHIFT)
+#define TEGRA_I2S_CTRL_LRCK_R_LOW			(TEGRA_I2S_LRCK_RIGHT_LOW << TEGRA_I2S_CTRL_LRCK_SHIFT)
+
+#define TEGRA_I2S_BIT_FORMAT_I2S			0
+#define TEGRA_I2S_BIT_FORMAT_RJM			1
+#define TEGRA_I2S_BIT_FORMAT_LJM			2
+#define TEGRA_I2S_BIT_FORMAT_DSP			3
+
+#define TEGRA_I2S_CTRL_BIT_FORMAT_SHIFT			10
+#define TEGRA_I2S_CTRL_BIT_FORMAT_MASK			(3                        << TEGRA_I2S_CTRL_BIT_FORMAT_SHIFT)
+#define TEGRA_I2S_CTRL_BIT_FORMAT_I2S			(TEGRA_I2S_BIT_FORMAT_I2S << TEGRA_I2S_CTRL_BIT_FORMAT_SHIFT)
+#define TEGRA_I2S_CTRL_BIT_FORMAT_RJM			(TEGRA_I2S_BIT_FORMAT_RJM << TEGRA_I2S_CTRL_BIT_FORMAT_SHIFT)
+#define TEGRA_I2S_CTRL_BIT_FORMAT_LJM			(TEGRA_I2S_BIT_FORMAT_LJM << TEGRA_I2S_CTRL_BIT_FORMAT_SHIFT)
+#define TEGRA_I2S_CTRL_BIT_FORMAT_DSP			(TEGRA_I2S_BIT_FORMAT_DSP << TEGRA_I2S_CTRL_BIT_FORMAT_SHIFT)
+
+#define TEGRA_I2S_BIT_SIZE_16				0
+#define TEGRA_I2S_BIT_SIZE_20				1
+#define TEGRA_I2S_BIT_SIZE_24				2
+#define TEGRA_I2S_BIT_SIZE_32				3
+
+#define TEGRA_I2S_CTRL_BIT_SIZE_SHIFT			8
+#define TEGRA_I2S_CTRL_BIT_SIZE_MASK			(3                     << TEGRA_I2S_CTRL_BIT_SIZE_SHIFT)
+#define TEGRA_I2S_CTRL_BIT_SIZE_16			(TEGRA_I2S_BIT_SIZE_16 << TEGRA_I2S_CTRL_BIT_SIZE_SHIFT)
+#define TEGRA_I2S_CTRL_BIT_SIZE_20			(TEGRA_I2S_BIT_SIZE_20 << TEGRA_I2S_CTRL_BIT_SIZE_SHIFT)
+#define TEGRA_I2S_CTRL_BIT_SIZE_24			(TEGRA_I2S_BIT_SIZE_24 << TEGRA_I2S_CTRL_BIT_SIZE_SHIFT)
+#define TEGRA_I2S_CTRL_BIT_SIZE_32			(TEGRA_I2S_BIT_SIZE_32 << TEGRA_I2S_CTRL_BIT_SIZE_SHIFT)
+
+#define TEGRA_I2S_FIFO_16_LSB				0
+#define TEGRA_I2S_FIFO_20_LSB				1
+#define TEGRA_I2S_FIFO_24_LSB				2
+#define TEGRA_I2S_FIFO_32				3
+#define TEGRA_I2S_FIFO_PACKED				7
+
+#define TEGRA_I2S_CTRL_FIFO_FORMAT_SHIFT		4
+#define TEGRA_I2S_CTRL_FIFO_FORMAT_MASK			(7                     << TEGRA_I2S_CTRL_FIFO_FORMAT_SHIFT)
+#define TEGRA_I2S_CTRL_FIFO_FORMAT_16_LSB		(TEGRA_I2S_FIFO_16_LSB << TEGRA_I2S_CTRL_FIFO_FORMAT_SHIFT)
+#define TEGRA_I2S_CTRL_FIFO_FORMAT_20_LSB		(TEGRA_I2S_FIFO_20_LSB << TEGRA_I2S_CTRL_FIFO_FORMAT_SHIFT)
+#define TEGRA_I2S_CTRL_FIFO_FORMAT_24_LSB		(TEGRA_I2S_FIFO_24_LSB << TEGRA_I2S_CTRL_FIFO_FORMAT_SHIFT)
+#define TEGRA_I2S_CTRL_FIFO_FORMAT_32			(TEGRA_I2S_FIFO_32     << TEGRA_I2S_CTRL_FIFO_FORMAT_SHIFT)
+#define TEGRA_I2S_CTRL_FIFO_FORMAT_PACKED		(TEGRA_I2S_FIFO_PACKED << TEGRA_I2S_CTRL_FIFO_FORMAT_SHIFT)
+
+#define TEGRA_I2S_CTRL_IE_FIFO1_ERR			(1 << 3)
+#define TEGRA_I2S_CTRL_IE_FIFO2_ERR			(1 << 2)
+#define TEGRA_I2S_CTRL_QE_FIFO1				(1 << 1)
+#define TEGRA_I2S_CTRL_QE_FIFO2				(1 << 0)
+
+/* Fields in TEGRA_I2S_STATUS */
+
+#define TEGRA_I2S_STATUS_FIFO1_RDY			(1 << 31)
+#define TEGRA_I2S_STATUS_FIFO2_RDY			(1 << 30)
+#define TEGRA_I2S_STATUS_FIFO1_BSY			(1 << 29)
+#define TEGRA_I2S_STATUS_FIFO2_BSY			(1 << 28)
+#define TEGRA_I2S_STATUS_FIFO1_ERR			(1 << 3)
+#define TEGRA_I2S_STATUS_FIFO2_ERR			(1 << 2)
+#define TEGRA_I2S_STATUS_QS_FIFO1			(1 << 1)
+#define TEGRA_I2S_STATUS_QS_FIFO2			(1 << 0)
+
+/* Fields in TEGRA_I2S_TIMING */
+
+#define TEGRA_I2S_TIMING_NON_SYM_ENABLE			(1 << 12)
+#define TEGRA_I2S_TIMING_CHANNEL_BIT_COUNT_SHIFT	0
+#define TEGRA_I2S_TIMING_CHANNEL_BIT_COUNT_MASK_US	0x7fff
+#define TEGRA_I2S_TIMING_CHANNEL_BIT_COUNT_MASK		(TEGRA_I2S_TIMING_CHANNEL_BIT_COUNT_MASK_US << TEGRA_I2S_TIMING_CHANNEL_BIT_COUNT_SHIFT)
+
+/* Fields in TEGRA_I2S_FIFO_SCR */
+
+#define TEGRA_I2S_FIFO_SCR_FIFO2_FULL_EMPTY_COUNT_SHIFT	24
+#define TEGRA_I2S_FIFO_SCR_FIFO1_FULL_EMPTY_COUNT_SHIFT	16
+#define TEGRA_I2S_FIFO_SCR_FIFO_FULL_EMPTY_COUNT_MASK	0x3f
+
+#define TEGRA_I2S_FIFO_SCR_FIFO2_CLR			(1 << 12)
+#define TEGRA_I2S_FIFO_SCR_FIFO1_CLR			(1 << 8)
+
+#define TEGRA_I2S_FIFO_ATN_LVL_ONE_SLOT			0
+#define TEGRA_I2S_FIFO_ATN_LVL_FOUR_SLOTS		1
+#define TEGRA_I2S_FIFO_ATN_LVL_EIGHT_SLOTS		2
+#define TEGRA_I2S_FIFO_ATN_LVL_TWELVE_SLOTS		3
+
+#define TEGRA_I2S_FIFO_SCR_FIFO2_ATN_LVL_SHIFT		4
+#define TEGRA_I2S_FIFO_SCR_FIFO2_ATN_LVL_MASK		(3 << TEGRA_I2S_FIFO_SCR_FIFO2_ATN_LVL_SHIFT)
+#define TEGRA_I2S_FIFO_SCR_FIFO2_ATN_LVL_ONE_SLOT	(TEGRA_I2S_FIFO_ATN_LVL_ONE_SLOT     << TEGRA_I2S_FIFO_SCR_FIFO2_ATN_LVL_SHIFT)
+#define TEGRA_I2S_FIFO_SCR_FIFO2_ATN_LVL_FOUR_SLOTS	(TEGRA_I2S_FIFO_ATN_LVL_FOUR_SLOTS   << TEGRA_I2S_FIFO_SCR_FIFO2_ATN_LVL_SHIFT)
+#define TEGRA_I2S_FIFO_SCR_FIFO2_ATN_LVL_EIGHT_SLOTS	(TEGRA_I2S_FIFO_ATN_LVL_EIGHT_SLOTS  << TEGRA_I2S_FIFO_SCR_FIFO2_ATN_LVL_SHIFT)
+#define TEGRA_I2S_FIFO_SCR_FIFO2_ATN_LVL_TWELVE_SLOTS	(TEGRA_I2S_FIFO_ATN_LVL_TWELVE_SLOTS << TEGRA_I2S_FIFO_SCR_FIFO2_ATN_LVL_SHIFT)
+
+#define TEGRA_I2S_FIFO_SCR_FIFO1_ATN_LVL_SHIFT		0
+#define TEGRA_I2S_FIFO_SCR_FIFO1_ATN_LVL_MASK		(3 << TEGRA_I2S_FIFO_SCR_FIFO1_ATN_LVL_SHIFT)
+#define TEGRA_I2S_FIFO_SCR_FIFO1_ATN_LVL_ONE_SLOT	(TEGRA_I2S_FIFO_ATN_LVL_ONE_SLOT     << TEGRA_I2S_FIFO_SCR_FIFO1_ATN_LVL_SHIFT)
+#define TEGRA_I2S_FIFO_SCR_FIFO1_ATN_LVL_FOUR_SLOTS	(TEGRA_I2S_FIFO_ATN_LVL_FOUR_SLOTS   << TEGRA_I2S_FIFO_SCR_FIFO1_ATN_LVL_SHIFT)
+#define TEGRA_I2S_FIFO_SCR_FIFO1_ATN_LVL_EIGHT_SLOTS	(TEGRA_I2S_FIFO_ATN_LVL_EIGHT_SLOTS  << TEGRA_I2S_FIFO_SCR_FIFO1_ATN_LVL_SHIFT)
+#define TEGRA_I2S_FIFO_SCR_FIFO1_ATN_LVL_TWELVE_SLOTS	(TEGRA_I2S_FIFO_ATN_LVL_TWELVE_SLOTS << TEGRA_I2S_FIFO_SCR_FIFO1_ATN_LVL_SHIFT)
+
+struct tegra_i2s {
+	struct clk *clk_i2s;
+	int clk_refs;
+	struct tegra_pcm_dma_params capture_dma_data;
+	struct tegra_pcm_dma_params playback_dma_data;
+	void __iomem *regs;
+	struct dentry *debug;
+	u32 reg_ctrl;
+};
+
+#endif
-- 
1.7.0.4
