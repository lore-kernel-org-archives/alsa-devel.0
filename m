From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH 1/2] clean-up according to feedback
Date: Mon, 20 Jul 2009 18:28:03 +0800
Message-ID: <1248085684-12552-2-git-send-email-21cnbao@gmail.com>
References: <1248085684-12552-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nwd2mail10.analog.com (nwd2mail10.analog.com [137.71.25.55])
	by alsa0.perex.cz (Postfix) with ESMTP id 5DD36245C1
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Jul 2009 12:26:31 +0200 (CEST)
In-Reply-To: <1248085684-12552-1-git-send-email-21cnbao@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Barry Song <21cnbao@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Barry Song <21cnbao@gmail.com>
---
 sound/soc/blackfin/Kconfig         |   15 ++-
 sound/soc/blackfin/Makefile        |    4 +
 sound/soc/blackfin/bf5xx-tdm-pcm.c |  332 ++++++++++++++++++++++++++++++++++
 sound/soc/blackfin/bf5xx-tdm-pcm.h |   21 +++
 sound/soc/blackfin/bf5xx-tdm.c     |  342 ++++++++++++++++++++++++++++++++++++
 sound/soc/blackfin/bf5xx-tdm.h     |   14 ++
 6 files changed, 727 insertions(+), 1 deletions(-)
 create mode 100644 sound/soc/blackfin/bf5xx-tdm-pcm.c
 create mode 100644 sound/soc/blackfin/bf5xx-tdm-pcm.h
 create mode 100644 sound/soc/blackfin/bf5xx-tdm.c
 create mode 100644 sound/soc/blackfin/bf5xx-tdm.h

diff --git a/sound/soc/blackfin/Kconfig b/sound/soc/blackfin/Kconfig
index 811596f..2ab6d2f 100644
--- a/sound/soc/blackfin/Kconfig
+++ b/sound/soc/blackfin/Kconfig
@@ -7,6 +7,15 @@ config SND_BF5XX_I2S
 	  mode (supports single stereo In/Out).
 	  You will also need to select the audio interfaces to support below.
 
+config SND_BF5XX_TDM
+	tristate "SoC I2S(TDM mode) Audio for the ADI BF5xx chip"
+	depends on (BLACKFIN && SND_SOC)
+	help
+	  Say Y or M if you want to add support for codecs attached to
+	  the Blackfin SPORT (synchronous serial ports) interface in TDM
+	  mode.
+	  You will also need to select the audio interfaces to support below.
+
 config SND_BF5XX_SOC_SSM2602
 	tristate "SoC SSM2602 Audio support for BF52x ezkit"
 	depends on SND_BF5XX_I2S
@@ -69,6 +78,10 @@ config SND_BF5XX_SOC_I2S
 	tristate
 	select SND_BF5XX_SOC_SPORT
 
+config SND_BF5XX_SOC_TDM
+	tristate
+	select SND_BF5XX_SOC_SPORT
+
 config SND_BF5XX_SOC_AC97
 	tristate
 	select AC97_BUS
@@ -85,7 +98,7 @@ config SND_BF5XX_SOC_AD1980
 
 config SND_BF5XX_SPORT_NUM
 	int "Set a SPORT for Sound chip"
-	depends on (SND_BF5XX_I2S || SND_BF5XX_AC97)
+	depends on (SND_BF5XX_I2S || SND_BF5XX_AC97 || SND_BF5XX_TDM)
 	range 0 3 if BF54x
 	range 0 1 if !BF54x
 	default 0
diff --git a/sound/soc/blackfin/Makefile b/sound/soc/blackfin/Makefile
index 97bb37a..f861926 100644
--- a/sound/soc/blackfin/Makefile
+++ b/sound/soc/blackfin/Makefile
@@ -1,15 +1,19 @@
 # Blackfin Platform Support
 snd-bf5xx-ac97-objs := bf5xx-ac97-pcm.o
 snd-bf5xx-i2s-objs := bf5xx-i2s-pcm.o
