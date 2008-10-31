From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 4/5] ASoC: Merge AT91 and AVR32 support into a
	single atmel architecture
Date: Fri, 31 Oct 2008 13:20:35 +0000
Message-ID: <1225459236-8633-4-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081031131828.GA8253@rakim.wolfsonmicro.main>
	<1225459236-8633-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1225459236-8633-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1225459236-8633-3-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CDEB12452A
	for <alsa-devel@alsa-project.org>; Fri, 31 Oct 2008 14:20:39 +0100 (CET)
In-Reply-To: <1225459236-8633-3-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Sedji Gaouaou <sedji.gaouaou@atmel.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

From: Sedji Gaouaou <sedji.gaouaou@atmel.com>

The Ateml AT91 and AVR32 SoC share common IP for audio and can share the
same driver code using the atmel-ssc API provided for both architectures.
Do this, creating a new unified atmel ASoC architecture to replace the
previous at32 and at91 ones.

[This was contributed as a patch series for reviewability but has been
squashed down to a single commit to help preserve both the history and
bisectability.  A small bugfix from Jukka is included.]

Tested-by: Jukka Hynninen <ext-jukka.hynninen@vaisala.com>
Signed-off-by: Sedji Gaouaou <sedji.gaouaou@atmel.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/Kconfig                                |    3 +-
 sound/soc/Makefile                               |    2 +-
 sound/soc/at32/Kconfig                           |   34 -
 sound/soc/at32/Makefile                          |   11 -
 sound/soc/at32/at32-pcm.h                        |   79 --
 sound/soc/at32/at32-ssc.c                        |  849 ----------------------
 sound/soc/at32/at32-ssc.h                        |   59 --
 sound/soc/at91/Kconfig                           |   10 -
 sound/soc/at91/Makefile                          |    6 -
 sound/soc/at91/at91-pcm.c                        |  434 -----------
 sound/soc/at91/at91-pcm.h                        |   72 --
 sound/soc/at91/at91-ssc.c                        |  791 --------------------
 sound/soc/at91/at91-ssc.h                        |   27 -
 sound/soc/atmel/Kconfig                          |   43 ++
 sound/soc/atmel/Makefile                         |   15 +
 sound/soc/{at32/at32-pcm.c => atmel/atmel-pcm.c} |  376 +++++-----
 sound/soc/atmel/atmel-pcm.h                      |   86 +++
 sound/soc/atmel/atmel_ssc_dai.c                  |  782 ++++++++++++++++++++
 sound/soc/atmel/atmel_ssc_dai.h                  |  121 +++
 sound/soc/{at32 => atmel}/playpaq_wm8510.c       |    4 +-
 20 files changed, 1235 insertions(+), 2569 deletions(-)
 delete mode 100644 sound/soc/at32/Kconfig
 delete mode 100644 sound/soc/at32/Makefile
 delete mode 100644 sound/soc/at32/at32-pcm.h
 delete mode 100644 sound/soc/at32/at32-ssc.c
 delete mode 100644 sound/soc/at32/at32-ssc.h
 delete mode 100644 sound/soc/at91/Kconfig
 delete mode 100644 sound/soc/at91/Makefile
 delete mode 100644 sound/soc/at91/at91-pcm.c
 delete mode 100644 sound/soc/at91/at91-pcm.h
 delete mode 100644 sound/soc/at91/at91-ssc.c
 delete mode 100644 sound/soc/at91/at91-ssc.h
 create mode 100644 sound/soc/atmel/Kconfig
 create mode 100644 sound/soc/atmel/Makefile
 rename sound/soc/{at32/at32-pcm.c => atmel/atmel-pcm.c} (50%)
 create mode 100644 sound/soc/atmel/atmel-pcm.h
 create mode 100644 sound/soc/atmel/atmel_ssc_dai.c
 create mode 100644 sound/soc/atmel/atmel_ssc_dai.h
 rename sound/soc/{at32 => atmel}/playpaq_wm8510.c (99%)

diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
index 4dfda66..615ebf0 100644
--- a/sound/soc/Kconfig
+++ b/sound/soc/Kconfig
@@ -23,8 +23,7 @@ config SND_SOC_AC97_BUS
 	bool
 
 # All the supported Soc's
-source "sound/soc/at32/Kconfig"
-source "sound/soc/at91/Kconfig"
+source "sound/soc/atmel/Kconfig"
 source "sound/soc/au1x/Kconfig"
 source "sound/soc/pxa/Kconfig"
 source "sound/soc/s3c24xx/Kconfig"
diff --git a/sound/soc/Makefile b/sound/soc/Makefile
index d849349..4d475c3 100644
--- a/sound/soc/Makefile
+++ b/sound/soc/Makefile
@@ -1,5 +1,5 @@
 snd-soc-core-objs := soc-core.o soc-dapm.o
 
 obj-$(CONFIG_SND_SOC)	+= snd-soc-core.o
-obj-$(CONFIG_SND_SOC)	+= codecs/ at32/ at91/ pxa/ s3c24xx/ sh/ fsl/ davinci/
+obj-$(CONFIG_SND_SOC)	+= codecs/ atmel/ pxa/ s3c24xx/ sh/ fsl/ davinci/
 obj-$(CONFIG_SND_SOC)	+= omap/ au1x/ blackfin/
