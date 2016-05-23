From: Jose Abreu <Jose.Abreu@synopsys.com>
Subject: [PATCH 3/4 v7] ASoC: dwc: Add PIO PCM extension
Date: Mon, 23 May 2016 11:02:24 +0100
Message-ID: <d81055d826825874c9d76922d2275688b2586fa6.1463996627.git.joabreu@synopsys.com>
References: <cover.1463996627.git.joabreu@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.1463996627.git.joabreu@synopsys.com>
In-Reply-To: <cover.1463996627.git.joabreu@synopsys.com>
References: <cover.1463996627.git.joabreu@synopsys.com>
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
Cc: Jose Abreu <Jose.Abreu@synopsys.com>, Rob Herring <robh@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, devicetree@vger.kernel.org, Mark Brown <broonie@kernel.org>, Carlos Palminha <CARLOS.PALMINHA@synopsys.com>, linux-snps-arc@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

A PCM extension was added to I2S driver so that audio
samples are transferred using PIO mode.

The PCM supports two channels @ 16 or 32 bits with rates
32k, 44.1k and 48k.

Although the mainline I2S driver uses ALSA DMA engine the
I2S controller can be built without DMA support, therefore
this is the reason why this extension was added.

The selection between the use of DMA engine or PIO mode
is detected by declaring or not the interrupt parameters
in the DT and using Kconfig.

Signed-off-by: Jose Abreu <joabreu@synopsys.com>
Cc: Carlos Palminha <palminha@synopsys.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Alexey Brodkin <abrodkin@synopsys.com>
Cc: linux-snps-arc@lists.infradead.org
Cc: alsa-devel@alsa-project.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---

Changes v6 -> v7:
* Discard the use of memcpy
* Report IRQ_HANDLED only when there is an IRQ
* Use interrupts to check if PIO mode is in use
* Unmask interrupts only when in PIO mode
* Remove empty functions

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
 sound/soc/dwc/Makefile         |   5 +-
 sound/soc/dwc/designware_i2s.c | 148 ++++++++++++---------------
 sound/soc/dwc/designware_pcm.c | 220 +++++++++++++++++++++++++++++++++++++++++
 sound/soc/dwc/local.h          | 122 +++++++++++++++++++++++
 5 files changed, 415 insertions(+), 89 deletions(-)
 create mode 100644 sound/soc/dwc/designware_pcm.c
 create mode 100644 sound/soc/dwc/local.h

diff --git a/sound/soc/dwc/Kconfig b/sound/soc/dwc/Kconfig
index d50e085..c6fd95f 100644
--- a/sound/soc/dwc/Kconfig
+++ b/sound/soc/dwc/Kconfig
@@ -7,4 +7,13 @@ config SND_DESIGNWARE_I2S
 	 Synopsys desigwnware I2S device. The device supports upto
 	 maximum of 8 channels each for play and record.
 
+config SND_DESIGNWARE_PCM
+	bool "PCM PIO extension for I2S driver"
+	depends on SND_DESIGNWARE_I2S
+	help
+	 Say Y or N if you want to add a custom ALSA extension that registers
+	 a PCM and uses PIO to transfer data.
+
+	 This functionality is specially suited for I2S devices that don't have
+	 DMA support.
 
diff --git a/sound/soc/dwc/Makefile b/sound/soc/dwc/Makefile
index 319371f..11ea966 100644
--- a/sound/soc/dwc/Makefile
+++ b/sound/soc/dwc/Makefile
@@ -1,3 +1,4 @@
 # SYNOPSYS Platform Support
