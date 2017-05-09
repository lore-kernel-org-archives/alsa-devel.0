From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/2] ALSA: atmel: Remove AVR32 bits from the
	driver
Date: Tue,  9 May 2017 19:18:36 +0300
Message-ID: <20170509161837.48301-2-andriy.shevchenko@linux.intel.com>
References: <20170509161837.48301-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 1F6A1266483
 for <alsa-devel@alsa-project.org>; Tue,  9 May 2017 18:19:12 +0200 (CEST)
In-Reply-To: <20170509161837.48301-1-andriy.shevchenko@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>, linux-kernel@vger.kernel.org, Haavard Skinnemoen <hskinnemoen@gmail.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, dmaengine@vger.kernel.org, Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

AVR32 is gone. Now it's time to clean up the driver by removing
leftovers that was used by AVR32 related code.

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 sound/atmel/Kconfig  |  13 +-
 sound/atmel/Makefile |   2 -
 sound/atmel/abdac.c  | 610 ---------------------------------------------------
 sound/atmel/ac97c.c  | 447 ++++++-------------------------------
 4 files changed, 74 insertions(+), 998 deletions(-)
 delete mode 100644 sound/atmel/abdac.c

diff --git a/sound/atmel/Kconfig b/sound/atmel/Kconfig
index 94de43a096f1..d789cbcb9106 100644
--- a/sound/atmel/Kconfig
+++ b/sound/atmel/Kconfig
@@ -1,18 +1,11 @@
-menu "Atmel devices (AVR32 and AT91)"
-	depends on AVR32 || ARCH_AT91
-
-config SND_ATMEL_ABDAC
-	tristate "Atmel Audio Bitstream DAC (ABDAC) driver"
-	select SND_PCM
-	depends on DW_DMAC && AVR32
-	help
-	  ALSA sound driver for the Atmel Audio Bitstream DAC (ABDAC).
+menu "Atmel devices (AT91)"
+	depends on ARCH_AT91
 
 config SND_ATMEL_AC97C
 	tristate "Atmel AC97 Controller (AC97C) driver"
 	select SND_PCM
 	select SND_AC97_CODEC
-	depends on (DW_DMAC && AVR32) || ARCH_AT91
+	depends on ARCH_AT91
 	help
 	  ALSA sound driver for the Atmel AC97 controller.
 
diff --git a/sound/atmel/Makefile b/sound/atmel/Makefile
index 219dcfac6086..d4009d1430ed 100644
--- a/sound/atmel/Makefile
+++ b/sound/atmel/Makefile
@@ -1,5 +1,3 @@
-snd-atmel-abdac-objs		:= abdac.o
 snd-atmel-ac97c-objs		:= ac97c.o
 
-obj-$(CONFIG_SND_ATMEL_ABDAC)	+= snd-atmel-abdac.o
 obj-$(CONFIG_SND_ATMEL_AC97C)	+= snd-atmel-ac97c.o
