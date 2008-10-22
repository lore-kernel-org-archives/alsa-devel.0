From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [PATCH] ASoC: OMAP: Continue fixing DSP DAI format in
	McBSP DAI driver
Date: Wed, 22 Oct 2008 15:00:29 +0300
Message-ID: <1224676829-14511-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 101971037FA
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Oct 2008 14:01:26 +0200 (CEST)
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
Cc: Arun KS <arunks@mistralsolutions.com>, Jarkko Nikula <jarkko.nikula@nokia.com>
List-Id: alsa-devel@alsa-project.org

Fix "ASoC: OMAP: Fix DSP DAI format in McBSP DAI driver" was not correct
due misunderstanding of DSP_A format and similar error in TLV320AIC33
codec which was used to test the original fix.

This patch corrects now DSP_A format in OMAP McBSP DAI driver and is
verified with TLV320AIC23 codec that's implementing DSP_A correctly.

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: Arun KS <arunks@mistralsolutions.com>

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 sound/soc/omap/omap-mcbsp.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 853b33a..8485a8a 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -265,7 +265,7 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 		break;
 	case SND_SOC_DAIFMT_DSP_A:
 		regs->srgr2	|= FPER(wlen * 2 - 1);
-		regs->srgr1	|= FWID(0);
+		regs->srgr1	|= FWID(wlen * 2 - 2);
 		break;
 	}
 
@@ -284,7 +284,6 @@ static int omap_mcbsp_dai_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 {
 	struct omap_mcbsp_data *mcbsp_data = to_mcbsp(cpu_dai->private_data);
 	struct omap_mcbsp_reg_cfg *regs = &mcbsp_data->regs;
-	unsigned int temp_fmt = fmt;
 
 	if (mcbsp_data->configured)
 		return 0;
@@ -307,8 +306,6 @@ static int omap_mcbsp_dai_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 		/* 0-bit data delay */
 		regs->rcr2      |= RDATDLY(0);
 		regs->xcr2      |= XDATDLY(0);
-		/* Invert bit clock and FS polarity configuration for DSP_A */
-		temp_fmt ^= SND_SOC_DAIFMT_IB_IF;
 		break;
 	default:
 		/* Unsupported data format */
@@ -332,7 +329,7 @@ static int omap_mcbsp_dai_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 	}
 
 	/* Set bit clock (CLKX/CLKR) and FS polarities */
-	switch (temp_fmt & SND_SOC_DAIFMT_INV_MASK) {
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
 	case SND_SOC_DAIFMT_NB_NF:
 		/*
 		 * Normal BCLK + FS.
-- 
1.5.6.5
