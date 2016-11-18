From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: atmel_ssc_dai: if not provided, default to sensible dividers" to the asoc tree
Date: Fri, 18 Nov 2016 12:01:46 +0000
Message-ID: <E1c7hrW-0005Fu-5n@debutante>
References: <1478863752-10569-2-git-send-email-peda@axentia.se>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1478863752-10569-2-git-send-email-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: atmel_ssc_dai: if not provided, default to sensible dividers

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From a85787edaaf7bc77ed011c89e23d52b3ff352c51 Mon Sep 17 00:00:00 2001
From: Peter Rosin <peda@axentia.se>
Date: Tue, 15 Nov 2016 19:38:13 +0100
Subject: [PATCH] ASoC: atmel_ssc_dai: if not provided, default to sensible
 dividers

When this driver masters BCLK and/or LRCLK, and noone has stated
differently, assume that all the bits of a frame are used.

This relieves the cpu dai users from the duty to fill in the dividers for
the common case.

Signed-off-by: Peter Rosin <peda@axentia.se>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/atmel/atmel_ssc_dai.c | 83 +++++++++++++++++++++++++++++++++++++----
 sound/soc/atmel/atmel_ssc_dai.h |  1 +
 2 files changed, 77 insertions(+), 7 deletions(-)

diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
index 16e459aedffe..a1e2c5682dcd 100644
--- a/sound/soc/atmel/atmel_ssc_dai.c
+++ b/sound/soc/atmel/atmel_ssc_dai.c
@@ -380,6 +380,7 @@ static void atmel_ssc_shutdown(struct snd_pcm_substream *substream,
 		ssc_writel(ssc_p->ssc->regs, CR, SSC_BIT(CR_SWRST));
 		/* Clear the SSC dividers */
 		ssc_p->cmr_div = ssc_p->tcmr_period = ssc_p->rcmr_period = 0;
+		ssc_p->forced_divider = 0;
 	}
 	spin_unlock_irq(&ssc_p->lock);
 
