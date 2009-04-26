From: Jon Smirl <jonsmirl@gmail.com>
Subject: Driver code with mpc5200 pointer problem.
Date: Sun, 26 Apr 2009 11:25:55 -0400
Message-ID: <9e4733910904260825o68d5b9dndbf92cdbc4a4e48e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f103.google.com (mail-qy0-f103.google.com
	[209.85.221.103])
	by alsa0.perex.cz (Postfix) with ESMTP id F3A9924392
	for <alsa-devel@alsa-project.org>;
	Sun, 26 Apr 2009 17:25:56 +0200 (CEST)
Received: by qyk1 with SMTP id 1so3704253qyk.16
	for <alsa-devel@alsa-project.org>; Sun, 26 Apr 2009 08:25:56 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Here's the code computing the mpc5200 dma pointer. Could you please
take a look at it and let me know what it is doing wrong.

/*
 * Freescale MPC5200 Audio DMA
 * ALSA SoC Platform driver
 *
 * Copyright (C) 2008 Secret Lab Technologies Ltd.
 */

#define DEBUG

#include <linux/init.h>
#include <linux/module.h>
#include <linux/interrupt.h>
#include <linux/device.h>
#include <linux/delay.h>
#include <linux/of_device.h>
#include <linux/of_platform.h>
#include <linux/dma-mapping.h>

#include <sound/core.h>
#include <sound/pcm.h>
#include <sound/pcm_params.h>
#include <sound/initval.h>
#include <sound/soc.h>
#include <sound/soc-of-simple.h>

#include <sysdev/bestcomm/bestcomm.h>
#include <sysdev/bestcomm/gen_bd.h>
#include <asm/time.h>
#include <asm/mpc52xx.h>
#include <asm/mpc52xx_psc.h>

#include "mpc5200_dma.h"

MODULE_AUTHOR("Grant Likely <grant.likely@secretlab.ca>");
MODULE_DESCRIPTION("Freescale MPC5200 PSC in DMA mode ASoC Driver");
MODULE_LICENSE("GPL");

/*
 * Interrupt handlers
 */
static irqreturn_t psc_dma_status_irq(int irq, void *_psc_dma)
{
	struct psc_dma *psc_dma = _psc_dma;
	struct mpc52xx_psc __iomem *regs = psc_dma->psc_regs;
	u16 isr;

	isr = in_be16(&regs->mpc52xx_psc_isr);

	/* Playback underrun error */
	if (psc_dma->playback.active && (isr & MPC52xx_PSC_IMR_TXEMP))
		psc_dma->stats.underrun_count++;

	/* Capture overrun error */
	if (psc_dma->capture.active && (isr & MPC52xx_PSC_IMR_ORERR))
		psc_dma->stats.overrun_count++;

	out_8(&regs->command, 4 << 4);	/* reset the error status */

	return IRQ_HANDLED;
}

/**
 * psc_dma_bcom_enqueue_next_buffer - Enqueue another audio buffer
 * @s: pointer to stream private data structure
 *
 * Enqueues another audio period buffer into the bestcomm queue.
 *
 * Note: The routine must only be called when there is space available in
 * the queue.  Otherwise the enqueue will fail and the audio ring buffer
 * will get out of sync
 */
static void psc_dma_bcom_enqueue_next_buffer(struct psc_dma_stream *s)
{
	struct bcom_bd *bd;

	/* Prepare and enqueue the next buffer descriptor */
	bd = bcom_prepare_next_buffer(s->bcom_task);
	bd->status = s->period_bytes;
	bd->data[0] = s->period_next_pt;
	bcom_submit_next_buffer(s->bcom_task, NULL);

	/* Update for next period */
	s->period_next_pt += s->period_bytes;
	if (s->period_next_pt >= s->period_end)
		s->period_next_pt = s->period_start;
}

/* Bestcomm DMA irq handler */
static irqreturn_t psc_dma_bcom_irq(int irq, void *_psc_dma_stream)
{
	struct psc_dma_stream *s = _psc_dma_stream;

	/* For each finished period, dequeue the completed period buffer
	 * and enqueue a new one in it's place. */
	while (bcom_buffer_done(s->bcom_task)) {
		bcom_retrieve_buffer(s->bcom_task, NULL, NULL);
		s->period_current_pt += s->period_bytes;
		if (s->period_current_pt >= s->period_end)
			s->period_current_pt = s->period_start;
		psc_dma_bcom_enqueue_next_buffer(s);
		bcom_enable(s->bcom_task);
	}

	/* If the stream is active, then also inform the PCM middle layer
	 * of the period finished event. */
	if (s->active) {
		s->jiffies = jiffies;
		snd_pcm_period_elapsed(s->stream);
	}

	return IRQ_HANDLED;
}

/**
 * psc_dma_startup: create a new substream
 *
 * This is the first function called when a stream is opened.
 *
 * If this is the first stream open, then grab the IRQ and program most of
 * the PSC registers.
 */