-obj-$(CONFIG_SND_DESIGNWARE_I2S) += designware_i2s.o
-
+obj-$(CONFIG_SND_DESIGNWARE_I2S) += dwc_i2s.o
+dwc_i2s-y := designware_i2s.o
+dwc_i2s-$(CONFIG_SND_DESIGNWARE_PCM) += designware_pcm.o
diff --git a/sound/soc/dwc/designware_i2s.c b/sound/soc/dwc/designware_i2s.c
index a97be8e..d4c3811 100644
--- a/sound/soc/dwc/designware_i2s.c
+++ b/sound/soc/dwc/designware_i2s.c
@@ -24,90 +24,7 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include <sound/dmaengine_pcm.h>
-
-/* common register for all channel */
-#define IER		0x000
-#define IRER		0x004
-#define ITER		0x008
-#define CER		0x00C
-#define CCR		0x010
-#define RXFFR		0x014
-#define TXFFR		0x018
-
-/* I2STxRxRegisters for all channels */
-#define LRBR_LTHR(x)	(0x40 * x + 0x020)
-#define RRBR_RTHR(x)	(0x40 * x + 0x024)
-#define RER(x)		(0x40 * x + 0x028)
-#define TER(x)		(0x40 * x + 0x02C)
-#define RCR(x)		(0x40 * x + 0x030)
-#define TCR(x)		(0x40 * x + 0x034)
-#define ISR(x)		(0x40 * x + 0x038)
-#define IMR(x)		(0x40 * x + 0x03C)
-#define ROR(x)		(0x40 * x + 0x040)
-#define TOR(x)		(0x40 * x + 0x044)
-#define RFCR(x)		(0x40 * x + 0x048)
-#define TFCR(x)		(0x40 * x + 0x04C)
-#define RFF(x)		(0x40 * x + 0x050)
-#define TFF(x)		(0x40 * x + 0x054)
-
-/* I2SCOMPRegisters */
-#define I2S_COMP_PARAM_2	0x01F0
-#define I2S_COMP_PARAM_1	0x01F4
-#define I2S_COMP_VERSION	0x01F8
-#define I2S_COMP_TYPE		0x01FC
-
-/*
- * Component parameter register fields - define the I2S block's
- * configuration.
- */
-#define	COMP1_TX_WORDSIZE_3(r)	(((r) & GENMASK(27, 25)) >> 25)
-#define	COMP1_TX_WORDSIZE_2(r)	(((r) & GENMASK(24, 22)) >> 22)
-#define	COMP1_TX_WORDSIZE_1(r)	(((r) & GENMASK(21, 19)) >> 19)
-#define	COMP1_TX_WORDSIZE_0(r)	(((r) & GENMASK(18, 16)) >> 16)
-#define	COMP1_TX_CHANNELS(r)	(((r) & GENMASK(10, 9)) >> 9)
-#define	COMP1_RX_CHANNELS(r)	(((r) & GENMASK(8, 7)) >> 7)
-#define	COMP1_RX_ENABLED(r)	(((r) & BIT(6)) >> 6)
-#define	COMP1_TX_ENABLED(r)	(((r) & BIT(5)) >> 5)
-#define	COMP1_MODE_EN(r)	(((r) & BIT(4)) >> 4)
-#define	COMP1_FIFO_DEPTH_GLOBAL(r)	(((r) & GENMASK(3, 2)) >> 2)
-#define	COMP1_APB_DATA_WIDTH(r)	(((r) & GENMASK(1, 0)) >> 0)
-
-#define	COMP2_RX_WORDSIZE_3(r)	(((r) & GENMASK(12, 10)) >> 10)
-#define	COMP2_RX_WORDSIZE_2(r)	(((r) & GENMASK(9, 7)) >> 7)
-#define	COMP2_RX_WORDSIZE_1(r)	(((r) & GENMASK(5, 3)) >> 3)
-#define	COMP2_RX_WORDSIZE_0(r)	(((r) & GENMASK(2, 0)) >> 0)
-
-/* Number of entries in WORDSIZE and DATA_WIDTH parameter registers */
-#define	COMP_MAX_WORDSIZE	(1 << 3)
-#define	COMP_MAX_DATA_WIDTH	(1 << 2)
-
-#define MAX_CHANNEL_NUM		8
-#define MIN_CHANNEL_NUM		2
-
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
+#include "local.h"
 
 static inline void i2s_write_reg(void __iomem *io_base, int reg, u32 val)
 {
@@ -181,13 +98,49 @@ static inline void i2s_enable_irqs(struct dw_i2s_dev *dev, u32 stream,
 	}
 }
 
