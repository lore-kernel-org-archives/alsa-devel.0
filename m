From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH] ASoC: fsl-ssi: Allow to use driver with
	generic audio card
Date: Sat, 26 Apr 2014 18:49:16 +0400
Message-ID: <1398523756-9740-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp30.i.mail.ru (smtp30.i.mail.ru [94.100.177.90])
 by alsa0.perex.cz (Postfix) with ESMTP id 566F22610D4
 for <alsa-devel@alsa-project.org>; Sat, 26 Apr 2014 16:49:24 +0200 (CEST)
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
Cc: Alexander Shiyan <shc_work@mail.ru>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.de>, Timur Tabi <timur@tabi.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Generic sound card checks return value of functions for setup format,
clock and slot for -ENOTSUPP error. Add this compatibility to fsl-ssi
driver.
---
I'm really not sure that's a good solution, please correct me if I'm wrong.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 sound/soc/fsl/fsl_ssi.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 25865d8f..6891b8c 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -764,7 +764,7 @@ static int fsl_ssi_set_dai_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
 			ssi_private->i2s_mode |= CCSR_SSI_SCR_I2S_MODE_SLAVE;
 			break;
 		default:
-			return -EINVAL;
+			return -ENOTSUPP;
 		}
 
 		/* Data on rising edge of bclk, frame low, 1clk before data */
@@ -789,7 +789,7 @@ static int fsl_ssi_set_dai_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
 		ssi_private->i2s_mode |= CCSR_SSI_SCR_I2S_MODE_NORMAL;
 		break;
 	default:
-		return -EINVAL;
+		return -ENOTSUPP;
 	}
 	scr |= ssi_private->i2s_mode;
 
@@ -812,7 +812,7 @@ static int fsl_ssi_set_dai_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
 		strcr ^= CCSR_SSI_STCR_TFSI;
 		break;
 	default:
-		return -EINVAL;
+		return -ENOTSUPP;
 	}
 
 	/* DAI clock master masks */
@@ -825,7 +825,7 @@ static int fsl_ssi_set_dai_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
 		scr &= ~CCSR_SSI_SCR_SYS_CLK_EN;
 		break;
 	default:
-		return -EINVAL;
+		return -ENOTSUPP;
 	}
 
 	stcr |= strcr;
@@ -897,7 +897,7 @@ static int fsl_ssi_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 
 	/* Don't apply it to any non-baudclk circumstance */
 	if (IS_ERR(ssi_private->baudclk))
-		return -EINVAL;
+		return -ENOTSUPP;
 
 	/* It should be already enough to divide clock by setting pm alone */
 	psr = 0;
@@ -986,7 +986,7 @@ static int fsl_ssi_set_dai_tdm_slot(struct snd_soc_dai *cpu_dai, u32 tx_mask,
 	val = read_ssi(&ssi->scr) & (CCSR_SSI_SCR_I2S_MODE_MASK | CCSR_SSI_SCR_NET);
 	if (val && slots < 2) {
 		dev_err(cpu_dai->dev, "slot number should be >= 2 in I2S or NET\n");
-		return -EINVAL;
+		return -ENOTSUPP;
 	}
 
 	write_ssi_mask(&ssi->stccr, CCSR_SSI_SxCCR_DC_MASK,
-- 
1.8.3.2
