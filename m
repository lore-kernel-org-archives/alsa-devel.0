From: Scott Jiang <scott.jiang.linux@gmail.com>
Subject: [PATCH] ASoC: blackfin: add bf6xx audio dma driver
Date: Wed, 24 Sep 2014 17:55:20 +0800
Message-ID: <1411552520-26090-1-git-send-email-scott.jiang.linux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0087.outbound.protection.outlook.com [157.56.110.87])
 by alsa0.perex.cz (Postfix) with ESMTP id CF2ED261AE4
 for <alsa-devel@alsa-project.org>; Tue, 23 Sep 2014 11:58:34 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Scott Jiang <scott.jiang.linux@gmail.com>
List-Id: alsa-devel@alsa-project.org

Bf5xx and bf6xx reused bf5xx-i2s-pcm.c before. Recently tdm driver
has been merged into bf5xx-i2s-pcm.c and it's not compatible with
bf6xx audio. So create this dma driver and add tdm support later.

Signed-off-by: Scott Jiang <scott.jiang.linux@gmail.com>
---
 sound/soc/blackfin/Kconfig     |   22 ++--
 sound/soc/blackfin/Makefile    |    2 +
 sound/soc/blackfin/bf6xx-pcm.c |  230 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 248 insertions(+), 6 deletions(-)
 create mode 100644 sound/soc/blackfin/bf6xx-pcm.c

diff --git a/sound/soc/blackfin/Kconfig b/sound/soc/blackfin/Kconfig
index 6410aa2..9d6bd9d 100644
--- a/sound/soc/blackfin/Kconfig
+++ b/sound/soc/blackfin/Kconfig
@@ -1,8 +1,17 @@
 config SND_BF5XX_I2S
 	tristate "SoC I2S Audio for the ADI Blackfin chip"
-	depends on BLACKFIN
-	select SND_BF5XX_SOC_SPORT if !BF60x
-	select SND_BF6XX_SOC_SPORT if BF60x
+	depends on BLACKFIN && !BF60x
+	select SND_BF5XX_SOC_SPORT
+	help
+	  Say Y or M if you want to add support for codecs attached to
+	  the Blackfin SPORT (synchronous serial ports) interface in I2S
+	  mode (supports single stereo In/Out).
+	  You will also need to select the audio interfaces to support below.
+
+config SND_BF6XX_PCM
+	tristate "SoC Audio for the ADI Blackfin BF6xx chip"
+	depends on BF60x
+	select SND_BF6XX_SOC_SPORT
 	help
 	  Say Y or M if you want to add support for codecs attached to
 	  the Blackfin SPORT (synchronous serial ports) interface in I2S
@@ -11,7 +20,7 @@ config SND_BF5XX_I2S
 
 config SND_BF5XX_SOC_SSM2602
 	tristate "SoC SSM2602 Audio Codec Add-On Card support"
-	depends on SND_BF5XX_I2S && SND_SOC_I2C_AND_SPI
+	depends on (SND_BF5XX_I2S || SND_BF6XX_PCM) && SND_SOC_I2C_AND_SPI
 	select SND_BF5XX_SOC_I2S if !BF60x
 	select SND_BF6XX_SOC_I2S if BF60x
 	select SND_SOC_SSM2602_SPI if SPI_MASTER
@@ -45,8 +54,9 @@ config SND_SOC_BFIN_EVAL_ADAU1373
 
 config SND_SOC_BFIN_EVAL_ADAU1X61
 	tristate "Support for the EVAL-ADAU1X61 board on Blackfin eval boards"
-	depends on SND_BF5XX_I2S && I2C
-	select SND_BF5XX_SOC_I2S
+	depends on (SND_BF5XX_I2S || SND_BF6XX_PCM) && I2C
+	select SND_BF5XX_SOC_I2S if !BF60x
+	select SND_BF6XX_SOC_I2S if BF60x
 	select SND_SOC_ADAU1761_I2C
 	help
 	  Say Y if you want to add support for the Analog Devices EVAL-ADAU1X61
diff --git a/sound/soc/blackfin/Makefile b/sound/soc/blackfin/Makefile
index f21e948..cef39f6 100644
--- a/sound/soc/blackfin/Makefile
+++ b/sound/soc/blackfin/Makefile
@@ -1,6 +1,7 @@
 # Blackfin Platform Support
 snd-bf5xx-ac97-objs := bf5xx-ac97-pcm.o
 snd-bf5xx-i2s-objs := bf5xx-i2s-pcm.o
+snd-bf6xx-pcm-objs := bf6xx-pcm.o
 snd-soc-bf5xx-sport-objs := bf5xx-sport.o
 snd-soc-bf6xx-sport-objs := bf6xx-sport.o
 snd-soc-bf5xx-ac97-objs := bf5xx-ac97.o
@@ -9,6 +10,7 @@ snd-soc-bf6xx-i2s-objs := bf6xx-i2s.o
 
 obj-$(CONFIG_SND_BF5XX_AC97) += snd-bf5xx-ac97.o
 obj-$(CONFIG_SND_BF5XX_I2S) += snd-bf5xx-i2s.o
