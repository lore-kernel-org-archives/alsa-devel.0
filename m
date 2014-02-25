From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH] ASoC: fsl-sai: fix Freescale SAI DAI format setting.
Date: Tue, 25 Feb 2014 17:54:51 +0800
Message-ID: <1393322091-24427-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Xiubo Li <Li.Xiubo@freescale.com>
List-Id: alsa-devel@alsa-project.org

o Fix some bugs of fsl_sai_set_dai_fmt_tr().
o Add SND_SOC_DAIFMT_LEFT_J support.
o Add SND_SOC_DAIFMT_CBS_CFM support.
o Add SND_SOC_DAIFMT_CBM_CFS support.
o And SND_SOC_DAIFMT_RIGHT_J need to be done in the future.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 sound/soc/fsl/fsl_sai.c | 38 +++++++++++++++++++++++++++++---------
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index faa65af..26d9f5e 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -105,35 +105,47 @@ static int fsl_sai_set_dai_fmt_tr(struct snd_soc_dai *cpu_dai,
 	else
 		val_cr4 |= FSL_SAI_CR4_MF;
 
+	/* DAI mode */
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
-		val_cr4 |= FSL_SAI_CR4_FSE;
+		/* Data on rising edge of bclk, frame low, 1clk before data */
+		val_cr2 &= ~FSL_SAI_CR2_BCP;
+		val_cr4 |= FSL_SAI_CR4_FSE | FSL_SAI_CR4_FSP;
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		/* Data on rising edge of bclk, frame high, 0clk before data */
+		val_cr2 &= ~FSL_SAI_CR2_BCP;
+		val_cr4 &= ~(FSL_SAI_CR4_FSE | FSL_SAI_CR4_FSP);
 		break;
+	case SND_SOC_DAIFMT_RIGHT_J:
+		/* To be done */
 	default:
 		return -EINVAL;
 	}
 
+	/* DAI clock inversion */
 	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
 	case SND_SOC_DAIFMT_IB_IF:
-		val_cr4 |= FSL_SAI_CR4_FSP;
-		val_cr2 &= ~FSL_SAI_CR2_BCP;
+		/* Invert both clocks */
+		val_cr2 ^= FSL_SAI_CR2_BCP;
+		val_cr4 ^= FSL_SAI_CR4_FSP;
 		break;
 	case SND_SOC_DAIFMT_IB_NF:
-		val_cr4 &= ~FSL_SAI_CR4_FSP;
-		val_cr2 &= ~FSL_SAI_CR2_BCP;
+		/* Invert bit clock */
+		val_cr2 ^= FSL_SAI_CR2_BCP;
 		break;
 	case SND_SOC_DAIFMT_NB_IF:
-		val_cr4 |= FSL_SAI_CR4_FSP;
-		val_cr2 |= FSL_SAI_CR2_BCP;
+		/* Invert frame clock */
+		val_cr4 ^= FSL_SAI_CR4_FSP;
 		break;
 	case SND_SOC_DAIFMT_NB_NF:
-		val_cr4 &= ~FSL_SAI_CR4_FSP;
-		val_cr2 |= FSL_SAI_CR2_BCP;
+		/* Nothing to do for both normal cases */
 		break;
 	default:
 		return -EINVAL;
 	}
 
+	/* DAI clock master masks */
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
 	case SND_SOC_DAIFMT_CBS_CFS:
 		val_cr2 |= FSL_SAI_CR2_BCD_MSTR;
@@ -143,6 +155,14 @@ static int fsl_sai_set_dai_fmt_tr(struct snd_soc_dai *cpu_dai,
 		val_cr2 &= ~FSL_SAI_CR2_BCD_MSTR;
 		val_cr4 &= ~FSL_SAI_CR4_FSD_MSTR;
 		break;
+	case SND_SOC_DAIFMT_CBS_CFM:
+		val_cr2 |= FSL_SAI_CR2_BCD_MSTR;
+		val_cr4 &= ~FSL_SAI_CR4_FSD_MSTR;
+		break;
+	case SND_SOC_DAIFMT_CBM_CFS:
+		val_cr2 &= ~FSL_SAI_CR2_BCD_MSTR;
+		val_cr4 |= FSL_SAI_CR4_FSD_MSTR;
+		break;
 	default:
 		return -EINVAL;
 	}
-- 
1.8.4
