From: Michael Trimarchi <michael@amarulasolutions.com>
Subject: [RFC PATCH] ASoC: fsl-ssi: Add support for CBM_CFS
	16/24 bit
Date: Mon, 28 Jul 2014 14:46:38 +0200
Message-ID: <1406551598-14740-1-git-send-email-michael@amarulasolutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f46.google.com (mail-wg0-f46.google.com [74.125.82.46])
 by alsa0.perex.cz (Postfix) with ESMTP id D85432619FE
 for <alsa-devel@alsa-project.org>; Mon, 28 Jul 2014 14:46:44 +0200 (CEST)
Received: by mail-wg0-f46.google.com with SMTP id m15so7263605wgh.5
 for <alsa-devel@alsa-project.org>; Mon, 28 Jul 2014 05:46:41 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@tabi.org>
Cc: Markus Pargmann <mpa@pengutronix.de>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---
 sound/soc/fsl/fsl_ssi.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 9bfef55..743e50d 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -724,10 +724,19 @@ static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
 		regmap_update_bits(regs, CCSR_SSI_SRCCR, CCSR_SSI_SxCCR_WL_MASK,
 				wl);
 
-	if (!fsl_ssi_is_ac97(ssi_private))
+	if (!fsl_ssi_is_ac97(ssi_private)) {
+		u8 i2smode;
+
+		if (ssi_private->i2s_mode == (CCSR_SSI_SCR_I2S_MODE_NORMAL |
+		    CCSR_SSI_SCR_NET) && sample_size >= 24)
+			i2smode = CCSR_SSI_SCR_I2S_MODE_MASTER;
+		else
+			i2smode = ssi_private->i2s_mode;
+
 		regmap_update_bits(regs, CCSR_SSI_SCR,
 				CCSR_SSI_SCR_NET | CCSR_SSI_SCR_I2S_MODE_MASK,
-				channels == 1 ? 0 : ssi_private->i2s_mode);
+				channels == 1 ? 0 : i2smode);
+	}
 
 	return 0;
 }
@@ -789,6 +798,15 @@ static int _fsl_ssi_set_dai_fmt(struct fsl_ssi_private *ssi_private,
 					CCSR_SSI_SxCCR_DC_MASK,
 					CCSR_SSI_SxCCR_DC(2));
 			break;
+		case SND_SOC_DAIFMT_CBM_CFS:
+			ssi_private->i2s_mode |= CCSR_SSI_SCR_I2S_MODE_NORMAL;
+			regmap_update_bits(regs, CCSR_SSI_STCCR,
+					CCSR_SSI_SxCCR_DC_MASK,
+					CCSR_SSI_SxCCR_DC(2));
+			regmap_update_bits(regs, CCSR_SSI_SRCCR,
+					CCSR_SSI_SxCCR_DC_MASK,
+					CCSR_SSI_SxCCR_DC(2));
+			break;
 		case SND_SOC_DAIFMT_CBM_CFM:
 			ssi_private->i2s_mode |= CCSR_SSI_SCR_I2S_MODE_SLAVE;
 			break;
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
1.8.1.2
