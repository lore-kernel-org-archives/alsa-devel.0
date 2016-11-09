From: Peter Rosin <peda@axentia.se>
Subject: [PATCH v2 1/3] ASoC: atmel_ssc_dai: if not provided, default to sensible TCMR/RCMR periods
Date: Wed, 9 Nov 2016 23:40:56 +0100
Message-ID: <1478731258-26084-2-git-send-email-peda@axentia.se>
References: <1478731258-26084-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1478731258-26084-1-git-send-email-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

When this driver runs the dai link frame clock, and noone has stated
differently, assume that all the bits of a frame are used.

This relieves the cpu dai users from the duty to fill in the dividers for
the common case.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 sound/soc/atmel/atmel_ssc_dai.c | 29 +++++++++++++++++++++++------
 sound/soc/atmel/atmel_ssc_dai.h |  1 +
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
index 16e459aedffe..674191508437 100644
--- a/sound/soc/atmel/atmel_ssc_dai.c
+++ b/sound/soc/atmel/atmel_ssc_dai.c
@@ -380,6 +380,7 @@ static void atmel_ssc_shutdown(struct snd_pcm_substream *substream,
 		ssc_writel(ssc_p->ssc->regs, CR, SSC_BIT(CR_SWRST));
 		/* Clear the SSC dividers */
 		ssc_p->cmr_div = ssc_p->tcmr_period = ssc_p->rcmr_period = 0;
+		ssc_p->forced_divider = 0;
 	}
 	spin_unlock_irq(&ssc_p->lock);
 
@@ -429,10 +430,12 @@ static int atmel_ssc_set_dai_clkdiv(struct snd_soc_dai *cpu_dai,
 		break;
 
 	case ATMEL_SSC_TCMR_PERIOD:
+		ssc_p->forced_divider |= BIT(ATMEL_SSC_TCMR_PERIOD);
 		ssc_p->tcmr_period = div;
 		break;
 
 	case ATMEL_SSC_RCMR_PERIOD:
+		ssc_p->forced_divider |= BIT(ATMEL_SSC_RCMR_PERIOD);
 		ssc_p->rcmr_period = div;
 		break;
 
@@ -459,6 +462,8 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
 	u32 tfmr, rfmr, tcmr, rcmr;
 	int ret;
 	int fslen, fslen_ext;
+	u32 tcmr_period;
+	u32 rcmr_period;
 
 	/*
 	 * Currently, there is only one set of dma params for
@@ -470,6 +475,18 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
 	else
 		dir = 1;
 
+	/*
+	 * If the cpu dai should provide the frame clock,
+	 * but noone has provided the dividers needed for
+	 * that to work, fall back to something sensible.
+	 */
+	tcmr_period = ssc_p->tcmr_period;
+	if (!(ssc_p->forced_divider & BIT(ATMEL_SSC_TCMR_PERIOD)))
+		tcmr_period = snd_soc_params_to_frame_size(params) / 2 - 1;
+	rcmr_period = ssc_p->rcmr_period;
+	if (!(ssc_p->forced_divider & BIT(ATMEL_SSC_RCMR_PERIOD)))
+		rcmr_period = snd_soc_params_to_frame_size(params) / 2 - 1;
+
 	dma_params = ssc_p->dma_params[dir];
 
 	channels = params_channels(params);
@@ -524,7 +541,7 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
 		fslen_ext = (bits - 1) / 16;
 		fslen = (bits - 1) % 16;
 
-		rcmr =	  SSC_BF(RCMR_PERIOD, ssc_p->rcmr_period)
+		rcmr =	  SSC_BF(RCMR_PERIOD, rcmr_period)
 			| SSC_BF(RCMR_STTDLY, START_DELAY)
 			| SSC_BF(RCMR_START, SSC_START_FALLING_RF)
 			| SSC_BF(RCMR_CKI, SSC_CKI_RISING)
@@ -540,7 +557,7 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
 			| SSC_BF(RFMR_LOOP, 0)
 			| SSC_BF(RFMR_DATLEN, (bits - 1));
 
-		tcmr =	  SSC_BF(TCMR_PERIOD, ssc_p->tcmr_period)
+		tcmr =	  SSC_BF(TCMR_PERIOD, tcmr_period)
 			| SSC_BF(TCMR_STTDLY, START_DELAY)
 			| SSC_BF(TCMR_START, SSC_START_FALLING_RF)
 			| SSC_BF(TCMR_CKI, SSC_CKI_FALLING)
@@ -606,7 +623,7 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
 		fslen_ext = (bits - 1) / 16;
 		fslen = (bits - 1) % 16;
 
-		rcmr =	  SSC_BF(RCMR_PERIOD, ssc_p->rcmr_period)
+		rcmr =	  SSC_BF(RCMR_PERIOD, rcmr_period)
 			| SSC_BF(RCMR_STTDLY, START_DELAY)
 			| SSC_BF(RCMR_START, SSC_START_FALLING_RF)
 			| SSC_BF(RCMR_CKI, SSC_CKI_RISING)
@@ -623,7 +640,7 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
 			| SSC_BF(RFMR_LOOP, 0)
 			| SSC_BF(RFMR_DATLEN, (bits - 1));
 
-		tcmr =	  SSC_BF(TCMR_PERIOD, ssc_p->tcmr_period)
+		tcmr =	  SSC_BF(TCMR_PERIOD, tcmr_period)
 			| SSC_BF(TCMR_STTDLY, START_DELAY)
 			| SSC_BF(TCMR_START, SSC_START_FALLING_RF)
 			| SSC_BF(TCMR_CKI, SSC_CKI_FALLING)
@@ -650,7 +667,7 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
 		 * MCK divider, and the BCLK signal is output
 		 * on the SSC TK line.
 		 */
-		rcmr =	  SSC_BF(RCMR_PERIOD, ssc_p->rcmr_period)
+		rcmr =	  SSC_BF(RCMR_PERIOD, rcmr_period)
 			| SSC_BF(RCMR_STTDLY, 1)
 			| SSC_BF(RCMR_START, SSC_START_RISING_RF)
 			| SSC_BF(RCMR_CKI, SSC_CKI_RISING)
@@ -665,7 +682,7 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
 			| SSC_BF(RFMR_LOOP, 0)
 			| SSC_BF(RFMR_DATLEN, (bits - 1));
 
-		tcmr =	  SSC_BF(TCMR_PERIOD, ssc_p->tcmr_period)
+		tcmr =	  SSC_BF(TCMR_PERIOD, tcmr_period)
 			| SSC_BF(TCMR_STTDLY, 1)
 			| SSC_BF(TCMR_START, SSC_START_RISING_RF)
 			| SSC_BF(TCMR_CKI, SSC_CKI_FALLING)
diff --git a/sound/soc/atmel/atmel_ssc_dai.h b/sound/soc/atmel/atmel_ssc_dai.h
index 80b153857a88..75194f582131 100644
--- a/sound/soc/atmel/atmel_ssc_dai.h
+++ b/sound/soc/atmel/atmel_ssc_dai.h
@@ -113,6 +113,7 @@ struct atmel_ssc_info {
 	unsigned short cmr_div;
 	unsigned short tcmr_period;
 	unsigned short rcmr_period;
+	unsigned int forced_divider;
 	struct atmel_pcm_dma_params *dma_params[2];
 	struct atmel_ssc_state ssc_state;
 	unsigned long mck_rate;
-- 
2.1.4
