From: Scott Jiang <scott.jiang.linux@gmail.com>
Subject: [PATCH] asoc: bfin: add i2s driver for blackfin bf60x
	processor
Date: Mon, 4 Jun 2012 16:03:19 -0400
Message-ID: <1338840199-19714-1-git-send-email-scott.jiang.linux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tx2outboundpool.messaging.microsoft.com
	(tx2ehsobe004.messaging.microsoft.com [65.55.88.14])
	by alsa0.perex.cz (Postfix) with ESMTP id 60289103F6C
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Jun 2012 09:41:25 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, uclinux-dist-devel@blackfin.uclinux.org
Cc: Scott Jiang <scott.jiang.linux@gmail.com>
List-Id: alsa-devel@alsa-project.org

This driver includes i2s dai, dma and sport driver. It enables i2s
mode support on blackfin bf60x platform.

Signed-off-by: Scott Jiang <scott.jiang.linux@gmail.com>
---
 sound/soc/blackfin/Kconfig         |   25 ++-
 sound/soc/blackfin/Makefile        |    6 +
 sound/soc/blackfin/bf6xx-i2s-pcm.c |  294 +++++++++++++++++++++++++
 sound/soc/blackfin/bf6xx-i2s.c     |  245 +++++++++++++++++++++
 sound/soc/blackfin/bf6xx-sport.c   |  422 ++++++++++++++++++++++++++++++++++++
 sound/soc/blackfin/bf6xx-sport.h   |   82 +++++++
 6 files changed, 1070 insertions(+), 4 deletions(-)
 create mode 100644 sound/soc/blackfin/bf6xx-i2s-pcm.c
 create mode 100644 sound/soc/blackfin/bf6xx-i2s.c
 create mode 100644 sound/soc/blackfin/bf6xx-sport.c
 create mode 100644 sound/soc/blackfin/bf6xx-sport.h

diff --git a/sound/soc/blackfin/Kconfig b/sound/soc/blackfin/Kconfig
index 9f6bc55..2822b6a 100644
--- a/sound/soc/blackfin/Kconfig
+++ b/sound/soc/blackfin/Kconfig
@@ -1,6 +1,6 @@
 config SND_BF5XX_I2S
 	tristate "SoC I2S Audio for the ADI BF5xx chip"
-	depends on BLACKFIN
+	depends on BLACKFIN && !BF60x
 	select SND_BF5XX_SOC_SPORT
 	help
 	  Say Y or M if you want to add support for codecs attached to
@@ -8,10 +8,21 @@ config SND_BF5XX_I2S
 	  mode (supports single stereo In/Out).
 	  You will also need to select the audio interfaces to support below.
 
+config SND_BF6XX_I2S
+	tristate "SoC I2S Audio for the ADI BF6xx chip"
+	depends on BLACKFIN && BF60x
+	select SND_BF6XX_SOC_SPORT
+	help
+	  Say Y or M if you want to add support for codecs attached to
+	  the Blackfin SPORT (synchronous serial ports) interface in I2S
+	  mode (supports single stereo In/Out).
+	  You will also need to select the audio interfaces to support below.
+
 config SND_BF5XX_SOC_SSM2602
 	tristate "SoC SSM2602 Audio support for BF52x ezkit"
-	depends on SND_BF5XX_I2S && (SPI_MASTER || I2C)
-	select SND_BF5XX_SOC_I2S
+	depends on (SND_BF5XX_I2S || SND_BF6XX_I2S) && (SPI_MASTER || I2C)
+	select SND_BF5XX_SOC_I2S if SND_BF5XX_I2S
+	select SND_BF6XX_SOC_I2S if SND_BF6XX_I2S
 	select SND_SOC_SSM2602
 	help
 	  Say Y if you want to add support for SoC audio on BF527-EZKIT.
@@ -162,9 +173,15 @@ config SND_BF5XX_SOC_AD1980
 config SND_BF5XX_SOC_SPORT
 	tristate
 
+config SND_BF6XX_SOC_SPORT
+	tristate
+
 config SND_BF5XX_SOC_I2S
 	tristate
 
+config SND_BF6XX_SOC_I2S
+	tristate
+
 config SND_BF5XX_SOC_TDM
 	tristate
 
@@ -173,7 +190,7 @@ config SND_BF5XX_SOC_AC97
 
 config SND_BF5XX_SPORT_NUM
 	int "Set a SPORT for Sound chip"
-	depends on (SND_BF5XX_I2S || SND_BF5XX_AC97 || SND_BF5XX_TDM)
+	depends on (BLACKFIN && SND_SOC)
 	range 0 3 if BF54x
 	range 0 1 if !BF54x
 	default 0
diff --git a/sound/soc/blackfin/Makefile b/sound/soc/blackfin/Makefile
index 1bf86cc..a05335a 100644
--- a/sound/soc/blackfin/Makefile
+++ b/sound/soc/blackfin/Makefile
@@ -1,18 +1,24 @@
 # Blackfin Platform Support
 snd-bf5xx-ac97-objs := bf5xx-ac97-pcm.o
 snd-bf5xx-i2s-objs := bf5xx-i2s-pcm.o
