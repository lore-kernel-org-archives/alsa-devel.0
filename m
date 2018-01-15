From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [PATCH v4 10/17] ASoC: fsl_ssi: Set xFEN0 and xFEN1 together
Date: Mon, 15 Jan 2018 15:16:25 -0800
Message-ID: <1516058192-65519-11-git-send-email-nicoleotsuka@gmail.com>
References: <1516058192-65519-1-git-send-email-nicoleotsuka@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1516058192-65519-1-git-send-email-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: timur@tabi.org, broonie@kernel.org, mail@maciej.szmigiero.name
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org, lgirdwood@gmail.com, fabio.estevam@nxp.com, caleb@crome.org, arnaud.mouiche@invoxia.com, lukma@denx.de, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

It'd be safer to enable both FIFOs for TX or RX at the same time.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Tested-by: Caleb Crome <caleb@crome.org>
---
 sound/soc/fsl/fsl_ssi.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index e5efee2..ba06e94 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -591,6 +591,11 @@ static void fsl_ssi_setup_regvals(struct fsl_ssi *ssi)
 	if (fsl_ssi_is_ac97(ssi))
 		vals[RX].scr = vals[TX].scr = 0;
 
+	if (ssi->use_dual_fifo) {
+		vals[RX].srcr |= SSI_SRCR_RFEN1;
+		vals[TX].stcr |= SSI_STCR_TFEN1;
+	}
+
 	if (ssi->use_dma) {
 		vals[RX].sier |= SSI_SIER_RDMAE;
 		vals[TX].sier |= SSI_SIER_TDMAE;
@@ -991,14 +996,9 @@ static int _fsl_ssi_set_dai_fmt(struct device *dev,
 		     SSI_SFCSR_TFWM0(wm) | SSI_SFCSR_RFWM0(wm) |
 		     SSI_SFCSR_TFWM1(wm) | SSI_SFCSR_RFWM1(wm));
 
-	if (ssi->use_dual_fifo) {
-		regmap_update_bits(regs, REG_SSI_SRCR,
-				   SSI_SRCR_RFEN1, SSI_SRCR_RFEN1);
-		regmap_update_bits(regs, REG_SSI_STCR,
-				   SSI_STCR_TFEN1, SSI_STCR_TFEN1);
+	if (ssi->use_dual_fifo)
 		regmap_update_bits(regs, REG_SSI_SCR,
 				   SSI_SCR_TCH_EN, SSI_SCR_TCH_EN);
-	}
 
 	if ((fmt & SND_SOC_DAIFMT_FORMAT_MASK) == SND_SOC_DAIFMT_AC97)
 		fsl_ssi_setup_ac97(ssi);
-- 
2.7.4