int mpc5200_dma_startup(struct snd_pcm_substream *substream,
			   struct snd_soc_dai *dai)
{
	struct snd_soc_pcm_runtime *rtd = substream->private_data;
	struct psc_dma *psc_dma = rtd->dai->cpu_dai->private_data;
	int rc;

	dev_dbg(psc_dma->dev, "psc_dma_startup(substream=%p)\n", substream);

	if (!psc_dma->playback.active &&
	    !psc_dma->capture.active) {
		/* Setup the IRQs */
		rc = request_irq(psc_dma->irq, &psc_dma_status_irq, IRQF_SHARED,
				 "psc-dma-status", psc_dma);
		rc |= request_irq(psc_dma->capture.irq,
				  &psc_dma_bcom_irq, IRQF_SHARED,
				  "psc-dma-capture", &psc_dma->capture);
		rc |= request_irq(psc_dma->playback.irq,
				  &psc_dma_bcom_irq, IRQF_SHARED,
				  "psc-dma-playback", &psc_dma->playback);
		if (rc) {
			free_irq(psc_dma->irq, psc_dma);
			free_irq(psc_dma->capture.irq,
				 &psc_dma->capture);
			free_irq(psc_dma->playback.irq,
				 &psc_dma->playback);
			return -ENODEV;
		}
	}

	return 0;
}
EXPORT_SYMBOL_GPL(mpc5200_dma_startup);

int mpc5200_dma_hw_free(struct snd_pcm_substream *substream,
			   struct snd_soc_dai *dai)
{
	snd_pcm_set_runtime_buffer(substream, NULL);
	return 0;
}
EXPORT_SYMBOL_GPL(mpc5200_dma_hw_free);


/**
 * psc_dma_trigger: start and stop the DMA transfer.
 *
 * This function is called by ALSA to start, stop, pause, and resume the DMA
 * transfer of data.
 */
int mpc5200_dma_trigger(struct snd_pcm_substream *substream, int cmd,
			   struct snd_soc_dai *dai)
{
	struct snd_soc_pcm_runtime *rtd = substream->private_data;
	struct psc_dma *psc_dma = rtd->dai->cpu_dai->private_data;
	struct snd_pcm_runtime *runtime = substream->runtime;
	struct psc_dma_stream *s;
	struct mpc52xx_psc __iomem *regs = psc_dma->psc_regs;
	u16 imr;
	u8 psc_cmd;
	unsigned long flags;

	if (substream->pstr->stream == SNDRV_PCM_STREAM_CAPTURE)
		s = &psc_dma->capture;
	else
		s = &psc_dma->playback;

	dev_dbg(psc_dma->dev, "psc_dma_trigger(substream=%p, cmd=%i)"
		" stream_id=%i\n",
		substream, cmd, substream->pstr->stream);

	switch (cmd) {
	case SNDRV_PCM_TRIGGER_START:
		s->period_bytes = frames_to_bytes(runtime,
						  runtime->period_size);
		s->period_start = virt_to_phys(runtime->dma_area);
		s->period_end = s->period_start +
				(s->period_bytes * runtime->periods);
		s->period_next_pt = s->period_start;
		s->period_current_pt = s->period_start;
		s->active = 1;

		/* First; reset everything */
		if (substream->pstr->stream == SNDRV_PCM_STREAM_CAPTURE) {
			out_8(&regs->command, MPC52xx_PSC_RST_RX);
			out_8(&regs->command, MPC52xx_PSC_RST_ERR_STAT);
		} else {
			out_8(&regs->command, MPC52xx_PSC_RST_TX);
			out_8(&regs->command, MPC52xx_PSC_RST_ERR_STAT);
		}

		/* Next, fill up the bestcomm bd queue and enable DMA.
		 * This will begin filling the PSC's fifo. */
		if (substream->pstr->stream == SNDRV_PCM_STREAM_CAPTURE)
			bcom_gen_bd_rx_reset(s->bcom_task);
		else
			bcom_gen_bd_tx_reset(s->bcom_task);
		while (!bcom_queue_full(s->bcom_task))
			psc_dma_bcom_enqueue_next_buffer(s);
		bcom_enable(s->bcom_task);

		/* Due to errata in the dma mode; need to line up enabling
		 * the transmitter with a transition on the frame sync
		 * line */

		spin_lock_irqsave(&psc_dma->lock, flags);
		/* first make sure it is low */
		while ((in_8(&regs->ipcr_acr.ipcr) & 0x80) != 0)
			;
		/* then wait for the transition to high */
		while ((in_8(&regs->ipcr_acr.ipcr) & 0x80) == 0)
			;
		/* Finally, enable the PSC.
		 * Receiver must always be enabled; even when we only want
		 * transmit.  (see 15.3.2.3 of MPC5200B User's Guide) */
		psc_cmd = MPC52xx_PSC_RX_ENABLE;
		if (substream->pstr->stream == SNDRV_PCM_STREAM_PLAYBACK)
			psc_cmd |= MPC52xx_PSC_TX_ENABLE;
		out_8(&regs->command, psc_cmd);
		spin_unlock_irqrestore(&psc_dma->lock, flags);

		break;

	case SNDRV_PCM_TRIGGER_STOP:
		/* Turn off the PSC */
		s->active = 0;
		if (substream->pstr->stream == SNDRV_PCM_STREAM_CAPTURE) {
			if (!psc_dma->playback.active) {
				out_8(&regs->command, 2 << 4);	/* reset rx */
				out_8(&regs->command, 3 << 4);	/* reset tx */
				out_8(&regs->command, 4 << 4);	/* reset err */
			}
		} else {
			out_8(&regs->command, 3 << 4);	/* reset tx */
			out_8(&regs->command, 4 << 4);	/* reset err */
			if (!psc_dma->capture.active)
				out_8(&regs->command, 2 << 4);	/* reset rx */
		}

		bcom_disable(s->bcom_task);
		while (!bcom_queue_empty(s->bcom_task))
			bcom_retrieve_buffer(s->bcom_task, NULL, NULL);

		break;

	default:
		dev_dbg(psc_dma->dev, "invalid command\n");
		return -EINVAL;
	}

