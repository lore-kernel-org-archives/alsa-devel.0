From: Sedji Gaouaou <sedji.gaouaou@atmel.com>
Subject: ALSA:AT91SAM9G20: Add support(DAI) for wolfson8731
Date: Wed, 17 Sep 2008 11:51:09 +0200
Message-ID: <48D0D30D.7070807@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from atmel-es2.atmel.fr (mail.atmel.fr [81.80.104.162])
	by alsa0.perex.cz (Postfix) with ESMTP id 2BA9B24561
	for <alsa-devel@alsa-project.org>;
	Wed, 17 Sep 2008 11:51:18 +0200 (CEST)
Received: from fwat.rfo.atmel.com (gateway [192.168.1.1])
	by atmel-es2.atmel.fr (8.11.6+Sun/8.11.6) with SMTP id m8H9obI11959
	for <alsa-devel@alsa-project.org>;
	Wed, 17 Sep 2008 11:50:42 +0200 (MEST)
Received: from [127.0.0.1] ([10.159.245.197])
	by meyreuil.atmel.fr (8.11.7p1+Sun/8.11.7) with ESMTP id m8H9p7r07427
	for <alsa-devel@alsa-project.org>;
	Wed, 17 Sep 2008 11:51:07 +0200 (MEST)
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

Hi,

So here is a patch to add support for the wolfson 8731 on the at91sam9g20 evaluation board.
Any comments will be welcomed!!

Regards,
Sedji

 sound/soc/at91/Kconfig               |   19 +-
 sound/soc/at91/Makefile              |    6 +
 sound/soc/at91/at91-ssc.h            |    1 +
 sound/soc/at91/atmel_ssc_dai.c       |  715 ++++++++++++++++++++++++++++++++++
 sound/soc/at91/sam9g20_wm8731.c      |  290 ++++++++++++++
 sound/soc/codecs/Kconfig             |    2 +-
 6 files changed, 1031 insertions(+), 2 deletions(-)
diff --git a/sound/soc/at91/Kconfig b/sound/soc/at91/Kconfig
index 9051865..86621b9 100644
--- a/sound/soc/at91/Kconfig
+++ b/sound/soc/at91/Kconfig
@@ -7,7 +7,15 @@ config SND_AT91_SOC
 	  to select the audio interfaces to support below.
 
 config SND_AT91_SOC_SSC
-	tristate
+	tristate "at91 soc ssc"
+
+config SND_ATMEL_SOC_SSC
+	tristate "ATMEL SoC ssc dai"
+	depends on ATMEL_SSC
+	help
+	  Say Y or M if you want to add support for codecs the
+	  ATMEL SSC interface(interface between at91sam9g20 and
+	  WM8731 for instance).
 
 config SND_AT91_SOC_ETI_B1_WM8731
 	tristate "SoC Audio support for WM8731-based Endrelia ETI-B1 boards"
@@ -18,6 +26,15 @@ config SND_AT91_SOC_ETI_B1_WM8731
 	  Say Y if you want to add support for SoC audio on WM8731-based
 	  Endrelia Technologies Inc ETI-B1 or ETI-C1 boards.
 
+config SND_AT91_SOC_SAM9G20_WM8731
+	tristate "SoC Audio support for WM8731-based At91sam9g20 evaluation board"
+	depends on ATMEL_SSC && ARCH_AT91SAM9G20 && SND_AT91_SOC
+	select SND_ATMEL_SOC_SSC
+	select SND_SOC_WM8731
+	help
+	  Say Y if you want to add support for SoC audio on WM8731-based
+	  AT91sam9g20 evaluation board.
+
 config SND_AT91_SOC_ETI_SLAVE
 	bool "Run codec in slave Mode on Endrelia boards"
 	depends on SND_AT91_SOC_ETI_B1_WM8731
diff --git a/sound/soc/at91/Makefile b/sound/soc/at91/Makefile
index f23da17..f12a798 100644
--- a/sound/soc/at91/Makefile
+++ b/sound/soc/at91/Makefile
@@ -1,11 +1,17 @@
 # AT91 Platform Support
 snd-soc-at91-objs := at91-pcm.o
 snd-soc-at91-ssc-objs := at91-ssc.o
