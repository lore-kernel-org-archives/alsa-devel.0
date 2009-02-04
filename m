From: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
Subject: [PATCH 3/3] Add ALSA driver for Atmel AC97 controller
Date: Wed,  4 Feb 2009 12:48:34 +0100
Message-ID: <1233748114-6353-4-git-send-email-hans-christian.egtvedt@atmel.com>
References: <1233748114-6353-1-git-send-email-hans-christian.egtvedt@atmel.com>
	<1233748114-6353-2-git-send-email-hans-christian.egtvedt@atmel.com>
	<1233748114-6353-3-git-send-email-hans-christian.egtvedt@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay.atmel.no (relay.atmel.no [80.232.32.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 5D5EC24342
	for <alsa-devel@alsa-project.org>; Wed,  4 Feb 2009 12:48:37 +0100 (CET)
In-Reply-To: <1233748114-6353-3-git-send-email-hans-christian.egtvedt@atmel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
List-Id: alsa-devel@alsa-project.org

This patch adds ALSA support for the AC97 controller found on Atmel
AVR32 devices.

Tested on ATSTK1006 + ATSTK1000 with a development board with a AC97
codec.

Signed-off-by: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
---
 include/sound/atmel-ac97c.h |   40 ++
 sound/avr32/Kconfig         |    8 +
 sound/avr32/Makefile        |    2 +
 sound/avr32/ac97c.c         |  994 +++++++++++++++++++++++++++++++++++++++++++
 sound/avr32/ac97c.h         |   71 +++
 5 files changed, 1115 insertions(+), 0 deletions(-)
 create mode 100644 include/sound/atmel-ac97c.h
 create mode 100644 sound/avr32/ac97c.c
 create mode 100644 sound/avr32/ac97c.h

diff --git a/include/sound/atmel-ac97c.h b/include/sound/atmel-ac97c.h
new file mode 100644
index 0000000..d5daddd
--- /dev/null
+++ b/include/sound/atmel-ac97c.h
@@ -0,0 +1,40 @@
+/*
+ * Driver for the Atmel AC97C controller
+ *
+ * Copyright (C) 2005-2009 Atmel Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ */
+#ifndef __INCLUDE_SOUND_AT32_AC97C_H
+#define __INCLUDE_SOUND_AT32_AC97C_H
+
+#include <linux/dw_dmac.h>
+
+#define AC97C_CAPTURE	0x01
+#define AC97C_PLAYBACK	0x02
+#define AC97C_BOTH	(AC97C_CAPTURE | AC97C_PLAYBACK)
+
+/**
+ * struct atmel_ac97c_pdata - board specific AC97C configuration
+ * @rx_dws: DMA slave interface to use in sound capture.
+ * @tx_dws: DMA slave interface to use in sound playback.
+ * @reset_pin: GPIO pin wired to the reset input on the external AC97 codec,
+ *             optional to use, set to -ENODEV if not in use. AC97 layer will
+ *             try to do a software reset of the external codec anyway.
+ * @flags: Flags for which directions should be enabled.
+ *
+ * If the user do not want to use a DMA channel for playback or capture, i.e.
+ * only one feature is required on the board. The slave for playback or capture
+ * can be set to NULL. The AC97C driver will take use of this when setting up
+ * the sound streams.
+ */
+struct ac97c_platform_data {
+	struct dw_dma_slave	rx_dws;
+	struct dw_dma_slave	tx_dws;
+	unsigned int		flags;
+	int			reset_pin;
+};
+
+#endif /* __INCLUDE_SOUND_AT32_AC97C_H */
diff --git a/sound/avr32/Kconfig b/sound/avr32/Kconfig
index 6ac06ff..82ec27f 100644
--- a/sound/avr32/Kconfig
+++ b/sound/avr32/Kconfig
@@ -8,4 +8,12 @@ config SND_AT32_ABDAC
 	help
 	  ALSA sound driver for the Atmel AVR32 Audio Bitstream DAC (ABDAC).
 
+config SND_AT32_AC97C
+	tristate "Atmel AVR32 AC97 Controller Driver"
+	select SND_PCM
+	select SND_AC97_CODEC
+	depends on DW_DMAC
+	help
+	  ALSA sound driver for the Atmel AVR32 AC97 controller.
+
 endmenu
diff --git a/sound/avr32/Makefile b/sound/avr32/Makefile
index fa9ac7f..4018adc 100644
--- a/sound/avr32/Makefile
+++ b/sound/avr32/Makefile
@@ -1,3 +1,5 @@
 snd-at32-abdac-objs		:= abdac.o
+snd-at32-ac97c-objs		:= ac97c.o
 
 obj-$(CONFIG_SND_AT32_ABDAC)	+= snd-at32-abdac.o
+obj-$(CONFIG_SND_AT32_AC97C)	+= snd-at32-ac97c.o
diff --git a/sound/avr32/ac97c.c b/sound/avr32/ac97c.c
new file mode 100644
index 0000000..218d666
--- /dev/null
+++ b/sound/avr32/ac97c.c
@@ -0,0 +1,994 @@
+/*
+ * Driver for the Atmel AC97C controller
+ *
+ * Copyright (C) 2005-2009 Atmel Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ */
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/bitmap.h>
+#include <linux/dmaengine.h>
+#include <linux/dma-mapping.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/mutex.h>
+#include <linux/gpio.h>
+#include <linux/io.h>
+
+#include <sound/core.h>
+#include <sound/initval.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/ac97_codec.h>
+#include <sound/atmel-ac97c.h>
+#include <sound/memalloc.h>
+
+#include <linux/dw_dmac.h>
+
+#include "ac97c.h"
+
+enum {
+	DMA_TX_READY = 0,
+	DMA_TX_STOP,
+	DMA_RX_READY,
+	DMA_RX_STOP,
+	DMA_TX_CHAN_PRESENT,
+	DMA_RX_CHAN_PRESENT,
+};
+
+/* Serialize access to opened variable */
+static DEFINE_MUTEX(opened_mutex);
+
+struct atmel_ac97c_dma {
+	struct dma_chan			*rx_chan;
+	struct dma_chan			*tx_chan;
+};
+
+struct atmel_ac97c {
+	struct clk			*pclk;
+	struct platform_device		*pdev;
+	struct atmel_ac97c_dma		dma;
+
+	struct snd_pcm_substream	*playback_substream;
+	struct snd_pcm_substream	*capture_substream;
+	struct snd_card			*card;
+	struct snd_pcm			*pcm;
+	struct snd_ac97			*ac97;
+	struct snd_ac97_bus		*ac97_bus;
+
+	u64				cur_format;
+	unsigned int			cur_rate;
+	unsigned long			flags;
+	/* Serialize access to opened variable */
+	spinlock_t			lock;
+	void __iomem			*regs;
+	int				opened;
+	int				reset_pin;
+};
+
+#define get_chip(card) ((struct atmel_ac97c *)(card)->private_data)
+
+#define ac97c_writel(chip, reg, val)			\
+	__raw_writel((val), (chip)->regs + AC97C_##reg)
+#define ac97c_readl(chip, reg)				\
+	__raw_readl((chip)->regs + AC97C_##reg)
+
+/* This function is called by the DMA driver. */
+static void atmel_ac97c_dma_playback_period_done(void *arg)
+{
+	struct atmel_ac97c	*chip = arg;
+
+	if (test_bit(DMA_TX_STOP, &chip->flags))
+		return;
+	snd_pcm_period_elapsed(chip->playback_substream);
+}
+
+static void atmel_ac97c_dma_capture_period_done(void *arg)
+{
+	struct atmel_ac97c	*chip = arg;
+
+	if (test_bit(DMA_RX_STOP, &chip->flags))
+		return;
+	snd_pcm_period_elapsed(chip->capture_substream);
+}
+
+static int atmel_ac97c_prepare_dma(struct atmel_ac97c *chip,
+		struct snd_pcm_substream *substream,
+		enum dma_data_direction direction)
+{
+	struct dma_chan			*chan;
+	struct dw_cyclic_desc		*cdesc;
+	struct snd_pcm_runtime		*runtime = substream->runtime;
+	unsigned long			buffer_len, period_len;
+
+	/*
+	 * We don't do DMA on "complex" transfers, i.e. with
+	 * non-halfword-aligned buffers or lengths.
+	 */
+	if (runtime->dma_addr & 1 || runtime->buffer_size & 1) {
+		dev_dbg(&chip->pdev->dev, "too complex transfer\n");
+		return -EINVAL;
+	}
+
+	if (direction == DMA_TO_DEVICE)
+		chan = chip->dma.tx_chan;
+	else
+		chan = chip->dma.rx_chan;
+
+	buffer_len = frames_to_bytes(runtime, runtime->buffer_size);
+	period_len = frames_to_bytes(runtime, runtime->period_size);
+
+	cdesc = dw_dma_cyclic_prep(chan, runtime->dma_addr, buffer_len,
+			period_len, direction);
+	if (IS_ERR(cdesc)) {
+		dev_dbg(&chip->pdev->dev, "could not prepare cyclic DMA\n");
+		return PTR_ERR(cdesc);
+	}
+
+	if (direction == DMA_TO_DEVICE) {
+		cdesc->period_callback = atmel_ac97c_dma_playback_period_done;
+		set_bit(DMA_TX_READY, &chip->flags);
+	} else {
+		cdesc->period_callback = atmel_ac97c_dma_capture_period_done;
+		set_bit(DMA_RX_READY, &chip->flags);
+	}
+
+	cdesc->period_callback_param = chip;
+
+	return 0;
+}
+
+static struct snd_pcm_hardware atmel_ac97c_playback_hw = {
+	.info			= (SNDRV_PCM_INFO_MMAP
+				  | SNDRV_PCM_INFO_MMAP_VALID
+				  | SNDRV_PCM_INFO_INTERLEAVED
+				  | SNDRV_PCM_INFO_BLOCK_TRANSFER
+				  | SNDRV_PCM_INFO_JOINT_DUPLEX
+				  | SNDRV_PCM_INFO_BLOCK_TRANSFER
+				  | SNDRV_PCM_INFO_RESUME
+				  | SNDRV_PCM_INFO_PAUSE),
+	.formats		= (SNDRV_PCM_FMTBIT_S16_BE
+				  | SNDRV_PCM_FMTBIT_S16_LE),
+	.rates			= (SNDRV_PCM_RATE_CONTINUOUS),
+	.rate_min		= 4000,
+	.rate_max		= 48000,
+	.channels_min		= 1,
+	.channels_max		= 2,
+	.buffer_bytes_max	= 64 * 4096,
+	.period_bytes_min	= 4096,
+	.period_bytes_max	= 4096,
+	.periods_min		= 4,
+	.periods_max		= 64,
+};
+
+static struct snd_pcm_hardware atmel_ac97c_capture_hw = {
+	.info			= (SNDRV_PCM_INFO_MMAP
+				  | SNDRV_PCM_INFO_MMAP_VALID
+				  | SNDRV_PCM_INFO_INTERLEAVED
+				  | SNDRV_PCM_INFO_BLOCK_TRANSFER
+				  | SNDRV_PCM_INFO_JOINT_DUPLEX
+				  | SNDRV_PCM_INFO_BLOCK_TRANSFER
+				  | SNDRV_PCM_INFO_RESUME
+				  | SNDRV_PCM_INFO_PAUSE),
+	.formats		= (SNDRV_PCM_FMTBIT_S16_BE
+				  | SNDRV_PCM_FMTBIT_S16_LE),
+	.rates			= (SNDRV_PCM_RATE_CONTINUOUS),
+	.rate_min		= 4000,
+	.rate_max		= 48000,
+	.channels_min		= 1,
+	.channels_max		= 2,
+	.buffer_bytes_max	= 64 * 4096,
+	.period_bytes_min	= 4096,
+	.period_bytes_max	= 4096,
+	.periods_min		= 4,
+	.periods_max		= 64,
+};
+
+static int atmel_ac97c_playback_open(struct snd_pcm_substream *substream)
+{
+	struct atmel_ac97c *chip = snd_pcm_substream_chip(substream);
+	struct snd_pcm_runtime *runtime = substream->runtime;
+
+	mutex_lock(&opened_mutex);
+	chip->opened++;
+	runtime->hw = atmel_ac97c_playback_hw;
+	if (chip->cur_rate) {
+		runtime->hw.rate_min = chip->cur_rate;
+		runtime->hw.rate_max = chip->cur_rate;
+	}
+	if (chip->cur_format)
+		runtime->hw.formats = (1ULL << chip->cur_format);
+	mutex_unlock(&opened_mutex);
+	chip->playback_substream = substream;
+	return 0;
+}
+
+static int atmel_ac97c_capture_open(struct snd_pcm_substream *substream)
+{
+	struct atmel_ac97c *chip = snd_pcm_substream_chip(substream);
+	struct snd_pcm_runtime *runtime = substream->runtime;
+
+	mutex_lock(&opened_mutex);
+	chip->opened++;
+	runtime->hw = atmel_ac97c_capture_hw;
+	if (chip->cur_rate) {
+		runtime->hw.rate_min = chip->cur_rate;
+		runtime->hw.rate_max = chip->cur_rate;
+	}
+	if (chip->cur_format)
+		runtime->hw.formats = (1ULL << chip->cur_format);
+	mutex_unlock(&opened_mutex);
+	chip->capture_substream = substream;
+	return 0;
+}
+
+static int atmel_ac97c_playback_close(struct snd_pcm_substream *substream)
+{
+	struct atmel_ac97c *chip = snd_pcm_substream_chip(substream);
+
+	mutex_lock(&opened_mutex);
+	chip->opened--;
+	if (!chip->opened) {
+		chip->cur_rate = 0;
+		chip->cur_format = 0;
+	}
+	mutex_unlock(&opened_mutex);
+
+	clear_bit(DMA_TX_STOP, &chip->flags);
+	chip->playback_substream = NULL;
+
+	return 0;
+}
+
+static int atmel_ac97c_capture_close(struct snd_pcm_substream *substream)
+{
+	struct atmel_ac97c *chip = snd_pcm_substream_chip(substream);
+
+	mutex_lock(&opened_mutex);
+	chip->opened--;
+	if (!chip->opened) {
+		chip->cur_rate = 0;
+		chip->cur_format = 0;
+	}
+	mutex_unlock(&opened_mutex);
+
+	clear_bit(DMA_RX_STOP, &chip->flags);
+	chip->capture_substream = NULL;
+
+	return 0;
+}
+
+static int atmel_ac97c_playback_hw_params(struct snd_pcm_substream *substream,
+		struct snd_pcm_hw_params *hw_params)
+{
+	struct atmel_ac97c *chip = snd_pcm_substream_chip(substream);
+	int retval;
+
+	retval = snd_pcm_lib_malloc_pages(substream,
+					params_buffer_bytes(hw_params));
+	if (retval)
+		return retval;
+
+	/* Set restrictions to params */
+	mutex_lock(&opened_mutex);
+	chip->cur_rate = params_rate(hw_params);
+	chip->cur_format = params_format(hw_params);
+	mutex_unlock(&opened_mutex);
+
+	if (test_and_clear_bit(DMA_TX_READY, &chip->flags))
+		dw_dma_cyclic_free(chip->dma.tx_chan);
+
+	return atmel_ac97c_prepare_dma(chip, substream, DMA_TO_DEVICE);
+}
+
+static int atmel_ac97c_capture_hw_params(struct snd_pcm_substream *substream,
+		struct snd_pcm_hw_params *hw_params)
+{
+	struct atmel_ac97c *chip = snd_pcm_substream_chip(substream);
+	int retval;
+
+	retval = snd_pcm_lib_malloc_pages(substream,
+					params_buffer_bytes(hw_params));
+	if (retval)
+		return retval;
+
+	/* Set restrictions to params */
+	mutex_lock(&opened_mutex);
+	chip->cur_rate = params_rate(hw_params);
+	chip->cur_format = params_format(hw_params);
+	mutex_unlock(&opened_mutex);
+
+	if (test_and_clear_bit(DMA_RX_READY, &chip->flags))
+		dw_dma_cyclic_free(chip->dma.rx_chan);
+
+	return atmel_ac97c_prepare_dma(chip, substream, DMA_FROM_DEVICE);
+}
+
+static int atmel_ac97c_playback_hw_free(struct snd_pcm_substream *substream)
+{
+	struct atmel_ac97c *chip = snd_pcm_substream_chip(substream);
+	if (test_and_clear_bit(DMA_TX_READY, &chip->flags))
+		dw_dma_cyclic_free(chip->dma.tx_chan);
+	return snd_pcm_lib_free_pages(substream);
+}
+
+static int atmel_ac97c_capture_hw_free(struct snd_pcm_substream *substream)
+{
+	struct atmel_ac97c *chip = snd_pcm_substream_chip(substream);
+	if (test_and_clear_bit(DMA_RX_READY, &chip->flags))
+		dw_dma_cyclic_free(chip->dma.rx_chan);
+	return snd_pcm_lib_free_pages(substream);
+}
+
+static int atmel_ac97c_playback_prepare(struct snd_pcm_substream *substream)
+{
+	struct atmel_ac97c *chip = snd_pcm_substream_chip(substream);
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	unsigned long word = 0;
+	int retval;
+
+	/* assign channels to AC97C channel A */
+	switch (runtime->channels) {
+	case 1:
+		word |= AC97C_CH_ASSIGN(PCM_LEFT, A);
+		break;
+	case 2:
+		word |= AC97C_CH_ASSIGN(PCM_LEFT, A)
+			| AC97C_CH_ASSIGN(PCM_RIGHT, A);
+		break;
+	default:
+		/* TODO: support more than two channels */
+		return -EINVAL;
+		break;
+	}
+	ac97c_writel(chip, OCA, word);
+
+	/* configure sample format and size */
+	word = AC97C_CMR_DMAEN | AC97C_CMR_SIZE_16;
+
+	switch (runtime->format) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+		word |= AC97C_CMR_CEM_LITTLE;
+		break;
+	case SNDRV_PCM_FORMAT_S16_BE: /* fall through */
+	default:
+		word &= ~(AC97C_CMR_CEM_LITTLE);
+		break;
+	}
+
+	ac97c_writel(chip, CAMR, word);
+
+	/* set variable rate if needed */
+	if (runtime->rate != 48000) {
+		word = ac97c_readl(chip, MR);
+		word |= AC97C_MR_VRA;
+		ac97c_writel(chip, MR, word);
+	} else {
+		word = ac97c_readl(chip, MR);
+		word &= ~(AC97C_MR_VRA);
+		ac97c_writel(chip, MR, word);
+	}
+
+	retval = snd_ac97_set_rate(chip->ac97, AC97_PCM_FRONT_DAC_RATE,
+			runtime->rate);
+	if (retval)
+		dev_dbg(&chip->pdev->dev, "could not set rate %d Hz\n",
+				runtime->rate);
+	return retval;
+}
+
+static int atmel_ac97c_capture_prepare(struct snd_pcm_substream *substream)
+{
+	struct atmel_ac97c *chip = snd_pcm_substream_chip(substream);
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	unsigned long word = 0;
+	int retval;
+
+	/* assign channels to AC97C channel A */
+	switch (runtime->channels) {
+	case 1:
+		word |= AC97C_CH_ASSIGN(PCM_LEFT, A);
+		break;
+	case 2:
+		word |= AC97C_CH_ASSIGN(PCM_LEFT, A)
+			| AC97C_CH_ASSIGN(PCM_RIGHT, A);
+		break;
+	default:
+		/* TODO: support more than two channels */
+		return -EINVAL;
+		break;
+	}
+	ac97c_writel(chip, ICA, word);
+
+	/* configure sample format and size */
+	word = AC97C_CMR_DMAEN | AC97C_CMR_SIZE_16;
+
+	switch (runtime->format) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+		word |= AC97C_CMR_CEM_LITTLE;
+		break;
+	case SNDRV_PCM_FORMAT_S16_BE: /* fall through */
+	default:
+		word &= ~(AC97C_CMR_CEM_LITTLE);
+		break;
+	}
+
+	ac97c_writel(chip, CAMR, word);
+
+	/* set variable rate if needed */
+	if (runtime->rate != 48000) {
+		word = ac97c_readl(chip, MR);
+		word |= AC97C_MR_VRA;
+		ac97c_writel(chip, MR, word);
+	} else {
+		word = ac97c_readl(chip, MR);
+		word &= ~(AC97C_MR_VRA);
+		ac97c_writel(chip, MR, word);
+	}
+
+	retval = snd_ac97_set_rate(chip->ac97, AC97_PCM_LR_ADC_RATE,
+			runtime->rate);
+	if (retval)
+		dev_dbg(&chip->pdev->dev, "could not set rate %d Hz\n",
+				runtime->rate);
+	return retval;
+}
+
+static int
+atmel_ac97c_playback_trigger(struct snd_pcm_substream *substream, int cmd)
+{
+	struct atmel_ac97c *chip = snd_pcm_substream_chip(substream);
+	unsigned long camr;
+	int retval = 0;
+
+	camr = ac97c_readl(chip, CAMR);
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE: /* fall through */
+	case SNDRV_PCM_TRIGGER_RESUME: /* fall through */
+	case SNDRV_PCM_TRIGGER_START:
+		retval = dw_dma_cyclic_start(chip->dma.tx_chan);
+		if (retval)
+			goto out;
+		camr |= AC97C_CMR_CENA;
+		break;
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH: /* fall through */
+	case SNDRV_PCM_TRIGGER_SUSPEND: /* fall through */
+	case SNDRV_PCM_TRIGGER_STOP:
+		set_bit(DMA_TX_STOP, &chip->flags);
+		dw_dma_cyclic_stop(chip->dma.tx_chan);
+		if (chip->opened <= 1)
+			camr &= ~AC97C_CMR_CENA;
+		break;
+	default:
+		retval = -EINVAL;
+		goto out;
+	}
+
+	ac97c_writel(chip, CAMR, camr);
+out:
+	return retval;
+}
+
+static int
+atmel_ac97c_capture_trigger(struct snd_pcm_substream *substream, int cmd)
+{
+	struct atmel_ac97c *chip = snd_pcm_substream_chip(substream);
+	unsigned long camr;
+	int retval = 0;
+
+	camr = ac97c_readl(chip, CAMR);
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE: /* fall through */
+	case SNDRV_PCM_TRIGGER_RESUME: /* fall through */
+	case SNDRV_PCM_TRIGGER_START:
+		dw_dma_cyclic_start(chip->dma.rx_chan);
+		if (retval)
+			goto out;
+		camr |= AC97C_CMR_CENA;
+		break;
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH: /* fall through */
+	case SNDRV_PCM_TRIGGER_SUSPEND: /* fall through */
+	case SNDRV_PCM_TRIGGER_STOP:
+		set_bit(DMA_RX_STOP, &chip->flags);
+		dw_dma_cyclic_stop(chip->dma.rx_chan);
+		if (chip->opened <= 1)
+			camr &= ~AC97C_CMR_CENA;
+		break;
+	default:
+		retval = -EINVAL;
+		break;
+	}
+
+	ac97c_writel(chip, CAMR, camr);
+out:
+	return retval;
+}
+
+static snd_pcm_uframes_t
+atmel_ac97c_playback_pointer(struct snd_pcm_substream *substream)
+{
+	struct atmel_ac97c	*chip = snd_pcm_substream_chip(substream);
+	struct snd_pcm_runtime	*runtime = substream->runtime;
+	snd_pcm_uframes_t	frames;
+	unsigned long		bytes;
+
+	bytes = dw_dma_get_src_addr(chip->dma.tx_chan);
+	bytes -= runtime->dma_addr;
+
+	frames = bytes_to_frames(runtime, bytes);
+	if (frames >= runtime->buffer_size)
+		frames -= runtime->buffer_size;
+	return frames;
+}
+
+static snd_pcm_uframes_t
+atmel_ac97c_capture_pointer(struct snd_pcm_substream *substream)
+{
+	struct atmel_ac97c	*chip = snd_pcm_substream_chip(substream);
+	struct snd_pcm_runtime	*runtime = substream->runtime;
+	snd_pcm_uframes_t	frames;
+	unsigned long		bytes;
+
+	bytes = dw_dma_get_dst_addr(chip->dma.rx_chan);
+	bytes -= runtime->dma_addr;
+
+	frames = bytes_to_frames(runtime, bytes);
+	if (frames >= runtime->buffer_size)
+		frames -= runtime->buffer_size;
+	return frames;
+}
+
+static struct snd_pcm_ops atmel_ac97_playback_ops = {
+	.open		= atmel_ac97c_playback_open,
+	.close		= atmel_ac97c_playback_close,
+	.ioctl		= snd_pcm_lib_ioctl,
+	.hw_params	= atmel_ac97c_playback_hw_params,
+	.hw_free	= atmel_ac97c_playback_hw_free,
+	.prepare	= atmel_ac97c_playback_prepare,
+	.trigger	= atmel_ac97c_playback_trigger,
+	.pointer	= atmel_ac97c_playback_pointer,
+};
+
+static struct snd_pcm_ops atmel_ac97_capture_ops = {
+	.open		= atmel_ac97c_capture_open,
+	.close		= atmel_ac97c_capture_close,
+	.ioctl		= snd_pcm_lib_ioctl,
+	.hw_params	= atmel_ac97c_capture_hw_params,
+	.hw_free	= atmel_ac97c_capture_hw_free,
+	.prepare	= atmel_ac97c_capture_prepare,
+	.trigger	= atmel_ac97c_capture_trigger,
+	.pointer	= atmel_ac97c_capture_pointer,
+};
+
+static struct ac97_pcm atmel_ac97_pcm_defs[] __devinitdata = {
+	/* Playback */
+	{
+		.exclusive = 1,
+		.r = { {
+			.slots = ((1 << AC97_SLOT_PCM_LEFT)
+					| (1 << AC97_SLOT_PCM_RIGHT)
+					| (1 << AC97_SLOT_PCM_CENTER)
+					| (1 << AC97_SLOT_PCM_SLEFT)
+					| (1 << AC97_SLOT_PCM_SRIGHT)
+					| (1 << AC97_SLOT_LFE)),
+		} }
+	},
+	/* PCM in */
+	{
+		.stream = 1,
+		.exclusive = 1,
+		.r = { {
+			.slots = ((1 << AC97_SLOT_PCM_LEFT)
+					| (1 << AC97_SLOT_PCM_RIGHT)),
+		} }
+	},
+	/* Mic in */
+	{
+		.stream = 1,
+		.exclusive = 1,
+		.r = { {
+			.slots = (1 << AC97_SLOT_MIC),
+		} }
+	},
+};
+
+static int __devinit atmel_ac97c_pcm_new(struct atmel_ac97c *chip)
+{
+	struct snd_pcm *pcm;
+	int capture = test_bit(DMA_RX_CHAN_PRESENT, &chip->flags);
+	int playback = test_bit(DMA_TX_CHAN_PRESENT, &chip->flags);
+	int err;
+
+	err = snd_ac97_pcm_assign(chip->ac97_bus,
+			ARRAY_SIZE(atmel_ac97_pcm_defs),
+			atmel_ac97_pcm_defs);
+	if (err)
+		return err;
+
+	err = snd_pcm_new(chip->card, "Atmel AC97C", chip->pdev->id,
+			playback, capture, &pcm);
+	if (err)
+		return err;
+
+	if (capture)
+		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE,
+				&atmel_ac97_capture_ops);
+
+	if (playback)
+		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK,
+				&atmel_ac97_playback_ops);
+
+	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
+			&chip->pdev->dev,
+			128 * 1024, 128 * 1024);
+
+	pcm->private_data = chip;
+	pcm->info_flags = 0;
+	strcpy(pcm->name, "Atmel AC97C");
+	chip->pcm = pcm;
+
+	return 0;
+}
+
+static int atmel_ac97c_mixer_new(struct atmel_ac97c *chip)
+{
+	struct snd_ac97_template template;
+	memset(&template, 0, sizeof(template));
+	template.private_data = chip;
+	return snd_ac97_mixer(chip->ac97_bus, &template, &chip->ac97);
+}
+
+static void atmel_ac97c_write(struct snd_ac97 *ac97, unsigned short reg,
+		unsigned short val)
+{
+	struct atmel_ac97c *chip = get_chip(ac97);
+	unsigned long word;
+	int timeout = 40;
+
+	word = (reg & 0x7f) << 16 | val;
+
+	do {
+		if (ac97c_readl(chip, COSR) & AC97C_CSR_TXRDY) {
+			ac97c_writel(chip, COTHR, word);
+			return;
+		}
+		udelay(1);
+	} while (--timeout);
+
+	dev_dbg(&chip->pdev->dev, "codec write timeout\n");
+}
+
+static unsigned short atmel_ac97c_read(struct snd_ac97 *ac97,
+		unsigned short reg)
+{
+	struct atmel_ac97c *chip = get_chip(ac97);
+	unsigned long word;
+	int timeout = 40;
+	int write = 10;
+
+	word = (0x80 | (reg & 0x7f)) << 16;
+
+	if ((ac97c_readl(chip, COSR) & AC97C_CSR_RXRDY) != 0)
+		ac97c_readl(chip, CORHR);
+
+retry_write:
+	timeout = 40;
+
+	do {
+		if ((ac97c_readl(chip, COSR) & AC97C_CSR_TXRDY) != 0) {
+			ac97c_writel(chip, COTHR, word);
+			goto read_reg;
+		}
+		udelay(10);
+	} while (--timeout);
+
+	if (!--write)
+		goto timed_out;
+	goto retry_write;
+
+read_reg:
+	do {
+		if ((ac97c_readl(chip, COSR) & AC97C_CSR_RXRDY) != 0) {
+			unsigned short val = ac97c_readl(chip, CORHR);
+			return val;
+		}
+		udelay(10);
+	} while (--timeout);
+
+	if (!--write)
+		goto timed_out;
+	goto retry_write;
+
+timed_out:
+	dev_dbg(&chip->pdev->dev, "codec read timeout\n");
+	return 0xffff;
+}
+
+static bool filter(struct dma_chan *chan, void *slave)
+{
+	struct dw_dma_slave *dws = slave;
+
+	if (dws->dma_dev == chan->device->dev) {
+		chan->private = dws;
+		return true;
+	} else
+		return false;
+}
+
+static void atmel_ac97c_reset(struct atmel_ac97c *chip)
+{
+	ac97c_writel(chip, MR, AC97C_MR_WRST);
+
+	if (gpio_is_valid(chip->reset_pin)) {
+		gpio_set_value(chip->reset_pin, 0);
+		/* AC97 v2.2 specifications says minimum 1 us. */
+		udelay(10);
+		gpio_set_value(chip->reset_pin, 1);
+	}
+
+	udelay(1);
+	ac97c_writel(chip, MR, AC97C_MR_ENA);
+}
+
+static int __devinit atmel_ac97c_probe(struct platform_device *pdev)
+{
+	struct snd_card			*card;
+	struct atmel_ac97c		*chip;
+	struct resource			*regs;
+	struct ac97c_platform_data	*pdata;
+	struct clk			*pclk;
+	static struct snd_ac97_bus_ops	ops = {
+		.write	= atmel_ac97c_write,
+		.read	= atmel_ac97c_read,
+	};
+	int				retval;
+
+	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!regs) {
+		dev_dbg(&pdev->dev, "no memory resource\n");
+		return -ENXIO;
+	}
+
+	pdata = pdev->dev.platform_data;
+	if (!pdata) {
+		dev_dbg(&pdev->dev, "no platform data\n");
+		return -ENXIO;
+	}
+
+	pclk = clk_get(&pdev->dev, "pclk");
+	if (IS_ERR(pclk)) {
+		dev_dbg(&pdev->dev, "no peripheral clock\n");
+		return PTR_ERR(pclk);
+	}
+	clk_enable(pclk);
+
+	mutex_init(&opened_mutex);
+
+	retval = -ENOMEM;
+	card = snd_card_new(SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1,
+			THIS_MODULE, sizeof(struct atmel_ac97c));
+	if (!card) {
+		dev_dbg(&pdev->dev, "could not allocate memory\n");
+		goto err_snd_card_new;
+	}
+
+	chip = get_chip(card);
+
+	spin_lock_init(&chip->lock);
+
+	chip->card = card;
+	chip->pclk = pclk;
+	chip->pdev = pdev;
+	chip->regs = ioremap(regs->start, regs->end - regs->start + 1);
+
+	if (!chip->regs) {
+		dev_dbg(&pdev->dev, "could not remap register memory\n");
+		goto err_ioremap;
+	}
+
+	if (gpio_is_valid(pdata->reset_pin)) {
+		if (gpio_request(pdata->reset_pin, chip->card->shortname)) {
+			dev_dbg(&pdev->dev, "reset pin not available\n");
+			chip->reset_pin = -ENODEV;
+		} else {
+			gpio_direction_output(pdata->reset_pin, 1);
+			chip->reset_pin = pdata->reset_pin;
+		}
+	}
+
+	snd_card_set_dev(card, &pdev->dev);
+
+	retval = snd_ac97_bus(card, 0, &ops, chip, &chip->ac97_bus);
+	if (retval) {
+		dev_dbg(&pdev->dev, "could not register on ac97 bus\n");
+		goto err_ac97_bus;
+	}
+
+	atmel_ac97c_reset(chip);
+
+	retval = atmel_ac97c_mixer_new(chip);
+	if (retval) {
+		dev_dbg(&pdev->dev, "could not register ac97 mixer\n");
+		goto err_ac97_bus;
+	}
+
+	if (pdata->rx_dws.dma_dev) {
+		struct dw_dma_slave *dws = &pdata->rx_dws;
+		dma_cap_mask_t mask;
+
+		dws->rx_reg = regs->start + AC97C_CARHR + 2;
+
+		dma_cap_zero(mask);
+		dma_cap_set(DMA_SLAVE, mask);
+
+		chip->dma.rx_chan = dma_request_channel(mask, filter, dws);
+
+		dev_info(&chip->pdev->dev, "using %s for DMA RX\n",
+					chip->dma.rx_chan->dev->device.bus_id);
+		set_bit(DMA_RX_CHAN_PRESENT, &chip->flags);
+	}
+
+	if (pdata->tx_dws.dma_dev) {
+		struct dw_dma_slave *dws = &pdata->tx_dws;
+		dma_cap_mask_t mask;
+
+		dws->tx_reg = regs->start + AC97C_CATHR + 2;
+
+		dma_cap_zero(mask);
+		dma_cap_set(DMA_SLAVE, mask);
+
+		chip->dma.tx_chan = dma_request_channel(mask, filter, dws);
+
+		dev_info(&chip->pdev->dev, "using %s for DMA TX\n",
+					chip->dma.tx_chan->dev->device.bus_id);
+		set_bit(DMA_TX_CHAN_PRESENT, &chip->flags);
+	}
+
+	if (!test_bit(DMA_RX_CHAN_PRESENT, &chip->flags) &&
+			!test_bit(DMA_TX_CHAN_PRESENT, &chip->flags)) {
+		dev_dbg(&pdev->dev, "DMA not available\n");
+		retval = -ENODEV;
+		goto err_dma;
+	}
+
+	retval = atmel_ac97c_pcm_new(chip);
+	if (retval) {
+		dev_dbg(&pdev->dev, "could not register ac97 pcm device\n");
+		goto err_dma;
+	}
+
+	strcpy(card->driver, "Atmel AC97C");
+	strcpy(card->shortname, "Atmel AC97C");
+	sprintf(card->longname, "Atmel AC97 Controller");
+
+	retval = snd_card_register(card);
+	if (retval) {
+		dev_dbg(&pdev->dev, "could not register sound card\n");
+		goto err_ac97_bus;
+	}
+
+	platform_set_drvdata(pdev, card);
+
+	dev_info(&pdev->dev, "Atmel AC97 controller at 0x%p\n",
+			chip->regs);
+
+	return retval;
+
+err_dma:
+	if (test_bit(DMA_RX_CHAN_PRESENT, &chip->flags))
+		dma_release_channel(chip->dma.rx_chan);
+	if (test_bit(DMA_TX_CHAN_PRESENT, &chip->flags))
+		dma_release_channel(chip->dma.tx_chan);
+	clear_bit(DMA_RX_CHAN_PRESENT, &chip->flags);
+	clear_bit(DMA_TX_CHAN_PRESENT, &chip->flags);
+	chip->dma.rx_chan = NULL;
+	chip->dma.tx_chan = NULL;
+err_ac97_bus:
+	snd_card_set_dev(card, NULL);
+
+	if (gpio_is_valid(chip->reset_pin))
+		gpio_free(chip->reset_pin);
+
+	iounmap(chip->regs);
+err_ioremap:
+	snd_card_free(card);
+err_snd_card_new:
+	clk_disable(pclk);
+	clk_put(pclk);
+	return retval;
+}
+
+#ifdef CONFIG_PM
+static int atmel_ac97c_suspend(struct platform_device *pdev, pm_message_t msg)
+{
+	struct snd_card *card = platform_get_drvdata(pdev);
+	struct atmel_ac97c *chip = card->private_data;
+
+	if (test_bit(DMA_RX_READY, &chip->flags))
+		dw_dma_cyclic_stop(chip->dma.rx_chan);
+	if (test_bit(DMA_TX_READY, &chip->flags))
+		dw_dma_cyclic_stop(chip->dma.tx_chan);
+	clk_disable(chip->pclk);
+
+	return 0;
+}
+
+static int atmel_ac97c_resume(struct platform_device *pdev)
+{
+	struct snd_card *card = platform_get_drvdata(pdev);
+	struct atmel_ac97c *chip = card->private_data;
+
+	clk_enable(chip->pclk);
+	if (test_bit(DMA_RX_READY, &chip->flags))
+		dw_dma_cyclic_start(chip->dma.rx_chan);
+	if (test_bit(DMA_TX_READY, &chip->flags))
+		dw_dma_cyclic_start(chip->dma.tx_chan);
+
+	return 0;
+}
+#else
+#define atmel_ac97c_suspend NULL
+#define atmel_ac97c_resume NULL
+#endif
+
+static int __devexit atmel_ac97c_remove(struct platform_device *pdev)
+{
+	struct snd_card *card = platform_get_drvdata(pdev);
+	struct atmel_ac97c *chip = get_chip(card);
+
+	if (gpio_is_valid(chip->reset_pin))
+		gpio_free(chip->reset_pin);
+
+	clk_disable(chip->pclk);
+	clk_put(chip->pclk);
+	iounmap(chip->regs);
+
+	if (test_bit(DMA_RX_CHAN_PRESENT, &chip->flags))
+		dma_release_channel(chip->dma.rx_chan);
+	if (test_bit(DMA_TX_CHAN_PRESENT, &chip->flags))
+		dma_release_channel(chip->dma.tx_chan);
+	clear_bit(DMA_RX_CHAN_PRESENT, &chip->flags);
+	clear_bit(DMA_TX_CHAN_PRESENT, &chip->flags);
+	chip->dma.rx_chan = NULL;
+	chip->dma.tx_chan = NULL;
+
+	snd_card_set_dev(card, NULL);
+	snd_card_free(card);
+
+	platform_set_drvdata(pdev, NULL);
+
+	return 0;
+}
+
+static struct platform_driver atmel_ac97c_driver = {
+	.remove		= __devexit_p(atmel_ac97c_remove),
+	.driver		= {
+		.name	= "atmel_ac97c",
+	},
+	.suspend	= atmel_ac97c_suspend,
+	.resume		= atmel_ac97c_resume,
+};
+
+static int __init atmel_ac97c_init(void)
+{
+	return platform_driver_probe(&atmel_ac97c_driver,
+			atmel_ac97c_probe);
+}
+module_init(atmel_ac97c_init);
+
+static void __exit atmel_ac97c_exit(void)
+{
+	platform_driver_unregister(&atmel_ac97c_driver);
+}
+module_exit(atmel_ac97c_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Driver for Atmel AC97 Controller");
+MODULE_AUTHOR("Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>");
diff --git a/sound/avr32/ac97c.h b/sound/avr32/ac97c.h
new file mode 100644
index 0000000..ac49a4d
--- /dev/null
+++ b/sound/avr32/ac97c.h
@@ -0,0 +1,71 @@
+/*
+ * Register definitions for the Atmel AC97C Controller.
+ *
+ * Copyright (C) 2005-2009 Atmel Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ */
+#ifndef __SOUND_AVR32_AC97C_H
+#define __SOUND_AVR32_AC97C_H
+
+#define AC97C_MR		0x08
+#define AC97C_ICA		0x10
+#define AC97C_OCA		0x14
+#define AC97C_CARHR		0x20
+#define AC97C_CATHR		0x24
+#define AC97C_CASR		0x28
+#define AC97C_CAMR		0x2c
+#define AC97C_CBRHR		0x30
+#define AC97C_CBTHR		0x34
+#define AC97C_CBSR		0x38
+#define AC97C_CBMR		0x3c
+#define AC97C_CORHR		0x40
+#define AC97C_COTHR		0x44
+#define AC97C_COSR		0x48
+#define AC97C_COMR		0x4c
+#define AC97C_SR		0x50
+#define AC97C_IER		0x54
+#define AC97C_IDR		0x58
+#define AC97C_IMR		0x5c
+#define AC97C_VERSION		0xfc
+
+#define AC97C_CATPR		PDC_TPR
+#define AC97C_CATCR		PDC_TCR
+#define AC97C_CATNPR		PDC_TNPR
+#define AC97C_CATNCR		PDC_TNCR
+#define AC97C_CARPR		PDC_RPR
+#define AC97C_CARCR		PDC_RCR
+#define AC97C_CARNPR		PDC_RNPR
+#define AC97C_CARNCR		PDC_RNCR
+#define AC97C_PTCR		PDC_PTCR
+
+#define AC97C_MR_ENA		(1 << 0)
+#define AC97C_MR_WRST		(1 << 1)
+#define AC97C_MR_VRA		(1 << 2)
+
+#define AC97C_CSR_TXRDY		(1 << 0)
+#define AC97C_CSR_UNRUN		(1 << 2)
+#define AC97C_CSR_RXRDY		(1 << 4)
+#define AC97C_CSR_ENDTX		(1 << 10)
+#define AC97C_CSR_ENDRX		(1 << 14)
+
+#define AC97C_CMR_SIZE_20	(0 << 16)
+#define AC97C_CMR_SIZE_18	(1 << 16)
+#define AC97C_CMR_SIZE_16	(2 << 16)
+#define AC97C_CMR_SIZE_10	(3 << 16)
+#define AC97C_CMR_CEM_LITTLE	(1 << 18)
+#define AC97C_CMR_CEM_BIG	(0 << 18)
+#define AC97C_CMR_CENA		(1 << 21)
+#define AC97C_CMR_DMAEN		(1 << 22)
+
+#define AC97C_SR_CAEVT		(1 << 3)
+
+#define AC97C_CH_ASSIGN(slot, channel)					\
+	(AC97C_CHANNEL_##channel << (3 * (AC97_SLOT_##slot - 3)))
+#define AC97C_CHANNEL_NONE	0x0
+#define AC97C_CHANNEL_A		0x1
+#define AC97C_CHANNEL_B		0x2
+
+#endif /* __SOUND_AVR32_AC97C_H */
-- 
1.5.6.3