+snd-bf6xx-i2s-objs := bf6xx-i2s-pcm.o
 snd-bf5xx-tdm-objs := bf5xx-tdm-pcm.o
 snd-soc-bf5xx-sport-objs := bf5xx-sport.o
+snd-soc-bf6xx-sport-objs := bf6xx-sport.o
 snd-soc-bf5xx-ac97-objs := bf5xx-ac97.o
 snd-soc-bf5xx-i2s-objs := bf5xx-i2s.o
+snd-soc-bf6xx-i2s-objs := bf6xx-i2s.o
 snd-soc-bf5xx-tdm-objs := bf5xx-tdm.o
 
 obj-$(CONFIG_SND_BF5XX_AC97) += snd-bf5xx-ac97.o
 obj-$(CONFIG_SND_BF5XX_I2S) += snd-bf5xx-i2s.o
+obj-$(CONFIG_SND_BF6XX_I2S) += snd-bf6xx-i2s.o
 obj-$(CONFIG_SND_BF5XX_TDM) += snd-bf5xx-tdm.o
 obj-$(CONFIG_SND_BF5XX_SOC_SPORT) += snd-soc-bf5xx-sport.o
+obj-$(CONFIG_SND_BF6XX_SOC_SPORT) += snd-soc-bf6xx-sport.o
 obj-$(CONFIG_SND_BF5XX_SOC_AC97) += snd-soc-bf5xx-ac97.o
 obj-$(CONFIG_SND_BF5XX_SOC_I2S) += snd-soc-bf5xx-i2s.o
+obj-$(CONFIG_SND_BF6XX_SOC_I2S) += snd-soc-bf6xx-i2s.o
 obj-$(CONFIG_SND_BF5XX_SOC_TDM) += snd-soc-bf5xx-tdm.o
 
 # Blackfin Machine Support
