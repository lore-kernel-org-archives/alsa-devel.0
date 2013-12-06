From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 2/4] ASoC: Add support for the Analog
	Devices AXI-I2S core
Date: Fri,  6 Dec 2013 11:02:50 +0100
Message-ID: <1386324172-15609-2-git-send-email-lars@metafoo.de>
References: <1386324172-15609-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-151.synserver.de (smtp-out-159.synserver.de
 [212.40.185.159])
 by alsa0.perex.cz (Postfix) with ESMTP id E7E5C2655AA
 for <alsa-devel@alsa-project.org>; Fri,  6 Dec 2013 11:02:43 +0100 (CET)
In-Reply-To: <1386324172-15609-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

This patch adds support for the AXI-I2S softcore. The core implements a simple
bidirectional I2S transceiver and is used by Analog Devices in some of their
reference designs for various FPGA platforms.

The driver uses the generic PCM dmaengine driver for its PCM. The only
restriction is that we need to set the SND_DMAENGINE_PCM_FLAG_NO_RESIDUE flag as
the dmaengine driver for the DMA core (PL330) that is used with this core has no
residue reporting capabilities yet. This will be fixed in the future though.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

---
Changes since v1:
	* Remove explicit dependency on SND_SOC since there already is an implicit
	  one.
	* Added clarifications on the programable I2S word width that is currently
	  hardcoded to 32
---
 sound/soc/Kconfig       |   1 +
 sound/soc/Makefile      |   1 +
 sound/soc/adi/Kconfig   |  13 +++
 sound/soc/adi/Makefile  |   3 +
 sound/soc/adi/axi-i2s.c | 277 ++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 295 insertions(+)
 create mode 100644 sound/soc/adi/Kconfig
 create mode 100644 sound/soc/adi/Makefile
 create mode 100644 sound/soc/adi/axi-i2s.c

diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
index a5dcdec..d62ce48 100644
--- a/sound/soc/Kconfig
+++ b/sound/soc/Kconfig
@@ -31,6 +31,7 @@ config SND_SOC_GENERIC_DMAENGINE_PCM
 	select SND_DMAENGINE_PCM
 
 # All the supported SoCs
+source "sound/soc/adi/Kconfig"
 source "sound/soc/atmel/Kconfig"
 source "sound/soc/au1x/Kconfig"
 source "sound/soc/bcm/Kconfig"
diff --git a/sound/soc/Makefile b/sound/soc/Makefile
index bf32b7a..62a1822 100644
--- a/sound/soc/Makefile
+++ b/sound/soc/Makefile
@@ -8,6 +8,7 @@ endif
 obj-$(CONFIG_SND_SOC)	+= snd-soc-core.o
 obj-$(CONFIG_SND_SOC)	+= codecs/
 obj-$(CONFIG_SND_SOC)	+= generic/
+obj-$(CONFIG_SND_SOC)	+= adi/
 obj-$(CONFIG_SND_SOC)	+= atmel/
 obj-$(CONFIG_SND_SOC)	+= au1x/
 obj-$(CONFIG_SND_SOC)	+= bcm/
