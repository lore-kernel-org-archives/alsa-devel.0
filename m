From: Ryan Mallon <ryan@bluewatersys.com>
Subject: [RFC PATCH] Add combined clock support to Atmel SoC
	audio
Date: Wed, 24 Nov 2010 11:05:11 +1300
Message-ID: <4CEC3A97.4040400@bluewatersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hayes.bluewaternz.com (mail.bluewatersys.com [202.124.120.130])
	by alsa0.perex.cz (Postfix) with ESMTP id EE747103932
	for <alsa-devel@alsa-project.org>; Tue, 23 Nov 2010 23:04:06 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: gwossum@acm.org, Sergey Lapin <slapin@ossfans.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Sedji Gaouaou <sedji.gaouaou@atmel.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

The following patch is one that has been floating around in various
forms in our own internal trees for a while.

The Atmel SSC peripheral has seperate TX and RX clocks which use
separate pins from the the micro. TF (frame) and TK (clock) for transmit
and RF and RK for receive. Not all codecs have separate frame and bit
clocks for transmit and receive so we want to be able to do both
playback and capture using a single set of pins.

This patch introduces a combined clock mode for the Atmel SSC
peripheral. Which allows playback and capture to use a single set of
pins. Currently combined clock is only supported on the TF/TK pins (some
incomplete support exists for using RF/RK).

I have tested this patch on our AT91SAM9G45 + TLV320AIC26 platform.
Playback and capture work individually. Simultaneous playback and
capture have been tested by connecting a loopback cable on the linein
and lineout jacks and then doing:

  arecord -c 2 -f S16_LE -r 44100 > recording.wav &
  aplay 500hz_sine.wav

This patch is posted as RFC since the approach is incomplete and a bit
hackish. I am mostly interested in knowing if this is a sensible
approach, and could be cleaned up for mainline inclusion, or if there is
a better way to do this.

Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
---

diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
index 5d230ce..ee00172 100644
--- a/sound/soc/atmel/atmel_ssc_dai.c
+++ b/sound/soc/atmel/atmel_ssc_dai.c
@@ -43,6 +43,7 @@
 #include <sound/soc.h>
 
 #include <mach/hardware.h>
+#include <asm/atomic.h>
 
 #include "atmel-pcm.h"
 #include "atmel_ssc_dai.h"
@@ -246,7 +247,18 @@ static void atmel_ssc_shutdown(struct snd_pcm_substream *substream,
 	dma_params = ssc_p->dma_params[dir];
 
 	if (dma_params != NULL) {
-		ssc_writel(ssc_p->ssc->regs, CR, dma_params->mask->ssc_disable);
+		if (ssc_p->combined_clock) {
+			/*
+			 * When using a combined clock we only disable the
+			 * clock once all substreams have completed
+			 */
+			if (atomic_dec_and_test(&ssc_p->substreams_running))
+				ssc_writel(ssc_p->ssc->regs, CR,
+					   dma_params->mask->ssc_disable);
+		} else {
+			ssc_writel(ssc_p->ssc->regs, CR,
+				   dma_params->mask->ssc_disable);
+		}
 		pr_debug("atmel_ssc_shutdown: %s disabled SSC_SR=0x%08x\n",
 			(dir ? "receive" : "transmit"),
 			ssc_readl(ssc_p->ssc->regs, SR));
@@ -328,6 +340,21 @@ static int atmel_ssc_set_dai_clkdiv(struct snd_soc_dai *cpu_dai,
 	return 0;
 }
 
+void atmel_ssc_setup_combined_clock(struct atmel_ssc_info *ssc_p,
+				    int combined_clock)
+{
+	int i;
+
+	ssc_p->combined_clock = combined_clock;
+	for (i = 0; i < ARRAY_SIZE(ssc_dma_params); i++) {
+		if (ssc_p->combined_clock == ATMEL_SSC_CLOCK_TX_ON_RX)
+			ssc_dma_params[i][0].mask->ssc_enable |= SSC_BIT(CR_RXEN);
+		else if (ssc_p->combined_clock == ATMEL_SSC_CLOCK_RX_ON_TX)
+			ssc_dma_params[i][1].mask->ssc_enable |= SSC_BIT(CR_TXEN);
+	}
+}
+EXPORT_SYMBOL(atmel_ssc_setup_combined_clock);
+
 /*
  * Configure the SSC.
  */
@@ -548,6 +575,34 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
 			ssc_p->daifmt);
 		return -EINVAL;
 	}
