From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Subject: [PATCH 09/10] ASoC: blackfin: Remove bf5xx-tdm
	driver
Date: Tue, 28 May 2013 19:22:17 +0200
Message-ID: <1369761738-29503-9-git-send-email-lars@metafoo.de>
References: <1369761738-29503-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
In-Reply-To: <1369761738-29503-1-git-send-email-lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
List-Unsubscribe: <https://blackfin.uclinux.org/mailman/options/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Scott Jiang <scott.jiang.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Steven Miao <realmz6-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Now that the bf5xx-i2s driver supports TDM mode and all users of the bf5xx-tdm
driver have been switch over to using the bf5xx-i2s driver there is no need to
keep the b5fxx-tdm driver around.

Signed-off-by: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
---
 sound/soc/blackfin/Kconfig         |  13 --
 sound/soc/blackfin/Makefile        |   4 -
 sound/soc/blackfin/bf5xx-tdm-pcm.c | 343 -------------------------------------
 sound/soc/blackfin/bf5xx-tdm.c     | 328 -----------------------------------
 sound/soc/blackfin/bf5xx-tdm.h     |  23 ---
 5 files changed, 711 deletions(-)
 delete mode 100644 sound/soc/blackfin/bf5xx-tdm-pcm.c
 delete mode 100644 sound/soc/blackfin/bf5xx-tdm.c
 delete mode 100644 sound/soc/blackfin/bf5xx-tdm.h

diff --git a/sound/soc/blackfin/Kconfig b/sound/soc/blackfin/Kconfig
index 4a67865..54f74f8 100644
--- a/sound/soc/blackfin/Kconfig
+++ b/sound/soc/blackfin/Kconfig
@@ -89,16 +89,6 @@ config SND_BFIN_AD73311_SE
 	  Enter the GPIO used to control AD73311's SE pin. Acceptable
 	  values are 0 to 7
 
-config SND_BF5XX_TDM
-	tristate "SoC I2S(TDM mode) Audio for the ADI BF5xx chip"
-	depends on (BLACKFIN && SND_SOC)
-	select SND_BF5XX_SOC_SPORT
-	help
-	  Say Y or M if you want to add support for codecs attached to
-	  the Blackfin SPORT (synchronous serial ports) interface in TDM
-	  mode.
-	  You will also need to select the audio interfaces to support below.
-
 config SND_BF5XX_AC97
 	tristate "SoC AC97 Audio for the ADI BF5xx chip"
 	depends on BLACKFIN
@@ -174,9 +164,6 @@ config SND_BF5XX_SOC_I2S
 config SND_BF6XX_SOC_I2S
 	tristate
 
-config SND_BF5XX_SOC_TDM
-	tristate
-
 config SND_BF5XX_SOC_AC97
 	tristate
 
diff --git a/sound/soc/blackfin/Makefile b/sound/soc/blackfin/Makefile
index 6fea1f4..ad0a6e9 100644
--- a/sound/soc/blackfin/Makefile
+++ b/sound/soc/blackfin/Makefile
@@ -1,23 +1,19 @@
 # Blackfin Platform Support
 snd-bf5xx-ac97-objs := bf5xx-ac97-pcm.o
 snd-bf5xx-i2s-objs := bf5xx-i2s-pcm.o
-snd-bf5xx-tdm-objs := bf5xx-tdm-pcm.o
 snd-soc-bf5xx-sport-objs := bf5xx-sport.o
 snd-soc-bf6xx-sport-objs := bf6xx-sport.o
 snd-soc-bf5xx-ac97-objs := bf5xx-ac97.o
 snd-soc-bf5xx-i2s-objs := bf5xx-i2s.o
 snd-soc-bf6xx-i2s-objs := bf6xx-i2s.o
-snd-soc-bf5xx-tdm-objs := bf5xx-tdm.o
 
 obj-$(CONFIG_SND_BF5XX_AC97) += snd-bf5xx-ac97.o
 obj-$(CONFIG_SND_BF5XX_I2S) += snd-bf5xx-i2s.o