diff --git a/sound/soc/at32/Kconfig b/sound/soc/at32/Kconfig
deleted file mode 100644
index b0765e8..0000000
--- a/sound/soc/at32/Kconfig
+++ /dev/null
@@ -1,34 +0,0 @@
-config SND_AT32_SOC
-        tristate "SoC Audio for the Atmel AT32 System-on-a-Chip"
-        depends on AVR32 && SND_SOC
-        help
-          Say Y or M if you want to add support for codecs attached to 
-          the AT32 SSC interface.  You will also need to
-          to select the audio interfaces to support below.
-
-
-config SND_AT32_SOC_SSC
-        tristate
-
-
-
-config SND_AT32_SOC_PLAYPAQ
-        tristate "SoC Audio support for PlayPaq with WM8510"
-        depends on SND_AT32_SOC && BOARD_PLAYPAQ
-        select SND_AT32_SOC_SSC
-        select SND_SOC_WM8510
-        help
-          Say Y or M here if you want to add support for SoC audio
-          on the LRS PlayPaq.
-
-
-
-config SND_AT32_SOC_PLAYPAQ_SLAVE
-        bool "Run CODEC on PlayPaq in slave mode"
-        depends on SND_AT32_SOC_PLAYPAQ
-        default n
-        help
-          Say Y if you want to run with the AT32 SSC generating the BCLK
-          and FRAME signals on the PlayPaq.  Unless you want to play
-          with the AT32 as the SSC master, you probably want to say N here,
-          as this will give you better sound quality.
diff --git a/sound/soc/at32/Makefile b/sound/soc/at32/Makefile
deleted file mode 100644
index c03e55e..0000000
--- a/sound/soc/at32/Makefile
+++ /dev/null
@@ -1,11 +0,0 @@
-# AT32 Platform Support
-snd-soc-at32-objs := at32-pcm.o
-snd-soc-at32-ssc-objs := at32-ssc.o
-
-obj-$(CONFIG_SND_AT32_SOC) += snd-soc-at32.o
-obj-$(CONFIG_SND_AT32_SOC_SSC) += snd-soc-at32-ssc.o
-
-# AT32 Machine Support
-snd-soc-playpaq-objs := playpaq_wm8510.o
-
-obj-$(CONFIG_SND_AT32_SOC_PLAYPAQ) += snd-soc-playpaq.o
diff --git a/sound/soc/at32/at32-pcm.h b/sound/soc/at32/at32-pcm.h
deleted file mode 100644
index 2a52430..0000000
--- a/sound/soc/at32/at32-pcm.h
+++ /dev/null
@@ -1,79 +0,0 @@
-/* sound/soc/at32/at32-pcm.h
- * ASoC PCM interface for Atmel AT32 SoC
- *
- * Copyright (C) 2008 Long Range Systems
- *    Geoffrey Wossum <gwossum@acm.org>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef __SOUND_SOC_AT32_AT32_PCM_H
-#define __SOUND_SOC_AT32_AT32_PCM_H __FILE__
-
-#include <linux/atmel-ssc.h>
-
-
-/*
- * Registers and status bits that are required by the PCM driver
- * TODO: Is ptcr really used?
- */
-struct at32_pdc_regs {
-	u32 xpr;		/* PDC RX/TX pointer */
-	u32 xcr;		/* PDC RX/TX counter */
-	u32 xnpr;		/* PDC next RX/TX pointer */
-	u32 xncr;		/* PDC next RX/TX counter */
-	u32 ptcr;		/* PDC transfer control */
-};
-
-
-
-/*
- * SSC mask info
- */
-struct at32_ssc_mask {
-	u32 ssc_enable;		/* SSC RX/TX enable */
-	u32 ssc_disable;	/* SSC RX/TX disable */
-	u32 ssc_endx;		/* SSC ENDTX or ENDRX */
-	u32 ssc_endbuf;		/* SSC TXBUFF or RXBUFF */
-	u32 pdc_enable;		/* PDC RX/TX enable */
-	u32 pdc_disable;	/* PDC RX/TX disable */
-};
-
-
-
-/*
- * This structure, shared between the PCM driver and the interface,
- * contains all information required by the PCM driver to perform the
- * PDC DMA operation.  All fields except dma_intr_handler() are initialized
- * by the interface.  The dms_intr_handler() pointer is set by the PCM
- * driver and called by the interface SSC interrupt handler if it is
- * non-NULL.
- */
-struct at32_pcm_dma_params {
-	char *name;		/* stream identifier */
-	int pdc_xfer_size;	/* PDC counter increment in bytes */
-	struct ssc_device *ssc;	/* SSC device for stream */
-	struct at32_pdc_regs *pdc;	/* PDC register info */
-	struct at32_ssc_mask *mask;	/* SSC mask info */
-	struct snd_pcm_substream *substream;
-	void (*dma_intr_handler) (u32, struct snd_pcm_substream *);
-};
-
-
-
-/*
- * The AT32 ASoC platform driver
- */
-extern struct snd_soc_platform at32_soc_platform;
-
-
-
-/*
- * SSC register access (since ssc_writel() / ssc_readl() require literal name)
- */
-#define ssc_readx(base, reg)            (__raw_readl((base) + (reg)))
-#define ssc_writex(base, reg, value)    __raw_writel((value), (base) + (reg))
-
-#endif /* __SOUND_SOC_AT32_AT32_PCM_H */
diff --git a/sound/soc/at32/at32-ssc.c b/sound/soc/at32/at32-ssc.c
deleted file mode 100644
index 4ef6492..0000000
--- a/sound/soc/at32/at32-ssc.c
+++ /dev/null
@@ -1,849 +0,0 @@
-/* sound/soc/at32/at32-ssc.c
- * ASoC platform driver for AT32 using SSC as DAI
- *
- * Copyright (C) 2008 Long Range Systems
- *    Geoffrey Wossum <gwossum@acm.org>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * Note that this is basically a port of the sound/soc/at91-ssc.c to
- * the AVR32 kernel.  Thanks to Frank Mandarino for that code.
- */
-
-/* #define DEBUG */
-
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/interrupt.h>
-#include <linux/device.h>
-#include <linux/delay.h>
-#include <linux/clk.h>
-#include <linux/io.h>
-#include <linux/atmel_pdc.h>
-#include <linux/atmel-ssc.h>
-
-#include <sound/core.h>
-#include <sound/pcm.h>
-#include <sound/pcm_params.h>
-#include <sound/initval.h>
-#include <sound/soc.h>
-
-#include "at32-pcm.h"
-#include "at32-ssc.h"
-
-
-
-/*-------------------------------------------------------------------------*\
- * Constants
-\*-------------------------------------------------------------------------*/
-#define NUM_SSC_DEVICES		3
-
-/*
- * SSC direction masks
- */
-#define SSC_DIR_MASK_UNUSED	0
-#define SSC_DIR_MASK_PLAYBACK	1
-#define SSC_DIR_MASK_CAPTURE	2
-
-/*
- * SSC register values that Atmel left out of <linux/atmel-ssc.h>.  These
- * are expected to be used with SSC_BF
- */
-/* START bit field values */
-#define SSC_START_CONTINUOUS	0
-#define SSC_START_TX_RX		1
-#define SSC_START_LOW_RF	2
-#define SSC_START_HIGH_RF	3
-#define SSC_START_FALLING_RF	4
-#define SSC_START_RISING_RF	5
-#define SSC_START_LEVEL_RF	6
-#define SSC_START_EDGE_RF	7
-#define SSS_START_COMPARE_0	8
-
-/* CKI bit field values */
-#define SSC_CKI_FALLING		0
-#define SSC_CKI_RISING		1
-
-/* CKO bit field values */
-#define SSC_CKO_NONE		0
-#define SSC_CKO_CONTINUOUS	1
-#define SSC_CKO_TRANSFER	2
-
-/* CKS bit field values */
-#define SSC_CKS_DIV		0
-#define SSC_CKS_CLOCK		1
-#define SSC_CKS_PIN		2
-
-/* FSEDGE bit field values */
-#define SSC_FSEDGE_POSITIVE	0
-#define SSC_FSEDGE_NEGATIVE	1
-
-/* FSOS bit field values */
-#define SSC_FSOS_NONE		0
-#define SSC_FSOS_NEGATIVE	1
-#define SSC_FSOS_POSITIVE	2
-#define SSC_FSOS_LOW		3
-#define SSC_FSOS_HIGH		4
-#define SSC_FSOS_TOGGLE		5
-
-#define START_DELAY		1
-
-
-
-/*-------------------------------------------------------------------------*\
- * Module data
-\*-------------------------------------------------------------------------*/
-/*
- * SSC PDC registered required by the PCM DMA engine
- */
-static struct at32_pdc_regs pdc_tx_reg = {
-	.xpr = SSC_PDC_TPR,
-	.xcr = SSC_PDC_TCR,
-	.xnpr = SSC_PDC_TNPR,
-	.xncr = SSC_PDC_TNCR,
-};
-
-
-
-static struct at32_pdc_regs pdc_rx_reg = {
-	.xpr = SSC_PDC_RPR,
-	.xcr = SSC_PDC_RCR,
-	.xnpr = SSC_PDC_RNPR,
-	.xncr = SSC_PDC_RNCR,
-};
-
-
-
-/*
- * SSC and PDC status bits for transmit and receive
- */
-static struct at32_ssc_mask ssc_tx_mask = {
-	.ssc_enable = SSC_BIT(CR_TXEN),
-	.ssc_disable = SSC_BIT(CR_TXDIS),
-	.ssc_endx = SSC_BIT(SR_ENDTX),
-	.ssc_endbuf = SSC_BIT(SR_TXBUFE),
-	.pdc_enable = SSC_BIT(PDC_PTCR_TXTEN),
-	.pdc_disable = SSC_BIT(PDC_PTCR_TXTDIS),
-};
-
-
-
-static struct at32_ssc_mask ssc_rx_mask = {
-	.ssc_enable = SSC_BIT(CR_RXEN),
-	.ssc_disable = SSC_BIT(CR_RXDIS),
-	.ssc_endx = SSC_BIT(SR_ENDRX),
-	.ssc_endbuf = SSC_BIT(SR_RXBUFF),
-	.pdc_enable = SSC_BIT(PDC_PTCR_RXTEN),
-	.pdc_disable = SSC_BIT(PDC_PTCR_RXTDIS),
-};
-
-
-
-/*
- * DMA parameters for each SSC
- */
-static struct at32_pcm_dma_params ssc_dma_params[NUM_SSC_DEVICES][2] = {
-	{
-	 {
-	  .name = "SSC0 PCM out",
-	  .pdc = &pdc_tx_reg,
-	  .mask = &ssc_tx_mask,
-	  },
-	 {
-	  .name = "SSC0 PCM in",
-	  .pdc = &pdc_rx_reg,
-	  .mask = &ssc_rx_mask,
-	  },
-	 },
-	{
-	 {
-	  .name = "SSC1 PCM out",
-	  .pdc = &pdc_tx_reg,
-	  .mask = &ssc_tx_mask,
-	  },
-	 {
-	  .name = "SSC1 PCM in",
-	  .pdc = &pdc_rx_reg,
-	  .mask = &ssc_rx_mask,
-	  },
-	 },
-	{
-	 {
-	  .name = "SSC2 PCM out",
-	  .pdc = &pdc_tx_reg,
-	  .mask = &ssc_tx_mask,
-	  },
-	 {
-	  .name = "SSC2 PCM in",
-	  .pdc = &pdc_rx_reg,
-	  .mask = &ssc_rx_mask,
-	  },
-	 },
-};
-
-
-
-static struct at32_ssc_info ssc_info[NUM_SSC_DEVICES] = {
-	{
-	 .name = "ssc0",
-	 .lock = __SPIN_LOCK_UNLOCKED(ssc_info[0].lock),
-	 .dir_mask = SSC_DIR_MASK_UNUSED,
-	 .initialized = 0,
-	 },
-	{
-	 .name = "ssc1",
-	 .lock = __SPIN_LOCK_UNLOCKED(ssc_info[1].lock),
-	 .dir_mask = SSC_DIR_MASK_UNUSED,
-	 .initialized = 0,
-	 },
-	{
-	 .name = "ssc2",
-	 .lock = __SPIN_LOCK_UNLOCKED(ssc_info[2].lock),
-	 .dir_mask = SSC_DIR_MASK_UNUSED,
-	 .initialized = 0,
-	 },
-};
-
-
-
-
-/*-------------------------------------------------------------------------*\
- * ISR
-\*-------------------------------------------------------------------------*/
-/*
- * SSC interrupt handler.  Passes PDC interrupts to the DMA interrupt
- * handler in the PCM driver.
- */
-static irqreturn_t at32_ssc_interrupt(int irq, void *dev_id)
-{
-	struct at32_ssc_info *ssc_p = dev_id;
-	struct at32_pcm_dma_params *dma_params;
-	u32 ssc_sr;
-	u32 ssc_substream_mask;
-	int i;
-
-	ssc_sr = (ssc_readl(ssc_p->ssc->regs, SR) &
-		  ssc_readl(ssc_p->ssc->regs, IMR));
-
-	/*
-	 * Loop through substreams attached to this SSC.  If a DMA-related
-	 * interrupt occured on that substream, call the DMA interrupt
-	 * handler function, if one has been registered in the dma_param
-	 * structure by the PCM driver.
-	 */
-	for (i = 0; i < ARRAY_SIZE(ssc_p->dma_params); i++) {
-		dma_params = ssc_p->dma_params[i];
-
-		if ((dma_params != NULL) &&
-		    (dma_params->dma_intr_handler != NULL)) {
-			ssc_substream_mask = (dma_params->mask->ssc_endx |
-					      dma_params->mask->ssc_endbuf);
-			if (ssc_sr & ssc_substream_mask) {
-				dma_params->dma_intr_handler(ssc_sr,
-							     dma_params->
-							     substream);
-			}
-		}
-	}
-
-
-	return IRQ_HANDLED;
-}
-
-/*-------------------------------------------------------------------------*\
- * DAI functions
-\*-------------------------------------------------------------------------*/
-/*
- * Startup.  Only that one substream allowed in each direction.
- */
-static int at32_ssc_startup(struct snd_pcm_substream *substream)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct at32_ssc_info *ssc_p = &ssc_info[rtd->dai->cpu_dai->id];
-	int dir_mask;
-
-	dir_mask = ((substream->stream == SNDRV_PCM_STREAM_PLAYBACK) ?
-		    SSC_DIR_MASK_PLAYBACK : SSC_DIR_MASK_CAPTURE);
-
-	spin_lock_irq(&ssc_p->lock);
-	if (ssc_p->dir_mask & dir_mask) {
-		spin_unlock_irq(&ssc_p->lock);
-		return -EBUSY;
-	}
-	ssc_p->dir_mask |= dir_mask;
-	spin_unlock_irq(&ssc_p->lock);
-
-	return 0;
-}
-
-
-
-/*
- * Shutdown.  Clear DMA parameters and shutdown the SSC if there
- * are no other substreams open.
- */
-static void at32_ssc_shutdown(struct snd_pcm_substream *substream)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct at32_ssc_info *ssc_p = &ssc_info[rtd->dai->cpu_dai->id];
-	struct at32_pcm_dma_params *dma_params;
-	int dir_mask;
-
-	dma_params = ssc_p->dma_params[substream->stream];
-
-	if (dma_params != NULL) {
-		ssc_writel(dma_params->ssc->regs, CR,
-			   dma_params->mask->ssc_disable);
-		pr_debug("%s disabled SSC_SR=0x%08x\n",
-			 (substream->stream ? "receiver" : "transmit"),
-			 ssc_readl(ssc_p->ssc->regs, SR));
-
-		dma_params->ssc = NULL;
-		dma_params->substream = NULL;
-		ssc_p->dma_params[substream->stream] = NULL;
-	}
-
-
-	dir_mask = 1 << substream->stream;
-	spin_lock_irq(&ssc_p->lock);
-	ssc_p->dir_mask &= ~dir_mask;
-	if (!ssc_p->dir_mask) {
-		/* Shutdown the SSC clock */
-		pr_debug("at32-ssc: Stopping user %d clock\n",
-			 ssc_p->ssc->user);
-		clk_disable(ssc_p->ssc->clk);
-
-		if (ssc_p->initialized) {
-			free_irq(ssc_p->ssc->irq, ssc_p);
-			ssc_p->initialized = 0;
-		}
-
-		/* Reset the SSC */
-		ssc_writel(ssc_p->ssc->regs, CR, SSC_BIT(CR_SWRST));
-
-		/* clear the SSC dividers */
-		ssc_p->cmr_div = 0;
-		ssc_p->tcmr_period = 0;
-		ssc_p->rcmr_period = 0;
-	}
-	spin_unlock_irq(&ssc_p->lock);
-}
-
-
-
-/*
- * Set the SSC system clock rate
- */
-static int at32_ssc_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
-				   int clk_id, unsigned int freq, int dir)
-{
-	/* TODO: What the heck do I do here? */
-	return 0;
-}
-
-
-
-/*
- * Record DAI format for use by hw_params()
- */
-static int at32_ssc_set_dai_fmt(struct snd_soc_dai *cpu_dai,
-				unsigned int fmt)
-{
-	struct at32_ssc_info *ssc_p = &ssc_info[cpu_dai->id];
-
-	ssc_p->daifmt = fmt;
-	return 0;
-}
-
-
-
-/*
- * Record SSC clock dividers for use in hw_params()
- */
-static int at32_ssc_set_dai_clkdiv(struct snd_soc_dai *cpu_dai,
-				   int div_id, int div)
-{
-	struct at32_ssc_info *ssc_p = &ssc_info[cpu_dai->id];
-
-	switch (div_id) {
-	case AT32_SSC_CMR_DIV:
-		/*
-		 * The same master clock divider is used for both
-		 * transmit and receive, so if a value has already
-		 * been set, it must match this value
-		 */
-		if (ssc_p->cmr_div == 0)
-			ssc_p->cmr_div = div;
-		else if (div != ssc_p->cmr_div)
-			return -EBUSY;
-		break;
-
-	case AT32_SSC_TCMR_PERIOD:
-		ssc_p->tcmr_period = div;
-		break;
-
-	case AT32_SSC_RCMR_PERIOD:
-		ssc_p->rcmr_period = div;
-		break;
-
-	default:
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-
-
-/*
- * Configure the SSC
- */
-static int at32_ssc_hw_params(struct snd_pcm_substream *substream,
-			      struct snd_pcm_hw_params *params)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	int id = rtd->dai->cpu_dai->id;
-	struct at32_ssc_info *ssc_p = &ssc_info[id];
-	struct at32_pcm_dma_params *dma_params;
-	int channels, bits;
-	u32 tfmr, rfmr, tcmr, rcmr;
-	int start_event;
-	int ret;
-
-
-	/*
-	 * Currently, there is only one set of dma_params for each direction.
-	 * If more are added, this code will have to be changed to select
-	 * the proper set
-	 */
-	dma_params = &ssc_dma_params[id][substream->stream];
-	dma_params->ssc = ssc_p->ssc;
-	dma_params->substream = substream;
-
-	ssc_p->dma_params[substream->stream] = dma_params;
-
-
-	/*
-	 * The cpu_dai->dma_data field is only used to communicate the
-	 * appropriate DMA parameters to the PCM driver's hw_params()
-	 * function.  It should not be used for other purposes as it
-	 * is common to all substreams.
-	 */
-	rtd->dai->cpu_dai->dma_data = dma_params;
-
-	channels = params_channels(params);
-
-
-	/*
-	 * Determine sample size in bits and the PDC increment
-	 */
-	switch (params_format(params)) {
-	case SNDRV_PCM_FORMAT_S8:
-		bits = 8;
-		dma_params->pdc_xfer_size = 1;
-		break;
-
-	case SNDRV_PCM_FORMAT_S16:
-		bits = 16;
-		dma_params->pdc_xfer_size = 2;
-		break;
-
-	case SNDRV_PCM_FORMAT_S24:
-		bits = 24;
-		dma_params->pdc_xfer_size = 4;
-		break;
-
-	case SNDRV_PCM_FORMAT_S32:
-		bits = 32;
-		dma_params->pdc_xfer_size = 4;
-		break;
-
-	default:
-		pr_warning("at32-ssc: Unsupported PCM format %d",
-			   params_format(params));
-		return -EINVAL;
-	}
-	pr_debug("at32-ssc: bits = %d, pdc_xfer_size = %d, channels = %d\n",
-		 bits, dma_params->pdc_xfer_size, channels);
-
-
-	/*
-	 * The SSC only supports up to 16-bit samples in I2S format, due
-	 * to the size of the Frame Mode Register FSLEN field.
-	 */
-	if ((ssc_p->daifmt & SND_SOC_DAIFMT_FORMAT_MASK) == SND_SOC_DAIFMT_I2S)
-		if (bits > 16) {
-			pr_warning("at32-ssc: "
-				   "sample size %d is too large for I2S\n",
-				   bits);
-			return -EINVAL;
-		}
-
-
-	/*
-	 * Compute the SSC register settings
-	 */
-	switch (ssc_p->daifmt & (SND_SOC_DAIFMT_FORMAT_MASK |
-				 SND_SOC_DAIFMT_MASTER_MASK)) {
-	case SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBS_CFS:
-		/*
-		 * I2S format, SSC provides BCLK and LRS clocks.
-		 *
-		 * The SSC transmit and receive clocks are generated from the
-		 * MCK divider, and the BCLK signal is output on the SSC TK line
-		 */
-		pr_debug("at32-ssc: SSC mode is I2S BCLK / FRAME master\n");
-		rcmr = (SSC_BF(RCMR_PERIOD, ssc_p->rcmr_period) |
-			SSC_BF(RCMR_STTDLY, START_DELAY) |
-			SSC_BF(RCMR_START, SSC_START_FALLING_RF) |
-			SSC_BF(RCMR_CKI, SSC_CKI_RISING) |
-			SSC_BF(RCMR_CKO, SSC_CKO_NONE) |
-			SSC_BF(RCMR_CKS, SSC_CKS_DIV));
-
-		rfmr = (SSC_BF(RFMR_FSEDGE, SSC_FSEDGE_POSITIVE) |
-			SSC_BF(RFMR_FSOS, SSC_FSOS_NEGATIVE) |
-			SSC_BF(RFMR_FSLEN, bits - 1) |
-			SSC_BF(RFMR_DATNB, channels - 1) |
-			SSC_BIT(RFMR_MSBF) | SSC_BF(RFMR_DATLEN, bits - 1));
-
-		tcmr = (SSC_BF(TCMR_PERIOD, ssc_p->tcmr_period) |
-			SSC_BF(TCMR_STTDLY, START_DELAY) |
-			SSC_BF(TCMR_START, SSC_START_FALLING_RF) |
-			SSC_BF(TCMR_CKI, SSC_CKI_FALLING) |
-			SSC_BF(TCMR_CKO, SSC_CKO_CONTINUOUS) |
-			SSC_BF(TCMR_CKS, SSC_CKS_DIV));
-
-		tfmr = (SSC_BF(TFMR_FSEDGE, SSC_FSEDGE_POSITIVE) |
-			SSC_BF(TFMR_FSOS, SSC_FSOS_NEGATIVE) |
-			SSC_BF(TFMR_FSLEN, bits - 1) |
-			SSC_BF(TFMR_DATNB, channels - 1) | SSC_BIT(TFMR_MSBF) |
-			SSC_BF(TFMR_DATLEN, bits - 1));
-		break;
-
-
-	case SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBM_CFM:
-		/*
-		 * I2S format, CODEC supplies BCLK and LRC clock.
-		 *
-		 * The SSC transmit clock is obtained from the BCLK signal
-		 * on the TK line, and the SSC receive clock is generated from
-		 * the transmit clock.
-		 *
-		 * For single channel data, one sample is transferred on the
-		 * falling edge of the LRC clock.  For two channel data, one
-		 * sample is transferred on both edges of the LRC clock.
-		 */
-		pr_debug("at32-ssc: SSC mode is I2S BCLK / FRAME slave\n");
-		start_event = ((channels == 1) ?
-			       SSC_START_FALLING_RF : SSC_START_EDGE_RF);
-
-		rcmr = (SSC_BF(RCMR_STTDLY, START_DELAY) |
-			SSC_BF(RCMR_START, start_event) |
-			SSC_BF(RCMR_CKI, SSC_CKI_RISING) |
-			SSC_BF(RCMR_CKO, SSC_CKO_NONE) |
-			SSC_BF(RCMR_CKS, SSC_CKS_CLOCK));
-
-		rfmr = (SSC_BF(RFMR_FSEDGE, SSC_FSEDGE_POSITIVE) |
-			SSC_BF(RFMR_FSOS, SSC_FSOS_NONE) |
-			SSC_BIT(RFMR_MSBF) | SSC_BF(RFMR_DATLEN, bits - 1));
-
-		tcmr = (SSC_BF(TCMR_STTDLY, START_DELAY) |
-			SSC_BF(TCMR_START, start_event) |
-			SSC_BF(TCMR_CKI, SSC_CKI_FALLING) |
-			SSC_BF(TCMR_CKO, SSC_CKO_NONE) |
-			SSC_BF(TCMR_CKS, SSC_CKS_PIN));
-
-		tfmr = (SSC_BF(TFMR_FSEDGE, SSC_FSEDGE_POSITIVE) |
-			SSC_BF(TFMR_FSOS, SSC_FSOS_NONE) |
-			SSC_BIT(TFMR_MSBF) | SSC_BF(TFMR_DATLEN, bits - 1));
-		break;
-
-
-	case SND_SOC_DAIFMT_DSP_A | SND_SOC_DAIFMT_CBS_CFS:
-		/*
-		 * DSP/PCM Mode A format, SSC provides BCLK and LRC clocks.
-		 *
-		 * The SSC transmit and receive clocks are generated from the
-		 * MCK divider, and the BCLK signal is output on the SSC TK line
-		 */
-		pr_debug("at32-ssc: SSC mode is DSP A BCLK / FRAME master\n");
-		rcmr = (SSC_BF(RCMR_PERIOD, ssc_p->rcmr_period) |
-			SSC_BF(RCMR_STTDLY, 1) |
-			SSC_BF(RCMR_START, SSC_START_RISING_RF) |
-			SSC_BF(RCMR_CKI, SSC_CKI_RISING) |
-			SSC_BF(RCMR_CKO, SSC_CKO_NONE) |
-			SSC_BF(RCMR_CKS, SSC_CKS_DIV));
-
-		rfmr = (SSC_BF(RFMR_FSEDGE, SSC_FSEDGE_POSITIVE) |
-			SSC_BF(RFMR_FSOS, SSC_FSOS_POSITIVE) |
-			SSC_BF(RFMR_DATNB, channels - 1) |
-			SSC_BIT(RFMR_MSBF) | SSC_BF(RFMR_DATLEN, bits - 1));
-
-		tcmr = (SSC_BF(TCMR_PERIOD, ssc_p->tcmr_period) |
-			SSC_BF(TCMR_STTDLY, 1) |
-			SSC_BF(TCMR_START, SSC_START_RISING_RF) |
-			SSC_BF(TCMR_CKI, SSC_CKI_RISING) |
-			SSC_BF(TCMR_CKO, SSC_CKO_CONTINUOUS) |
-			SSC_BF(TCMR_CKS, SSC_CKS_DIV));
-
-		tfmr = (SSC_BF(TFMR_FSEDGE, SSC_FSEDGE_POSITIVE) |
-			SSC_BF(TFMR_FSOS, SSC_FSOS_POSITIVE) |
-			SSC_BF(TFMR_DATNB, channels - 1) |
-			SSC_BIT(TFMR_MSBF) | SSC_BF(TFMR_DATLEN, bits - 1));
-		break;
-
-
-	case SND_SOC_DAIFMT_DSP_A | SND_SOC_DAIFMT_CBM_CFM:
-	default:
-		pr_warning("at32-ssc: unsupported DAI format 0x%x\n",
-			   ssc_p->daifmt);
-		return -EINVAL;
-		break;
-	}
-	pr_debug("at32-ssc: RCMR=%08x RFMR=%08x TCMR=%08x TFMR=%08x\n",
-		 rcmr, rfmr, tcmr, tfmr);
-
-
-	if (!ssc_p->initialized) {
-		/* enable peripheral clock */
-		pr_debug("at32-ssc: Starting clock\n");
-		clk_enable(ssc_p->ssc->clk);
-
-		/* Reset the SSC and its PDC registers */
-		ssc_writel(ssc_p->ssc->regs, CR, SSC_BIT(CR_SWRST));
-
-		ssc_writel(ssc_p->ssc->regs, PDC_RPR, 0);
-		ssc_writel(ssc_p->ssc->regs, PDC_RCR, 0);
-		ssc_writel(ssc_p->ssc->regs, PDC_RNPR, 0);
-		ssc_writel(ssc_p->ssc->regs, PDC_RNCR, 0);
-
-		ssc_writel(ssc_p->ssc->regs, PDC_TPR, 0);
-		ssc_writel(ssc_p->ssc->regs, PDC_TCR, 0);
-		ssc_writel(ssc_p->ssc->regs, PDC_TNPR, 0);
-		ssc_writel(ssc_p->ssc->regs, PDC_TNCR, 0);
-
-		ret = request_irq(ssc_p->ssc->irq, at32_ssc_interrupt, 0,
-				  ssc_p->name, ssc_p);
-		if (ret < 0) {
-			pr_warning("at32-ssc: request irq failed (%d)\n", ret);
-			pr_debug("at32-ssc: Stopping clock\n");
-			clk_disable(ssc_p->ssc->clk);
-			return ret;
-		}
-
-		ssc_p->initialized = 1;
-	}
-
-	/* Set SSC clock mode register */
-	ssc_writel(ssc_p->ssc->regs, CMR, ssc_p->cmr_div);
-
-	/* set receive clock mode and format */
-	ssc_writel(ssc_p->ssc->regs, RCMR, rcmr);
-	ssc_writel(ssc_p->ssc->regs, RFMR, rfmr);
-
-	/* set transmit clock mode and format */
-	ssc_writel(ssc_p->ssc->regs, TCMR, tcmr);
-	ssc_writel(ssc_p->ssc->regs, TFMR, tfmr);
-
-	pr_debug("at32-ssc: SSC initialized\n");
-	return 0;
-}
-
-
-
-static int at32_ssc_prepare(struct snd_pcm_substream *substream)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct at32_ssc_info *ssc_p = &ssc_info[rtd->dai->cpu_dai->id];
-	struct at32_pcm_dma_params *dma_params;
-
-	dma_params = ssc_p->dma_params[substream->stream];
-
-	ssc_writel(dma_params->ssc->regs, CR, dma_params->mask->ssc_enable);
-
-	return 0;
-}
-
-
-
-#ifdef CONFIG_PM
-static int at32_ssc_suspend(struct platform_device *pdev,
-			    struct snd_soc_dai *cpu_dai)
-{
-	struct at32_ssc_info *ssc_p;
-
-	if (!cpu_dai->active)
-		return 0;
-
-	ssc_p = &ssc_info[cpu_dai->id];
-
-	/* Save the status register before disabling transmit and receive */
-	ssc_p->ssc_state.ssc_sr = ssc_readl(ssc_p->ssc->regs, SR);
-	ssc_writel(ssc_p->ssc->regs, CR, SSC_BIT(CR_TXDIS) | SSC_BIT(CR_RXDIS));
-
-	/* Save the current interrupt mask, then disable unmasked interrupts */
-	ssc_p->ssc_state.ssc_imr = ssc_readl(ssc_p->ssc->regs, IMR);
-	ssc_writel(ssc_p->ssc->regs, IDR, ssc_p->ssc_state.ssc_imr);
-
-	ssc_p->ssc_state.ssc_cmr = ssc_readl(ssc_p->ssc->regs, CMR);
-	ssc_p->ssc_state.ssc_rcmr = ssc_readl(ssc_p->ssc->regs, RCMR);
-	ssc_p->ssc_state.ssc_rfmr = ssc_readl(ssc_p->ssc->regs, RFMR);
-	ssc_p->ssc_state.ssc_tcmr = ssc_readl(ssc_p->ssc->regs, TCMR);
-	ssc_p->ssc_state.ssc_tfmr = ssc_readl(ssc_p->ssc->regs, TFMR);
-
-	return 0;
-}
-
-
-
-static int at32_ssc_resume(struct platform_device *pdev,
-			   struct snd_soc_dai *cpu_dai)
-{
-	struct at32_ssc_info *ssc_p;
-	u32 cr;
-
-	if (!cpu_dai->active)
-		return 0;
-
-	ssc_p = &ssc_info[cpu_dai->id];
-
-	/* restore SSC register settings */
-	ssc_writel(ssc_p->ssc->regs, TFMR, ssc_p->ssc_state.ssc_tfmr);
-	ssc_writel(ssc_p->ssc->regs, TCMR, ssc_p->ssc_state.ssc_tcmr);
-	ssc_writel(ssc_p->ssc->regs, RFMR, ssc_p->ssc_state.ssc_rfmr);
-	ssc_writel(ssc_p->ssc->regs, RCMR, ssc_p->ssc_state.ssc_rcmr);
-	ssc_writel(ssc_p->ssc->regs, CMR, ssc_p->ssc_state.ssc_cmr);
-
-	/* re-enable interrupts */
-	ssc_writel(ssc_p->ssc->regs, IER, ssc_p->ssc_state.ssc_imr);
-
-	/* Re-enable recieve and transmit as appropriate */
-	cr = 0;
-	cr |=
-	    (ssc_p->ssc_state.ssc_sr & SSC_BIT(SR_RXEN)) ? SSC_BIT(CR_RXEN) : 0;
-	cr |=
-	    (ssc_p->ssc_state.ssc_sr & SSC_BIT(SR_TXEN)) ? SSC_BIT(CR_TXEN) : 0;
-	ssc_writel(ssc_p->ssc->regs, CR, cr);
-
-	return 0;
-}
-#else /* CONFIG_PM */
-#  define at32_ssc_suspend	NULL
-#  define at32_ssc_resume	NULL
-#endif /* CONFIG_PM */
-
-
-#define AT32_SSC_RATES \
-    (SNDRV_PCM_RATE_8000  | SNDRV_PCM_RATE_11025 | SNDRV_PCM_RATE_16000 | \
-     SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 | \
-     SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000)
-
-
-#define AT32_SSC_FORMATS \
-    (SNDRV_PCM_FMTBIT_S8  | SNDRV_PCM_FMTBIT_S16 | \
-     SNDRV_PCM_FMTBIT_S24 | SNDRV_PCM_FMTBIT_S32)
-
-
-struct snd_soc_dai at32_ssc_dai[NUM_SSC_DEVICES] = {
-	{
-	 .name = "at32-ssc0",
-	 .id = 0,
-	 .type = SND_SOC_DAI_PCM,
-	 .suspend = at32_ssc_suspend,
-	 .resume = at32_ssc_resume,
-	 .playback = {
-		      .channels_min = 1,
-		      .channels_max = 2,
-		      .rates = AT32_SSC_RATES,
-		      .formats = AT32_SSC_FORMATS,
-		      },
-	 .capture = {
-		     .channels_min = 1,
-		     .channels_max = 2,
-		     .rates = AT32_SSC_RATES,
-		     .formats = AT32_SSC_FORMATS,
-		     },
-	 .ops = {
-		 .startup = at32_ssc_startup,
-		 .shutdown = at32_ssc_shutdown,
-		 .prepare = at32_ssc_prepare,
-		 .hw_params = at32_ssc_hw_params,
-		 },
-	 .dai_ops = {
-		     .set_sysclk = at32_ssc_set_dai_sysclk,
-		     .set_fmt = at32_ssc_set_dai_fmt,
-		     .set_clkdiv = at32_ssc_set_dai_clkdiv,
-		     },
-	 .private_data = &ssc_info[0],
-	 },
-	{
-	 .name = "at32-ssc1",
-	 .id = 1,
-	 .type = SND_SOC_DAI_PCM,
-	 .suspend = at32_ssc_suspend,
-	 .resume = at32_ssc_resume,
-	 .playback = {
-		      .channels_min = 1,
-		      .channels_max = 2,
-		      .rates = AT32_SSC_RATES,
-		      .formats = AT32_SSC_FORMATS,
-		      },
-	 .capture = {
-		     .channels_min = 1,
-		     .channels_max = 2,
-		     .rates = AT32_SSC_RATES,
-		     .formats = AT32_SSC_FORMATS,
-		     },
-	 .ops = {
-		 .startup = at32_ssc_startup,
-		 .shutdown = at32_ssc_shutdown,
-		 .prepare = at32_ssc_prepare,
-		 .hw_params = at32_ssc_hw_params,
-		 },
-	 .dai_ops = {
-		     .set_sysclk = at32_ssc_set_dai_sysclk,
-		     .set_fmt = at32_ssc_set_dai_fmt,
-		     .set_clkdiv = at32_ssc_set_dai_clkdiv,
-		     },
-	 .private_data = &ssc_info[1],
-	 },
-	{
-	 .name = "at32-ssc2",
-	 .id = 2,
-	 .type = SND_SOC_DAI_PCM,
-	 .suspend = at32_ssc_suspend,
-	 .resume = at32_ssc_resume,
-	 .playback = {
-		      .channels_min = 1,
-		      .channels_max = 2,
-		      .rates = AT32_SSC_RATES,
-		      .formats = AT32_SSC_FORMATS,
-		      },
-	 .capture = {
-		     .channels_min = 1,
-		     .channels_max = 2,
-		     .rates = AT32_SSC_RATES,
-		     .formats = AT32_SSC_FORMATS,
-		     },
-	 .ops = {
-		 .startup = at32_ssc_startup,
-		 .shutdown = at32_ssc_shutdown,
-		 .prepare = at32_ssc_prepare,
-		 .hw_params = at32_ssc_hw_params,
-		 },
-	 .dai_ops = {
-		     .set_sysclk = at32_ssc_set_dai_sysclk,
-		     .set_fmt = at32_ssc_set_dai_fmt,
-		     .set_clkdiv = at32_ssc_set_dai_clkdiv,
-		     },
-	 .private_data = &ssc_info[2],
-	 },
-};
-EXPORT_SYMBOL_GPL(at32_ssc_dai);
-
-
-MODULE_AUTHOR("Geoffrey Wossum <gwossum@acm.org>");
-MODULE_DESCRIPTION("AT32 SSC ASoC Interface");
-MODULE_LICENSE("GPL");
diff --git a/sound/soc/at32/at32-ssc.h b/sound/soc/at32/at32-ssc.h
deleted file mode 100644
index 3c052db..0000000
--- a/sound/soc/at32/at32-ssc.h
+++ /dev/null
@@ -1,59 +0,0 @@
-/* sound/soc/at32/at32-ssc.h
- * ASoC SSC interface for Atmel AT32 SoC
- *
- * Copyright (C) 2008 Long Range Systems
- *    Geoffrey Wossum <gwossum@acm.org>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef __SOUND_SOC_AT32_AT32_SSC_H
-#define __SOUND_SOC_AT32_AT32_SSC_H __FILE__
-
-#include <linux/types.h>
-#include <linux/atmel-ssc.h>
-
-#include "at32-pcm.h"
-
-
-
-struct at32_ssc_state {
-	u32 ssc_cmr;
-	u32 ssc_rcmr;
-	u32 ssc_rfmr;
-	u32 ssc_tcmr;
-	u32 ssc_tfmr;
-	u32 ssc_sr;
-	u32 ssc_imr;
-};
-
-
-
-struct at32_ssc_info {
-	char *name;
-	struct ssc_device *ssc;
-	spinlock_t lock;	/* lock for dir_mask */
-	unsigned short dir_mask;	/* 0=unused, 1=playback, 2=capture */
-	unsigned short initialized;	/* true if SSC has been initialized */
-	unsigned short daifmt;
-	unsigned short cmr_div;
-	unsigned short tcmr_period;
-	unsigned short rcmr_period;
-	struct at32_pcm_dma_params *dma_params[2];
-	struct at32_ssc_state ssc_state;
-};
-
-
-/* SSC divider ids */
-#define AT32_SSC_CMR_DIV        0	/* MCK divider for BCLK */
-#define AT32_SSC_TCMR_PERIOD    1	/* BCLK divider for transmit FS */
-#define AT32_SSC_RCMR_PERIOD    2	/* BCLK divider for receive FS */
-
-
-extern struct snd_soc_dai at32_ssc_dai[];
-
-
-
-#endif /* __SOUND_SOC_AT32_AT32_SSC_H */
diff --git a/sound/soc/at91/Kconfig b/sound/soc/at91/Kconfig
deleted file mode 100644
index 85a8832..0000000
--- a/sound/soc/at91/Kconfig
+++ /dev/null
@@ -1,10 +0,0 @@
-config SND_AT91_SOC
-	tristate "SoC Audio for the Atmel AT91 System-on-Chip"
-	depends on ARCH_AT91
-	help
-	  Say Y or M if you want to add support for codecs attached to
-	  the AT91 SSC interface. You will also need
-	  to select the audio interfaces to support below.
-
-config SND_AT91_SOC_SSC
-	tristate
diff --git a/sound/soc/at91/Makefile b/sound/soc/at91/Makefile
deleted file mode 100644
index b817f11..0000000
--- a/sound/soc/at91/Makefile
+++ /dev/null
@@ -1,6 +0,0 @@
-# AT91 Platform Support
-snd-soc-at91-objs := at91-pcm.o
-snd-soc-at91-ssc-objs := at91-ssc.o
-
-obj-$(CONFIG_SND_AT91_SOC) += snd-soc-at91.o
-obj-$(CONFIG_SND_AT91_SOC_SSC) += snd-soc-at91-ssc.o
diff --git a/sound/soc/at91/at91-pcm.c b/sound/soc/at91/at91-pcm.c
deleted file mode 100644
index 7ab48bd..0000000
--- a/sound/soc/at91/at91-pcm.c
+++ /dev/null
@@ -1,434 +0,0 @@
-/*
- * at91-pcm.c -- ALSA PCM interface for the Atmel AT91 SoC
- *
- * Author:	Frank Mandarino <fmandarino@endrelia.com>
- *		Endrelia Technologies Inc.
- * Created:	Mar 3, 2006
- *
- * Based on pxa2xx-pcm.c by:
- *
- * Author:	Nicolas Pitre
- * Created:	Nov 30, 2004
- * Copyright:	(C) 2004 MontaVista Software, Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/slab.h>
-#include <linux/dma-mapping.h>
-#include <linux/atmel_pdc.h>
-
-#include <sound/core.h>
-#include <sound/pcm.h>
-#include <sound/pcm_params.h>
-#include <sound/soc.h>
-
-#include <mach/hardware.h>
-#include <mach/at91_ssc.h>
-
-#include "at91-pcm.h"
-
-#if 0
-#define	DBG(x...)	printk(KERN_INFO "at91-pcm: " x)
-#else
-#define	DBG(x...)
-#endif
-
-static const struct snd_pcm_hardware at91_pcm_hardware = {
-	.info			= SNDRV_PCM_INFO_MMAP |
-				  SNDRV_PCM_INFO_MMAP_VALID |
-				  SNDRV_PCM_INFO_INTERLEAVED |
-				  SNDRV_PCM_INFO_PAUSE,
-	.formats		= SNDRV_PCM_FMTBIT_S16_LE,
-	.period_bytes_min	= 32,
-	.period_bytes_max	= 8192,
-	.periods_min		= 2,
-	.periods_max		= 1024,
-	.buffer_bytes_max	= 32 * 1024,
-};
-
-struct at91_runtime_data {
-	struct at91_pcm_dma_params *params;
-	dma_addr_t dma_buffer;			/* physical address of dma buffer */
-	dma_addr_t dma_buffer_end;		/* first address beyond DMA buffer */
-	size_t period_size;
-	dma_addr_t period_ptr;			/* physical address of next period */
-	u32 pdc_xpr_save;			/* PDC register save */
-	u32 pdc_xcr_save;
-	u32 pdc_xnpr_save;
-	u32 pdc_xncr_save;
-};
-
-static void at91_pcm_dma_irq(u32 ssc_sr,
-	struct snd_pcm_substream *substream)
-{
-	struct at91_runtime_data *prtd = substream->runtime->private_data;
-	struct at91_pcm_dma_params *params = prtd->params;
-	static int count = 0;
-
-	count++;
-
-	if (ssc_sr & params->mask->ssc_endbuf) {
-
-		printk(KERN_WARNING
-			"at91-pcm: buffer %s on %s (SSC_SR=%#x, count=%d)\n",
-			substream->stream == SNDRV_PCM_STREAM_PLAYBACK
-				? "underrun" : "overrun",
-			params->name, ssc_sr, count);
-
-		/* re-start the PDC */
-		at91_ssc_write(params->ssc_base + ATMEL_PDC_PTCR, params->mask->pdc_disable);
-
-		prtd->period_ptr += prtd->period_size;
-		if (prtd->period_ptr >= prtd->dma_buffer_end) {
-			prtd->period_ptr = prtd->dma_buffer;
-		}
-
-		at91_ssc_write(params->ssc_base + params->pdc->xpr, prtd->period_ptr);
-		at91_ssc_write(params->ssc_base + params->pdc->xcr,
-				prtd->period_size / params->pdc_xfer_size);
-
-		at91_ssc_write(params->ssc_base + ATMEL_PDC_PTCR, params->mask->pdc_enable);
-	}
-
-	if (ssc_sr & params->mask->ssc_endx) {
-
-		/* Load the PDC next pointer and counter registers */
-		prtd->period_ptr += prtd->period_size;
-		if (prtd->period_ptr >= prtd->dma_buffer_end) {
-			prtd->period_ptr = prtd->dma_buffer;
-		}
-		at91_ssc_write(params->ssc_base + params->pdc->xnpr,
-			       prtd->period_ptr);
-		at91_ssc_write(params->ssc_base + params->pdc->xncr,
-				prtd->period_size / params->pdc_xfer_size);
-	}
-
-	snd_pcm_period_elapsed(substream);
-}
-
-static int at91_pcm_hw_params(struct snd_pcm_substream *substream,
-	struct snd_pcm_hw_params *params)
-{
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct at91_runtime_data *prtd = runtime->private_data;
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-
-	/* this may get called several times by oss emulation
-	 * with different params */
-
-	snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);
-	runtime->dma_bytes = params_buffer_bytes(params);
-
-	prtd->params = rtd->dai->cpu_dai->dma_data;
-	prtd->params->dma_intr_handler = at91_pcm_dma_irq;
-
-	prtd->dma_buffer = runtime->dma_addr;
-	prtd->dma_buffer_end = runtime->dma_addr + runtime->dma_bytes;
-	prtd->period_size = params_period_bytes(params);
-
-	DBG("hw_params: DMA for %s initialized (dma_bytes=%d, period_size=%d)\n",
-		prtd->params->name, runtime->dma_bytes, prtd->period_size);
-	return 0;
-}
-
-static int at91_pcm_hw_free(struct snd_pcm_substream *substream)
-{
-	struct at91_runtime_data *prtd = substream->runtime->private_data;
-	struct at91_pcm_dma_params *params = prtd->params;
-
-	if (params != NULL) {
-		at91_ssc_write(params->ssc_base + ATMEL_PDC_PTCR, params->mask->pdc_disable);
-		prtd->params->dma_intr_handler = NULL;
-	}
-
-	return 0;
-}
-
-static int at91_pcm_prepare(struct snd_pcm_substream *substream)
-{
-	struct at91_runtime_data *prtd = substream->runtime->private_data;
-	struct at91_pcm_dma_params *params = prtd->params;
-
-	at91_ssc_write(params->ssc_base + AT91_SSC_IDR,
-			params->mask->ssc_endx | params->mask->ssc_endbuf);
-
-	at91_ssc_write(params->ssc_base + ATMEL_PDC_PTCR, params->mask->pdc_disable);
-	return 0;
-}
-
-static int at91_pcm_trigger(struct snd_pcm_substream *substream,
-	int cmd)
-{
-	struct at91_runtime_data *prtd = substream->runtime->private_data;
-	struct at91_pcm_dma_params *params = prtd->params;
-	int ret = 0;
-
-	switch (cmd) {
-	case SNDRV_PCM_TRIGGER_START:
-		prtd->period_ptr = prtd->dma_buffer;
-
-		at91_ssc_write(params->ssc_base + params->pdc->xpr, prtd->period_ptr);
-		at91_ssc_write(params->ssc_base + params->pdc->xcr,
-				prtd->period_size / params->pdc_xfer_size);
-
-		prtd->period_ptr += prtd->period_size;
-		at91_ssc_write(params->ssc_base + params->pdc->xnpr, prtd->period_ptr);
-		at91_ssc_write(params->ssc_base + params->pdc->xncr,
-				prtd->period_size / params->pdc_xfer_size);
-
-		DBG("trigger: period_ptr=%lx, xpr=%lx, xcr=%ld, xnpr=%lx, xncr=%ld\n",
-			(unsigned long) prtd->period_ptr,
-			at91_ssc_read(params->ssc_base + params->pdc->xpr),
-			at91_ssc_read(params->ssc_base + params->pdc->xcr),
-			at91_ssc_read(params->ssc_base + params->pdc->xnpr),
-			at91_ssc_read(params->ssc_base + params->pdc->xncr));
-
-		at91_ssc_write(params->ssc_base + AT91_SSC_IER,
-			params->mask->ssc_endx | params->mask->ssc_endbuf);
-
-		at91_ssc_write(params->ssc_base + ATMEL_PDC_PTCR,
-			params->mask->pdc_enable);
-
-		DBG("sr=%lx imr=%lx\n",
-		    at91_ssc_read(params->ssc_base + AT91_SSC_SR),
-		    at91_ssc_read(params->ssc_base + AT91_SSC_IMR));
-		break;
-
-	case SNDRV_PCM_TRIGGER_STOP:
-	case SNDRV_PCM_TRIGGER_SUSPEND:
-	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		at91_ssc_write(params->ssc_base + ATMEL_PDC_PTCR, params->mask->pdc_disable);
-		break;
-
-	case SNDRV_PCM_TRIGGER_RESUME:
-	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		at91_ssc_write(params->ssc_base + ATMEL_PDC_PTCR, params->mask->pdc_enable);
-		break;
-
-	default:
-		ret = -EINVAL;
-	}
-
-	return ret;
-}
-
-static snd_pcm_uframes_t at91_pcm_pointer(
-	struct snd_pcm_substream *substream)
-{
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct at91_runtime_data *prtd = runtime->private_data;
-	struct at91_pcm_dma_params *params = prtd->params;
-	dma_addr_t ptr;
-	snd_pcm_uframes_t x;
-
-	ptr = (dma_addr_t) at91_ssc_read(params->ssc_base + params->pdc->xpr);
-	x = bytes_to_frames(runtime, ptr - prtd->dma_buffer);
-
-	if (x == runtime->buffer_size)
-		x = 0;
-	return x;
-}
-
-static int at91_pcm_open(struct snd_pcm_substream *substream)
-{
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct at91_runtime_data *prtd;
-	int ret = 0;
-
-	snd_soc_set_runtime_hwparams(substream, &at91_pcm_hardware);
-
-	/* ensure that buffer size is a multiple of period size */
-	ret = snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS);
-	if (ret < 0)
-		goto out;
-
-	prtd = kzalloc(sizeof(struct at91_runtime_data), GFP_KERNEL);
-	if (prtd == NULL) {
-		ret = -ENOMEM;
-		goto out;
-	}
-	runtime->private_data = prtd;
-
- out:
-	return ret;
-}
-
-static int at91_pcm_close(struct snd_pcm_substream *substream)
-{
-	struct at91_runtime_data *prtd = substream->runtime->private_data;
-
-	kfree(prtd);
-	return 0;
-}
-
-static int at91_pcm_mmap(struct snd_pcm_substream *substream,
-	struct vm_area_struct *vma)
-{
-	struct snd_pcm_runtime *runtime = substream->runtime;
-
-	return dma_mmap_writecombine(substream->pcm->card->dev, vma,
-				     runtime->dma_area,
-				     runtime->dma_addr,
-				     runtime->dma_bytes);
-}
-
-struct snd_pcm_ops at91_pcm_ops = {
-	.open		= at91_pcm_open,
-	.close		= at91_pcm_close,
-	.ioctl		= snd_pcm_lib_ioctl,
-	.hw_params	= at91_pcm_hw_params,
-	.hw_free	= at91_pcm_hw_free,
-	.prepare	= at91_pcm_prepare,
-	.trigger	= at91_pcm_trigger,
-	.pointer	= at91_pcm_pointer,
-	.mmap		= at91_pcm_mmap,
-};
-
-static int at91_pcm_preallocate_dma_buffer(struct snd_pcm *pcm,
-	int stream)
-{
-	struct snd_pcm_substream *substream = pcm->streams[stream].substream;
-	struct snd_dma_buffer *buf = &substream->dma_buffer;
-	size_t size = at91_pcm_hardware.buffer_bytes_max;
-
-	buf->dev.type = SNDRV_DMA_TYPE_DEV;
-	buf->dev.dev = pcm->card->dev;
-	buf->private_data = NULL;
-	buf->area = dma_alloc_writecombine(pcm->card->dev, size,
-					   &buf->addr, GFP_KERNEL);
-
-	DBG("preallocate_dma_buffer: area=%p, addr=%p, size=%d\n",
-		(void *) buf->area,
-		(void *) buf->addr,
-		size);
-
-	if (!buf->area)
-		return -ENOMEM;
-
-	buf->bytes = size;
-	return 0;
-}
-
-static u64 at91_pcm_dmamask = 0xffffffff;
-
-static int at91_pcm_new(struct snd_card *card,
-	struct snd_soc_dai *dai, struct snd_pcm *pcm)
-{
-	int ret = 0;
-
-	if (!card->dev->dma_mask)
-		card->dev->dma_mask = &at91_pcm_dmamask;
-	if (!card->dev->coherent_dma_mask)
-		card->dev->coherent_dma_mask = 0xffffffff;
-
-	if (dai->playback.channels_min) {
-		ret = at91_pcm_preallocate_dma_buffer(pcm,
-			SNDRV_PCM_STREAM_PLAYBACK);
-		if (ret)
-			goto out;
-	}
-
-	if (dai->capture.channels_min) {
-		ret = at91_pcm_preallocate_dma_buffer(pcm,
-			SNDRV_PCM_STREAM_CAPTURE);
-		if (ret)
-			goto out;
-	}
- out:
-	return ret;
-}
-
-static void at91_pcm_free_dma_buffers(struct snd_pcm *pcm)
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
-
-		dma_free_writecombine(pcm->card->dev, buf->bytes,
-				      buf->area, buf->addr);
-		buf->area = NULL;
-	}
-}
-
-#ifdef CONFIG_PM
-static int at91_pcm_suspend(struct platform_device *pdev,
-	struct snd_soc_dai *dai)
-{
-	struct snd_pcm_runtime *runtime = dai->runtime;
-	struct at91_runtime_data *prtd;
-	struct at91_pcm_dma_params *params;
-
-	if (!runtime)
-		return 0;
-
-	prtd = runtime->private_data;
-	params = prtd->params;
-
-	/* disable the PDC and save the PDC registers */
-
-	at91_ssc_write(params->ssc_base + ATMEL_PDC_PTCR, params->mask->pdc_disable);
-
-	prtd->pdc_xpr_save  = at91_ssc_read(params->ssc_base + params->pdc->xpr);
-	prtd->pdc_xcr_save  = at91_ssc_read(params->ssc_base + params->pdc->xcr);
-	prtd->pdc_xnpr_save = at91_ssc_read(params->ssc_base + params->pdc->xnpr);
-	prtd->pdc_xncr_save = at91_ssc_read(params->ssc_base + params->pdc->xncr);
-
-	return 0;
-}
-
-static int at91_pcm_resume(struct platform_device *pdev,
-	struct snd_soc_dai *dai)
-{
-	struct snd_pcm_runtime *runtime = dai->runtime;
-	struct at91_runtime_data *prtd;
-	struct at91_pcm_dma_params *params;
-
-	if (!runtime)
-		return 0;
-
-	prtd = runtime->private_data;
-	params = prtd->params;
-
-	/* restore the PDC registers and enable the PDC */
-	at91_ssc_write(params->ssc_base + params->pdc->xpr,  prtd->pdc_xpr_save);
-	at91_ssc_write(params->ssc_base + params->pdc->xcr,  prtd->pdc_xcr_save);
-	at91_ssc_write(params->ssc_base + params->pdc->xnpr, prtd->pdc_xnpr_save);
-	at91_ssc_write(params->ssc_base + params->pdc->xncr, prtd->pdc_xncr_save);
-
-	at91_ssc_write(params->ssc_base + ATMEL_PDC_PTCR, params->mask->pdc_enable);
-	return 0;
-}
-#else
-#define at91_pcm_suspend	NULL
-#define at91_pcm_resume		NULL
-#endif
-
-struct snd_soc_platform at91_soc_platform = {
-	.name		= "at91-audio",
-	.pcm_ops 	= &at91_pcm_ops,
-	.pcm_new	= at91_pcm_new,
-	.pcm_free	= at91_pcm_free_dma_buffers,
-	.suspend	= at91_pcm_suspend,
-	.resume		= at91_pcm_resume,
-};
-
-EXPORT_SYMBOL_GPL(at91_soc_platform);
-
-MODULE_AUTHOR("Frank Mandarino <fmandarino@endrelia.com>");
-MODULE_DESCRIPTION("Atmel AT91 PCM module");
-MODULE_LICENSE("GPL");
diff --git a/sound/soc/at91/at91-pcm.h b/sound/soc/at91/at91-pcm.h
deleted file mode 100644
index e5aada2..0000000
--- a/sound/soc/at91/at91-pcm.h
+++ /dev/null
@@ -1,72 +0,0 @@
-/*
- * at91-pcm.h - ALSA PCM interface for the Atmel AT91 SoC
- *
- * Author:	Frank Mandarino <fmandarino@endrelia.com>
- *		Endrelia Technologies Inc.
- * Created:	Mar 3, 2006
- *
- * Based on pxa2xx-pcm.h by:
- *
- * Author:	Nicolas Pitre
- * Created:	Nov 30, 2004
- * Copyright:	MontaVista Software, Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef _AT91_PCM_H
-#define _AT91_PCM_H
-
-#include <mach/hardware.h>
-
-struct at91_ssc_periph {
-	void __iomem	*base;
-	u32		pid;
-};
-
-/*
- * Registers and status bits that are required by the PCM driver.
- */
-struct at91_pdc_regs {
-	unsigned int	xpr;		/* PDC recv/trans pointer */
-	unsigned int	xcr;		/* PDC recv/trans counter */
-	unsigned int	xnpr;		/* PDC next recv/trans pointer */
-	unsigned int	xncr;		/* PDC next recv/trans counter */
-	unsigned int	ptcr;		/* PDC transfer control */
-};
-
-struct at91_ssc_mask {
-	u32	ssc_enable;		/* SSC recv/trans enable */
-	u32	ssc_disable;		/* SSC recv/trans disable */
-	u32	ssc_endx;		/* SSC ENDTX or ENDRX */
-	u32	ssc_endbuf;		/* SSC TXBUFE or RXBUFF */
-	u32	pdc_enable;		/* PDC recv/trans enable */
-	u32	pdc_disable;		/* PDC recv/trans disable */
-};
-
-/*
- * This structure, shared between the PCM driver and the interface,
- * contains all information required by the PCM driver to perform the
- * PDC DMA operation.  All fields except dma_intr_handler() are initialized
- * by the interface.  The dms_intr_handler() pointer is set by the PCM
- * driver and called by the interface SSC interrupt handler if it is
- * non-NULL.
- */
-struct at91_pcm_dma_params {
-	char *name;			/* stream identifier */
-	int pdc_xfer_size;		/* PDC counter increment in bytes */
-	void __iomem *ssc_base;		/* SSC base address */
-	struct at91_pdc_regs *pdc; /* PDC receive or transmit registers */
-	struct at91_ssc_mask *mask;/* SSC & PDC status bits */
-	struct snd_pcm_substream *substream;
-	void (*dma_intr_handler)(u32, struct snd_pcm_substream *);
-};
-
-extern struct snd_soc_platform at91_soc_platform;
-
-#define at91_ssc_read(a)	((unsigned long) __raw_readl(a))
-#define at91_ssc_write(a,v)	__raw_writel((v),(a))
-
-#endif /* _AT91_PCM_H */
diff --git a/sound/soc/at91/at91-ssc.c b/sound/soc/at91/at91-ssc.c
deleted file mode 100644
index 1b61cc4..0000000
--- a/sound/soc/at91/at91-ssc.c
+++ /dev/null
@@ -1,791 +0,0 @@
-/*
- * at91-ssc.c  --  ALSA SoC AT91 SSC Audio Layer Platform driver
- *
- * Author: Frank Mandarino <fmandarino@endrelia.com>
- *         Endrelia Technologies Inc.
- *
- * Based on pxa2xx Platform drivers by
- * Liam Girdwood <lrg@slimlogic.co.uk>
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- */
-
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/interrupt.h>
-#include <linux/device.h>
-#include <linux/delay.h>
-#include <linux/clk.h>
-#include <linux/atmel_pdc.h>
-
-#include <sound/core.h>
-#include <sound/pcm.h>
-#include <sound/pcm_params.h>
-#include <sound/initval.h>
-#include <sound/soc.h>
-
-#include <mach/hardware.h>
-#include <mach/at91_pmc.h>
-#include <mach/at91_ssc.h>
-
-#include "at91-pcm.h"
-#include "at91-ssc.h"
-
-#if 0
-#define	DBG(x...)	printk(KERN_DEBUG "at91-ssc:" x)
-#else
-#define	DBG(x...)
-#endif
-
-#if defined(CONFIG_ARCH_AT91SAM9260) || defined(CONFIG_ARCH_AT91SAM9G20)
-#define NUM_SSC_DEVICES		1
-#else
-#define NUM_SSC_DEVICES		3
-#endif
-
-
-/*
- * SSC PDC registers required by the PCM DMA engine.
- */
-static struct at91_pdc_regs pdc_tx_reg = {
-	.xpr		= ATMEL_PDC_TPR,
-	.xcr		= ATMEL_PDC_TCR,
-	.xnpr		= ATMEL_PDC_TNPR,
-	.xncr		= ATMEL_PDC_TNCR,
-};
-
-static struct at91_pdc_regs pdc_rx_reg = {
-	.xpr		= ATMEL_PDC_RPR,
-	.xcr		= ATMEL_PDC_RCR,
-	.xnpr		= ATMEL_PDC_RNPR,
-	.xncr		= ATMEL_PDC_RNCR,
-};
-
-/*
- * SSC & PDC status bits for transmit and receive.
- */
-static struct at91_ssc_mask ssc_tx_mask = {
-	.ssc_enable	= AT91_SSC_TXEN,
-	.ssc_disable	= AT91_SSC_TXDIS,
-	.ssc_endx	= AT91_SSC_ENDTX,
-	.ssc_endbuf	= AT91_SSC_TXBUFE,
-	.pdc_enable	= ATMEL_PDC_TXTEN,
-	.pdc_disable	= ATMEL_PDC_TXTDIS,
-};
-
-static struct at91_ssc_mask ssc_rx_mask = {
-	.ssc_enable	= AT91_SSC_RXEN,
-	.ssc_disable	= AT91_SSC_RXDIS,
-	.ssc_endx	= AT91_SSC_ENDRX,
-	.ssc_endbuf	= AT91_SSC_RXBUFF,
-	.pdc_enable	= ATMEL_PDC_RXTEN,
-	.pdc_disable	= ATMEL_PDC_RXTDIS,
-};
-
-
-/*
- * DMA parameters.
- */
-static struct at91_pcm_dma_params ssc_dma_params[NUM_SSC_DEVICES][2] = {
-	{{
-	.name		= "SSC0 PCM out",
-	.pdc		= &pdc_tx_reg,
-	.mask		= &ssc_tx_mask,
-	},
-	{
-	.name		= "SSC0 PCM in",
-	.pdc		= &pdc_rx_reg,
-	.mask		= &ssc_rx_mask,
-	}},
-#if NUM_SSC_DEVICES == 3
-	{{
-	.name		= "SSC1 PCM out",
-	.pdc		= &pdc_tx_reg,
-	.mask		= &ssc_tx_mask,
-	},
-	{
-	.name		= "SSC1 PCM in",
-	.pdc		= &pdc_rx_reg,
-	.mask		= &ssc_rx_mask,
-	}},
-	{{
-	.name		= "SSC2 PCM out",
-	.pdc		= &pdc_tx_reg,
-	.mask		= &ssc_tx_mask,
-	},
-	{
-	.name		= "SSC2 PCM in",
-	.pdc		= &pdc_rx_reg,
-	.mask		= &ssc_rx_mask,
-	}},
-#endif
-};
-
-struct at91_ssc_state {
-	u32	ssc_cmr;
-	u32	ssc_rcmr;
-	u32	ssc_rfmr;
-	u32	ssc_tcmr;
-	u32	ssc_tfmr;
-	u32	ssc_sr;
-	u32	ssc_imr;
-};
-
-static struct at91_ssc_info {
-	char		*name;
-	struct at91_ssc_periph ssc;
-	spinlock_t 	lock;		/* lock for dir_mask */
-	unsigned short	dir_mask;	/* 0=unused, 1=playback, 2=capture */
-	unsigned short	initialized;	/* 1=SSC has been initialized */
-	unsigned short	daifmt;
-	unsigned short	cmr_div;
-	unsigned short	tcmr_period;
-	unsigned short	rcmr_period;
-	struct at91_pcm_dma_params *dma_params[2];
-	struct at91_ssc_state ssc_state;
-
-} ssc_info[NUM_SSC_DEVICES] = {
-	{
-	.name		= "ssc0",
-	.lock		= __SPIN_LOCK_UNLOCKED(ssc_info[0].lock),
-	.dir_mask	= 0,
-	.initialized	= 0,
-	},
-#if NUM_SSC_DEVICES == 3
-	{
-	.name		= "ssc1",
-	.lock		= __SPIN_LOCK_UNLOCKED(ssc_info[1].lock),
-	.dir_mask	= 0,
-	.initialized	= 0,
-	},
-	{
-	.name		= "ssc2",
-	.lock		= __SPIN_LOCK_UNLOCKED(ssc_info[2].lock),
-	.dir_mask	= 0,
-	.initialized	= 0,
-	},
-#endif
-};
-
-static unsigned int at91_ssc_sysclk;
-
-/*
- * SSC interrupt handler.  Passes PDC interrupts to the DMA
- * interrupt handler in the PCM driver.
- */
-static irqreturn_t at91_ssc_interrupt(int irq, void *dev_id)
-{
-	struct at91_ssc_info *ssc_p = dev_id;
-	struct at91_pcm_dma_params *dma_params;
-	u32 ssc_sr;
-	int i;
-
-	ssc_sr = at91_ssc_read(ssc_p->ssc.base + AT91_SSC_SR)
-			& at91_ssc_read(ssc_p->ssc.base + AT91_SSC_IMR);
-
-	/*
-	 * Loop through the substreams attached to this SSC.  If
-	 * a DMA-related interrupt occurred on that substream, call
-	 * the DMA interrupt handler function, if one has been
-	 * registered in the dma_params structure by the PCM driver.
-	 */
-	for (i = 0; i < ARRAY_SIZE(ssc_p->dma_params); i++) {
-		dma_params = ssc_p->dma_params[i];
-
-		if (dma_params != NULL && dma_params->dma_intr_handler != NULL &&
-			(ssc_sr &
-			(dma_params->mask->ssc_endx | dma_params->mask->ssc_endbuf)))
-
-			dma_params->dma_intr_handler(ssc_sr, dma_params->substream);
-	}
-
-	return IRQ_HANDLED;
-}
-
-/*
- * Startup.  Only that one substream allowed in each direction.
- */
-static int at91_ssc_startup(struct snd_pcm_substream *substream)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct at91_ssc_info *ssc_p = &ssc_info[rtd->dai->cpu_dai->id];
-	int dir_mask;
-
-	DBG("ssc_startup: SSC_SR=0x%08lx\n",
-			at91_ssc_read(ssc_p->ssc.base + AT91_SSC_SR));
-	dir_mask = substream->stream == SNDRV_PCM_STREAM_PLAYBACK ? 0x1 : 0x2;
-
-	spin_lock_irq(&ssc_p->lock);
-	if (ssc_p->dir_mask & dir_mask) {
-		spin_unlock_irq(&ssc_p->lock);
-		return -EBUSY;
-	}
-	ssc_p->dir_mask |= dir_mask;
-	spin_unlock_irq(&ssc_p->lock);
-
-	return 0;
-}
-
-/*
- * Shutdown.  Clear DMA parameters and shutdown the SSC if there
- * are no other substreams open.
- */
-static void at91_ssc_shutdown(struct snd_pcm_substream *substream)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct at91_ssc_info *ssc_p = &ssc_info[rtd->dai->cpu_dai->id];
-	struct at91_pcm_dma_params *dma_params;
-	int dir, dir_mask;
-
-	dir = substream->stream == SNDRV_PCM_STREAM_PLAYBACK ? 0 : 1;
-	dma_params = ssc_p->dma_params[dir];
-
-	if (dma_params != NULL) {
-		at91_ssc_write(dma_params->ssc_base + AT91_SSC_CR,
-				dma_params->mask->ssc_disable);
-		DBG("%s disabled SSC_SR=0x%08lx\n", (dir ? "receive" : "transmit"),
-			at91_ssc_read(ssc_p->ssc.base + AT91_SSC_SR));
-
-		dma_params->ssc_base = NULL;
-		dma_params->substream = NULL;
-		ssc_p->dma_params[dir] = NULL;
-	}
-
-	dir_mask = 1 << dir;
-
-	spin_lock_irq(&ssc_p->lock);
-	ssc_p->dir_mask &= ~dir_mask;
-	if (!ssc_p->dir_mask) {
-		/* Shutdown the SSC clock. */
-		DBG("Stopping pid %d clock\n", ssc_p->ssc.pid);
-		at91_sys_write(AT91_PMC_PCDR, 1<<ssc_p->ssc.pid);
-
-		if (ssc_p->initialized) {
-			free_irq(ssc_p->ssc.pid, ssc_p);
-			ssc_p->initialized = 0;
-		}
-
-		/* Reset the SSC */
-		at91_ssc_write(ssc_p->ssc.base + AT91_SSC_CR, AT91_SSC_SWRST);
-
-		/* Clear the SSC dividers */
-		ssc_p->cmr_div = ssc_p->tcmr_period = ssc_p->rcmr_period = 0;
-	}
-	spin_unlock_irq(&ssc_p->lock);
-}
-
-/*
- * Record the SSC system clock rate.
- */
-static int at91_ssc_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
-		int clk_id, unsigned int freq, int dir)
-{
-	/*
-	 * The only clock supplied to the SSC is the AT91 master clock,
-	 * which is only used if the SSC is generating BCLK and/or
-	 * LRC clocks.
-	 */
-	switch (clk_id) {
-	case AT91_SYSCLK_MCK:
-		at91_ssc_sysclk = freq;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-/*
- * Record the DAI format for use in hw_params().
- */
-static int at91_ssc_set_dai_fmt(struct snd_soc_dai *cpu_dai,
-		unsigned int fmt)
-{
-	struct at91_ssc_info *ssc_p = &ssc_info[cpu_dai->id];
-
-	ssc_p->daifmt = fmt;
-	return 0;
-}
-
-/*
- * Record SSC clock dividers for use in hw_params().
- */
-static int at91_ssc_set_dai_clkdiv(struct snd_soc_dai *cpu_dai,
-	int div_id, int div)
-{
-	struct at91_ssc_info *ssc_p = &ssc_info[cpu_dai->id];
-
-	switch (div_id) {
-	case AT91SSC_CMR_DIV:
-		/*
-		 * The same master clock divider is used for both
-		 * transmit and receive, so if a value has already
-		 * been set, it must match this value.
-		 */
-		if (ssc_p->cmr_div == 0)
-			ssc_p->cmr_div = div;
-		else
-			if (div != ssc_p->cmr_div)
-				return -EBUSY;
-		break;
-
-	case AT91SSC_TCMR_PERIOD:
-		ssc_p->tcmr_period = div;
-		break;
-
-	case AT91SSC_RCMR_PERIOD:
-		ssc_p->rcmr_period = div;
-		break;
-
-	default:
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-/*
- * Configure the SSC.
- */
-static int at91_ssc_hw_params(struct snd_pcm_substream *substream,
-	struct snd_pcm_hw_params *params)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	int id = rtd->dai->cpu_dai->id;
-	struct at91_ssc_info *ssc_p = &ssc_info[id];
-	struct at91_pcm_dma_params *dma_params;
-	int dir, channels, bits;
-	u32 tfmr, rfmr, tcmr, rcmr;
-	int start_event;
-	int ret;
-
-	/*
-	 * Currently, there is only one set of dma params for
-	 * each direction.  If more are added, this code will
-	 * have to be changed to select the proper set.
-	 */
-	dir = substream->stream == SNDRV_PCM_STREAM_PLAYBACK ? 0 : 1;
-
-	dma_params = &ssc_dma_params[id][dir];
-	dma_params->ssc_base = ssc_p->ssc.base;
-	dma_params->substream = substream;
-
-	ssc_p->dma_params[dir] = dma_params;
-
-	/*
-	 * The cpu_dai->dma_data field is only used to communicate the
-	 * appropriate DMA parameters to the pcm driver hw_params()
-	 * function.  It should not be used for other purposes
-	 * as it is common to all substreams.
-	 */
-	rtd->dai->cpu_dai->dma_data = dma_params;
-
-	channels = params_channels(params);
-
-	/*
-	 * Determine sample size in bits and the PDC increment.
-	 */
-	switch(params_format(params)) {
-	case SNDRV_PCM_FORMAT_S8:
-		bits = 8;
-		dma_params->pdc_xfer_size = 1;
-		break;
-	case SNDRV_PCM_FORMAT_S16_LE:
-		bits = 16;
-		dma_params->pdc_xfer_size = 2;
-		break;
-	case SNDRV_PCM_FORMAT_S24_LE:
-		bits = 24;
-		dma_params->pdc_xfer_size = 4;
-		break;
-	case SNDRV_PCM_FORMAT_S32_LE:
-		bits = 32;
-		dma_params->pdc_xfer_size = 4;
-		break;
-	default:
-		printk(KERN_WARNING "at91-ssc: unsupported PCM format\n");
-		return -EINVAL;
-	}
-
-	/*
-	 * The SSC only supports up to 16-bit samples in I2S format, due
-	 * to the size of the Frame Mode Register FSLEN field.
-	 */
-	if ((ssc_p->daifmt & SND_SOC_DAIFMT_FORMAT_MASK) == SND_SOC_DAIFMT_I2S
-		&& bits > 16) {
-		printk(KERN_WARNING
-			"at91-ssc: sample size %d is too large for I2S\n", bits);
-		return -EINVAL;
-	}
-
-	/*
-	 * Compute SSC register settings.
-	 */
-	switch (ssc_p->daifmt
-		& (SND_SOC_DAIFMT_FORMAT_MASK | SND_SOC_DAIFMT_MASTER_MASK)) {
-
-	case SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBS_CFS:
-		/*
-		 * I2S format, SSC provides BCLK and LRC clocks.
-		 *
-		 * The SSC transmit and receive clocks are generated from the
-		 * MCK divider, and the BCLK signal is output on the SSC TK line.
-		 */
-		rcmr =	  (( ssc_p->rcmr_period		<< 24) & AT91_SSC_PERIOD)
-			| (( 1				<< 16) & AT91_SSC_STTDLY)
-			| (( AT91_SSC_START_FALLING_RF	     ) & AT91_SSC_START)
-			| (( AT91_SSC_CK_RISING		     ) & AT91_SSC_CKI)
-			| (( AT91_SSC_CKO_NONE		     ) & AT91_SSC_CKO)
-			| (( AT91_SSC_CKS_DIV		     ) & AT91_SSC_CKS);
-
-		rfmr =	  (( AT91_SSC_FSEDGE_POSITIVE	     ) & AT91_SSC_FSEDGE)
-			| (( AT91_SSC_FSOS_NEGATIVE	     ) & AT91_SSC_FSOS)
-			| (((bits - 1)			<< 16) & AT91_SSC_FSLEN)
-			| (((channels - 1)		<<  8) & AT91_SSC_DATNB)
-			| (( 1				<<  7) & AT91_SSC_MSBF)
-			| (( 0				<<  5) & AT91_SSC_LOOP)
-			| (((bits - 1)			<<  0) & AT91_SSC_DATALEN);
-
-		tcmr =	  (( ssc_p->tcmr_period		<< 24) & AT91_SSC_PERIOD)
-			| (( 1				<< 16) & AT91_SSC_STTDLY)
-			| (( AT91_SSC_START_FALLING_RF       ) & AT91_SSC_START)
-			| (( AT91_SSC_CKI_FALLING	     ) & AT91_SSC_CKI)
-			| (( AT91_SSC_CKO_CONTINUOUS	     ) & AT91_SSC_CKO)
-			| (( AT91_SSC_CKS_DIV		     ) & AT91_SSC_CKS);
-
-		tfmr =	  (( AT91_SSC_FSEDGE_POSITIVE	     ) & AT91_SSC_FSEDGE)
-			| (( 0				<< 23) & AT91_SSC_FSDEN)
-			| (( AT91_SSC_FSOS_NEGATIVE	     ) & AT91_SSC_FSOS)
-			| (((bits - 1)			<< 16) & AT91_SSC_FSLEN)
-			| (((channels - 1)		<<  8) & AT91_SSC_DATNB)
-			| (( 1				<<  7) & AT91_SSC_MSBF)
-			| (( 0				<<  5) & AT91_SSC_DATDEF)
-			| (((bits - 1)			<<  0) & AT91_SSC_DATALEN);
-		break;
-
-	case SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBM_CFM:
-		/*
-		 * I2S format, CODEC supplies BCLK and LRC clocks.
-		 *
-		 * The SSC transmit clock is obtained from the BCLK signal on
-		 * on the TK line, and the SSC receive clock is generated from the
-		 * transmit clock.
-		 *
-		 * For single channel data, one sample is transferred on the falling
-		 * edge of the LRC clock.  For two channel data, one sample is
-		 * transferred on both edges of the LRC clock.
-		 */
-		start_event = channels == 1
-				? AT91_SSC_START_FALLING_RF
-				: AT91_SSC_START_EDGE_RF;
-
-		rcmr =	  (( 0				<< 24) & AT91_SSC_PERIOD)
-			| (( 1				<< 16) & AT91_SSC_STTDLY)
-			| (( start_event		     ) & AT91_SSC_START)
-			| (( AT91_SSC_CK_RISING		     ) & AT91_SSC_CKI)
-			| (( AT91_SSC_CKO_NONE		     ) & AT91_SSC_CKO)
-			| (( AT91_SSC_CKS_CLOCK		     ) & AT91_SSC_CKS);
-
-		rfmr =	  (( AT91_SSC_FSEDGE_POSITIVE	     ) & AT91_SSC_FSEDGE)
-			| (( AT91_SSC_FSOS_NONE		     ) & AT91_SSC_FSOS)
-			| (( 0				<< 16) & AT91_SSC_FSLEN)
-			| (( 0				<<  8) & AT91_SSC_DATNB)
-			| (( 1				<<  7) & AT91_SSC_MSBF)
-			| (( 0				<<  5) & AT91_SSC_LOOP)
-			| (((bits - 1)			<<  0) & AT91_SSC_DATALEN);
-
-		tcmr =	  (( 0				<< 24) & AT91_SSC_PERIOD)
-			| (( 1				<< 16) & AT91_SSC_STTDLY)
-			| (( start_event		     ) & AT91_SSC_START)
-			| (( AT91_SSC_CKI_FALLING	     ) & AT91_SSC_CKI)
-			| (( AT91_SSC_CKO_NONE		     ) & AT91_SSC_CKO)
-			| (( AT91_SSC_CKS_PIN		     ) & AT91_SSC_CKS);
-
-		tfmr =	  (( AT91_SSC_FSEDGE_POSITIVE	     ) & AT91_SSC_FSEDGE)
-			| (( 0				<< 23) & AT91_SSC_FSDEN)
-			| (( AT91_SSC_FSOS_NONE		     ) & AT91_SSC_FSOS)
-			| (( 0				<< 16) & AT91_SSC_FSLEN)
-			| (( 0				<<  8) & AT91_SSC_DATNB)
-			| (( 1				<<  7) & AT91_SSC_MSBF)
-			| (( 0				<<  5) & AT91_SSC_DATDEF)
-			| (((bits - 1)			<<  0) & AT91_SSC_DATALEN);
-		break;
-
-	case SND_SOC_DAIFMT_DSP_A | SND_SOC_DAIFMT_CBS_CFS:
-		/*
-		 * DSP/PCM Mode A format, SSC provides BCLK and LRC clocks.
-		 *
-		 * The SSC transmit and receive clocks are generated from the
-		 * MCK divider, and the BCLK signal is output on the SSC TK line.
-		 */
-		rcmr =	  (( ssc_p->rcmr_period		<< 24) & AT91_SSC_PERIOD)
-			| (( 1				<< 16) & AT91_SSC_STTDLY)
-			| (( AT91_SSC_START_RISING_RF	     ) & AT91_SSC_START)
-			| (( AT91_SSC_CK_RISING		     ) & AT91_SSC_CKI)
-			| (( AT91_SSC_CKO_NONE		     ) & AT91_SSC_CKO)
-			| (( AT91_SSC_CKS_DIV		     ) & AT91_SSC_CKS);
-
-		rfmr =	  (( AT91_SSC_FSEDGE_POSITIVE	     ) & AT91_SSC_FSEDGE)
-			| (( AT91_SSC_FSOS_POSITIVE	     ) & AT91_SSC_FSOS)
-			| (( 0				<< 16) & AT91_SSC_FSLEN)
-			| (((channels - 1)		<<  8) & AT91_SSC_DATNB)
-			| (( 1				<<  7) & AT91_SSC_MSBF)
-			| (( 0				<<  5) & AT91_SSC_LOOP)
-			| (((bits - 1)			<<  0) & AT91_SSC_DATALEN);
-
-		tcmr =	  (( ssc_p->tcmr_period		<< 24) & AT91_SSC_PERIOD)
-			| (( 1				<< 16) & AT91_SSC_STTDLY)
-			| (( AT91_SSC_START_RISING_RF        ) & AT91_SSC_START)
-			| (( AT91_SSC_CK_RISING		     ) & AT91_SSC_CKI)
-			| (( AT91_SSC_CKO_CONTINUOUS	     ) & AT91_SSC_CKO)
-			| (( AT91_SSC_CKS_DIV		     ) & AT91_SSC_CKS);
-
-		tfmr =	  (( AT91_SSC_FSEDGE_POSITIVE	     ) & AT91_SSC_FSEDGE)
-			| (( 0				<< 23) & AT91_SSC_FSDEN)
-			| (( AT91_SSC_FSOS_POSITIVE	     ) & AT91_SSC_FSOS)
-			| (( 0				<< 16) & AT91_SSC_FSLEN)
-			| (((channels - 1)		<<  8) & AT91_SSC_DATNB)
-			| (( 1				<<  7) & AT91_SSC_MSBF)
-			| (( 0				<<  5) & AT91_SSC_DATDEF)
-			| (((bits - 1)			<<  0) & AT91_SSC_DATALEN);
-
-
-
-			break;
-
-	case SND_SOC_DAIFMT_DSP_A | SND_SOC_DAIFMT_CBM_CFM:
-	default:
-		printk(KERN_WARNING "at91-ssc: unsupported DAI format 0x%x.\n",
-			ssc_p->daifmt);
-		return -EINVAL;
-		break;
-	}
-	DBG("RCMR=%08x RFMR=%08x TCMR=%08x TFMR=%08x\n", rcmr, rfmr, tcmr, tfmr);
-
-	if (!ssc_p->initialized) {
-
-		/* Enable PMC peripheral clock for this SSC */
-		DBG("Starting pid %d clock\n", ssc_p->ssc.pid);
-		at91_sys_write(AT91_PMC_PCER, 1<<ssc_p->ssc.pid);
-
-		/* Reset the SSC and its PDC registers */
-		at91_ssc_write(ssc_p->ssc.base + AT91_SSC_CR, AT91_SSC_SWRST);
-
-		at91_ssc_write(ssc_p->ssc.base + ATMEL_PDC_RPR, 0);
-		at91_ssc_write(ssc_p->ssc.base + ATMEL_PDC_RCR, 0);
-		at91_ssc_write(ssc_p->ssc.base + ATMEL_PDC_RNPR, 0);
-		at91_ssc_write(ssc_p->ssc.base + ATMEL_PDC_RNCR, 0);
-		at91_ssc_write(ssc_p->ssc.base + ATMEL_PDC_TPR, 0);
-		at91_ssc_write(ssc_p->ssc.base + ATMEL_PDC_TCR, 0);
-		at91_ssc_write(ssc_p->ssc.base + ATMEL_PDC_TNPR, 0);
-		at91_ssc_write(ssc_p->ssc.base + ATMEL_PDC_TNCR, 0);
-
-		if ((ret = request_irq(ssc_p->ssc.pid, at91_ssc_interrupt,
-					0, ssc_p->name, ssc_p)) < 0) {
-			printk(KERN_WARNING "at91-ssc: request_irq failure\n");
-
-			DBG("Stopping pid %d clock\n", ssc_p->ssc.pid);
-			at91_sys_write(AT91_PMC_PCDR, 1<<ssc_p->ssc.pid);
-			return ret;
-		}
-
-		ssc_p->initialized = 1;
-	}
-
-	/* set SSC clock mode register */
-	at91_ssc_write(ssc_p->ssc.base + AT91_SSC_CMR, ssc_p->cmr_div);
-
-	/* set receive clock mode and format */
-	at91_ssc_write(ssc_p->ssc.base + AT91_SSC_RCMR, rcmr);
-	at91_ssc_write(ssc_p->ssc.base + AT91_SSC_RFMR, rfmr);
-
-	/* set transmit clock mode and format */
-	at91_ssc_write(ssc_p->ssc.base + AT91_SSC_TCMR, tcmr);
-	at91_ssc_write(ssc_p->ssc.base + AT91_SSC_TFMR, tfmr);
-
-	DBG("hw_params: SSC initialized\n");
-	return 0;
-}
-
-
-static int at91_ssc_prepare(struct snd_pcm_substream *substream)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct at91_ssc_info *ssc_p = &ssc_info[rtd->dai->cpu_dai->id];
-	struct at91_pcm_dma_params *dma_params;
-	int dir;
-
-	dir = substream->stream == SNDRV_PCM_STREAM_PLAYBACK ? 0 : 1;
-	dma_params = ssc_p->dma_params[dir];
-
-	at91_ssc_write(dma_params->ssc_base + AT91_SSC_CR,
-			dma_params->mask->ssc_enable);
-
-	DBG("%s enabled SSC_SR=0x%08lx\n", dir ? "receive" : "transmit",
-		at91_ssc_read(dma_params->ssc_base + AT91_SSC_SR));
-	return 0;
-}
-
-
-#ifdef CONFIG_PM
-static int at91_ssc_suspend(struct platform_device *pdev,
-	struct snd_soc_dai *cpu_dai)
-{
-	struct at91_ssc_info *ssc_p;
-
-	if(!cpu_dai->active)
-		return 0;
-
-	ssc_p = &ssc_info[cpu_dai->id];
-
-	/* Save the status register before disabling transmit and receive. */
-	ssc_p->ssc_state.ssc_sr = at91_ssc_read(ssc_p->ssc.base + AT91_SSC_SR);
-	at91_ssc_write(ssc_p->ssc.base + AT91_SSC_CR,
-			AT91_SSC_TXDIS | AT91_SSC_RXDIS);
-
-	/* Save the current interrupt mask, then disable unmasked interrupts. */
-	ssc_p->ssc_state.ssc_imr = at91_ssc_read(ssc_p->ssc.base + AT91_SSC_IMR);
-	at91_ssc_write(ssc_p->ssc.base + AT91_SSC_IDR, ssc_p->ssc_state.ssc_imr);
-
-	ssc_p->ssc_state.ssc_cmr  = at91_ssc_read(ssc_p->ssc.base + AT91_SSC_CMR);
-	ssc_p->ssc_state.ssc_rcmr = at91_ssc_read(ssc_p->ssc.base + AT91_SSC_RCMR);
-	ssc_p->ssc_state.ssc_rfmr = at91_ssc_read(ssc_p->ssc.base + AT91_SSC_RFMR);
-	ssc_p->ssc_state.ssc_tcmr = at91_ssc_read(ssc_p->ssc.base + AT91_SSC_TCMR);
-	ssc_p->ssc_state.ssc_tfmr = at91_ssc_read(ssc_p->ssc.base + AT91_SSC_TFMR);
-
-	return 0;
-}
-
-static int at91_ssc_resume(struct platform_device *pdev,
-	struct snd_soc_dai *cpu_dai)
-{
-	struct at91_ssc_info *ssc_p;
-
-	if(!cpu_dai->active)
-		return 0;
-
-	ssc_p = &ssc_info[cpu_dai->id];
-
-	at91_ssc_write(ssc_p->ssc.base + AT91_SSC_TFMR, ssc_p->ssc_state.ssc_tfmr);
-	at91_ssc_write(ssc_p->ssc.base + AT91_SSC_TCMR, ssc_p->ssc_state.ssc_tcmr);
-	at91_ssc_write(ssc_p->ssc.base + AT91_SSC_RFMR, ssc_p->ssc_state.ssc_rfmr);
-	at91_ssc_write(ssc_p->ssc.base + AT91_SSC_RCMR, ssc_p->ssc_state.ssc_rcmr);
-	at91_ssc_write(ssc_p->ssc.base + AT91_SSC_CMR,  ssc_p->ssc_state.ssc_cmr);
-
-	at91_ssc_write(ssc_p->ssc.base + AT91_SSC_IER,  ssc_p->ssc_state.ssc_imr);
-
-	at91_ssc_write(ssc_p->ssc.base + AT91_SSC_CR,
-		((ssc_p->ssc_state.ssc_sr & AT91_SSC_RXENA) ? AT91_SSC_RXEN : 0) |
-		((ssc_p->ssc_state.ssc_sr & AT91_SSC_TXENA) ? AT91_SSC_TXEN : 0));
-
-	return 0;
-}
-
-#else
-#define at91_ssc_suspend	NULL
-#define at91_ssc_resume		NULL
-#endif
-
-#define AT91_SSC_RATES (SNDRV_PCM_RATE_8000  | SNDRV_PCM_RATE_11025 |\
-			SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_22050 |\
-			SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 |\
-			SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 |\
-			SNDRV_PCM_RATE_96000)
-
-#define AT91_SSC_FORMATS (SNDRV_PCM_FMTBIT_S8     | SNDRV_PCM_FMTBIT_S16_LE |\
-			  SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE)
-
-struct snd_soc_dai at91_ssc_dai[NUM_SSC_DEVICES] = {
-	{	.name = "at91-ssc0",
-		.id = 0,
-		.type = SND_SOC_DAI_PCM,
-		.suspend = at91_ssc_suspend,
-		.resume = at91_ssc_resume,
-		.playback = {
-			.channels_min = 1,
-			.channels_max = 2,
-			.rates = AT91_SSC_RATES,
-			.formats = AT91_SSC_FORMATS,},
-		.capture = {
-			.channels_min = 1,
-			.channels_max = 2,
-			.rates = AT91_SSC_RATES,
-			.formats = AT91_SSC_FORMATS,},
-		.ops = {
-			.startup = at91_ssc_startup,
-			.shutdown = at91_ssc_shutdown,
-			.prepare = at91_ssc_prepare,
-			.hw_params = at91_ssc_hw_params,},
-		.dai_ops = {
-			.set_sysclk = at91_ssc_set_dai_sysclk,
-			.set_fmt = at91_ssc_set_dai_fmt,
-			.set_clkdiv = at91_ssc_set_dai_clkdiv,},
-		.private_data = &ssc_info[0].ssc,
-	},
-#if NUM_SSC_DEVICES == 3
-	{	.name = "at91-ssc1",
-		.id = 1,
-		.type = SND_SOC_DAI_PCM,
-		.suspend = at91_ssc_suspend,
-		.resume = at91_ssc_resume,
-		.playback = {
-			.channels_min = 1,
-			.channels_max = 2,
-			.rates = AT91_SSC_RATES,
-			.formats = AT91_SSC_FORMATS,},
-		.capture = {
-			.channels_min = 1,
-			.channels_max = 2,
-			.rates = AT91_SSC_RATES,
-			.formats = AT91_SSC_FORMATS,},
-		.ops = {
-			.startup = at91_ssc_startup,
-			.shutdown = at91_ssc_shutdown,
-			.prepare = at91_ssc_prepare,
-			.hw_params = at91_ssc_hw_params,},
-		.dai_ops = {
-			.set_sysclk = at91_ssc_set_dai_sysclk,
-			.set_fmt = at91_ssc_set_dai_fmt,
-			.set_clkdiv = at91_ssc_set_dai_clkdiv,},
-		.private_data = &ssc_info[1].ssc,
-	},
-	{	.name = "at91-ssc2",
-		.id = 2,
-		.type = SND_SOC_DAI_PCM,
-		.suspend = at91_ssc_suspend,
-		.resume = at91_ssc_resume,
-		.playback = {
-			.channels_min = 1,
-			.channels_max = 2,
-			.rates = AT91_SSC_RATES,
-			.formats = AT91_SSC_FORMATS,},
-		.capture = {
-			.channels_min = 1,
-			.channels_max = 2,
-			.rates = AT91_SSC_RATES,
-			.formats = AT91_SSC_FORMATS,},
-		.ops = {
-			.startup = at91_ssc_startup,
-			.shutdown = at91_ssc_shutdown,
-			.prepare = at91_ssc_prepare,
-			.hw_params = at91_ssc_hw_params,},
-		.dai_ops = {
-			.set_sysclk = at91_ssc_set_dai_sysclk,
-			.set_fmt = at91_ssc_set_dai_fmt,
-			.set_clkdiv = at91_ssc_set_dai_clkdiv,},
-		.private_data = &ssc_info[2].ssc,
-	},
-#endif
-};
-
-EXPORT_SYMBOL_GPL(at91_ssc_dai);
-
-/* Module information */
-MODULE_AUTHOR("Frank Mandarino, fmandarino@endrelia.com, www.endrelia.com");
-MODULE_DESCRIPTION("AT91 SSC ASoC Interface");
-MODULE_LICENSE("GPL");
diff --git a/sound/soc/at91/at91-ssc.h b/sound/soc/at91/at91-ssc.h
deleted file mode 100644
index 6b7bf38..0000000
--- a/sound/soc/at91/at91-ssc.h
+++ /dev/null
@@ -1,27 +0,0 @@
-/*
- * at91-ssc.h - ALSA SSC interface for the Atmel AT91 SoC
- *
- * Author:	Frank Mandarino <fmandarino@endrelia.com>
- *		Endrelia Technologies Inc.
- * Created:	Jan 9, 2007
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef _AT91_SSC_H
-#define _AT91_SSC_H
-
-/* SSC system clock ids */
-#define AT91_SYSCLK_MCK		0 /* SSC uses AT91 MCK as system clock */
-
-/* SSC divider ids */
-#define AT91SSC_CMR_DIV		0 /* MCK divider for BCLK */
-#define AT91SSC_TCMR_PERIOD	1 /* BCLK divider for transmit FS */
-#define AT91SSC_RCMR_PERIOD	2 /* BCLK divider for receive FS */
-
-extern struct snd_soc_dai at91_ssc_dai[];
-
-#endif /* _AT91_SSC_H */
-
diff --git a/sound/soc/atmel/Kconfig b/sound/soc/atmel/Kconfig
new file mode 100644
index 0000000..a608d70
--- /dev/null
+++ b/sound/soc/atmel/Kconfig
@@ -0,0 +1,43 @@
+config SND_ATMEL_SOC
+	tristate "SoC Audio for the Atmel System-on-Chip"
+	depends on ARCH_AT91 || AVR32
+	help
+	  Say Y or M if you want to add support for codecs attached to
+	  the ATMEL SSC interface. You will also need
+	  to select the audio interfaces to support below.
+
+config SND_ATMEL_SOC_SSC
+	tristate
+	depends on SND_ATMEL_SOC
+	help
+	  Say Y or M if you want to add support for codecs the
+	  ATMEL SSC interface. You will also needs to select the individual
+	  machine drivers to support below.
+
+config SND_AT91_SOC_SAM9G20_WM8731
+	tristate "SoC Audio support for WM8731-based At91sam9g20 evaluation board"
+	depends on ATMEL_SSC && ARCH_AT91SAM9G20 && SND_ATMEL_SOC
+	select SND_ATMEL_SOC_SSC
+	select SND_SOC_WM8731
+	help
+	  Say Y if you want to add support for SoC audio on WM8731-based
+	  AT91sam9g20 evaluation board.
+
+config SND_AT32_SOC_PLAYPAQ
+        tristate "SoC Audio support for PlayPaq with WM8510"
+        depends on SND_ATMEL_SOC && BOARD_PLAYPAQ
+        select SND_ATMEL_SOC_SSC
+        select SND_SOC_WM8510
+        help
+          Say Y or M here if you want to add support for SoC audio
+          on the LRS PlayPaq.
+
+config SND_AT32_SOC_PLAYPAQ_SLAVE
+        bool "Run CODEC on PlayPaq in slave mode"
+        depends on SND_AT32_SOC_PLAYPAQ
+        default n
+        help
+          Say Y if you want to run with the AT32 SSC generating the BCLK
+          and FRAME signals on the PlayPaq.  Unless you want to play
+          with the AT32 as the SSC master, you probably want to say N here,
+          as this will give you better sound quality.
diff --git a/sound/soc/atmel/Makefile b/sound/soc/atmel/Makefile
new file mode 100644
index 0000000..f54a7cc
--- /dev/null
+++ b/sound/soc/atmel/Makefile
@@ -0,0 +1,15 @@
+# AT91 Platform Support
+snd-soc-atmel-pcm-objs := atmel-pcm.o
+snd-soc-atmel_ssc_dai-objs := atmel_ssc_dai.o
+
+obj-$(CONFIG_SND_ATMEL_SOC) += snd-soc-atmel-pcm.o
+obj-$(CONFIG_SND_ATMEL_SOC_SSC) += snd-soc-atmel_ssc_dai.o
+
+# AT91 Machine Support
+snd-soc-sam9g20-wm8731-objs := sam9g20_wm8731.o
+
+# AT32 Machine Support
+snd-soc-playpaq-objs := playpaq_wm8510.o
+
+obj-$(CONFIG_SND_AT91_SOC_SAM9G20_WM8731) += snd-soc-sam9g20-wm8731.o
+obj-$(CONFIG_SND_AT32_SOC_PLAYPAQ) += snd-soc-playpaq.o
diff --git a/sound/soc/at32/at32-pcm.c b/sound/soc/atmel/atmel-pcm.c
similarity index 50%
rename from sound/soc/at32/at32-pcm.c
rename to sound/soc/atmel/atmel-pcm.c
index c83584f..394412f 100644
--- a/sound/soc/at32/at32-pcm.c
+++ b/sound/soc/atmel/atmel-pcm.c
@@ -1,15 +1,34 @@
-/* sound/soc/at32/at32-pcm.c
- * ASoC PCM interface for Atmel AT32 SoC
+/*
+ * atmel-pcm.c  --  ALSA PCM interface for the Atmel atmel SoC.
  *
- * Copyright (C) 2008 Long Range Systems
- *    Geoffrey Wossum <gwossum@acm.org>
+ *  Copyright (C) 2005 SAN People
+ *  Copyright (C) 2008 Atmel
+ *
+ * Authors: Sedji Gaouaou <sedji.gaouaou@atmel.com>
+ *
+ * Based on at91-pcm. by:
+ * Frank Mandarino <fmandarino@endrelia.com>
+ * Copyright 2006 Endrelia Technologies Inc.
+ *
+ * Based on pxa2xx-pcm.c by:
+ *
+ * Author:	Nicolas Pitre
+ * Created:	Nov 30, 2004
+ * Copyright:	(C) 2004 MontaVista Software, Inc.
  *
  * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
  *
- * Note that this is basically a port of the sound/soc/at91-pcm.c to
- * the AVR32 kernel.  Thanks to Frank Mandarino for that code.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
 #include <linux/module.h>
@@ -18,14 +37,16 @@
 #include <linux/slab.h>
 #include <linux/dma-mapping.h>
 #include <linux/atmel_pdc.h>
+#include <linux/atmel-ssc.h>
 
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 
-#include "at32-pcm.h"
+#include <mach/hardware.h>
 
+#include "atmel-pcm.h"
 
 
 /*--------------------------------------------------------------------------*\
@@ -34,36 +55,33 @@
 /* TODO: These values were taken from the AT91 platform driver, check
  *	 them against real values for AT32
  */
