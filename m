From: Sedji Gaouaou <sedji.gaouaou@atmel.com>
Subject: [PATCH] Add AC'97 driver for AT91SAM9263ek atmel board.
Date: Wed, 01 Oct 2008 18:24:12 +0200
Message-ID: <48E3A42C.6090202@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from atmel-es2.atmel.fr (mail.atmel.fr [81.80.104.162])
	by alsa0.perex.cz (Postfix) with ESMTP id A007C24435
	for <alsa-devel@alsa-project.org>;
	Wed,  1 Oct 2008 18:24:17 +0200 (CEST)
Received: from fwat.rfo.atmel.com (gateway [192.168.1.1])
	by atmel-es2.atmel.fr (8.11.6+Sun/8.11.6) with SMTP id m91GNRI20934
	for <alsa-devel@alsa-project.org>; Wed, 1 Oct 2008 18:23:27 +0200 (MEST)
Received: from [127.0.0.1] ([10.159.245.197])
	by meyreuil.atmel.fr (8.11.7p1+Sun/8.11.7) with ESMTP id m91GOAr20594
	for <alsa-devel@alsa-project.org>; Wed, 1 Oct 2008 18:24:10 +0200 (MEST)
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
List-Id: alsa-devel@alsa-project.org

Add AC'97 driver for AT91SAM9263ek atmel board.
The driver includes the playback and the capture.

Signed-off-by: Sedji Gaouaou <sedji.gaouaou@atmel.com>
---
 sound/arm/Kconfig     |    9 +
 sound/arm/Makefile    |    4 +
 sound/arm/at91-ac97.c |  912 +++++++++++++++++++++++++++++++++++++++++++++++++
 sound/arm/at91-ac97.h |  295 ++++++++++++++++
 4 files changed, 1220 insertions(+), 0 deletions(-)
 create mode 100644 sound/arm/at91-ac97.c
 create mode 100644 sound/arm/at91-ac97.h

diff --git a/sound/arm/Kconfig b/sound/arm/Kconfig
index f8e6de4..bfe12f7 100644
--- a/sound/arm/Kconfig
+++ b/sound/arm/Kconfig
@@ -50,5 +50,14 @@ config SND_PXA2XX_AC97
 	  Say Y or M if you want to support any AC97 codec attached to
 	  the PXA2xx AC97 interface.
 
+config SND_AT91_AC97
+	tristate "AC97 Controller driver for SAM926X familly from ATMEL"
+	depends on SND && ARCH_AT91
+	select SND_PCM
+	select SND_AC97_CODEC
+	help
+	  Say Y or M if you want to support any AC97 codec attached to
+	  the SAM926X AC97 Controller.
+
 endif	# SND_ARM
 
diff --git a/sound/arm/Makefile b/sound/arm/Makefile
index 2054de1..73fc74b 100644
--- a/sound/arm/Makefile
+++ b/sound/arm/Makefile
@@ -17,3 +17,7 @@ snd-pxa2xx-lib-$(CONFIG_SND_PXA2XX_LIB_AC97)	+= pxa2xx-ac97-lib.o
 
 obj-$(CONFIG_SND_PXA2XX_AC97)	+= snd-pxa2xx-ac97.o
 snd-pxa2xx-ac97-objs		:= pxa2xx-ac97.o