+snd-bf5xx-tdm-objs := bf5xx-tdm-pcm.o
 snd-soc-bf5xx-sport-objs := bf5xx-sport.o
 snd-soc-bf5xx-ac97-objs := bf5xx-ac97.o
 snd-soc-bf5xx-i2s-objs := bf5xx-i2s.o
+snd-soc-bf5xx-tdm-objs := bf5xx-tdm.o
 
 obj-$(CONFIG_SND_BF5XX_AC97) += snd-bf5xx-ac97.o
 obj-$(CONFIG_SND_BF5XX_I2S) += snd-bf5xx-i2s.o
+obj-$(CONFIG_SND_BF5XX_TDM) += snd-bf5xx-tdm.o
 obj-$(CONFIG_SND_BF5XX_SOC_SPORT) += snd-soc-bf5xx-sport.o
 obj-$(CONFIG_SND_BF5XX_SOC_AC97) += snd-soc-bf5xx-ac97.o
 obj-$(CONFIG_SND_BF5XX_SOC_I2S) += snd-soc-bf5xx-i2s.o
+obj-$(CONFIG_SND_BF5XX_SOC_TDM) += snd-soc-bf5xx-tdm.o
 
 # Blackfin Machine Support
 snd-ad1980-objs := bf5xx-ad1980.o
