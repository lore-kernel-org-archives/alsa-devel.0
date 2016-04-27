From: Jose Abreu <Jose.Abreu@synopsys.com>
Subject: [PATCH 1/2 v6] ASoC: dwc: Add custom PCM driver
Date: Wed, 27 Apr 2016 11:05:19 +0100
Message-ID: <1467b43ff009213277fe8f092da40f0bb7609af4.1461749984.git.joabreu@synopsys.com>
References: <cover.1461749984.git.joabreu@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.1461749984.git.joabreu@synopsys.com>
In-Reply-To: <cover.1461749984.git.joabreu@synopsys.com>
References: <cover.1461749984.git.joabreu@synopsys.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org
To: alsa-devel@alsa-project.org
Cc: Jose Abreu <Jose.Abreu@synopsys.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, Mark Brown <broonie@kernel.org>, Carlos Palminha <CARLOS.PALMINHA@synopsys.com>, linux-snps-arc@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

HDMI audio support was added to the AXS board using an
I2S cpu driver and a custom platform driver.

The platform driver supports two channels @ 16 bits with
rates 32k, 44.1k and 48k.

Although the mainline I2S driver uses ALSA DMA engine,
this controller can be built without DMA support so it
was necessary to add this custom platform driver so that
HDMI audio works in AXS boards.

The selection between the use of DMA engine or PIO mode
is detected by declaring or not the DMA parameters in
the device tree.

Signed-off-by: Jose Abreu <joabreu@synopsys.com>
Cc: Carlos Palminha <palminha@synopsys.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Alexey Brodkin <abrodkin@synopsys.com>
Cc: linux-snps-arc@lists.infradead.org
Cc: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
---

Changes v5 -> v6:
* Use SNDRV_DMA_TYPE_CONTINUOUS

Changes v4 -> v5:
* Resolve undefined references when compiling as module
* Use DMA properties in I2S to check which mode to use: PIO or DMA (as suggested by Lars-Peter Clausen)

Changes v3 -> v4:
* Reintroduced custom PCM driver
* Use DT boolean to switch between ALSA DMA engine PCM or custom PCM

Changes v2 -> v3:
* Removed pll_config functions (as suggested by Alexey Brodkin)
* Dropped custom platform driver, using now ALSA DMA engine
* Dropped IRQ handler for I2S

No changes v1 -> v2.

 sound/soc/dwc/Kconfig          |   9 ++
 sound/soc/dwc/Makefile         |   1 +
 sound/soc/dwc/designware.h     |  71 +++++++++++++
 sound/soc/dwc/designware_i2s.c |  94 ++++++++++++-----
 sound/soc/dwc/designware_pcm.c | 228 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 376 insertions(+), 27 deletions(-)
 create mode 100644 sound/soc/dwc/designware.h
 create mode 100644 sound/soc/dwc/designware_pcm.c

diff --git a/sound/soc/dwc/Kconfig b/sound/soc/dwc/Kconfig
index d50e085..2a21120 100644
--- a/sound/soc/dwc/Kconfig
+++ b/sound/soc/dwc/Kconfig
@@ -7,4 +7,13 @@ config SND_DESIGNWARE_I2S
 	 Synopsys desigwnware I2S device. The device supports upto
 	 maximum of 8 channels each for play and record.
 
+config SND_DESIGNWARE_PCM
+	tristate "Synopsys I2S PCM Driver"
+	help
+	 Say Y or M if you want to add support for ALSA ASoC platform driver
+	 using I2S.
+
+	 Select this option if you want to be able to create a sound interface
+	 using the I2S device driver as CPU driver. Instead of using ALSA
+	 DMA engine by selecting this driver a custom PCM driver will be used.
 
diff --git a/sound/soc/dwc/Makefile b/sound/soc/dwc/Makefile
index 319371f..1b48bccc 100644
--- a/sound/soc/dwc/Makefile
+++ b/sound/soc/dwc/Makefile
@@ -1,3 +1,4 @@
 # SYNOPSYS Platform Support
 obj-$(CONFIG_SND_DESIGNWARE_I2S) += designware_i2s.o
+obj-$(CONFIG_SND_DESIGNWARE_PCM) += designware_pcm.o
 