	/* Update interrupt enable settings */
	imr = 0;
	if (psc_dma->playback.active)
		imr |= MPC52xx_PSC_IMR_TXEMP;
	if (psc_dma->capture.active)
		imr |= MPC52xx_PSC_IMR_ORERR;
	out_be16(&regs->isr_imr.imr, imr);

	return 0;
}
EXPORT_SYMBOL_GPL(mpc5200_dma_trigger);


/**
 * psc_dma_shutdown: shutdown the data transfer on a stream
 *
 * Shutdown the PSC if there are no other substreams open.
 */
void mpc5200_dma_shutdown(struct snd_pcm_substream *substream,
			     struct snd_soc_dai *dai)
{
	struct snd_soc_pcm_runtime *rtd = substream->private_data;
	struct psc_dma *psc_dma = rtd->dai->cpu_dai->private_data;

	dev_dbg(psc_dma->dev, "psc_dma_shutdown(substream=%p)\n", substream);

	/*
	 * If this is the last active substream, disable the PSC and release
	 * the IRQ.
	 */
	if (!psc_dma->playback.active &&
	    !psc_dma->capture.active) {

		/* Disable all interrupts and reset the PSC */
		out_be16(&psc_dma->psc_regs->isr_imr.imr, 0);
		out_8(&psc_dma->psc_regs->command, 3 << 4); /* reset tx */
		out_8(&psc_dma->psc_regs->command, 2 << 4); /* reset rx */
		out_8(&psc_dma->psc_regs->command, 1 << 4); /* reset mode */
		out_8(&psc_dma->psc_regs->command, 4 << 4); /* reset error */

		/* Release irqs */
		free_irq(psc_dma->irq, psc_dma);
		free_irq(psc_dma->capture.irq, &psc_dma->capture);
		free_irq(psc_dma->playback.irq, &psc_dma->playback);
	}
}
EXPORT_SYMBOL_GPL(mpc5200_dma_shutdown);

/* ---------------------------------------------------------------------
 * The PSC DMA 'ASoC platform' driver
 *
 * Can be referenced by an 'ASoC machine' driver
 * This driver only deals with the audio bus; it doesn't have any
 * interaction with the attached codec
 */

static const struct snd_pcm_hardware psc_dma_pcm_hardware = {
	.info = SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID |
		SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER,
	.formats = SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_BE |
		   SNDRV_PCM_FMTBIT_S24_BE | SNDRV_PCM_FMTBIT_S32_BE,
	.rate_min = 8000,
	.rate_max = 48000,
	.channels_min = 1,
	.channels_max = 2,
	.period_bytes_max	= 1024 * 1024,
	.period_bytes_min	= 32,
	.periods_min		= 2,
	.periods_max		= 256,
	.buffer_bytes_max	= 2 * 1024 * 1024,
	.fifo_size		= 0,
};

static int psc_dma_pcm_open(struct snd_pcm_substream *substream)
{
	struct snd_soc_pcm_runtime *rtd = substream->private_data;
	struct psc_dma *psc_dma = rtd->dai->cpu_dai->private_data;
	struct psc_dma_stream *s;

	dev_dbg(psc_dma->dev, "psc_dma_pcm_open(substream=%p)\n", substream);

	if (substream->pstr->stream == SNDRV_PCM_STREAM_CAPTURE)
		s = &psc_dma->capture;
	else
		s = &psc_dma->playback;

	snd_soc_set_runtime_hwparams(substream, &psc_dma_pcm_hardware);

	s->stream = substream;
	return 0;
}