diff --git a/sound/soc/blackfin/bf6xx-i2s-pcm.c b/sound/soc/blackfin/bf6xx-i2s-pcm.c
new file mode 100644
index 0000000..cc3216f
--- /dev/null
+++ b/sound/soc/blackfin/bf6xx-i2s-pcm.c
@@ -0,0 +1,294 @@
+/*
+ * bf6xx-i2s-pcm.c - Analog Devices BF6XX i2s dma driver
+ *
+ * Copyright (c) 2012 Analog Devices Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/mm.h>
+#include <linux/types.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-dai.h>
+
+#include "bf6xx-sport.h"
+
+
+#include <linux/dma-mapping.h>
+#include <linux/gfp.h>
+#include <asm/dma.h>
+
+static void bfin_dma_irq(void *data)
+{
+	struct snd_pcm_substream *pcm = data;
+	snd_pcm_period_elapsed(pcm);
+}
+
+static const struct snd_pcm_hardware bfin_pcm_hardware = {
+	.info			= SNDRV_PCM_INFO_INTERLEAVED |
+				   SNDRV_PCM_INFO_MMAP |
+				   SNDRV_PCM_INFO_MMAP_VALID |
+				   SNDRV_PCM_INFO_BLOCK_TRANSFER,
+	.formats		= SNDRV_PCM_FMTBIT_S16_LE |
+				   SNDRV_PCM_FMTBIT_S24_LE |
+				   SNDRV_PCM_FMTBIT_S32_LE,
+	.period_bytes_min	= 32,
+	.period_bytes_max	= 0x10000,
+	.periods_min		= 1,
+	.periods_max		= PAGE_SIZE/32,
+	.buffer_bytes_max	= 0x20000, /* 128 kbytes */
+	.fifo_size		= 16,
+};
+
+static int bfin_pcm_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params)
+{
+	size_t size = bfin_pcm_hardware.buffer_bytes_max;
+	snd_pcm_lib_malloc_pages(substream, size);
+
+	return 0;
+}
+
+static int bfin_pcm_hw_free(struct snd_pcm_substream *substream)
+{
+	snd_pcm_lib_free_pages(substream);
+
+	return 0;
+}
+
+static int bfin_pcm_prepare(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct sport_device *sport = runtime->private_data;
+	int period_bytes = frames_to_bytes(runtime, runtime->period_size);
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		sport_set_tx_callback(sport, bfin_dma_irq, substream);
+		sport_config_tx_dma(sport, runtime->dma_area,
+			runtime->periods, period_bytes);
+	} else {
+		sport_set_rx_callback(sport, bfin_dma_irq, substream);
+		sport_config_rx_dma(sport, runtime->dma_area,
+			runtime->periods, period_bytes);
+	}
+
+	return 0;
+}
+
+static int bfin_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct sport_device *sport = runtime->private_data;
+	int ret = 0;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+			sport_tx_start(sport);
+		else
+			sport_rx_start(sport);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+			sport_tx_stop(sport);
+		else
+			sport_rx_stop(sport);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static snd_pcm_uframes_t bfin_pcm_pointer(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct sport_device *sport = runtime->private_data;
+	unsigned int diff;
+	snd_pcm_uframes_t frames;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		diff = sport_curr_offset_tx(sport);
+	} else {
+		diff = sport_curr_offset_rx(sport);
+	}
+
+	/*
+	 * TX at least can report one frame beyond the end of the
+	 * buffer if we hit the wraparound case - clamp to within the
+	 * buffer as the ALSA APIs require.
+	 */
+	if (diff == snd_pcm_lib_buffer_bytes(substream))
+		diff = 0;
+
+	frames = bytes_to_frames(substream->runtime, diff);
+
+	return frames;
+}
+
+static int bfin_pcm_open(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct sport_device *sport = snd_soc_dai_get_drvdata(cpu_dai);
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	int ret;
+
+	snd_soc_set_runtime_hwparams(substream, &bfin_pcm_hardware);
+
+	ret = snd_pcm_hw_constraint_integer(runtime,
+			SNDRV_PCM_HW_PARAM_PERIODS);
+	if (ret < 0)
+		return ret;
+
+	runtime->private_data = sport;
+	return 0;
+}
+
+static int bfin_pcm_mmap(struct snd_pcm_substream *substream,
+	struct vm_area_struct *vma)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	size_t size = vma->vm_end - vma->vm_start;
+	vma->vm_start = (unsigned long)runtime->dma_area;
+	vma->vm_end = vma->vm_start + size;
+	vma->vm_flags |=  VM_SHARED;
+
+	return 0 ;
+}
+
+static struct snd_pcm_ops bfin_pcm_i2s_ops = {
+	.open		= bfin_pcm_open,
+	.ioctl		= snd_pcm_lib_ioctl,
+	.hw_params	= bfin_pcm_hw_params,
+	.hw_free	= bfin_pcm_hw_free,
+	.prepare	= bfin_pcm_prepare,
+	.trigger	= bfin_pcm_trigger,
+	.pointer	= bfin_pcm_pointer,
+	.mmap		= bfin_pcm_mmap,
+};
+
+static int bfin_pcm_preallocate_dma_buffer(struct snd_pcm *pcm, int stream)
+{
+	struct snd_pcm_substream *substream = pcm->streams[stream].substream;
+	struct snd_dma_buffer *buf = &substream->dma_buffer;
+	size_t size = bfin_pcm_hardware.buffer_bytes_max;
+
+	buf->dev.type = SNDRV_DMA_TYPE_DEV;
+	buf->dev.dev = pcm->card->dev;
+	buf->private_data = NULL;
+	buf->area = dma_alloc_coherent(pcm->card->dev, size,
+			&buf->addr, GFP_KERNEL);
+	if (!buf->area)
+		return -ENOMEM;
+	buf->bytes = size;
+
+	return 0;
+}
+
+static void bfin_pcm_free_dma_buffers(struct snd_pcm *pcm)
+{
+	struct snd_pcm_substream *substream;
+	struct snd_dma_buffer *buf;
+	int stream;
+
+	for (stream = 0; stream < 2; stream++) {
+		substream = pcm->streams[stream].substream;
+		if (!substream)
+			continue;
+
+		buf = &substream->dma_buffer;
+		if (!buf->area)
+			continue;
+		dma_free_coherent(NULL, buf->bytes, buf->area, 0);
+		buf->area = NULL;
+	}
+}
+
+static u64 bfin_pcm_dmamask = DMA_BIT_MASK(32);
+
+int bfin_pcm_i2s_new(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_card *card = rtd->card->snd_card;
+	struct snd_soc_dai *dai = rtd->cpu_dai;
+	struct snd_pcm *pcm = rtd->pcm;
+	int ret = 0;
+
+	if (!card->dev->dma_mask)
+		card->dev->dma_mask = &bfin_pcm_dmamask;
+	if (!card->dev->coherent_dma_mask)
+		card->dev->coherent_dma_mask = DMA_BIT_MASK(32);
+
+	if (dai->driver->playback.channels_min) {
+		ret = bfin_pcm_preallocate_dma_buffer(pcm,
+			SNDRV_PCM_STREAM_PLAYBACK);
+		if (ret)
+			return ret;
+	}
+
+	if (dai->driver->capture.channels_min)
+		ret = bfin_pcm_preallocate_dma_buffer(pcm,
+			SNDRV_PCM_STREAM_CAPTURE);
+	return ret;
+}
+
+static struct snd_soc_platform_driver bfin_i2s_soc_platform = {
+	.ops		= &bfin_pcm_i2s_ops,
+	.pcm_new	= bfin_pcm_i2s_new,
+	.pcm_free	= bfin_pcm_free_dma_buffers,
+};
+
+static int __devinit bfin_i2s_soc_platform_probe(struct platform_device *pdev)
+{
+	return snd_soc_register_platform(&pdev->dev, &bfin_i2s_soc_platform);
+}
+
+static int __devexit bfin_i2s_soc_platform_remove(struct platform_device *pdev)
+{
+	snd_soc_unregister_platform(&pdev->dev);
+	return 0;
+}
+
+static struct platform_driver bfin_i2s_pcm_driver = {
+	.driver = {
+		.name = "bfin-i2s-pcm-audio",
+		.owner = THIS_MODULE,
+	},
+	.probe = bfin_i2s_soc_platform_probe,
+	.remove = __devexit_p(bfin_i2s_soc_platform_remove),
+};
+
+static int __init snd_bfin_i2s_pcm_init(void)
+{
+	return platform_driver_register(&bfin_i2s_pcm_driver);
+}
+module_init(snd_bfin_i2s_pcm_init);
+
+static void __exit snd_bfin_i2s_pcm_exit(void)
+{
+	platform_driver_unregister(&bfin_i2s_pcm_driver);
+}
+module_exit(snd_bfin_i2s_pcm_exit);
+
+MODULE_DESCRIPTION("Analog Devices BF6XX i2s dma driver");
+MODULE_AUTHOR("Scott Jiang <Scott.Jiang.Linux@gmail.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/blackfin/bf6xx-i2s.c b/sound/soc/blackfin/bf6xx-i2s.c
new file mode 100644
index 0000000..c4a5499
--- /dev/null
+++ b/sound/soc/blackfin/bf6xx-i2s.c
@@ -0,0 +1,245 @@
+/*
+ * bf6xx-i2s.c - Analog Devices BF6XX i2s interface driver
+ *
+ * Copyright (c) 2012 Analog Devices Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-dai.h>
+
+#include "bf6xx-sport.h"
+
+struct sport_params param;
+
+static int bfin_i2s_set_dai_fmt(struct snd_soc_dai *cpu_dai,
+		unsigned int fmt)
+{
+	struct sport_device *sport = snd_soc_dai_get_drvdata(cpu_dai);
+	struct device *dev = &sport->pdev->dev;
+	int ret = 0;
+
+	param.spctl &= ~(SPORT_CTL_OPMODE | SPORT_CTL_CKRE | SPORT_CTL_FSR
+			| SPORT_CTL_LFS | SPORT_CTL_LAFS);
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		param.spctl |= SPORT_CTL_OPMODE | SPORT_CTL_CKRE
+			| SPORT_CTL_LFS;
+		break;
+	case SND_SOC_DAIFMT_DSP_A:
+		param.spctl |= SPORT_CTL_FSR;
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		param.spctl |= SPORT_CTL_OPMODE | SPORT_CTL_LFS
+			| SPORT_CTL_LAFS;
+		break;
+	default:
+		dev_err(dev, "%s: Unknown DAI format type\n", __func__);
+		ret = -EINVAL;
+		break;
+	}
+
+	param.spctl &= ~(SPORT_CTL_ICLK | SPORT_CTL_IFS);
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBM_CFM:
+		break;
+	case SND_SOC_DAIFMT_CBS_CFS:
+	case SND_SOC_DAIFMT_CBM_CFS:
+	case SND_SOC_DAIFMT_CBS_CFM:
+		ret = -EINVAL;
+		break;
+	default:
+		dev_err(dev, "%s: Unknown DAI master type\n", __func__);
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static int bfin_i2s_hw_params(struct snd_pcm_substream *substream,
+				struct snd_pcm_hw_params *params,
+				struct snd_soc_dai *dai)
+{
+	struct sport_device *sport = snd_soc_dai_get_drvdata(dai);
+	struct device *dev = &sport->pdev->dev;
+	int ret = 0;
+
+	param.spctl &= ~SPORT_CTL_SLEN;
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S8:
+		param.spctl |= 0x70;
+		sport->wdsize = 1;
+	case SNDRV_PCM_FORMAT_S16_LE:
+		param.spctl |= 0xf0;
+		sport->wdsize = 2;
+		break;
+	case SNDRV_PCM_FORMAT_S24_LE:
+		param.spctl |= 0x170;
+		sport->wdsize = 3;
+		break;
+	case SNDRV_PCM_FORMAT_S32_LE:
+		param.spctl |= 0x1f0;
+		sport->wdsize = 4;
+		break;
+	}
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		ret = sport_set_tx_params(sport, &param);
+		if (ret) {
+			dev_err(dev, "SPORT tx is busy!\n");
+			return ret;
+		}
+	} else {
+		ret = sport_set_rx_params(sport, &param);
+		if (ret) {
+			dev_err(dev, "SPORT rx is busy!\n");
+			return ret;
+		}
+	}
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int bfin_i2s_suspend(struct snd_soc_dai *dai)
+{
+	struct sport_device *sport = snd_soc_dai_get_drvdata(dai);
+
+	if (dai->capture_active)
+		sport_rx_stop(sport);
+	if (dai->playback_active)
+		sport_tx_stop(sport);
+	return 0;
+}
+
+static int bfin_i2s_resume(struct snd_soc_dai *dai)
+{
+	struct sport_device *sport = snd_soc_dai_get_drvdata(dai);
+	struct device *dev = &sport->pdev->dev;
+	int ret;
+
+	ret = sport_set_tx_params(sport, &param);
+	if (ret) {
+		dev_err(dev, "SPORT tx is busy!\n");
+		return ret;
+	}
+	ret = sport_set_rx_params(sport, &param);
+	if (ret) {
+		dev_err(dev, "SPORT rx is busy!\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+#else
+#define bfin_i2s_suspend NULL
+#define bfin_i2s_resume NULL
+#endif
+
+#define BFIN_I2S_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 |\
+		SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_22050 | \
+		SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 | \
+		SNDRV_PCM_RATE_96000)
+
+#define BFIN_I2S_FORMATS (SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_LE | \
+		SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE)
+
+static struct snd_soc_dai_ops bfin_i2s_dai_ops = {
+	.hw_params	= bfin_i2s_hw_params,
+	.set_fmt	= bfin_i2s_set_dai_fmt,
+};
+
+static struct snd_soc_dai_driver bfin_i2s_dai = {
+	.suspend = bfin_i2s_suspend,
+	.resume = bfin_i2s_resume,
+	.playback = {
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = BFIN_I2S_RATES,
+		.formats = BFIN_I2S_FORMATS,
+	},
+	.capture = {
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = BFIN_I2S_RATES,
+		.formats = BFIN_I2S_FORMATS,
+	},
+	.ops = &bfin_i2s_dai_ops,
+};
+
+static int __devinit bfin_i2s_probe(struct platform_device *pdev)
+{
+	struct sport_device *sport;
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	sport = sport_create(pdev);
+	if (!sport)
+		return -ENODEV;
+
+	/* register with the ASoC layers */
+	ret = snd_soc_register_dai(dev, &bfin_i2s_dai);
+	if (ret) {
+		dev_err(dev, "Failed to register DAI: %d\n", ret);
+		sport_delete(sport);
+		return ret;
+	}
+	platform_set_drvdata(pdev, sport);
+
+	return 0;
+}
+
+static int __devexit bfin_i2s_remove(struct platform_device *pdev)
+{
+	struct sport_device *sport = platform_get_drvdata(pdev);
+
+	snd_soc_unregister_dai(&pdev->dev);
+	sport_delete(sport);
+
+	return 0;
+}
+
+static struct platform_driver bfin_i2s_driver = {
+	.probe  = bfin_i2s_probe,
+	.remove = __devexit_p(bfin_i2s_remove),
+	.driver = {
+		.name = "bfin-i2s",
+		.owner = THIS_MODULE,
+	},
+};
+
+static int __init bfin_i2s_init(void)
+{
+	return platform_driver_register(&bfin_i2s_driver);
+}
+
+static void __exit bfin_i2s_exit(void)
+{
+	platform_driver_unregister(&bfin_i2s_driver);
+}
+
+module_init(bfin_i2s_init);
+module_exit(bfin_i2s_exit);
+
+MODULE_DESCRIPTION("Analog Devices BF6XX i2s interface driver");
+MODULE_AUTHOR("Scott Jiang <Scott.Jiang.Linux@gmail.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/blackfin/bf6xx-sport.c b/sound/soc/blackfin/bf6xx-sport.c
new file mode 100644
index 0000000..ea4b844
--- /dev/null
+++ b/sound/soc/blackfin/bf6xx-sport.c
@@ -0,0 +1,422 @@
+/*
+ * bf6xx_sport.c Analog Devices BF6XX SPORT driver
+ *
+ * Copyright (c) 2012 Analog Devices Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#include <asm/blackfin.h>
+#include <asm/dma.h>
+#include <asm/portmux.h>
+
+#include "bf6xx-sport.h"
+
+int sport_set_tx_params(struct sport_device *sport,
+			struct sport_params *params)
+{
+	if (sport->tx_regs->spctl & SPORT_CTL_SPENPRI)
+		return -EBUSY;
+	sport->tx_regs->spctl = params->spctl | SPORT_CTL_SPTRAN;
+	sport->tx_regs->div = params->div;
+	SSYNC();
+	return 0;
+}
+EXPORT_SYMBOL(sport_set_tx_params);
+
+int sport_set_rx_params(struct sport_device *sport,
+			struct sport_params *params)
+{
+	if (sport->rx_regs->spctl & SPORT_CTL_SPENPRI)
+		return -EBUSY;
+	sport->rx_regs->spctl = params->spctl & ~SPORT_CTL_SPTRAN;
+	sport->rx_regs->div = params->div;
+	SSYNC();
+	return 0;
+}
+EXPORT_SYMBOL(sport_set_rx_params);
+
+static int compute_wdsize(size_t wdsize)
+{
+	switch (wdsize) {
+	case 1:
+		return WDSIZE_8 | PSIZE_8;
+	case 2:
+		return WDSIZE_16 | PSIZE_16;
+	default:
+		return WDSIZE_32 | PSIZE_32;
+	}
+}
+
+void sport_tx_start(struct sport_device *sport)
+{
+	set_dma_next_desc_addr(sport->tx_dma_chan, sport->tx_desc);
+	set_dma_config(sport->tx_dma_chan, DMAFLOW_LIST | DI_EN
+			| compute_wdsize(sport->wdsize) | NDSIZE_6);
+	enable_dma(sport->tx_dma_chan);
+	sport->tx_regs->spctl |= SPORT_CTL_SPENPRI;
+	SSYNC();
+}
+EXPORT_SYMBOL(sport_tx_start);
+
+void sport_rx_start(struct sport_device *sport)
+{
+	set_dma_next_desc_addr(sport->rx_dma_chan, sport->rx_desc);
+	set_dma_config(sport->rx_dma_chan, DMAFLOW_LIST | DI_EN | WNR
+			| compute_wdsize(sport->wdsize) | NDSIZE_6);
+	enable_dma(sport->rx_dma_chan);
+	sport->rx_regs->spctl |= SPORT_CTL_SPENPRI;
+	SSYNC();
+}
+EXPORT_SYMBOL(sport_rx_start);
+
+void sport_tx_stop(struct sport_device *sport)
+{
+	sport->tx_regs->spctl &= ~SPORT_CTL_SPENPRI;
+	SSYNC();
+	disable_dma(sport->tx_dma_chan);
+}
+EXPORT_SYMBOL(sport_tx_stop);
+
+void sport_rx_stop(struct sport_device *sport)
+{
+	sport->rx_regs->spctl &= ~SPORT_CTL_SPENPRI;
+	SSYNC();
+	disable_dma(sport->rx_dma_chan);
+}
+EXPORT_SYMBOL(sport_rx_stop);
+
+void sport_set_tx_callback(struct sport_device *sport,
+		void (*tx_callback)(void *), void *tx_data)
+{
+	sport->tx_callback = tx_callback;
+	sport->tx_data = tx_data;
+}
+EXPORT_SYMBOL(sport_set_tx_callback);
+
+void sport_set_rx_callback(struct sport_device *sport,
+		void (*rx_callback)(void *), void *rx_data)
+{
+	sport->rx_callback = rx_callback;
+	sport->rx_data = rx_data;
+}
+EXPORT_SYMBOL(sport_set_rx_callback);
+
+static void setup_desc(struct dmasg *desc, void *buf, int fragcount,
+		size_t fragsize, unsigned int cfg,
+		unsigned int count, size_t wdsize)
+{
+
+	int i;
+
+	for (i = 0; i < fragcount; ++i) {
+		desc[i].next_desc_addr  = &(desc[i + 1]);
+		desc[i].start_addr = (unsigned long)buf + i*fragsize;
+		desc[i].cfg = cfg;
+		desc[i].x_count = count;
+		desc[i].x_modify = wdsize;
+		desc[i].y_count = 0;
+		desc[i].y_modify = 0;
+	}
+
+	/* make circular */
+	desc[fragcount-1].next_desc_addr = desc;
+}
+
+int sport_config_tx_dma(struct sport_device *sport, void *buf,
+		int fragcount, size_t fragsize)
+{
+	unsigned int count;
+	unsigned int cfg;
+	dma_addr_t addr;
+
+	count = fragsize/sport->wdsize;
+
+	if (sport->tx_desc)
+		dma_free_coherent(NULL, sport->tx_desc_size,
+				sport->tx_desc, 0);
+
+	sport->tx_desc = dma_alloc_coherent(NULL,
+			fragcount * sizeof(struct dmasg), &addr, 0);
+	sport->tx_desc_size = fragcount * sizeof(struct dmasg);
+	if (!sport->tx_desc)
+		return -ENOMEM;
+
+	sport->tx_buf = buf;
+	sport->tx_fragsize = fragsize;
+	sport->tx_frags = fragcount;
+	cfg = DMAFLOW_LIST | DI_EN | compute_wdsize(sport->wdsize) | NDSIZE_6;
+
+	setup_desc(sport->tx_desc, buf, fragcount, fragsize,
+			cfg|DMAEN, count, sport->wdsize);
+
+	return 0;
+}
+EXPORT_SYMBOL(sport_config_tx_dma);
+
+int sport_config_rx_dma(struct sport_device *sport, void *buf,
+		int fragcount, size_t fragsize)
+{
+	unsigned int count;
+	unsigned int cfg;
+	dma_addr_t addr;
+
+	count = fragsize/sport->wdsize;
+
+	if (sport->rx_desc)
+		dma_free_coherent(NULL, sport->rx_desc_size,
+				sport->rx_desc, 0);
+
+	sport->rx_desc = dma_alloc_coherent(NULL,
+			fragcount * sizeof(struct dmasg), &addr, 0);
+	sport->rx_desc_size = fragcount * sizeof(struct dmasg);
+	if (!sport->rx_desc)
+		return -ENOMEM;
+
+	sport->rx_buf = buf;
+	sport->rx_fragsize = fragsize;
+	sport->rx_frags = fragcount;
+	cfg = DMAFLOW_LIST | DI_EN | compute_wdsize(sport->wdsize)
+		| WNR | NDSIZE_6;
+
+	setup_desc(sport->rx_desc, buf, fragcount, fragsize,
+			cfg|DMAEN, count, sport->wdsize);
+
+	return 0;
+}
+EXPORT_SYMBOL(sport_config_rx_dma);
+
+unsigned long sport_curr_offset_tx(struct sport_device *sport)
+{
+	unsigned long curr = get_dma_curr_addr(sport->tx_dma_chan);
+
+	return (unsigned char *)curr - sport->tx_buf;
+}
+EXPORT_SYMBOL(sport_curr_offset_tx);
+
+unsigned long sport_curr_offset_rx(struct sport_device *sport)
+{
+	unsigned long curr = get_dma_curr_addr(sport->rx_dma_chan);
+
+	return (unsigned char *)curr - sport->rx_buf;
+}
+EXPORT_SYMBOL(sport_curr_offset_rx);
+
+static irqreturn_t sport_tx_irq(int irq, void *dev_id)
+{
+	struct sport_device *sport = dev_id;
+	static unsigned long status;
+
+	status = get_dma_curr_irqstat(sport->tx_dma_chan);
+	if (status & (DMA_DONE|DMA_ERR)) {
+		clear_dma_irqstat(sport->tx_dma_chan);
+		SSYNC();
+	}
+	if (sport->tx_callback)
+		sport->tx_callback(sport->tx_data);
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t sport_rx_irq(int irq, void *dev_id)
+{
+	struct sport_device *sport = dev_id;
+	unsigned long status;
+
+	status = get_dma_curr_irqstat(sport->rx_dma_chan);
+	if (status & (DMA_DONE|DMA_ERR)) {
+		clear_dma_irqstat(sport->rx_dma_chan);
+		SSYNC();
+	}
+	if (sport->rx_callback)
+		sport->rx_callback(sport->rx_data);
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t sport_err_irq(int irq, void *dev_id)
+{
+	struct sport_device *sport = dev_id;
+	struct device *dev = &sport->pdev->dev;
+
+	if (sport->tx_regs->spctl & SPORT_CTL_DERRPRI)
+		dev_dbg(dev, "sport error: TUVF\n");
+	if (sport->rx_regs->spctl & SPORT_CTL_DERRPRI)
+		dev_dbg(dev, "sport error: ROVF\n");
+
+	return IRQ_HANDLED;
+}
+
+static int sport_get_resource(struct sport_device *sport)
+{
+	struct platform_device *pdev = sport->pdev;
+	struct device *dev = &pdev->dev;
+	struct bfin_snd_platform_data *pdata = dev->platform_data;
+	struct resource *res;
+
+	if (!pdata) {
+		dev_err(dev, "No platform data\n");
+		return -ENODEV;
+	}
+	sport->pin_req = pdata->pin_req;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(dev, "No tx MEM resource\n");
+		return -ENODEV;
+	}
+	sport->tx_regs = (struct sport_register *)res->start;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (!res) {
+		dev_err(dev, "No rx MEM resource\n");
+		return -ENODEV;
+	}
+	sport->rx_regs = (struct sport_register *)res->start;
+
+	res = platform_get_resource(pdev, IORESOURCE_DMA, 0);
+	if (!res) {
+		dev_err(dev, "No tx DMA resource\n");
+		return -ENODEV;
+	}
+	sport->tx_dma_chan = res->start;
+
+	res = platform_get_resource(pdev, IORESOURCE_DMA, 1);
+	if (!res) {
+		dev_err(dev, "No rx DMA resource\n");
+		return -ENODEV;
+	}
+	sport->rx_dma_chan = res->start;
+
+	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (!res) {
+		dev_err(dev, "No tx error irq resource\n");
+		return -ENODEV;
+	}
+	sport->tx_err_irq = res->start;
+
+	res = platform_get_resource(pdev, IORESOURCE_IRQ, 1);
+	if (!res) {
+		dev_err(dev, "No rx error irq resource\n");
+		return -ENODEV;
+	}
+	sport->rx_err_irq = res->start;
+
+	return 0;
+}
+
+static int sport_request_resource(struct sport_device *sport)
+{
+	struct device *dev = &sport->pdev->dev;
+	int ret;
+
+	ret = peripheral_request_list(sport->pin_req, "soc-audio");
+	if (ret) {
+		dev_err(dev, "Unable to request sport pin\n");
+		return ret;
+	}
+
+	ret = request_dma(sport->tx_dma_chan, "SPORT TX Data");
+	if (ret) {
+		dev_err(dev, "Unable to allocate DMA channel for sport tx\n");
+		goto err_tx_dma;
+	}
+	set_dma_callback(sport->tx_dma_chan, sport_tx_irq, sport);
+
+	ret = request_dma(sport->rx_dma_chan, "SPORT RX Data");
+	if (ret) {
+		dev_err(dev, "Unable to allocate DMA channel for sport rx\n");
+		goto err_rx_dma;
+	}
+	set_dma_callback(sport->rx_dma_chan, sport_rx_irq, sport);
+
+	ret = request_irq(sport->tx_err_irq, sport_err_irq,
+			0, "SPORT TX ERROR", sport);
+	if (ret) {
+		dev_err(dev, "Unable to allocate tx error IRQ for sport\n");
+		goto err_tx_irq;
+	}
+
+	ret = request_irq(sport->rx_err_irq, sport_err_irq,
+			0, "SPORT RX ERROR", sport);
+	if (ret) {
+		dev_err(dev, "Unable to allocate rx error IRQ for sport\n");
+		goto err_rx_irq;
+	}
+
+	return 0;
+err_rx_irq:
+	free_irq(sport->tx_err_irq, sport);
+err_tx_irq:
+	free_dma(sport->rx_dma_chan);
+err_rx_dma:
+	free_dma(sport->tx_dma_chan);
+err_tx_dma:
+	peripheral_free_list(sport->pin_req);
+	return ret;
+}
+
+static void sport_free_resource(struct sport_device *sport)
+{
+	free_irq(sport->rx_err_irq, sport);
+	free_irq(sport->tx_err_irq, sport);
+	free_dma(sport->rx_dma_chan);
+	free_dma(sport->tx_dma_chan);
+	peripheral_free_list(sport->pin_req);
+}
+
+struct sport_device *sport_create(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct sport_device *sport;
+	int ret;
+
+	sport = kzalloc(sizeof(*sport), GFP_KERNEL);
+	if (!sport) {
+		dev_err(dev, "Unable to allocate memory for sport device\n");
+		return NULL;
+	}
+	sport->pdev = pdev;
+
+	ret = sport_get_resource(sport);
+	if (ret) {
+		kfree(sport);
+		return NULL;
+	}
+
+	ret = sport_request_resource(sport);
+	if (ret) {
+		kfree(sport);
+		return NULL;
+	}
+
+	dev_info(dev, "SPORT create success\n");
+	return sport;
+}
+EXPORT_SYMBOL(sport_create);
+
+void sport_delete(struct sport_device *sport)
+{
+	sport_free_resource(sport);
+}
+EXPORT_SYMBOL(sport_delete);
+
+MODULE_DESCRIPTION("Analog Devices BF6XX SPORT driver");
+MODULE_AUTHOR("Scott Jiang <Scott.Jiang.Linux@gmail.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/blackfin/bf6xx-sport.h b/sound/soc/blackfin/bf6xx-sport.h
new file mode 100644
index 0000000..307d193
--- /dev/null
+++ b/sound/soc/blackfin/bf6xx-sport.h
@@ -0,0 +1,82 @@
+/*
+ * bf6xx_sport - Analog Devices BF6XX SPORT driver
+ *
+ * Copyright (c) 2012 Analog Devices Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#ifndef _BF6XX_SPORT_H_
+#define _BF6XX_SPORT_H_
+
+#include <linux/platform_device.h>
+#include <asm/bfin_sport3.h>
+
+struct sport_device {
+	struct platform_device *pdev;
+	const unsigned short *pin_req;
+	struct sport_register *tx_regs;
+	struct sport_register *rx_regs;
+	int tx_dma_chan;
+	int rx_dma_chan;
+	int tx_err_irq;
+	int rx_err_irq;
+
+	void (*tx_callback)(void *data);
+	void *tx_data;
+	void (*rx_callback)(void *data);
+	void *rx_data;
+
+	struct dmasg *tx_desc;
+	struct dmasg *rx_desc;
+	unsigned int tx_desc_size;
+	unsigned int rx_desc_size;
+	unsigned char *tx_buf;
+	unsigned char *rx_buf;
+	unsigned int tx_fragsize;
+	unsigned int rx_fragsize;
+	unsigned int tx_frags;
+	unsigned int rx_frags;
+	unsigned int wdsize;
+};
+
+struct sport_params {
+	u32 spctl;
+	u32 div;
+};
+
+struct sport_device *sport_create(struct platform_device *pdev);
+void sport_delete(struct sport_device *sport);
+int sport_set_tx_params(struct sport_device *sport,
+		struct sport_params *params);
+int sport_set_rx_params(struct sport_device *sport,
+		struct sport_params *params);
+void sport_tx_start(struct sport_device *sport);
+void sport_rx_start(struct sport_device *sport);
+void sport_tx_stop(struct sport_device *sport);
+void sport_rx_stop(struct sport_device *sport);
+void sport_set_tx_callback(struct sport_device *sport,
+	void (*tx_callback)(void *), void *tx_data);
+void sport_set_rx_callback(struct sport_device *sport,
+	void (*rx_callback)(void *), void *rx_data);
+int sport_config_tx_dma(struct sport_device *sport, void *buf,
+	int fragcount, size_t fragsize);
+int sport_config_rx_dma(struct sport_device *sport, void *buf,
+	int fragcount, size_t fragsize);
+unsigned long sport_curr_offset_tx(struct sport_device *sport);
+unsigned long sport_curr_offset_rx(struct sport_device *sport);
+
+
+
+#endif
-- 
1.7.0.4
