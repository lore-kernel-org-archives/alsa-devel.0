From: Sedji Gaouaou <sedji.gaouaou@atmel.com>
Subject: [PATCH] [patch 1/2]AC97: add AC97 support for AT91.
Date: Thu, 25 Feb 2010 18:59:30 +0100
Message-ID: <1267120770-1752-1-git-send-email-sedji.gaouaou@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from atmel-es2.atmel.fr (mail.atmel.fr [81.80.104.162])
	by alsa0.perex.cz (Postfix) with ESMTP id D751D10397C
	for <alsa-devel@alsa-project.org>; Thu, 25 Feb 2010 17:47:15 +0100 (CET)
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
Cc: sedji.gaouaou@atmel.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

This patch add AC97 support for ATMEL AT91, using the AVR32 code.
While AVR is using a DMA, the AT91 chips are using a Peripheral Data
Controller.

Signed-off-by: Sedji Gaouaou <sedji.gaouaou@atmel.com>
---
 sound/atmel/Kconfig |    2 +-
 sound/atmel/ac97c.c |  309 +++++++++++++++++++++++++++++++++++++--------------
 2 files changed, 226 insertions(+), 85 deletions(-)

diff --git a/sound/atmel/Kconfig b/sound/atmel/Kconfig
index 6c228a9..94de43a 100644
--- a/sound/atmel/Kconfig
+++ b/sound/atmel/Kconfig
@@ -12,7 +12,7 @@ config SND_ATMEL_AC97C
 	tristate "Atmel AC97 Controller (AC97C) driver"
 	select SND_PCM
 	select SND_AC97_CODEC
-	depends on DW_DMAC && AVR32
+	depends on (DW_DMAC && AVR32) || ARCH_AT91
 	help
 	  ALSA sound driver for the Atmel AC97 controller.
 
diff --git a/sound/atmel/ac97c.c b/sound/atmel/ac97c.c
index 0c0f877..e765d65 100644
--- a/sound/atmel/ac97c.c
+++ b/sound/atmel/ac97c.c
@@ -13,6 +13,7 @@
 #include <linux/device.h>
 #include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
+#include <linux/atmel_pdc.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
@@ -31,6 +32,10 @@
 
 #include <linux/dw_dmac.h>
 
