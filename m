From: Fabio Falzoi <fabio.falzoi84@gmail.com>
Subject: [PATCH] ASoC: fsl-ssi: Support for
	SND_SOC_DAIFMT_CBM_CFS
Date: Mon,  4 Aug 2014 17:08:07 +0200
Message-ID: <1407164887-22703-1-git-send-email-fabio.falzoi84@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f171.google.com (mail-wi0-f171.google.com
 [209.85.212.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 045CA26084B
 for <alsa-devel@alsa-project.org>; Mon,  4 Aug 2014 17:08:34 +0200 (CEST)
Received: by mail-wi0-f171.google.com with SMTP id hi2so5279279wib.10
 for <alsa-devel@alsa-project.org>; Mon, 04 Aug 2014 08:08:32 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: adamo.a60@gmail.com, timur@tabi.org, lgirdwood@gmail.com, broonie@kernel.org, Fabio Falzoi <fabio.falzoi84@gmail.com>, mpa@pengutronix.de, michael@amarulasolutions.com
List-Id: alsa-devel@alsa-project.org

Add SND_SOC_DAIFMT_CBM_CFS support for Freescale architecture.
Successfully tested on i.MX 6Quad Wandboard and UDOO boards connected to
the pcm1792a codec.
In CBM_CFS mode, when using a sample size of 16 bits, we cannot use
CCSR_SSI_SCR_I2S_MODE_MASTER since we get a frame sync every 16 bits.

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Fabio Falzoi <fabio.falzoi84@gmail.com>
Tested-by: Angelo Adamo <adamo.a60@gmail.com>
---
 sound/soc/fsl/fsl_ssi.c | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 87eb577..2fc3e66 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -259,6 +259,11 @@ static bool fsl_ssi_is_i2s_master(struct fsl_ssi_private *ssi_private)
 		SND_SOC_DAIFMT_CBS_CFS;
 }
 
+static bool fsl_ssi_is_i2s_cbm_cfs(struct fsl_ssi_private *ssi_private)
+{
+	return (ssi_private->dai_fmt & SND_SOC_DAIFMT_MASTER_MASK) ==
+		SND_SOC_DAIFMT_CBM_CFS;
+}
 /**
  * fsl_ssi_isr: SSI interrupt handler
  *
@@ -705,6 +710,23 @@ static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
 		}
 	}
 
+	if (!fsl_ssi_is_ac97(ssi_private)) {
+		u8 i2smode;
+		/*
+		 * Switch to normal net mode in order to have a frame sync
+		 * signal every 32 bits instead of 16 bits
+		 */
+		if (fsl_ssi_is_i2s_cbm_cfs(ssi_private) && sample_size == 16)
+			i2smode = CCSR_SSI_SCR_I2S_MODE_NORMAL |
+				CCSR_SSI_SCR_NET;
+		else
+			i2smode = ssi_private->i2s_mode;
+
+		regmap_update_bits(regs, CCSR_SSI_SCR,
+				CCSR_SSI_SCR_NET | CCSR_SSI_SCR_I2S_MODE_MASK,
+				channels == 1 ? 0 : i2smode);
+	}
+
 	/*
 	 * FIXME: The documentation says that SxCCR[WL] should not be
 	 * modified while the SSI is enabled.  The only time this can
@@ -724,11 +746,6 @@ static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
 		regmap_update_bits(regs, CCSR_SSI_SRCCR, CCSR_SSI_SxCCR_WL_MASK,
 				wl);
 
-	if (!fsl_ssi_is_ac97(ssi_private))
-		regmap_update_bits(regs, CCSR_SSI_SCR,
-				CCSR_SSI_SCR_NET | CCSR_SSI_SCR_I2S_MODE_MASK,
-				channels == 1 ? 0 : ssi_private->i2s_mode);
-
 	return 0;
 }
 
@@ -780,6 +797,7 @@ static int _fsl_ssi_set_dai_fmt(struct fsl_ssi_private *ssi_private,
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
 		switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+		case SND_SOC_DAIFMT_CBM_CFS:
 		case SND_SOC_DAIFMT_CBS_CFS:
 			ssi_private->i2s_mode |= CCSR_SSI_SCR_I2S_MODE_MASTER;
 			regmap_update_bits(regs, CCSR_SSI_STCCR,
@@ -853,6 +871,11 @@ static int _fsl_ssi_set_dai_fmt(struct fsl_ssi_private *ssi_private,
 	case SND_SOC_DAIFMT_CBM_CFM:
 		scr &= ~CCSR_SSI_SCR_SYS_CLK_EN;
 		break;
+	case SND_SOC_DAIFMT_CBM_CFS:
+		strcr &= ~CCSR_SSI_STCR_TXDIR;
+		strcr |= CCSR_SSI_STCR_TFDIR;
+		scr &= ~CCSR_SSI_SCR_SYS_CLK_EN;
+		break;
 	default:
 		return -EINVAL;
 	}
-- 
2.0.0