-static const struct snd_pcm_hardware at32_pcm_hardware = {
-	.info = (SNDRV_PCM_INFO_MMAP |
-		 SNDRV_PCM_INFO_MMAP_VALID |
-		 SNDRV_PCM_INFO_INTERLEAVED |
-		 SNDRV_PCM_INFO_BLOCK_TRANSFER |
-		 SNDRV_PCM_INFO_PAUSE),
-
-	.formats = SNDRV_PCM_FMTBIT_S16,
-	.period_bytes_min = 32,
-	.period_bytes_max = 8192,	/* 512 frames * 16 bytes / frame */
-	.periods_min = 2,
-	.periods_max = 1024,
-	.buffer_bytes_max = 32 * 1024,
+static const struct snd_pcm_hardware atmel_pcm_hardware = {
+	.info			= SNDRV_PCM_INFO_MMAP |
+				  SNDRV_PCM_INFO_MMAP_VALID |
+				  SNDRV_PCM_INFO_INTERLEAVED |
+				  SNDRV_PCM_INFO_PAUSE,
+	.formats		= SNDRV_PCM_FMTBIT_S16_LE,
+	.period_bytes_min	= 32,
+	.period_bytes_max	= 8192,
+	.periods_min		= 2,
+	.periods_max		= 1024,
+	.buffer_bytes_max	= 32 * 1024,
 };
 
 
-
 /*--------------------------------------------------------------------------*\
  * Data types
 \*--------------------------------------------------------------------------*/
-struct at32_runtime_data {
-	struct at32_pcm_dma_params *params;
-	dma_addr_t dma_buffer;	/* physical address of DMA buffer */
-	dma_addr_t dma_buffer_end; /* first address beyond DMA buffer */
+struct atmel_runtime_data {
+	struct atmel_pcm_dma_params *params;
+	dma_addr_t dma_buffer;		/* physical address of dma buffer */
+	dma_addr_t dma_buffer_end;	/* first address beyond DMA buffer */
 	size_t period_size;
 
-	dma_addr_t period_ptr;	/* physical address of next period */
-	int periods;		/* period index of period_ptr */
+	dma_addr_t period_ptr;		/* physical address of next period */
+	int periods;			/* period index of period_ptr */
 
-	/* Save PDC registers (for power management) */
+	/* PDC register save */
 	u32 pdc_xpr_save;
 	u32 pdc_xcr_save;
 	u32 pdc_xnpr_save;
@@ -71,49 +89,51 @@ struct at32_runtime_data {
 };
 
 
-
 /*--------------------------------------------------------------------------*\
  * Helper functions
 \*--------------------------------------------------------------------------*/
-static int at32_pcm_preallocate_dma_buffer(struct snd_pcm *pcm, int stream)
+static int atmel_pcm_preallocate_dma_buffer(struct snd_pcm *pcm,
+	int stream)
 {
 	struct snd_pcm_substream *substream = pcm->streams[stream].substream;
-	struct snd_dma_buffer *dmabuf = &substream->dma_buffer;
-	size_t size = at32_pcm_hardware.buffer_bytes_max;
-
-	dmabuf->dev.type = SNDRV_DMA_TYPE_DEV;
-	dmabuf->dev.dev = pcm->card->dev;
-	dmabuf->private_data = NULL;
-	dmabuf->area = dma_alloc_coherent(pcm->card->dev, size,
-					  &dmabuf->addr, GFP_KERNEL);
-	pr_debug("at32_pcm: preallocate_dma_buffer: "
-		 "area=%p, addr=%p, size=%ld\n",
-		 (void *)dmabuf->area, (void *)dmabuf->addr, size);
-
-	if (!dmabuf->area)
+	struct snd_dma_buffer *buf = &substream->dma_buffer;
+	size_t size = atmel_pcm_hardware.buffer_bytes_max;
+
+	buf->dev.type = SNDRV_DMA_TYPE_DEV;
+	buf->dev.dev = pcm->card->dev;
+	buf->private_data = NULL;
+	buf->area = dma_alloc_coherent(pcm->card->dev, size,
+					  &buf->addr, GFP_KERNEL);
+	pr_debug("atmel-pcm:"
+		"preallocate_dma_buffer: area=%p, addr=%p, size=%d\n",
+		(void *) buf->area,
+		(void *) buf->addr,
+		size);
+
+	if (!buf->area)
 		return -ENOMEM;
 
-	dmabuf->bytes = size;
+	buf->bytes = size;
 	return 0;
 }
-
-
-
 /*--------------------------------------------------------------------------*\
  * ISR
 \*--------------------------------------------------------------------------*/
-static void at32_pcm_dma_irq(u32 ssc_sr, struct snd_pcm_substream *substream)
+static void atmel_pcm_dma_irq(u32 ssc_sr,
+	struct snd_pcm_substream *substream)
 {
-	struct snd_pcm_runtime *rtd = substream->runtime;
-	struct at32_runtime_data *prtd = rtd->private_data;
-	struct at32_pcm_dma_params *params = prtd->params;
+	struct atmel_runtime_data *prtd = substream->runtime->private_data;
+	struct atmel_pcm_dma_params *params = prtd->params;
 	static int count;
 
 	count++;
+
 	if (ssc_sr & params->mask->ssc_endbuf) {
-		pr_warning("at32-pcm: buffer %s on %s (SSC_SR=%#x, count=%d)\n",
-			   substream->stream == SNDRV_PCM_STREAM_PLAYBACK ?
-			   "underrun" : "overrun", params->name, ssc_sr, count);
+		pr_warning("atmel-pcm: buffer %s on %s"
+				" (SSC_SR=%#x, count=%d)\n",
+				substream->stream == SNDRV_PCM_STREAM_PLAYBACK
+				? "underrun" : "overrun",
+				params->name, ssc_sr, count);
 
 		/* re-start the PDC */
 		ssc_writex(params->ssc->regs, ATMEL_PDC_PTCR,
@@ -122,7 +142,6 @@ static void at32_pcm_dma_irq(u32 ssc_sr, struct snd_pcm_substream *substream)
 		if (prtd->period_ptr >= prtd->dma_buffer_end)
 			prtd->period_ptr = prtd->dma_buffer;
 
-
 		ssc_writex(params->ssc->regs, params->pdc->xpr,
 			   prtd->period_ptr);
 		ssc_writex(params->ssc->regs, params->pdc->xcr,
@@ -131,60 +150,58 @@ static void at32_pcm_dma_irq(u32 ssc_sr, struct snd_pcm_substream *substream)
 			   params->mask->pdc_enable);
 	}
 
-
 	if (ssc_sr & params->mask->ssc_endx) {
 		/* Load the PDC next pointer and counter registers */
 		prtd->period_ptr += prtd->period_size;
 		if (prtd->period_ptr >= prtd->dma_buffer_end)
 			prtd->period_ptr = prtd->dma_buffer;
+
 		ssc_writex(params->ssc->regs, params->pdc->xnpr,
 			   prtd->period_ptr);
 		ssc_writex(params->ssc->regs, params->pdc->xncr,
 			   prtd->period_size / params->pdc_xfer_size);
 	}
 
-
 	snd_pcm_period_elapsed(substream);
 }
 
 
-
 /*--------------------------------------------------------------------------*\
  * PCM operations
 \*--------------------------------------------------------------------------*/
-static int at32_pcm_hw_params(struct snd_pcm_substream *substream,
-			      struct snd_pcm_hw_params *params)
+static int atmel_pcm_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct at32_runtime_data *prtd = runtime->private_data;
+	struct atmel_runtime_data *prtd = runtime->private_data;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 
 	/* this may get called several times by oss emulation
-	 * with different params
-	 */
+	 * with different params */
+
 	snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);
 	runtime->dma_bytes = params_buffer_bytes(params);
 
 	prtd->params = rtd->dai->cpu_dai->dma_data;
-	prtd->params->dma_intr_handler = at32_pcm_dma_irq;
+	prtd->params->dma_intr_handler = atmel_pcm_dma_irq;
 
 	prtd->dma_buffer = runtime->dma_addr;
 	prtd->dma_buffer_end = runtime->dma_addr + runtime->dma_bytes;
 	prtd->period_size = params_period_bytes(params);
 
-	pr_debug("hw_params: DMA for %s initialized "
-		 "(dma_bytes=%ld, period_size=%ld)\n",
-		 prtd->params->name, runtime->dma_bytes, prtd->period_size);
-
+	pr_debug("atmel-pcm: "
+		"hw_params: DMA for %s initialized "
+		"(dma_bytes=%u, period_size=%u)\n",
+		prtd->params->name,
+		runtime->dma_bytes,
+		prtd->period_size);
 	return 0;
 }
 
-
-
-static int at32_pcm_hw_free(struct snd_pcm_substream *substream)
+static int atmel_pcm_hw_free(struct snd_pcm_substream *substream)
 {
-	struct at32_runtime_data *prtd = substream->runtime->private_data;
-	struct at32_pcm_dma_params *params = prtd->params;
+	struct atmel_runtime_data *prtd = substream->runtime->private_data;
+	struct atmel_pcm_dma_params *params = prtd->params;
 
 	if (params != NULL) {
 		ssc_writex(params->ssc->regs, SSC_PDC_PTCR,
@@ -195,32 +212,29 @@ static int at32_pcm_hw_free(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-
-
-static int at32_pcm_prepare(struct snd_pcm_substream *substream)
+static int atmel_pcm_prepare(struct snd_pcm_substream *substream)
 {
-	struct at32_runtime_data *prtd = substream->runtime->private_data;
-	struct at32_pcm_dma_params *params = prtd->params;
+	struct atmel_runtime_data *prtd = substream->runtime->private_data;
+	struct atmel_pcm_dma_params *params = prtd->params;
 
 	ssc_writex(params->ssc->regs, SSC_IDR,
 		   params->mask->ssc_endx | params->mask->ssc_endbuf);
 	ssc_writex(params->ssc->regs, ATMEL_PDC_PTCR,
 		   params->mask->pdc_disable);
-
 	return 0;
 }
 
-
-static int at32_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
+static int atmel_pcm_trigger(struct snd_pcm_substream *substream,
+	int cmd)
 {
 	struct snd_pcm_runtime *rtd = substream->runtime;
-	struct at32_runtime_data *prtd = rtd->private_data;
-	struct at32_pcm_dma_params *params = prtd->params;
+	struct atmel_runtime_data *prtd = rtd->private_data;
+	struct atmel_pcm_dma_params *params = prtd->params;
 	int ret = 0;
 
-	pr_debug("at32_pcm_trigger: buffer_size = %ld, "
-		 "dma_area = %p, dma_bytes = %ld\n",
-		 rtd->buffer_size, rtd->dma_area, rtd->dma_bytes);
+	pr_debug("atmel-pcm:buffer_size = %ld,"
+		"dma_area = %p, dma_bytes = %u\n",
+		rtd->buffer_size, rtd->dma_area, rtd->dma_bytes);
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
@@ -237,26 +251,25 @@ static int at32_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 		ssc_writex(params->ssc->regs, params->pdc->xncr,
 			   prtd->period_size / params->pdc_xfer_size);
 
-		pr_debug("trigger: period_ptr=%lx, xpr=%x, "
-			 "xcr=%d, xnpr=%x, xncr=%d\n",
-			 (unsigned long)prtd->period_ptr,
-			 ssc_readx(params->ssc->regs, params->pdc->xpr),
-			 ssc_readx(params->ssc->regs, params->pdc->xcr),
-			 ssc_readx(params->ssc->regs, params->pdc->xnpr),
-			 ssc_readx(params->ssc->regs, params->pdc->xncr));
+		pr_debug("atmel-pcm: trigger: "
+			"period_ptr=%lx, xpr=%u, "
+			"xcr=%u, xnpr=%u, xncr=%u\n",
+			(unsigned long)prtd->period_ptr,
+			ssc_readx(params->ssc->regs, params->pdc->xpr),
+			ssc_readx(params->ssc->regs, params->pdc->xcr),
+			ssc_readx(params->ssc->regs, params->pdc->xnpr),
+			ssc_readx(params->ssc->regs, params->pdc->xncr));
 
 		ssc_writex(params->ssc->regs, SSC_IER,
 			   params->mask->ssc_endx | params->mask->ssc_endbuf);
 		ssc_writex(params->ssc->regs, SSC_PDC_PTCR,
 			   params->mask->pdc_enable);
 
-		pr_debug("sr=%x, imr=%x\n",
-			 ssc_readx(params->ssc->regs, SSC_SR),
-			 ssc_readx(params->ssc->regs, SSC_IER));
+		pr_debug("sr=%u imr=%u\n",
+			ssc_readx(params->ssc->regs, SSC_SR),
+			ssc_readx(params->ssc->regs, SSC_IER));
 		break;		/* SNDRV_PCM_TRIGGER_START */
 
-
-
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
@@ -264,7 +277,6 @@ static int at32_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 			   params->mask->pdc_disable);
 		break;
 
-
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		ssc_writex(params->ssc->regs, ATMEL_PDC_PTCR,
@@ -278,13 +290,12 @@ static int at32_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 	return ret;
 }
 
-
-
-static snd_pcm_uframes_t at32_pcm_pointer(struct snd_pcm_substream *substream)
+static snd_pcm_uframes_t atmel_pcm_pointer(
+	struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct at32_runtime_data *prtd = runtime->private_data;
-	struct at32_pcm_dma_params *params = prtd->params;
+	struct atmel_runtime_data *prtd = runtime->private_data;
+	struct atmel_pcm_dma_params *params = prtd->params;
 	dma_addr_t ptr;
 	snd_pcm_uframes_t x;
 
@@ -297,108 +308,95 @@ static snd_pcm_uframes_t at32_pcm_pointer(struct snd_pcm_substream *substream)
 	return x;
 }
 
-
-
-static int at32_pcm_open(struct snd_pcm_substream *substream)
+static int atmel_pcm_open(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct at32_runtime_data *prtd;
+	struct atmel_runtime_data *prtd;
 	int ret = 0;
 
-	snd_soc_set_runtime_hwparams(substream, &at32_pcm_hardware);
+	snd_soc_set_runtime_hwparams(substream, &atmel_pcm_hardware);
 
 	/* ensure that buffer size is a multiple of period size */
 	ret = snd_pcm_hw_constraint_integer(runtime,
-					    SNDRV_PCM_HW_PARAM_PERIODS);
+						SNDRV_PCM_HW_PARAM_PERIODS);
 	if (ret < 0)
 		goto out;
 
-	prtd = kzalloc(sizeof(*prtd), GFP_KERNEL);
+	prtd = kzalloc(sizeof(struct atmel_runtime_data), GFP_KERNEL);
 	if (prtd == NULL) {
 		ret = -ENOMEM;
 		goto out;
 	}
 	runtime->private_data = prtd;
 
-
-out:
+ out:
 	return ret;
 }
 
-
-
-static int at32_pcm_close(struct snd_pcm_substream *substream)
+static int atmel_pcm_close(struct snd_pcm_substream *substream)
 {
-	struct at32_runtime_data *prtd = substream->runtime->private_data;
+	struct atmel_runtime_data *prtd = substream->runtime->private_data;
 
 	kfree(prtd);
 	return 0;
 }
 
-
-static int at32_pcm_mmap(struct snd_pcm_substream *substream,
-			 struct vm_area_struct *vma)
+static int atmel_pcm_mmap(struct snd_pcm_substream *substream,
+	struct vm_area_struct *vma)
 {
 	return remap_pfn_range(vma, vma->vm_start,
-			       substream->dma_buffer.addr >> PAGE_SHIFT,
-			       vma->vm_end - vma->vm_start, vma->vm_page_prot);
+		       substream->dma_buffer.addr >> PAGE_SHIFT,
+		       vma->vm_end - vma->vm_start, vma->vm_page_prot);
 }
 
-
-
-static struct snd_pcm_ops at32_pcm_ops = {
-	.open = at32_pcm_open,
-	.close = at32_pcm_close,
-	.ioctl = snd_pcm_lib_ioctl,
-	.hw_params = at32_pcm_hw_params,
-	.hw_free = at32_pcm_hw_free,
-	.prepare = at32_pcm_prepare,
-	.trigger = at32_pcm_trigger,
-	.pointer = at32_pcm_pointer,
-	.mmap = at32_pcm_mmap,
+struct snd_pcm_ops atmel_pcm_ops = {
+	.open		= atmel_pcm_open,
+	.close		= atmel_pcm_close,
+	.ioctl		= snd_pcm_lib_ioctl,
+	.hw_params	= atmel_pcm_hw_params,
+	.hw_free	= atmel_pcm_hw_free,
+	.prepare	= atmel_pcm_prepare,
+	.trigger	= atmel_pcm_trigger,
+	.pointer	= atmel_pcm_pointer,
+	.mmap		= atmel_pcm_mmap,
 };
 
 
-
 /*--------------------------------------------------------------------------*\
  * ASoC platform driver
 \*--------------------------------------------------------------------------*/
-static u64 at32_pcm_dmamask = 0xffffffff;
+static u64 atmel_pcm_dmamask = 0xffffffff;
 
-static int at32_pcm_new(struct snd_card *card,
-			struct snd_soc_dai *dai,
-			struct snd_pcm *pcm)
+static int atmel_pcm_new(struct snd_card *card,
+	struct snd_soc_dai *dai, struct snd_pcm *pcm)
 {
 	int ret = 0;
 
 	if (!card->dev->dma_mask)
-		card->dev->dma_mask = &at32_pcm_dmamask;
+		card->dev->dma_mask = &atmel_pcm_dmamask;
 	if (!card->dev->coherent_dma_mask)
 		card->dev->coherent_dma_mask = 0xffffffff;
 
 	if (dai->playback.channels_min) {
-		ret = at32_pcm_preallocate_dma_buffer(
-			  pcm, SNDRV_PCM_STREAM_PLAYBACK);
+		ret = atmel_pcm_preallocate_dma_buffer(pcm,
+			SNDRV_PCM_STREAM_PLAYBACK);
 		if (ret)
 			goto out;
 	}
 
 	if (dai->capture.channels_min) {
-		pr_debug("at32-pcm: Allocating PCM capture DMA buffer\n");
-		ret = at32_pcm_preallocate_dma_buffer(
-			  pcm, SNDRV_PCM_STREAM_CAPTURE);
+		pr_debug("at32-pcm:"
+				"Allocating PCM capture DMA buffer\n");
+		ret = atmel_pcm_preallocate_dma_buffer(pcm,
+			SNDRV_PCM_STREAM_CAPTURE);
 		if (ret)
 			goto out;
 	}
-
-
-out:
+ out:
 	return ret;
 }
 
-
-
-static void at32_pcm_free_dma_buffers(struct snd_pcm *pcm)
+static void atmel_pcm_free_dma_buffers(struct snd_pcm *pcm)
 {
 	struct snd_pcm_substream *substream;
 	struct snd_dma_buffer *buf;
@@ -406,7 +404,7 @@ static void at32_pcm_free_dma_buffers(struct snd_pcm *pcm)
 
 	for (stream = 0; stream < 2; stream++) {
 		substream = pcm->streams[stream].substream;
-		if (substream == NULL)
+		if (!substream)
 			continue;
 
 		buf = &substream->dma_buffer;
@@ -418,24 +416,23 @@ static void at32_pcm_free_dma_buffers(struct snd_pcm *pcm)
 	}
 }
 
-
-
 #ifdef CONFIG_PM
-static int at32_pcm_suspend(struct platform_device *pdev,
-			    struct snd_soc_dai *dai)
+static int atmel_pcm_suspend(struct platform_device *pdev,
+	struct snd_soc_dai *dai)
 {
 	struct snd_pcm_runtime *runtime = dai->runtime;
-	struct at32_runtime_data *prtd;
-	struct at32_pcm_dma_params *params;
+	struct atmel_runtime_data *prtd;
+	struct atmel_pcm_dma_params *params;
 
-	if (runtime == NULL)
+	if (!runtime)
 		return 0;
+
 	prtd = runtime->private_data;
 	params = prtd->params;
 
-	/* Disable the PDC and save the PDC registers */
-	ssc_writex(params->ssc->regs, ATMEL_PDC_PTCR,
-		   params->mask->pdc_disable);
+	/* disable the PDC and save the PDC registers */
+
+	ssc_writel(params->ssc->regs, PDC_PTCR, params->mask->pdc_disable);
 
 	prtd->pdc_xpr_save = ssc_readx(params->ssc->regs, params->pdc->xpr);
 	prtd->pdc_xcr_save = ssc_readx(params->ssc->regs, params->pdc->xcr);
@@ -445,48 +442,43 @@ static int at32_pcm_suspend(struct platform_device *pdev,
 	return 0;
 }
 
-
-
-static int at32_pcm_resume(struct platform_device *pdev,
-			   struct snd_soc_dai *dai)
+static int atmel_pcm_resume(struct platform_device *pdev,
+	struct snd_soc_dai *dai)
 {
 	struct snd_pcm_runtime *runtime = dai->runtime;
-	struct at32_runtime_data *prtd;
-	struct at32_pcm_dma_params *params;
+	struct atmel_runtime_data *prtd;
+	struct atmel_pcm_dma_params *params;
 
-	if (runtime == NULL)
+	if (!runtime)
 		return 0;
+
 	prtd = runtime->private_data;
 	params = prtd->params;
 
-	/* Restore the PDC registers and enable the PDC */
+	/* restore the PDC registers and enable the PDC */
 	ssc_writex(params->ssc->regs, params->pdc->xpr, prtd->pdc_xpr_save);
 	ssc_writex(params->ssc->regs, params->pdc->xcr, prtd->pdc_xcr_save);
 	ssc_writex(params->ssc->regs, params->pdc->xnpr, prtd->pdc_xnpr_save);
 	ssc_writex(params->ssc->regs, params->pdc->xncr, prtd->pdc_xncr_save);
 
-	ssc_writex(params->ssc->regs, ATMEL_PDC_PTCR, params->mask->pdc_enable);
+	ssc_writel(params->ssc->regs, PDC_PTCR, params->mask->pdc_enable);
 	return 0;
 }
-#else /* CONFIG_PM */
-#  define at32_pcm_suspend	NULL
-#  define at32_pcm_resume	NULL
-#endif /* CONFIG_PM */
-
-
-
-struct snd_soc_platform at32_soc_platform = {
-	.name = "at32-audio",
-	.pcm_ops = &at32_pcm_ops,
-	.pcm_new = at32_pcm_new,
-	.pcm_free = at32_pcm_free_dma_buffers,
-	.suspend = at32_pcm_suspend,
-	.resume = at32_pcm_resume,
+#else
+#define atmel_pcm_suspend	NULL
+#define atmel_pcm_resume	NULL
+#endif
+
+struct snd_soc_platform atmel_soc_platform = {
+	.name		= "atmel-audio",
+	.pcm_ops 	= &atmel_pcm_ops,
+	.pcm_new	= atmel_pcm_new,
+	.pcm_free	= atmel_pcm_free_dma_buffers,
+	.suspend	= atmel_pcm_suspend,
+	.resume		= atmel_pcm_resume,
 };
-EXPORT_SYMBOL_GPL(at32_soc_platform);
-
-
+EXPORT_SYMBOL_GPL(atmel_soc_platform);
 
-MODULE_AUTHOR("Geoffrey Wossum <gwossum@acm.org>");
-MODULE_DESCRIPTION("Atmel AT32 PCM module");
+MODULE_AUTHOR("Sedji Gaouaou <sedji.gaouaou@atmel.com>");
+MODULE_DESCRIPTION("Atmel PCM module");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/atmel/atmel-pcm.h b/sound/soc/atmel/atmel-pcm.h
new file mode 100644
index 0000000..ec9b282
--- /dev/null
+++ b/sound/soc/atmel/atmel-pcm.h
@@ -0,0 +1,86 @@
+/*
+ * at91-pcm.h - ALSA PCM interface for the Atmel AT91 SoC.
+ *
+ *  Copyright (C) 2005 SAN People
+ *  Copyright (C) 2008 Atmel
+ *
+ * Authors: Sedji Gaouaou <sedji.gaouaou@atmel.com>
+ *
+ * Based on at91-pcm. by:
+ * Frank Mandarino <fmandarino@endrelia.com>
+ * Copyright 2006 Endrelia Technologies Inc.
+ *
+ * Based on pxa2xx-pcm.c by:
+ *
+ * Author:	Nicolas Pitre
+ * Created:	Nov 30, 2004
+ * Copyright:	(C) 2004 MontaVista Software, Inc.
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
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#ifndef _ATMEL_PCM_H
+#define _ATMEL_PCM_H
+
+#include <linux/atmel-ssc.h>
+
+/*
+ * Registers and status bits that are required by the PCM driver.
+ */
+struct atmel_pdc_regs {
+	unsigned int	xpr;		/* PDC recv/trans pointer */
+	unsigned int	xcr;		/* PDC recv/trans counter */
+	unsigned int	xnpr;		/* PDC next recv/trans pointer */
+	unsigned int	xncr;		/* PDC next recv/trans counter */
+	unsigned int	ptcr;		/* PDC transfer control */
+};
+
+struct atmel_ssc_mask {
+	u32	ssc_enable;		/* SSC recv/trans enable */
+	u32	ssc_disable;		/* SSC recv/trans disable */
+	u32	ssc_endx;		/* SSC ENDTX or ENDRX */
+	u32	ssc_endbuf;		/* SSC TXBUFE or RXBUFF */
+	u32	pdc_enable;		/* PDC recv/trans enable */
+	u32	pdc_disable;		/* PDC recv/trans disable */
+};
+
+/*
+ * This structure, shared between the PCM driver and the interface,
+ * contains all information required by the PCM driver to perform the
+ * PDC DMA operation.  All fields except dma_intr_handler() are initialized
+ * by the interface.  The dms_intr_handler() pointer is set by the PCM
+ * driver and called by the interface SSC interrupt handler if it is
+ * non-NULL.
+ */
+struct atmel_pcm_dma_params {
+	char *name;			/* stream identifier */
+	int pdc_xfer_size;		/* PDC counter increment in bytes */
+	struct ssc_device *ssc;		/* SSC device for stream */
+	struct atmel_pdc_regs *pdc;	/* PDC receive or transmit registers */
+	struct atmel_ssc_mask *mask;	/* SSC & PDC status bits */
+	struct snd_pcm_substream *substream;
+	void (*dma_intr_handler)(u32, struct snd_pcm_substream *);
+};
+
+extern struct snd_soc_platform atmel_soc_platform;
+
+
+/*
+ * SSC register access (since ssc_writel() / ssc_readl() require literal name)
+ */
+#define ssc_readx(base, reg)            (__raw_readl((base) + (reg)))
+#define ssc_writex(base, reg, value)    __raw_writel((value), (base) + (reg))
+
+#endif /* _ATMEL_PCM_H */
diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
new file mode 100644
index 0000000..d290b78
--- /dev/null
+++ b/sound/soc/atmel/atmel_ssc_dai.c
@@ -0,0 +1,782 @@
+/*
+ * atmel_ssc_dai.c  --  ALSA SoC ATMEL SSC Audio Layer Platform driver
+ *
+ * Copyright (C) 2005 SAN People
+ * Copyright (C) 2008 Atmel
+ *
+ * Author: Sedji Gaouaou <sedji.gaouaou@atmel.com>
+ *         ATMEL CORP.
+ *
+ * Based on at91-ssc.c by
+ * Frank Mandarino <fmandarino@endrelia.com>
+ * Based on pxa2xx Platform drivers by
+ * Liam Girdwood <liam.girdwood@wolfsonmicro.com>
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
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/device.h>
+#include <linux/delay.h>
+#include <linux/clk.h>
+#include <linux/atmel_pdc.h>
+
+#include <linux/atmel-ssc.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/initval.h>
+#include <sound/soc.h>
+
+#include <mach/hardware.h>
+
+#include "atmel-pcm.h"
+#include "atmel_ssc_dai.h"
+
+
+#if defined(CONFIG_ARCH_AT91SAM9260) || defined(CONFIG_ARCH_AT91SAM9G20)
+#define NUM_SSC_DEVICES		1
+#else
+#define NUM_SSC_DEVICES		3
+#endif
+
+/*
+ * SSC PDC registers required by the PCM DMA engine.
+ */
+static struct atmel_pdc_regs pdc_tx_reg = {
+	.xpr		= ATMEL_PDC_TPR,
+	.xcr		= ATMEL_PDC_TCR,
+	.xnpr		= ATMEL_PDC_TNPR,
+	.xncr		= ATMEL_PDC_TNCR,
+};
+
+static struct atmel_pdc_regs pdc_rx_reg = {
+	.xpr		= ATMEL_PDC_RPR,
+	.xcr		= ATMEL_PDC_RCR,
+	.xnpr		= ATMEL_PDC_RNPR,
+	.xncr		= ATMEL_PDC_RNCR,
+};
+
+/*
+ * SSC & PDC status bits for transmit and receive.
+ */
+static struct atmel_ssc_mask ssc_tx_mask = {
+	.ssc_enable	= SSC_BIT(CR_TXEN),
+	.ssc_disable	= SSC_BIT(CR_TXDIS),
+	.ssc_endx	= SSC_BIT(SR_ENDTX),
+	.ssc_endbuf	= SSC_BIT(SR_TXBUFE),
+	.pdc_enable	= ATMEL_PDC_TXTEN,
+	.pdc_disable	= ATMEL_PDC_TXTDIS,
+};
+
+static struct atmel_ssc_mask ssc_rx_mask = {
+	.ssc_enable	= SSC_BIT(CR_RXEN),
+	.ssc_disable	= SSC_BIT(CR_RXDIS),
+	.ssc_endx	= SSC_BIT(SR_ENDRX),
+	.ssc_endbuf	= SSC_BIT(SR_RXBUFF),
+	.pdc_enable	= ATMEL_PDC_RXTEN,
+	.pdc_disable	= ATMEL_PDC_RXTDIS,
+};
+
+
+/*
+ * DMA parameters.
+ */
+static struct atmel_pcm_dma_params ssc_dma_params[NUM_SSC_DEVICES][2] = {
+	{{
+	.name		= "SSC0 PCM out",
+	.pdc		= &pdc_tx_reg,
+	.mask		= &ssc_tx_mask,
+	},
+	{
+	.name		= "SSC0 PCM in",
+	.pdc		= &pdc_rx_reg,
+	.mask		= &ssc_rx_mask,
+	} },
+#if NUM_SSC_DEVICES == 3
+	{{
+	.name		= "SSC1 PCM out",
+	.pdc		= &pdc_tx_reg,
+	.mask		= &ssc_tx_mask,
+	},
+	{
+	.name		= "SSC1 PCM in",
+	.pdc		= &pdc_rx_reg,
+	.mask		= &ssc_rx_mask,
+	} },
+	{{
+	.name		= "SSC2 PCM out",
+	.pdc		= &pdc_tx_reg,
+	.mask		= &ssc_tx_mask,
+	},
+	{
+	.name		= "SSC2 PCM in",
+	.pdc		= &pdc_rx_reg,
+	.mask		= &ssc_rx_mask,
+	} },
+#endif
+};
+
+
+static struct atmel_ssc_info ssc_info[NUM_SSC_DEVICES] = {
+	{
+	.name		= "ssc0",
+	.lock		= __SPIN_LOCK_UNLOCKED(ssc_info[0].lock),
+	.dir_mask	= SSC_DIR_MASK_UNUSED,
+	.initialized	= 0,
+	},
+#if NUM_SSC_DEVICES == 3
+	{
+	.name		= "ssc1",
+	.lock		= __SPIN_LOCK_UNLOCKED(ssc_info[1].lock),
+	.dir_mask	= SSC_DIR_MASK_UNUSED,
+	.initialized	= 0,
+	},
+	{
+	.name		= "ssc2",
+	.lock		= __SPIN_LOCK_UNLOCKED(ssc_info[2].lock),
+	.dir_mask	= SSC_DIR_MASK_UNUSED,
+	.initialized	= 0,
+	},
+#endif
+};
+
+
+/*
+ * SSC interrupt handler.  Passes PDC interrupts to the DMA
+ * interrupt handler in the PCM driver.
+ */
+static irqreturn_t atmel_ssc_interrupt(int irq, void *dev_id)
+{
+	struct atmel_ssc_info *ssc_p = dev_id;
+	struct atmel_pcm_dma_params *dma_params;
+	u32 ssc_sr;
+	u32 ssc_substream_mask;
+	int i;
+
+	ssc_sr = (unsigned long)ssc_readl(ssc_p->ssc->regs, SR)
+			& (unsigned long)ssc_readl(ssc_p->ssc->regs, IMR);
+
+	/*
+	 * Loop through the substreams attached to this SSC.  If
+	 * a DMA-related interrupt occurred on that substream, call
+	 * the DMA interrupt handler function, if one has been
+	 * registered in the dma_params structure by the PCM driver.
+	 */
+	for (i = 0; i < ARRAY_SIZE(ssc_p->dma_params); i++) {
+		dma_params = ssc_p->dma_params[i];
+
+		if ((dma_params != NULL) &&
+			(dma_params->dma_intr_handler != NULL)) {
+			ssc_substream_mask = (dma_params->mask->ssc_endx |
+					dma_params->mask->ssc_endbuf);
+			if (ssc_sr & ssc_substream_mask) {
+				dma_params->dma_intr_handler(ssc_sr,
+						dma_params->
+						substream);
+			}
+		}
+	}
+
+	return IRQ_HANDLED;
+}
+
+
+/*-------------------------------------------------------------------------*\
+ * DAI functions
+\*-------------------------------------------------------------------------*/
+/*
+ * Startup.  Only that one substream allowed in each direction.
+ */
+static int atmel_ssc_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = snd_pcm_substream_chip(substream);
+	struct atmel_ssc_info *ssc_p = &ssc_info[rtd->dai->cpu_dai->id];
+	int dir_mask;
+
+	pr_debug("atmel_ssc_startup: SSC_SR=0x%u\n",
+		ssc_readl(ssc_p->ssc->regs, SR));
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		dir_mask = SSC_DIR_MASK_PLAYBACK;
+	else
+		dir_mask = SSC_DIR_MASK_CAPTURE;
+
+	spin_lock_irq(&ssc_p->lock);
+	if (ssc_p->dir_mask & dir_mask) {
+		spin_unlock_irq(&ssc_p->lock);
+		return -EBUSY;
+	}
+	ssc_p->dir_mask |= dir_mask;
+	spin_unlock_irq(&ssc_p->lock);
+
+	return 0;
+}
+
+/*
+ * Shutdown.  Clear DMA parameters and shutdown the SSC if there
+ * are no other substreams open.
+ */
+static void atmel_ssc_shutdown(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = snd_pcm_substream_chip(substream);
+	struct atmel_ssc_info *ssc_p = &ssc_info[rtd->dai->cpu_dai->id];
+	struct atmel_pcm_dma_params *dma_params;
+	int dir, dir_mask;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		dir = 0;
+	else
+		dir = 1;
+
+	dma_params = ssc_p->dma_params[dir];
+
+	if (dma_params != NULL) {
+		ssc_writel(ssc_p->ssc->regs, CR, dma_params->mask->ssc_disable);
+		pr_debug("atmel_ssc_shutdown: %s disabled SSC_SR=0x%08x\n",
+			(dir ? "receive" : "transmit"),
+			ssc_readl(ssc_p->ssc->regs, SR));
+
+		dma_params->ssc = NULL;
+		dma_params->substream = NULL;
+		ssc_p->dma_params[dir] = NULL;
+	}
+
+	dir_mask = 1 << dir;
+
+	spin_lock_irq(&ssc_p->lock);
+	ssc_p->dir_mask &= ~dir_mask;
+	if (!ssc_p->dir_mask) {
+		if (ssc_p->initialized) {
+			/* Shutdown the SSC clock. */
+			pr_debug("atmel_ssc_dau: Stopping clock\n");
+			clk_disable(ssc_p->ssc->clk);
+
+			free_irq(ssc_p->ssc->irq, ssc_p);
+			ssc_p->initialized = 0;
+		}
+
+		/* Reset the SSC */
+		ssc_writel(ssc_p->ssc->regs, CR, SSC_BIT(CR_SWRST));
+		/* Clear the SSC dividers */
+		ssc_p->cmr_div = ssc_p->tcmr_period = ssc_p->rcmr_period = 0;
+	}
+	spin_unlock_irq(&ssc_p->lock);
+}
+
+
+/*
+ * Record the DAI format for use in hw_params().
+ */
+static int atmel_ssc_set_dai_fmt(struct snd_soc_dai *cpu_dai,
+		unsigned int fmt)
+{
+	struct atmel_ssc_info *ssc_p = &ssc_info[cpu_dai->id];
+
+	ssc_p->daifmt = fmt;
+	return 0;
+}
+
+/*
+ * Record SSC clock dividers for use in hw_params().
+ */
+static int atmel_ssc_set_dai_clkdiv(struct snd_soc_dai *cpu_dai,
+	int div_id, int div)
+{
+	struct atmel_ssc_info *ssc_p = &ssc_info[cpu_dai->id];
+
+	switch (div_id) {
+	case ATMEL_SSC_CMR_DIV:
+		/*
+		 * The same master clock divider is used for both
+		 * transmit and receive, so if a value has already
+		 * been set, it must match this value.
+		 */
+		if (ssc_p->cmr_div == 0)
+			ssc_p->cmr_div = div;
+		else
+			if (div != ssc_p->cmr_div)
+				return -EBUSY;
+		break;
+
+	case ATMEL_SSC_TCMR_PERIOD:
+		ssc_p->tcmr_period = div;
+		break;
+
+	case ATMEL_SSC_RCMR_PERIOD:
+		ssc_p->rcmr_period = div;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/*
+ * Configure the SSC.
+ */
+static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = snd_pcm_substream_chip(substream);
+	int id = rtd->dai->cpu_dai->id;
+	struct atmel_ssc_info *ssc_p = &ssc_info[id];
+	struct atmel_pcm_dma_params *dma_params;
+	int dir, channels, bits;
+	u32 tfmr, rfmr, tcmr, rcmr;
+	int start_event;
+	int ret;
+
+	/*
+	 * Currently, there is only one set of dma params for
+	 * each direction.  If more are added, this code will
+	 * have to be changed to select the proper set.
+	 */
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		dir = 0;
+	else
+		dir = 1;
+
+	dma_params = &ssc_dma_params[id][dir];
+	dma_params->ssc = ssc_p->ssc;
+	dma_params->substream = substream;
+
+	ssc_p->dma_params[dir] = dma_params;
+
+	/*
+	 * The cpu_dai->dma_data field is only used to communicate the
+	 * appropriate DMA parameters to the pcm driver hw_params()
+	 * function.  It should not be used for other purposes
+	 * as it is common to all substreams.
+	 */
+	rtd->dai->cpu_dai->dma_data = dma_params;
+
+	channels = params_channels(params);
+
+	/*
+	 * Determine sample size in bits and the PDC increment.
+	 */
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S8:
+		bits = 8;
+		dma_params->pdc_xfer_size = 1;
+		break;
+	case SNDRV_PCM_FORMAT_S16_LE:
+		bits = 16;
+		dma_params->pdc_xfer_size = 2;
+		break;
+	case SNDRV_PCM_FORMAT_S24_LE:
+		bits = 24;
+		dma_params->pdc_xfer_size = 4;
+		break;
+	case SNDRV_PCM_FORMAT_S32_LE:
+		bits = 32;
+		dma_params->pdc_xfer_size = 4;
+		break;
+	default:
+		printk(KERN_WARNING "atmel_ssc_dai: unsupported PCM format");
+		return -EINVAL;
+	}
+
+	/*
+	 * The SSC only supports up to 16-bit samples in I2S format, due
+	 * to the size of the Frame Mode Register FSLEN field.
+	 */
+	if ((ssc_p->daifmt & SND_SOC_DAIFMT_FORMAT_MASK) == SND_SOC_DAIFMT_I2S
+		&& bits > 16) {
+		printk(KERN_WARNING
+				"atmel_ssc_dai: sample size %d"
+				"is too large for I2S\n", bits);
+		return -EINVAL;
+	}
+
+	/*
+	 * Compute SSC register settings.
+	 */
+	switch (ssc_p->daifmt
+		& (SND_SOC_DAIFMT_FORMAT_MASK | SND_SOC_DAIFMT_MASTER_MASK)) {
+
+	case SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBS_CFS:
+		/*
+		 * I2S format, SSC provides BCLK and LRC clocks.
+		 *
+		 * The SSC transmit and receive clocks are generated
+		 * from the MCK divider, and the BCLK signal
+		 * is output on the SSC TK line.
+		 */
+		rcmr =	  SSC_BF(RCMR_PERIOD, ssc_p->rcmr_period)
+			| SSC_BF(RCMR_STTDLY, START_DELAY)
+			| SSC_BF(RCMR_START, SSC_START_FALLING_RF)
+			| SSC_BF(RCMR_CKI, SSC_CKI_RISING)
+			| SSC_BF(RCMR_CKO, SSC_CKO_NONE)
+			| SSC_BF(RCMR_CKS, SSC_CKS_DIV);
+
+		rfmr =	  SSC_BF(RFMR_FSEDGE, SSC_FSEDGE_POSITIVE)
+			| SSC_BF(RFMR_FSOS, SSC_FSOS_NEGATIVE)
+			| SSC_BF(RFMR_FSLEN, (bits - 1))
+			| SSC_BF(RFMR_DATNB, (channels - 1))
+			| SSC_BIT(RFMR_MSBF)
+			| SSC_BF(RFMR_LOOP, 0)
+			| SSC_BF(RFMR_DATLEN, (bits - 1));
+
+		tcmr =	  SSC_BF(TCMR_PERIOD, ssc_p->tcmr_period)
+			| SSC_BF(TCMR_STTDLY, START_DELAY)
+			| SSC_BF(TCMR_START, SSC_START_FALLING_RF)
+			| SSC_BF(TCMR_CKI, SSC_CKI_FALLING)
+			| SSC_BF(TCMR_CKO, SSC_CKO_CONTINUOUS)
+			| SSC_BF(TCMR_CKS, SSC_CKS_DIV);
+
+		tfmr =	  SSC_BF(TFMR_FSEDGE, SSC_FSEDGE_POSITIVE)
+			| SSC_BF(TFMR_FSDEN, 0)
+			| SSC_BF(TFMR_FSOS, SSC_FSOS_NEGATIVE)
+			| SSC_BF(TFMR_FSLEN, (bits - 1))
+			| SSC_BF(TFMR_DATNB, (channels - 1))
+			| SSC_BIT(TFMR_MSBF)
+			| SSC_BF(TFMR_DATDEF, 0)
+			| SSC_BF(TFMR_DATLEN, (bits - 1));
+		break;
+
+	case SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBM_CFM:
+		/*
+		 * I2S format, CODEC supplies BCLK and LRC clocks.
+		 *
+		 * The SSC transmit clock is obtained from the BCLK signal on
+		 * on the TK line, and the SSC receive clock is
+		 * generated from the transmit clock.
+		 *
+		 *  For single channel data, one sample is transferred
+		 * on the falling edge of the LRC clock.
+		 * For two channel data, one sample is
+		 * transferred on both edges of the LRC clock.
+		 */
+		start_event = ((channels == 1)
+				? SSC_START_FALLING_RF
+				: SSC_START_EDGE_RF);
+
+		rcmr =	  SSC_BF(RCMR_PERIOD, 0)
+			| SSC_BF(RCMR_STTDLY, START_DELAY)
+			| SSC_BF(RCMR_START, start_event)
+			| SSC_BF(RCMR_CKI, SSC_CKI_RISING)
+			| SSC_BF(RCMR_CKO, SSC_CKO_NONE)
+			| SSC_BF(RCMR_CKS, SSC_CKS_CLOCK);
+
+		rfmr =	  SSC_BF(RFMR_FSEDGE, SSC_FSEDGE_POSITIVE)
+			| SSC_BF(RFMR_FSOS, SSC_FSOS_NONE)
+			| SSC_BF(RFMR_FSLEN, 0)
+			| SSC_BF(RFMR_DATNB, 0)
+			| SSC_BIT(RFMR_MSBF)
+			| SSC_BF(RFMR_LOOP, 0)
+			| SSC_BF(RFMR_DATLEN, (bits - 1));
+
+		tcmr =	  SSC_BF(TCMR_PERIOD, 0)
+			| SSC_BF(TCMR_STTDLY, START_DELAY)
+			| SSC_BF(TCMR_START, start_event)
+			| SSC_BF(TCMR_CKI, SSC_CKI_FALLING)
+			| SSC_BF(TCMR_CKO, SSC_CKO_NONE)
+			| SSC_BF(TCMR_CKS, SSC_CKS_PIN);
+
+		tfmr =	  SSC_BF(TFMR_FSEDGE, SSC_FSEDGE_POSITIVE)
+			| SSC_BF(TFMR_FSDEN, 0)
+			| SSC_BF(TFMR_FSOS, SSC_FSOS_NONE)
+			| SSC_BF(TFMR_FSLEN, 0)
+			| SSC_BF(TFMR_DATNB, 0)
+			| SSC_BIT(TFMR_MSBF)
+			| SSC_BF(TFMR_DATDEF, 0)
+			| SSC_BF(TFMR_DATLEN, (bits - 1));
+		break;
+
+	case SND_SOC_DAIFMT_DSP_A | SND_SOC_DAIFMT_CBS_CFS:
+		/*
+		 * DSP/PCM Mode A format, SSC provides BCLK and LRC clocks.
+		 *
+		 * The SSC transmit and receive clocks are generated from the
+		 * MCK divider, and the BCLK signal is output
+		 * on the SSC TK line.
+		 */
+		rcmr =	  SSC_BF(RCMR_PERIOD, ssc_p->rcmr_period)
+			| SSC_BF(RCMR_STTDLY, 1)
+			| SSC_BF(RCMR_START, SSC_START_RISING_RF)
+			| SSC_BF(RCMR_CKI, SSC_CKI_RISING)
+			| SSC_BF(RCMR_CKO, SSC_CKO_NONE)
+			| SSC_BF(RCMR_CKS, SSC_CKS_DIV);
+
+		rfmr =	  SSC_BF(RFMR_FSEDGE, SSC_FSEDGE_POSITIVE)
+			| SSC_BF(RFMR_FSOS, SSC_FSOS_POSITIVE)
+			| SSC_BF(RFMR_FSLEN, 0)
+			| SSC_BF(RFMR_DATNB, (channels - 1))
+			| SSC_BIT(RFMR_MSBF)
+			| SSC_BF(RFMR_LOOP, 0)
+			| SSC_BF(RFMR_DATLEN, (bits - 1));
+
+		tcmr =	  SSC_BF(TCMR_PERIOD, ssc_p->tcmr_period)
+			| SSC_BF(TCMR_STTDLY, 1)
+			| SSC_BF(TCMR_START, SSC_START_RISING_RF)
+			| SSC_BF(TCMR_CKI, SSC_CKI_RISING)
+			| SSC_BF(TCMR_CKO, SSC_CKO_CONTINUOUS)
+			| SSC_BF(TCMR_CKS, SSC_CKS_DIV);
+
+		tfmr =	  SSC_BF(TFMR_FSEDGE, SSC_FSEDGE_POSITIVE)
+			| SSC_BF(TFMR_FSDEN, 0)
+			| SSC_BF(TFMR_FSOS, SSC_FSOS_POSITIVE)
+			| SSC_BF(TFMR_FSLEN, 0)
+			| SSC_BF(TFMR_DATNB, (channels - 1))
+			| SSC_BIT(TFMR_MSBF)
+			| SSC_BF(TFMR_DATDEF, 0)
+			| SSC_BF(TFMR_DATLEN, (bits - 1));
+		break;
+
+	case SND_SOC_DAIFMT_DSP_A | SND_SOC_DAIFMT_CBM_CFM:
+	default:
+		printk(KERN_WARNING "atmel_ssc_dai: unsupported DAI format 0x%x\n",
+			ssc_p->daifmt);
+		return -EINVAL;
+		break;
+	}
+	pr_debug("atmel_ssc_hw_params: "
+			"RCMR=%08x RFMR=%08x TCMR=%08x TFMR=%08x\n",
+			rcmr, rfmr, tcmr, tfmr);
+
+	if (!ssc_p->initialized) {
+
+		/* Enable PMC peripheral clock for this SSC */
+		pr_debug("atmel_ssc_dai: Starting clock\n");
+		clk_enable(ssc_p->ssc->clk);
+
+		/* Reset the SSC and its PDC registers */
+		ssc_writel(ssc_p->ssc->regs, CR, SSC_BIT(CR_SWRST));
+
+		ssc_writel(ssc_p->ssc->regs, PDC_RPR, 0);
+		ssc_writel(ssc_p->ssc->regs, PDC_RCR, 0);
+		ssc_writel(ssc_p->ssc->regs, PDC_RNPR, 0);
+		ssc_writel(ssc_p->ssc->regs, PDC_RNCR, 0);
+
+		ssc_writel(ssc_p->ssc->regs, PDC_TPR, 0);
+		ssc_writel(ssc_p->ssc->regs, PDC_TCR, 0);
+		ssc_writel(ssc_p->ssc->regs, PDC_TNPR, 0);
+		ssc_writel(ssc_p->ssc->regs, PDC_TNCR, 0);
+
+		ret = request_irq(ssc_p->ssc->irq, atmel_ssc_interrupt, 0,
+				ssc_p->name, ssc_p);
+		if (ret < 0) {
+			printk(KERN_WARNING
+					"atmel_ssc_dai: request_irq failure\n");
+			pr_debug("Atmel_ssc_dai: Stoping clock\n");
+			clk_disable(ssc_p->ssc->clk);
+			return ret;
+		}
+
+		ssc_p->initialized = 1;
+	}
+
+	/* set SSC clock mode register */
+	ssc_writel(ssc_p->ssc->regs, CMR, ssc_p->cmr_div);
+
+	/* set receive clock mode and format */
+	ssc_writel(ssc_p->ssc->regs, RCMR, rcmr);
+	ssc_writel(ssc_p->ssc->regs, RFMR, rfmr);
+
+	/* set transmit clock mode and format */
+	ssc_writel(ssc_p->ssc->regs, TCMR, tcmr);
+	ssc_writel(ssc_p->ssc->regs, TFMR, tfmr);
+
+	pr_debug("atmel_ssc_dai,hw_params: SSC initialized\n");
+	return 0;
+}
+
+
+static int atmel_ssc_prepare(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = snd_pcm_substream_chip(substream);
+	struct atmel_ssc_info *ssc_p = &ssc_info[rtd->dai->cpu_dai->id];
+	struct atmel_pcm_dma_params *dma_params;
+	int dir;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		dir = 0;
+	else
+		dir = 1;
+
+	dma_params = ssc_p->dma_params[dir];
+
+	ssc_writel(ssc_p->ssc->regs, CR, dma_params->mask->ssc_enable);
+
+	pr_debug("%s enabled SSC_SR=0x%08x\n",
+			dir ? "receive" : "transmit",
+			ssc_readl(ssc_p->ssc->regs, SR));
+	return 0;
+}
+
+
+#ifdef CONFIG_PM
+static int atmel_ssc_suspend(struct platform_device *pdev,
+			    struct snd_soc_dai *cpu_dai)
+{
+	struct atmel_ssc_info *ssc_p;
+
+	if (!cpu_dai->active)
+		return 0;
+
+	ssc_p = &ssc_info[cpu_dai->id];
+
+	/* Save the status register before disabling transmit and receive */
+	ssc_p->ssc_state.ssc_sr = ssc_readl(ssc_p->ssc->regs, SR);
+	ssc_writel(ssc_p->ssc->regs, CR, SSC_BIT(CR_TXDIS) | SSC_BIT(CR_RXDIS));
+
+	/* Save the current interrupt mask, then disable unmasked interrupts */
+	ssc_p->ssc_state.ssc_imr = ssc_readl(ssc_p->ssc->regs, IMR);
+	ssc_writel(ssc_p->ssc->regs, IDR, ssc_p->ssc_state.ssc_imr);
+
+	ssc_p->ssc_state.ssc_cmr = ssc_readl(ssc_p->ssc->regs, CMR);
+	ssc_p->ssc_state.ssc_rcmr = ssc_readl(ssc_p->ssc->regs, RCMR);
+	ssc_p->ssc_state.ssc_rfmr = ssc_readl(ssc_p->ssc->regs, RFMR);
+	ssc_p->ssc_state.ssc_tcmr = ssc_readl(ssc_p->ssc->regs, TCMR);
+	ssc_p->ssc_state.ssc_tfmr = ssc_readl(ssc_p->ssc->regs, TFMR);
+
+	return 0;
+}
+
+
+
+static int atmel_ssc_resume(struct platform_device *pdev,
+			   struct snd_soc_dai *cpu_dai)
+{
+	struct atmel_ssc_info *ssc_p;
+	u32 cr;
+
+	if (!cpu_dai->active)
+		return 0;
+
+	ssc_p = &ssc_info[cpu_dai->id];
+
+	/* restore SSC register settings */
+	ssc_writel(ssc_p->ssc->regs, TFMR, ssc_p->ssc_state.ssc_tfmr);
+	ssc_writel(ssc_p->ssc->regs, TCMR, ssc_p->ssc_state.ssc_tcmr);
+	ssc_writel(ssc_p->ssc->regs, RFMR, ssc_p->ssc_state.ssc_rfmr);
+	ssc_writel(ssc_p->ssc->regs, RCMR, ssc_p->ssc_state.ssc_rcmr);
+	ssc_writel(ssc_p->ssc->regs, CMR, ssc_p->ssc_state.ssc_cmr);
+
+	/* re-enable interrupts */
+	ssc_writel(ssc_p->ssc->regs, IER, ssc_p->ssc_state.ssc_imr);
+
+	/* Re-enable recieve and transmit as appropriate */
+	cr = 0;
+	cr |=
+	    (ssc_p->ssc_state.ssc_sr & SSC_BIT(SR_RXEN)) ? SSC_BIT(CR_RXEN) : 0;
+	cr |=
+	    (ssc_p->ssc_state.ssc_sr & SSC_BIT(SR_TXEN)) ? SSC_BIT(CR_TXEN) : 0;
+	ssc_writel(ssc_p->ssc->regs, CR, cr);
+
+	return 0;
+}
+#else /* CONFIG_PM */
+#  define atmel_ssc_suspend	NULL
+#  define atmel_ssc_resume	NULL
+#endif /* CONFIG_PM */
+
+
+#define ATMEL_SSC_RATES (SNDRV_PCM_RATE_8000_96000)
+
+#define ATMEL_SSC_FORMATS (SNDRV_PCM_FMTBIT_S8     | SNDRV_PCM_FMTBIT_S16_LE |\
+			  SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE)
+
+struct snd_soc_dai atmel_ssc_dai[NUM_SSC_DEVICES] = {
+	{	.name = "atmel-ssc0",
+		.id = 0,
+		.type = SND_SOC_DAI_PCM,
+		.suspend = atmel_ssc_suspend,
+		.resume = atmel_ssc_resume,
+		.playback = {
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = ATMEL_SSC_RATES,
+			.formats = ATMEL_SSC_FORMATS,},
+		.capture = {
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = ATMEL_SSC_RATES,
+			.formats = ATMEL_SSC_FORMATS,},
+		.ops = {
+			.startup = atmel_ssc_startup,
+			.shutdown = atmel_ssc_shutdown,
+			.prepare = atmel_ssc_prepare,
+			.hw_params = atmel_ssc_hw_params,},
+		.dai_ops = {
+			.set_fmt = atmel_ssc_set_dai_fmt,
+			.set_clkdiv = atmel_ssc_set_dai_clkdiv,},
+		.private_data = &ssc_info[0],
+	},
+#if NUM_SSC_DEVICES == 3
+	{	.name = "atmel-ssc1",
+		.id = 1,
+		.type = SND_SOC_DAI_PCM,
+		.suspend = atmel_ssc_suspend,
+		.resume = atmel_ssc_resume,
+		.playback = {
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = ATMEL_SSC_RATES,
+			.formats = ATMEL_SSC_FORMATS,},
+		.capture = {
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = ATMEL_SSC_RATES,
+			.formats = ATMEL_SSC_FORMATS,},
+		.ops = {
+			.startup = atmel_ssc_startup,
+			.shutdown = atmel_ssc_shutdown,
+			.prepare = atmel_ssc_prepare,
+			.hw_params = atmel_ssc_hw_params,},
+		.dai_ops = {
+			.set_fmt = atmel_ssc_set_dai_fmt,
+			.set_clkdiv = atmel_ssc_set_dai_clkdiv,},
+		.private_data = &ssc_info[1],
+	},
+	{	.name = "atmel-ssc2",
+		.id = 2,
+		.type = SND_SOC_DAI_PCM,
+		.suspend = atmel_ssc_suspend,
+		.resume = atmel_ssc_resume,
+		.playback = {
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = ATMEL_SSC_RATES,
+			.formats = ATMEL_SSC_FORMATS,},
+		.capture = {
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = ATMEL_SSC_RATES,
+			.formats = ATMEL_SSC_FORMATS,},
+		.ops = {
+			.startup = atmel_ssc_startup,
+			.shutdown = atmel_ssc_shutdown,
+			.prepare = atmel_ssc_prepare,
+			.hw_params = atmel_ssc_hw_params,},
+		.dai_ops = {
+			.set_fmt = atmel_ssc_set_dai_fmt,
+			.set_clkdiv = atmel_ssc_set_dai_clkdiv,},
+		.private_data = &ssc_info[2],
+	},
+#endif
+};
+EXPORT_SYMBOL_GPL(atmel_ssc_dai);
+
+/* Module information */
+MODULE_AUTHOR("Sedji Gaouaou, sedji.gaouaou@atmel.com, www.atmel.com");
+MODULE_DESCRIPTION("ATMEL SSC ASoC Interface");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/atmel/atmel_ssc_dai.h b/sound/soc/atmel/atmel_ssc_dai.h
new file mode 100644
index 0000000..a828746
--- /dev/null
+++ b/sound/soc/atmel/atmel_ssc_dai.h
@@ -0,0 +1,121 @@
+/*
+ * atmel_ssc_dai.h - ALSA SSC interface for the Atmel  SoC
+ *
+ * Copyright (C) 2005 SAN People
+ * Copyright (C) 2008 Atmel
+ *
+ * Author: Sedji Gaouaou <sedji.gaouaou@atmel.com>
+ *         ATMEL CORP.
+ *
+ * Based on at91-ssc.c by
+ * Frank Mandarino <fmandarino@endrelia.com>
+ * Based on pxa2xx Platform drivers by
+ * Liam Girdwood <liam.girdwood@wolfsonmicro.com>
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
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#ifndef _ATMEL_SSC_DAI_H
+#define _ATMEL_SSC_DAI_H
+
+#include <linux/types.h>
+#include <linux/atmel-ssc.h>
+
+#include "atmel-pcm.h"
+
+/* SSC system clock ids */
+#define ATMEL_SYSCLK_MCK	0 /* SSC uses AT91 MCK as system clock */
+
+/* SSC divider ids */
+#define ATMEL_SSC_CMR_DIV	0 /* MCK divider for BCLK */
+#define ATMEL_SSC_TCMR_PERIOD	1 /* BCLK divider for transmit FS */
+#define ATMEL_SSC_RCMR_PERIOD	2 /* BCLK divider for receive FS */
+/*
+ * SSC direction masks
+ */
+#define SSC_DIR_MASK_UNUSED	0
+#define SSC_DIR_MASK_PLAYBACK	1
+#define SSC_DIR_MASK_CAPTURE	2
+
+/*
+ * SSC register values that Atmel left out of <linux/atmel-ssc.h>.  These
+ * are expected to be used with SSC_BF
+ */
+/* START bit field values */
+#define SSC_START_CONTINUOUS	0
+#define SSC_START_TX_RX		1
+#define SSC_START_LOW_RF	2
+#define SSC_START_HIGH_RF	3
+#define SSC_START_FALLING_RF	4
+#define SSC_START_RISING_RF	5
+#define SSC_START_LEVEL_RF	6
+#define SSC_START_EDGE_RF	7
+#define SSS_START_COMPARE_0	8
+
+/* CKI bit field values */
+#define SSC_CKI_FALLING		0
+#define SSC_CKI_RISING		1
+
+/* CKO bit field values */
+#define SSC_CKO_NONE		0
+#define SSC_CKO_CONTINUOUS	1
+#define SSC_CKO_TRANSFER	2
+
+/* CKS bit field values */
+#define SSC_CKS_DIV		0
+#define SSC_CKS_CLOCK		1
+#define SSC_CKS_PIN		2
+
+/* FSEDGE bit field values */
+#define SSC_FSEDGE_POSITIVE	0
+#define SSC_FSEDGE_NEGATIVE	1
+
+/* FSOS bit field values */
+#define SSC_FSOS_NONE		0
+#define SSC_FSOS_NEGATIVE	1
+#define SSC_FSOS_POSITIVE	2
+#define SSC_FSOS_LOW		3
+#define SSC_FSOS_HIGH		4
+#define SSC_FSOS_TOGGLE		5
+
+#define START_DELAY		1
+
+struct atmel_ssc_state {
+	u32 ssc_cmr;
+	u32 ssc_rcmr;
+	u32 ssc_rfmr;
+	u32 ssc_tcmr;
+	u32 ssc_tfmr;
+	u32 ssc_sr;
+	u32 ssc_imr;
+};
+
+
+struct atmel_ssc_info {
+	char *name;
+	struct ssc_device *ssc;
+	spinlock_t lock;	/* lock for dir_mask */
+	unsigned short dir_mask;	/* 0=unused, 1=playback, 2=capture */
+	unsigned short initialized;	/* true if SSC has been initialized */
+	unsigned short daifmt;
+	unsigned short cmr_div;
+	unsigned short tcmr_period;
+	unsigned short rcmr_period;
+	struct atmel_pcm_dma_params *dma_params[2];
+	struct atmel_ssc_state ssc_state;
+};
+extern struct snd_soc_dai atmel_ssc_dai[];
+
+#endif /* _AT91_SSC_DAI_H */
diff --git a/sound/soc/at32/playpaq_wm8510.c b/sound/soc/atmel/playpaq_wm8510.c
similarity index 99%
rename from sound/soc/at32/playpaq_wm8510.c
rename to sound/soc/atmel/playpaq_wm8510.c
index b1966e4..5b07cf7 100644
--- a/sound/soc/at32/playpaq_wm8510.c
+++ b/sound/soc/atmel/playpaq_wm8510.c
@@ -40,8 +40,8 @@
 #include <mach/portmux.h>
 
 #include "../codecs/wm8510.h"
-#include "at32-pcm.h"
-#include "at32-ssc.h"
+#include "atmel-pcm.h"
+#include "atmel_ssc_dai.h"
 
 
 /*-------------------------------------------------------------------------*\
-- 
1.5.6.5
