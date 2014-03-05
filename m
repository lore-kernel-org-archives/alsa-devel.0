From: RongJun Ying <rjying@gmail.com>
Subject: [PATCH v5-resend 4/7] ASoC: sirf: Add SiRF I2S driver
Date: Wed,  5 Mar 2014 16:34:37 +0800
Message-ID: <1394008480-29135-5-git-send-email-rongjun.ying@csr.com>
References: <1394008480-29135-1-git-send-email-rongjun.ying@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f169.google.com (mail-pd0-f169.google.com
 [209.85.192.169])
 by alsa0.perex.cz (Postfix) with ESMTP id EF4082658A0
 for <alsa-devel@alsa-project.org>; Wed,  5 Mar 2014 09:35:47 +0100 (CET)
Received: by mail-pd0-f169.google.com with SMTP id fp1so767921pdb.28
 for <alsa-devel@alsa-project.org>; Wed, 05 Mar 2014 00:35:47 -0800 (PST)
In-Reply-To: <1394008480-29135-1-git-send-email-rongjun.ying@csr.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, rjying@gmail.com
Cc: Takashi Iwai <tiwai@suse.de>, Rongjun Ying <rongjun.ying@csr.com>, alsa-devel@alsa-project.org, workgroup.linux@csr.com
List-Id: alsa-devel@alsa-project.org

From: Rongjun Ying <rongjun.ying@csr.com>

This patch adds ASoC support for SiRF SoCs I2S modules.
Features include:
1. I2S bus specification compliant (Released by Philips Semiconductors in June, 1996)
2. Support both master and slave mode.
3. Provides MCLK to I2S CODEC in I2S master mode
4. Supports 16-bit resolution playback
5. Supports 16-bit resolution record
6 .Supports 2 channel record
7. Supports 2 channel and 6 channel mode playback
8. Frame length, left channel length and right channel length are all programmable
9. Supports two DMA channels for TXFIFO and RXFIFO
10. Supports floating mode (x_ac97_dout can be configured as input)

Signed-off-by: Rongjun Ying <rongjun.ying@csr.com>
---
-v5:
1. Drop all inlines.
2. Fixed returning ret twice is redundant in sirf_i2s_runtime_resume function

 .../devicetree/bindings/sound/sirf-i2s.txt         |   27 ++
 sound/soc/sirf/Kconfig                             |    4 +
 sound/soc/sirf/Makefile                            |    2 +
 sound/soc/sirf/sirf-i2s.c                          |  434 ++++++++++++++++++++
 sound/soc/sirf/sirf-i2s.h                          |   88 ++++
 5 files changed, 555 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/sirf-i2s.txt
 create mode 100644 sound/soc/sirf/sirf-i2s.c
 create mode 100644 sound/soc/sirf/sirf-i2s.h

diff --git a/Documentation/devicetree/bindings/sound/sirf-i2s.txt b/Documentation/devicetree/bindings/sound/sirf-i2s.txt
new file mode 100644
index 0000000..cbff8a8
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/sirf-i2s.txt
@@ -0,0 +1,27 @@
+* SiRF SoC I2S module
+
+Required properties:
+- compatible: "sirf,prima2-i2s"
+- reg: Base address and size entries:
+- dmas: List of DMA controller phandle and DMA request line ordered pairs.
+- dma-names: Identifier string for each DMA request line in the dmas property.
+  These strings correspond 1:1 with the ordered pairs in dmas.
+
+  One of the DMA channels will be responsible for transmission (should be
+  named "tx") and one for reception (should be named "rx").
+
+- clocks: I2S controller clock source
+- pinctrl-names: Must contain a "default" entry.
+- pinctrl-NNN: One property must exist for each entry in pinctrl-names.
+
+Example:
+
+i2s: i2s@b0040000 {
+	compatible = "sirf,prima2-i2s";
+	reg = <0xb0040000 0x10000>;
+	dmas = <&dmac1 6>, <&dmac1 12>;
+	dma-names = "rx", "tx";
+	clocks = <&clks 27>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2s_pins_a>;
+};
diff --git a/sound/soc/sirf/Kconfig b/sound/soc/sirf/Kconfig
index 89e8942..e0b7157 100644
--- a/sound/soc/sirf/Kconfig
+++ b/sound/soc/sirf/Kconfig
@@ -12,3 +12,7 @@ config SND_SOC_SIRF_AUDIO
 config SND_SOC_SIRF_AUDIO_PORT
 	select REGMAP_MMIO
 	tristate