static int psc_dma_pcm_close(struct snd_pcm_substream *substream)
{
	struct snd_soc_pcm_runtime *rtd = substream->private_data;
	struct psc_dma *psc_dma = rtd->dai->cpu_dai->private_data;
	struct psc_dma_stream *s;

	dev_dbg(psc_dma->dev, "psc_dma_pcm_close(substream=%p)\n", substream);

	if (substream->pstr->stream == SNDRV_PCM_STREAM_CAPTURE)
		s = &psc_dma->capture;
	else
		s = &psc_dma->playback;

	s->stream = NULL;
	return 0;
}

static snd_pcm_uframes_t
psc_dma_pcm_pointer(struct snd_pcm_substream *substream)
{
	struct snd_pcm_runtime *runtime = substream->runtime;
	struct snd_soc_pcm_runtime *rtd = substream->private_data;
	struct psc_dma *psc_dma = rtd->dai->cpu_dai->private_data;
	struct psc_dma_stream *s;
	dma_addr_t count;
	snd_pcm_uframes_t frames;
	int delta;

	if (substream->pstr->stream == SNDRV_PCM_STREAM_CAPTURE)
		s = &psc_dma->capture;
	else
		s = &psc_dma->playback;

	count = s->period_current_pt - s->period_start;

	delta = jiffies - s->jiffies;
	delta = delta * runtime->rate / HZ;
	frames = bytes_to_frames(substream->runtime, count);

	return frames + delta;
}

static struct snd_pcm_ops psc_dma_pcm_ops = {
	.open		= psc_dma_pcm_open,
	.close		= psc_dma_pcm_close,
	.ioctl		= snd_pcm_lib_ioctl,
	.pointer	= psc_dma_pcm_pointer,
};

static u64 psc_dma_pcm_dmamask = 0xffffffff;
static int psc_dma_pcm_new(struct snd_card *card, struct snd_soc_dai *dai,
			   struct snd_pcm *pcm)
{
	struct snd_soc_pcm_runtime *rtd = pcm->private_data;
	struct psc_dma *psc_dma = rtd->dai->cpu_dai->private_data;
	size_t size = psc_dma_pcm_hardware.buffer_bytes_max;
	int rc = 0;

	dev_dbg(rtd->socdev->dev, "psc_dma_pcm_new(card=%p, dai=%p, pcm=%p)\n",
		card, dai, pcm);

	if (!card->dev->dma_mask)
		card->dev->dma_mask = &psc_dma_pcm_dmamask;
	if (!card->dev->coherent_dma_mask)
		card->dev->coherent_dma_mask = 0xffffffff;

	if (pcm->streams[0].substream) {
		rc = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, pcm->card->dev, size,
					&pcm->streams[0].substream->dma_buffer);
		if (rc)
			goto playback_alloc_err;
	}

	if (pcm->streams[1].substream) {
		rc = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, pcm->card->dev, size,
					&pcm->streams[1].substream->dma_buffer);
		if (rc)
			goto capture_alloc_err;
	}

	if (rtd->socdev->card->codec->ac97)
		rtd->socdev->card->codec->ac97->private_data = psc_dma;

	return 0;

 capture_alloc_err:
	if (pcm->streams[0].substream)
		snd_dma_free_pages(&pcm->streams[0].substream->dma_buffer);
 playback_alloc_err:
	dev_err(card->dev, "Cannot allocate buffer(s)\n");
	return -ENOMEM;
}

static void psc_dma_pcm_free(struct snd_pcm *pcm)
{
	struct snd_soc_pcm_runtime *rtd = pcm->private_data;
	struct snd_pcm_substream *substream;
	int stream;

	dev_dbg(rtd->socdev->dev, "psc_dma_pcm_free(pcm=%p)\n", pcm);

	for (stream = 0; stream < 2; stream++) {
		substream = pcm->streams[stream].substream;
		if (substream) {
			snd_dma_free_pages(&substream->dma_buffer);
			substream->dma_buffer.area = NULL;
			substream->dma_buffer.addr = 0;
		}
	}
}

struct snd_soc_platform mpc5200_dma_platform = {
	.name		= "mpc5200-psc-audio",
	.pcm_ops	= &psc_dma_pcm_ops,
	.pcm_new	= &psc_dma_pcm_new,
	.pcm_free	= &psc_dma_pcm_free,
};
EXPORT_SYMBOL_GPL(mpc5200_dma_platform);

static int __init mpc5200_soc_platform_init(void)
{
	/* Tell the ASoC OF helpers about it */
	of_snd_soc_register_platform(&mpc5200_dma_platform);
	return snd_soc_register_platform(&mpc5200_dma_platform);
}
module_init(mpc5200_soc_platform_init);

static void __exit mpc5200_soc_platform_exit(void)
{
	snd_soc_unregister_platform(&mpc5200_dma_platform);
}
module_exit(mpc5200_soc_platform_exit);

-------------------------------------------------------------------------------

/*
 * linux/sound/mpc5200-ac97.c -- AC97 support for the Freescale MPC52xx chip.
 *
 * Copyright 2008 Jon Smirl, Digispeaker
 * Author: Jon Smirl <jonsmirl@gmail.com>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2 as
 * published by the Free Software Foundation.
 */

#define DEBUG