diff --git a/sound/soc/dwc/designware.h b/sound/soc/dwc/designware.h
new file mode 100644
index 0000000..09fafee
--- /dev/null
+++ b/sound/soc/dwc/designware.h
@@ -0,0 +1,71 @@
+/*
+ * ALSA SoC Synopsys Audio Layer
+ *
+ * sound/soc/dwc/designware.h
+ *
+ * Copyright (C) 2016 Synopsys
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __DESIGNWARE_H
+#define __DESIGNWARE_H
+
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/kconfig.h>
+#include <sound/designware_i2s.h>
+#include <sound/dmaengine_pcm.h>
+
+struct dw_pcm_binfo {
+	struct snd_pcm_substream *stream;
+	unsigned char *dma_base;
+	unsigned char *dma_pointer;
+	unsigned int period_size_frames;
+	unsigned int size;
+	snd_pcm_uframes_t period_pointer;
+	unsigned int total_periods;
+	unsigned int current_period;
+};
+
+union dw_i2s_snd_dma_data {
+	struct i2s_dma_data pd;
+	struct snd_dmaengine_dai_dma_data dt;
+};
+
+struct dw_i2s_dev {
+	void __iomem *i2s_base;
+	struct clk *clk;
+	int active;
+	unsigned int capability;
+	unsigned int quirks;
+	unsigned int i2s_reg_comp1;
+	unsigned int i2s_reg_comp2;
+	struct device *dev;
+	u32 ccr;
+	u32 xfer_resolution;
+	u32 fifo_th;
+
+	/* data related to DMA transfers b/w i2s and DMAC */
+	bool use_dmaengine;
+	union dw_i2s_snd_dma_data play_dma_data;
+	union dw_i2s_snd_dma_data capture_dma_data;
+	struct i2s_clk_config_data config;
+	int (*i2s_clk_cfg)(struct i2s_clk_config_data *config);
+	struct dw_pcm_binfo binfo;
+};
+
+#if IS_ENABLED(CONFIG_SND_DESIGNWARE_PCM)
+int dw_pcm_transfer(u32 *lsample, u32 *rsample, int bytes, int buf_size,
+		struct dw_pcm_binfo *bi);
+#else
+int dw_pcm_transfer(u32 *lsample, u32 *rsample, int bytes, int buf_size,
+		struct dw_pcm_binfo *bi)
+{
+	return 0;
+}
+#endif
+
+#endif
diff --git a/sound/soc/dwc/designware_i2s.c b/sound/soc/dwc/designware_i2s.c
index 0db69b7..5ee0faf 100644
--- a/sound/soc/dwc/designware_i2s.c
+++ b/sound/soc/dwc/designware_i2s.c
@@ -24,6 +24,7 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include <sound/dmaengine_pcm.h>
+#include "designware.h"
 
 /* common register for all channel */
 #define IER		0x000
@@ -84,31 +85,6 @@
 #define MAX_CHANNEL_NUM		8
 #define MIN_CHANNEL_NUM		2
 
-union dw_i2s_snd_dma_data {
-	struct i2s_dma_data pd;
-	struct snd_dmaengine_dai_dma_data dt;
-};
-
-struct dw_i2s_dev {
-	void __iomem *i2s_base;
-	struct clk *clk;
-	int active;
-	unsigned int capability;
-	unsigned int quirks;
-	unsigned int i2s_reg_comp1;
-	unsigned int i2s_reg_comp2;
-	struct device *dev;
-	u32 ccr;
-	u32 xfer_resolution;
-	u32 fifo_th;
-
-	/* data related to DMA transfers b/w i2s and DMAC */
-	union dw_i2s_snd_dma_data play_dma_data;
-	union dw_i2s_snd_dma_data capture_dma_data;
-	struct i2s_clk_config_data config;
-	int (*i2s_clk_cfg)(struct i2s_clk_config_data *config);
-};
-
 static inline void i2s_write_reg(void __iomem *io_base, int reg, u32 val)
 {
 	writel(val, io_base + reg);
@@ -145,6 +121,54 @@ static inline void i2s_clear_irqs(struct dw_i2s_dev *dev, u32 stream)
 	}
 }
 