@@ -426,14 +427,17 @@ static int atmel_ssc_set_dai_clkdiv(struct snd_soc_dai *cpu_dai,
 		else
 			if (div != ssc_p->cmr_div)
 				return -EBUSY;
+		ssc_p->forced_divider |= BIT(ATMEL_SSC_CMR_DIV);
 		break;
 
 	case ATMEL_SSC_TCMR_PERIOD:
 		ssc_p->tcmr_period = div;
+		ssc_p->forced_divider |= BIT(ATMEL_SSC_TCMR_PERIOD);
 		break;
 
 	case ATMEL_SSC_RCMR_PERIOD:
 		ssc_p->rcmr_period = div;
+		ssc_p->forced_divider |= BIT(ATMEL_SSC_RCMR_PERIOD);
 		break;
 
 	default:
@@ -443,6 +447,28 @@ static int atmel_ssc_set_dai_clkdiv(struct snd_soc_dai *cpu_dai,
 	return 0;
 }
 
+/* Is the cpu-dai master of the frame clock? */
+static int atmel_ssc_cfs(struct atmel_ssc_info *ssc_p)
+{
+	switch (ssc_p->daifmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBM_CFS:
+	case SND_SOC_DAIFMT_CBS_CFS:
+		return 1;
+	}
+	return 0;
+}
+
+/* Is the cpu-dai master of the bit clock? */
+static int atmel_ssc_cbs(struct atmel_ssc_info *ssc_p)
+{
+	switch (ssc_p->daifmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBS_CFM:
+	case SND_SOC_DAIFMT_CBS_CFS:
+		return 1;
+	}
+	return 0;
+}
+
 /*
  * Configure the SSC.
  */
@@ -459,6 +485,9 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
 	u32 tfmr, rfmr, tcmr, rcmr;
 	int ret;
 	int fslen, fslen_ext;
+	u32 cmr_div;
+	u32 tcmr_period;
+	u32 rcmr_period;
 
 	/*
 	 * Currently, there is only one set of dma params for
@@ -470,6 +499,46 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
 	else
 		dir = 1;
 
+	/*
+	 * If the cpu dai should provide BCLK, but noone has provided the
+	 * divider needed for that to work, fall back to something sensible.
+	 */
+	cmr_div = ssc_p->cmr_div;
+	if (!(ssc_p->forced_divider & BIT(ATMEL_SSC_CMR_DIV)) &&
+	    atmel_ssc_cbs(ssc_p)) {
+		int bclk_rate = snd_soc_params_to_bclk(params);
+
+		if (bclk_rate < 0) {
+			dev_err(dai->dev, "unable to calculate cmr_div: %d\n",
+				bclk_rate);
+			return bclk_rate;
+		}
+
+		cmr_div = DIV_ROUND_CLOSEST(ssc_p->mck_rate, 2 * bclk_rate);
+	}
+
+	/*
+	 * If the cpu dai should provide LRCLK, but noone has provided the
+	 * dividers needed for that to work, fall back to something sensible.
+	 */
+	tcmr_period = ssc_p->tcmr_period;
+	rcmr_period = ssc_p->rcmr_period;
+	if (atmel_ssc_cfs(ssc_p)) {
+		int frame_size = snd_soc_params_to_frame_size(params);
+
+		if (frame_size < 0) {
+			dev_err(dai->dev,
+				"unable to calculate tx/rx cmr_period: %d\n",
+				frame_size);
+			return frame_size;
+		}
+
+		if (!(ssc_p->forced_divider & BIT(ATMEL_SSC_TCMR_PERIOD)))
+			tcmr_period = frame_size / 2 - 1;
+		if (!(ssc_p->forced_divider & BIT(ATMEL_SSC_RCMR_PERIOD)))
+			rcmr_period = frame_size / 2 - 1;
+	}
+
 	dma_params = ssc_p->dma_params[dir];
 
 	channels = params_channels(params);
@@ -524,7 +593,7 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
 		fslen_ext = (bits - 1) / 16;
 		fslen = (bits - 1) % 16;
 
-		rcmr =	  SSC_BF(RCMR_PERIOD, ssc_p->rcmr_period)
+		rcmr =	  SSC_BF(RCMR_PERIOD, rcmr_period)
 			| SSC_BF(RCMR_STTDLY, START_DELAY)
 			| SSC_BF(RCMR_START, SSC_START_FALLING_RF)
 			| SSC_BF(RCMR_CKI, SSC_CKI_RISING)
@@ -540,7 +609,7 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
 			| SSC_BF(RFMR_LOOP, 0)
 			| SSC_BF(RFMR_DATLEN, (bits - 1));
 
-		tcmr =	  SSC_BF(TCMR_PERIOD, ssc_p->tcmr_period)
+		tcmr =	  SSC_BF(TCMR_PERIOD, tcmr_period)
 			| SSC_BF(TCMR_STTDLY, START_DELAY)
 			| SSC_BF(TCMR_START, SSC_START_FALLING_RF)
 			| SSC_BF(TCMR_CKI, SSC_CKI_FALLING)
@@ -606,7 +675,7 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
 		fslen_ext = (bits - 1) / 16;
 		fslen = (bits - 1) % 16;
 
-		rcmr =	  SSC_BF(RCMR_PERIOD, ssc_p->rcmr_period)
+		rcmr =	  SSC_BF(RCMR_PERIOD, rcmr_period)
 			| SSC_BF(RCMR_STTDLY, START_DELAY)
 			| SSC_BF(RCMR_START, SSC_START_FALLING_RF)
 			| SSC_BF(RCMR_CKI, SSC_CKI_RISING)
@@ -623,7 +692,7 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
 			| SSC_BF(RFMR_LOOP, 0)
 			| SSC_BF(RFMR_DATLEN, (bits - 1));
 
-		tcmr =	  SSC_BF(TCMR_PERIOD, ssc_p->tcmr_period)
+		tcmr =	  SSC_BF(TCMR_PERIOD, tcmr_period)
 			| SSC_BF(TCMR_STTDLY, START_DELAY)
 			| SSC_BF(TCMR_START, SSC_START_FALLING_RF)
 			| SSC_BF(TCMR_CKI, SSC_CKI_FALLING)
@@ -650,7 +719,7 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
 		 * MCK divider, and the BCLK signal is output
 		 * on the SSC TK line.
 		 */
-		rcmr =	  SSC_BF(RCMR_PERIOD, ssc_p->rcmr_period)
+		rcmr =	  SSC_BF(RCMR_PERIOD, rcmr_period)
 			| SSC_BF(RCMR_STTDLY, 1)
 			| SSC_BF(RCMR_START, SSC_START_RISING_RF)
 			| SSC_BF(RCMR_CKI, SSC_CKI_RISING)
@@ -665,7 +734,7 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
 			| SSC_BF(RFMR_LOOP, 0)
 			| SSC_BF(RFMR_DATLEN, (bits - 1));
 
-		tcmr =	  SSC_BF(TCMR_PERIOD, ssc_p->tcmr_period)
+		tcmr =	  SSC_BF(TCMR_PERIOD, tcmr_period)
 			| SSC_BF(TCMR_STTDLY, 1)
 			| SSC_BF(TCMR_START, SSC_START_RISING_RF)
 			| SSC_BF(TCMR_CKI, SSC_CKI_FALLING)
@@ -760,7 +829,7 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	/* set SSC clock mode register */
-	ssc_writel(ssc_p->ssc->regs, CMR, ssc_p->cmr_div);
+	ssc_writel(ssc_p->ssc->regs, CMR, cmr_div);
 
 	/* set receive clock mode and format */
 	ssc_writel(ssc_p->ssc->regs, RCMR, rcmr);
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
2.10.2