diff --git a/sound/soc/blackfin/bf5xx-tdm-pcm.c b/sound/soc/blackfin/bf5xx-tdm-pcm.c
new file mode 100644
index 0000000..8742a0a
--- /dev/null
+++ b/sound/soc/blackfin/bf5xx-tdm-pcm.c
@@ -0,0 +1,332 @@
+/*
+ * File:         sound/soc/blackfin/bf5xx-tdm-pcm.c
+ * Author:       Barry Song <Barry.Song@analog.com>
+ *
+ * Created:      Tue June 06 2009
+ * Description:  DMA driver for tdm codec
+ *
+ * Modified:
+ *               Copyright 2009 Analog Devices Inc.
+ *
+ * Bugs:         Enter bugs at http://blackfin.uclinux.org/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see the file COPYING, or write
+ * to the Free Software Foundation, Inc.,
+ * 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/dma-mapping.h>
+
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+
+#include <asm/dma.h>
+
+#include "bf5xx-tdm-pcm.h"
+#include "bf5xx-tdm.h"
+#include "bf5xx-sport.h"
+
+#define PCM_BUFFER_MAX  0x10000
+#define FRAGMENT_SIZE_MIN  (4*1024)
+#define FRAGMENTS_MIN  2
+#define FRAGMENTS_MAX  32
+
+static void bf5xx_dma_irq(void *data)
+{
+	struct snd_pcm_substream *pcm = data;
+	snd_pcm_period_elapsed(pcm);
+}
+
+static const struct snd_pcm_hardware bf5xx_pcm_hardware = {
+	.info = (SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER |
+		SNDRV_PCM_INFO_RESUME),
+	.formats =          SNDRV_PCM_FMTBIT_S32_LE,
+	.rates =            SNDRV_PCM_RATE_48000,
+	.channels_min =     2,
+	.channels_max =     8,
+	.buffer_bytes_max = PCM_BUFFER_MAX,
+	.period_bytes_min = FRAGMENT_SIZE_MIN,
+	.period_bytes_max = PCM_BUFFER_MAX/2,
+	.periods_min =      FRAGMENTS_MIN,
+	.periods_max =      FRAGMENTS_MAX,
+};
+
+static int bf5xx_pcm_hw_params(struct snd_pcm_substream *substream,
+		struct snd_pcm_hw_params *params)
+{
+	size_t size = bf5xx_pcm_hardware.buffer_bytes_max;
+	snd_pcm_lib_malloc_pages(substream, size * 4);
+
+	return 0;
+}
+
+static int bf5xx_pcm_hw_free(struct snd_pcm_substream *substream)
+{
+	snd_pcm_lib_free_pages(substream);
+
+	return 0;
+}
+
+static int bf5xx_pcm_prepare(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct sport_device *sport = runtime->private_data;
+	int fragsize_bytes = frames_to_bytes(runtime, runtime->period_size);
+
+	fragsize_bytes /= runtime->channels;
+	/* inflate the fragsize to match the dma width of SPORT */
+	fragsize_bytes *= 8;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		sport_set_tx_callback(sport, bf5xx_dma_irq, substream);
+		sport_config_tx_dma(sport, runtime->dma_area,
+				runtime->periods, fragsize_bytes);
+	} else {
+		sport_set_rx_callback(sport, bf5xx_dma_irq, substream);
+		sport_config_rx_dma(sport, runtime->dma_area,
+				runtime->periods, fragsize_bytes);
+	}
+
+	return 0;
+}
+
+static int bf5xx_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
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
+static snd_pcm_uframes_t bf5xx_pcm_pointer(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct sport_device *sport = runtime->private_data;
+	unsigned int diff;
+	snd_pcm_uframes_t frames;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		diff = sport_curr_offset_tx(sport);
+		frames = diff / (8*4); /* 32 bytes per frame */
+	} else {
+		diff = sport_curr_offset_rx(sport);
+		frames = diff / (8*4);
+	}
+	return frames;
+}
+
+static int bf5xx_pcm_open(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	int ret;
+
+	snd_soc_set_runtime_hwparams(substream, &bf5xx_pcm_hardware);
+
+	ret = snd_pcm_hw_constraint_integer(runtime,
+			SNDRV_PCM_HW_PARAM_PERIODS);
+	if (ret < 0)
+		goto out;
+
+	if (sport_handle != NULL)
+		runtime->private_data = sport_handle;
+	else {
+		pr_err("sport_handle is NULL\n");
+		return -1;
+	}
+	return 0;
+
+ out:
+	return ret;
+}
+
+static int bf5xx_pcm_copy(struct snd_pcm_substream *substream, int channel,
+		snd_pcm_uframes_t pos, void *buf, snd_pcm_uframes_t count)
+{
+	unsigned int *src;
+	unsigned int *dst;
+	int i;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		src = buf;
+		dst = (unsigned int *)substream->runtime->dma_area;
+
+		dst += pos * 8;
+		while (count--) {
+			for (i = 0; i < substream->runtime->channels; i++)
+				*(dst + i) = *src++;
+			dst += 8;
+		}
+	} else {
+		src = (unsigned int *)substream->runtime->dma_area;
+		dst = buf;
+
+		src += pos * 8;
+		while (count--) {
+			for (i = 0; i < substream->runtime->channels; i++)
+				*dst++ = *(src+i);
+			src += 8;
+		}
+	}
+
+	return 0;
+}
+
+static int bf5xx_pcm_silence(struct snd_pcm_substream *substream,
+		int channel, snd_pcm_uframes_t pos, snd_pcm_uframes_t count)
+{
+	unsigned char *buf = substream->runtime->dma_area;
+	buf += pos * 8 * 4;
+	memset(buf, '\0', count * 8 * 4);
+
+	return 0;
+}
+
+
+struct snd_pcm_ops bf5xx_pcm_tdm_ops = {
+	.open		= bf5xx_pcm_open,
+	.ioctl		= snd_pcm_lib_ioctl,
+	.hw_params	= bf5xx_pcm_hw_params,
+	.hw_free	= bf5xx_pcm_hw_free,
+	.prepare	= bf5xx_pcm_prepare,
+	.trigger	= bf5xx_pcm_trigger,
+	.pointer	= bf5xx_pcm_pointer,
+	.copy           = bf5xx_pcm_copy,
+	.silence        = bf5xx_pcm_silence,
+};
+
+static int bf5xx_pcm_preallocate_dma_buffer(struct snd_pcm *pcm, int stream)
+{
+	struct snd_pcm_substream *substream = pcm->streams[stream].substream;
+	struct snd_dma_buffer *buf = &substream->dma_buffer;
+	size_t size = bf5xx_pcm_hardware.buffer_bytes_max;
+
+	buf->dev.type = SNDRV_DMA_TYPE_DEV;
+	buf->dev.dev = pcm->card->dev;
+	buf->private_data = NULL;
+	buf->area = dma_alloc_coherent(pcm->card->dev, size * 4,
+			&buf->addr, GFP_KERNEL);
+	if (!buf->area) {
+		pr_err("Failed to allocate dma memory \
+				Please increase uncached DMA memory region\n");
+		return -ENOMEM;
+	}
+	buf->bytes = size;
+
+	if (stream == SNDRV_PCM_STREAM_PLAYBACK)
+		sport_handle->tx_buf = buf->area;
+	else
+		sport_handle->rx_buf = buf->area;
+
+	return 0;
+}
+
+static void bf5xx_pcm_free_dma_buffers(struct snd_pcm *pcm)
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
+	if (sport_handle)
+		sport_done(sport_handle);
+}
+
+static u64 bf5xx_pcm_dmamask = DMA_32BIT_MASK;
+
+int bf5xx_pcm_tdm_new(struct snd_card *card, struct snd_soc_dai *dai,
+	struct snd_pcm *pcm)
+{
+	int ret = 0;
+
+	if (!card->dev->dma_mask)
+		card->dev->dma_mask = &bf5xx_pcm_dmamask;
+	if (!card->dev->coherent_dma_mask)
+		card->dev->coherent_dma_mask = DMA_32BIT_MASK;
+
+	if (dai->playback.channels_min) {
+		ret = bf5xx_pcm_preallocate_dma_buffer(pcm,
+			SNDRV_PCM_STREAM_PLAYBACK);
+		if (ret)
+			goto out;
+	}
+
+	if (dai->capture.channels_min) {
+		ret = bf5xx_pcm_preallocate_dma_buffer(pcm,
+			SNDRV_PCM_STREAM_CAPTURE);
+		if (ret)
+			goto out;
+	}
+ out:
+	return ret;
+}
+
+struct snd_soc_platform bf5xx_tdm_soc_platform = {
+	.name		= "bf5xx-audio",
+	.pcm_ops 	= &bf5xx_pcm_tdm_ops,
+	.pcm_new	= bf5xx_pcm_tdm_new,
+	.pcm_free	= bf5xx_pcm_free_dma_buffers,
+};
+EXPORT_SYMBOL_GPL(bf5xx_tdm_soc_platform);
+
+static int __init bfin_pcm_tdm_init(void)
+{
+	return snd_soc_register_platform(&bf5xx_tdm_soc_platform);
+}
+module_init(bfin_pcm_tdm_init);
+
+static void __exit bfin_pcm_tdm_exit(void)
+{
+	snd_soc_unregister_platform(&bf5xx_tdm_soc_platform);
+}
+module_exit(bfin_pcm_tdm_exit);
+
+MODULE_AUTHOR("Barry Song");
+MODULE_DESCRIPTION("ADI Blackfin TDM PCM DMA module");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/blackfin/bf5xx-tdm-pcm.h b/sound/soc/blackfin/bf5xx-tdm-pcm.h
new file mode 100644
index 0000000..493e6df
--- /dev/null
+++ b/sound/soc/blackfin/bf5xx-tdm-pcm.h
@@ -0,0 +1,21 @@
+/*
+ * linux/sound/arm/bf5xx-tdm-pcm.h -- ALSA PCM interface for the Blackfin
+ *
+ * Copyright 2009 Analog Device Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _BF5XX_TDM_PCM_H
+#define _BF5XX_TDM_PCM_H
+
+struct bf5xx_pcm_dma_params {
+	char *name;			/* stream identifier */
+};
+
+/* platform data */
+extern struct snd_soc_platform bf5xx_tdm_soc_platform;
+
+#endif
diff --git a/sound/soc/blackfin/bf5xx-tdm.c b/sound/soc/blackfin/bf5xx-tdm.c
new file mode 100644
index 0000000..a5624cc
--- /dev/null
+++ b/sound/soc/blackfin/bf5xx-tdm.c
@@ -0,0 +1,342 @@
+/*
+ * File:         sound/soc/blackfin/bf5xx-tdm.c
+ * Author:       Barry Song <Barry.Song@analog.com>
+ *
+ * Created:      Thurs June 04 2009
+ * Description:  Blackfin I2S(TDM) CPU DAI driver
+ * 		 Even though TDM mode can be as part of I2S DAI, but there
+ * 		 are so much difference in configuration and data flow,
+ * 		 it's very ugly to integrate I2S and TDM into a module
+ *
+ * Modified:
+ *               Copyright 2009 Analog Devices Inc.
+ *
+ * Bugs:         Enter bugs at http://blackfin.uclinux.org/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see the file COPYING, or write
+ * to the Free Software Foundation, Inc.,
+ * 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/initval.h>
+#include <sound/soc.h>
+
+#include <asm/irq.h>
+#include <asm/portmux.h>
+#include <linux/mutex.h>
+#include <linux/gpio.h>
+
+#include "bf5xx-sport.h"
+#include "bf5xx-tdm.h"
+
+struct bf5xx_tdm_port {
+	u16 tcr1;
+	u16 rcr1;
+	u16 tcr2;
+	u16 rcr2;
+	int configured;
+};
+
+static struct bf5xx_tdm_port bf5xx_tdm;
+static int sport_num = CONFIG_SND_BF5XX_SPORT_NUM;
+
+static struct sport_param sport_params[2] = {
+	{
+		.dma_rx_chan	= CH_SPORT0_RX,
+		.dma_tx_chan	= CH_SPORT0_TX,
+		.err_irq	= IRQ_SPORT0_ERROR,
+		.regs		= (struct sport_register *)SPORT0_TCR1,
+	},
+	{
+		.dma_rx_chan	= CH_SPORT1_RX,
+		.dma_tx_chan	= CH_SPORT1_TX,
+		.err_irq	= IRQ_SPORT1_ERROR,
+		.regs		= (struct sport_register *)SPORT1_TCR1,
+	}
+};
+
+/*
+ * Setting the TFS pin selector for SPORT 0 based on whether the selected
+ * port id F or G. If the port is F then no conflict should exist for the
+ * TFS. When Port G is selected and EMAC then there is a conflict between
+ * the PHY interrupt line and TFS.  Current settings prevent the conflict
+ * by ignoring the TFS pin when Port G is selected. This allows both
+ * ssm2602 using Port G and EMAC concurrently.
+ */
+#ifdef CONFIG_BF527_SPORT0_PORTF
+#define LOCAL_SPORT0_TFS (P_SPORT0_TFS)
+#else
+#define LOCAL_SPORT0_TFS (0)
+#endif
+
+static u16 sport_req[][7] = { {P_SPORT0_DTPRI, P_SPORT0_TSCLK, P_SPORT0_RFS,
+	P_SPORT0_DRPRI, P_SPORT0_RSCLK, LOCAL_SPORT0_TFS, 0},
+	   {P_SPORT1_DTPRI, P_SPORT1_TSCLK, P_SPORT1_RFS, P_SPORT1_DRPRI,
+		   P_SPORT1_RSCLK, P_SPORT1_TFS, 0} };
+
+static int bf5xx_tdm_set_dai_fmt(struct snd_soc_dai *cpu_dai,
+		unsigned int fmt)
+{
+	int ret = 0;
+
+	/* interface format:support TDM,slave mode */
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_DSP_A:
+		break;
+	default:
+		printk(KERN_ERR "%s: Unknown DAI format type\n", __func__);
+		ret = -EINVAL;
+		break;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBM_CFM:
+		break;
+	case SND_SOC_DAIFMT_CBS_CFS:
+	case SND_SOC_DAIFMT_CBM_CFS:
+	case SND_SOC_DAIFMT_CBS_CFM:
+		ret = -EINVAL;
+		break;
+	default:
+		printk(KERN_ERR "%s: Unknown DAI master type\n", __func__);
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static int bf5xx_tdm_hw_params(struct snd_pcm_substream *substream,
+		struct snd_pcm_hw_params *params,
+		struct snd_soc_dai *dai)
+{
+	int ret = 0;
+
+	bf5xx_tdm.tcr2 &= ~0x1f;
+	bf5xx_tdm.rcr2 &= ~0x1f;
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S32_LE:
+		bf5xx_tdm.tcr2 |= 31;
+		bf5xx_tdm.rcr2 |= 31;
+		sport_handle->wdsize = 4;
+		break;
+		/* at present, we only support 32bit transfer */
+	default:
+		pr_err("not supported PCM format yet\n");
+		break;
+	}
+
+	if (!bf5xx_tdm.configured) {
+		/*
+		 * TX and RX are not independent,they are enabled at the
+		 * same time, even if only one side is running. So, we
+		 * need to configure both of them at the time when the first
+		 * stream is opened.
+		 *
+		 * CPU DAI:slave mode.
+		 */
+		ret = sport_config_rx(sport_handle, bf5xx_tdm.rcr1,
+				bf5xx_tdm.rcr2, 0, 0);
+		if (ret) {
+			pr_err("SPORT is busy!\n");
+			return -EBUSY;
+		}
+
+		ret = sport_config_tx(sport_handle, bf5xx_tdm.tcr1,
+				bf5xx_tdm.tcr2, 0, 0);
+		if (ret) {
+			pr_err("SPORT is busy!\n");
+			return -EBUSY;
+		}
+
+		bf5xx_tdm.configured = 1;
+	}
+
+	return 0;
+}
+
+static void bf5xx_tdm_shutdown(struct snd_pcm_substream *substream,
+				struct snd_soc_dai *dai)
+{
+	/* No active stream, SPORT is allowed to be configured again. */
+	if (!dai->active)
+		bf5xx_tdm.configured = 0;
+}
+
+#ifdef CONFIG_PM
+static int bf5xx_tdm_suspend(struct snd_soc_dai *dai)
+{
+	struct sport_device *sport =
+		(struct sport_device *)dai->private_data;
+
+	if (!dai->active)
+		return 0;
+	if (dai->capture.active)
+		sport_rx_stop(sport);
+	if (dai->playback.active)
+		sport_tx_stop(sport);
+	return 0;
+}
+
+static int bf5xx_tdm_resume(struct snd_soc_dai *dai)
+{
+	int ret;
+	struct sport_device *sport =
+		(struct sport_device *)dai->private_data;
+
+	if (!dai->active)
+		return 0;
+
+	ret = sport_set_multichannel(sport, 8, 0xFF, 1);
+	if (ret) {
+		pr_err("SPORT is busy!\n");
+		ret = -EBUSY;
+	}
+
+	ret = sport_config_rx(sport, IRFS, 0x1F, 0, 0);
+	if (ret) {
+		pr_err("SPORT is busy!\n");
+		ret = -EBUSY;
+	}
+
+	ret = sport_config_tx(sport, ITFS, 0x1F, 0, 0);
+	if (ret) {
+		pr_err("SPORT is busy!\n");
+		ret = -EBUSY;
+	}
+
+	return 0;
+}
+
+#else
+#define bf5xx_tdm_suspend	NULL
+#define bf5xx_tdm_resume	NULL
+#endif
+
+static struct snd_soc_dai_ops bf5xx_tdm_dai_ops = {
+	.hw_params	= bf5xx_tdm_hw_params,
+	.set_fmt	= bf5xx_tdm_set_dai_fmt,
+	.shutdown       = bf5xx_tdm_shutdown,
+};
+
+struct snd_soc_dai bf5xx_tdm_dai = {
+	.name = "bf5xx-tdm",
+	.id = 0,
+	.suspend = bf5xx_tdm_suspend,
+	.resume = bf5xx_tdm_resume,
+	.playback = {
+		.channels_min = 2,
+		.channels_max = 8,
+		.rates = SNDRV_PCM_RATE_48000,
+		.formats = SNDRV_PCM_FMTBIT_S32_LE,},
+	.capture = {
+		.channels_min = 2,
+		.channels_max = 8,
+		.rates = SNDRV_PCM_RATE_48000,
+		.formats = SNDRV_PCM_FMTBIT_S32_LE,},
+	.ops = &bf5xx_tdm_dai_ops,
+};
+EXPORT_SYMBOL_GPL(bf5xx_tdm_dai);
+
+static int __devinit bfin_tdm_probe(struct platform_device *pdev)
+{
+	int ret = 0;
+
+	if (peripheral_request_list(&sport_req[sport_num][0], "soc-audio")) {
+		pr_err("Requesting Peripherals failed\n");
+		return -EFAULT;
+	}
+
+	/* request DMA for SPORT */
+	sport_handle = sport_init(&sport_params[sport_num], 4, \
+			8 * sizeof(u32), NULL);
+	if (!sport_handle) {
+		peripheral_free_list(&sport_req[sport_num][0]);
+		return -ENODEV;
+	}
+
+	/* SPORT works in TDM mode */
+	ret = sport_set_multichannel(sport_handle, 8, 0xFF, 1);
+	if (ret) {
+		pr_err("SPORT is busy!\n");
+		ret = -EBUSY;
+		goto sport_config_err;
+	}
+
+	ret = sport_config_rx(sport_handle, IRFS, 0x1F, 0, 0);
+	if (ret) {
+		pr_err("SPORT is busy!\n");
+		ret = -EBUSY;
+		goto sport_config_err;
+	}
+
+	ret = sport_config_tx(sport_handle, ITFS, 0x1F, 0, 0);
+	if (ret) {
+		pr_err("SPORT is busy!\n");
+		ret = -EBUSY;
+		goto sport_config_err;
+	}
+
+	ret = snd_soc_register_dai(&bf5xx_tdm_dai);
+	if (ret) {
+		pr_err("Failed to register DAI: %d\n", ret);
+		goto sport_config_err;
+	}
+	return 0;
+
+sport_config_err:
+	peripheral_free_list(&sport_req[sport_num][0]);
+	return ret;
+}
+
+static int __devexit bfin_tdm_remove(struct platform_device *pdev)
+{
+	peripheral_free_list(&sport_req[sport_num][0]);
+	snd_soc_unregister_dai(&bf5xx_tdm_dai);
+
+	return 0;
+}
+
+static struct platform_driver bfin_tdm_driver = {
+	.probe  = bfin_tdm_probe,
+	.remove = __devexit_p(bfin_tdm_remove),
+	.driver = {
+		.name   = "bfin-sport",
+		.owner  = THIS_MODULE,
+	},
+};
+
+static int __init bfin_tdm_init(void)
+{
+	return platform_driver_register(&bfin_tdm_driver);
+}
+module_init(bfin_tdm_init);
+
+static void __exit bfin_tdm_exit(void)
+{
+	platform_driver_unregister(&bfin_tdm_driver);
+}
+module_exit(bfin_tdm_exit);
+
+/* Module information */
+MODULE_AUTHOR("Barry Song");
+MODULE_DESCRIPTION("TDM driver for ADI Blackfin");
+MODULE_LICENSE("GPL");
+
diff --git a/sound/soc/blackfin/bf5xx-tdm.h b/sound/soc/blackfin/bf5xx-tdm.h
new file mode 100644
index 0000000..e5157cd
--- /dev/null
+++ b/sound/soc/blackfin/bf5xx-tdm.h
@@ -0,0 +1,14 @@
+/*
+ * linux/sound/arm/bf5xx-i2s.h
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _BF5XX_TDM_H
+#define _BF5XX_TDM_H
+
+extern struct snd_soc_dai bf5xx_tdm_dai;
+
+#endif
-- 
1.5.6.3