+
+obj-$(CONFIG_SND_AT91_AC97)	+= snd-at91-ac97.o
+snd-at91-ac97-objs		:= at91-ac97.o
+
diff --git a/sound/arm/at91-ac97.c b/sound/arm/at91-ac97.c
new file mode 100644
index 0000000..3dcf742
--- /dev/null
+++ b/sound/arm/at91-ac97.c
@@ -0,0 +1,912 @@
+/*
+ * at91-ac97.c  --  AC'97 driver for atmel boards.
+ *
+ *  Copyright (C) 2005 SAN People
+ *  Copyright (C) 2006 Atmel
+ *
+ * Author:	Patrice Vilchez <patrice.vilchez@atmel.com>
+ *		Sedji Gaouaou <sedji.gaouaou@atmel.com>
+ *		ATMEL CORP.
+ *
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
+#include <linux/platform_device.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/delay.h>
+#include <linux/clk.h>
+#include <linux/atmel_pdc.h>
+#include <linux/io.h>
+
+#include <sound/core.h>
+#include <sound/initval.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/ac97_codec.h>
+#include <sound/soc.h>
+
+#include <asm/cacheflush.h>
+
+#include <mach/hardware.h>
+#include <mach/gpio.h>
+#include <mach/board.h>
+
+#include "at91-ac97.h"
+
+
+/*
+ * module parameters
+ */
+static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;
+static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;
+static int enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE_PNP;
+
+module_param_array(index, int, NULL, 0444);
+MODULE_PARM_DESC(index, "Index value for AC97 controller");
+module_param_array(id, charp, NULL, 0444);
+MODULE_PARM_DESC(id, "ID string for AC97 controller");
+module_param_array(enable, bool, NULL, 0444);
+MODULE_PARM_DESC(enable, "Enable AC97 controller");
+
+typedef struct at91_ac97 {
+	spinlock_t lock;
+	void *regs;
+	int period;
+	struct clk *ac97_clk;
+	struct snd_pcm_substream *playback_substream;
+	struct snd_pcm_substream *capture_substream;
+	struct snd_card *card;
+	struct snd_pcm *pcm;
+	struct snd_ac97 *ac97;
+	struct snd_ac97_bus *ac97_bus;
+	int irq;
+	struct platform_device *pdev;
+	u8 reset_pin;
+} at91_ac97_t;
+
+
+/*
+ * PIO management functions
+ */
+void at91_ac97c_drive_reset(at91_ac97_t *chip, unsigned int value)
+{
+	at91_set_gpio_value(chip->reset_pin, value);
+}
+
+static const char driver_name[] = "at91-ac97";
+
+
+/*
+ * PCM part
+ */
+static struct snd_pcm_hardware snd_at91_ac97_playback_hw = {
+	.info			= (SNDRV_PCM_INFO_INTERLEAVED
+				   | SNDRV_PCM_INFO_MMAP
+				   | SNDRV_PCM_INFO_MMAP_VALID
+				   | SNDRV_PCM_INFO_BLOCK_TRANSFER),
+	.formats		= (SNDRV_PCM_FMTBIT_S16_LE
+				   | SNDRV_PCM_FMTBIT_S16_BE),
+	.rates			= SNDRV_PCM_RATE_CONTINUOUS,
+	.rate_min		= 8000,
+	.rate_max		= 48000,
+	.channels_min		= 2,
+	.channels_max		= 2,
+	.buffer_bytes_max	= 256*1024,
+	.period_bytes_min	= 1024,
+	.period_bytes_max	= 4*1024,
+	.periods_min		= 1,
+	.periods_max		= 64,
+};
+
+static struct snd_pcm_hardware snd_at91_ac97_capture_hw = {
+	.info			= (SNDRV_PCM_INFO_INTERLEAVED
+				   | SNDRV_PCM_INFO_MMAP
+				   | SNDRV_PCM_INFO_MMAP_VALID
+				   | SNDRV_PCM_INFO_BLOCK_TRANSFER),
+	.formats		= (SNDRV_PCM_FMTBIT_S16_LE
+				   | SNDRV_PCM_FMTBIT_S16_BE),
+	.rates			= SNDRV_PCM_RATE_CONTINUOUS,
+	.rate_min		= 8000,
+	.rate_max		= 48000,
+	.channels_min		= 1,
+	.channels_max		= 2,
+	.buffer_bytes_max	= 256*1024,
+	.period_bytes_min	= 1024,
+	.period_bytes_max	= 4*1024,
+	.periods_min		= 1,
+	.periods_max		= 64,
+};
+
+static int snd_at91_ac97_playback_open(struct snd_pcm_substream *substream)
+{
+	at91_ac97_t *chip = snd_pcm_substream_chip(substream);
+	struct snd_pcm_runtime *runtime = substream->runtime;
+
+	runtime->hw = snd_at91_ac97_playback_hw;
+	chip->playback_substream = substream;
+	chip->period = 0;
+
+	pr_debug("%s : snd_at91_ac97_playback_open\n\r", driver_name);
+
+	return 0;
+}
+
+static int snd_at91_ac97_capture_open(struct snd_pcm_substream *substream)
+{
+	at91_ac97_t *chip = snd_pcm_substream_chip(substream);
+	struct snd_pcm_runtime *runtime = substream->runtime;
+
+	runtime->hw = snd_at91_ac97_capture_hw;
+	chip->capture_substream = substream;
+	chip->period = 0;
+
+	pr_debug("%s : snd_at91_ac97_capture_open\n\r", driver_name);
+
+	return 0;
+}
+
+static int snd_at91_ac97_playback_close(struct snd_pcm_substream *substream)
+{
+	at91_ac97_t *chip = snd_pcm_substream_chip(substream);
+
+	chip->playback_substream = NULL;
+
+	return 0;
+}
+
+static int snd_at91_ac97_capture_close(struct snd_pcm_substream *substream)
+{
+	at91_ac97_t *chip = snd_pcm_substream_chip(substream);
+
+	chip->capture_substream = NULL;
+
+	return 0;
+}
+
+static int snd_at91_ac97_playback_hw_params(struct snd_pcm_substream *substream,
+				    struct snd_pcm_hw_params *hw_params)
+{
+	int err;
+
+	err = snd_pcm_lib_malloc_pages(substream,
+				       params_buffer_bytes(hw_params));
+
+	return err;
+}
+
+static int snd_at91_ac97_capture_hw_params(struct snd_pcm_substream *substream,
+				    struct snd_pcm_hw_params *hw_params)
+{
+	int err;
+
+	err = snd_pcm_lib_malloc_pages(substream,
+				       params_buffer_bytes(hw_params));
+
+	return err;
+}
+
+static int snd_at91_ac97_playback_hw_free(struct snd_pcm_substream *substream)
+{
+
+	snd_pcm_lib_free_pages(substream);
+
+	return 0;
+}
+
+static int snd_at91_ac97_capture_hw_free(struct snd_pcm_substream *substream)
+{
+
+	snd_pcm_lib_free_pages(substream);
+
+	return 0;
+}
+
+static int snd_at91_ac97_playback_prepare(struct snd_pcm_substream *substream)
+{
+	at91_ac97_t *chip = snd_pcm_substream_chip(substream);
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	int block_size = frames_to_bytes(runtime, runtime->period_size);
+	unsigned long word = 0;
+
+	pr_debug("%s : block_size = %d\n\r", driver_name, block_size);
+
+	/* Assign slots to channels */
+	switch (substream->runtime->channels) {
+	/* TODO: Support more than two channels */
+	case 1:
+		word |= AT91C_AC97C_CHID3_CA;
+		break;
+	case 2:
+	default:
+		/* Assign Left and Right slots (3,4) to Channel A */
+		word |= AT91C_AC97C_CHID3_CA | AT91C_AC97C_CHID4_CA;
+		break;
+	}
+
+	ac97c_writel(chip, OCA, word);
+
+	/*
+	 * Configure sample format and size..
+	 */
+	word = AT91C_AC97C_PDCEN | AT91C_AC97C_SIZE_16_BITS;
+
+	switch (runtime->format) {
+	case SNDRV_PCM_FORMAT_S16_BE:
+		word |= AT91C_AC97C_CEM;
+		break;
+	case SNDRV_PCM_FORMAT_S16_LE:
+	default:
+		break;
+	}
+
+	ac97c_writel(chip, CAMR, word);
+
+	/* Set variable rate if needed */
+	if (runtime->rate != 48000) {
+		word = ac97c_readl(chip, MR);
+		word |= AT91C_AC97C_VRA;
+		ac97c_writel(chip, MR, word);
+	} else {
+		/* Clear Variable Rate Bit */
+		word = ac97c_readl(chip, MR);
+		word &= ~AT91C_AC97C_VRA;
+		ac97c_writel(chip, MR, word);
+	}
+
+	/* Set rate */
+	snd_ac97_set_rate(chip->ac97, AC97_PCM_FRONT_DAC_RATE, runtime->rate);
+
+	pr_debug("%s : dma_addr = %x\n\r : dma_area = %x\n\r"
+			" : dma_bytes = %d\n\r",
+			driver_name, runtime->dma_addr,
+			runtime->dma_area, runtime->dma_bytes);
+
+	/* Initialize and start the PDC */
+	writel(runtime->dma_addr, chip->regs + ATMEL_PDC_TPR);
+	writel(block_size / 2, chip->regs + ATMEL_PDC_TCR);
+	writel(runtime->dma_addr + block_size, chip->regs + ATMEL_PDC_TNPR);
+	writel(block_size / 2, chip->regs + ATMEL_PDC_TNCR);
+
+	/* Enable Channel A interrupts */
+	ac97c_writel(chip, IER, AT91C_AC97C_CAEVT);
+
+	pr_debug("%s : snd_at91_ac97_playback_prepare\n\r", driver_name);
+
+	return 0;
+}
+
+static int snd_at91_ac97_capture_prepare(struct snd_pcm_substream *substream)
+{
+	at91_ac97_t *chip = snd_pcm_substream_chip(substream);
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	int block_size = frames_to_bytes(runtime, runtime->period_size);
+	unsigned long word = 0;
+
+	pr_debug("%s : block_size = %d\n\r", driver_name, block_size);
+
+
+	/* Assign slots to channels */
+	switch (substream->runtime->channels) {
+	/* TODO: Support more than two channels */
+	case 1:
+		word |= AT91C_AC97C_CHID3_CA;
+		break;
+	case 2:
+	default:
+		/* Assign Left and Right slots (3,4) to Channel A */
+		word |= AT91C_AC97C_CHID3_CA | AT91C_AC97C_CHID4_CA;
+		break;
+	}
+
+	ac97c_writel(chip, ICA, word);
+
+	/*
+	 * Configure sample format and size.
+	 */
+	word = AT91C_AC97C_PDCEN | AT91C_AC97C_SIZE_16_BITS;
+
+	switch (runtime->format) {
+	case SNDRV_PCM_FORMAT_S16_BE:
+		word |= AT91C_AC97C_CEM;
+		break;
+	case SNDRV_PCM_FORMAT_S16_LE:
+		break;
+	}
+
+	ac97c_writel(chip, CAMR, word);
+
+	/* Set variable rate if needed */
+	if (runtime->rate != 48000) {
+		word = ac97c_readl(chip, MR);
+		word |= AT91C_AC97C_VRA;
+		ac97c_writel(chip, MR, word);
+	} else {
+		/* Clear Variable Rate Bit */
+		word = ac97c_readl(chip, MR);
+		word &= ~AT91C_AC97C_VRA;
+		ac97c_writel(chip, MR, word);
+	}
+
+	/* Set rate */
+	snd_ac97_set_rate(chip->ac97, AC97_PCM_LR_ADC_RATE, runtime->rate);
+
+	pr_debug("%s : dma_addr = %x\n\r : dma_area = %x\n\r"
+			" : dma_bytes = %d\n\r",
+			driver_name, runtime->dma_addr,
+			runtime->dma_area, runtime->dma_bytes);
+
+	/* Initialize and start the PDC */
+	writel(runtime->dma_addr, chip->regs + ATMEL_PDC_RPR);
+	writel(block_size / 2, chip->regs + ATMEL_PDC_RCR);
+	writel(runtime->dma_addr + block_size, chip->regs + ATMEL_PDC_RNPR);
+	writel(block_size / 2, chip->regs + ATMEL_PDC_RNCR);
+
+	/* Enable Channel A interrupts */
+	ac97c_writel(chip, IER, AT91C_AC97C_CAEVT);
+
+	pr_debug("%s : snd_at91_ac97_capture_prepare\n\r", driver_name);
+
+	return 0;
+}
+
+static int snd_at91_ac97_playback_trigger(struct snd_pcm_substream *substream,
+						int cmd)
+{
+	at91_ac97_t *chip = snd_pcm_substream_chip(substream);
+	unsigned long camr, ptcr = 0, flags;
+	int err = 0;
+
+	spin_lock_irqsave(&chip->lock, flags);
+	camr = ac97c_readl(chip, CAMR);
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		camr |= (AT91C_AC97C_CEN | AT91C_AC97C_ENDTX);
+		ptcr = ATMEL_PDC_TXTEN;
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+		camr &= ~(AT91C_AC97C_CEN | AT91C_AC97C_ENDTX);
+		ptcr = ATMEL_PDC_TXTDIS;
+		break;
+	default:
+		err = -EINVAL;
+		break;
+	}
+
+	ac97c_writel(chip, CAMR, camr);
+
+	writel(ptcr, chip->regs + ATMEL_PDC_PTCR);
+
+	spin_unlock_irqrestore(&chip->lock, flags);
+
+	pr_debug("%s : snd_at91_ac97_playback_trigger\n\r", driver_name);
+
+	return err;
+}
+
+static int snd_at91_ac97_capture_trigger(struct snd_pcm_substream *substream,
+						int cmd)
+{
+	at91_ac97_t *chip = snd_pcm_substream_chip(substream);
+	unsigned long camr, ptcr = 0, flags;
+	int err = 0;
+
+	spin_lock_irqsave(&chip->lock, flags);
+	camr = ac97c_readl(chip, CAMR);
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		camr |= (AT91C_AC97C_CEN |
+				AT91C_AC97C_ENDRX |
+				AT91C_AC97C_OVRUN);
+		ptcr = ATMEL_PDC_RXTEN;
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+		camr &= ~(AT91C_AC97C_CEN |
+				AT91C_AC97C_ENDRX |
+				AT91C_AC97C_OVRUN);
+		ptcr = ATMEL_PDC_RXTDIS;
+		break;
+	default:
+		err = -EINVAL;
+		break;
+	}
+
+	ac97c_writel(chip, CAMR, camr);
+
+	writel(ptcr, chip->regs + ATMEL_PDC_PTCR);
+
+	spin_unlock_irqrestore(&chip->lock, flags);
+
+	pr_debug("%s : snd_at91_ac97_capture_trigger\n\r", driver_name);
+
+	return err;
+}
+
+static snd_pcm_uframes_t
+snd_at91_ac97_playback_pointer(struct snd_pcm_substream *substream)
+{
+	at91_ac97_t *chip = snd_pcm_substream_chip(substream);
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	snd_pcm_uframes_t pos;
+	unsigned long bytes;
+
+	bytes = readl(chip->regs + ATMEL_PDC_TPR) - runtime->dma_addr;
+
+	pos = bytes_to_frames(runtime, bytes);
+
+	if (pos >= runtime->buffer_size)
+		pos -= runtime->buffer_size;
+
+	pr_debug("%s : snd_at91_ac97_playback_pointer\n\r", driver_name);
+
+	return pos;
+}
+
+static  snd_pcm_uframes_t
+snd_at91_ac97_capture_pointer(struct snd_pcm_substream *substream)
+{
+	at91_ac97_t *chip = snd_pcm_substream_chip(substream);
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	snd_pcm_uframes_t pos;
+	unsigned long bytes;
+
+	bytes = readl(chip->regs + ATMEL_PDC_RPR) - runtime->dma_addr;
+	pos = bytes_to_frames(runtime, bytes);
+	if (pos >= runtime->buffer_size)
+		pos -= runtime->buffer_size;
+
+	pr_debug("%s : snd_at91_ac97_capture_pointer\n\r", driver_name);
+
+	return pos;
+}
+
+static struct snd_pcm_ops at91_ac97_playback_ops = {
+	.open		= snd_at91_ac97_playback_open,
+	.close		= snd_at91_ac97_playback_close,
+	.ioctl		= snd_pcm_lib_ioctl,
+	.hw_params	= snd_at91_ac97_playback_hw_params,
+	.hw_free	= snd_at91_ac97_playback_hw_free,
+	.prepare	= snd_at91_ac97_playback_prepare,
+	.trigger	= snd_at91_ac97_playback_trigger,
+	.pointer	= snd_at91_ac97_playback_pointer,
+};
+
+static struct snd_pcm_ops at91_ac97_capture_ops = {
+	.open		= snd_at91_ac97_capture_open,
+	.close		= snd_at91_ac97_capture_close,
+	.ioctl		= snd_pcm_lib_ioctl,
+	.hw_params	= snd_at91_ac97_capture_hw_params,
+	.hw_free	= snd_at91_ac97_capture_hw_free,
+	.prepare	= snd_at91_ac97_capture_prepare,
+	.trigger	= snd_at91_ac97_capture_trigger,
+	.pointer	= snd_at91_ac97_capture_pointer,
+};
+
+static struct ac97_pcm at91_ac97_pcm_defs[] __devinitdata = {
+	/* Playback */
+	{
+		.exclusive = 1,
+		.r = { {
+			.slots = ((1 << AC97_SLOT_PCM_LEFT)
+				  | (1 << AC97_SLOT_PCM_RIGHT)),
+		} },
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
+			.slots = (1<<AC97_SLOT_MIC),
+		} }
+	},
+};
+
+static int __devinit snd_at91_ac97_pcm_new(at91_ac97_t *chip)
+{
+	struct snd_pcm *pcm;
+	int err;
+
+	err = snd_ac97_pcm_assign(chip->ac97_bus,
+					ARRAY_SIZE(at91_ac97_pcm_defs),
+					at91_ac97_pcm_defs);
+	if (err)
+		return err;
+
+	err = snd_pcm_new(chip->card, "Atmel AC97", 0, 1, 1, &pcm);
+	if (err)
+		return err;
+
+	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
+					      &chip->pdev->dev,
+					      128 * 1024, 256 * 1024);
+
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK,
+					&at91_ac97_playback_ops);
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &at91_ac97_capture_ops);
+
+	pcm->private_data = chip;
+	pcm->info_flags = 0;
+	strcpy(pcm->name, "Atmel AC97");
+	chip->pcm = pcm;
+
+	return 0;
+}
+
+
+/*
+ * Mixer part
+ */
+static int snd_at91_ac97_mixer_new(at91_ac97_t *chip)
+{
+	int err;
+	struct snd_ac97_template template;
+
+	memset(&template, 0, sizeof(template));
+	template.private_data = chip;
+	template.num = 0;
+	template.addr = 0;
+	err = snd_ac97_mixer(chip->ac97_bus, &template, &chip->ac97);
+
+	return err;
+}
+
+static irqreturn_t snd_at91_ac97_interrupt(int irq, void *dev_id)
+{
+	at91_ac97_t *chip = dev_id;
+	unsigned long status;
+	unsigned long dummy;
+
+	status = ac97c_readl(chip, SR);
+
+	if (status & AT91C_AC97C_CAEVT) {
+		struct snd_pcm_runtime *runtime;
+		int offset, next_period, block_size;
+		unsigned long casr, camr, test;
+
+		casr = ac97c_readl(chip, CASR);
+		camr = ac97c_readl(chip, CAMR);
+		test = casr & camr;
+
+		if ((casr & camr) & AT91C_AC97C_ENDTX) {
+			runtime = chip->playback_substream->runtime;
+			block_size = frames_to_bytes(runtime,
+							runtime->period_size);
+			chip->period++;
+
+			if (chip->period == runtime->periods)
+				chip->period = 0;
+			next_period = chip->period + 1;
+			if (next_period == runtime->periods)
+				next_period = 0;
+
+			offset = block_size * next_period;
+
+			writel(runtime->dma_addr + offset,
+						chip->regs + ATMEL_PDC_TNPR);
+			writel(block_size / 2, chip->regs + ATMEL_PDC_TNCR);
+
+			snd_pcm_period_elapsed(chip->playback_substream);
+		}
+		if ((casr & camr) & AT91C_AC97C_ENDRX) {
+			runtime = chip->capture_substream->runtime;
+			block_size = frames_to_bytes(runtime,
+							runtime->period_size);
+			chip->period++;
+
+			if (chip->period == runtime->periods)
+				chip->period = 0;
+			next_period = chip->period + 1;
+			if (next_period == runtime->periods)
+				next_period = 0;
+
+			offset = block_size * next_period;
+
+			writel(runtime->dma_addr + offset,
+						chip->regs + ATMEL_PDC_RNPR);
+			writel(block_size / 2, chip->regs + ATMEL_PDC_RNCR);
+			snd_pcm_period_elapsed(chip->capture_substream);
+		}
+		if ((casr & camr) & AT91C_AC97C_OVRUN)
+			printk(KERN_INFO " AC97_irq - overrun!\n");
+	} else {
+		printk(KERN_WARNING
+		       "Spurious AC97 interrupt, status = 0x%08lx\n",
+		       status);
+	}
+
+	dummy = ac97c_readl(chip, SR);
+
+	return IRQ_HANDLED;
+}
+
+
+/*
+ * CODEC part
+ */
+static void snd_at91_ac97_hard_reset(at91_ac97_t *chip)
+{
+       /* Enable AC97 Controller.*/
+       /* Perform a cold (hard) reset of the AC97 codec.*/
+       ac97c_writel(chip, MR, 0);
+       ac97c_writel(chip, MR, AT91C_AC97C_ENA);
+
+       at91_ac97c_drive_reset(chip, 0);
+       udelay(1);
+       at91_ac97c_drive_reset(chip, 1);
+       udelay(1);
+}
+
+static void snd_at91_ac97_write(struct snd_ac97 *ac97, unsigned short reg,
+				 unsigned short val)
+{
+	at91_ac97_t *chip = ac97->private_data;
+	unsigned long word;
+	int timeout = 0x100;
+
+	pr_debug("%s : Writing codec register 0x%x = 0x%x\n\r",
+						driver_name, reg, val);
+
+	word = (reg & 0x7f) << 16 | val;
+
+	do {
+		if (ac97c_readl(chip, COSR) & AT91C_AC97C_TXRDY) {
+			ac97c_writel(chip, COTHR, word);
+			return;
+		}
+		udelay(1);
+	} while (--timeout);
+
+	snd_printk(KERN_WARNING "at91-ac97: codec write timeout\n\r");
+}
+
+static unsigned short snd_at91_ac97_read(struct snd_ac97 *ac97,
+					  unsigned short reg)
+{
+	at91_ac97_t *chip = ac97->private_data;
+	unsigned long word;
+	int timeout = 40;
+
+	word = (0x80 | (reg & 0x7f)) << 16;
+
+	do {
+		if (ac97c_readl(chip, COSR) & AT91C_AC97C_TXRDY) {
+			ac97c_writel(chip, COTHR, word);
+			break;
+		}
+		udelay(1);
+	} while (--timeout);
+
+	if (!timeout)
+		goto timed_out;
+
+	timeout = 0x100;
+
+	do {
+		if (ac97c_readl(chip, COSR) & AT91C_AC97C_RXRDY) {
+			unsigned short val =
+				(unsigned short) ac97c_readl(chip, CORHR);
+			return val;
+		}
+		udelay(1);
+	} while (--timeout);
+
+	if (!timeout)
+		goto timed_out;
+
+timed_out:
+	snd_printk(KERN_WARNING "at91-ac97: codec write timeout\n\r");
+	return 0xffff;
+}
+
+static void snd_at91_ac97_warm_reset(struct snd_ac97 *ac97)
+{
+	at91_ac97_t *chip = ac97->private_data;
+	unsigned int mr = ac97c_readl(chip, MR);
+
+	mr |= AT91C_AC97C_WRST;
+
+	ac97c_writel(chip, MR, mr);
+	udelay(1);
+
+	mr &= ~AT91C_AC97C_WRST;
+	ac97c_writel(chip, MR, mr);
+}
+
+static void snd_at91_ac97_destroy(struct snd_card *card)
+{
+	at91_ac97_t *chip = get_chip(card);
+
+	if (chip->irq != -1)
+		free_irq(chip->irq, chip);
+
+	if (chip->regs)
+		iounmap(chip->regs);
+}
+
+static int __devinit snd_at91_ac97_create(struct snd_card *card,
+					   struct platform_device *pdev)
+{
+	static struct snd_ac97_bus_ops ops = {
+		.write	= snd_at91_ac97_write,
+		.read	= snd_at91_ac97_read,
+		.reset  = snd_at91_ac97_warm_reset,
+	};
+
+	at91_ac97_t *chip = get_chip(card);
+	int irq, err = 0;
+
+
+
+	card->private_free = snd_at91_ac97_destroy;
+
+	spin_lock_init(&chip->lock);
+	chip->card = card;
+	chip->pdev = pdev;
+	chip->irq = -1;
+
+	if (!(platform_resource_flags(pdev, 0) & IORESOURCE_MEM)
+	    || !(platform_resource_flags(pdev, 1) & IORESOURCE_IRQ))
+		return -ENODEV;
+
+	irq = platform_resource_start(pdev, 1);
+
+	err = request_irq(irq, snd_at91_ac97_interrupt, 0, "ac97", chip);
+	if (err) {
+		snd_printk(KERN_WARNING "unable to request IRQ%d\n", irq);
+		return err;
+	}
+
+	chip->irq = irq;
+	snd_printk(KERN_INFO "AC97C regs = %08X \n",
+					platform_resource_start(pdev, 0));
+	snd_printk(KERN_INFO "AC97C irq  = %d \n", irq);
+
+	chip->regs = ioremap(platform_resource_start(pdev, 0),
+			     platform_resource_len(pdev, 0));
+	if (!chip->regs) {
+		snd_printk(KERN_WARNING "unable to remap AC97C io memory\n");
+		return -ENOMEM;
+	}
+
+	snd_card_set_dev(card, &pdev->dev);
+
+	err = snd_ac97_bus(card, 0, &ops, chip, &chip->ac97_bus);
+
+	return err;
+}
+
+static int __devinit snd_at91_ac97_probe(struct platform_device *pdev)
+{
+	static int dev;
+	struct atmel_ac97_data *pdata = pdev->dev.platform_data;
+	struct snd_card *card;
+	at91_ac97_t *chip;
+	int err;
+
+	if (dev >= SNDRV_CARDS)
+		return -ENODEV;
+	if (!enable[dev]) {
+		dev++;
+		return -ENOENT;
+	}
+
+	card = snd_card_new(index[dev], id[dev], THIS_MODULE,
+			    sizeof(at91_ac97_t));
+	if (!card)
+		return -ENOMEM;
+	chip = get_chip(card);
+
+	err = snd_at91_ac97_create(card, pdev);
+	if (err)
+		goto out_free_card;
+
+	/* Enable AC97 Controller clock*/
+	chip->reset_pin = pdata->reset_pin;
+	chip->ac97_clk = clk_get(NULL, "ac97_clk");
+	if (!chip->ac97_clk)
+		goto out_free_card;
+
+	clk_enable(chip->ac97_clk);
+
+	/* Perform a codec hard reset.*/
+	/* This also enables the AC97 Controller.*/
+	snd_at91_ac97_hard_reset(chip);
+
+	err = snd_at91_ac97_mixer_new(chip);
+	if (err)
+		goto out_free_card;
+
+	err = snd_at91_ac97_pcm_new(chip);
+	if (err)
+		goto out_free_card;
+
+	strcpy(card->driver, "ac97c");
+	strcpy(card->shortname, "Atmel AC97");
+	sprintf(card->longname, "Atmel AC97 Controller at %#lx, irq %i",
+		(unsigned long) platform_resource_start(pdev, 0),
+		(int) chip->irq);
+
+	err = snd_card_register(card);
+	if (err)
+		goto out_free_card;
+
+	dev_set_drvdata(&pdev->dev, card);
+	dev++;
+	return 0;
+
+out_free_card:
+	snd_card_free(card);
+	return err;
+}
+
+static int __devexit snd_at91_ac97_remove(struct  platform_device *pdev)
+{
+	struct snd_card *card = dev_get_drvdata(&pdev->dev);
+	at91_ac97_t *chip = get_chip(card);
+
+
+	snd_card_free(card);
+
+	/* Disable AC97 Controller*/
+	ac97c_writel(chip, MR, 0);
+
+	/* Disable AC97 Controller clock*/
+	clk_disable(chip->ac97_clk);
+
+	dev_set_drvdata(&pdev->dev, NULL);
+
+	return 0;
+}
+
+static struct platform_driver at91_ac97_driver = {
+	.probe      = snd_at91_ac97_probe,
+	.remove     = __devexit_p(snd_at91_ac97_remove),
+	.driver     =
+	{
+		.name       = "ac97c",
+	}
+	,
+};
+
+static int __init at91_ac97_init(void)
+{
+	return platform_driver_register(&at91_ac97_driver);
+}
+
+static void __exit at91_ac97_exit(void)
+{
+	platform_driver_unregister(&at91_ac97_driver);
+}
+
+module_init(at91_ac97_init);
+module_exit(at91_ac97_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Driver for Atmel AC97 Controller");
+MODULE_AUTHOR("Atmel");
+
diff --git a/sound/arm/at91-ac97.h b/sound/arm/at91-ac97.h
new file mode 100644
index 0000000..e945f5d
--- /dev/null
+++ b/sound/arm/at91-ac97.h
@@ -0,0 +1,295 @@
+/*
+ * at91-ac97.h  --  Hardware definition for the ac97c peripheral
+ * 			in the ATMEL at91sam926x processor
+ *
+ *  Copyright (C) 2005 SAN People
+ *  Copyright (C) 2006 Atmel
+ *
+ * Author:	Patrice Vilchez <patrice.vilchez@atmel.com>
+ *		ATMEL CORP.
+ *
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
+#ifndef __AC97C_H
+#define __AC97C_H
+
+/* -------------------------------------------------------- */
+/* AC97C ID definitions for  AT91SAM926x           */
+/* -------------------------------------------------------- */
+#ifndef AT91C_ID_AC97C
+#define AT91C_ID_AC97C 	18 /**< AC97 Controller id */
+#endif /* AT91C_ID_AC97C */
+
+/* -------------------------------------------------------- */
+/* AC97C Base Address definitions for  AT91SAM926x   */
+/* -------------------------------------------------------- */
+#define AT91C_BASE_AC97C     	0xFFFA0000 /**< AC97C base address */
+
+/* -------------------------------------------------------- */
+/* PIO definition for AC97C hardware peripheral */
+/* -------------------------------------------------------- */
+#define AT91C_PB1_AC97CK   	(1 << 1) /**<  */
+#define AT91C_PB0_AC97FS   	(1 << 0) /**<  */
+#define AT91C_PB3_AC97RX   	(1 << 3) /**<  */
+#define AT91C_PB2_AC97TX   	(1 << 2) /**<  */
+
+/* -------------------------------------------------------- */
+/* Register offset definition for AC97C hardware peripheral */
+/* -------------------------------------------------------- */
+#define AC97C_MR 	(0x0008) 	/**< Mode Register */
+#define AC97C_ICA 	(0x0010) 	/**< Input Channel AssignementRegister */
+#define AC97C_OCA 	(0x0014) 	/**< Output Channel Assignement Register */
+#define AC97C_CARHR 	(0x0020) 	/**< Channel A Receive Holding Register */
+#define AC97C_CATHR 	(0x0024) 	/**< Channel A Transmit Holding Register */
+#define AC97C_CASR 	(0x0028) 	/**< Channel A Status Register */
+#define AC97C_CAMR 	(0x002C) 	/**< Channel A Mode Register */
+#define AC97C_CBRHR 	(0x0030) 	/**< Channel B Receive Holding Register (optional) */
+#define AC97C_CBTHR 	(0x0034) 	/**< Channel B Transmit Holding Register (optional) */
+#define AC97C_CBSR 	(0x0038) 	/**< Channel B Status Register */
+#define AC97C_CBMR 	(0x003C) 	/**< Channel B Mode Register */
+#define AC97C_CORHR 	(0x0040) 	/**< COdec Transmit Holding Register */
+#define AC97C_COTHR 	(0x0044) 	/**< COdec Transmit Holding Register */
+#define AC97C_COSR 	(0x0048) 	/**< CODEC Status Register */
+#define AC97C_COMR 	(0x004C) 	/**< CODEC Mask Status Register */
+#define AC97C_SR 	(0x0050) 	/**< Status Register */
+#define AC97C_IER 	(0x0054) 	/**< Interrupt Enable Register */
+#define AC97C_IDR 	(0x0058) 	/**< Interrupt Disable Register */
+#define AC97C_IMR 	(0x005C) 	/**< Interrupt Mask Register */
+#define AC97C_VERSION 	(0x00FC) 	/**< Version Register */
+
+/* -------------------------------------------------------- */
+/* Bitfields definition for AC97C hardware peripheral */
+/* -------------------------------------------------------- */
+/* --- Register AC97C_MR */
+#define AT91C_AC97C_ENA	(0x1 << 0) /**< (AC97C) AC97 Controller Global Enable */
+#define AT91C_AC97C_WRST	(0x1 << 1) /**< (AC97C) Warm Reset */
+#define AT91C_AC97C_VRA	(0x1 << 2) /**< (AC97C) Variable RAte (for Data Slots) */
+/* --- Register AC97C_ICA */
+#define AT91C_AC97C_CHID3	(0x7 << 0) /**< (AC97C) Channel Id for the input slot 3 */
+#define 	AT91C_AC97C_CHID3_NONE                 0x0 /**< (AC97C) No data will be transmitted during this slot */
+#define 	AT91C_AC97C_CHID3_CA                   0x1 /**< (AC97C) Channel A data will be transmitted during this slot */
+#define 	AT91C_AC97C_CHID3_CB                   0x2 /**< (AC97C) Channel B data will be transmitted during this slot */
+#define 	AT91C_AC97C_CHID3_CC                   0x3 /**< (AC97C) Channel C data will be transmitted during this slot */
+#define AT91C_AC97C_CHID4     (0x7 << 3) /**< (AC97C) Channel Id for the input slot 4 */
+#define 	AT91C_AC97C_CHID4_NONE                 (0x0 <<  3) /**< (AC97C) No data will be transmitted during this slot */
+#define 	AT91C_AC97C_CHID4_CA                   (0x1 <<  3) /**< (AC97C) Channel A data will be transmitted during this slot */
+#define 	AT91C_AC97C_CHID4_CB                   (0x2 <<  3) /**< (AC97C) Channel B data will be transmitted during this slot */
+#define 	AT91C_AC97C_CHID4_CC                   (0x3 <<  3) /**< (AC97C) Channel C data will be transmitted during this slot */
+#define AT91C_AC97C_CHID5     (0x7 << 6) /**< (AC97C) Channel Id for the input slot 5 */
+#define 	AT91C_AC97C_CHID5_NONE                 (0x0 <<  6) /**< (AC97C) No data will be transmitted during this slot */
+#define 	AT91C_AC97C_CHID5_CA                   (0x1 <<  6) /**< (AC97C) Channel A data will be transmitted during this slot */
+#define 	AT91C_AC97C_CHID5_CB                   (0x2 <<  6) /**< (AC97C) Channel B data will be transmitted during this slot */
+#define 	AT91C_AC97C_CHID5_CC                   (0x3 <<  6) /**< (AC97C) Channel C data will be transmitted during this slot */
+#define AT91C_AC97C_CHID6     (0x7 << 9) /**< (AC97C) Channel Id for the input slot 6 */
+#define 	AT91C_AC97C_CHID6_NONE                 (0x0 <<  9) /**< (AC97C) No data will be transmitted during this slot */
+#define 	AT91C_AC97C_CHID6_CA                   (0x1 <<  9) /**< (AC97C) Channel A data will be transmitted during this slot */
+#define 	AT91C_AC97C_CHID6_CB                   (0x2 <<  9) /**< (AC97C) Channel B data will be transmitted during this slot */
+#define 	AT91C_AC97C_CHID6_CC                   (0x3 <<  9) /**< (AC97C) Channel C data will be transmitted during this slot */
+#define AT91C_AC97C_CHID7     (0x7 << 12) /**< (AC97C) Channel Id for the input slot 7 */
+#define 	AT91C_AC97C_CHID7_NONE                 (0x0 << 12) /**< (AC97C) No data will be transmitted during this slot */
+#define 	AT91C_AC97C_CHID7_CA                   (0x1 << 12) /**< (AC97C) Channel A data will be transmitted during this slot */
+#define 	AT91C_AC97C_CHID7_CB                   (0x2 << 12) /**< (AC97C) Channel B data will be transmitted during this slot */
+#define 	AT91C_AC97C_CHID7_CC                   (0x3 << 12) /**< (AC97C) Channel C data will be transmitted during this slot */
+#define AT91C_AC97C_CHID8     (0x7 << 15) /**< (AC97C) Channel Id for the input slot 8 */
+#define 	AT91C_AC97C_CHID8_NONE                 (0x0 << 15) /**< (AC97C) No data will be transmitted during this slot */
+#define 	AT91C_AC97C_CHID8_CA                   (0x1 << 15) /**< (AC97C) Channel A data will be transmitted during this slot */
+#define 	AT91C_AC97C_CHID8_CB                   (0x2 << 15) /**< (AC97C) Channel B data will be transmitted during this slot */
+#define 	AT91C_AC97C_CHID8_CC                   (0x3 << 15) /**< (AC97C) Channel C data will be transmitted during this slot */
+#define AT91C_AC97C_CHID9     (0x7 << 18) /**< (AC97C) Channel Id for the input slot 9 */
+#define 	AT91C_AC97C_CHID9_NONE                 (0x0 << 18) /**< (AC97C) No data will be transmitted during this slot */
+#define 	AT91C_AC97C_CHID9_CA                   (0x1 << 18) /**< (AC97C) Channel A data will be transmitted during this slot */
+#define 	AT91C_AC97C_CHID9_CB                   (0x2 << 18) /**< (AC97C) Channel B data will be transmitted during this slot */
+#define 	AT91C_AC97C_CHID9_CC                   (0x3 << 18) /**< (AC97C) Channel C data will be transmitted during this slot */
+#define AT91C_AC97C_CHID10    (0x7 << 21) /**< (AC97C) Channel Id for the input slot 10 */
+#define 	AT91C_AC97C_CHID10_NONE                 (0x0 << 21) /**< (AC97C) No data will be transmitted during this slot */
+#define 	AT91C_AC97C_CHID10_CA                   (0x1 << 21) /**< (AC97C) Channel A data will be transmitted during this slot */
+#define 	AT91C_AC97C_CHID10_CB                   (0x2 << 21) /**< (AC97C) Channel B data will be transmitted during this slot */
+#define 	AT91C_AC97C_CHID10_CC                   (0x3 << 21) /**< (AC97C) Channel C data will be transmitted during this slot */
+#define AT91C_AC97C_CHID11    (0x7 << 24) /**< (AC97C) Channel Id for the input slot 11 */
+#define 	AT91C_AC97C_CHID11_NONE                 (0x0 << 24) /**< (AC97C) No data will be transmitted during this slot */
+#define 	AT91C_AC97C_CHID11_CA                   (0x1 << 24) /**< (AC97C) Channel A data will be transmitted during this slot */
+#define 	AT91C_AC97C_CHID11_CB                   (0x2 << 24) /**< (AC97C) Channel B data will be transmitted during this slot */
+#define 	AT91C_AC97C_CHID11_CC                   (0x3 << 24) /**< (AC97C) Channel C data will be transmitted during this slot */
+#define AT91C_AC97C_CHID12    (0x7 << 27) /**< (AC97C) Channel Id for the input slot 12 */
+#define 	AT91C_AC97C_CHID12_NONE                 (0x0 << 27) /**< (AC97C) No data will be transmitted during this slot */
+#define 	AT91C_AC97C_CHID12_CA                   (0x1 << 27) /**< (AC97C) Channel A data will be transmitted during this slot */
+#define 	AT91C_AC97C_CHID12_CB                   (0x2 << 27) /**< (AC97C) Channel B data will be transmitted during this slot */
+#define 	AT91C_AC97C_CHID12_CC                   (0x3 << 27) /**< (AC97C) Channel C data will be transmitted during this slot */
+/* --- Register AC97C_OCA */
+#define AT91C_AC97C_CHID3     (0x7 << 0) /**< (AC97C) Channel Id for the input slot 3 */
+#define 	AT91C_AC97C_CHID3_NONE                 0x0 /**< (AC97C) No data will be transmitted during this slot */
+#define 	AT91C_AC97C_CHID3_CA                   0x1 /**< (AC97C) Channel A data will be transmitted during this slot */
+#define 	AT91C_AC97C_CHID3_CB                   0x2 /**< (AC97C) Channel B data will be transmitted during this slot */
+#define 	AT91C_AC97C_CHID3_CC                   0x3 /**< (AC97C) Channel C data will be transmitted during this slot */
+#define AT91C_AC97C_CHID4     (0x7 << 3) /**< (AC97C) Channel Id for the input slot 4 */
+#define 	AT91C_AC97C_CHID4_NONE                 (0x0 <<  3) /**< (AC97C) No data will be transmitted during this slot */
+#define 	AT91C_AC97C_CHID4_CA                   (0x1 <<  3) /**< (AC97C) Channel A data will be transmitted during this slot */
+#define 	AT91C_AC97C_CHID4_CB                   (0x2 <<  3) /**< (AC97C) Channel B data will be transmitted during this slot */
+#define 	AT91C_AC97C_CHID4_CC                   (0x3 <<  3) /**< (AC97C) Channel C data will be transmitted during this slot */
+#define AT91C_AC97C_CHID5     (0x7 << 6) /**< (AC97C) Channel Id for the input slot 5 */
+#define 	AT91C_AC97C_CHID5_NONE                 (0x0 <<  6) /**< (AC97C) No data will be transmitted during this slot */
+#define 	AT91C_AC97C_CHID5_CA                   (0x1 <<  6) /**< (AC97C) Channel A data will be transmitted during this slot */
+#define 	AT91C_AC97C_CHID5_CB                   (0x2 <<  6) /**< (AC97C) Channel B data will be transmitted during this slot */
+#define 	AT91C_AC97C_CHID5_CC                   (0x3 <<  6) /**< (AC97C) Channel C data will be transmitted during this slot */
+#define AT91C_AC97C_CHID6     (0x7 << 9) /**< (AC97C) Channel Id for the input slot 6 */
+#define 	AT91C_AC97C_CHID6_NONE                 (0x0 <<  9) /**< (AC97C) No data will be transmitted during this slot */
+#define 	AT91C_AC97C_CHID6_CA                   (0x1 <<  9) /**< (AC97C) Channel A data will be transmitted during this slot */
+#define 	AT91C_AC97C_CHID6_CB                   (0x2 <<  9) /**< (AC97C) Channel B data will be transmitted during this slot */
+#define 	AT91C_AC97C_CHID6_CC                   (0x3 <<  9) /**< (AC97C) Channel C data will be transmitted during this slot */
+#define AT91C_AC97C_CHID7     (0x7 << 12) /**< (AC97C) Channel Id for the input slot 7 */
+#define 	AT91C_AC97C_CHID7_NONE                 (0x0 << 12) /**< (AC97C) No data will be transmitted during this slot */
+#define 	AT91C_AC97C_CHID7_CA                   (0x1 << 12) /**< (AC97C) Channel A data will be transmitted during this slot */
+#define 	AT91C_AC97C_CHID7_CB                   (0x2 << 12) /**< (AC97C) Channel B data will be transmitted during this slot */
+#define 	AT91C_AC97C_CHID7_CC                   (0x3 << 12) /**< (AC97C) Channel C data will be transmitted during this slot */
+#define AT91C_AC97C_CHID8     (0x7 << 15) /**< (AC97C) Channel Id for the input slot 8 */
+#define 	AT91C_AC97C_CHID8_NONE                 (0x0 << 15) /**< (AC97C) No data will be transmitted during this slot */
+#define 	AT91C_AC97C_CHID8_CA                   (0x1 << 15) /**< (AC97C) Channel A data will be transmitted during this slot */
+#define 	AT91C_AC97C_CHID8_CB                   (0x2 << 15) /**< (AC97C) Channel B data will be transmitted during this slot */
+#define 	AT91C_AC97C_CHID8_CC                   (0x3 << 15) /**< (AC97C) Channel C data will be transmitted during this slot */
+#define AT91C_AC97C_CHID9     (0x7 << 18) /**< (AC97C) Channel Id for the input slot 9 */
+#define 	AT91C_AC97C_CHID9_NONE                 (0x0 << 18) /**< (AC97C) No data will be transmitted during this slot */
+#define 	AT91C_AC97C_CHID9_CA                   (0x1 << 18) /**< (AC97C) Channel A data will be transmitted during this slot */
+#define 	AT91C_AC97C_CHID9_CB                   (0x2 << 18) /**< (AC97C) Channel B data will be transmitted during this slot */
+#define 	AT91C_AC97C_CHID9_CC                   (0x3 << 18) /**< (AC97C) Channel C data will be transmitted during this slot */
+#define AT91C_AC97C_CHID10    (0x7 << 21) /**< (AC97C) Channel Id for the input slot 10 */
+#define 	AT91C_AC97C_CHID10_NONE                 (0x0 << 21) /**< (AC97C) No data will be transmitted during this slot */
+#define 	AT91C_AC97C_CHID10_CA                   (0x1 << 21) /**< (AC97C) Channel A data will be transmitted during this slot */
+#define 	AT91C_AC97C_CHID10_CB                   (0x2 << 21) /**< (AC97C) Channel B data will be transmitted during this slot */
+#define 	AT91C_AC97C_CHID10_CC                   (0x3 << 21) /**< (AC97C) Channel C data will be transmitted during this slot */
+#define AT91C_AC97C_CHID11    (0x7 << 24) /**< (AC97C) Channel Id for the input slot 11 */
+#define 	AT91C_AC97C_CHID11_NONE                 (0x0 << 24) /**< (AC97C) No data will be transmitted during this slot */
+#define 	AT91C_AC97C_CHID11_CA                   (0x1 << 24) /**< (AC97C) Channel A data will be transmitted during this slot */
+#define 	AT91C_AC97C_CHID11_CB                   (0x2 << 24) /**< (AC97C) Channel B data will be transmitted during this slot */
+#define 	AT91C_AC97C_CHID11_CC                   (0x3 << 24) /**< (AC97C) Channel C data will be transmitted during this slot */
+#define AT91C_AC97C_CHID12    (0x7 << 27) /**< (AC97C) Channel Id for the input slot 12 */
+#define 	AT91C_AC97C_CHID12_NONE                 (0x0 << 27) /**< (AC97C) No data will be transmitted during this slot */
+#define 	AT91C_AC97C_CHID12_CA                   (0x1 << 27) /**< (AC97C) Channel A data will be transmitted during this slot */
+#define 	AT91C_AC97C_CHID12_CB                   (0x2 << 27) /**< (AC97C) Channel B data will be transmitted during this slot */
+#define 	AT91C_AC97C_CHID12_CC                   (0x3 << 27) /**< (AC97C) Channel C data will be transmitted during this slot */
+/* --- Register AC97C_CARHR */
+#define AT91C_AC97C_RDATA     (0xFFFFF << 0) /**< (AC97C) Receive data */
+/* --- Register AC97C_CATHR */
+#define AT91C_AC97C_TDATA     (0xFFFFF << 0) /**< (AC97C) Transmit data */
+/* --- Register AC97C_CASR */
+#define AT91C_AC97C_TXRDY     (0x1 << 0) /**< (AC97C)  */
+#define AT91C_AC97C_TXEMPTY   (0x1 << 1) /**< (AC97C)  */
+#define AT91C_AC97C_UNRUN     (0x1 << 2) /**< (AC97C)  */
+#define AT91C_AC97C_RXRDY     (0x1 << 4) /**< (AC97C)  */
+#define AT91C_AC97C_OVRUN     (0x1 << 5) /**< (AC97C)  */
+#define AT91C_AC97C_ENDTX     (0x1 << 10) /**< (AC97C)  */
+#define AT91C_AC97C_TXBUFE    (0x1 << 11) /**< (AC97C)  */
+#define AT91C_AC97C_ENDRX     (0x1 << 14) /**< (AC97C)  */
+#define AT91C_AC97C_RXBUFF    (0x1 << 15) /**< (AC97C)  */
+/* --- Register AC97C_CAMR */
+#define AT91C_AC97C_TXRDY     (0x1 << 0) /**< (AC97C)  */
+#define AT91C_AC97C_TXEMPTY   (0x1 << 1) /**< (AC97C)  */
+#define AT91C_AC97C_UNRUN     (0x1 << 2) /**< (AC97C)  */
+#define AT91C_AC97C_RXRDY     (0x1 << 4) /**< (AC97C)  */
+#define AT91C_AC97C_OVRUN     (0x1 << 5) /**< (AC97C)  */
+#define AT91C_AC97C_ENDTX     (0x1 << 10) /**< (AC97C)  */
+#define AT91C_AC97C_TXBUFE    (0x1 << 11) /**< (AC97C)  */
+#define AT91C_AC97C_ENDRX     (0x1 << 14) /**< (AC97C)  */
+#define AT91C_AC97C_RXBUFF    (0x1 << 15) /**< (AC97C)  */
+#define AT91C_AC97C_SIZE      (0x3 << 16) /**< (AC97C)  */
+#define 	AT91C_AC97C_SIZE_20_BITS              (0x0 << 16) /**< (AC97C) Data size is 20 bits */
+#define 	AT91C_AC97C_SIZE_18_BITS              (0x1 << 16) /**< (AC97C) Data size is 18 bits */
+#define 	AT91C_AC97C_SIZE_16_BITS              (0x2 << 16) /**< (AC97C) Data size is 16 bits */
+#define 	AT91C_AC97C_SIZE_10_BITS              (0x3 << 16) /**< (AC97C) Data size is 10 bits */
+#define AT91C_AC97C_CEM       (0x1 << 18) /**< (AC97C)  */
+#define AT91C_AC97C_CEN       (0x1 << 21) /**< (AC97C)  */
+#define AT91C_AC97C_PDCEN     (0x1 << 22) /**< (AC97C)  */
+/* --- Register AC97C_CBRHR */
+#define AT91C_AC97C_RDATA     (0xFFFFF << 0) /**< (AC97C) Receive data */
+/* --- Register AC97C_CBTHR */
+#define AT91C_AC97C_TDATA     (0xFFFFF << 0) /**< (AC97C) Transmit data */
+/* --- Register AC97C_CBSR */
+#define AT91C_AC97C_TXRDY     (0x1 << 0) /**< (AC97C)  */
+#define AT91C_AC97C_TXEMPTY   (0x1 << 1) /**< (AC97C)  */
+#define AT91C_AC97C_UNRUN     (0x1 << 2) /**< (AC97C)  */
+#define AT91C_AC97C_RXRDY     (0x1 << 4) /**< (AC97C)  */
+#define AT91C_AC97C_OVRUN     (0x1 << 5) /**< (AC97C)  */
+/* --- Register AC97C_CBMR */
+#define AT91C_AC97C_TXRDY     (0x1 << 0) /**< (AC97C)  */
+#define AT91C_AC97C_TXEMPTY   (0x1 << 1) /**< (AC97C)  */
+#define AT91C_AC97C_UNRUN     (0x1 << 2) /**< (AC97C)  */
+#define AT91C_AC97C_RXRDY     (0x1 << 4) /**< (AC97C)  */
+#define AT91C_AC97C_OVRUN     (0x1 << 5) /**< (AC97C)  */
+#define AT91C_AC97C_SIZE      (0x3 << 16) /**< (AC97C)  */
+#define 	AT91C_AC97C_SIZE_20_BITS              (0x0 << 16) /**< (AC97C) Data size is 20 bits */
+#define 	AT91C_AC97C_SIZE_18_BITS              (0x1 << 16) /**< (AC97C) Data size is 18 bits */
+#define 	AT91C_AC97C_SIZE_16_BITS              (0x2 << 16) /**< (AC97C) Data size is 16 bits */
+#define 	AT91C_AC97C_SIZE_10_BITS              (0x3 << 16) /**< (AC97C) Data size is 10 bits */
+#define AT91C_AC97C_CEM       (0x1 << 18) /**< (AC97C)  */
+#define AT91C_AC97C_CEN       (0x1 << 21) /**< (AC97C)  */
+/* --- Register AC97C_CORHR */
+#define AT91C_AC97C_SDATA     (0xFFFF << 0) /**< (AC97C) Status Data */
+/* --- Register AC97C_COTHR */
+#define AT91C_AC97C_CDATA     (0xFFFF << 0) /**< (AC97C) Command Data */
+#define AT91C_AC97C_CADDR     (0x7F << 16) /**< (AC97C) COdec control register index */
+#define AT91C_AC97C_READ      (0x1 << 23) /**< (AC97C) Read/Write command */
+/* --- Register AC97C_COSR */
+#define AT91C_AC97C_TXRDY     (0x1 << 0) /**< (AC97C)  */
+#define AT91C_AC97C_TXEMPTY   (0x1 << 1) /**< (AC97C)  */
+#define AT91C_AC97C_UNRUN     (0x1 << 2) /**< (AC97C)  */
+#define AT91C_AC97C_RXRDY     (0x1 << 4) /**< (AC97C)  */
+/* --- Register AC97C_COMR */
+#define AT91C_AC97C_TXRDY     (0x1 << 0) /**< (AC97C)  */
+#define AT91C_AC97C_TXEMPTY   (0x1 << 1) /**< (AC97C)  */
+#define AT91C_AC97C_UNRUN     (0x1 << 2) /**< (AC97C)  */
+#define AT91C_AC97C_RXRDY     (0x1 << 4) /**< (AC97C)  */
+/* --- Register AC97C_SR */
+#define AT91C_AC97C_SOF       (0x1 << 0) /**< (AC97C)  */
+#define AT91C_AC97C_WKUP      (0x1 << 1) /**< (AC97C)  */
+#define AT91C_AC97C_COEVT     (0x1 << 2) /**< (AC97C)  */
+#define AT91C_AC97C_CAEVT     (0x1 << 3) /**< (AC97C)  */
+#define AT91C_AC97C_CBEVT     (0x1 << 4) /**< (AC97C)  */
+/* --- Register AC97C_IER */
+#define AT91C_AC97C_SOF       (0x1 << 0) /**< (AC97C)  */
+#define AT91C_AC97C_WKUP      (0x1 << 1) /**< (AC97C)  */
+#define AT91C_AC97C_COEVT     (0x1 << 2) /**< (AC97C)  */
+#define AT91C_AC97C_CAEVT     (0x1 << 3) /**< (AC97C)  */
+#define AT91C_AC97C_CBEVT     (0x1 << 4) /**< (AC97C)  */
+/* --- Register AC97C_IDR */
+#define AT91C_AC97C_SOF       (0x1 << 0) /**< (AC97C)  */
+#define AT91C_AC97C_WKUP      (0x1 << 1) /**< (AC97C)  */
+#define AT91C_AC97C_COEVT     (0x1 << 2) /**< (AC97C)  */
+#define AT91C_AC97C_CAEVT     (0x1 << 3) /**< (AC97C)  */
+#define AT91C_AC97C_CBEVT     (0x1 << 4) /**< (AC97C)  */
+/* --- Register AC97C_IMR */
+#define AT91C_AC97C_SOF       (0x1 << 0) /**< (AC97C)  */
+#define AT91C_AC97C_WKUP      (0x1 << 1) /**< (AC97C)  */
+#define AT91C_AC97C_COEVT     (0x1 << 2) /**< (AC97C)  */
+#define AT91C_AC97C_CAEVT     (0x1 << 3) /**< (AC97C)  */
+#define AT91C_AC97C_CBEVT     (0x1 << 4) /**< (AC97C)  */
+
+#define platform_num_resources(dev)     ((dev)->num_resources)
+#define platform_resource_start(dev, i) ((dev)->resource[(i)].start)
+#define platform_resource_end(dev, i)   ((dev)->resource[(i)].end)
+#define platform_resource_flags(dev, i) ((dev)->resource[(i)].flags)
+#define platform_resource_len(dev, i)			\
+	(platform_resource_end((dev), (i)) -		\
+	platform_resource_start((dev), (i)) + 1)
+
+#define get_chip(card) ((at91_ac97_t *)(card)->private_data)
+
+#define ac97c_writel(chip, reg, val)			\
+	writel((val), (chip)->regs + AC97C_##reg)
+
+#define ac97c_readl(chip, reg)				\
+	readl((chip)->regs + AC97C_##reg)
+
+#endif /* __AC97C_H */
-- 
1.5.3.7