#include <linux/init.h>
#include <linux/module.h>
#include <linux/interrupt.h>
#include <linux/device.h>
#include <linux/delay.h>
#include <linux/of_device.h>
#include <linux/of_platform.h>
#include <linux/dma-mapping.h>

#include <sound/core.h>
#include <sound/pcm.h>
#include <sound/pcm_params.h>
#include <sound/initval.h>
#include <sound/soc.h>
#include <sound/soc-of-simple.h>

#include <sysdev/bestcomm/bestcomm.h>
#include <sysdev/bestcomm/gen_bd.h>
#include <asm/time.h>
#include <asm/mpc52xx.h>
#include <asm/mpc52xx_psc.h>

#include "mpc5200_dma.h"
#include "mpc5200_psc_ac97.h"

MODULE_AUTHOR("Jon Smirl <jonsmirl@gmail.com>");
MODULE_DESCRIPTION("mpc5200 AC97 module");
MODULE_LICENSE("GPL");

#define DRV_NAME "mpc5200-psc-ac97"

static unsigned short psc_ac97_read(struct snd_ac97 *ac97, unsigned short reg)
{
	struct psc_dma *psc_dma = ac97->private_data;
	int timeout;
	unsigned int val;

	spin_lock(&psc_dma->lock);
	//printk("ac97 read: reg %04x\n", reg);

	/* Wait for it to be ready */
	timeout = 1000;
	while ((--timeout) && (in_be16(&psc_dma->psc_regs->sr_csr.status) &
						MPC52xx_PSC_SR_CMDSEND) )
		udelay(10);

	if (!timeout) {
		printk(KERN_ERR DRV_NAME ": timeout on ac97 bus (rdy)\n");
		return 0xffff;
	}

	/* Do the read */
	out_be32(&psc_dma->psc_regs->ac97_cmd, (1<<31) | ((reg & 0x7f) << 24));

	/* Wait for the answer */
	timeout = 1000;
	while ((--timeout) && !(in_be16(&psc_dma->psc_regs->sr_csr.status) &
						MPC52xx_PSC_SR_DATA_VAL) )
		udelay(10);

	if (!timeout) {
		printk(KERN_ERR DRV_NAME ": timeout on ac97 read (val) %x\n",
in_be16(&psc_dma->psc_regs->sr_csr.status));
		return 0xffff;
	}

	/* Get the data */
	val = in_be32(&psc_dma->psc_regs->ac97_data);
	if ( ((val>>24) & 0x7f) != reg ) {
		printk(KERN_ERR DRV_NAME ": reg echo error on ac97 read\n");
		return 0xffff;
	}
	val = (val >> 8) & 0xffff;

	//printk("ac97 read ok: reg %04x  val %04x\n", reg, val);

	spin_unlock(&psc_dma->lock);
	return (unsigned short) val;
}

static void psc_ac97_write(struct snd_ac97 *ac97, unsigned short reg,
unsigned short val)
{
	struct psc_dma *psc_dma = ac97->private_data;
	int timeout;

	//printk("ac97 write: reg %04x  val %04x\n", reg, val);
	spin_lock(&psc_dma->lock);

	/* Wait for it to be ready */
	timeout = 1000;
	while ((--timeout) && (in_be16(&psc_dma->psc_regs->sr_csr.status) &
						MPC52xx_PSC_SR_CMDSEND) )
		udelay(10);

	if (!timeout) {
		printk(KERN_ERR DRV_NAME ": timeout on ac97 write\n");
		return;
	}

	/* Write data */
	out_be32(&psc_dma->psc_regs->ac97_cmd, ((reg & 0x7f) << 24) | (val << 8));

	spin_unlock(&psc_dma->lock);
}

static void psc_ac97_cold_reset(struct snd_ac97 *ac97)
{
	struct psc_dma *psc_dma = ac97->private_data;

	printk("psc_ac97_cold_reset %p\n", ac97);

	/* Do a cold reset */
	out_8(&psc_dma->psc_regs->op1, MPC52xx_PSC_OP_RES);
	udelay(10);
	out_8(&psc_dma->psc_regs->op0, MPC52xx_PSC_OP_RES);
	udelay(50);

	/* PSC recover from cold reset (cfr user manual, not sure if useful) */
	out_be32(&psc_dma->psc_regs->sicr, in_be32(&psc_dma->psc_regs->sicr));
}

static void psc_ac97_warm_reset(struct snd_ac97 *ac97)
{
	printk("psc_ac97_warm_reset\n");
}

struct snd_ac97_bus_ops soc_ac97_ops = {
	.read		= psc_ac97_read,
	.write		= psc_ac97_write,
	.reset		= psc_ac97_cold_reset,
	.warm_reset	= psc_ac97_warm_reset,
};
EXPORT_SYMBOL_GPL(soc_ac97_ops);

#ifdef CONFIG_PM
static int psc_ac97_suspend(struct snd_soc_dai *dai)
{
	return 0;
}

