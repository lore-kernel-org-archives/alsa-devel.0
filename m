From: Rajeev Kumar <rajeev-dlh.kumar@st.com>
Subject: [PATCH V2 3/9] sound:asoc: Add support for synopsys
	i2s controller as per ASoC framework.
Date: Thu, 21 Jun 2012 15:54:51 +0530
Message-ID: <d7aae7f0d84a69e58b2ed22b45b8d93eff05c25e.1340273261.git.rajeev-dlh.kumar@st.com>
References: <cover.1340273261.git.rajeev-dlh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog106.obsmtp.com (eu1sys200aog106.obsmtp.com
	[207.126.144.121])
	by alsa0.perex.cz (Postfix) with ESMTP id A6A1E10B976
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Jun 2012 11:04:05 +0200 (CEST)
In-Reply-To: <cover.1340273261.git.rajeev-dlh.kumar@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, broonie@opensource.wolfsonmicro.com, perex@perex.cz
Cc: alsa-devel@alsa-project.org, Rajeev Kumar <rajeev-dlh.kumar@st.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

This patch add support for synopsys I2S controller as per the ASoC
framework.

Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
---
 include/sound/designware_i2s.h |   69 ++++++
 sound/soc/Kconfig              |    1 +
 sound/soc/Makefile             |    1 +
 sound/soc/dwc/Kconfig          |    8 +
 sound/soc/dwc/Makefile         |    3 +
 sound/soc/dwc/designware_i2s.c |  454 ++++++++++++++++++++++++++++++++++++++++
 6 files changed, 536 insertions(+), 0 deletions(-)
 create mode 100644 include/sound/designware_i2s.h
 create mode 100644 sound/soc/dwc/Kconfig
 create mode 100644 sound/soc/dwc/Makefile
 create mode 100644 sound/soc/dwc/designware_i2s.c

diff --git a/include/sound/designware_i2s.h b/include/sound/designware_i2s.h
new file mode 100644
index 0000000..26f406e
--- /dev/null
+++ b/include/sound/designware_i2s.h
@@ -0,0 +1,69 @@
+/*
+ * Copyright (ST) 2012 Rajeev Kumar (rajeev-dlh.kumar@st.com)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ *
+ */
+
+#ifndef __SOUND_DESIGNWARE_I2S_H
+#define __SOUND_DESIGNWARE_I2S_H
+
+#include <linux/dmaengine.h>
+#include <linux/types.h>
+
+/*
+ * struct i2s_clk_config_data - represent i2s clk configuration data
+ * @chan_nr: number of channel
+ * @data_width: number of bits per sample (8/16/24/32 bit)
+ * @sample_rate: sampling frequency (8Khz, 16Khz, 32Khz, 44Khz, 48Khz)
+ */
+struct i2s_clk_config_data {
+	int chan_nr;
+	u32 data_width;
+	u32 sample_rate;
+};
+
+struct i2s_platform_data {
+	#define DWC_I2S_PLAY	(1 << 0)
+	#define DWC_I2S_RECORD	(1 << 1)
+	unsigned int cap;
+	int channel;
+	u32 snd_fmts;
+	u32 snd_rates;
+
+	void *play_dma_data;
+	void *capture_dma_data;
+	bool (*filter)(struct dma_chan *chan, void *slave);
+	int (*i2s_clk_cfg)(struct i2s_clk_config_data *config);
+};
+
+struct i2s_dma_data {
+	void *data;
+	dma_addr_t addr;
+	u32 max_burst;
+	enum dma_slave_buswidth addr_width;
+	bool (*filter)(struct dma_chan *chan, void *slave);
+};
+
+/* I2S DMA registers */
+#define I2S_RXDMA		0x01C0
+#define I2S_TXDMA		0x01C8
+
+#define TWO_CHANNEL_SUPPORT	2	/* up to 2.0 */
+#define FOUR_CHANNEL_SUPPORT	4	/* up to 3.1 */
+#define SIX_CHANNEL_SUPPORT	6	/* up to 5.1 */
+#define EIGHT_CHANNEL_SUPPORT	8	/* up to 7.1 */
+
+#endif /*  __SOUND_DESIGNWARE_I2S_H */
diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
index 40b2ad1..c5de0a8 100644
--- a/sound/soc/Kconfig
+++ b/sound/soc/Kconfig
@@ -33,6 +33,7 @@ source "sound/soc/atmel/Kconfig"
 source "sound/soc/au1x/Kconfig"
 source "sound/soc/blackfin/Kconfig"
 source "sound/soc/davinci/Kconfig"