+snd-soc-atmel_ssc_dai-objs := atmel_ssc_dai.o
+
 
 obj-$(CONFIG_SND_AT91_SOC) += snd-soc-at91.o
 obj-$(CONFIG_SND_AT91_SOC_SSC) += snd-soc-at91-ssc.o
+obj-$(CONFIG_SND_ATMEL_SOC_SSC) += snd-soc-atmel_ssc_dai.o
+
 
 # AT91 Machine Support
 snd-soc-eti-b1-wm8731-objs := eti_b1_wm8731.o
+snd-soc-sam9g20-wm8731-objs := sam9g20_wm8731.o
 
 obj-$(CONFIG_SND_AT91_SOC_ETI_B1_WM8731) += snd-soc-eti-b1-wm8731.o
+obj-$(CONFIG_SND_AT91_SOC_SAM9G20_WM8731) += snd-soc-sam9g20-wm8731.o
diff --git a/sound/soc/at91/at91-ssc.h b/sound/soc/at91/at91-ssc.h
index 6b7bf38..b967691 100644
--- a/sound/soc/at91/at91-ssc.h
+++ b/sound/soc/at91/at91-ssc.h
@@ -22,6 +22,7 @@
 #define AT91SSC_RCMR_PERIOD	2 /* BCLK divider for receive FS */
 
 extern struct snd_soc_dai at91_ssc_dai[];
+extern struct snd_soc_dai atmel_ssc_dai[];
 
 #endif /* _AT91_SSC_H */
 
