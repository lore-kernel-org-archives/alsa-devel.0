From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [PATCH v6 09/17] ASoC: fsl_ssi: Clean up fsl_ssi_setup_regvals()
Date: Mon, 12 Feb 2018 14:03:17 -0800
Message-ID: <1518473005-14090-10-git-send-email-nicoleotsuka@gmail.com>
References: <1518473005-14090-1-git-send-email-nicoleotsuka@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1518473005-14090-1-git-send-email-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, timur@tabi.org
Cc: caleb@crome.org, mail@maciej.szmigiero.name, fabio.estevam@nxp.com, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, arnaud.mouiche@invoxia.com, lukma@denx.de, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

This patch cleans fsl_ssi_setup_regvals() by following changes:
1) Moving DBG bits to the first lines.
2) Setting SSIE, RE/TE as default and cleaning it for AC97

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Tested-by: Caleb Crome <caleb@crome.org>
Tested-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Reviewed-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
 sound/soc/fsl/fsl_ssi.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index fc5768d..156f5132 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -580,18 +580,16 @@ static void fsl_ssi_setup_regvals(struct fsl_ssi *ssi)
 {
 	struct fsl_ssi_regvals *vals = ssi->regvals;
 
-	vals[RX].sier = SSI_SIER_RFF0_EN;
+	vals[RX].sier = SSI_SIER_RFF0_EN | FSLSSI_SIER_DBG_RX_FLAGS;
 	vals[RX].srcr = SSI_SRCR_RFEN0;
-	vals[RX].scr = 0;
-	vals[TX].sier = SSI_SIER_TFE0_EN;
+	vals[RX].scr = SSI_SCR_SSIEN | SSI_SCR_RE;
+	vals[TX].sier = SSI_SIER_TFE0_EN | FSLSSI_SIER_DBG_TX_FLAGS;
 	vals[TX].stcr = SSI_STCR_TFEN0;
-	vals[TX].scr = 0;
+	vals[TX].scr = SSI_SCR_SSIEN | SSI_SCR_TE;
 
 	/* AC97 has already enabled SSIEN, RE and TE, so ignore them */
-	if (!fsl_ssi_is_ac97(ssi)) {
-		vals[RX].scr = SSI_SCR_SSIEN | SSI_SCR_RE;
-		vals[TX].scr = SSI_SCR_SSIEN | SSI_SCR_TE;
-	}
+	if (fsl_ssi_is_ac97(ssi))
+		vals[RX].scr = vals[TX].scr = 0;
 
 	if (ssi->use_dma) {
 		vals[RX].sier |= SSI_SIER_RDMAE;
@@ -600,9 +598,6 @@ static void fsl_ssi_setup_regvals(struct fsl_ssi *ssi)
 		vals[RX].sier |= SSI_SIER_RIE;
 		vals[TX].sier |= SSI_SIER_TIE;
 	}
-
-	vals[RX].sier |= FSLSSI_SIER_DBG_RX_FLAGS;
-	vals[TX].sier |= FSLSSI_SIER_DBG_TX_FLAGS;
 }
 
 static void fsl_ssi_setup_ac97(struct fsl_ssi *ssi)
-- 
2.1.4