static int psc_ac97_resume(struct snd_soc_dai *dai)
{
	return 0;
}

#else
#define psc_ac97_suspend	NULL
#define psc_ac97_resume	NULL
#endif

static int psc_ac97_hw_analog_params(struct snd_pcm_substream *substream,
				 struct snd_pcm_hw_params *params,
				 struct snd_soc_dai *dai)
{
	struct snd_soc_pcm_runtime *rtd = substream->private_data;
	struct psc_dma *psc_dma = rtd->dai->cpu_dai->private_data;

	dev_dbg(psc_dma->dev, "%s(substream=%p) p_size=%i p_bytes=%i"
		" periods=%i buffer_size=%i  buffer_bytes=%i channels=%i"
		" rate=%i format=%i\n",
		__func__, substream, params_period_size(params),
		params_period_bytes(params), params_periods(params),
		params_buffer_size(params), params_buffer_bytes(params),
		params_channels(params), params_rate(params), params_format(params));

	// FIXME, need a spinlock to protect access
	if (params_channels(params) == 1)
		out_be32(&psc_dma->psc_regs->ac97_slots, 0x01000000);
	else
		out_be32(&psc_dma->psc_regs->ac97_slots, 0x03000000);

  	snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);

	return 0;
}

static int psc_ac97_hw_digital_params(struct snd_pcm_substream *substream,
				 struct snd_pcm_hw_params *params,
				 struct snd_soc_dai *dai)
{
	return 0;
}

/**
 * psc_ac97_set_fmt: set the serial format.
 *
 * This function is called by the machine driver to tell us what serial
 * format to use.
 *
 * This driver only supports AC97 mode.  Return an error if the format is
 * not SND_SOC_DAIFMT_AC97.
 *
 * @format: one of SND_SOC_DAIFMT_xxx
 */
static int psc_ac97_set_fmt(struct snd_soc_dai *cpu_dai, unsigned int format)
{
	struct psc_dma *psc_dma = cpu_dai->private_data;
	dev_dbg(psc_dma->dev, "psc_ac97_set_fmt(cpu_dai=%p, format=%i)\n",
				cpu_dai, format);
	return (format == SND_SOC_DAIFMT_AC97) ? 0 : -EINVAL;
}

/* ---------------------------------------------------------------------
 * ALSA SoC Bindings
 *
 * - Digital Audio Interface (DAI) template
 * - create/destroy dai hooks
 */

/**
 * psc_ac97_dai_template: template CPU Digital Audio Interface
 */
static struct snd_soc_dai_ops psc_ac97_analog_ops = {
	.startup	= mpc5200_dma_startup,
	.hw_params	= psc_ac97_hw_analog_params,
	.hw_free	= mpc5200_dma_hw_free,
	.shutdown	= mpc5200_dma_shutdown,
	.trigger	= mpc5200_dma_trigger,
	.set_fmt	= psc_ac97_set_fmt,
};

static struct snd_soc_dai_ops psc_ac97_digital_ops = {
	.startup	= mpc5200_dma_startup,
	.hw_params	= psc_ac97_hw_digital_params,
	.hw_free	= mpc5200_dma_hw_free,
	.shutdown	= mpc5200_dma_shutdown,
	.trigger	= mpc5200_dma_trigger,
	.set_fmt	= psc_ac97_set_fmt,
};

static struct snd_soc_dai psc_ac97_dai_template[] = {
{
	.name	= "%s analog",
	.suspend = psc_ac97_suspend,
	.resume = psc_ac97_resume,
	.playback = {
		.channels_min	= 1,
		.channels_max	= 6,
		.rates		= SNDRV_PCM_RATE_8000_48000,
		.formats	= SNDRV_PCM_FMTBIT_S32_BE,
	},
	.capture = {
		.channels_min	= 1,
		.channels_max	= 2,
		.rates		= SNDRV_PCM_RATE_8000_48000,
		.formats	= SNDRV_PCM_FMTBIT_S32_BE,
	},
	.ops = &psc_ac97_analog_ops,
},
{
	.name	= "%s digital",
	.playback = {
		.channels_min	= 1,
		.channels_max	= 2,
		.rates		= SNDRV_PCM_RATE_32000 | \
			SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000,
		.formats	= SNDRV_PCM_FORMAT_IEC958_SUBFRAME_BE,
	},
	.ops = &psc_ac97_digital_ops,
}};

/* ---------------------------------------------------------------------
 * Sysfs attributes for debugging
 */

static ssize_t psc_ac97_status_show(struct device *dev,
			   struct device_attribute *attr, char *buf)
{
	struct psc_dma *psc_dma = dev_get_drvdata(dev);

	return sprintf(buf, "status=%.4x sicr=%.8x rfnum=%i rfstat=0x%.4x "
			"tfnum=%i tfstat=0x%.4x\n",
			in_be16(&psc_dma->psc_regs->sr_csr.status),
			in_be32(&psc_dma->psc_regs->sicr),
			in_be16(&psc_dma->fifo_regs->rfnum) & 0x1ff,
			in_be16(&psc_dma->fifo_regs->rfstat),
			in_be16(&psc_dma->fifo_regs->tfnum) & 0x1ff,
			in_be16(&psc_dma->fifo_regs->tfstat));
}