diff --git a/sound/atmel/abdac.c b/sound/atmel/abdac.c
deleted file mode 100644
index 558618802000..000000000000
--- a/sound/atmel/abdac.c
+++ /dev/null
@@ -1,610 +0,0 @@
-/*
- * Driver for the Atmel on-chip Audio Bitstream DAC (ABDAC)
- *
- * Copyright (C) 2006-2009 Atmel Corporation
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- */
-#include <linux/clk.h>
-#include <linux/bitmap.h>
-#include <linux/dmaengine.h>
-#include <linux/dma-mapping.h>
-#include <linux/init.h>
-#include <linux/interrupt.h>
-#include <linux/module.h>
-#include <linux/platform_device.h>
-#include <linux/types.h>
-#include <linux/io.h>
-
-#include <sound/core.h>
-#include <sound/initval.h>
-#include <sound/pcm.h>
-#include <sound/pcm_params.h>
-#include <sound/atmel-abdac.h>
-
-#include <linux/platform_data/dma-dw.h>
-#include <linux/dma/dw.h>
-
-/* DAC register offsets */
-#define DAC_DATA                                0x0000
-#define DAC_CTRL                                0x0008
-#define DAC_INT_MASK                            0x000c
-#define DAC_INT_EN                              0x0010
-#define DAC_INT_DIS                             0x0014
-#define DAC_INT_CLR                             0x0018
-#define DAC_INT_STATUS                          0x001c
-
-/* Bitfields in CTRL */
-#define DAC_SWAP_OFFSET                         30
-#define DAC_SWAP_SIZE                           1
-#define DAC_EN_OFFSET                           31
-#define DAC_EN_SIZE                             1
-
-/* Bitfields in INT_MASK/INT_EN/INT_DIS/INT_STATUS/INT_CLR */
-#define DAC_UNDERRUN_OFFSET                     28
-#define DAC_UNDERRUN_SIZE                       1
-#define DAC_TX_READY_OFFSET                     29
-#define DAC_TX_READY_SIZE                       1
-
-/* Bit manipulation macros */
-#define DAC_BIT(name)					\
-	(1 << DAC_##name##_OFFSET)
-#define DAC_BF(name, value)				\
-	(((value) & ((1 << DAC_##name##_SIZE) - 1))	\
-	 << DAC_##name##_OFFSET)
-#define DAC_BFEXT(name, value)				\
-	(((value) >> DAC_##name##_OFFSET)		\
-	 & ((1 << DAC_##name##_SIZE) - 1))
-#define DAC_BFINS(name, value, old)			\
-	(((old) & ~(((1 << DAC_##name##_SIZE) - 1)	\
-		    << DAC_##name##_OFFSET))		\
-	 | DAC_BF(name, value))
-
-/* Register access macros */
-#define dac_readl(port, reg)				\
-	__raw_readl((port)->regs + DAC_##reg)
-#define dac_writel(port, reg, value)			\
-	__raw_writel((value), (port)->regs + DAC_##reg)
-
-/*
- * ABDAC supports a maximum of 6 different rates from a generic clock. The
- * generic clock has a power of two divider, which gives 6 steps from 192 kHz
- * to 5112 Hz.
- */
-#define MAX_NUM_RATES	6
-/* ALSA seems to use rates between 192000 Hz and 5112 Hz. */
-#define RATE_MAX	192000
-#define RATE_MIN	5112
-
-enum {
-	DMA_READY = 0,
-};
-
-struct atmel_abdac_dma {
-	struct dma_chan		*chan;
-	struct dw_cyclic_desc	*cdesc;
-};
-
-struct atmel_abdac {
-	struct clk				*pclk;
-	struct clk				*sample_clk;
-	struct platform_device			*pdev;
-	struct atmel_abdac_dma			dma;
-
-	struct snd_pcm_hw_constraint_list	constraints_rates;
-	struct snd_pcm_substream		*substream;
-	struct snd_card				*card;
-	struct snd_pcm				*pcm;
-
-	void __iomem				*regs;
-	unsigned long				flags;
-	unsigned int				rates[MAX_NUM_RATES];
-	unsigned int				rates_num;
-	int					irq;
-};
-
-#define get_dac(card) ((struct atmel_abdac *)(card)->private_data)
-
-/* This function is called by the DMA driver. */
-static void atmel_abdac_dma_period_done(void *arg)
-{
-	struct atmel_abdac *dac = arg;
-	snd_pcm_period_elapsed(dac->substream);
-}
-
-static int atmel_abdac_prepare_dma(struct atmel_abdac *dac,
-		struct snd_pcm_substream *substream,
-		enum dma_data_direction direction)
-{
-	struct dma_chan			*chan = dac->dma.chan;
-	struct dw_cyclic_desc		*cdesc;
-	struct snd_pcm_runtime		*runtime = substream->runtime;
-	unsigned long			buffer_len, period_len;
-
-	/*
-	 * We don't do DMA on "complex" transfers, i.e. with
-	 * non-halfword-aligned buffers or lengths.
-	 */
-	if (runtime->dma_addr & 1 || runtime->buffer_size & 1) {
-		dev_dbg(&dac->pdev->dev, "too complex transfer\n");
-		return -EINVAL;
-	}
-
-	buffer_len = frames_to_bytes(runtime, runtime->buffer_size);
-	period_len = frames_to_bytes(runtime, runtime->period_size);
-
-	cdesc = dw_dma_cyclic_prep(chan, runtime->dma_addr, buffer_len,
-			period_len, DMA_MEM_TO_DEV);
-	if (IS_ERR(cdesc)) {
-		dev_dbg(&dac->pdev->dev, "could not prepare cyclic DMA\n");
-		return PTR_ERR(cdesc);
-	}
-
-	cdesc->period_callback = atmel_abdac_dma_period_done;
-	cdesc->period_callback_param = dac;
-
-	dac->dma.cdesc = cdesc;
-
-	set_bit(DMA_READY, &dac->flags);
-
-	return 0;
-}
-
-static struct snd_pcm_hardware atmel_abdac_hw = {
-	.info			= (SNDRV_PCM_INFO_MMAP
-				  | SNDRV_PCM_INFO_MMAP_VALID
-				  | SNDRV_PCM_INFO_INTERLEAVED
-				  | SNDRV_PCM_INFO_BLOCK_TRANSFER
-				  | SNDRV_PCM_INFO_RESUME
-				  | SNDRV_PCM_INFO_PAUSE),
-	.formats		= (SNDRV_PCM_FMTBIT_S16_BE),
-	.rates			= (SNDRV_PCM_RATE_KNOT),
-	.rate_min		= RATE_MIN,
-	.rate_max		= RATE_MAX,
-	.channels_min		= 2,
-	.channels_max		= 2,
-	.buffer_bytes_max	= 64 * 4096,
-	.period_bytes_min	= 4096,
-	.period_bytes_max	= 4096,
-	.periods_min		= 6,
-	.periods_max		= 64,
-};
-
-static int atmel_abdac_open(struct snd_pcm_substream *substream)
-{
-	struct atmel_abdac *dac = snd_pcm_substream_chip(substream);
-
-	dac->substream = substream;
-	atmel_abdac_hw.rate_max = dac->rates[dac->rates_num - 1];
-	atmel_abdac_hw.rate_min = dac->rates[0];
-	substream->runtime->hw = atmel_abdac_hw;
-
-	return snd_pcm_hw_constraint_list(substream->runtime, 0,
-			SNDRV_PCM_HW_PARAM_RATE, &dac->constraints_rates);
-}
-
-static int atmel_abdac_close(struct snd_pcm_substream *substream)
-{
-	struct atmel_abdac *dac = snd_pcm_substream_chip(substream);
-	dac->substream = NULL;
-	return 0;
-}
-
-static int atmel_abdac_hw_params(struct snd_pcm_substream *substream,
-		struct snd_pcm_hw_params *hw_params)
-{
-	struct atmel_abdac *dac = snd_pcm_substream_chip(substream);
-	int retval;
-
-	retval = snd_pcm_lib_malloc_pages(substream,
-			params_buffer_bytes(hw_params));
-	if (retval < 0)
-		return retval;
-	/* snd_pcm_lib_malloc_pages returns 1 if buffer is changed. */
-	if (retval == 1)
-		if (test_and_clear_bit(DMA_READY, &dac->flags))
-			dw_dma_cyclic_free(dac->dma.chan);
-
-	return retval;
-}
-
-static int atmel_abdac_hw_free(struct snd_pcm_substream *substream)
-{
-	struct atmel_abdac *dac = snd_pcm_substream_chip(substream);
-	if (test_and_clear_bit(DMA_READY, &dac->flags))
-		dw_dma_cyclic_free(dac->dma.chan);
-	return snd_pcm_lib_free_pages(substream);
-}
-
-static int atmel_abdac_prepare(struct snd_pcm_substream *substream)
-{
-	struct atmel_abdac *dac = snd_pcm_substream_chip(substream);
-	int retval;
-
-	retval = clk_set_rate(dac->sample_clk, 256 * substream->runtime->rate);
-	if (retval)
-		return retval;
-
-	if (!test_bit(DMA_READY, &dac->flags))
-		retval = atmel_abdac_prepare_dma(dac, substream, DMA_TO_DEVICE);
-
-	return retval;
-}
-
-static int atmel_abdac_trigger(struct snd_pcm_substream *substream, int cmd)
-{
-	struct atmel_abdac *dac = snd_pcm_substream_chip(substream);
-	int retval = 0;
-
-	switch (cmd) {
-	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE: /* fall through */
-	case SNDRV_PCM_TRIGGER_RESUME: /* fall through */
-	case SNDRV_PCM_TRIGGER_START:
-		clk_prepare_enable(dac->sample_clk);
-		retval = dw_dma_cyclic_start(dac->dma.chan);
-		if (retval)
-			goto out;
-		dac_writel(dac, CTRL, DAC_BIT(EN));
-		break;
-	case SNDRV_PCM_TRIGGER_PAUSE_PUSH: /* fall through */
-	case SNDRV_PCM_TRIGGER_SUSPEND: /* fall through */
-	case SNDRV_PCM_TRIGGER_STOP:
-		dw_dma_cyclic_stop(dac->dma.chan);
-		dac_writel(dac, DATA, 0);
-		dac_writel(dac, CTRL, 0);
-		clk_disable_unprepare(dac->sample_clk);
-		break;
-	default:
-		retval = -EINVAL;
-		break;
-	}
-out:
-	return retval;
-}
-
-static snd_pcm_uframes_t
-atmel_abdac_pointer(struct snd_pcm_substream *substream)
-{
-	struct atmel_abdac	*dac = snd_pcm_substream_chip(substream);
-	struct snd_pcm_runtime	*runtime = substream->runtime;
-	snd_pcm_uframes_t	frames;
-	unsigned long		bytes;
-
-	bytes = dw_dma_get_src_addr(dac->dma.chan);
-	bytes -= runtime->dma_addr;
-
-	frames = bytes_to_frames(runtime, bytes);
-	if (frames >= runtime->buffer_size)
-		frames -= runtime->buffer_size;
-
-	return frames;
-}
-
-static irqreturn_t abdac_interrupt(int irq, void *dev_id)
-{
-	struct atmel_abdac *dac = dev_id;
-	u32 status;
-
-	status = dac_readl(dac, INT_STATUS);
-	if (status & DAC_BIT(UNDERRUN)) {
-		dev_err(&dac->pdev->dev, "underrun detected\n");
-		dac_writel(dac, INT_CLR, DAC_BIT(UNDERRUN));
-	} else {
-		dev_err(&dac->pdev->dev, "spurious interrupt (status=0x%x)\n",
-			status);
-		dac_writel(dac, INT_CLR, status);
-	}
-
-	return IRQ_HANDLED;
-}
-
-static struct snd_pcm_ops atmel_abdac_ops = {
-	.open		= atmel_abdac_open,
-	.close		= atmel_abdac_close,
-	.ioctl		= snd_pcm_lib_ioctl,
-	.hw_params	= atmel_abdac_hw_params,
-	.hw_free	= atmel_abdac_hw_free,
-	.prepare	= atmel_abdac_prepare,
-	.trigger	= atmel_abdac_trigger,
-	.pointer	= atmel_abdac_pointer,
-};
-
-static int atmel_abdac_pcm_new(struct atmel_abdac *dac)
-{
-	struct snd_pcm_hardware hw = atmel_abdac_hw;
-	struct snd_pcm *pcm;
-	int retval;
-
-	retval = snd_pcm_new(dac->card, dac->card->shortname,
-			dac->pdev->id, 1, 0, &pcm);
-	if (retval)
-		return retval;
-
-	strcpy(pcm->name, dac->card->shortname);
-	pcm->private_data = dac;
-	pcm->info_flags = 0;
-	dac->pcm = pcm;
-
-	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &atmel_abdac_ops);
-
-	retval = snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
-			&dac->pdev->dev, hw.periods_min * hw.period_bytes_min,
-			hw.buffer_bytes_max);
-
-	return retval;
-}
-
-static bool filter(struct dma_chan *chan, void *slave)
-{
-	struct dw_dma_slave *dws = slave;
-
-	if (dws->dma_dev == chan->device->dev) {
-		chan->private = dws;
-		return true;
-	} else
-		return false;
-}
-
-static int set_sample_rates(struct atmel_abdac *dac)
-{
-	long new_rate = RATE_MAX;
-	int retval = -EINVAL;
-	int index = 0;
-
-	/* we start at 192 kHz and work our way down to 5112 Hz */
-	while (new_rate >= RATE_MIN && index < (MAX_NUM_RATES + 1)) {
-		new_rate = clk_round_rate(dac->sample_clk, 256 * new_rate);
-		if (new_rate <= 0)
-			break;
-		/* make sure we are below the ABDAC clock */
-		if (index < MAX_NUM_RATES &&
-		    new_rate <= clk_get_rate(dac->pclk)) {
-			dac->rates[index] = new_rate / 256;
-			index++;
-		}
-		/* divide by 256 and then by two to get next rate */
-		new_rate /= 256 * 2;
-	}
-
-	if (index) {
-		int i;
-
-		/* reverse array, smallest go first */
-		for (i = 0; i < (index / 2); i++) {
-			unsigned int tmp = dac->rates[index - 1 - i];
-			dac->rates[index - 1 - i] = dac->rates[i];
-			dac->rates[i] = tmp;
-		}
-
-		dac->constraints_rates.count = index;
-		dac->constraints_rates.list = dac->rates;
-		dac->constraints_rates.mask = 0;
-		dac->rates_num = index;
-
-		retval = 0;
-	}
-
-	return retval;
-}
-
-static int atmel_abdac_probe(struct platform_device *pdev)
-{
-	struct snd_card		*card;
-	struct atmel_abdac	*dac;
-	struct resource		*regs;
-	struct atmel_abdac_pdata	*pdata;
-	struct clk		*pclk;
-	struct clk		*sample_clk;
-	int			retval;
-	int			irq;
-
-	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!regs) {
-		dev_dbg(&pdev->dev, "no memory resource\n");
-		return -ENXIO;
-	}
-
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_dbg(&pdev->dev, "could not get IRQ number\n");
-		return irq;
-	}
-
-	pdata = pdev->dev.platform_data;
-	if (!pdata) {
-		dev_dbg(&pdev->dev, "no platform data\n");
-		return -ENXIO;
-	}
-
-	pclk = clk_get(&pdev->dev, "pclk");
-	if (IS_ERR(pclk)) {
-		dev_dbg(&pdev->dev, "no peripheral clock\n");
-		return PTR_ERR(pclk);
-	}
-	sample_clk = clk_get(&pdev->dev, "sample_clk");
-	if (IS_ERR(sample_clk)) {
-		dev_dbg(&pdev->dev, "no sample clock\n");
-		retval = PTR_ERR(sample_clk);
-		goto out_put_pclk;
-	}
-	clk_prepare_enable(pclk);
-
-	retval = snd_card_new(&pdev->dev, SNDRV_DEFAULT_IDX1,
-			      SNDRV_DEFAULT_STR1, THIS_MODULE,
-			      sizeof(struct atmel_abdac), &card);
-	if (retval) {
-		dev_dbg(&pdev->dev, "could not create sound card device\n");
-		goto out_put_sample_clk;
-	}
-
-	dac = get_dac(card);
-
-	dac->irq = irq;
-	dac->card = card;
-	dac->pclk = pclk;
-	dac->sample_clk = sample_clk;
-	dac->pdev = pdev;
-
-	retval = set_sample_rates(dac);
-	if (retval < 0) {
-		dev_dbg(&pdev->dev, "could not set supported rates\n");
-		goto out_free_card;
-	}
-
-	dac->regs = ioremap(regs->start, resource_size(regs));
-	if (!dac->regs) {
-		dev_dbg(&pdev->dev, "could not remap register memory\n");
-		retval = -ENOMEM;
-		goto out_free_card;
-	}
-
-	/* make sure the DAC is silent and disabled */
-	dac_writel(dac, DATA, 0);
-	dac_writel(dac, CTRL, 0);
-
-	retval = request_irq(irq, abdac_interrupt, 0, "abdac", dac);
-	if (retval) {
-		dev_dbg(&pdev->dev, "could not request irq\n");
-		goto out_unmap_regs;
-	}
-
-	if (pdata->dws.dma_dev) {
-		dma_cap_mask_t mask;
-
-		dma_cap_zero(mask);
-		dma_cap_set(DMA_SLAVE, mask);
-
-		dac->dma.chan = dma_request_channel(mask, filter, &pdata->dws);
-		if (dac->dma.chan) {
-			struct dma_slave_config dma_conf = {
-				.dst_addr = regs->start + DAC_DATA,
-				.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES,
-				.src_maxburst = 1,
-				.dst_maxburst = 1,
-				.direction = DMA_MEM_TO_DEV,
-				.device_fc = false,
-			};
-
-			dmaengine_slave_config(dac->dma.chan, &dma_conf);
-		}
-	}
-	if (!pdata->dws.dma_dev || !dac->dma.chan) {
-		dev_dbg(&pdev->dev, "DMA not available\n");
-		retval = -ENODEV;
-		goto out_unmap_regs;
-	}
-
-	strcpy(card->driver, "Atmel ABDAC");
-	strcpy(card->shortname, "Atmel ABDAC");
-	sprintf(card->longname, "Atmel Audio Bitstream DAC");
-
-	retval = atmel_abdac_pcm_new(dac);
-	if (retval) {
-		dev_dbg(&pdev->dev, "could not register ABDAC pcm device\n");
-		goto out_release_dma;
-	}
-
-	retval = snd_card_register(card);
-	if (retval) {
-		dev_dbg(&pdev->dev, "could not register sound card\n");
-		goto out_release_dma;
-	}
-
-	platform_set_drvdata(pdev, card);
-
-	dev_info(&pdev->dev, "Atmel ABDAC at 0x%p using %s\n",
-			dac->regs, dev_name(&dac->dma.chan->dev->device));
-
-	return retval;
-
-out_release_dma:
-	dma_release_channel(dac->dma.chan);
-	dac->dma.chan = NULL;
-out_unmap_regs:
-	iounmap(dac->regs);
-out_free_card:
-	snd_card_free(card);
-out_put_sample_clk:
-	clk_put(sample_clk);
-	clk_disable_unprepare(pclk);
-out_put_pclk:
-	clk_put(pclk);
-	return retval;
-}
-
-#ifdef CONFIG_PM_SLEEP
-static int atmel_abdac_suspend(struct device *pdev)
-{
-	struct snd_card *card = dev_get_drvdata(pdev);
-	struct atmel_abdac *dac = card->private_data;
-
-	dw_dma_cyclic_stop(dac->dma.chan);
-	clk_disable_unprepare(dac->sample_clk);
-	clk_disable_unprepare(dac->pclk);
-
-	return 0;
-}
-
-static int atmel_abdac_resume(struct device *pdev)
-{
-	struct snd_card *card = dev_get_drvdata(pdev);
-	struct atmel_abdac *dac = card->private_data;
-
-	clk_prepare_enable(dac->pclk);
-	clk_prepare_enable(dac->sample_clk);
-	if (test_bit(DMA_READY, &dac->flags))
-		dw_dma_cyclic_start(dac->dma.chan);
-
-	return 0;
-}
-
-static SIMPLE_DEV_PM_OPS(atmel_abdac_pm, atmel_abdac_suspend, atmel_abdac_resume);
-#define ATMEL_ABDAC_PM_OPS	&atmel_abdac_pm
-#else
-#define ATMEL_ABDAC_PM_OPS	NULL
-#endif
-
-static int atmel_abdac_remove(struct platform_device *pdev)
-{
-	struct snd_card *card = platform_get_drvdata(pdev);
-	struct atmel_abdac *dac = get_dac(card);
-
-	clk_put(dac->sample_clk);
-	clk_disable_unprepare(dac->pclk);
-	clk_put(dac->pclk);
-
-	dma_release_channel(dac->dma.chan);
-	dac->dma.chan = NULL;
-	iounmap(dac->regs);
-	free_irq(dac->irq, dac);
-	snd_card_free(card);
-
-	return 0;
-}
-
-static struct platform_driver atmel_abdac_driver = {
-	.remove		= atmel_abdac_remove,
-	.driver		= {
-		.name	= "atmel_abdac",
-		.pm	= ATMEL_ABDAC_PM_OPS,
-	},
-};
-
-static int __init atmel_abdac_init(void)
-{
-	return platform_driver_probe(&atmel_abdac_driver,
-			atmel_abdac_probe);
-}
-module_init(atmel_abdac_init);
-
-static void __exit atmel_abdac_exit(void)
-{
-	platform_driver_unregister(&atmel_abdac_driver);
-}
-module_exit(atmel_abdac_exit);
-
-MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("Driver for Atmel Audio Bitstream DAC (ABDAC)");
-MODULE_AUTHOR("Hans-Christian Egtvedt <egtvedt@samfundet.no>");
diff --git a/sound/atmel/ac97c.c b/sound/atmel/ac97c.c
index 6dad042630d8..65e6948e3995 100644
--- a/sound/atmel/ac97c.c
+++ b/sound/atmel/ac97c.c
@@ -11,8 +11,6 @@
 #include <linux/delay.h>
 #include <linux/bitmap.h>
 #include <linux/device.h>
-#include <linux/dmaengine.h>
-#include <linux/dma-mapping.h>
 #include <linux/atmel_pdc.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
@@ -34,36 +32,14 @@
 #include <sound/atmel-ac97c.h>
 #include <sound/memalloc.h>
 
-#include <linux/platform_data/dma-dw.h>
-#include <linux/dma/dw.h>
-
-#ifdef CONFIG_AVR32
-#include <mach/cpu.h>
-#else
-#define cpu_is_at32ap7000() 0
-#endif
-
 #include "ac97c.h"
 
-enum {
-	DMA_TX_READY = 0,
-	DMA_RX_READY,
-	DMA_TX_CHAN_PRESENT,
-	DMA_RX_CHAN_PRESENT,
-};
-
 /* Serialize access to opened variable */
 static DEFINE_MUTEX(opened_mutex);
 
-struct atmel_ac97c_dma {
-	struct dma_chan			*rx_chan;
-	struct dma_chan			*tx_chan;
-};
-
 struct atmel_ac97c {
 	struct clk			*pclk;
 	struct platform_device		*pdev;
-	struct atmel_ac97c_dma		dma;
 
 	struct snd_pcm_substream	*playback_substream;
 	struct snd_pcm_substream	*capture_substream;
@@ -74,7 +50,6 @@ struct atmel_ac97c {
 
 	u64				cur_format;
 	unsigned int			cur_rate;
-	unsigned long			flags;
 	int				playback_period, capture_period;
 	/* Serialize access to opened variable */
 	spinlock_t			lock;
@@ -91,65 +66,6 @@ struct atmel_ac97c {
 #define ac97c_readl(chip, reg)				\
 	__raw_readl((chip)->regs + AC97C_##reg)
 
-/* This function is called by the DMA driver. */
-static void atmel_ac97c_dma_playback_period_done(void *arg)
-{
-	struct atmel_ac97c *chip = arg;
-	snd_pcm_period_elapsed(chip->playback_substream);
-}
-
-static void atmel_ac97c_dma_capture_period_done(void *arg)
-{
-	struct atmel_ac97c *chip = arg;
-	snd_pcm_period_elapsed(chip->capture_substream);
-}
-
-static int atmel_ac97c_prepare_dma(struct atmel_ac97c *chip,
-		struct snd_pcm_substream *substream,
-		enum dma_transfer_direction direction)
-{
-	struct dma_chan			*chan;
-	struct dw_cyclic_desc		*cdesc;
-	struct snd_pcm_runtime		*runtime = substream->runtime;
-	unsigned long			buffer_len, period_len;
-
-	/*
-	 * We don't do DMA on "complex" transfers, i.e. with
-	 * non-halfword-aligned buffers or lengths.
-	 */
-	if (runtime->dma_addr & 1 || runtime->buffer_size & 1) {
-		dev_dbg(&chip->pdev->dev, "too complex transfer\n");
-		return -EINVAL;
-	}
-
-	if (direction == DMA_MEM_TO_DEV)
-		chan = chip->dma.tx_chan;
-	else
-		chan = chip->dma.rx_chan;
-
-	buffer_len = frames_to_bytes(runtime, runtime->buffer_size);
-	period_len = frames_to_bytes(runtime, runtime->period_size);
-
-	cdesc = dw_dma_cyclic_prep(chan, runtime->dma_addr, buffer_len,
-			period_len, direction);
-	if (IS_ERR(cdesc)) {
-		dev_dbg(&chip->pdev->dev, "could not prepare cyclic DMA\n");
-		return PTR_ERR(cdesc);
-	}
-
-	if (direction == DMA_MEM_TO_DEV) {
-		cdesc->period_callback = atmel_ac97c_dma_playback_period_done;
-		set_bit(DMA_TX_READY, &chip->flags);
-	} else {
-		cdesc->period_callback = atmel_ac97c_dma_capture_period_done;
-		set_bit(DMA_RX_READY, &chip->flags);
-	}
-
-	cdesc->period_callback_param = chip;
-
-	return 0;
-}
-
 static struct snd_pcm_hardware atmel_ac97c_hw = {
 	.info			= (SNDRV_PCM_INFO_MMAP
 				  | SNDRV_PCM_INFO_MMAP_VALID
@@ -254,13 +170,7 @@ static int atmel_ac97c_playback_hw_params(struct snd_pcm_substream *substream,
 					params_buffer_bytes(hw_params));
 	if (retval < 0)
 		return retval;
-	/* snd_pcm_lib_malloc_pages returns 1 if buffer is changed. */
-	if (cpu_is_at32ap7000()) {
-		/* snd_pcm_lib_malloc_pages returns 1 if buffer is changed. */
-		if (retval == 1)
-			if (test_and_clear_bit(DMA_TX_READY, &chip->flags))
-				dw_dma_cyclic_free(chip->dma.tx_chan);
-	}
+
 	/* Set restrictions to params. */
 	mutex_lock(&opened_mutex);
 	chip->cur_rate = params_rate(hw_params);
@@ -280,10 +190,6 @@ static int atmel_ac97c_capture_hw_params(struct snd_pcm_substream *substream,
 					params_buffer_bytes(hw_params));
 	if (retval < 0)
 		return retval;
-	/* snd_pcm_lib_malloc_pages returns 1 if buffer is changed. */
-	if (cpu_is_at32ap7000() && retval == 1)
-		if (test_and_clear_bit(DMA_RX_READY, &chip->flags))
-			dw_dma_cyclic_free(chip->dma.rx_chan);
 
 	/* Set restrictions to params. */
 	mutex_lock(&opened_mutex);
@@ -294,26 +200,6 @@ static int atmel_ac97c_capture_hw_params(struct snd_pcm_substream *substream,
 	return retval;
 }
 
-static int atmel_ac97c_playback_hw_free(struct snd_pcm_substream *substream)
-{
-	struct atmel_ac97c *chip = snd_pcm_substream_chip(substream);
-	if (cpu_is_at32ap7000()) {
-		if (test_and_clear_bit(DMA_TX_READY, &chip->flags))
-			dw_dma_cyclic_free(chip->dma.tx_chan);
-	}
-	return snd_pcm_lib_free_pages(substream);
-}
-
-static int atmel_ac97c_capture_hw_free(struct snd_pcm_substream *substream)
-{
-	struct atmel_ac97c *chip = snd_pcm_substream_chip(substream);
-	if (cpu_is_at32ap7000()) {
-		if (test_and_clear_bit(DMA_RX_READY, &chip->flags))
-			dw_dma_cyclic_free(chip->dma.rx_chan);
-	}
-	return snd_pcm_lib_free_pages(substream);
-}
-
 static int atmel_ac97c_playback_prepare(struct snd_pcm_substream *substream)
 {
 	struct atmel_ac97c *chip = snd_pcm_substream_chip(substream);
@@ -349,8 +235,6 @@ static int atmel_ac97c_playback_prepare(struct snd_pcm_substream *substream)
 
 	switch (runtime->format) {
 	case SNDRV_PCM_FORMAT_S16_LE:
-		if (cpu_is_at32ap7000())
-			word |= AC97C_CMR_CEM_LITTLE;
 		break;
 	case SNDRV_PCM_FORMAT_S16_BE: /* fall through */
 		word &= ~(AC97C_CMR_CEM_LITTLE);
@@ -389,18 +273,11 @@ static int atmel_ac97c_playback_prepare(struct snd_pcm_substream *substream)
 		dev_dbg(&chip->pdev->dev, "could not set rate %d Hz\n",
 				runtime->rate);
 
-	if (cpu_is_at32ap7000()) {
-		if (!test_bit(DMA_TX_READY, &chip->flags))
-			retval = atmel_ac97c_prepare_dma(chip, substream,
-					DMA_MEM_TO_DEV);
-	} else {
-		/* Initialize and start the PDC */
-		writel(runtime->dma_addr, chip->regs + ATMEL_PDC_TPR);
-		writel(block_size / 2, chip->regs + ATMEL_PDC_TCR);
-		writel(runtime->dma_addr + block_size,
-				chip->regs + ATMEL_PDC_TNPR);
-		writel(block_size / 2, chip->regs + ATMEL_PDC_TNCR);
-	}
+	/* Initialize and start the PDC */
+	writel(runtime->dma_addr, chip->regs + ATMEL_PDC_TPR);
+	writel(block_size / 2, chip->regs + ATMEL_PDC_TCR);
+	writel(runtime->dma_addr + block_size, chip->regs + ATMEL_PDC_TNPR);
+	writel(block_size / 2, chip->regs + ATMEL_PDC_TNCR);
 
 	return retval;
 }
@@ -440,8 +317,6 @@ static int atmel_ac97c_capture_prepare(struct snd_pcm_substream *substream)
 
 	switch (runtime->format) {
 	case SNDRV_PCM_FORMAT_S16_LE:
-		if (cpu_is_at32ap7000())
-			word |= AC97C_CMR_CEM_LITTLE;
 		break;
 	case SNDRV_PCM_FORMAT_S16_BE: /* fall through */
 		word &= ~(AC97C_CMR_CEM_LITTLE);
@@ -480,18 +355,11 @@ static int atmel_ac97c_capture_prepare(struct snd_pcm_substream *substream)
 		dev_dbg(&chip->pdev->dev, "could not set rate %d Hz\n",
 				runtime->rate);
 
-	if (cpu_is_at32ap7000()) {
-		if (!test_bit(DMA_RX_READY, &chip->flags))
-			retval = atmel_ac97c_prepare_dma(chip, substream,
-					DMA_DEV_TO_MEM);
-	} else {
-		/* Initialize and start the PDC */
-		writel(runtime->dma_addr, chip->regs + ATMEL_PDC_RPR);
-		writel(block_size / 2, chip->regs + ATMEL_PDC_RCR);
-		writel(runtime->dma_addr + block_size,
-				chip->regs + ATMEL_PDC_RNPR);
-		writel(block_size / 2, chip->regs + ATMEL_PDC_RNCR);
-	}
+	/* Initialize and start the PDC */
+	writel(runtime->dma_addr, chip->regs + ATMEL_PDC_RPR);
+	writel(block_size / 2, chip->regs + ATMEL_PDC_RCR);
+	writel(runtime->dma_addr + block_size, chip->regs + ATMEL_PDC_RNPR);
+	writel(block_size / 2, chip->regs + ATMEL_PDC_RNCR);
 
 	return retval;
 }
@@ -501,7 +369,6 @@ atmel_ac97c_playback_trigger(struct snd_pcm_substream *substream, int cmd)
 {
 	struct atmel_ac97c *chip = snd_pcm_substream_chip(substream);
 	unsigned long camr, ptcr = 0;
-	int retval = 0;
 
 	camr = ac97c_readl(chip, CAMR);
 
@@ -509,35 +376,23 @@ atmel_ac97c_playback_trigger(struct snd_pcm_substream *substream, int cmd)
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE: /* fall through */
 	case SNDRV_PCM_TRIGGER_RESUME: /* fall through */
 	case SNDRV_PCM_TRIGGER_START:
-		if (cpu_is_at32ap7000()) {
-			retval = dw_dma_cyclic_start(chip->dma.tx_chan);
-			if (retval)
-				goto out;
-		} else {
-			ptcr = ATMEL_PDC_TXTEN;
-		}
+		ptcr = ATMEL_PDC_TXTEN;
 		camr |= AC97C_CMR_CENA | AC97C_CSR_ENDTX;
 		break;
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH: /* fall through */
 	case SNDRV_PCM_TRIGGER_SUSPEND: /* fall through */
 	case SNDRV_PCM_TRIGGER_STOP:
-		if (cpu_is_at32ap7000())
-			dw_dma_cyclic_stop(chip->dma.tx_chan);
-		else
-			ptcr |= ATMEL_PDC_TXTDIS;
+		ptcr |= ATMEL_PDC_TXTDIS;
 		if (chip->opened <= 1)
 			camr &= ~AC97C_CMR_CENA;
 		break;
 	default:
-		retval = -EINVAL;
-		goto out;
+		return -EINVAL;
 	}
 
 	ac97c_writel(chip, CAMR, camr);
-	if (!cpu_is_at32ap7000())
-		writel(ptcr, chip->regs + ATMEL_PDC_PTCR);
-out:
-	return retval;
+	writel(ptcr, chip->regs + ATMEL_PDC_PTCR);
+	return 0;
 }
 
 static int
@@ -545,7 +400,6 @@ atmel_ac97c_capture_trigger(struct snd_pcm_substream *substream, int cmd)
 {
 	struct atmel_ac97c *chip = snd_pcm_substream_chip(substream);
 	unsigned long camr, ptcr = 0;
-	int retval = 0;
 
 	camr = ac97c_readl(chip, CAMR);
 	ptcr = readl(chip->regs + ATMEL_PDC_PTSR);
@@ -554,35 +408,23 @@ atmel_ac97c_capture_trigger(struct snd_pcm_substream *substream, int cmd)
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE: /* fall through */
 	case SNDRV_PCM_TRIGGER_RESUME: /* fall through */
 	case SNDRV_PCM_TRIGGER_START:
-		if (cpu_is_at32ap7000()) {
-			retval = dw_dma_cyclic_start(chip->dma.rx_chan);
-			if (retval)
-				goto out;
-		} else {
-			ptcr = ATMEL_PDC_RXTEN;
-		}
+		ptcr = ATMEL_PDC_RXTEN;
 		camr |= AC97C_CMR_CENA | AC97C_CSR_ENDRX;
 		break;
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH: /* fall through */
 	case SNDRV_PCM_TRIGGER_SUSPEND: /* fall through */
 	case SNDRV_PCM_TRIGGER_STOP:
-		if (cpu_is_at32ap7000())
-			dw_dma_cyclic_stop(chip->dma.rx_chan);
-		else
-			ptcr |= (ATMEL_PDC_RXTDIS);
+		ptcr |= ATMEL_PDC_RXTDIS;
 		if (chip->opened <= 1)
 			camr &= ~AC97C_CMR_CENA;
 		break;
 	default:
-		retval = -EINVAL;
-		break;
+		return -EINVAL;
 	}
 
 	ac97c_writel(chip, CAMR, camr);
-	if (!cpu_is_at32ap7000())
-		writel(ptcr, chip->regs + ATMEL_PDC_PTCR);
-out:
-	return retval;
+	writel(ptcr, chip->regs + ATMEL_PDC_PTCR);
+	return 0;
 }
 
 static snd_pcm_uframes_t
@@ -593,10 +435,7 @@ atmel_ac97c_playback_pointer(struct snd_pcm_substream *substream)
 	snd_pcm_uframes_t	frames;
 	unsigned long		bytes;
 
-	if (cpu_is_at32ap7000())
-		bytes = dw_dma_get_src_addr(chip->dma.tx_chan);
-	else
-		bytes = readl(chip->regs + ATMEL_PDC_TPR);
+	bytes = readl(chip->regs + ATMEL_PDC_TPR);
 	bytes -= runtime->dma_addr;
 
 	frames = bytes_to_frames(runtime, bytes);
@@ -613,10 +452,7 @@ atmel_ac97c_capture_pointer(struct snd_pcm_substream *substream)
 	snd_pcm_uframes_t	frames;
 	unsigned long		bytes;
 
-	if (cpu_is_at32ap7000())
-		bytes = dw_dma_get_dst_addr(chip->dma.rx_chan);
-	else
-		bytes = readl(chip->regs + ATMEL_PDC_RPR);
+	bytes = readl(chip->regs + ATMEL_PDC_RPR);
 	bytes -= runtime->dma_addr;
 
 	frames = bytes_to_frames(runtime, bytes);
@@ -630,7 +466,7 @@ static struct snd_pcm_ops atmel_ac97_playback_ops = {
 	.close		= atmel_ac97c_playback_close,
 	.ioctl		= snd_pcm_lib_ioctl,
 	.hw_params	= atmel_ac97c_playback_hw_params,
-	.hw_free	= atmel_ac97c_playback_hw_free,
+	.hw_free	= snd_pcm_lib_free_pages,
 	.prepare	= atmel_ac97c_playback_prepare,
 	.trigger	= atmel_ac97c_playback_trigger,
 	.pointer	= atmel_ac97c_playback_pointer,
@@ -641,7 +477,7 @@ static struct snd_pcm_ops atmel_ac97_capture_ops = {
 	.close		= atmel_ac97c_capture_close,
 	.ioctl		= snd_pcm_lib_ioctl,
 	.hw_params	= atmel_ac97c_capture_hw_params,
-	.hw_free	= atmel_ac97c_capture_hw_free,
+	.hw_free	= snd_pcm_lib_free_pages,
 	.prepare	= atmel_ac97c_capture_prepare,
 	.trigger	= atmel_ac97c_capture_trigger,
 	.pointer	= atmel_ac97c_capture_pointer,
@@ -666,49 +502,40 @@ static irqreturn_t atmel_ac97c_interrupt(int irq, void *dev)
 				casr & AC97C_CSR_TXEMPTY ? " TXEMPTY" : "",
 				casr & AC97C_CSR_TXRDY   ? " TXRDY"   : "",
 				!casr                    ? " NONE"    : "");
-		if (!cpu_is_at32ap7000()) {
-			if ((casr & camr) & AC97C_CSR_ENDTX) {
-				runtime = chip->playback_substream->runtime;
-				block_size = frames_to_bytes(runtime,
-						runtime->period_size);
-				chip->playback_period++;
-
-				if (chip->playback_period == runtime->periods)
-					chip->playback_period = 0;
-				next_period = chip->playback_period + 1;
-				if (next_period == runtime->periods)
-					next_period = 0;
-
-				offset = block_size * next_period;
-
-				writel(runtime->dma_addr + offset,
-						chip->regs + ATMEL_PDC_TNPR);
-				writel(block_size / 2,
-						chip->regs + ATMEL_PDC_TNCR);
-
-				snd_pcm_period_elapsed(
-						chip->playback_substream);
-			}
-			if ((casr & camr) & AC97C_CSR_ENDRX) {
-				runtime = chip->capture_substream->runtime;
-				block_size = frames_to_bytes(runtime,
-						runtime->period_size);
-				chip->capture_period++;
-
-				if (chip->capture_period == runtime->periods)
-					chip->capture_period = 0;
-				next_period = chip->capture_period + 1;
-				if (next_period == runtime->periods)
-					next_period = 0;
-
-				offset = block_size * next_period;
-
-				writel(runtime->dma_addr + offset,
-						chip->regs + ATMEL_PDC_RNPR);
-				writel(block_size / 2,
-						chip->regs + ATMEL_PDC_RNCR);
-				snd_pcm_period_elapsed(chip->capture_substream);
-			}
+		if ((casr & camr) & AC97C_CSR_ENDTX) {
+			runtime = chip->playback_substream->runtime;
+			block_size = frames_to_bytes(runtime, runtime->period_size);
+			chip->playback_period++;
+
+			if (chip->playback_period == runtime->periods)
+				chip->playback_period = 0;
+			next_period = chip->playback_period + 1;
+			if (next_period == runtime->periods)
+				next_period = 0;
+
+			offset = block_size * next_period;
+
+			writel(runtime->dma_addr + offset, chip->regs + ATMEL_PDC_TNPR);
+			writel(block_size / 2, chip->regs + ATMEL_PDC_TNCR);
+
+			snd_pcm_period_elapsed(chip->playback_substream);
+		}
+		if ((casr & camr) & AC97C_CSR_ENDRX) {
+			runtime = chip->capture_substream->runtime;
+			block_size = frames_to_bytes(runtime, runtime->period_size);
+			chip->capture_period++;
+
+			if (chip->capture_period == runtime->periods)
+				chip->capture_period = 0;
+			next_period = chip->capture_period + 1;
+			if (next_period == runtime->periods)
+				next_period = 0;
+
+			offset = block_size * next_period;
+
+			writel(runtime->dma_addr + offset, chip->regs + ATMEL_PDC_RNPR);
+			writel(block_size / 2, chip->regs + ATMEL_PDC_RNCR);
+			snd_pcm_period_elapsed(chip->capture_substream);
 		}
 		retval = IRQ_HANDLED;
 	}
@@ -763,29 +590,20 @@ static int atmel_ac97c_pcm_new(struct atmel_ac97c *chip)
 {
 	struct snd_pcm		*pcm;
 	struct snd_pcm_hardware	hw = atmel_ac97c_hw;
-	int			capture, playback, retval, err;
+	int			retval;
 
-	capture = test_bit(DMA_RX_CHAN_PRESENT, &chip->flags);
-	playback = test_bit(DMA_TX_CHAN_PRESENT, &chip->flags);
+	retval = snd_ac97_pcm_assign(chip->ac97_bus,
+				     ARRAY_SIZE(at91_ac97_pcm_defs),
+				     at91_ac97_pcm_defs);
+	if (retval)
+		return retval;
 
-	if (!cpu_is_at32ap7000()) {
-		err = snd_ac97_pcm_assign(chip->ac97_bus,
-				ARRAY_SIZE(at91_ac97_pcm_defs),
-				at91_ac97_pcm_defs);
-		if (err)
-			return err;
-	}
-	retval = snd_pcm_new(chip->card, chip->card->shortname,
-			0, playback, capture, &pcm);
+	retval = snd_pcm_new(chip->card, chip->card->shortname, 0, 1, 1, &pcm);
 	if (retval)
 		return retval;
 
-	if (capture)
-		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE,
-				&atmel_ac97_capture_ops);
-	if (playback)
-		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK,
-				&atmel_ac97_playback_ops);
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &atmel_ac97_capture_ops);
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &atmel_ac97_playback_ops);
 
 	retval = snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
 			&chip->pdev->dev, hw.periods_min * hw.period_bytes_min,
@@ -875,17 +693,6 @@ static unsigned short atmel_ac97c_read(struct snd_ac97 *ac97,
 	return 0xffff;
 }
 
-static bool filter(struct dma_chan *chan, void *slave)
-{
-	struct dw_dma_slave *dws = slave;
-
-	if (dws->dma_dev == chan->device->dev) {
-		chan->private = dws;
-		return true;
-	} else
-		return false;
-}
-
 static void atmel_ac97c_reset(struct atmel_ac97c *chip)
 {
 	ac97c_writel(chip, MR,   0);
@@ -971,12 +778,7 @@ static int atmel_ac97c_probe(struct platform_device *pdev)
 		return -ENXIO;
 	}
 
-	if (cpu_is_at32ap7000()) {
-		pclk = clk_get(&pdev->dev, "pclk");
-	} else {
-		pclk = clk_get(&pdev->dev, "ac97_clk");
-	}
-
+	pclk = clk_get(&pdev->dev, "ac97_clk");
 	if (IS_ERR(pclk)) {
 		dev_dbg(&pdev->dev, "no peripheral clock\n");
 		return PTR_ERR(pclk);
@@ -1047,88 +849,16 @@ static int atmel_ac97c_probe(struct platform_device *pdev)
 		goto err_ac97_bus;
 	}
 
-	if (cpu_is_at32ap7000()) {
-		if (pdata->rx_dws.dma_dev) {
-			dma_cap_mask_t mask;
-
-			dma_cap_zero(mask);
-			dma_cap_set(DMA_SLAVE, mask);
-
-			chip->dma.rx_chan = dma_request_channel(mask, filter,
-								&pdata->rx_dws);
-			if (chip->dma.rx_chan) {
-				struct dma_slave_config dma_conf = {
-					.src_addr = regs->start + AC97C_CARHR +
-						2,
-					.src_addr_width =
-						DMA_SLAVE_BUSWIDTH_2_BYTES,
-					.src_maxburst = 1,
-					.dst_maxburst = 1,
-					.direction = DMA_DEV_TO_MEM,
-					.device_fc = false,
-				};
-
-				dmaengine_slave_config(chip->dma.rx_chan,
-						&dma_conf);
-			}
-
-			dev_info(&chip->pdev->dev, "using %s for DMA RX\n",
-				dev_name(&chip->dma.rx_chan->dev->device));
-			set_bit(DMA_RX_CHAN_PRESENT, &chip->flags);
-		}
-
-		if (pdata->tx_dws.dma_dev) {
-			dma_cap_mask_t mask;
-
-			dma_cap_zero(mask);
-			dma_cap_set(DMA_SLAVE, mask);
-
-			chip->dma.tx_chan = dma_request_channel(mask, filter,
-								&pdata->tx_dws);
-			if (chip->dma.tx_chan) {
-				struct dma_slave_config dma_conf = {
-					.dst_addr = regs->start + AC97C_CATHR +
-						2,
-					.dst_addr_width =
-						DMA_SLAVE_BUSWIDTH_2_BYTES,
-					.src_maxburst = 1,
-					.dst_maxburst = 1,
-					.direction = DMA_MEM_TO_DEV,
-					.device_fc = false,
-				};
-
-				dmaengine_slave_config(chip->dma.tx_chan,
-						&dma_conf);
-			}
-
-			dev_info(&chip->pdev->dev, "using %s for DMA TX\n",
-				dev_name(&chip->dma.tx_chan->dev->device));
-			set_bit(DMA_TX_CHAN_PRESENT, &chip->flags);
-		}
-
-		if (!test_bit(DMA_RX_CHAN_PRESENT, &chip->flags) &&
-				!test_bit(DMA_TX_CHAN_PRESENT, &chip->flags)) {
-			dev_dbg(&pdev->dev, "DMA not available\n");
-			retval = -ENODEV;
-			goto err_dma;
-		}
-	} else {
-		/* Just pretend that we have DMA channel(for at91 i is actually
-		 * the PDC) */
-		set_bit(DMA_RX_CHAN_PRESENT, &chip->flags);
-		set_bit(DMA_TX_CHAN_PRESENT, &chip->flags);
-	}
-
 	retval = atmel_ac97c_pcm_new(chip);
 	if (retval) {
 		dev_dbg(&pdev->dev, "could not register ac97 pcm device\n");
-		goto err_dma;
+		goto err_ac97_bus;
 	}
 
 	retval = snd_card_register(card);
 	if (retval) {
 		dev_dbg(&pdev->dev, "could not register sound card\n");
-		goto err_dma;
+		goto err_ac97_bus;
 	}
 
 	platform_set_drvdata(pdev, card);
@@ -1138,17 +868,6 @@ static int atmel_ac97c_probe(struct platform_device *pdev)
 
 	return 0;
 
-err_dma:
-	if (cpu_is_at32ap7000()) {
-		if (test_bit(DMA_RX_CHAN_PRESENT, &chip->flags))
-			dma_release_channel(chip->dma.rx_chan);
-		if (test_bit(DMA_TX_CHAN_PRESENT, &chip->flags))
-			dma_release_channel(chip->dma.tx_chan);
-		clear_bit(DMA_RX_CHAN_PRESENT, &chip->flags);
-		clear_bit(DMA_TX_CHAN_PRESENT, &chip->flags);
-		chip->dma.rx_chan = NULL;
-		chip->dma.tx_chan = NULL;
-	}
 err_ac97_bus:
 	if (gpio_is_valid(chip->reset_pin))
 		gpio_free(chip->reset_pin);
@@ -1170,14 +889,7 @@ static int atmel_ac97c_suspend(struct device *pdev)
 	struct snd_card *card = dev_get_drvdata(pdev);
 	struct atmel_ac97c *chip = card->private_data;
 
-	if (cpu_is_at32ap7000()) {
-		if (test_bit(DMA_RX_READY, &chip->flags))
-			dw_dma_cyclic_stop(chip->dma.rx_chan);
-		if (test_bit(DMA_TX_READY, &chip->flags))
-			dw_dma_cyclic_stop(chip->dma.tx_chan);
-	}
 	clk_disable_unprepare(chip->pclk);
-
 	return 0;
 }
 
@@ -1187,12 +899,6 @@ static int atmel_ac97c_resume(struct device *pdev)
 	struct atmel_ac97c *chip = card->private_data;
 
 	clk_prepare_enable(chip->pclk);
-	if (cpu_is_at32ap7000()) {
-		if (test_bit(DMA_RX_READY, &chip->flags))
-			dw_dma_cyclic_start(chip->dma.rx_chan);
-		if (test_bit(DMA_TX_READY, &chip->flags))
-			dw_dma_cyclic_start(chip->dma.tx_chan);
-	}
 	return 0;
 }
 
@@ -1219,17 +925,6 @@ static int atmel_ac97c_remove(struct platform_device *pdev)
 	iounmap(chip->regs);
 	free_irq(chip->irq, chip);
 
-	if (cpu_is_at32ap7000()) {
-		if (test_bit(DMA_RX_CHAN_PRESENT, &chip->flags))
-			dma_release_channel(chip->dma.rx_chan);
-		if (test_bit(DMA_TX_CHAN_PRESENT, &chip->flags))
-			dma_release_channel(chip->dma.tx_chan);
-		clear_bit(DMA_RX_CHAN_PRESENT, &chip->flags);
-		clear_bit(DMA_TX_CHAN_PRESENT, &chip->flags);
-		chip->dma.rx_chan = NULL;
-		chip->dma.tx_chan = NULL;
-	}
-
 	snd_card_free(card);
 
 	return 0;
-- 
2.11.0