+static irqreturn_t dw_i2s_irq_handler(int irq, void *dev_id)
+{
+	struct dw_i2s_dev *dev = dev_id;
+	u32 isr[4], sleft[dev->fifo_th], sright[dev->fifo_th];
+	int i, j, xfer_bytes = dev->config.data_width / 8;
+	int dir = dev->binfo.stream->stream;
+
+	for (i = 0; i < 4; i++)
+		isr[i] = i2s_read_reg(dev->i2s_base, ISR(i));
+
+	i2s_clear_irqs(dev, SNDRV_PCM_STREAM_PLAYBACK);
+	i2s_clear_irqs(dev, SNDRV_PCM_STREAM_CAPTURE);
+
+	if (dev->use_dmaengine)
+		return IRQ_HANDLED;
+
+	for (i = 0; i < 4; i++) {
+		/* Copy only to/from first two channels
+		 * TODO: Remaining channels
+		 */
+		if ((isr[i] & 0x10) && (i == 0) &&
+				(dir == SNDRV_PCM_STREAM_PLAYBACK)) {
+			/* TXFEM - TX FIFO is empty */
+			dw_pcm_transfer(sleft, sright, xfer_bytes, dev->fifo_th,
+					&dev->binfo);
+			for (j = 0; j < dev->fifo_th; j++) {
+				i2s_write_reg(dev->i2s_base, LRBR_LTHR(i),
+						sleft[j]);
+				i2s_write_reg(dev->i2s_base, RRBR_RTHR(i),
+						sright[j]);
+			}
+		} else if ((isr[i] & 0x01) && (i == 0) &&
+				(dir == SNDRV_PCM_STREAM_CAPTURE)) {
+			/* RXDAM - RX FIFO is full */
+			for (j = 0; j < dev->fifo_th; j++) {
+				sleft[j] = i2s_read_reg(dev->i2s_base,
+						LRBR_LTHR(i));
+				sright[j] = i2s_read_reg(dev->i2s_base,
+						RRBR_RTHR(i));
+			}
+			dw_pcm_transfer(sleft, sright, xfer_bytes, dev->fifo_th,
+					&dev->binfo);
+		}
+	}
+
+	return IRQ_HANDLED;
+}
+
 static void i2s_start(struct dw_i2s_dev *dev,
 		      struct snd_pcm_substream *substream)
 {
@@ -626,7 +650,7 @@ static int dw_i2s_probe(struct platform_device *pdev)
 	const struct i2s_platform_data *pdata = pdev->dev.platform_data;
 	struct dw_i2s_dev *dev;
 	struct resource *res;
-	int ret;
+	int ret, irq_number;
 	struct snd_soc_dai_driver *dw_i2s_dai;
 	const char *clk_id;
 
@@ -649,6 +673,19 @@ static int dw_i2s_probe(struct platform_device *pdev)
 	if (IS_ERR(dev->i2s_base))
 		return PTR_ERR(dev->i2s_base);
 
+	irq_number = platform_get_irq(pdev, 0);
+	if (irq_number <= 0) {
+		dev_err(&pdev->dev, "get_irq fail\n");
+		return -EINVAL;
+	}
+
+	ret = devm_request_irq(&pdev->dev, irq_number, dw_i2s_irq_handler,
+			IRQF_SHARED, "dw_i2s_irq_handler", dev);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "request_irq fail\n");
+		return ret;
+	}
+
 	dev->dev = &pdev->dev;
 
 	dev->i2s_reg_comp1 = I2S_COMP_PARAM_1;
@@ -657,6 +694,7 @@ static int dw_i2s_probe(struct platform_device *pdev)
 		dev->capability = pdata->cap;
 		clk_id = NULL;
 		dev->quirks = pdata->quirks;
+		dev->use_dmaengine = false;
 		if (dev->quirks & DW_I2S_QUIRK_COMP_REG_OFFSET) {
 			dev->i2s_reg_comp1 = pdata->i2s_reg_comp1;
 			dev->i2s_reg_comp2 = pdata->i2s_reg_comp2;
@@ -664,6 +702,8 @@ static int dw_i2s_probe(struct platform_device *pdev)
 		ret = dw_configure_dai_by_pd(dev, dw_i2s_dai, res, pdata);
 	} else {
 		clk_id = "i2sclk";
+		dev->use_dmaengine = of_property_read_bool(pdev->dev.of_node,
+				"dmas");
 		ret = dw_configure_dai_by_dt(dev, dw_i2s_dai, res);
 	}
 	if (ret < 0)