-obj-$(CONFIG_SND_BF5XX_TDM) += snd-bf5xx-tdm.o
 obj-$(CONFIG_SND_BF5XX_SOC_SPORT) += snd-soc-bf5xx-sport.o
 obj-$(CONFIG_SND_BF6XX_SOC_SPORT) += snd-soc-bf6xx-sport.o
 obj-$(CONFIG_SND_BF5XX_SOC_AC97) += snd-soc-bf5xx-ac97.o
 obj-$(CONFIG_SND_BF5XX_SOC_I2S) += snd-soc-bf5xx-i2s.o
 obj-$(CONFIG_SND_BF6XX_SOC_I2S) += snd-soc-bf6xx-i2s.o
-obj-$(CONFIG_SND_BF5XX_SOC_TDM) += snd-soc-bf5xx-tdm.o
 
 # Blackfin Machine Support
 snd-ad1836-objs := bf5xx-ad1836.o
diff --git a/sound/soc/blackfin/bf5xx-tdm-pcm.c b/sound/soc/blackfin/bf5xx-tdm-pcm.c
deleted file mode 100644
index a6b5457..0000000
--- a/sound/soc/blackfin/bf5xx-tdm-pcm.c
+++ /dev/null
@@ -1,343 +0,0 @@
-/*
- * File:         sound/soc/blackfin/bf5xx-tdm-pcm.c
- * Author:       Barry Song <Barry.Song-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
- *
- * Created:      Tue June 06 2009
- * Description:  DMA driver for tdm codec
- *
- * Modified:
- *               Copyright 2009 Analog Devices Inc.
- *
- * Bugs:         Enter bugs at http://blackfin.uclinux.org/
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see the file COPYING, or write
- * to the Free Software Foundation, Inc.,
- * 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- */
-
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/dma-mapping.h>
-#include <linux/gfp.h>
-
-#include <sound/core.h>
-#include <sound/pcm.h>
-#include <sound/pcm_params.h>
-#include <sound/soc.h>
-
-#include <asm/dma.h>
-
-#include "bf5xx-tdm.h"
-#include "bf5xx-sport.h"
-
-#define PCM_BUFFER_MAX  0x8000
-#define FRAGMENT_SIZE_MIN  (4*1024)
-#define FRAGMENTS_MIN  2
-#define FRAGMENTS_MAX  32
-
-static void bf5xx_dma_irq(void *data)
-{
-	struct snd_pcm_substream *pcm = data;
-	snd_pcm_period_elapsed(pcm);
-}
-
-static const struct snd_pcm_hardware bf5xx_pcm_hardware = {
-	.info = (SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER |
-		SNDRV_PCM_INFO_RESUME),
-	.formats =          SNDRV_PCM_FMTBIT_S32_LE,
-	.rates =            SNDRV_PCM_RATE_48000,
-	.channels_min =     2,
-	.channels_max =     8,
-	.buffer_bytes_max = PCM_BUFFER_MAX,
-	.period_bytes_min = FRAGMENT_SIZE_MIN,
-	.period_bytes_max = PCM_BUFFER_MAX/2,
-	.periods_min =      FRAGMENTS_MIN,
-	.periods_max =      FRAGMENTS_MAX,
-};
-
-static int bf5xx_pcm_hw_params(struct snd_pcm_substream *substream,
-	struct snd_pcm_hw_params *params)
-{
-	size_t size = bf5xx_pcm_hardware.buffer_bytes_max;
-	snd_pcm_lib_malloc_pages(substream, size * 4);
-
-	return 0;
-}
-
-static int bf5xx_pcm_hw_free(struct snd_pcm_substream *substream)
-{
-	snd_pcm_lib_free_pages(substream);
-
-	return 0;
-}
-
-static int bf5xx_pcm_prepare(struct snd_pcm_substream *substream)
-{
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct sport_device *sport = runtime->private_data;
-	int fragsize_bytes = frames_to_bytes(runtime, runtime->period_size);
-
-	fragsize_bytes /= runtime->channels;
-	/* inflate the fragsize to match the dma width of SPORT */
-	fragsize_bytes *= 8;
-
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		sport_set_tx_callback(sport, bf5xx_dma_irq, substream);
-		sport_config_tx_dma(sport, runtime->dma_area,
-			runtime->periods, fragsize_bytes);
-	} else {
-		sport_set_rx_callback(sport, bf5xx_dma_irq, substream);
-		sport_config_rx_dma(sport, runtime->dma_area,
-			runtime->periods, fragsize_bytes);
-	}
-
-	return 0;
-}
-
-static int bf5xx_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
-{
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct sport_device *sport = runtime->private_data;
-	int ret = 0;
-
-	switch (cmd) {
-	case SNDRV_PCM_TRIGGER_START:
-		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-			sport_tx_start(sport);
-		else
-			sport_rx_start(sport);
-		break;
-	case SNDRV_PCM_TRIGGER_STOP:
-	case SNDRV_PCM_TRIGGER_SUSPEND:
-	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-			sport_tx_stop(sport);
-		else
-			sport_rx_stop(sport);
-		break;
-	default:
-		ret = -EINVAL;
-	}
-
-	return ret;
-}
-
-static snd_pcm_uframes_t bf5xx_pcm_pointer(struct snd_pcm_substream *substream)
-{
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct sport_device *sport = runtime->private_data;
-	unsigned int diff;
-	snd_pcm_uframes_t frames;
-
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		diff = sport_curr_offset_tx(sport);
-		frames = diff / (8*4); /* 32 bytes per frame */
-	} else {
-		diff = sport_curr_offset_rx(sport);
-		frames = diff / (8*4);
-	}
-	return frames;
-}
-
-static int bf5xx_pcm_open(struct snd_pcm_substream *substream)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	struct sport_device *sport_handle = snd_soc_dai_get_drvdata(cpu_dai);
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct snd_dma_buffer *buf = &substream->dma_buffer;
-
-	int ret = 0;
-
-	snd_soc_set_runtime_hwparams(substream, &bf5xx_pcm_hardware);
-
-	ret = snd_pcm_hw_constraint_integer(runtime,
-		SNDRV_PCM_HW_PARAM_PERIODS);
-	if (ret < 0)
-		goto out;
-
-	if (sport_handle != NULL) {
-		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-			sport_handle->tx_buf = buf->area;
-		else
-			sport_handle->rx_buf = buf->area;
-
-		runtime->private_data = sport_handle;
-	} else {
-		pr_err("sport_handle is NULL\n");
-		ret = -ENODEV;
-	}
-out:
-	return ret;
-}
-
-static int bf5xx_pcm_copy(struct snd_pcm_substream *substream, int channel,
-	snd_pcm_uframes_t pos, void *buf, snd_pcm_uframes_t count)
-{
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct sport_device *sport = runtime->private_data;
-	struct bf5xx_tdm_port *tdm_port = sport->private_data;
-	unsigned int *src;
-	unsigned int *dst;
-	int i;
-
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		src = buf;
-		dst = (unsigned int *)substream->runtime->dma_area;
-
-		dst += pos * 8;
-		while (count--) {
-			for (i = 0; i < substream->runtime->channels; i++)
-				*(dst + tdm_port->tx_map[i]) = *src++;
-			dst += 8;
-		}
-	} else {
-		src = (unsigned int *)substream->runtime->dma_area;
-		dst = buf;
-
-		src += pos * 8;
-		while (count--) {
-			for (i = 0; i < substream->runtime->channels; i++)
-				*dst++ = *(src + tdm_port->rx_map[i]);
-			src += 8;
-		}
-	}
-
-	return 0;
-}
-
-static int bf5xx_pcm_silence(struct snd_pcm_substream *substream,
-	int channel, snd_pcm_uframes_t pos, snd_pcm_uframes_t count)
-{
-	unsigned char *buf = substream->runtime->dma_area;
-	buf += pos * 8 * 4;
-	memset(buf, '\0', count * 8 * 4);
-
-	return 0;
-}
-
-static struct snd_pcm_ops bf5xx_pcm_tdm_ops = {
-	.open           = bf5xx_pcm_open,
-	.ioctl          = snd_pcm_lib_ioctl,
-	.hw_params      = bf5xx_pcm_hw_params,
-	.hw_free        = bf5xx_pcm_hw_free,
-	.prepare        = bf5xx_pcm_prepare,
-	.trigger        = bf5xx_pcm_trigger,
-	.pointer        = bf5xx_pcm_pointer,
-	.copy           = bf5xx_pcm_copy,
-	.silence        = bf5xx_pcm_silence,
-};
-
-static int bf5xx_pcm_preallocate_dma_buffer(struct snd_pcm *pcm, int stream)
-{
-	struct snd_pcm_substream *substream = pcm->streams[stream].substream;
-	struct snd_dma_buffer *buf = &substream->dma_buffer;
-	size_t size = bf5xx_pcm_hardware.buffer_bytes_max;
-
-	buf->dev.type = SNDRV_DMA_TYPE_DEV;
-	buf->dev.dev = pcm->card->dev;
-	buf->private_data = NULL;
-	buf->area = dma_alloc_coherent(pcm->card->dev, size * 4,
-		&buf->addr, GFP_KERNEL);
-	if (!buf->area) {
-		pr_err("Failed to allocate dma memory - Please increase uncached DMA memory region\n");
-		return -ENOMEM;
-	}
-	buf->bytes = size;
-
-	return 0;
-}
-
-static void bf5xx_pcm_free_dma_buffers(struct snd_pcm *pcm)
-{
-	struct snd_pcm_substream *substream;
-	struct snd_dma_buffer *buf;
-	int stream;
-
-	for (stream = 0; stream < 2; stream++) {
-		substream = pcm->streams[stream].substream;
-		if (!substream)
-			continue;
-
-		buf = &substream->dma_buffer;
-		if (!buf->area)
-			continue;
-		dma_free_coherent(NULL, buf->bytes, buf->area, 0);
-		buf->area = NULL;
-	}
-}
-
-static u64 bf5xx_pcm_dmamask = DMA_BIT_MASK(32);
-
-static int bf5xx_pcm_tdm_new(struct snd_soc_pcm_runtime *rtd)
-{
-	struct snd_card *card = rtd->card->snd_card;
-	struct snd_pcm *pcm = rtd->pcm;
-	int ret = 0;
-
-	if (!card->dev->dma_mask)
-		card->dev->dma_mask = &bf5xx_pcm_dmamask;
-	if (!card->dev->coherent_dma_mask)
-		card->dev->coherent_dma_mask = DMA_BIT_MASK(32);
-
-	if (pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream) {
-		ret = bf5xx_pcm_preallocate_dma_buffer(pcm,
-			SNDRV_PCM_STREAM_PLAYBACK);
-		if (ret)
-			goto out;
-	}
-
-	if (pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream) {
-		ret = bf5xx_pcm_preallocate_dma_buffer(pcm,
-			SNDRV_PCM_STREAM_CAPTURE);
-		if (ret)
-			goto out;
-	}
-out:
-	return ret;
-}
-
-static struct snd_soc_platform_driver bf5xx_tdm_soc_platform = {
-	.ops        = &bf5xx_pcm_tdm_ops,
-	.pcm_new        = bf5xx_pcm_tdm_new,
-	.pcm_free       = bf5xx_pcm_free_dma_buffers,
-};
-
-static int bf5xx_soc_platform_probe(struct platform_device *pdev)
-{
-	return snd_soc_register_platform(&pdev->dev, &bf5xx_tdm_soc_platform);
-}
-
-static int bf5xx_soc_platform_remove(struct platform_device *pdev)
-{
-	snd_soc_unregister_platform(&pdev->dev);
-	return 0;
-}
-
-static struct platform_driver bfin_tdm_driver = {
-	.driver = {
-			.name = "bfin-tdm-pcm-audio",
-			.owner = THIS_MODULE,
-	},
-
-	.probe = bf5xx_soc_platform_probe,
-	.remove = bf5xx_soc_platform_remove,
-};
-
-module_platform_driver(bfin_tdm_driver);
-
-MODULE_AUTHOR("Barry Song");
-MODULE_DESCRIPTION("ADI Blackfin TDM PCM DMA module");
-MODULE_LICENSE("GPL");
diff --git a/sound/soc/blackfin/bf5xx-tdm.c b/sound/soc/blackfin/bf5xx-tdm.c
deleted file mode 100644
index aa08516..0000000
--- a/sound/soc/blackfin/bf5xx-tdm.c
+++ /dev/null
@@ -1,328 +0,0 @@
-/*
- * File:         sound/soc/blackfin/bf5xx-tdm.c
- * Author:       Barry Song <Barry.Song-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
- *
- * Created:      Thurs June 04 2009
- * Description:  Blackfin I2S(TDM) CPU DAI driver
- *              Even though TDM mode can be as part of I2S DAI, but there
- *              are so much difference in configuration and data flow,
- *              it's very ugly to integrate I2S and TDM into a module
- *
- * Modified:
- *               Copyright 2009 Analog Devices Inc.
- *
- * Bugs:         Enter bugs at http://blackfin.uclinux.org/
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see the file COPYING, or write
- * to the Free Software Foundation, Inc.,
- * 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- */
-
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/device.h>
-#include <sound/core.h>
-#include <sound/pcm.h>
-#include <sound/pcm_params.h>
-#include <sound/initval.h>
-#include <sound/soc.h>
-
-#include <asm/irq.h>
-#include <asm/portmux.h>
-#include <linux/mutex.h>
-#include <linux/gpio.h>
-
-#include "bf5xx-sport.h"
-#include "bf5xx-tdm.h"
-
-static int bf5xx_tdm_set_dai_fmt(struct snd_soc_dai *cpu_dai,
-	unsigned int fmt)
-{
-	int ret = 0;
-
-	/* interface format:support TDM,slave mode */
-	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
-	case SND_SOC_DAIFMT_DSP_A:
-		break;
-	default:
-		printk(KERN_ERR "%s: Unknown DAI format type\n", __func__);
-		ret = -EINVAL;
-		break;
-	}
-
-	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
-	case SND_SOC_DAIFMT_CBM_CFM:
-		break;
-	case SND_SOC_DAIFMT_CBS_CFS:
-	case SND_SOC_DAIFMT_CBM_CFS:
-	case SND_SOC_DAIFMT_CBS_CFM:
-		ret = -EINVAL;
-		break;
-	default:
-		printk(KERN_ERR "%s: Unknown DAI master type\n", __func__);
-		ret = -EINVAL;
-		break;
-	}
-
-	return ret;
-}
-
-static int bf5xx_tdm_hw_params(struct snd_pcm_substream *substream,
-	struct snd_pcm_hw_params *params,
-	struct snd_soc_dai *dai)
-{
-	struct sport_device *sport_handle = snd_soc_dai_get_drvdata(dai);
-	struct bf5xx_tdm_port *bf5xx_tdm = sport_handle->private_data;
-	int ret = 0;
-
-	bf5xx_tdm->tcr2 &= ~0x1f;
-	bf5xx_tdm->rcr2 &= ~0x1f;
-	switch (params_format(params)) {
-	case SNDRV_PCM_FORMAT_S32_LE:
-		bf5xx_tdm->tcr2 |= 31;
-		bf5xx_tdm->rcr2 |= 31;
-		sport_handle->wdsize = 4;
-		break;
-		/* at present, we only support 32bit transfer */
-	default:
-		pr_err("not supported PCM format yet\n");
-		return -EINVAL;
-		break;
-	}
-
-	if (!bf5xx_tdm->configured) {
-		/*
-		 * TX and RX are not independent,they are enabled at the
-		 * same time, even if only one side is running. So, we
-		 * need to configure both of them at the time when the first
-		 * stream is opened.
-		 *
-		 * CPU DAI:slave mode.
-		 */
-		ret = sport_config_rx(sport_handle, bf5xx_tdm->rcr1,
-			bf5xx_tdm->rcr2, 0, 0);
-		if (ret) {
-			pr_err("SPORT is busy!\n");
-			return -EBUSY;
-		}
-
-		ret = sport_config_tx(sport_handle, bf5xx_tdm->tcr1,
-			bf5xx_tdm->tcr2, 0, 0);
-		if (ret) {
-			pr_err("SPORT is busy!\n");
-			return -EBUSY;
-		}
-
-		bf5xx_tdm->configured = 1;
-	}
-
-	return 0;
-}
-
-static void bf5xx_tdm_shutdown(struct snd_pcm_substream *substream,
-	struct snd_soc_dai *dai)
-{
-	struct sport_device *sport_handle = snd_soc_dai_get_drvdata(dai);
-	struct bf5xx_tdm_port *bf5xx_tdm = sport_handle->private_data;
-
-	/* No active stream, SPORT is allowed to be configured again. */
-	if (!dai->active)
-		bf5xx_tdm->configured = 0;
-}
-
-static int bf5xx_tdm_set_channel_map(struct snd_soc_dai *dai,
-		unsigned int tx_num, unsigned int *tx_slot,
-		unsigned int rx_num, unsigned int *rx_slot)
-{
-	struct sport_device *sport_handle = snd_soc_dai_get_drvdata(dai);
-	struct bf5xx_tdm_port *bf5xx_tdm = sport_handle->private_data;
-	int i;
-	unsigned int slot;
-	unsigned int tx_mapped = 0, rx_mapped = 0;
-
-	if ((tx_num > BFIN_TDM_DAI_MAX_SLOTS) ||
-			(rx_num > BFIN_TDM_DAI_MAX_SLOTS))
-		return -EINVAL;
-
-	for (i = 0; i < tx_num; i++) {
-		slot = tx_slot[i];
-		if ((slot < BFIN_TDM_DAI_MAX_SLOTS) &&
-				(!(tx_mapped & (1 << slot)))) {
-			bf5xx_tdm->tx_map[i] = slot;
-			tx_mapped |= 1 << slot;
-		} else
-			return -EINVAL;
-	}
-	for (i = 0; i < rx_num; i++) {
-		slot = rx_slot[i];
-		if ((slot < BFIN_TDM_DAI_MAX_SLOTS) &&
-				(!(rx_mapped & (1 << slot)))) {
-			bf5xx_tdm->rx_map[i] = slot;
-			rx_mapped |= 1 << slot;
-		} else
-			return -EINVAL;
-	}
-
-	return 0;
-}
-
-#ifdef CONFIG_PM
-static int bf5xx_tdm_suspend(struct snd_soc_dai *dai)
-{
-	struct sport_device *sport = snd_soc_dai_get_drvdata(dai);
-
-	if (dai->playback_active)
-		sport_tx_stop(sport);
-	if (dai->capture_active)
-		sport_rx_stop(sport);
-
-	/* isolate sync/clock pins from codec while sports resume */
-	peripheral_free_list(sport->pin_req);
-
-	return 0;
-}
-
-static int bf5xx_tdm_resume(struct snd_soc_dai *dai)
-{
-	int ret;
-	struct sport_device *sport = snd_soc_dai_get_drvdata(dai);
-
-	ret = sport_set_multichannel(sport, 8, 0xFF, 0xFF, 1);
-	if (ret) {
-		pr_err("SPORT is busy!\n");
-		ret = -EBUSY;
-	}
-
-	ret = sport_config_rx(sport, 0, 0x1F, 0, 0);
-	if (ret) {
-		pr_err("SPORT is busy!\n");
-		ret = -EBUSY;
-	}
-
-	ret = sport_config_tx(sport, 0, 0x1F, 0, 0);
-	if (ret) {
-		pr_err("SPORT is busy!\n");
-		ret = -EBUSY;
-	}
-
-	peripheral_request_list(sport->pin_req, "soc-audio");
-
-	return 0;
-}
-
-#else
-#define bf5xx_tdm_suspend      NULL
-#define bf5xx_tdm_resume       NULL
-#endif
-
-static const struct snd_soc_dai_ops bf5xx_tdm_dai_ops = {
-	.hw_params      = bf5xx_tdm_hw_params,
-	.set_fmt        = bf5xx_tdm_set_dai_fmt,
-	.shutdown       = bf5xx_tdm_shutdown,
-	.set_channel_map   = bf5xx_tdm_set_channel_map,
-};
-
-static struct snd_soc_dai_driver bf5xx_tdm_dai = {
-	.suspend = bf5xx_tdm_suspend,
-	.resume = bf5xx_tdm_resume,
-	.playback = {
-		.channels_min = 2,
-		.channels_max = 8,
-		.rates = SNDRV_PCM_RATE_48000,
-		.formats = SNDRV_PCM_FMTBIT_S32_LE,},
-	.capture = {
-		.channels_min = 2,
-		.channels_max = 8,
-		.rates = SNDRV_PCM_RATE_48000,
-		.formats = SNDRV_PCM_FMTBIT_S32_LE,},
-	.ops = &bf5xx_tdm_dai_ops,
-};
-
-static const struct snd_soc_component_driver bf5xx_tdm_component = {
-	.name		= "bf5xx-tdm",
-};
-
-static int bfin_tdm_probe(struct platform_device *pdev)
-{
-	struct sport_device *sport_handle;
-	int ret;
-
-	/* configure SPORT for TDM */
-	sport_handle = sport_init(pdev, 4, 8 * sizeof(u32),
-		sizeof(struct bf5xx_tdm_port));
-	if (!sport_handle)
-		return -ENODEV;
-
-	/* SPORT works in TDM mode */
-	ret = sport_set_multichannel(sport_handle, 8, 0xFF, 0xFF, 1);
-	if (ret) {
-		pr_err("SPORT is busy!\n");
-		ret = -EBUSY;
-		goto sport_config_err;
-	}
-
-	ret = sport_config_rx(sport_handle, 0, 0x1F, 0, 0);
-	if (ret) {
-		pr_err("SPORT is busy!\n");
-		ret = -EBUSY;
-		goto sport_config_err;
-	}
-
-	ret = sport_config_tx(sport_handle, 0, 0x1F, 0, 0);
-	if (ret) {
-		pr_err("SPORT is busy!\n");
-		ret = -EBUSY;
-		goto sport_config_err;
-	}
-
-	ret = snd_soc_register_component(&pdev->dev, &bf5xx_tdm_component,
-					 &bf5xx_tdm_dai, 1);
-	if (ret) {
-		pr_err("Failed to register DAI: %d\n", ret);
-		goto sport_config_err;
-	}
-
-	return 0;
-
-sport_config_err:
-	sport_done(sport_handle);
-	return ret;
-}
-
-static int bfin_tdm_remove(struct platform_device *pdev)
-{
-	struct sport_device *sport_handle = platform_get_drvdata(pdev);
-
-	snd_soc_unregister_component(&pdev->dev);
-	sport_done(sport_handle);
-
-	return 0;
-}
-
-static struct platform_driver bfin_tdm_driver = {
-	.probe  = bfin_tdm_probe,
-	.remove = bfin_tdm_remove,
-	.driver = {
-		.name   = "bfin-tdm",
-		.owner  = THIS_MODULE,
-	},
-};
-
-module_platform_driver(bfin_tdm_driver);
-
-/* Module information */
-MODULE_AUTHOR("Barry Song");
-MODULE_DESCRIPTION("TDM driver for ADI Blackfin");
-MODULE_LICENSE("GPL");
-
diff --git a/sound/soc/blackfin/bf5xx-tdm.h b/sound/soc/blackfin/bf5xx-tdm.h
deleted file mode 100644
index e986a3e..0000000
--- a/sound/soc/blackfin/bf5xx-tdm.h
+++ /dev/null
@@ -1,23 +0,0 @@
-/*
- * sound/soc/blackfin/bf5xx-tdm.h
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef _BF5XX_TDM_H
-#define _BF5XX_TDM_H
-
-#define BFIN_TDM_DAI_MAX_SLOTS 8
-struct bf5xx_tdm_port {
-	u16 tcr1;
-	u16 rcr1;
-	u16 tcr2;
-	u16 rcr2;
-	unsigned int tx_map[BFIN_TDM_DAI_MAX_SLOTS];
-	unsigned int rx_map[BFIN_TDM_DAI_MAX_SLOTS];
-	int configured;
-};
-
-#endif
-- 
1.8.0