diff --git a/sound/soc/adi/Kconfig b/sound/soc/adi/Kconfig
new file mode 100644
index 0000000..46f4b79
--- /dev/null
+++ b/sound/soc/adi/Kconfig
@@ -0,0 +1,13 @@
+config SND_SOC_ADI
+	tristate "Audio support for Analog Devices reference designs"
+	depends on MICROBLAZE || ARCH_ZYNQ || COMPILE_TEST
+	help
+	  Audio support for various reference designs by Analog Devices.
+
+config SND_SOC_ADI_AXI_I2S
+	tristate "AXI-I2S support"
+	depends on SND_SOC_ADI
+	select SND_SOC_GENERIC_DMAENGINE_PCM
+	select REGMAP_MMIO
+	help
+	  ASoC driver for the Analog Devices AXI-I2S softcore peripheral.
diff --git a/sound/soc/adi/Makefile b/sound/soc/adi/Makefile
new file mode 100644
index 0000000..d32c21a
--- /dev/null
+++ b/sound/soc/adi/Makefile
@@ -0,0 +1,3 @@
+snd-soc-adi-axi-i2s-objs := axi-i2s.o
+
+obj-$(CONFIG_SND_SOC_ADI_AXI_I2S) += snd-soc-adi-axi-i2s.o
diff --git a/sound/soc/adi/axi-i2s.c b/sound/soc/adi/axi-i2s.c
new file mode 100644
index 0000000..0822c77
--- /dev/null
+++ b/sound/soc/adi/axi-i2s.c
@@ -0,0 +1,277 @@
+/*
+ * Copyright (C) 2012-2013, Analog Devices Inc.
+ * Author: Lars-Peter Clausen <lars@metafoo.de>
+ *
+ * Licensed under the GPL-2.
+ */
+
+#include <linux/clk.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/dmaengine_pcm.h>
+
+#define AXI_I2S_REG_RESET	0x00
+#define AXI_I2S_REG_CTRL	0x04
+#define AXI_I2S_REG_CLK_CTRL	0x08
+#define AXI_I2S_REG_STATUS	0x10
+
+#define AXI_I2S_REG_RX_FIFO	0x28
+#define AXI_I2S_REG_TX_FIFO	0x2C
+
+#define AXI_I2S_RESET_GLOBAL	BIT(0)
+#define AXI_I2S_RESET_TX_FIFO	BIT(1)
+#define AXI_I2S_RESET_RX_FIFO	BIT(2)
+
+#define AXI_I2S_CTRL_TX_EN	BIT(0)
+#define AXI_I2S_CTRL_RX_EN	BIT(1)
+
+/* The frame size is configurable, but for now we always set it 64 bit */
+#define AXI_I2S_BITS_PER_FRAME 64
+
+struct axi_i2s {
+	struct regmap *regmap;
+	struct clk *clk;
+	struct clk *clk_ref;
+
+	struct snd_soc_dai_driver dai_driver;
+
+	struct snd_dmaengine_dai_dma_data capture_dma_data;
+	struct snd_dmaengine_dai_dma_data playback_dma_data;
+
+	struct snd_ratnum ratnum;
+	struct snd_pcm_hw_constraint_ratnums rate_constraints;
+};
+
+static int axi_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
+	struct snd_soc_dai *dai)
+{
+	struct axi_i2s *i2s = snd_soc_dai_get_drvdata(dai);
+	unsigned int mask, val;
+
+	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
+		mask = AXI_I2S_CTRL_RX_EN;
+	else
+		mask = AXI_I2S_CTRL_TX_EN;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		val = mask;
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		val = 0;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	regmap_update_bits(i2s->regmap, AXI_I2S_REG_CTRL, mask, val);
+
+	return 0;
+}
+
+static int axi_i2s_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
+{
+	struct axi_i2s *i2s = snd_soc_dai_get_drvdata(dai);
+	unsigned int bclk_div, word_size;
+	unsigned int bclk_rate;
+
+	bclk_rate = params_rate(params) * AXI_I2S_BITS_PER_FRAME;
+
+	word_size = AXI_I2S_BITS_PER_FRAME / 2 - 1;
+	bclk_div = DIV_ROUND_UP(clk_get_rate(i2s->clk_ref), bclk_rate) / 2 - 1;
+
+	regmap_write(i2s->regmap, AXI_I2S_REG_CLK_CTRL, (word_size << 16) |
+		bclk_div);
+
+	return 0;
+}
+
+static int axi_i2s_startup(struct snd_pcm_substream *substream,
+	struct snd_soc_dai *dai)
+{
+	struct axi_i2s *i2s = snd_soc_dai_get_drvdata(dai);
+	uint32_t mask;
+	int ret;
+
+	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
+		mask = AXI_I2S_RESET_RX_FIFO;
+	else
+		mask = AXI_I2S_RESET_TX_FIFO;
+
+	regmap_write(i2s->regmap, AXI_I2S_REG_RESET, mask);
+
+	ret = snd_pcm_hw_constraint_ratnums(substream->runtime, 0,
+			   SNDRV_PCM_HW_PARAM_RATE,
+			   &i2s->rate_constraints);
+	if (ret)
+		return ret;
+
+	return clk_prepare_enable(i2s->clk_ref);
+}
+
+static void axi_i2s_shutdown(struct snd_pcm_substream *substream,
+	struct snd_soc_dai *dai)
+{
+	struct axi_i2s *i2s = snd_soc_dai_get_drvdata(dai);
+
+	clk_disable_unprepare(i2s->clk_ref);
+}
+
+static int axi_i2s_dai_probe(struct snd_soc_dai *dai)
+{
+	struct axi_i2s *i2s = snd_soc_dai_get_drvdata(dai);
+
+	snd_soc_dai_init_dma_data(dai, &i2s->playback_dma_data,
+		&i2s->capture_dma_data);
+
+	return 0;
+}
+
+static const struct snd_soc_dai_ops axi_i2s_dai_ops = {
+	.startup = axi_i2s_startup,
+	.shutdown = axi_i2s_shutdown,
+	.trigger = axi_i2s_trigger,
+	.hw_params = axi_i2s_hw_params,
+};
+
+static struct snd_soc_dai_driver axi_i2s_dai = {
+	.probe = axi_i2s_dai_probe,
+	.playback = {
+		.channels_min = 2,
+		.channels_max = 2,
+		.rates = SNDRV_PCM_RATE_KNOT,
+		.formats = SNDRV_PCM_FMTBIT_S32_LE | SNDRV_PCM_FMTBIT_U32_LE,
+	},
+	.capture = {
+		.channels_min = 2,
+		.channels_max = 2,
+		.rates = SNDRV_PCM_RATE_KNOT,
+		.formats = SNDRV_PCM_FMTBIT_S32_LE | SNDRV_PCM_FMTBIT_U32_LE,
+	},
+	.ops = &axi_i2s_dai_ops,
+	.symmetric_rates = 1,
+};
+
+static const struct snd_soc_component_driver axi_i2s_component = {
+	.name = "axi-i2s",
+};
+
+static const struct regmap_config axi_i2s_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = AXI_I2S_REG_STATUS,
+};
+
+static int axi_i2s_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+	struct axi_i2s *i2s;
+	void __iomem *base;
+	int ret;
+
+	i2s = devm_kzalloc(&pdev->dev, sizeof(*i2s), GFP_KERNEL);
+	if (!i2s)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, i2s);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	base = devm_request_and_ioremap(&pdev->dev, res);
+	if (!base)
+		return -EBUSY;
+
+	i2s->regmap = devm_regmap_init_mmio(&pdev->dev, base,
+		&axi_i2s_regmap_config);
+	if (IS_ERR(i2s->regmap))
+		return PTR_ERR(i2s->regmap);
+
+	i2s->clk = devm_clk_get(&pdev->dev, "axi");
+	if (IS_ERR(i2s->clk))
+		return PTR_ERR(i2s->clk);
+
+	i2s->clk_ref = devm_clk_get(&pdev->dev, "ref");
+	if (IS_ERR(i2s->clk_ref))
+		return PTR_ERR(i2s->clk_ref);
+
+	ret = clk_prepare_enable(i2s->clk);
+	if (ret)
+		return ret;
+
+	i2s->playback_dma_data.addr = res->start + AXI_I2S_REG_TX_FIFO;
+	i2s->playback_dma_data.addr_width = 4;
+	i2s->playback_dma_data.maxburst = 1;
+
+	i2s->capture_dma_data.addr = res->start + AXI_I2S_REG_RX_FIFO;
+	i2s->capture_dma_data.addr_width = 4;
+	i2s->capture_dma_data.maxburst = 1;
+
+	i2s->ratnum.num = clk_get_rate(i2s->clk_ref) / 2 / AXI_I2S_BITS_PER_FRAME;
+	i2s->ratnum.den_step = 1;
+	i2s->ratnum.den_min = 1;
+	i2s->ratnum.den_max = 64;
+
+	i2s->rate_constraints.rats = &i2s->ratnum;
+	i2s->rate_constraints.nrats = 1;
+
+	regmap_write(i2s->regmap, AXI_I2S_REG_RESET, AXI_I2S_RESET_GLOBAL);
+
+	ret = devm_snd_soc_register_component(&pdev->dev, &axi_i2s_component,
+					 &axi_i2s_dai, 1);
+	if (ret)
+		goto err_clk_disable;
+
+	ret = devm_snd_dmaengine_pcm_register(&pdev->dev, NULL,
+			SND_DMAENGINE_PCM_FLAG_NO_RESIDUE);
+	if (ret)
+		goto err_clk_disable;
+
+err_clk_disable:
+	clk_disable_unprepare(i2s->clk);
+	return ret;
+}
+
+static int axi_i2s_dev_remove(struct platform_device *pdev)
+{
+	struct axi_i2s *i2s = platform_get_drvdata(pdev);
+
+	clk_disable_unprepare(i2s->clk);
+
+	return 0;
+}
+
+static const struct of_device_id axi_i2s_of_match[] = {
+	{ .compatible = "adi,axi-i2s-1.00.a", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, axi_i2s_of_match);
+
+static struct platform_driver axi_i2s_driver = {
+	.driver = {
+		.name = "axi-i2s",
+		.owner = THIS_MODULE,
+		.of_match_table = axi_i2s_of_match,
+	},
+	.probe = axi_i2s_probe,
+	.remove = axi_i2s_dev_remove,
+};
+module_platform_driver(axi_i2s_driver);
+
+MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
+MODULE_DESCRIPTION("AXI I2S driver");
+MODULE_LICENSE("GPL");
-- 
1.8.0