static int *psc_ac97_get_stat_attr(struct psc_dma *psc_dma, const char *name)
{
	if (strcmp(name, "playback_underrun") == 0)
		return &psc_dma->stats.underrun_count;
	if (strcmp(name, "capture_overrun") == 0)
		return &psc_dma->stats.overrun_count;

	return NULL;
}

static ssize_t psc_ac97_stat_show(struct device *dev,
				 struct device_attribute *attr, char *buf)
{
	struct psc_dma *psc_dma = dev_get_drvdata(dev);
	int *attrib;

	attrib = psc_ac97_get_stat_attr(psc_dma, attr->attr.name);
	if (!attrib)
		return 0;

	return sprintf(buf, "%i\n", *attrib);
}

static ssize_t psc_ac97_stat_store(struct device *dev,
				  struct device_attribute *attr,
				  const char *buf,
				  size_t count)
{
	struct psc_dma *psc_dma = dev_get_drvdata(dev);
	int *attrib;

	attrib = psc_ac97_get_stat_attr(psc_dma, attr->attr.name);
	if (!attrib)
		return 0;

	*attrib = simple_strtoul(buf, NULL, 0);
	return count;
}

static DEVICE_ATTR(status, 0644, psc_ac97_status_show, NULL);
static DEVICE_ATTR(playback_underrun, 0644, psc_ac97_stat_show,
			psc_ac97_stat_store);
static DEVICE_ATTR(capture_overrun, 0644, psc_ac97_stat_show,
			psc_ac97_stat_store);


/* ---------------------------------------------------------------------
 * OF platform bus binding code:
 * - Probe/remove operations
 * - OF device match table
 */
