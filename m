From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [PATCH v6 10/17] ASoC: fsl_ssi: Set xFEN0 and xFEN1
	together
Date: Mon, 12 Feb 2018 14:03:18 -0800
Message-ID: <1518473005-14090-11-git-send-email-nicoleotsuka@gmail.com>
References: <1518473005-14090-1-git-send-email-nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f66.google.com (mail-pg0-f66.google.com [74.125.83.66])
 by alsa0.perex.cz (Postfix) with ESMTP id A61A426759B
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 23:02:51 +0100 (CET)
Received: by mail-pg0-f66.google.com with SMTP id g2so8413629pgn.7
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 14:02:51 -0800 (PST)
In-Reply-To: <1518473005-14090-1-git-send-email-nicoleotsuka@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, timur@tabi.org
Cc: mail@maciej.szmigiero.name, kernel@pengutronix.de, lgirdwood@gmail.com, alsa-devel@alsa-project.org, caleb@crome.org, linux-kernel@vger.kernel.org, arnaud.mouiche@invoxia.com, lukma@denx.de, fabio.estevam@nxp.com, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

It'd be safer to enable both FIFOs for TX or RX at the same time.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Tested-by: Caleb Crome <caleb@crome.org>
Tested-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Reviewed-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
 sound/soc/fsl/fsl_ssi.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 156f5132..00dfdc7 100644
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
2.1.4
