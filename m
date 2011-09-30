From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: [PATCH for-3.2 1/2] ASoC: omap-mcbsp: Fix FS polarity
	for LEFT_J, DSP_A and DSP_B formats
Date: Fri, 30 Sep 2011 10:55:32 +0300
Message-ID: <1317369333-20814-1-git-send-email-jarkko.nikula@bitmer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bitmer.com (bitmer.com [213.157.87.50])
	by alsa0.perex.cz (Postfix) with ESMTP id 98F602412D
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Sep 2011 09:56:41 +0200 (CEST)
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
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

Commit 75d9ac4 ("ASoC: Allow DAI formats to be specified in the dai_link")
changed DAI format flag values and we cannot simply invert anymore e.g.
frame-sync with ^= SND_SOC_DAIFMT_NB_IF (which was anyway misuse) as there
is no anymore fixed bit position for bit-clock or frame-sync inversion.

Fix this by relying only on DAI format flag values passed to us and by not
making any assumption on individual bit positions.

Signed-off-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/omap-mcbsp.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 1391ea0..894f2f3 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -398,7 +398,7 @@ static int omap_mcbsp_dai_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 {
 	struct omap_mcbsp_data *mcbsp_data = snd_soc_dai_get_drvdata(cpu_dai);
 	struct omap_mcbsp_reg_cfg *regs = &mcbsp_data->regs;
-	unsigned int temp_fmt = fmt;
+	bool inv_fs = false;
 
 	if (mcbsp_data->configured)
 		return 0;
@@ -430,21 +430,21 @@ static int omap_mcbsp_dai_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 		regs->xcr2	|= XDATDLY(0);
 		regs->spcr1	|= RJUST(2);
 		/* Invert FS polarity configuration */
-		temp_fmt ^= SND_SOC_DAIFMT_NB_IF;
+		inv_fs = true;
 		break;
 	case SND_SOC_DAIFMT_DSP_A:
 		/* 1-bit data delay */
 		regs->rcr2      |= RDATDLY(1);
 		regs->xcr2      |= XDATDLY(1);
 		/* Invert FS polarity configuration */
-		temp_fmt ^= SND_SOC_DAIFMT_NB_IF;
+		inv_fs = true;
 		break;
 	case SND_SOC_DAIFMT_DSP_B:
 		/* 0-bit data delay */
 		regs->rcr2      |= RDATDLY(0);
 		regs->xcr2      |= XDATDLY(0);
 		/* Invert FS polarity configuration */
-		temp_fmt ^= SND_SOC_DAIFMT_NB_IF;
+		inv_fs = true;
 		break;
 	default:
 		/* Unsupported data format */
@@ -468,7 +468,7 @@ static int omap_mcbsp_dai_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 	}
 
 	/* Set bit clock (CLKX/CLKR) and FS polarities */
-	switch (temp_fmt & SND_SOC_DAIFMT_INV_MASK) {
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
 	case SND_SOC_DAIFMT_NB_NF:
 		/*
 		 * Normal BCLK + FS.
@@ -489,6 +489,8 @@ static int omap_mcbsp_dai_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 	default:
 		return -EINVAL;
 	}
+	if (inv_fs == true)
+		regs->pcr0 ^= FSXP | FSRP;
 
 	return 0;
 }
-- 
1.7.6.3
