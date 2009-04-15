From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [2.6.30-rc2][PATCH 1/2] ASoC: OMAP: Fix DSP_B format
	in OMAP McBSP DAI driver
Date: Wed, 15 Apr 2009 13:48:16 +0300
Message-ID: <1239792497-31761-2-git-send-email-jarkko.nikula@nokia.com>
References: <1239792497-31761-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id E448A1037F5
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Apr 2009 12:47:51 +0200 (CEST)
In-Reply-To: <1239792497-31761-1-git-send-email-jarkko.nikula@nokia.com>
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
Cc: Peter Ujfalusi <peter.ujfalusi@nokia.com>, Jarkko Nikula <jarkko.nikula@nokia.com>, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

The DSP format wasn't still correct in OMAP McBSP DAI even after the commit
bd25867a6cbe7a00ef7dbe8d9ddebc91b00b9b3f.

Thanks to Peter Ujfalusi <peter.ujfalusi@nokia.com> for noticing and being
part of the fix. Now the FS length definition is more clear by defining
it with  FWID(0).

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/omap/omap-mcbsp.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 9c09b94..90f4df7 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -283,7 +283,7 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 		break;
 	case SND_SOC_DAIFMT_DSP_B:
 		regs->srgr2	|= FPER(wlen * channels - 1);
-		regs->srgr1	|= FWID(wlen * channels - 2);
+		regs->srgr1	|= FWID(0);
 		break;
 	}
 
@@ -302,6 +302,7 @@ static int omap_mcbsp_dai_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 {
 	struct omap_mcbsp_data *mcbsp_data = to_mcbsp(cpu_dai->private_data);
 	struct omap_mcbsp_reg_cfg *regs = &mcbsp_data->regs;
+	unsigned int temp_fmt = fmt;
 
 	if (mcbsp_data->configured)
 		return 0;
@@ -328,6 +329,8 @@ static int omap_mcbsp_dai_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 		/* 0-bit data delay */
 		regs->rcr2      |= RDATDLY(0);
 		regs->xcr2      |= XDATDLY(0);
+		/* Invert FS polarity configuration */
+		temp_fmt ^= SND_SOC_DAIFMT_NB_IF;
 		break;
 	default:
 		/* Unsupported data format */
@@ -351,7 +354,7 @@ static int omap_mcbsp_dai_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 	}
 
 	/* Set bit clock (CLKX/CLKR) and FS polarities */
-	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	switch (temp_fmt & SND_SOC_DAIFMT_INV_MASK) {
 	case SND_SOC_DAIFMT_NB_NF:
 		/*
 		 * Normal BCLK + FS.
-- 
1.6.2.1