diff --git a/sound/soc/at91/atmel_ssc_dai.c b/sound/soc/at91/atmel_ssc_dai.c
new file mode 100644
index 0000000..a3888c0
--- /dev/null
+++ b/sound/soc/at91/atmel_ssc_dai.c
@@ -0,0 +1,715 @@
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
+#include <mach/at91_pmc.h>
+
+#include "at91-pcm.h"
+#include "at91-ssc.h"
+
+#if 0
+#define	DBG(x...)	printk(KERN_DEBUG "atmel_ssc_dai:" x)
+#else
+#define	DBG(x...)
+#endif
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
+static struct at91_pdc_regs pdc_tx_reg = {
+	.xpr		= ATMEL_PDC_TPR,
+	.xcr		= ATMEL_PDC_TCR,
+	.xnpr		= ATMEL_PDC_TNPR,
+	.xncr		= ATMEL_PDC_TNCR,
+};
+
+static struct at91_pdc_regs pdc_rx_reg = {
+	.xpr		= ATMEL_PDC_RPR,
+	.xcr		= ATMEL_PDC_RCR,
+	.xnpr		= ATMEL_PDC_RNPR,
+	.xncr		= ATMEL_PDC_RNCR,
+};
+
+/*
+ * SSC & PDC status bits for transmit and receive.
+ */
+static struct at91_ssc_mask ssc_tx_mask = {
+	.ssc_enable	= SSC_BIT(CR_TXEN),
+	.ssc_disable	= SSC_BIT(CR_TXDIS),
+	.ssc_endx	= SSC_BIT(SR_ENDTX),
+	.ssc_endbuf	= SSC_BIT(SR_TXBUFE),
+	.pdc_enable	= ATMEL_PDC_TXTEN,
+	.pdc_disable	= ATMEL_PDC_TXTDIS,
+};
+
+static struct at91_ssc_mask ssc_rx_mask = {
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
+static struct at91_pcm_dma_params ssc_dma_params[NUM_SSC_DEVICES][2] = {
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
+static struct atmel_ssc_info {
+	char			*name;
+	struct ssc_device	*ssc;
+	spinlock_t 		lock;		/* lock for dir_mask */
+	unsigned short		dir_mask;	/* 0=unused, 1=playback, 2=capture */
+	unsigned short		initialized;	/* 1=SSC has been initialized */
+	unsigned short		daifmt;
+	unsigned short		cmr_div;
+	unsigned short		tcmr_period;
+	unsigned short		rcmr_period;
+	struct at91_pcm_dma_params *dma_params[2];
+} ssc_info[NUM_SSC_DEVICES] = {
+	{
+	.name		= "ssc0",
+	.lock		= __SPIN_LOCK_UNLOCKED(ssc_info[0].lock),
+	.dir_mask	= 0,
+	.initialized	= 0,
+	},
+#if NUM_SSC_DEVICES == 3
+	{
+	.name		= "ssc1",
+	.lock		= __SPIN_LOCK_UNLOCKED(ssc_info[1].lock),
+	.dir_mask	= 0,
+	.initialized	= 0,
+	},
+	{
+	.name		= "ssc2",
+	.lock		= __SPIN_LOCK_UNLOCKED(ssc_info[2].lock),
+	.dir_mask	= 0,
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
+	struct at91_pcm_dma_params *dma_params;
+	u32 ssc_sr;
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
+		if (dma_params != NULL && dma_params->dma_intr_handler != NULL &&
+			(ssc_sr &
+			(dma_params->mask->ssc_endx | dma_params->mask->ssc_endbuf)))
+
+			dma_params->dma_intr_handler(ssc_sr, dma_params->substream);
+	}
+
+	return IRQ_HANDLED;
+}
+
+/*
+ * Startup.  Only that one substream allowed in each direction.
+ */
+static int atmel_ssc_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = snd_pcm_substream_chip(substream);
+	struct atmel_ssc_info *ssc_p = &ssc_info[rtd->dai->cpu_dai->id];
+	int dir_mask;
+
+	DBG("ssc_startup: SSC_SR=0x%08lx\n", ssc_readl(ssc_p->ssc->regs, SR));
+	dir_mask = substream->stream == SNDRV_PCM_STREAM_PLAYBACK ? 0x1 : 0x2;
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
+	struct at91_pcm_dma_params *dma_params;
+	int dir, dir_mask;
+	u32 pid;
+
+	pid = ssc_p->ssc->pdev->resource[1].start;
+
+	dir = substream->stream == SNDRV_PCM_STREAM_PLAYBACK ? 0 : 1;
+	dma_params = ssc_p->dma_params[dir];
+
+	if (dma_params != NULL) {
+		ssc_writel(ssc_p->ssc->regs, CR, dma_params->mask->ssc_disable);
+		DBG("%s disabled SSC_SR=0x%08lx\n", (dir ? "receive" : "transmit"),
+			ssc_readl(ssc_p->ssc->regs, SR));
+
+		dma_params->ssc_base = NULL;
+		dma_params->substream = NULL;
+		ssc_p->dma_params[dir] = NULL;
+	}
+
+	dir_mask = 1 << dir;
+
+	spin_lock_irq(&ssc_p->lock);
+	ssc_p->dir_mask &= ~dir_mask;
+	if (!ssc_p->dir_mask) {
+		/* Shutdown the SSC clock. */
+		DBG("Stopping pid %d clock\n", pid);
+		at91_sys_write(AT91_PMC_PCDR, 1<<pid);
+
+		if (ssc_p->initialized) {
+			free_irq(pid, ssc_p);
+			ssc_p->initialized = 0;
+		}
+
+		/* Reset the SSC */
+		ssc_writel(ssc_p->ssc->regs, CR, SSC_BIT(CR_SWRST));
+		/* Clear the SSC dividers */
+		ssc_p->cmr_div = ssc_p->tcmr_period = ssc_p->rcmr_period = 0;
+	}
+	spin_unlock_irq(&ssc_p->lock);
+	ssc_free(ssc_p->ssc);
+}
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
+	case AT91SSC_CMR_DIV:
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
+	case AT91SSC_TCMR_PERIOD:
+		ssc_p->tcmr_period = div;
+		break;
+
+	case AT91SSC_RCMR_PERIOD:
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
+	struct at91_pcm_dma_params *dma_params;
+	int dir, channels, bits;
+	u32 tfmr, rfmr, tcmr, rcmr;
+	u32 pid;
+	int start_event;
+	int ret;
+
+	ssc_p->ssc = ssc_request(0);
+	pid = ssc_p->ssc->pdev->resource[1].start;
+	/*
+	 * Currently, there is only one set of dma params for
+	 * each direction.  If more are added, this code will
+	 * have to be changed to select the proper set.
+	 */
+	dir = substream->stream == SNDRV_PCM_STREAM_PLAYBACK ? 0 : 1;
+	dma_params = &ssc_dma_params[id][dir];
+	dma_params->ssc_base = ssc_p->ssc->regs;
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
+			"atmel_ssc_dai: sample size %d is too large for I2S\n", bits);
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
+		 * The SSC transmit and receive clocks are generated from the
+		 * MCK divider, and the BCLK signal is output on the SSC TK line.
+		 */
+		rcmr =	  SSC_BF(RCMR_PERIOD, ssc_p->rcmr_period)
+			| SSC_BF(RCMR_STTDLY, 1)
+			| SSC_BF(RCMR_START, 4)
+			| SSC_BF(RCMR_CKI, 1)
+			| SSC_BF(RCMR_CKO, 0)
+			| SSC_BF(RCMR_CKS, 0);
+
+		rfmr =	  SSC_BF(RFMR_FSEDGE, 0)
+			| SSC_BF(RFMR_FSOS, 1)
+			| SSC_BF(RFMR_FSLEN, (bits - 1))
+			| SSC_BF(RFMR_DATNB, (channels - 1))
+			| SSC_BF(RFMR_MSBF, 1)
+			| SSC_BF(RFMR_LOOP, 0)
+			| SSC_BF(RFMR_DATLEN, (bits - 1));
+
+		tcmr =	  SSC_BF(TCMR_PERIOD, ssc_p->tcmr_period)
+			| SSC_BF(TCMR_STTDLY, 1)
+			| SSC_BF(TCMR_START, 4)
+			| SSC_BF(TCMR_CKI, 0)
+			| SSC_BF(TCMR_CKO, 1)
+			| SSC_BF(TCMR_CKS, 0);
+
+		tfmr =	  SSC_BF(TFMR_FSEDGE, 0)
+			| SSC_BF(TFMR_FSDEN, 0)
+			| SSC_BF(TFMR_FSOS, 1)
+			| SSC_BF(TFMR_FSLEN, (bits - 1))
+			| SSC_BF(TFMR_DATNB, (channels - 1))
+			| SSC_BF(TFMR_MSBF, 1)
+			| SSC_BF(TFMR_DATDEF, 0)
+			| SSC_BF(TFMR_DATLEN, (bits - 1));
+		break;
+
+	case SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBM_CFM:
+		/*
+		 * I2S format, CODEC supplies BCLK and LRC clocks.
+		 *
+		 * The SSC transmit clock is obtained from the BCLK signal on
+		 * on the TK line, and the SSC receive clock is generated from the
+		 * transmit clock.
+		 *
+		 * For single channel data, one sample is transferred on the falling
+		 * edge of the LRC clock.  For two channel data, one sample is
+		 * transferred on both edges of the LRC clock.
+		 */
+		start_event = channels == 1
+				? 4
+				: 7;
+
+		rcmr =	  SSC_BF(RCMR_PERIOD, 0)
+			| SSC_BF(RCMR_STTDLY, 1)
+			| SSC_BF(RCMR_START, start_event)
+			| SSC_BF(RCMR_CKI, 1)
+			| SSC_BF(RCMR_CKO, 0)
+			| SSC_BF(RCMR_CKS, 1);
+
+		rfmr =	  SSC_BF(RFMR_FSEDGE, 0)
+			| SSC_BF(RFMR_FSOS, 0)
+			| SSC_BF(RFMR_FSLEN, 0)
+			| SSC_BF(RFMR_DATNB, 0)
+			| SSC_BF(RFMR_MSBF, 1)
+			| SSC_BF(RFMR_LOOP, 0)
+			| SSC_BF(RFMR_DATLEN, (bits - 1));
+
+		tcmr =	  SSC_BF(TCMR_PERIOD, 0)
+			| SSC_BF(TCMR_STTDLY, 1)
+			| SSC_BF(TCMR_START, start_event)
+			| SSC_BF(TCMR_CKI, 0)
+			| SSC_BF(TCMR_CKO, 0)
+			| SSC_BF(TCMR_CKS, 2);
+
+		tfmr =	  SSC_BF(TFMR_FSEDGE, 0)
+			| SSC_BF(TFMR_FSDEN, 0)
+			| SSC_BF(TFMR_FSOS, 0)
+			| SSC_BF(TFMR_FSLEN, 0)
+			| SSC_BF(TFMR_DATNB, 0)
+			| SSC_BF(TFMR_MSBF, 1)
+			| SSC_BF(TFMR_DATDEF, 0)
+			| SSC_BF(TFMR_DATLEN, (bits - 1));
+		break;
+
+	case SND_SOC_DAIFMT_DSP_A | SND_SOC_DAIFMT_CBS_CFS:
+		/*
+		 * DSP/PCM Mode A format, SSC provides BCLK and LRC clocks.
+		 *
+		 * The SSC transmit and receive clocks are generated from the
+		 * MCK divider, and the BCLK signal is output on the SSC TK line.
+		 */
+		rcmr =	  SSC_BF(RCMR_PERIOD, ssc_p->rcmr_period)
+			| SSC_BF(RCMR_STTDLY, 1)
+			| SSC_BF(RCMR_START, 5)
+			| SSC_BF(RCMR_CKI, 1)
+			| SSC_BF(RCMR_CKO, 0)
+			| SSC_BF(RCMR_CKS, 0);
+
+		rfmr =	  SSC_BF(RFMR_FSEDGE, 0)
+			| SSC_BF(RFMR_FSOS, 2)
+			| SSC_BF(RFMR_FSLEN, 0)
+			| SSC_BF(RFMR_DATNB, (channels - 1))
+			| SSC_BF(RFMR_MSBF, 1)
+			| SSC_BF(RFMR_LOOP, 0)
+			| SSC_BF(RFMR_DATLEN, (bits - 1));
+
+		tcmr =	  SSC_BF(TCMR_PERIOD, ssc_p->tcmr_period)
+			| SSC_BF(TCMR_STTDLY, 1)
+			| SSC_BF(TCMR_START, 5)
+			| SSC_BF(TCMR_CKI, 1)
+			| SSC_BF(TCMR_CKO, 1)
+			| SSC_BF(TCMR_CKS, 0);
+
+		tfmr =	  SSC_BF(TFMR_FSEDGE, 0)
+			| SSC_BF(TFMR_FSDEN, 0)
+			| SSC_BF(TFMR_FSOS, 2)
+			| SSC_BF(TFMR_FSLEN, 0)
+			| SSC_BF(TFMR_DATNB, (channels - 1))
+			| SSC_BF(TFMR_MSBF, 1)
+			| SSC_BF(TFMR_DATDEF, 0)
+			| SSC_BF(TFMR_DATLEN, (bits - 1));
+		break;
+
+	case SND_SOC_DAIFMT_DSP_A | SND_SOC_DAIFMT_CBM_CFM:
+	default:
+		printk(KERN_WARNING "atmel_ssc_dai: unsupported DAI format 0x%x.\n",
+			ssc_p->daifmt);
+		return -EINVAL;
+		break;
+	}
+	DBG("RCMR=%08x RFMR=%08x TCMR=%08x TFMR=%08x\n", rcmr, rfmr, tcmr, tfmr);
+
+	if (!ssc_p->initialized) {
+
+		/* Enable PMC peripheral clock for this SSC */
+		DBG("Starting pid %d clock\n", pid);
+		at91_sys_write(AT91_PMC_PCER, 1<<pid);
+
+		/* Reset the SSC and its PDC registers */
+		ssc_writel(ssc_p->ssc->regs, CR, SSC_BIT(CR_SWRST));
+
+		ssc_writel(ssc_p->ssc->regs, PDC_RPR, 0);
+		ssc_writel(ssc_p->ssc->regs, PDC_RCR, 0);
+		ssc_writel(ssc_p->ssc->regs, PDC_RNPR, 0);
+		ssc_writel(ssc_p->ssc->regs, PDC_RNCR, 0);
+		ssc_writel(ssc_p->ssc->regs, PDC_TPR, 0);
+		ssc_writel(ssc_p->ssc->regs, PDC_TCR, 0);
+		ssc_writel(ssc_p->ssc->regs, PDC_TNPR, 0);
+		ssc_writel(ssc_p->ssc->regs, PDC_TNCR, 0);
+
+		ret = request_irq(pid, atmel_ssc_interrupt,
+				0, ssc_p->name, ssc_p);
+		if (ret < 0) {
+			printk(KERN_WARNING "atmel_ssc_dai: request_irq failure\n");
+
+			DBG("Stopping pid %d clock\n", pid);
+			at91_sys_write(AT91_PMC_PCER, 1<<pid);
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
+	DBG("hw_params: SSC initialized\n");
+	return 0;
+}
+
+
+static int atmel_ssc_prepare(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = snd_pcm_substream_chip(substream);
+	struct atmel_ssc_info *ssc_p = &ssc_info[rtd->dai->cpu_dai->id];
+	struct at91_pcm_dma_params *dma_params;
+	int dir;
+
+	dir = substream->stream == SNDRV_PCM_STREAM_PLAYBACK ? 0 : 1;
+	dma_params = ssc_p->dma_params[dir];
+
+	ssc_writel(ssc_p->ssc->regs, CR, dma_params->mask->ssc_enable);
+
+	DBG("%s enabled SSC_SR=0x%08lx\n", dir ? "receive" : "transmit",
+		ssc_readl(ssc_p->ssc->regs, SR));
+	return 0;
+}
+
+
+#ifdef CONFIG_PM
+#define atmel_ssc_suspend	NULL
+#define atmel_ssc_resume	NULL
+#else
+#define atmel_ssc_suspend	NULL
+#define atmel_ssc_resume	NULL
+#endif
+
+
+#define ATMEL_SSC_RATES (SNDRV_PCM_RATE_8000  | SNDRV_PCM_RATE_11025 |\
+			SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_22050 |\
+			SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 |\
+			SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 |\
+			SNDRV_PCM_RATE_96000)
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
+		.private_data = &ssc_info[0].ssc,
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
+		.private_data = &ssc_info[1].ssc,
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
+		.private_data = &ssc_info[2].ssc,
+	},
+#endif
+};
+
+EXPORT_SYMBOL_GPL(atmel_ssc_dai);
+
+/* Module information */
+MODULE_AUTHOR("Sedji Gaouaou, sedji.gaouaou@atmel.com, www.atmel.com");
+MODULE_DESCRIPTION("ATMEL SSC ASoC Interface");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/at91/sam9g20_wm8731.c b/sound/soc/at91/sam9g20_wm8731.c
new file mode 100644
index 0000000..8d77830
--- /dev/null
+++ b/sound/soc/at91/sam9g20_wm8731.c
@@ -0,0 +1,290 @@
+/*
+ * sam9g20_wm8731  --  SoC audio for AT91SAM9G20-based ATMEL AT91SAM9G20ek board.
+ *
+ *  Copyright (C) 2005 SAN People
+ *  Copyright (C) 2008 Atmel
+ *
+ * Authors: Sedji Gaouaou <sedji.gaouaou@atmel.com>
+ * 
+ * Based on ati_b1_wm8731.c by:
+ * Frank Mandarino <fmandarino@endrelia.com>
+ * Copyright 2006 Endrelia Technologies Inc.
+ * Based on corgi.c by:
+ * Copyright 2005 Wolfson Microelectronics PLC.
+ * Copyright 2005 Openedhand Ltd.
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
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/version.h>
+#include <linux/kernel.h>
+#include <linux/clk.h>
+#include <linux/timer.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/atmel-ssc.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+
+#include <mach/hardware.h>
+#include <mach/gpio.h>
+
+#include "../codecs/wm8731.h"
+#include "at91-pcm.h"
+#include "at91-ssc.h"
+
+
+#if 0
+#define	DBG(x...)	printk(KERN_INFO "at91sam9g20ek_wm8731: " x)
+#else
+#define	DBG(x...)
+#endif
+
+
+static int at91sam9g20ek_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = snd_pcm_substream_chip(substream);
+	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+	int ret;
+
+	/* codec system clock is supplied by PCK0, set to 12MHz */
+	ret = snd_soc_dai_set_sysclk(codec_dai, WM8731_SYSCLK,
+		12000000, SND_SOC_CLOCK_IN);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static void at91sam9g20ek_shutdown(struct snd_pcm_substream *substream)
+{
+	DBG("pck0 stopped\n");
+}
+
+static int at91sam9g20ek_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	int ret;
+
+	unsigned int rate;
+	int cmr_div, period;
+
+	/* set codec DAI configuration */
+	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
+		SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBS_CFS);
+	if (ret < 0)
+		return ret;
+
+	/* set cpu DAI configuration */
+	ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S |
+		SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBS_CFS);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * The SSC clock dividers depend on the sample rate.  The CMR.DIV
+	 * field divides the system master clock MCK to drive the SSC TK
+	 * signal which provides the codec BCLK.  The TCMR.PERIOD and
+	 * RCMR.PERIOD fields further divide the BCLK signal to drive
+	 * the SSC TF and RF signals which provide the codec DACLRC and
+	 * ADCLRC clocks.
+	 *
+	 * The dividers were determined through trial and error, where a
+	 * CMR.DIV value is chosen such that the resulting BCLK value is
+	 * divisible, or almost divisible, by (2 * sample rate), and then
+	 * the TCMR.PERIOD or RCMR.PERIOD is BCLK / (2 * sample rate) - 1.
+	 */
+	rate = params_rate(params);
+
+	switch (rate) {
+	case 8000:
+		cmr_div = 55;	/* BCLK = 133MHz/(2*55) = 1.209MHz */
+		period = 74;	/* LRC = BCLK/(2*(74+1)) ~= 8060,6Hz */
+		break;
+	case 11025:
+		cmr_div = 67;	/* BCLK = 133MHz/(2*60) = 1.108MHz */
+		period = 45;	/* LRC = BCLK/(2*(49+1)) = 11083,3Hz */
+		break;
+	case 16000:
+		cmr_div = 63;	/* BCLK = 133MHz/(2*63) = 1.055MHz */
+		period = 32;	/* LRC = BCLK/(2*(32+1)) = 15993,2Hz */
+		break;
+	case 22050:
+		cmr_div = 52;	/* BCLK = 133MHz/(2*52) = 1.278MHz */
+		period = 28;	/* LRC = BCLK/(2*(28+1)) = 22049Hz */
+		break;
+	case 32000:
+		cmr_div = 66;	/* BCLK = 133MHz/(2*66) = 1.007MHz */
+		period = 15;	/* LRC = BCLK/(2*(15+1)) = 31486,742Hz */
+		break;
+	case 44100:
+		cmr_div = 29;	/* BCLK = 133MHz/(2*29) = 2.293MHz */
+		period = 25;	/* LRC = BCLK/(2*(25+1)) = 44098Hz */
+		break;
+	case 48000:
+		cmr_div = 33;	/* BCLK = 133MHz/(2*33) = 2.015MHz */
+		period = 20;	/* LRC = BCLK/(2*(20+1)) = 47979,79Hz */
+		break;
+	case 88200:
+		cmr_div = 29;	/* BCLK = 133MHz/(2*29) = 2.293MHz */
+		period = 12;	/* LRC = BCLK/(2*(12+1)) = 88196Hz */
+		break;
+	case 96000:
+		cmr_div = 23;	/* BCLK = 133MHz/(2*23) = 2.891MHz */
+		period = 14;	/* LRC = BCLK/(2*(14+1)) = 96376Hz */
+		break;
+	default:
+		printk(KERN_WARNING "unsupported rate %d on at91sam9g20ek board\n", rate);
+		return -EINVAL;
+	}
+
+	/* set the MCK divider for BCLK */
+	ret = snd_soc_dai_set_clkdiv(cpu_dai, AT91SSC_CMR_DIV, cmr_div);
+	if (ret < 0)
+		return ret;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		/* set the BCLK divider for DACLRC */
+		ret = snd_soc_dai_set_clkdiv(cpu_dai,
+						AT91SSC_TCMR_PERIOD, period);
+	} else {
+		/* set the BCLK divider for ADCLRC */
+		ret = snd_soc_dai_set_clkdiv(cpu_dai,
+						AT91SSC_RCMR_PERIOD, period);
+	}
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static struct snd_soc_ops at91sam9g20ek_ops = {
+	.startup = at91sam9g20ek_startup,
+	.hw_params = at91sam9g20ek_hw_params,
+	.shutdown = at91sam9g20ek_shutdown,
+};
+
+
+static const struct snd_soc_dapm_widget at91sam9g20ek_dapm_widgets[] = {
+	SND_SOC_DAPM_MIC("Int Mic", NULL),
+	SND_SOC_DAPM_SPK("Ext Spk", NULL),
+};
+
+static const struct snd_soc_dapm_route intercon[] = {
+
+	/* speaker connected to LHPOUT */
+	{"Ext Spk", NULL, "LHPOUT"},
+
+	/* mic is connected to Mic Jack, with WM8731 Mic Bias */
+	{"MICIN", NULL, "Mic Bias"},
+	{"Mic Bias", NULL, "Int Mic"},
+};
+
+/*
+ * Logic for a wm8731 as connected on a at91sam9g20ek board.
+ */
+static int at91sam9g20ek_wm8731_init(struct snd_soc_codec *codec)
+{
+
+	DBG("at91sam9g20ek_wm8731 : at91sam9g20ek_wm8731_init() called\n");
+
+	/* Add specific widgets */
+	snd_soc_dapm_new_controls(codec, at91sam9g20ek_dapm_widgets,
+				  ARRAY_SIZE(at91sam9g20ek_dapm_widgets));
+	/* Set up specific audio path interconnects */
+	snd_soc_dapm_add_routes(codec, intercon, ARRAY_SIZE(intercon));
+
+	/* not connected */
+	snd_soc_dapm_disable_pin(codec, "RLINEIN");
+	snd_soc_dapm_disable_pin(codec, "LLINEIN");
+
+	/* always connected */
+	snd_soc_dapm_enable_pin(codec, "Int Mic");
+	snd_soc_dapm_enable_pin(codec, "Ext Spk");
+
+	snd_soc_dapm_sync(codec);
+
+	return 0;
+}
+
+static struct snd_soc_dai_link at91sam9g20ek_dai = {
+	.name = "WM8731",
+	.stream_name = "WM8731 PCM",
+	.cpu_dai = &atmel_ssc_dai[0],
+	.codec_dai = &wm8731_dai,
+	.init = at91sam9g20ek_wm8731_init,
+	.ops = &at91sam9g20ek_ops,
+};
+
+static struct snd_soc_machine snd_soc_machine_at91sam9g20ek = {
+	.name = "WM8731",
+	.dai_link = &at91sam9g20ek_dai,
+	.num_links = 1,
+};
+
+static struct wm8731_setup_data at91sam9g20ek_wm8731_setup = {
+	.i2c_address = 0x1b,
+};
+
+static struct snd_soc_device at91sam9g20ek_snd_devdata = {
+	.machine = &snd_soc_machine_at91sam9g20ek,
+	.platform = &at91_soc_platform,
+	.codec_dev = &soc_codec_dev_wm8731,
+	.codec_data = &at91sam9g20ek_wm8731_setup,
+};
+
+static struct platform_device *at91sam9g20ek_snd_device;
+
+static int __init at91sam9g20ek_init(void)
+{
+	int ret;
+
+	at91sam9g20ek_snd_device = platform_device_alloc("soc-audio", -1);
+	if (!at91sam9g20ek_snd_device) {
+		DBG("platform device allocation failed\n");
+		ret = -ENOMEM;
+	}
+
+	platform_set_drvdata(at91sam9g20ek_snd_device, &at91sam9g20ek_snd_devdata);
+	at91sam9g20ek_snd_devdata.dev = &at91sam9g20ek_snd_device->dev;
+
+	ret = platform_device_add(at91sam9g20ek_snd_device);
+	if (ret) {
+		DBG("platform device add failed\n");
+		platform_device_put(at91sam9g20ek_snd_device);
+	}
+
+	return ret;
+}
+
+static void __exit at91sam9g20ek_exit(void)
+{
+	platform_device_unregister(at91sam9g20ek_snd_device);
+}
+
+module_init(at91sam9g20ek_init);
+module_exit(at91sam9g20ek_exit);
+
+/* Module information */
+MODULE_AUTHOR("Sedji Gaouaou <sedji.gaouaou@atmel.com>");
+MODULE_DESCRIPTION("ALSA SoC AT91SAM9G20EK_WM8731");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 1db04a2..1595b04 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -12,7 +12,7 @@ config SND_SOC_WM8510
 	tristate
 
 config SND_SOC_WM8731
-	tristate
+	tristate "WM8731"
 
 config SND_SOC_WM8750
 	tristate
