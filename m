From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Subject: [PATCH 06/10] ASoC: blackfin: bf5xx-i2s: Add
	support for TDM mode
Date: Tue, 28 May 2013 19:22:14 +0200
Message-ID: <1369761738-29503-6-git-send-email-lars@metafoo.de>
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

The bf5xx-i2s{,-pcm} and bf5xx-tdm{-pcm} drivers are nearly identical. Both are
for the same hardware each supporting a slight different subset of the hardware.
The bf5xx-i2s driver supports 2 channel I2S mode while the bf5xx-tdm driver
supports TDM mode and channel remapping. This patch adds support for TDM mode
and channel remapping to the bf5xx-i2s driver so that we'll eventually be able
to retire the bf5xx-tdm driver. Unfortunately the hardware is fixed to using 8
channels in TDM mode. The bf5xx-tdm driver jumps through a few hoops to make it
work well with other channel counts as well:
	* Don't support mmap
	* Translate between internal frame size (which is always 8 * sample_size)
	  and ALSA frame size (which depends on the channel count)
	* Have special copy and silence callbacks which are aware of the mismatch
	  between internal and ALSA frame size
	* Reduce the maximum buffer size to ensure that there is enough headroom for
	  dummy data.

The bf5xx-i2s driver is going to use the same mechanisms when being used int
TDM mode.

Signed-off-by: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
---
 sound/soc/blackfin/bf5xx-i2s-pcm.c | 118 ++++++++++++++++++++++++++++++++++++-
 sound/soc/blackfin/bf5xx-i2s-pcm.h |  17 ++++++
 sound/soc/blackfin/bf5xx-i2s.c     | 105 ++++++++++++++++++++++++++++++---
 3 files changed, 229 insertions(+), 11 deletions(-)
 create mode 100644 sound/soc/blackfin/bf5xx-i2s-pcm.h

diff --git a/sound/soc/blackfin/bf5xx-i2s-pcm.c b/sound/soc/blackfin/bf5xx-i2s-pcm.c
index 9931a18..9cb4a80 100644
--- a/sound/soc/blackfin/bf5xx-i2s-pcm.c
+++ b/sound/soc/blackfin/bf5xx-i2s-pcm.c
@@ -40,6 +40,7 @@
 #include <asm/dma.h>
 
 #include "bf5xx-sport.h"