@@ -695,7 +735,7 @@ static int dw_i2s_probe(struct platform_device *pdev)
 		goto err_clk_disable;
 	}
 
-	if (!pdata) {
+	if (dev->use_dmaengine) {
 		ret = devm_snd_dmaengine_pcm_register(&pdev->dev, NULL, 0);
 		if (ret) {
 			dev_err(&pdev->dev,
diff --git a/sound/soc/dwc/designware_pcm.c b/sound/soc/dwc/designware_pcm.c
new file mode 100644
index 0000000..beb4b99
--- /dev/null
+++ b/sound/soc/dwc/designware_pcm.c
@@ -0,0 +1,228 @@
+/*
+ * Synopsys I2S PCM Driver
+ *
+ * Copyright (C) 2016 Synopsys
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/dmaengine.h>
+#include <linux/dma-mapping.h>
+#include <linux/slab.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <sound/dmaengine_pcm.h>
+#include "designware.h"
+
+#define BUFFER_BYTES_MAX	384000
+#define PERIOD_BYTES_MIN	2048
+#define PERIODS_MIN		8
+
+static const struct snd_pcm_hardware dw_pcm_hardware = {
+	.info = SNDRV_PCM_INFO_INTERLEAVED |
+		SNDRV_PCM_INFO_MMAP |
+		SNDRV_PCM_INFO_MMAP_VALID |
+		SNDRV_PCM_INFO_BLOCK_TRANSFER,
+	.rates = SNDRV_PCM_RATE_32000 |
+		SNDRV_PCM_RATE_44100 |
+		SNDRV_PCM_RATE_48000,
+	.rate_min = 32000,
+	.rate_max = 48000,
+	.formats = SNDRV_PCM_FMTBIT_S16_LE,
+	.channels_min = 2,
+	.channels_max = 2,
+	.buffer_bytes_max = BUFFER_BYTES_MAX,
+	.period_bytes_min = PERIOD_BYTES_MIN,
+	.period_bytes_max = BUFFER_BYTES_MAX / PERIODS_MIN,
+	.periods_min = PERIODS_MIN,
+	.periods_max = BUFFER_BYTES_MAX / PERIOD_BYTES_MIN,
+};
+
+int dw_pcm_transfer(u32 *lsample, u32 *rsample, int bytes, int buf_size,
+		struct dw_pcm_binfo *bi)
+{
+	struct snd_pcm_runtime *rt = bi->stream->runtime;
+	int dir = bi->stream->stream;
+	int i;
+
+	for (i = 0; i < buf_size; i++) {
+		if (dir == SNDRV_PCM_STREAM_PLAYBACK) {
+			memcpy(&lsample[i], bi->dma_pointer, bytes);
+			bi->dma_pointer += bytes;
+			memcpy(&rsample[i], bi->dma_pointer, bytes);
+			bi->dma_pointer += bytes;
+		} else {
+			memcpy(bi->dma_pointer, &lsample[i], bytes);
+			bi->dma_pointer += bytes;
+			memcpy(bi->dma_pointer, &rsample[i], bytes);
+			bi->dma_pointer += bytes;
+		}
+	}
+
+	bi->period_pointer += bytes_to_frames(rt, bytes * 2 * buf_size);
+
+	if (bi->period_pointer >= (bi->period_size_frames * bi->current_period)) {
+		bi->current_period++;
+		if (bi->current_period > bi->total_periods) {
+			bi->dma_pointer = bi->dma_base;
+			bi->period_pointer = 0;
+			bi->current_period = 1;
+		}
+		snd_pcm_period_elapsed(bi->stream);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dw_pcm_transfer);
+
+static int dw_pcm_open(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_pcm_runtime *rt = substream->runtime;
+	struct dw_i2s_dev *dev = snd_soc_dai_get_drvdata(rtd->cpu_dai);
+
+	snd_soc_set_runtime_hwparams(substream, &dw_pcm_hardware);
+	snd_pcm_hw_constraint_integer(rt, SNDRV_PCM_HW_PARAM_PERIODS);
+
+	dev->binfo.stream = substream;
+	rt->private_data = &dev->binfo;
+	return 0;
+}
+
+static int dw_pcm_close(struct snd_pcm_substream *substream)
+{
+	return 0;
+}
+
+static int dw_pcm_hw_params(struct snd_pcm_substream *substream,
+		struct snd_pcm_hw_params *hw_params)
+{
+	struct snd_pcm_runtime *rt = substream->runtime;
+	struct dw_pcm_binfo *bi = rt->private_data;
+	int ret;
+
+	ret = snd_pcm_lib_alloc_vmalloc_buffer(substream,
+			params_buffer_bytes(hw_params));
+	if (ret < 0)
+		return ret;
+
+	memset(rt->dma_area, 0, params_buffer_bytes(hw_params));
+	bi->dma_base = rt->dma_area;
+	bi->dma_pointer = bi->dma_base;
+
+	return 0;
+}
+
+static int dw_pcm_hw_free(struct snd_pcm_substream *substream)
+{
+	return snd_pcm_lib_free_vmalloc_buffer(substream);
+}
+
+static int dw_pcm_prepare(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *rt = substream->runtime;
+	struct dw_pcm_binfo *bi = rt->private_data;
+	u32 buffer_size_frames = 0;
+
+	bi->period_size_frames = bytes_to_frames(rt,
+			snd_pcm_lib_period_bytes(substream));
+	bi->size = snd_pcm_lib_buffer_bytes(substream);
+	buffer_size_frames = bytes_to_frames(rt, bi->size);
+	bi->total_periods = buffer_size_frames / bi->period_size_frames;
+	bi->current_period = 1;
+
+	if ((buffer_size_frames % bi->period_size_frames) != 0)
+		return -EINVAL;
+	if ((bi->size % (snd_pcm_format_width(rt->format) / 8)) != 0)
+		return -EINVAL;
+	return 0;
+}
+
+static int dw_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
+{
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static snd_pcm_uframes_t dw_pcm_pointer(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *rt = substream->runtime;
+	struct dw_pcm_binfo *bi = rt->private_data;
+
+	return bi->period_pointer;
+}
+
+static struct snd_pcm_ops dw_pcm_ops = {
+	.open = dw_pcm_open,
+	.close = dw_pcm_close,
+	.ioctl = snd_pcm_lib_ioctl,
+	.hw_params = dw_pcm_hw_params,
+	.hw_free = dw_pcm_hw_free,
+	.prepare = dw_pcm_prepare,
+	.trigger = dw_pcm_trigger,
+	.pointer = dw_pcm_pointer,
+	.page = snd_pcm_lib_get_vmalloc_page,
+	.mmap = snd_pcm_lib_mmap_vmalloc,
+};
+
+static int dw_pcm_new(struct snd_soc_pcm_runtime *runtime)
+{
+	struct snd_pcm *pcm = runtime->pcm;
+
+	return snd_pcm_lib_preallocate_pages_for_all(pcm,
+			SNDRV_DMA_TYPE_CONTINUOUS,
+			snd_dma_continuous_data(GFP_KERNEL), BUFFER_BYTES_MAX,
+			BUFFER_BYTES_MAX);
+}
+
+static void dw_pcm_free(struct snd_pcm *pcm)
+{
+	snd_pcm_lib_preallocate_free_for_all(pcm);
+}
+
+static struct snd_soc_platform_driver dw_pcm_platform = {
+	.pcm_new = dw_pcm_new,
+	.pcm_free = dw_pcm_free,
+	.ops = &dw_pcm_ops,
+};
+
+static int dw_pcm_probe(struct platform_device *pdev)
+{
+	return devm_snd_soc_register_platform(&pdev->dev, &dw_pcm_platform);
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id dw_pcm_of[] = {
+	{ .compatible = "snps,designware-pcm" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, dw_pcm_of);
+#endif
+
+static struct platform_driver dw_pcm_driver = {
+	.driver = {
+		.name = "designware-pcm",
+		.of_match_table = of_match_ptr(dw_pcm_of),
+	},
+	.probe = dw_pcm_probe,
+};
+module_platform_driver(dw_pcm_driver);
+
+MODULE_AUTHOR("Jose Abreu <joabreu@synopsys.com>, Tiago Duarte");
+MODULE_DESCRIPTION("Synopsys Designware PCM Driver");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1