+source "sound/soc/dwc/Kconfig"
 source "sound/soc/ep93xx/Kconfig"
 source "sound/soc/fsl/Kconfig"
 source "sound/soc/jz4740/Kconfig"
diff --git a/sound/soc/Makefile b/sound/soc/Makefile
index 70990f4..00a555a 100644
--- a/sound/soc/Makefile
+++ b/sound/soc/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_SND_SOC)	+= atmel/
 obj-$(CONFIG_SND_SOC)	+= au1x/
 obj-$(CONFIG_SND_SOC)	+= blackfin/
 obj-$(CONFIG_SND_SOC)	+= davinci/
+obj-$(CONFIG_SND_SOC)	+= dwc/
 obj-$(CONFIG_SND_SOC)	+= ep93xx/
 obj-$(CONFIG_SND_SOC)	+= fsl/
 obj-$(CONFIG_SND_SOC)	+= jz4740/
diff --git a/sound/soc/dwc/Kconfig b/sound/soc/dwc/Kconfig
new file mode 100644
index 0000000..93e9fc3
--- /dev/null
+++ b/sound/soc/dwc/Kconfig
@@ -0,0 +1,8 @@
+config SND_DESIGNWARE_I2S
+	tristate "Synopsys I2S Device Driver"
+	help
+	 Say Y or M if you want to add support for I2S driver for
+	 Synopsys desigwnware I2S device. The device supports upto
+	 maximum of 8 channels each for play and record.
+
+
diff --git a/sound/soc/dwc/Makefile b/sound/soc/dwc/Makefile
new file mode 100644
index 0000000..319371f
--- /dev/null
+++ b/sound/soc/dwc/Makefile
@@ -0,0 +1,3 @@
+# SYNOPSYS Platform Support
+obj-$(CONFIG_SND_DESIGNWARE_I2S) += designware_i2s.o
+
diff --git a/sound/soc/dwc/designware_i2s.c b/sound/soc/dwc/designware_i2s.c
new file mode 100644
index 0000000..e667e2b
--- /dev/null
+++ b/sound/soc/dwc/designware_i2s.c
@@ -0,0 +1,454 @@
+/*
+ * ALSA SoC Synopsys I2S Audio Layer
+ *
+ * sound/soc/spear/designware_i2s.c
+ *
+ * Copyright (C) 2010 ST Microelectronics
+ * Rajeev Kumar <rajeev-dlh.kumar@st.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <sound/designware_i2s.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+
+/* common register for all channel */
+#define IER		0x000
+#define IRER		0x004
+#define ITER		0x008
+#define CER		0x00C
+#define CCR		0x010
+#define RXFFR		0x014
+#define TXFFR		0x018
+
+/* I2STxRxRegisters for all channels */
+#define LRBR_LTHR(x)	(0x40 * x + 0x020)
+#define RRBR_RTHR(x)	(0x40 * x + 0x024)
+#define RER(x)		(0x40 * x + 0x028)
+#define TER(x)		(0x40 * x + 0x02C)
+#define RCR(x)		(0x40 * x + 0x030)
+#define TCR(x)		(0x40 * x + 0x034)
+#define ISR(x)		(0x40 * x + 0x038)
+#define IMR(x)		(0x40 * x + 0x03C)
+#define ROR(x)		(0x40 * x + 0x040)
+#define TOR(x)		(0x40 * x + 0x044)
+#define RFCR(x)		(0x40 * x + 0x048)
+#define TFCR(x)		(0x40 * x + 0x04C)
+#define RFF(x)		(0x40 * x + 0x050)
+#define TFF(x)		(0x40 * x + 0x054)
+
+/* I2SCOMPRegisters */
+#define I2S_COMP_PARAM_2	0x01F0
+#define I2S_COMP_PARAM_1	0x01F4
+#define I2S_COMP_VERSION	0x01F8
+#define I2S_COMP_TYPE		0x01FC
+
+#define MAX_CHANNEL_NUM		8
+#define MIN_CHANNEL_NUM		2
+
+struct dw_i2s_dev {
+	void __iomem *i2s_base;
+	struct clk *clk;
+	int active;
+	unsigned int capability;
+	struct device *dev;
+
+	/* data related to DMA transfers b/w i2s and DMAC */
+	struct i2s_dma_data play_dma_data;
+	struct i2s_dma_data capture_dma_data;
+	struct i2s_clk_config_data config;
+	int (*i2s_clk_cfg)(struct i2s_clk_config_data *config);
+};
+
+static inline void i2s_write_reg(void *io_base, int reg, u32 val)
+{
+	writel(val, io_base + reg);
+}
+
+static inline u32 i2s_read_reg(void *io_base, int reg)
+{
+	return readl(io_base + reg);
+}
+
+static inline void i2s_disable_channels(struct dw_i2s_dev *dev, u32 stream)
+{
+	u32 i = 0;
+
+	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		for (i = 0; i < 4; i++)
+			i2s_write_reg(dev->i2s_base, TER(i), 0);
+	} else {
+		for (i = 0; i < 4; i++)
+			i2s_write_reg(dev->i2s_base, RER(i), 0);
+	}
+}
+
+static inline void i2s_clear_irqs(struct dw_i2s_dev *dev, u32 stream)
+{
+	u32 i = 0;
+
+	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		for (i = 0; i < 4; i++)
+			i2s_write_reg(dev->i2s_base, TOR(i), 0);
+	} else {
+		for (i = 0; i < 4; i++)
+			i2s_write_reg(dev->i2s_base, ROR(i), 0);
+	}
+}
+
+void i2s_start(struct dw_i2s_dev *dev, struct snd_pcm_substream *substream)
+{
+
+	i2s_write_reg(dev->i2s_base, IER, 1);
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		i2s_write_reg(dev->i2s_base, ITER, 1);
+	else
+		i2s_write_reg(dev->i2s_base, IRER, 1);
+
+	i2s_write_reg(dev->i2s_base, CER, 1);
+}
+
+static void i2s_stop(struct dw_i2s_dev *dev,
+		struct snd_pcm_substream *substream)
+{
+	u32 i = 0, irq;
+
+	i2s_clear_irqs(dev, substream->stream);
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		i2s_write_reg(dev->i2s_base, ITER, 0);
+
+		for (i = 0; i < 4; i++) {
+			irq = i2s_read_reg(dev->i2s_base, IMR(i));
+			i2s_write_reg(dev->i2s_base, IMR(i), irq | 0x30);
+		}
+	} else {
+		i2s_write_reg(dev->i2s_base, IRER, 0);
+
+		for (i = 0; i < 4; i++) {
+			irq = i2s_read_reg(dev->i2s_base, IMR(i));
+			i2s_write_reg(dev->i2s_base, IMR(i), irq | 0x03);
+		}
+	}
+
+	if (!dev->active) {
+		i2s_write_reg(dev->i2s_base, CER, 0);
+		i2s_write_reg(dev->i2s_base, IER, 0);
+	}
+}
+
+static int dw_i2s_startup(struct snd_pcm_substream *substream,
+		struct snd_soc_dai *cpu_dai)
+{
+	struct dw_i2s_dev *dev = snd_soc_dai_get_drvdata(cpu_dai);
+	struct i2s_dma_data *dma_data = NULL;
+
+	if (!(dev->capability & DWC_I2S_RECORD) &&
+			(substream->stream == SNDRV_PCM_STREAM_CAPTURE))
+		return -EINVAL;
+
+	if (!(dev->capability & DWC_I2S_PLAY) &&
+			(substream->stream == SNDRV_PCM_STREAM_PLAYBACK))
+		return -EINVAL;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		dma_data = &dev->play_dma_data;
+	else if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
+		dma_data = &dev->capture_dma_data;
+
+	snd_soc_dai_set_dma_data(cpu_dai, substream, (void *)dma_data);
+
+	return 0;
+}
+
+static int dw_i2s_hw_params(struct snd_pcm_substream *substream,
+		struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
+{
+	struct dw_i2s_dev *dev = snd_soc_dai_get_drvdata(dai);
+	struct i2s_clk_config_data *config = &dev->config;
+	u32 ccr, xfer_resolution, ch_reg, irq;
+	int ret;
+
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+		config->data_width = 16;
+		ccr = 0x00;
+		xfer_resolution = 0x02;
+		break;
+
+	case SNDRV_PCM_FORMAT_S24_LE:
+		config->data_width = 24;
+		ccr = 0x08;
+		xfer_resolution = 0x04;
+		break;
+
+	case SNDRV_PCM_FORMAT_S32_LE:
+		config->data_width = 32;
+		ccr = 0x10;
+		xfer_resolution = 0x05;
+		break;
+
+	default:
+		dev_err(dev->dev, "designware-i2s: unsuppted PCM fmt");
+		return -EINVAL;
+	}
+
+	config->chan_nr = params_channels(params);
+
+	switch (config->chan_nr) {
+	case EIGHT_CHANNEL_SUPPORT:
+		ch_reg = 3;
+	case SIX_CHANNEL_SUPPORT:
+		ch_reg = 2;
+	case FOUR_CHANNEL_SUPPORT:
+		ch_reg = 1;
+	case TWO_CHANNEL_SUPPORT:
+		ch_reg = 0;
+		break;
+	default:
+		dev_err(dev->dev, "channel not supported\n");
+	}
+
+	i2s_disable_channels(dev, substream->stream);
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		i2s_write_reg(dev->i2s_base, TCR(ch_reg), xfer_resolution);
+		i2s_write_reg(dev->i2s_base, TFCR(ch_reg), 0x02);
+		irq = i2s_read_reg(dev->i2s_base, IMR(ch_reg));
+		i2s_write_reg(dev->i2s_base, IMR(ch_reg), irq & ~0x30);
+		i2s_write_reg(dev->i2s_base, TER(ch_reg), 1);
+	} else {
+		i2s_write_reg(dev->i2s_base, RCR(ch_reg), xfer_resolution);
+		i2s_write_reg(dev->i2s_base, RFCR(ch_reg), 0x07);
+		irq = i2s_read_reg(dev->i2s_base, IMR(ch_reg));
+		i2s_write_reg(dev->i2s_base, IMR(ch_reg), irq & ~0x03);
+		i2s_write_reg(dev->i2s_base, RER(ch_reg), 1);
+	}
+
+	i2s_write_reg(dev->i2s_base, CCR, ccr);
+
+	config->sample_rate = params_rate(params);
+
+	if (!dev->i2s_clk_cfg)
+		return -EINVAL;
+
+	ret = dev->i2s_clk_cfg(config);
+	if (ret < 0) {
+		dev_err(dev->dev, "runtime audio clk config fail\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static void dw_i2s_shutdown(struct snd_pcm_substream *substream,
+		struct snd_soc_dai *dai)
+{
+	snd_soc_dai_set_dma_data(dai, substream, NULL);
+}
+
+static int dw_i2s_trigger(struct snd_pcm_substream *substream,
+		int cmd, struct snd_soc_dai *dai)
+{
+	struct dw_i2s_dev *dev = snd_soc_dai_get_drvdata(dai);
+	int ret = 0;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		dev->active++;
+		i2s_start(dev, substream);
+		break;
+
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		dev->active--;
+		i2s_stop(dev, substream);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+	return ret;
+}
+
+static struct snd_soc_dai_ops dw_i2s_dai_ops = {
+	.startup	= dw_i2s_startup,
+	.shutdown	= dw_i2s_shutdown,
+	.hw_params	= dw_i2s_hw_params,
+	.trigger	= dw_i2s_trigger,
+};
+
+#ifdef CONFIG_PM
+
+static int dw_i2s_suspend(struct snd_soc_dai *dai)
+{
+	struct dw_i2s_dev *dev = snd_soc_dai_get_drvdata(dai);
+
+	clk_disable(dev->clk);
+	return 0;
+}
+
+static int dw_i2s_resume(struct snd_soc_dai *dai)
+{
+	struct dw_i2s_dev *dev = snd_soc_dai_get_drvdata(dai);
+
+	clk_enable(dev->clk);
+	return 0;
+}
+
+#else
+#define dw_i2s_suspend	NULL
+#define dw_i2s_resume	NULL
+#endif
+
+static int dw_i2s_probe(struct platform_device *pdev)
+{
+	const struct i2s_platform_data *pdata = pdev->dev.platform_data;
+	struct dw_i2s_dev *dev;
+	struct resource *res;
+	int ret;
+	unsigned int cap;
+	struct snd_soc_dai_driver *dw_i2s_dai;
+
+	if (!pdata) {
+		dev_err(&pdev->dev, "Invalid platform data\n");
+		return -EINVAL;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "no i2s resource defined\n");
+		return -ENODEV;
+	}
+
+	if (!devm_request_mem_region(&pdev->dev, res->start,
+				resource_size(res), pdev->name)) {
+		dev_err(&pdev->dev, "i2s region already claimed\n");
+		return -EBUSY;
+	}
+
+	dev = devm_kzalloc(&pdev->dev, sizeof(*dev), GFP_KERNEL);
+	if (!dev) {
+		dev_warn(&pdev->dev, "kzalloc fail\n");
+		return -ENOMEM;
+	}
+
+	dev->i2s_base = devm_ioremap(&pdev->dev, res->start,
+			resource_size(res));
+	if (!dev->i2s_base) {
+		dev_err(&pdev->dev, "ioremap fail for i2s_region\n");
+		return -ENOMEM;
+	}
+
+	cap = pdata->cap;
+	dev->capability = cap;
+	dev->i2s_clk_cfg = pdata->i2s_clk_cfg;
+
+	/* Set DMA slaves info */
+
+	dev->play_dma_data.data = pdata->play_dma_data;
+	dev->capture_dma_data.data = pdata->capture_dma_data;
+	dev->play_dma_data.addr = res->start + I2S_TXDMA;
+	dev->capture_dma_data.addr = res->start + I2S_RXDMA;
+	dev->play_dma_data.max_burst = 16;
+	dev->capture_dma_data.max_burst = 16;
+	dev->play_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
+	dev->capture_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
+	dev->play_dma_data.filter = pdata->filter;
+	dev->capture_dma_data.filter = pdata->filter;
+
+	dev->clk = clk_get(&pdev->dev, NULL);
+	if (IS_ERR(dev->clk))
+		return  PTR_ERR(dev->clk);
+
+	ret = clk_enable(dev->clk);
+	if (ret < 0)
+		goto err_clk_put;
+
+	dw_i2s_dai = devm_kzalloc(&pdev->dev, sizeof(*dw_i2s_dai), GFP_KERNEL);
+	if (!dw_i2s_dai) {
+		dev_err(&pdev->dev, "mem allocation failed for dai driver\n");
+		ret = -ENOMEM;
+		goto err_clk_disable;
+	}
+
+	if (cap & DWC_I2S_PLAY) {
+		dev_dbg(&pdev->dev, " SPEAr: play supported\n");
+		dw_i2s_dai->playback.channels_min = MIN_CHANNEL_NUM;
+		dw_i2s_dai->playback.channels_max = pdata->channel;
+		dw_i2s_dai->playback.formats = pdata->snd_fmts;
+		dw_i2s_dai->playback.rates = pdata->snd_rates;
+	}
+
+	if (cap & DWC_I2S_RECORD) {
+		dev_dbg(&pdev->dev, "SPEAr: record supported\n");
+		dw_i2s_dai->capture.channels_min = MIN_CHANNEL_NUM;
+		dw_i2s_dai->capture.channels_max = pdata->channel;
+		dw_i2s_dai->capture.formats = pdata->snd_fmts;
+		dw_i2s_dai->capture.rates = pdata->snd_rates;
+	}
+
+	dw_i2s_dai->ops = &dw_i2s_dai_ops;
+	dw_i2s_dai->suspend = dw_i2s_suspend;
+	dw_i2s_dai->resume = dw_i2s_resume;
+
+	dev->dev = &pdev->dev;
+	dev_set_drvdata(&pdev->dev, dev);
+	ret = snd_soc_register_dai(&pdev->dev, dw_i2s_dai);
+	if (ret != 0) {
+		dev_err(&pdev->dev, "not able to register dai\n");
+		goto err_set_drvdata;
+	}
+
+	return 0;
+
+err_set_drvdata:
+	dev_set_drvdata(&pdev->dev, NULL);
+err_clk_disable:
+	clk_disable(dev->clk);
+err_clk_put:
+	clk_put(dev->clk);
+	return ret;
+}
+
+static int dw_i2s_remove(struct platform_device *pdev)
+{
+	struct dw_i2s_dev *dev = dev_get_drvdata(&pdev->dev);
+
+	snd_soc_unregister_dai(&pdev->dev);
+	dev_set_drvdata(&pdev->dev, NULL);
+
+	clk_put(dev->clk);
+
+	return 0;
+}
+
+static struct platform_driver dw_i2s_driver = {
+	.probe		= dw_i2s_probe,
+	.remove		= dw_i2s_remove,
+	.driver		= {
+		.name	= "designware-i2s",
+		.owner	= THIS_MODULE,
+	},
+};
+
+module_platform_driver(dw_i2s_driver);
+
+MODULE_AUTHOR("Rajeev Kumar <rajeev-dlh.kumar@st.com>");
+MODULE_DESCRIPTION("DESIGNWARE I2S SoC Interface");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:designware_i2s");
-- 
1.7.0.4