+static irqreturn_t i2s_irq_handler(int irq, void *dev_id)
+{
+	struct dw_i2s_dev *dev = dev_id;
+	bool irq_valid = false;
+	u32 isr[4];
+	int i;
+
+	for (i = 0; i < 4; i++)
+		isr[i] = i2s_read_reg(dev->i2s_base, ISR(i));
+
+	i2s_clear_irqs(dev, SNDRV_PCM_STREAM_PLAYBACK);
+	i2s_clear_irqs(dev, SNDRV_PCM_STREAM_CAPTURE);
+
+	for (i = 0; i < 4; i++) {
+		if (isr[i] & 0x33)
+			irq_valid = true;
+
+		/*
+		 * Check if TX fifo is empty. If empty fill FIFO with samples
+		 * NOTE: Only two channels supported
+		 */
+		if ((isr[i] & 0x10) && (i == 0))
+			dw_pcm_push_tx(dev);
+
+		/* Error Handling */
+		if (isr[i] & 0x20)
+			dev_err(dev->dev, "TX overrun (ch_id=%d)\n", i);
+		if (isr[i] & 0x02)
+			dev_err(dev->dev, "RX overrun (ch_id=%d)\n", i);
+	}
+
+	return irq_valid ? IRQ_HANDLED : IRQ_NONE;
+}
+
 static void i2s_start(struct dw_i2s_dev *dev,
 		      struct snd_pcm_substream *substream)
 {
 	struct i2s_clk_config_data *config = &dev->config;
 
 	i2s_write_reg(dev->i2s_base, IER, 1);
-	i2s_enable_irqs(dev, substream->stream, config->chan_nr);
+
+	if (dev->use_pio)
+		i2s_enable_irqs(dev, substream->stream, config->chan_nr);
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 		i2s_write_reg(dev->i2s_base, ITER, 1);
@@ -640,7 +593,7 @@ static int dw_i2s_probe(struct platform_device *pdev)
 	const struct i2s_platform_data *pdata = pdev->dev.platform_data;
 	struct dw_i2s_dev *dev;
 	struct resource *res;
-	int ret;
+	int ret, irq;
 	struct snd_soc_dai_driver *dw_i2s_dai;
 	const char *clk_id;
 
@@ -665,6 +618,19 @@ static int dw_i2s_probe(struct platform_device *pdev)
 
 	dev->dev = &pdev->dev;
 
+	irq = platform_get_irq(pdev, 0);
+	if (irq >= 0) {
+		dev_dbg(&pdev->dev, "using PIO mode\n");
+		dev->use_pio = true;
+
+		ret = devm_request_irq(&pdev->dev, irq, i2s_irq_handler, 0,
+				pdev->name, dev);
+		if (ret < 0) {
+			dev_err(&pdev->dev, "failed to request irq\n");
+			return ret;
+		}
+	}
+
 	dev->i2s_reg_comp1 = I2S_COMP_PARAM_1;
 	dev->i2s_reg_comp2 = I2S_COMP_PARAM_2;
 	if (pdata) {
@@ -710,14 +676,22 @@ static int dw_i2s_probe(struct platform_device *pdev)
 		goto err_clk_disable;
 	}
 
-	if (!pdata) {
+	if (!pdata && !dev->use_pio) {
 		ret = devm_snd_dmaengine_pcm_register(&pdev->dev, NULL, 0);
 		if (ret) {
 			dev_err(&pdev->dev,
 				"Could not register PCM: %d\n", ret);
 			goto err_clk_disable;
 		}
+	} else if (dev->use_pio) {
+		ret = dw_pcm_register(pdev);
+		if (ret) {
+			dev_err(&pdev->dev,
+				"Could not register PIO PCM: %d\n", ret);
+			goto err_clk_disable;
+		}
 	}
+
 	pm_runtime_enable(&pdev->dev);
 	return 0;
 
diff --git a/sound/soc/dwc/designware_pcm.c b/sound/soc/dwc/designware_pcm.c
new file mode 100644
index 0000000..d995b50
--- /dev/null
+++ b/sound/soc/dwc/designware_pcm.c
@@ -0,0 +1,220 @@
+/*
+ * ALSA SoC Synopsys PIO PCM for I2S driver
+ *
+ * sound/soc/dwc/designware_pcm.c
+ *
+ * Copyright (C) 2016 Synopsys
+ * Jose Abreu <joabreu@synopsys.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/io.h>
+#include <linux/rcupdate.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include "local.h"
+
+#define BUFFER_BYTES_MAX	(3 * 2 * 8 * PERIOD_BYTES_MIN)
+#define PERIOD_BYTES_MIN	4096
+#define PERIODS_MIN		2
+
+#define dw_pcm_tx_fn(sample_bits) \
+static unsigned int dw_pcm_tx_##sample_bits(struct dw_i2s_dev *dev, \
+		struct snd_pcm_runtime *runtime, unsigned int tx_ptr, \
+		bool *period_elapsed) \
+{ \
+	const u##sample_bits (*p)[2] = (void *)runtime->dma_area; \
+	unsigned int period_pos = tx_ptr % runtime->period_size; \
+	int i; \
+\
+	for (i = 0; i < dev->fifo_th; i++) { \
+		iowrite32(p[tx_ptr][0], dev->i2s_base + LRBR_LTHR(0)); \
+		iowrite32(p[tx_ptr][1], dev->i2s_base + RRBR_RTHR(0)); \
+		period_pos++; \
+		if (++tx_ptr >= runtime->buffer_size) \
+			tx_ptr = 0; \
+	} \
+	*period_elapsed = period_pos >= runtime->period_size; \
+	return tx_ptr; \
+}
+
+dw_pcm_tx_fn(16);
+dw_pcm_tx_fn(32);
+
+#undef dw_pcm_tx_fn
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
+	.formats = SNDRV_PCM_FMTBIT_S16_LE |
+		SNDRV_PCM_FMTBIT_S32_LE,
+	.channels_min = 2,
+	.channels_max = 2,
+	.buffer_bytes_max = BUFFER_BYTES_MAX,
+	.period_bytes_min = PERIOD_BYTES_MIN,
+	.period_bytes_max = BUFFER_BYTES_MAX / PERIODS_MIN,
+	.periods_min = PERIODS_MIN,
+	.periods_max = BUFFER_BYTES_MAX / PERIOD_BYTES_MIN,
+	.fifo_size = 16,
+};
+
+void dw_pcm_push_tx(struct dw_i2s_dev *dev)
+{
+	struct snd_pcm_substream *tx_substream;
+	bool tx_active, period_elapsed;
+
+	rcu_read_lock();
+	tx_substream = rcu_dereference(dev->tx_substream);
+	tx_active = tx_substream && snd_pcm_running(tx_substream);
+	if (tx_active) {
+		unsigned int tx_ptr = ACCESS_ONCE(dev->tx_ptr);
+		unsigned int new_tx_ptr = dev->tx_fn(dev, tx_substream->runtime,
+				tx_ptr, &period_elapsed);
+		cmpxchg(&dev->tx_ptr, tx_ptr, new_tx_ptr);
+
+		if (period_elapsed)
+			snd_pcm_period_elapsed(tx_substream);
+	}
+	rcu_read_unlock();
+}
+
+static int dw_pcm_open(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct dw_i2s_dev *dev = snd_soc_dai_get_drvdata(rtd->cpu_dai);
+
+	snd_soc_set_runtime_hwparams(substream, &dw_pcm_hardware);
+	snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS);
+	runtime->private_data = dev;
+
+	return 0;
+}
+
+static int dw_pcm_close(struct snd_pcm_substream *substream)
+{
+	synchronize_rcu();
+	return 0;
+}
+
+static int dw_pcm_hw_params(struct snd_pcm_substream *substream,
+		struct snd_pcm_hw_params *hw_params)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct dw_i2s_dev *dev = runtime->private_data;
+	int ret;
+
+	switch (params_channels(hw_params)) {
+	case 2:
+		break;
+	default:
+		dev_err(dev->dev, "invalid channels number\n");
+		return -EINVAL;
+	}
+
+	switch (params_format(hw_params)) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+		dev->tx_fn = dw_pcm_tx_16;
+		break;
+	case SNDRV_PCM_FORMAT_S32_LE:
+		dev->tx_fn = dw_pcm_tx_32;
+		break;
+	default:
+		dev_err(dev->dev, "invalid format\n");
+		return -EINVAL;
+	}
+
+	if (substream->stream != SNDRV_PCM_STREAM_PLAYBACK) {
+		dev_err(dev->dev, "only playback is available\n");
+		return -EINVAL;
+	}
+
+	ret = snd_pcm_lib_malloc_pages(substream,
+			params_buffer_bytes(hw_params));
+	return (ret < 0) ? ret : 0;
+}
+
+static int dw_pcm_hw_free(struct snd_pcm_substream *substream)
+{
+	return snd_pcm_lib_free_pages(substream);
+}
+
+static int dw_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct dw_i2s_dev *dev = runtime->private_data;
+	int ret = 0;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		ACCESS_ONCE(dev->tx_ptr) = 0;
+		rcu_assign_pointer(dev->tx_substream, substream);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		rcu_assign_pointer(dev->tx_substream, NULL);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static snd_pcm_uframes_t dw_pcm_pointer(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct dw_i2s_dev *dev = runtime->private_data;
+	snd_pcm_uframes_t pos = ACCESS_ONCE(dev->tx_ptr);
+
+	return pos < runtime->buffer_size ? pos : 0;
+}
+
+static int dw_pcm_new(struct snd_soc_pcm_runtime *rtd)
+{
+	size_t size = dw_pcm_hardware.buffer_bytes_max;
+
+	return snd_pcm_lib_preallocate_pages_for_all(rtd->pcm,
+			SNDRV_DMA_TYPE_CONTINUOUS,
+			snd_dma_continuous_data(GFP_KERNEL), size, size);
+}
+
+static void dw_pcm_free(struct snd_pcm *pcm)
+{
+	snd_pcm_lib_preallocate_free_for_all(pcm);
+}
+
+static const struct snd_pcm_ops dw_pcm_ops = {
+	.open = dw_pcm_open,
+	.close = dw_pcm_close,
+	.ioctl = snd_pcm_lib_ioctl,
+	.hw_params = dw_pcm_hw_params,
+	.hw_free = dw_pcm_hw_free,
+	.trigger = dw_pcm_trigger,
+	.pointer = dw_pcm_pointer,
+};
+
+static const struct snd_soc_platform_driver dw_pcm_platform = {
+	.pcm_new = dw_pcm_new,
+	.pcm_free = dw_pcm_free,
+	.ops = &dw_pcm_ops,
+};
+
+int dw_pcm_register(struct platform_device *pdev)
+{
+	return devm_snd_soc_register_platform(&pdev->dev, &dw_pcm_platform);
+}
diff --git a/sound/soc/dwc/local.h b/sound/soc/dwc/local.h
new file mode 100644
index 0000000..6a8edc7
--- /dev/null
+++ b/sound/soc/dwc/local.h
@@ -0,0 +1,122 @@
+/*
+ * Copyright (ST) 2012 Rajeev Kumar (rajeevkumar.linux@gmail.com)
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __DESIGNWARE_LOCAL_H
+#define __DESIGNWARE_LOCAL_H
+
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/types.h>
+#include <sound/dmaengine_pcm.h>
+#include <sound/pcm.h>
+#include <sound/designware_i2s.h>
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
+/*
+ * Component parameter register fields - define the I2S block's
+ * configuration.
+ */
+#define	COMP1_TX_WORDSIZE_3(r)	(((r) & GENMASK(27, 25)) >> 25)
+#define	COMP1_TX_WORDSIZE_2(r)	(((r) & GENMASK(24, 22)) >> 22)
+#define	COMP1_TX_WORDSIZE_1(r)	(((r) & GENMASK(21, 19)) >> 19)
+#define	COMP1_TX_WORDSIZE_0(r)	(((r) & GENMASK(18, 16)) >> 16)
+#define	COMP1_TX_CHANNELS(r)	(((r) & GENMASK(10, 9)) >> 9)
+#define	COMP1_RX_CHANNELS(r)	(((r) & GENMASK(8, 7)) >> 7)
+#define	COMP1_RX_ENABLED(r)	(((r) & BIT(6)) >> 6)
+#define	COMP1_TX_ENABLED(r)	(((r) & BIT(5)) >> 5)
+#define	COMP1_MODE_EN(r)	(((r) & BIT(4)) >> 4)
+#define	COMP1_FIFO_DEPTH_GLOBAL(r)	(((r) & GENMASK(3, 2)) >> 2)
+#define	COMP1_APB_DATA_WIDTH(r)	(((r) & GENMASK(1, 0)) >> 0)
+
+#define	COMP2_RX_WORDSIZE_3(r)	(((r) & GENMASK(12, 10)) >> 10)
+#define	COMP2_RX_WORDSIZE_2(r)	(((r) & GENMASK(9, 7)) >> 7)
+#define	COMP2_RX_WORDSIZE_1(r)	(((r) & GENMASK(5, 3)) >> 3)
+#define	COMP2_RX_WORDSIZE_0(r)	(((r) & GENMASK(2, 0)) >> 0)
+
+/* Number of entries in WORDSIZE and DATA_WIDTH parameter registers */
+#define	COMP_MAX_WORDSIZE	(1 << 3)
+#define	COMP_MAX_DATA_WIDTH	(1 << 2)
+
+#define MAX_CHANNEL_NUM		8
+#define MIN_CHANNEL_NUM		2
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
+	union dw_i2s_snd_dma_data play_dma_data;
+	union dw_i2s_snd_dma_data capture_dma_data;
+	struct i2s_clk_config_data config;
+	int (*i2s_clk_cfg)(struct i2s_clk_config_data *config);
+
+	/* data related to PIO transfers (TX) */
+	bool use_pio;
+	struct snd_pcm_substream __rcu *tx_substream;
+	unsigned int (*tx_fn)(struct dw_i2s_dev *dev,
+			struct snd_pcm_runtime *runtime, unsigned int tx_ptr,
+			bool *period_elapsed);
+	unsigned int tx_ptr;
+};
+
+#if IS_ENABLED(CONFIG_SND_DESIGNWARE_PCM)
+void dw_pcm_push_tx(struct dw_i2s_dev *dev);
+int dw_pcm_register(struct platform_device *pdev);
+#else
+void dw_pcm_push_tx(struct dw_i2s_dev *dev) { }
+int dw_pcm_register(struct platform_device *pdev)
+{
+	return -EINVAL;
+}
+#endif
+
+#endif
-- 
1.9.1