+
+config SND_SOC_SIRF_I2S
+	select REGMAP_MMIO
+	tristate
diff --git a/sound/soc/sirf/Makefile b/sound/soc/sirf/Makefile
index 913b932..d06a39e 100644
--- a/sound/soc/sirf/Makefile
+++ b/sound/soc/sirf/Makefile
@@ -1,5 +1,7 @@
 snd-soc-sirf-audio-objs := sirf-audio.o
 snd-soc-sirf-audio-port-objs := sirf-audio-port.o
+snd-soc-sirf-i2s-objs := sirf-i2s.o
 
 obj-$(CONFIG_SND_SOC_SIRF_AUDIO) += snd-soc-sirf-audio.o
 obj-$(CONFIG_SND_SOC_SIRF_AUDIO_PORT) += snd-soc-sirf-audio-port.o
+obj-$(CONFIG_SND_SOC_SIRF_I2S) += snd-soc-sirf-i2s.o
diff --git a/sound/soc/sirf/sirf-i2s.c b/sound/soc/sirf/sirf-i2s.c
new file mode 100644
index 0000000..ae83033
--- /dev/null
+++ b/sound/soc/sirf/sirf-i2s.c
@@ -0,0 +1,434 @@
+/*
+ * SiRF I2S driver
+ *
+ * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *
+ * Licensed under GPLv2 or later.
+ */
+#include <linux/module.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/pm_runtime.h>
+#include <linux/clk.h>
+#include <linux/regmap.h>
+#include <sound/soc.h>
+#include <sound/pcm_params.h>
+#include <sound/dmaengine_pcm.h>
+
+#include "sirf-i2s.h"
+
+struct sirf_i2s {
+	struct regmap *regmap;
+	struct clk *clk;
+	u32 i2s_ctrl;
+	u32 i2s_ctrl_tx_rx_en;
+	bool master;
+	int ext_clk;
+	int src_clk_rate;
+	struct snd_dmaengine_dai_dma_data playback_dma_data;
+	struct snd_dmaengine_dai_dma_data capture_dma_data;
+};
+
+static int sirf_i2s_dai_probe(struct snd_soc_dai *dai)
+{
+	struct sirf_i2s *i2s = snd_soc_dai_get_drvdata(dai);
+	snd_soc_dai_init_dma_data(dai, &i2s->playback_dma_data,
+			&i2s->capture_dma_data);
+	return 0;
+}
+
+static void sirf_i2s_tx_enable(struct sirf_i2s *i2s)
+{
+	/* First start the FIFO, then enable the tx/rx */
+	regmap_update_bits(i2s->regmap, AUDIO_CTRL_I2S_TXFIFO_OP,
+		AUDIO_FIFO_RESET, AUDIO_FIFO_RESET);
+	regmap_update_bits(i2s->regmap, AUDIO_CTRL_I2S_TXFIFO_OP,
+		AUDIO_FIFO_START, AUDIO_FIFO_RESET);
+	regmap_update_bits(i2s->regmap, AUDIO_CTRL_I2S_TX_RX_EN,
+		I2S_TX_ENABLE | I2S_DOUT_OE,
+		I2S_TX_ENABLE | I2S_DOUT_OE);
+}
+
+static void sirf_i2s_tx_disable(struct sirf_i2s *i2s)
+{
+	regmap_update_bits(i2s->regmap, AUDIO_CTRL_I2S_TX_RX_EN,
+		I2S_TX_ENABLE, ~I2S_TX_ENABLE);
+	/* First disable the tx/rx, then stop the FIFO */
+	regmap_write(i2s->regmap, AUDIO_CTRL_I2S_TXFIFO_OP, 0);
+}
+
+static void sirf_i2s_rx_enable(struct sirf_i2s *i2s)
+{
+	/* First start the FIFO, then enable the tx/rx */
+	regmap_update_bits(i2s->regmap, AUDIO_CTRL_I2S_RXFIFO_OP,
+		AUDIO_FIFO_RESET, AUDIO_FIFO_RESET);
+	regmap_update_bits(i2s->regmap, AUDIO_CTRL_I2S_RXFIFO_OP,
+		AUDIO_FIFO_START, AUDIO_FIFO_START);
+	regmap_update_bits(i2s->regmap, AUDIO_CTRL_I2S_TX_RX_EN,
+		I2S_RX_ENABLE, I2S_RX_ENABLE);
+}
+
+static void sirf_i2s_rx_disable(struct sirf_i2s *i2s)
+{
+	regmap_update_bits(i2s->regmap, AUDIO_CTRL_I2S_TX_RX_EN,
+		I2S_RX_ENABLE, ~I2S_RX_ENABLE);
+	/* First disable the tx/rx, then stop the FIFO */
+	regmap_write(i2s->regmap, AUDIO_CTRL_I2S_RXFIFO_OP, 0);
+}
+
+static int sirf_i2s_trigger(struct snd_pcm_substream *substream,
+		int cmd, struct snd_soc_dai *dai)
+{
+	struct sirf_i2s *i2s = snd_soc_dai_get_drvdata(dai);
+	int playback = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK);
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		if (playback)
+			sirf_i2s_tx_enable(i2s);
+		else
+			sirf_i2s_rx_enable(i2s);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		if (playback)
+			sirf_i2s_tx_disable(i2s);
+		else
+			sirf_i2s_rx_disable(i2s);
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int sirf_i2s_hw_params(struct snd_pcm_substream *substream,
+		struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
+{
+	struct sirf_i2s *i2s = snd_soc_dai_get_drvdata(dai);
+	u32 i2s_ctrl;
+	u32 i2s_tx_rx_ctrl;
+	u32 left_len, frame_len;
+	int channels = params_channels(params);
+	u32 bitclk;
+	u32 bclk_div;
+	u32 div;
+
+	/*
+	 * SiRFSoC I2S controller only support 2 and 6 channells output.
+	 * I2S_SIX_CHANNELS bit clear: select 2 channels mode.
+	 * I2S_SIX_CHANNELS bit set: select 6 channels mode.
+	 */
+	regmap_read(i2s->regmap, AUDIO_CTRL_I2S_CTRL, &i2s_ctrl);
+	regmap_read(i2s->regmap, AUDIO_CTRL_I2S_TX_RX_EN, &i2s_tx_rx_ctrl);
+	switch (channels) {
+	case 2:
+		i2s_ctrl &= ~I2S_SIX_CHANNELS;
+		break;
+	case 6:
+		i2s_ctrl |= I2S_SIX_CHANNELS;
+		break;
+	default:
+		dev_err(dai->dev, "%d channels unsupported\n", channels);
+		return -EINVAL;
+	}
+
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S8:
+		left_len = 8;
+		break;
+	case SNDRV_PCM_FORMAT_S16_LE:
+		left_len = 16;
+		break;
+	case SNDRV_PCM_FORMAT_S24_LE:
+		left_len = 24;
+		break;
+	case SNDRV_PCM_FORMAT_S32_LE:
+		left_len = 32;
+		break;
+	default:
+		dev_err(dai->dev, "Format unsupported\n");
+		return -EINVAL;
+	}
+
+	frame_len = left_len * 2;
+	i2s_ctrl &= ~(I2S_L_CHAN_LEN_MASK | I2S_FRAME_LEN_MASK);
+	/* Fill the actual len - 1 */
+	i2s_ctrl |= ((frame_len - 1) << I2S_FRAME_LEN_SHIFT)
+		| ((left_len - 1) << I2S_L_CHAN_LEN_SHIFT)
+		| (0 << I2S_MCLK_DIV_SHIFT) | (3 << I2S_BITCLK_DIV_SHIFT);
+
+	if (i2s->master) {
+		i2s_ctrl &= ~I2S_SLAVE_MODE;
+		i2s_tx_rx_ctrl |= I2S_MCLK_EN;
+		bitclk = params_rate(params) * frame_len;
+		div = i2s->src_clk_rate / bitclk;
+		/* MCLK divide-by-2 from source clk */
+		div /= 2;
+		bclk_div = div / 2 - 1;
+		i2s_ctrl |= (bclk_div << I2S_BITCLK_DIV_SHIFT);
+		/*
+		 * MCLK coefficient must set to 0, means
+		 * divide-by-two from reference clock.
+		 */
+		i2s_ctrl &= ~I2S_MCLK_DIV_MASK;
+	} else {
+		i2s_ctrl |= I2S_SLAVE_MODE;
+		i2s_tx_rx_ctrl &= ~I2S_MCLK_EN;
+	}
+
+	if (i2s->ext_clk)
+		i2s_tx_rx_ctrl |= I2S_REF_CLK_SEL_EXT;
+	else
+		i2s_tx_rx_ctrl &= ~I2S_REF_CLK_SEL_EXT;
+
+	regmap_write(i2s->regmap, AUDIO_CTRL_I2S_CTRL, i2s_ctrl);
+	regmap_write(i2s->regmap, AUDIO_CTRL_I2S_TX_RX_EN, i2s_tx_rx_ctrl);
+	regmap_update_bits(i2s->regmap, AUDIO_CTRL_MODE_SEL,
+		I2S_MODE, I2S_MODE);
+
+	return 0;
+}
+
+static int sirf_i2s_set_dai_fmt(struct snd_soc_dai *dai,
+		unsigned int fmt)
+{
+	struct sirf_i2s *i2s = snd_soc_dai_get_drvdata(dai);
+
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBM_CFM:
+		i2s->master = false;
+		break;
+	case SND_SOC_DAIFMT_CBS_CFS:
+		i2s->master = true;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* interface format */
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		break;
+	default:
+		dev_err(dai->dev, "Only I2S format supported\n");
+		return -EINVAL;
+	}
+
+	/* clock inversion */
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_NB_NF:
+		break;
+	default:
+		dev_err(dai->dev, "Only normal bit clock, normal frame clock supported\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int sirf_i2s_set_clkdiv(struct snd_soc_dai *dai, int div_id,
+	int src_rate)
+{
+	struct sirf_i2s *i2s = snd_soc_dai_get_drvdata(dai);
+
+	switch (div_id) {
+	case SIRF_I2S_EXT_CLK:
+		i2s->ext_clk = 1;
+		break;
+	case SIRF_I2S_PWM_CLK:
+		i2s->ext_clk = 0;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	i2s->src_clk_rate = src_rate;
+	return 0;
+}
+
+struct snd_soc_dai_ops sirfsoc_i2s_dai_ops = {
+	.trigger	= sirf_i2s_trigger,
+	.hw_params	= sirf_i2s_hw_params,
+	.set_fmt	= sirf_i2s_set_dai_fmt,
+	.set_clkdiv	= sirf_i2s_set_clkdiv,
+};
+
+static struct snd_soc_dai_driver sirf_i2s_dai = {
+	.probe = sirf_i2s_dai_probe,
+	.name = "sirf-i2s",
+	.id = 0,
+	.playback = {
+		.stream_name = "SiRF I2S Playback",
+		.channels_min = 2,
+		.channels_max = 6,
+		.rates = SNDRV_PCM_RATE_8000_96000,
+		.formats = SNDRV_PCM_FMTBIT_S8 |
+			SNDRV_PCM_FMTBIT_S16_LE |
+			SNDRV_PCM_FMTBIT_S24_LE |
+			SNDRV_PCM_FMTBIT_S32_LE,
+	},
+	.capture = {
+		.stream_name = "SiRF I2S Capture",
+		.channels_min = 2,
+		.channels_max = 2,
+		.rates = SNDRV_PCM_RATE_8000_96000,
+		.formats = SNDRV_PCM_FMTBIT_S8 |
+			SNDRV_PCM_FMTBIT_S16_LE |
+			SNDRV_PCM_FMTBIT_S24_LE |
+			SNDRV_PCM_FMTBIT_S32_LE,
+	},
+	.ops = &sirfsoc_i2s_dai_ops,
+};
+
+#ifdef CONFIG_PM_RUNTIME
+static int sirf_i2s_runtime_suspend(struct device *dev)
+{
+	struct sirf_i2s *i2s = dev_get_drvdata(dev);
+	clk_disable_unprepare(i2s->clk);
+
+	return 0;
+}
+
+static int sirf_i2s_runtime_resume(struct device *dev)
+{
+	struct sirf_i2s *i2s = dev_get_drvdata(dev);
+	return clk_prepare_enable(i2s->clk);
+}
+#endif
+
+#ifdef CONFIG_PM_SLEEP
+static int sirf_i2s_suspend(struct device *dev)
+{
+	struct sirf_i2s *i2s = dev_get_drvdata(dev);
+
+	if (!pm_runtime_status_suspended(dev)) {
+		regmap_read(i2s->regmap, AUDIO_CTRL_I2S_CTRL, &i2s->i2s_ctrl);
+		regmap_read(i2s->regmap, AUDIO_CTRL_I2S_TX_RX_EN,
+			&i2s->i2s_ctrl_tx_rx_en);
+		sirf_i2s_runtime_suspend(dev);
+	}
+	return 0;
+}
+
+static int sirf_i2s_resume(struct device *dev)
+{
+	struct sirf_i2s *i2s = dev_get_drvdata(dev);
+	int ret;
+	if (!pm_runtime_status_suspended(dev)) {
+		ret = sirf_i2s_runtime_resume(dev);
+		if (ret)
+			return ret;
+		regmap_update_bits(i2s->regmap, AUDIO_CTRL_MODE_SEL,
+			I2S_MODE, I2S_MODE);
+		regmap_write(i2s->regmap, AUDIO_CTRL_I2S_CTRL, i2s->i2s_ctrl);
+		/* Restore MCLK enable and reference clock select bits. */
+		i2s->i2s_ctrl_tx_rx_en &= (I2S_MCLK_EN | I2S_REF_CLK_SEL_EXT);
+		regmap_write(i2s->regmap, AUDIO_CTRL_I2S_TX_RX_EN,
+			i2s->i2s_ctrl_tx_rx_en);
+
+		regmap_write(i2s->regmap, AUDIO_CTRL_I2S_TXFIFO_INT_MSK, 0);
+		regmap_write(i2s->regmap, AUDIO_CTRL_I2S_RXFIFO_INT_MSK, 0);
+	}
+
+	return 0;
+}
+#endif
+
+static const struct snd_soc_component_driver sirf_i2s_component = {
+	.name       = "sirf-i2s",
+};
+
+static const struct regmap_config sirf_i2s_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = AUDIO_CTRL_I2S_RXFIFO_INT_MSK,
+	.cache_type = REGCACHE_NONE,
+};
+
+static int sirf_i2s_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct sirf_i2s *i2s;
+	void __iomem *base;
+	struct resource *mem_res;
+
+	i2s = devm_kzalloc(&pdev->dev, sizeof(struct sirf_i2s),
+			GFP_KERNEL);
+	if (!i2s)
+		return -ENOMEM;
+
+	mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!mem_res) {
+		dev_err(&pdev->dev, "no mem resource?\n");
+		return -ENODEV;
+	}
+
+	base = devm_ioremap(&pdev->dev, mem_res->start,
+		resource_size(mem_res));
+	if (base == NULL)
+		return -ENOMEM;
+
+	i2s->regmap = devm_regmap_init_mmio(&pdev->dev, base,
+					    &sirf_i2s_regmap_config);
+	if (IS_ERR(i2s->regmap))
+		return PTR_ERR(i2s->regmap);
+
+	i2s->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(i2s->clk)) {
+		dev_err(&pdev->dev, "Get clock failed.\n");
+		ret = PTR_ERR(i2s->clk);
+		return ret;
+	}
+
+	pm_runtime_enable(&pdev->dev);
+
+	ret = devm_snd_soc_register_component(&pdev->dev, &sirf_i2s_component,
+			&sirf_i2s_dai, 1);
+	if (ret) {
+		dev_err(&pdev->dev, "Register Audio SoC dai failed.\n");
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, i2s);
+	return devm_snd_dmaengine_pcm_register(&pdev->dev, NULL, 0);
+}
+
+static int sirf_i2s_remove(struct platform_device *pdev)
+{
+	pm_runtime_disable(&pdev->dev);
+	return 0;
+}
+
+static const struct of_device_id sirf_i2s_of_match[] = {
+	{ .compatible = "sirf,prima2-i2s", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, sirf_i2s_of_match);
+
+static const struct dev_pm_ops sirf_i2s_pm_ops = {
+	SET_RUNTIME_PM_OPS(sirf_i2s_runtime_suspend, sirf_i2s_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(sirf_i2s_suspend, sirf_i2s_resume)
+};
+
+static struct platform_driver sirf_i2s_driver = {
+	.driver = {
+		.name = "sirf-i2s",
+		.owner = THIS_MODULE,
+		.of_match_table = sirf_i2s_of_match,
+		.pm = &sirf_i2s_pm_ops,
+	},
+	.probe = sirf_i2s_probe,
+	.remove = sirf_i2s_remove,
+};
+
+module_platform_driver(sirf_i2s_driver);
+
+MODULE_DESCRIPTION("SiRF SoC I2S driver");
+MODULE_AUTHOR("RongJun Ying <Rongjun.Ying@csr.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/sirf/sirf-i2s.h b/sound/soc/sirf/sirf-i2s.h
new file mode 100644
index 0000000..3879fe5
--- /dev/null
+++ b/sound/soc/sirf/sirf-i2s.h
@@ -0,0 +1,88 @@
+/*
+ * SiRF I2S controllers define
+ *
+ * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+#ifndef _SIRF_I2S_H
+#define _SIRF_I2S_H
+
+#define AUDIO_CTRL_TX_FIFO_LEVEL_CHECK_MASK     0x3F
+#define AUDIO_CTRL_TX_FIFO_SC_OFFSET    0
+#define AUDIO_CTRL_TX_FIFO_LC_OFFSET    10
+#define AUDIO_CTRL_TX_FIFO_HC_OFFSET    20
+
+#define TX_FIFO_SC(x)           (((x) & AUDIO_CTRL_TX_FIFO_LEVEL_CHECK_MASK) \
+				<< AUDIO_CTRL_TX_FIFO_SC_OFFSET)
+#define TX_FIFO_LC(x)           (((x) & AUDIO_CTRL_TX_FIFO_LEVEL_CHECK_MASK) \
+				<< AUDIO_CTRL_TX_FIFO_LC_OFFSET)
+#define TX_FIFO_HC(x)           (((x) & AUDIO_CTRL_TX_FIFO_LEVEL_CHECK_MASK) \
+				<< AUDIO_CTRL_TX_FIFO_HC_OFFSET)
+
+#define AUDIO_CTRL_RX_FIFO_LEVEL_CHECK_MASK     0x0F
+#define AUDIO_CTRL_RX_FIFO_SC_OFFSET    0
+#define AUDIO_CTRL_RX_FIFO_LC_OFFSET    10
+#define AUDIO_CTRL_RX_FIFO_HC_OFFSET    20
+
+#define RX_FIFO_SC(x)           (((x) & AUDIO_CTRL_RX_FIFO_LEVEL_CHECK_MASK) \
+				<< AUDIO_CTRL_RX_FIFO_SC_OFFSET)
+#define RX_FIFO_LC(x)           (((x) & AUDIO_CTRL_RX_FIFO_LEVEL_CHECK_MASK) \
+				<< AUDIO_CTRL_RX_FIFO_LC_OFFSET)
+#define RX_FIFO_HC(x)           (((x) & AUDIO_CTRL_RX_FIFO_LEVEL_CHECK_MASK) \
+				<< AUDIO_CTRL_RX_FIFO_HC_OFFSET)
+
+#define AUDIO_CTRL_MODE_SEL			(0x0000)
+#define AUDIO_CTRL_I2S_CTRL			(0x0020)
+#define AUDIO_CTRL_I2S_TX_RX_EN			(0x0024)
+
+#define AUDIO_CTRL_I2S_TXFIFO_OP		(0x0040)
+#define AUDIO_CTRL_I2S_TXFIFO_LEV_CHK		(0x0044)
+#define AUDIO_CTRL_I2S_TXFIFO_STS		(0x0048)
+#define AUDIO_CTRL_I2S_TXFIFO_INT		(0x004C)
+#define AUDIO_CTRL_I2S_TXFIFO_INT_MSK		(0x0050)
+
+#define AUDIO_CTRL_I2S_RXFIFO_OP		(0x00B8)
+#define AUDIO_CTRL_I2S_RXFIFO_LEV_CHK		(0x00BC)
+#define AUDIO_CTRL_I2S_RXFIFO_STS		(0x00C0)
+#define AUDIO_CTRL_I2S_RXFIFO_INT		(0x00C4)
+#define AUDIO_CTRL_I2S_RXFIFO_INT_MSK		(0x00C8)
+
+#define I2S_MODE				(1<<0)
+
+#define I2S_LOOP_BACK				(1<<3)
+#define	I2S_MCLK_DIV_SHIFT			15
+#define I2S_MCLK_DIV_MASK			(0x1FF<<I2S_MCLK_DIV_SHIFT)
+#define I2S_BITCLK_DIV_SHIFT			24
+#define I2S_BITCLK_DIV_MASK			(0xFF<<I2S_BITCLK_DIV_SHIFT)
+
+#define I2S_MCLK_EN				(1<<2)
+#define I2S_REF_CLK_SEL_EXT			(1<<3)
+#define I2S_DOUT_OE				(1<<4)
+#define i2s_R2X_LP_TO_TX0			(1<<30)
+#define i2s_R2X_LP_TO_TX1			(2<<30)
+#define i2s_R2X_LP_TO_TX2			(3<<30)
+
+#define AUDIO_FIFO_START		(1 << 0)
+#define AUDIO_FIFO_RESET		(1 << 1)
+
+#define AUDIO_FIFO_FULL			(1 << 0)
+#define AUDIO_FIFO_EMPTY		(1 << 1)
+#define AUDIO_FIFO_OFLOW		(1 << 2)
+#define AUDIO_FIFO_UFLOW		(1 << 3)
+
+#define I2S_RX_ENABLE			(1 << 0)
+#define I2S_TX_ENABLE			(1 << 1)
+
+/* Codec I2S Control Register defines */
+#define I2S_SLAVE_MODE			(1 << 0)
+#define I2S_SIX_CHANNELS		(1 << 1)
+#define I2S_L_CHAN_LEN_SHIFT		(4)
+#define I2S_L_CHAN_LEN_MASK		(0x1f << I2S_L_CHAN_LEN_SHIFT)
+#define I2S_FRAME_LEN_SHIFT		(9)
+#define I2S_FRAME_LEN_MASK		(0x3f << I2S_FRAME_LEN_SHIFT)
+
+#define SIRF_I2S_EXT_CLK	0x0
+#define SIRF_I2S_PWM_CLK	0x1
+#endif /*__SIRF_I2S_H*/
-- 
1.7.5.4