+#include <mach/cpu.h>
+#include <mach/hardware.h>
+#include <mach/gpio.h>
+
 #include "ac97c.h"
 
 enum {
@@ -63,6 +68,7 @@ struct atmel_ac97c {
 	u64				cur_format;
 	unsigned int			cur_rate;
 	unsigned long			flags;
+	int				playback_period, capture_period;
 	/* Serialize access to opened variable */
 	spinlock_t			lock;
 	void __iomem			*regs;
@@ -242,10 +248,12 @@ static int atmel_ac97c_playback_hw_params(struct snd_pcm_substream *substream,
 	if (retval < 0)
 		return retval;
 	/* snd_pcm_lib_malloc_pages returns 1 if buffer is changed. */
-	if (retval == 1)
-		if (test_and_clear_bit(DMA_TX_READY, &chip->flags))
-			dw_dma_cyclic_free(chip->dma.tx_chan);
-
+	if (cpu_is_at32ap7000()) {
+		/* snd_pcm_lib_malloc_pages returns 1 if buffer is changed. */
+		if (retval == 1)
+			if (test_and_clear_bit(DMA_TX_READY, &chip->flags))
+				dw_dma_cyclic_free(chip->dma.tx_chan);
+	}
 	/* Set restrictions to params. */
 	mutex_lock(&opened_mutex);
 	chip->cur_rate = params_rate(hw_params);
@@ -266,9 +274,14 @@ static int atmel_ac97c_capture_hw_params(struct snd_pcm_substream *substream,
 	if (retval < 0)
 		return retval;
 	/* snd_pcm_lib_malloc_pages returns 1 if buffer is changed. */
-	if (retval == 1)
-		if (test_and_clear_bit(DMA_RX_READY, &chip->flags))
-			dw_dma_cyclic_free(chip->dma.rx_chan);
+	if (cpu_is_at32ap7000()) {
+		if (retval < 0)
+			return retval;
+		/* snd_pcm_lib_malloc_pages returns 1 if buffer is changed. */
+		if (retval == 1)
+			if (test_and_clear_bit(DMA_RX_READY, &chip->flags))
+				dw_dma_cyclic_free(chip->dma.rx_chan);
+	}
 
 	/* Set restrictions to params. */
 	mutex_lock(&opened_mutex);
@@ -282,16 +295,20 @@ static int atmel_ac97c_capture_hw_params(struct snd_pcm_substream *substream,
 static int atmel_ac97c_playback_hw_free(struct snd_pcm_substream *substream)
 {
 	struct atmel_ac97c *chip = snd_pcm_substream_chip(substream);
-	if (test_and_clear_bit(DMA_TX_READY, &chip->flags))
-		dw_dma_cyclic_free(chip->dma.tx_chan);
+	if (cpu_is_at32ap7000()) {
+		if (test_and_clear_bit(DMA_TX_READY, &chip->flags))
+			dw_dma_cyclic_free(chip->dma.tx_chan);
+	}
 	return snd_pcm_lib_free_pages(substream);
 }
 
 static int atmel_ac97c_capture_hw_free(struct snd_pcm_substream *substream)
 {
 	struct atmel_ac97c *chip = snd_pcm_substream_chip(substream);
-	if (test_and_clear_bit(DMA_RX_READY, &chip->flags))
-		dw_dma_cyclic_free(chip->dma.rx_chan);
+	if (cpu_is_at32ap7000()) {
+		if (test_and_clear_bit(DMA_RX_READY, &chip->flags))
+			dw_dma_cyclic_free(chip->dma.rx_chan);
+	}
 	return snd_pcm_lib_free_pages(substream);
 }
 
@@ -299,9 +316,11 @@ static int atmel_ac97c_playback_prepare(struct snd_pcm_substream *substream)
 {
 	struct atmel_ac97c *chip = snd_pcm_substream_chip(substream);
 	struct snd_pcm_runtime *runtime = substream->runtime;
+	int block_size = frames_to_bytes(runtime, runtime->period_size);
 	unsigned long word = ac97c_readl(chip, OCA);
 	int retval;
 
+	chip->playback_period = 0;
 	word &= ~(AC97C_CH_MASK(PCM_LEFT) | AC97C_CH_MASK(PCM_RIGHT));
 
 	/* assign channels to AC97C channel A */
@@ -324,7 +343,8 @@ static int atmel_ac97c_playback_prepare(struct snd_pcm_substream *substream)
 
 	switch (runtime->format) {
 	case SNDRV_PCM_FORMAT_S16_LE:
-		word |= AC97C_CMR_CEM_LITTLE;
+		if (cpu_is_at32ap7000())
+			word |= AC97C_CMR_CEM_LITTLE;
 		break;
 	case SNDRV_PCM_FORMAT_S16_BE: /* fall through */
 		word &= ~(AC97C_CMR_CEM_LITTLE);
@@ -363,9 +383,18 @@ static int atmel_ac97c_playback_prepare(struct snd_pcm_substream *substream)
 		dev_dbg(&chip->pdev->dev, "could not set rate %d Hz\n",
 				runtime->rate);
 
-	if (!test_bit(DMA_TX_READY, &chip->flags))
-		retval = atmel_ac97c_prepare_dma(chip, substream,
-				DMA_TO_DEVICE);
+	if (cpu_is_at32ap7000()) {
+		if (!test_bit(DMA_TX_READY, &chip->flags))
+			retval = atmel_ac97c_prepare_dma(chip, substream,
+					DMA_TO_DEVICE);
+	} else {
+		/* Initialize and start the PDC */
+		writel(runtime->dma_addr, chip->regs + ATMEL_PDC_TPR);
+		writel(block_size / 2, chip->regs + ATMEL_PDC_TCR);
+		writel(runtime->dma_addr + block_size,
+				chip->regs + ATMEL_PDC_TNPR);
+		writel(block_size / 2, chip->regs + ATMEL_PDC_TNCR);
+	}
 
 	return retval;
 }
@@ -374,9 +403,11 @@ static int atmel_ac97c_capture_prepare(struct snd_pcm_substream *substream)
 {
 	struct atmel_ac97c *chip = snd_pcm_substream_chip(substream);
 	struct snd_pcm_runtime *runtime = substream->runtime;
+	int block_size = frames_to_bytes(runtime, runtime->period_size);
 	unsigned long word = ac97c_readl(chip, ICA);
 	int retval;
 
+	chip->capture_period = 0;
 	word &= ~(AC97C_CH_MASK(PCM_LEFT) | AC97C_CH_MASK(PCM_RIGHT));
 
 	/* assign channels to AC97C channel A */
@@ -399,7 +430,8 @@ static int atmel_ac97c_capture_prepare(struct snd_pcm_substream *substream)
 
 	switch (runtime->format) {
 	case SNDRV_PCM_FORMAT_S16_LE:
-		word |= AC97C_CMR_CEM_LITTLE;
+		if (cpu_is_at32ap7000())
+			word |= AC97C_CMR_CEM_LITTLE;
 		break;
 	case SNDRV_PCM_FORMAT_S16_BE: /* fall through */
 		word &= ~(AC97C_CMR_CEM_LITTLE);
@@ -438,9 +470,18 @@ static int atmel_ac97c_capture_prepare(struct snd_pcm_substream *substream)
 		dev_dbg(&chip->pdev->dev, "could not set rate %d Hz\n",
 				runtime->rate);
 
-	if (!test_bit(DMA_RX_READY, &chip->flags))
-		retval = atmel_ac97c_prepare_dma(chip, substream,
-				DMA_FROM_DEVICE);
+	if (cpu_is_at32ap7000()) {
+		if (!test_bit(DMA_RX_READY, &chip->flags))
+			retval = atmel_ac97c_prepare_dma(chip, substream,
+					DMA_FROM_DEVICE);
+	} else {
+		/* Initialize and start the PDC */
+		writel(runtime->dma_addr, chip->regs + ATMEL_PDC_RPR);
+		writel(block_size / 2, chip->regs + ATMEL_PDC_RCR);
+		writel(runtime->dma_addr + block_size,
+				chip->regs + ATMEL_PDC_RNPR);
+		writel(block_size / 2, chip->regs + ATMEL_PDC_RNCR);
+	}
 
 	return retval;
 }
@@ -458,15 +499,22 @@ atmel_ac97c_playback_trigger(struct snd_pcm_substream *substream, int cmd)
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE: /* fall through */
 	case SNDRV_PCM_TRIGGER_RESUME: /* fall through */
 	case SNDRV_PCM_TRIGGER_START:
-		retval = dw_dma_cyclic_start(chip->dma.tx_chan);
-		if (retval)
-			goto out;
+		if (cpu_is_at32ap7000()) {
+			retval = dw_dma_cyclic_start(chip->dma.tx_chan);
+			if (retval)
+				goto out;
+		} else {
+			ptcr = ATMEL_PDC_TXTEN;
+		}
 		camr |= AC97C_CMR_CENA;
 		break;
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH: /* fall through */
 	case SNDRV_PCM_TRIGGER_SUSPEND: /* fall through */
 	case SNDRV_PCM_TRIGGER_STOP:
-		dw_dma_cyclic_stop(chip->dma.tx_chan);
+		if (cpu_is_at32ap7000())
+			dw_dma_cyclic_stop(chip->dma.tx_chan);
+		else
+			ptcr |= ATMEL_PDC_TXTDIS;
 		if (chip->opened <= 1)
 			camr &= ~AC97C_CMR_CENA;
 		break;
@@ -476,6 +524,8 @@ atmel_ac97c_playback_trigger(struct snd_pcm_substream *substream, int cmd)
 	}
 
 	ac97c_writel(chip, CAMR, camr);
+	if (!cpu_is_at32ap7000())
+		writel(ptcr, chip->regs + ATMEL_PDC_PTCR);
 out:
 	return retval;
 }
@@ -484,24 +534,32 @@ static int
 atmel_ac97c_capture_trigger(struct snd_pcm_substream *substream, int cmd)
 {
 	struct atmel_ac97c *chip = snd_pcm_substream_chip(substream);
-	unsigned long camr;
+	unsigned long camr, casr, ptcr = 0;
 	int retval = 0;
 
 	camr = ac97c_readl(chip, CAMR);
+	ptcr = readl(chip->regs + ATMEL_PDC_PTSR);
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE: /* fall through */
 	case SNDRV_PCM_TRIGGER_RESUME: /* fall through */
 	case SNDRV_PCM_TRIGGER_START:
-		retval = dw_dma_cyclic_start(chip->dma.rx_chan);
-		if (retval)
-			goto out;
+		if (cpu_is_at32ap7000()) {
+			retval = dw_dma_cyclic_start(chip->dma.rx_chan);
+			if (retval)
+				goto out;
+		} else {
+			ptcr = ATMEL_PDC_RXTEN;
+		}
 		camr |= AC97C_CMR_CENA;
 		break;
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH: /* fall through */
 	case SNDRV_PCM_TRIGGER_SUSPEND: /* fall through */
 	case SNDRV_PCM_TRIGGER_STOP:
-		dw_dma_cyclic_stop(chip->dma.rx_chan);
+		if (cpu_is_at32ap7000())
+			dw_dma_cyclic_stop(chip->dma.rx_chan);
+		else
+			ptcr |= (ATMEL_PDC_RXTDIS);
 		if (chip->opened <= 1)
 			camr &= ~AC97C_CMR_CENA;
 		break;
@@ -511,6 +569,8 @@ atmel_ac97c_capture_trigger(struct snd_pcm_substream *substream, int cmd)
 	}
 
 	ac97c_writel(chip, CAMR, camr);
+	if (!cpu_is_at32ap7000())
+		writel(ptcr, chip->regs + ATMEL_PDC_PTCR);
 out:
 	return retval;
 }
@@ -523,7 +583,10 @@ atmel_ac97c_playback_pointer(struct snd_pcm_substream *substream)
 	snd_pcm_uframes_t	frames;
 	unsigned long		bytes;
 
-	bytes = dw_dma_get_src_addr(chip->dma.tx_chan);
+	if (cpu_is_at32ap7000())
+		bytes = dw_dma_get_src_addr(chip->dma.tx_chan);
+	else
+		bytes = readl(chip->regs + ATMEL_PDC_TPR);
 	bytes -= runtime->dma_addr;
 
 	frames = bytes_to_frames(runtime, bytes);
@@ -540,7 +603,10 @@ atmel_ac97c_capture_pointer(struct snd_pcm_substream *substream)
 	snd_pcm_uframes_t	frames;
 	unsigned long		bytes;
 
-	bytes = dw_dma_get_dst_addr(chip->dma.rx_chan);
+	if (cpu_is_at32ap7000())
+		bytes = dw_dma_get_dst_addr(chip->dma.rx_chan);
+	else
+		bytes = readl(chip->regs + ATMEL_PDC_RPR);
 	bytes -= runtime->dma_addr;
 
 	frames = bytes_to_frames(runtime, bytes);
@@ -578,8 +644,11 @@ static irqreturn_t atmel_ac97c_interrupt(int irq, void *dev)
 	u32			sr     = ac97c_readl(chip, SR);
 	u32			casr   = ac97c_readl(chip, CASR);
 	u32			cosr   = ac97c_readl(chip, COSR);
+	u32			camr   = ac97c_readl(chip, CAMR);
 
 	if (sr & AC97C_SR_CAEVT) {
+		struct snd_pcm_runtime *runtime;
+		int offset, next_period, block_size;
 		dev_info(&chip->pdev->dev, "channel A event%s%s%s%s%s%s\n",
 				casr & AC97C_CSR_OVRUN   ? " OVRUN"   : "",
 				casr & AC97C_CSR_RXRDY   ? " RXRDY"   : "",
@@ -587,6 +656,50 @@ static irqreturn_t atmel_ac97c_interrupt(int irq, void *dev)
 				casr & AC97C_CSR_TXEMPTY ? " TXEMPTY" : "",
 				casr & AC97C_CSR_TXRDY   ? " TXRDY"   : "",
 				!casr                    ? " NONE"    : "");
+		if (!cpu_is_at32ap7000()) {
+			if ((casr & camr) & AC97C_CSR_ENDTX) {
+				runtime = chip->playback_substream->runtime;
+				block_size = frames_to_bytes(runtime,
+						runtime->period_size);
+				chip->playback_period++;
+
+				if (chip->playback_period == runtime->periods)
+					chip->playback_period = 0;
+				next_period = chip->playback_period + 1;
+				if (next_period == runtime->periods)
+					next_period = 0;
+
+				offset = block_size * next_period;
+
+				writel(runtime->dma_addr + offset,
+						chip->regs + ATMEL_PDC_TNPR);
+				writel(block_size / 2,
+						chip->regs + ATMEL_PDC_TNCR);
+
+				snd_pcm_period_elapsed(
+						chip->playback_substream);
+			}
+			if ((casr & camr) & AC97C_CSR_ENDRX) {
+				runtime = chip->capture_substream->runtime;
+				block_size = frames_to_bytes(runtime,
+						runtime->period_size);
+				chip->capture_period++;
+
+				if (chip->capture_period == runtime->periods)
+					chip->capture_period = 0;
+				next_period = chip->capture_period + 1;
+				if (next_period == runtime->periods)
+					next_period = 0;
+
+				offset = block_size * next_period;
+
+				writel(runtime->dma_addr + offset,
+						chip->regs + ATMEL_PDC_RNPR);
+				writel(block_size / 2,
+						chip->regs + ATMEL_PDC_RNCR);
+				snd_pcm_period_elapsed(chip->capture_substream);
+			}
+		}
 		retval = IRQ_HANDLED;
 	}
 
@@ -617,6 +730,13 @@ static int __devinit atmel_ac97c_pcm_new(struct atmel_ac97c *chip)
 	capture = test_bit(DMA_RX_CHAN_PRESENT, &chip->flags);
 	playback = test_bit(DMA_TX_CHAN_PRESENT, &chip->flags);
 
+	if (!cpu_is_at32ap7000()) {
+		err = snd_ac97_pcm_assign(chip->ac97_bus,
+				ARRAY_SIZE(at91_ac97_pcm_defs),
+				at91_ac97_pcm_defs);
+		if (err)
+			return err;
+	}
 	retval = snd_pcm_new(chip->card, chip->card->shortname,
 			chip->pdev->id, playback, capture, &pcm);
 	if (retval)
@@ -775,7 +895,12 @@ static int __devinit atmel_ac97c_probe(struct platform_device *pdev)
 		return -ENXIO;
 	}
 
-	pclk = clk_get(&pdev->dev, "pclk");
+	if (cpu_is_at32ap7000()) {
+		pclk = clk_get(&pdev->dev, "pclk");
+	} else {
+		pclk = clk_get(&pdev->dev, "ac97_clk");
+	}
+
 	if (IS_ERR(pclk)) {
 		dev_dbg(&pdev->dev, "no peripheral clock\n");
 		return PTR_ERR(pclk);
@@ -844,44 +969,53 @@ static int __devinit atmel_ac97c_probe(struct platform_device *pdev)
 		goto err_ac97_bus;
 	}
 
-	if (pdata->rx_dws.dma_dev) {
-		struct dw_dma_slave *dws = &pdata->rx_dws;
-		dma_cap_mask_t mask;
+	if (cpu_is_at32ap7000()) {
+		if (pdata->rx_dws.dma_dev) {
+			struct dw_dma_slave *dws = &pdata->rx_dws;
+			dma_cap_mask_t mask;
 
-		dws->rx_reg = regs->start + AC97C_CARHR + 2;
+			dws->rx_reg = regs->start + AC97C_CARHR + 2;
 
-		dma_cap_zero(mask);
-		dma_cap_set(DMA_SLAVE, mask);
+			dma_cap_zero(mask);
+			dma_cap_set(DMA_SLAVE, mask);
 
-		chip->dma.rx_chan = dma_request_channel(mask, filter, dws);
+			chip->dma.rx_chan = dma_request_channel(mask, filter,
+								dws);
 
-		dev_info(&chip->pdev->dev, "using %s for DMA RX\n",
+			dev_info(&chip->pdev->dev, "using %s for DMA RX\n",
 				dev_name(&chip->dma.rx_chan->dev->device));
-		set_bit(DMA_RX_CHAN_PRESENT, &chip->flags);
-	}
+			set_bit(DMA_RX_CHAN_PRESENT, &chip->flags);
+		}
 
-	if (pdata->tx_dws.dma_dev) {
-		struct dw_dma_slave *dws = &pdata->tx_dws;
-		dma_cap_mask_t mask;
+		if (pdata->tx_dws.dma_dev) {
+			struct dw_dma_slave *dws = &pdata->tx_dws;
+			dma_cap_mask_t mask;
 
-		dws->tx_reg = regs->start + AC97C_CATHR + 2;
+			dws->tx_reg = regs->start + AC97C_CATHR + 2;
 
-		dma_cap_zero(mask);
-		dma_cap_set(DMA_SLAVE, mask);
+			dma_cap_zero(mask);
+			dma_cap_set(DMA_SLAVE, mask);
 
-		chip->dma.tx_chan = dma_request_channel(mask, filter, dws);
+			chip->dma.tx_chan = dma_request_channel(mask, filter,
+								dws);
 
-		dev_info(&chip->pdev->dev, "using %s for DMA TX\n",
+			dev_info(&chip->pdev->dev, "using %s for DMA TX\n",
 				dev_name(&chip->dma.tx_chan->dev->device));
-		set_bit(DMA_TX_CHAN_PRESENT, &chip->flags);
-	}
+			set_bit(DMA_TX_CHAN_PRESENT, &chip->flags);
+		}
 
-	if (!test_bit(DMA_RX_CHAN_PRESENT, &chip->flags) &&
-			!test_bit(DMA_TX_CHAN_PRESENT, &chip->flags)) {
-		dev_dbg(&pdev->dev, "DMA not available\n");
-		retval = -ENODEV;
-		goto err_dma;
-	}
+		if (!test_bit(DMA_RX_CHAN_PRESENT, &chip->flags) &&
+				!test_bit(DMA_TX_CHAN_PRESENT, &chip->flags)) {
+			dev_dbg(&pdev->dev, "DMA not available\n");
+			retval = -ENODEV;
+			goto err_dma;
+		}
+	} else {
+		/* Just pretend that we have DMA channel(for at91 i is actually
+		 * the PDC) */
+		set_bit(DMA_RX_CHAN_PRESENT, &chip->flags);
+		set_bit(DMA_TX_CHAN_PRESENT, &chip->flags);
+	}
 
 	retval = atmel_ac97c_pcm_new(chip);
 	if (retval) {
@@ -897,20 +1031,22 @@ static int __devinit atmel_ac97c_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, card);
 
-	dev_info(&pdev->dev, "Atmel AC97 controller at 0x%p\n",
-			chip->regs);
+	dev_info(&pdev->dev, "Atmel AC97 controller at 0x%p, irq = %d\n",
+			chip->regs, irq);
 
 	return 0;
 
 err_dma:
-	if (test_bit(DMA_RX_CHAN_PRESENT, &chip->flags))
-		dma_release_channel(chip->dma.rx_chan);
-	if (test_bit(DMA_TX_CHAN_PRESENT, &chip->flags))
-		dma_release_channel(chip->dma.tx_chan);
-	clear_bit(DMA_RX_CHAN_PRESENT, &chip->flags);
-	clear_bit(DMA_TX_CHAN_PRESENT, &chip->flags);
-	chip->dma.rx_chan = NULL;
-	chip->dma.tx_chan = NULL;
+	if (cpu_is_at32ap7000()) {
+		if (test_bit(DMA_RX_CHAN_PRESENT, &chip->flags))
+			dma_release_channel(chip->dma.rx_chan);
+		if (test_bit(DMA_TX_CHAN_PRESENT, &chip->flags))
+			dma_release_channel(chip->dma.tx_chan);
+		clear_bit(DMA_RX_CHAN_PRESENT, &chip->flags);
+		clear_bit(DMA_TX_CHAN_PRESENT, &chip->flags);
+		chip->dma.rx_chan = NULL;
+		chip->dma.tx_chan = NULL;
+	}
 err_ac97_bus:
 	snd_card_set_dev(card, NULL);
 
@@ -934,10 +1070,12 @@ static int atmel_ac97c_suspend(struct platform_device *pdev, pm_message_t msg)
 	struct snd_card *card = platform_get_drvdata(pdev);
 	struct atmel_ac97c *chip = card->private_data;
 
-	if (test_bit(DMA_RX_READY, &chip->flags))
-		dw_dma_cyclic_stop(chip->dma.rx_chan);
-	if (test_bit(DMA_TX_READY, &chip->flags))
-		dw_dma_cyclic_stop(chip->dma.tx_chan);
+	if (cpu_is_at32ap7000()) {
+		if (test_bit(DMA_RX_READY, &chip->flags))
+			dw_dma_cyclic_stop(chip->dma.rx_chan);
+		if (test_bit(DMA_TX_READY, &chip->flags))
+			dw_dma_cyclic_stop(chip->dma.tx_chan);
+	}
 	clk_disable(chip->pclk);
 
 	return 0;
@@ -949,11 +1087,12 @@ static int atmel_ac97c_resume(struct platform_device *pdev)
 	struct atmel_ac97c *chip = card->private_data;
 
 	clk_enable(chip->pclk);
-	if (test_bit(DMA_RX_READY, &chip->flags))
-		dw_dma_cyclic_start(chip->dma.rx_chan);
-	if (test_bit(DMA_TX_READY, &chip->flags))
-		dw_dma_cyclic_start(chip->dma.tx_chan);
-
+	if (cpu_is_at32ap7000()) {
+		if (test_bit(DMA_RX_READY, &chip->flags))
+			dw_dma_cyclic_start(chip->dma.rx_chan);
+		if (test_bit(DMA_TX_READY, &chip->flags))
+			dw_dma_cyclic_start(chip->dma.tx_chan);
+	}
 	return 0;
 }
 #else
@@ -978,14 +1117,16 @@ static int __devexit atmel_ac97c_remove(struct platform_device *pdev)
 	iounmap(chip->regs);
 	free_irq(chip->irq, chip);
 
-	if (test_bit(DMA_RX_CHAN_PRESENT, &chip->flags))
-		dma_release_channel(chip->dma.rx_chan);
-	if (test_bit(DMA_TX_CHAN_PRESENT, &chip->flags))
-		dma_release_channel(chip->dma.tx_chan);
-	clear_bit(DMA_RX_CHAN_PRESENT, &chip->flags);
-	clear_bit(DMA_TX_CHAN_PRESENT, &chip->flags);
-	chip->dma.rx_chan = NULL;
-	chip->dma.tx_chan = NULL;
+	if (cpu_is_at32ap7000()) {
+		if (test_bit(DMA_RX_CHAN_PRESENT, &chip->flags))
+			dma_release_channel(chip->dma.rx_chan);
+		if (test_bit(DMA_TX_CHAN_PRESENT, &chip->flags))
+			dma_release_channel(chip->dma.tx_chan);
+		clear_bit(DMA_RX_CHAN_PRESENT, &chip->flags);
+		clear_bit(DMA_TX_CHAN_PRESENT, &chip->flags);
+		chip->dma.rx_chan = NULL;
+		chip->dma.tx_chan = NULL;
+	}
 
 	snd_card_set_dev(card, NULL);
 	snd_card_free(card);
-- 
1.5.6.5