static int __devinit psc_ac97_of_probe(struct of_device *op,
				      const struct of_device_id *match)
{
	phys_addr_t fifo;
	struct psc_dma *psc_dma;
	struct resource res;
	int i, nDAI, size, psc_id, irq, rc;
	const __be32 *prop;
	void __iomem *regs;

	/* Get the PSC ID */
	prop = of_get_property(op->node, "cell-index", &size);
	if (!prop || size < sizeof *prop)
		return -ENODEV;
	psc_id = be32_to_cpu(*prop);

	/* Fetch the registers and IRQ of the PSC */
	irq = irq_of_parse_and_map(op->node, 0);
	if (of_address_to_resource(op->node, 0, &res)) {
		dev_err(&op->dev, "Missing reg property\n");
		return -ENODEV;
	}
	regs = ioremap(res.start, 1 + res.end - res.start);
	if (!regs) {
		dev_err(&op->dev, "Could not map registers\n");
		return -ENODEV;
	}

	/* Allocate and initialize the driver private data */
	psc_dma = kzalloc(sizeof *psc_dma, GFP_KERNEL);
	if (!psc_dma) {
		iounmap(regs);
		return -ENOMEM;
	}
	printk("psc_dma %p\n", psc_dma);

	spin_lock_init(&psc_dma->lock);
	psc_dma->irq = irq;
	psc_dma->psc_regs = regs;
	psc_dma->fifo_regs = regs + sizeof *psc_dma->psc_regs;
	psc_dma->dev = &op->dev;
	psc_dma->playback.psc_dma = psc_dma;
	psc_dma->capture.psc_dma = psc_dma;
	snprintf(psc_dma->name, sizeof psc_dma->name, "PSC%u AC97", psc_id+1);

	/* Fill out the CPU DAI structure */
	nDAI = ARRAY_SIZE(psc_ac97_dai_template);
	nDAI = min(nDAI, SOC_OF_SIMPLE_MAX_DAI);
	for (i = 0; i < nDAI; i++) {
		memcpy(&psc_dma->dai[i], &psc_ac97_dai_template[i], sizeof(struct
snd_soc_dai));
		psc_dma->dai[i].private_data = psc_dma;
		snprintf(psc_dma->stream_name[i], PSC_STREAM_NAME_LEN,
psc_ac97_dai_template[i].name, psc_dma->name);
		psc_dma->dai[i].name = psc_dma->stream_name[i];
		psc_dma->dai[i].id = psc_id;
	}

	/* Find the address of the fifo data registers and setup the
	 * DMA tasks */
	fifo = res.start + offsetof(struct mpc52xx_psc, buffer.buffer_32);
	psc_dma->capture.bcom_task =
		bcom_psc_gen_bd_rx_init(psc_id, 10, fifo, 512);
	psc_dma->playback.bcom_task =
		bcom_psc_gen_bd_tx_init(psc_id, 10, fifo);
	if (!psc_dma->capture.bcom_task ||
	    !psc_dma->playback.bcom_task) {
		dev_err(&op->dev, "Could not allocate bestcomm tasks\n");
		iounmap(regs);
		kfree(psc_dma);
		return -ENODEV;
	}

	/* Disable all interrupts and reset the PSC */
	out_be16(&psc_dma->psc_regs->isr_imr.imr, 0);
	out_8(&psc_dma->psc_regs->command, MPC52xx_PSC_RST_RX); /* reset receiver */
	out_8(&psc_dma->psc_regs->command, MPC52xx_PSC_RST_TX); /* reset transmitter */
	out_8(&psc_dma->psc_regs->command, MPC52xx_PSC_RST_ERR_STAT); /* reset error */
	out_8(&psc_dma->psc_regs->command, MPC52xx_PSC_SEL_MODE_REG_1); /*
reset mode */

	/* Do a cold reset of codec */
	out_8(&psc_dma->psc_regs->op1, MPC52xx_PSC_OP_RES);
	udelay(10);
	out_8(&psc_dma->psc_regs->op0, MPC52xx_PSC_OP_RES);
	udelay(50);

	/* Configure the serial interface mode to AC97 */
	psc_dma->sicr = MPC52xx_PSC_SICR_SIM_AC97 | MPC52xx_PSC_SICR_ENAC97;
	out_be32(&psc_dma->psc_regs->sicr, psc_dma->sicr);

	/* No slots active */
	out_be32(&psc_dma->psc_regs->ac97_slots, 0x00000000);

	/* Set up mode register;
	 * First write: RxRdy (FIFO Alarm) generates rx FIFO irq
	 * Second write: register Normal mode for non loopback
	 */
	out_8(&psc_dma->psc_regs->mode, 0);
	out_8(&psc_dma->psc_regs->mode, 0);

	/* Set the TX and RX fifo alarm thresholds */
	out_be16(&psc_dma->fifo_regs->rfalarm, 0x100);
	out_8(&psc_dma->fifo_regs->rfcntl, 0x4);
	out_be16(&psc_dma->fifo_regs->tfalarm, 0x100);
	out_8(&psc_dma->fifo_regs->tfcntl, 0x7);

	/* Go */
	out_8(&psc_dma->psc_regs->command, MPC52xx_PSC_TX_ENABLE);
	out_8(&psc_dma->psc_regs->command, MPC52xx_PSC_RX_ENABLE);

	/* Lookup the IRQ numbers */
	psc_dma->playback.irq =
		bcom_get_task_irq(psc_dma->playback.bcom_task);
	psc_dma->capture.irq =
		bcom_get_task_irq(psc_dma->capture.bcom_task);

	/* Save what we've done so it can be found again later */
	dev_set_drvdata(&op->dev, psc_dma);

	/* Register the SYSFS files */
	rc = device_create_file(psc_dma->dev, &dev_attr_status);
	rc |= device_create_file(psc_dma->dev, &dev_attr_capture_overrun);
	rc |= device_create_file(psc_dma->dev, &dev_attr_playback_underrun);
	if (rc)
		dev_info(psc_dma->dev, "error creating sysfs files\n");

	rc = snd_soc_register_dais(psc_dma->dai, nDAI);
	if (rc != 0) {
		printk("Failed to register DAI\n");
		return 0;
	}

	/* Tell the ASoC OF helpers about it */
	of_snd_soc_register_cpu_dai(op->node, psc_dma->dai, nDAI);

	return 0;
}

static int __devexit psc_ac97_of_remove(struct of_device *op)
{
	struct psc_dma *psc_dma = dev_get_drvdata(&op->dev);

	dev_dbg(&op->dev, "psc_ac97_remove()\n");

	bcom_gen_bd_rx_release(psc_dma->capture.bcom_task);
	bcom_gen_bd_tx_release(psc_dma->playback.bcom_task);

	iounmap(psc_dma->psc_regs);
	iounmap(psc_dma->fifo_regs);
	kfree(psc_dma);
	dev_set_drvdata(&op->dev, NULL);

	return 0;
}

/* Match table for of_platform binding */
static struct of_device_id psc_ac97_match[] __devinitdata = {
	{ .compatible = "fsl,mpc5200-psc-ac97", },
	{}
};
MODULE_DEVICE_TABLE(of, psc_ac97_match);

static struct of_platform_driver psc_ac97_driver = {
	.match_table = psc_ac97_match,
	.probe = psc_ac97_of_probe,
	.remove = __devexit_p(psc_ac97_of_remove),
	.driver = {
		.name = "mpc5200-psc-ac97",
		.owner = THIS_MODULE,
	},
};

/* ---------------------------------------------------------------------
 * Module setup and teardown; simply register the of_platform driver
 * for the PSC in AC97 mode.
 */
static int __init psc_ac97_init(void)
{
	return of_register_platform_driver(&psc_ac97_driver);
}
module_init(psc_ac97_init);

static void __exit psc_ac97_exit(void)
{
	of_unregister_platform_driver(&psc_ac97_driver);
}
module_exit(psc_ac97_exit);



-- 
Jon Smirl
jonsmirl@gmail.com