+obj-$(CONFIG_SND_BF6XX_PCM) += snd-bf6xx-pcm.o
 obj-$(CONFIG_SND_BF5XX_SOC_SPORT) += snd-soc-bf5xx-sport.o
 obj-$(CONFIG_SND_BF6XX_SOC_SPORT) += snd-soc-bf6xx-sport.o
 obj-$(CONFIG_SND_BF5XX_SOC_AC97) += snd-soc-bf5xx-ac97.o
diff --git a/sound/soc/blackfin/bf6xx-pcm.c b/sound/soc/blackfin/bf6xx-pcm.c
new file mode 100644
index 0000000..bad9fbf
--- /dev/null
+++ b/sound/soc/blackfin/bf6xx-pcm.c
@@ -0,0 +1,230 @@
+/*
+ * bf6xx-pcm.c - Analog Devices BF6XX audio dma driver
+ *
+ * Copyright (c) 2014 Analog Devices Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
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
+static void bf6xx_dma_irq(void *data)
+{
+	struct snd_pcm_substream *pcm = data;
+	snd_pcm_period_elapsed(pcm);
+}
+
+static const struct snd_pcm_hardware bf6xx_pcm_hardware = {
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
+static int bf6xx_pcm_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params)
+{
+	size_t size = params_buffer_bytes(params);
+	snd_pcm_lib_malloc_pages(substream, size);
+
+	return 0;
+}
+
+static int bf6xx_pcm_hw_free(struct snd_pcm_substream *substream)
+{
+	snd_pcm_lib_free_pages(substream);
+
+	return 0;
+}
+
+static int bf6xx_pcm_prepare(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct sport_device *sport = runtime->private_data;
+	int period_bytes = frames_to_bytes(runtime, runtime->period_size);
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		sport_set_tx_callback(sport, bf6xx_dma_irq, substream);
+		sport_config_tx_dma(sport, runtime->dma_area,
+			runtime->periods, period_bytes);
+	} else {
+		sport_set_rx_callback(sport, bf6xx_dma_irq, substream);
+		sport_config_rx_dma(sport, runtime->dma_area,
+			runtime->periods, period_bytes);
+	}
+
+	return 0;
+}
+
+static int bf6xx_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
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
+static snd_pcm_uframes_t bf6xx_pcm_pointer(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct sport_device *sport = runtime->private_data;
+	unsigned int diff;
+	snd_pcm_uframes_t frames;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		diff = sport_curr_offset_tx(sport);
+	else
+		diff = sport_curr_offset_rx(sport);
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
+static int bf6xx_pcm_open(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct sport_device *sport = snd_soc_dai_get_drvdata(cpu_dai);
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct snd_dma_buffer *buf = &substream->dma_buffer;
+	int ret;
+
+	snd_soc_set_runtime_hwparams(substream, &bf6xx_pcm_hardware);
+
+	ret = snd_pcm_hw_constraint_integer(runtime,
+			SNDRV_PCM_HW_PARAM_PERIODS);
+	if (ret < 0)
+		return ret;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		sport->tx_buf = buf->area;
+	else
+		sport->rx_buf = buf->area;
+
+	runtime->private_data = sport;
+	return 0;
+}
+
+static int bf6xx_pcm_mmap(struct snd_pcm_substream *substream,
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
+static struct snd_pcm_ops bf6xx_pcm_ops = {
+	.open		= bf6xx_pcm_open,
+	.ioctl		= snd_pcm_lib_ioctl,
+	.hw_params	= bf6xx_pcm_hw_params,
+	.hw_free	= bf6xx_pcm_hw_free,
+	.prepare	= bf6xx_pcm_prepare,
+	.trigger	= bf6xx_pcm_trigger,
+	.pointer	= bf6xx_pcm_pointer,
+	.mmap		= bf6xx_pcm_mmap,
+};
+
+static int bf6xx_pcm_new(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_card *card = rtd->card->snd_card;
+	size_t size = bf6xx_pcm_hardware.buffer_bytes_max;
+	int ret = 0;
+
+	ret = dma_coerce_mask_and_coherent(card->dev, DMA_BIT_MASK(32));
+	if (ret)
+		return ret;
+
+	return snd_pcm_lib_preallocate_pages_for_all(rtd->pcm,
+				SNDRV_DMA_TYPE_DEV, card->dev, size, size);
+}
+
+static struct snd_soc_platform_driver bf6xx_soc_platform = {
+	.ops		= &bf6xx_pcm_ops,
+	.pcm_new	= bf6xx_pcm_new,
+};
+
+static int bfin_soc_platform_probe(struct platform_device *pdev)
+{
+	return snd_soc_register_platform(&pdev->dev, &bf6xx_soc_platform);
+}
+
+static int bfin_soc_platform_remove(struct platform_device *pdev)
+{
+	snd_soc_unregister_platform(&pdev->dev);
+	return 0;
+}
+
+static struct platform_driver bfin_pcm_driver = {
+	.driver = {
+		.name = "bfin-i2s-pcm-audio",
+		.owner = THIS_MODULE,
+	},
+
+	.probe = bfin_soc_platform_probe,
+	.remove = bfin_soc_platform_remove,
+};
+
+module_platform_driver(bfin_pcm_driver);
+
+MODULE_DESCRIPTION("Analog Devices BF6XX audio dma driver");
+MODULE_AUTHOR("Scott Jiang <Scott.Jiang.Linux@gmail.com>");
+MODULE_LICENSE("GPL v2");
-- 
1.7.9.5