+
+	if (ssc_p->combined_clock == ATMEL_SSC_CLOCK_RX_ON_TX) {
+		/* RX clock is always running */
+		rcmr &= ~SSC_BF(RCMR_CKO, 0x7);
+		rcmr |=  SSC_BF(RCMR_CKO, SSC_CKO_CONTINUOUS);
+
+		/* TX clock is always running */
+		tcmr &= ~SSC_BF(TCMR_CKO, 0x7);
+		tcmr |=  SSC_BF(TCMR_CKO, SSC_CKO_CONTINUOUS);
+
+		/* RX clock is sourced from TK pin */
+		rcmr &= ~SSC_BF(RCMR_CKS, 0x7);
+		rcmr |=  SSC_BF(RCMR_CKS, SSC_CKS_CLOCK);
+
+		/* Start RX on TX start */
+		rcmr &= ~SSC_BF(RCMR_START, 0xf);
+		rcmr |=  SSC_BF(RCMR_START, SSC_START_TX_RX);
+
+		if (dir == 1) {
+			/*
+			 * Set the TX clock period to the RX clock period
+			 * FIXME - Is this okay if we are already doing TX?
+			 */
+			tcmr &= 0x00ffffff;
+			tcmr |= rcmr & 0xff000000;
+		}
+	}
+
 	pr_debug("atmel_ssc_hw_params: "
 			"RCMR=%08x RFMR=%08x TCMR=%08x TFMR=%08x\n",
 			rcmr, rfmr, tcmr, tfmr);
@@ -581,6 +636,9 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
 			return ret;
 		}
 
+		if (ssc_p->combined_clock)
+			atomic_set(&ssc_p->substreams_running, 0);
+
 		ssc_p->initialized = 1;
 	}
 
@@ -616,6 +674,21 @@ static int atmel_ssc_prepare(struct snd_pcm_substream *substream,
 
 	ssc_writel(ssc_p->ssc->regs, CR, dma_params->mask->ssc_enable);
 
+	if (ssc_p->combined_clock) {
+		atomic_inc(&ssc_p->substreams_running);
+
+		if (ssc_p->combined_clock == ATMEL_SSC_CLOCK_RX_ON_TX &&
+		    dir == 1) {
+			/*
+			 * Jump start the dma for capture by loading the
+			 * transmit holding register with a dummy value.
+			 */
+			pr_debug("Jump starting SSC RX DMA\n");
+			if (!(ssc_readl(ssc_p->ssc->regs, SR) & (1 << 16)))
+				ssc_writel(ssc_p->ssc->regs, THR, 0);
+		}
+	}
+
 	pr_debug("%s enabled SSC_SR=0x%08x\n",
 			dir ? "receive" : "transmit",
 			ssc_readl(ssc_p->ssc->regs, SR));
diff --git a/sound/soc/atmel/atmel_ssc_dai.h b/sound/soc/atmel/atmel_ssc_dai.h
index 5d4f0f9..6b20ee6 100644
--- a/sound/soc/atmel/atmel_ssc_dai.h
+++ b/sound/soc/atmel/atmel_ssc_dai.h
@@ -102,6 +102,8 @@ struct atmel_ssc_state {
 	u32 ssc_imr;
 };
 
+#define ATMEL_SSC_CLOCK_RX_ON_TX	1
+#define ATMEL_SSC_CLOCK_TX_ON_RX	2
 
 struct atmel_ssc_info {
 	char *name;
@@ -115,8 +117,14 @@ struct atmel_ssc_info {
 	unsigned short rcmr_period;
 	struct atmel_pcm_dma_params *dma_params[2];
 	struct atmel_ssc_state ssc_state;
+
+	/* For combined clocks */
+	int combined_clock;
+	atomic_t substreams_running;
 };
 
 int atmel_ssc_set_audio(int ssc);
+extern void atmel_ssc_setup_combined_clock(struct atmel_ssc_info *ssc_p,
+					   int combined_clock);
 
 #endif /* _AT91_SSC_DAI_H */