+#include "bf5xx-i2s-pcm.h"
 
 static void bf5xx_dma_irq(void *data)
 {
@@ -49,7 +50,6 @@ static void bf5xx_dma_irq(void *data)
 
 static const struct snd_pcm_hardware bf5xx_pcm_hardware = {
 	.info			= SNDRV_PCM_INFO_INTERLEAVED |
-				   SNDRV_PCM_INFO_MMAP |
 				   SNDRV_PCM_INFO_MMAP_VALID |
 				   SNDRV_PCM_INFO_BLOCK_TRANSFER,
 	.formats		= SNDRV_PCM_FMTBIT_S16_LE |
@@ -66,7 +66,16 @@ static const struct snd_pcm_hardware bf5xx_pcm_hardware = {
 static int bf5xx_pcm_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params)
 {
-	return snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(params));
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	unsigned int buffer_size = params_buffer_bytes(params);
+	struct bf5xx_i2s_pcm_data *dma_data;
+
+	dma_data = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
+
+	if (dma_data->tdm_mode)
+		buffer_size = buffer_size / params_channels(params) * 8;
+
+	return snd_pcm_lib_malloc_pages(substream, buffer_size);
 }
 
 static int bf5xx_pcm_hw_free(struct snd_pcm_substream *substream)
@@ -78,9 +87,16 @@ static int bf5xx_pcm_hw_free(struct snd_pcm_substream *substream)
 
 static int bf5xx_pcm_prepare(struct snd_pcm_substream *substream)
 {
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct sport_device *sport = runtime->private_data;
 	int period_bytes = frames_to_bytes(runtime, runtime->period_size);
+	struct bf5xx_i2s_pcm_data *dma_data;
+
+	dma_data = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
+
+	if (dma_data->tdm_mode)
+		period_bytes = period_bytes / runtime->channels * 8;
 
 	pr_debug("%s enter\n", __func__);
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
@@ -127,10 +143,15 @@ static int bf5xx_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 
 static snd_pcm_uframes_t bf5xx_pcm_pointer(struct snd_pcm_substream *substream)
 {
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct sport_device *sport = runtime->private_data;
 	unsigned int diff;
 	snd_pcm_uframes_t frames;
+	struct bf5xx_i2s_pcm_data *dma_data;
+
+	dma_data = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
+
 	pr_debug("%s enter\n", __func__);
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		diff = sport_curr_offset_tx(sport);
@@ -147,6 +168,8 @@ static snd_pcm_uframes_t bf5xx_pcm_pointer(struct snd_pcm_substream *substream)
 		diff = 0;
 
 	frames = bytes_to_frames(substream->runtime, diff);
+	if (dma_data->tdm_mode)
+		frames = frames * runtime->channels / 8;
 
 	return frames;
 }
@@ -158,11 +181,18 @@ static int bf5xx_pcm_open(struct snd_pcm_substream *substream)
 	struct sport_device *sport_handle = snd_soc_dai_get_drvdata(cpu_dai);
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_dma_buffer *buf = &substream->dma_buffer;
+	struct bf5xx_i2s_pcm_data *dma_data;
 	int ret;
 
+	dma_data = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
+
 	pr_debug("%s enter\n", __func__);
 
 	snd_soc_set_runtime_hwparams(substream, &bf5xx_pcm_hardware);
+	if (dma_data->tdm_mode)
+		runtime->hw.buffer_bytes_max /= 4;
+	else
+		runtime->hw.info |= SNDRV_PCM_INFO_MMAP;
 
 	ret = snd_pcm_hw_constraint_integer(runtime,
 			SNDRV_PCM_HW_PARAM_PERIODS);
@@ -198,6 +228,88 @@ static int bf5xx_pcm_mmap(struct snd_pcm_substream *substream,
 	return 0 ;
 }
 
+static int bf5xx_pcm_copy(struct snd_pcm_substream *substream, int channel,
+	snd_pcm_uframes_t pos, void *buf, snd_pcm_uframes_t count)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	unsigned int sample_size = runtime->sample_bits / 8;
+	struct bf5xx_i2s_pcm_data *dma_data;
+	unsigned int i;
+	void *src, *dst;
+
+	dma_data = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
+
+	if (dma_data->tdm_mode) {
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+			src = buf;
+			dst = runtime->dma_area;
+			dst += pos * sample_size * 8;
+
+			while (count--) {
+				for (i = 0; i < runtime->channels; i++) {
+					memcpy(dst + dma_data->map[i] *
+						sample_size, src, sample_size);
+					src += sample_size;
+				}
+				dst += 8 * sample_size;
+			}
+		} else {
+			src = runtime->dma_area;
+			src += pos * sample_size * 8;
+			dst = buf;
+
+			while (count--) {
+				for (i = 0; i < runtime->channels; i++) {
+					memcpy(dst, src + dma_data->map[i] *
+						sample_size, sample_size);
+					dst += sample_size;
+				}
+				src += 8 * sample_size;
+			}
+		}
+	} else {
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+			src = buf;
+			dst = runtime->dma_area;
+			dst += frames_to_bytes(runtime, pos);
+		} else {
+			src = runtime->dma_area;
+			src += frames_to_bytes(runtime, pos);
+			dst = buf;
+		}
+
+		memcpy(dst, src, frames_to_bytes(runtime, count));
+	}
+
+	return 0;
+}
+
+static int bf5xx_pcm_silence(struct snd_pcm_substream *substream,
+	int channel, snd_pcm_uframes_t pos, snd_pcm_uframes_t count)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	unsigned int sample_size = runtime->sample_bits / 8;
+	void *buf = runtime->dma_area;
+	struct bf5xx_i2s_pcm_data *dma_data;
+	unsigned int offset, size;
+
+	dma_data = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
+
+	if (dma_data->tdm_mode) {
+		offset = pos * 8 * sample_size;
+		size = count * 8 * sample_size;
+	} else {
+		offset = frames_to_bytes(runtime, pos);
+		size = frames_to_bytes(runtime, count);
+	}
+
+	snd_pcm_format_set_silence(runtime->format, buf + offset, size);
+
+	return 0;
+}
+
 static struct snd_pcm_ops bf5xx_pcm_i2s_ops = {
 	.open		= bf5xx_pcm_open,
 	.ioctl		= snd_pcm_lib_ioctl,
@@ -207,6 +319,8 @@ static struct snd_pcm_ops bf5xx_pcm_i2s_ops = {
 	.trigger	= bf5xx_pcm_trigger,
 	.pointer	= bf5xx_pcm_pointer,
 	.mmap		= bf5xx_pcm_mmap,
+	.copy		= bf5xx_pcm_copy,
+	.silence	= bf5xx_pcm_silence,
 };
 
 static u64 bf5xx_pcm_dmamask = DMA_BIT_MASK(32);
diff --git a/sound/soc/blackfin/bf5xx-i2s-pcm.h b/sound/soc/blackfin/bf5xx-i2s-pcm.h
new file mode 100644
index 0000000..1f04352
--- /dev/null
+++ b/sound/soc/blackfin/bf5xx-i2s-pcm.h
@@ -0,0 +1,17 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _BF5XX_TDM_PCM_H
+#define _BF5XX_TDM_PCM_H
+
+#define BFIN_TDM_DAI_MAX_SLOTS 8
+
+struct bf5xx_i2s_pcm_data {
+	unsigned int map[BFIN_TDM_DAI_MAX_SLOTS];
+	bool tdm_mode;
+};
+
+#endif
diff --git a/sound/soc/blackfin/bf5xx-i2s.c b/sound/soc/blackfin/bf5xx-i2s.c
index 78411f2..9a174fc 100644
--- a/sound/soc/blackfin/bf5xx-i2s.c
+++ b/sound/soc/blackfin/bf5xx-i2s.c
@@ -42,6 +42,7 @@
 #include <linux/gpio.h>
 
 #include "bf5xx-sport.h"
+#include "bf5xx-i2s-pcm.h"
 
 struct bf5xx_i2s_port {
 	u16 tcr1;
@@ -49,6 +50,13 @@ struct bf5xx_i2s_port {
 	u16 tcr2;
 	u16 rcr2;
 	int configured;
+
+	unsigned int slots;
+	unsigned int tx_mask;
+	unsigned int rx_mask;
+
+	struct bf5xx_i2s_pcm_data tx_dma_data;
+	struct bf5xx_i2s_pcm_data rx_dma_data;
 };
 
 static int bf5xx_i2s_set_dai_fmt(struct snd_soc_dai *cpu_dai,
@@ -170,6 +178,64 @@ static void bf5xx_i2s_shutdown(struct snd_pcm_substream *substream,
 		bf5xx_i2s->configured = 0;
 }
 
+static int bf5xx_i2s_set_channel_map(struct snd_soc_dai *dai,
+		unsigned int tx_num, unsigned int *tx_slot,
+		unsigned int rx_num, unsigned int *rx_slot)
+{
+	struct sport_device *sport_handle = snd_soc_dai_get_drvdata(dai);
+	struct bf5xx_i2s_port *bf5xx_i2s = sport_handle->private_data;
+	unsigned int tx_mapped = 0, rx_mapped = 0;
+	unsigned int slot;
+	int i;
+
+	if ((tx_num > BFIN_TDM_DAI_MAX_SLOTS) ||
+			(rx_num > BFIN_TDM_DAI_MAX_SLOTS))
+		return -EINVAL;
+
+	for (i = 0; i < tx_num; i++) {
+		slot = tx_slot[i];
+		if ((slot < BFIN_TDM_DAI_MAX_SLOTS) &&
+				(!(tx_mapped & (1 << slot)))) {
+			bf5xx_i2s->tx_dma_data.map[i] = slot;
+			tx_mapped |= 1 << slot;
+		} else
+			return -EINVAL;
+	}
+	for (i = 0; i < rx_num; i++) {
+		slot = rx_slot[i];
+		if ((slot < BFIN_TDM_DAI_MAX_SLOTS) &&
+				(!(rx_mapped & (1 << slot)))) {
+			bf5xx_i2s->rx_dma_data.map[i] = slot;
+			rx_mapped |= 1 << slot;
+		} else
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int bf5xx_i2s_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
+	unsigned int rx_mask, int slots, int width)
+{
+	struct sport_device *sport_handle = snd_soc_dai_get_drvdata(dai);
+	struct bf5xx_i2s_port *bf5xx_i2s = sport_handle->private_data;
+
+	if (slots % 8 != 0 || slots > 8)
+		return -EINVAL;
+
+	if (width != 32)
+		return -EINVAL;
+
+	bf5xx_i2s->slots = slots;
+	bf5xx_i2s->tx_mask = tx_mask;
+	bf5xx_i2s->rx_mask = rx_mask;
+
+	bf5xx_i2s->tx_dma_data.tdm_mode = slots != 0;
+	bf5xx_i2s->rx_dma_data.tdm_mode = slots != 0;
+
+	return sport_set_multichannel(sport_handle, slots, tx_mask, rx_mask, 0);
+}
+
 #ifdef CONFIG_PM
 static int bf5xx_i2s_suspend(struct snd_soc_dai *dai)
 {
@@ -206,7 +272,8 @@ static int bf5xx_i2s_resume(struct snd_soc_dai *dai)
 		return -EBUSY;
 	}
 
-	return 0;
+	return sport_set_multichannel(sport_handle, bf5xx_i2s->slots,
+			bf5xx_i2s->tx_mask, bf5xx_i2s->rx_mask, 0);
 }
 
 #else
@@ -214,6 +281,23 @@ static int bf5xx_i2s_resume(struct snd_soc_dai *dai)
 #define bf5xx_i2s_resume	NULL
 #endif
 
+static int bf5xx_i2s_dai_probe(struct snd_soc_dai *dai)
+{
+	struct sport_device *sport_handle = snd_soc_dai_get_drvdata(dai);
+	struct bf5xx_i2s_port *bf5xx_i2s = sport_handle->private_data;
+	unsigned int i;
+
+	for (i = 0; i < BFIN_TDM_DAI_MAX_SLOTS; i++) {
+		bf5xx_i2s->tx_dma_data.map[i] = i;
+		bf5xx_i2s->rx_dma_data.map[i] = i;
+	}
+
+	dai->playback_dma_data = &bf5xx_i2s->tx_dma_data;
+	dai->capture_dma_data = &bf5xx_i2s->rx_dma_data;
+
+	return 0;
+}
+
 #define BF5XX_I2S_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 |\
 		SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_22050 | \
 		SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 | \
@@ -226,22 +310,25 @@ static int bf5xx_i2s_resume(struct snd_soc_dai *dai)
 	 SNDRV_PCM_FMTBIT_S32_LE)
 
 static const struct snd_soc_dai_ops bf5xx_i2s_dai_ops = {
-	.shutdown	= bf5xx_i2s_shutdown,
-	.hw_params	= bf5xx_i2s_hw_params,
-	.set_fmt	= bf5xx_i2s_set_dai_fmt,
+	.shutdown	 = bf5xx_i2s_shutdown,
+	.hw_params	 = bf5xx_i2s_hw_params,
+	.set_fmt	 = bf5xx_i2s_set_dai_fmt,
+	.set_tdm_slot	 = bf5xx_i2s_set_tdm_slot,
+	.set_channel_map = bf5xx_i2s_set_channel_map,
 };
 
 static struct snd_soc_dai_driver bf5xx_i2s_dai = {
+	.probe = bf5xx_i2s_dai_probe,
 	.suspend = bf5xx_i2s_suspend,
 	.resume = bf5xx_i2s_resume,
 	.playback = {
-		.channels_min = 1,
-		.channels_max = 2,
+		.channels_min = 2,
+		.channels_max = 8,
 		.rates = BF5XX_I2S_RATES,
 		.formats = BF5XX_I2S_FORMATS,},
 	.capture = {
-		.channels_min = 1,
-		.channels_max = 2,
+		.channels_min = 2,
+		.channels_max = 8,
 		.rates = BF5XX_I2S_RATES,
 		.formats = BF5XX_I2S_FORMATS,},
 	.ops = &bf5xx_i2s_dai_ops,
@@ -257,7 +344,7 @@ static int bf5xx_i2s_probe(struct platform_device *pdev)
 	int ret;
 
 	/* configure SPORT for I2S */
-	sport_handle = sport_init(pdev, 4, 2 * sizeof(u32),
+	sport_handle = sport_init(pdev, 4, 8 * sizeof(u32),
 		sizeof(struct bf5xx_i2s_port));
 	if (!sport_handle)
 		return -ENODEV;
-- 
1.8.0
