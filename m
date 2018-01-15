From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [PATCH v4 03/17] ASoC: fsl_ssi: Clean up
	set_dai_tdm_slot()
Date: Mon, 15 Jan 2018 15:16:18 -0800
Message-ID: <1516058192-65519-4-git-send-email-nicoleotsuka@gmail.com>
References: <1516058192-65519-1-git-send-email-nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f66.google.com (mail-pg0-f66.google.com [74.125.83.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 005FE26761B
 for <alsa-devel@alsa-project.org>; Tue, 16 Jan 2018 00:17:25 +0100 (CET)
Received: by mail-pg0-f66.google.com with SMTP id 136so8044181pgd.8
 for <alsa-devel@alsa-project.org>; Mon, 15 Jan 2018 15:17:25 -0800 (PST)
In-Reply-To: <1516058192-65519-1-git-send-email-nicoleotsuka@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: timur@tabi.org, broonie@kernel.org, mail@maciej.szmigiero.name
Cc: alsa-devel@alsa-project.org, kernel@pengutronix.de, linux-kernel@vger.kernel.org, caleb@crome.org, lgirdwood@gmail.com, arnaud.mouiche@invoxia.com, lukma@denx.de, fabio.estevam@nxp.com, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

This patch replaces the register read with ssi->i2s_net for
simplification. It also removes masking SSIEN from scr value
since it's handled later by regmap_update_bits() to set this
scr value back.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Tested-by: Caleb Crome <caleb@crome.org>
---
 sound/soc/fsl/fsl_ssi.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 9847a1d..8984ee2 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -1055,9 +1055,7 @@ static int fsl_ssi_set_dai_tdm_slot(struct snd_soc_dai *dai, u32 tx_mask,
 	}
 
 	/* The slot number should be >= 2 if using Network mode or I2S mode */
-	regmap_read(regs, REG_SSI_SCR, &val);
-	val &= SSI_SCR_I2S_MODE_MASK | SSI_SCR_NET;
-	if (val && slots < 2) {
+	if (ssi->i2s_net && slots < 2) {
 		dev_err(dai->dev, "slot number should be >= 2 in I2S or NET\n");
 		return -EINVAL;
 	}
@@ -1067,9 +1065,8 @@ static int fsl_ssi_set_dai_tdm_slot(struct snd_soc_dai *dai, u32 tx_mask,
 	regmap_update_bits(regs, REG_SSI_SRCCR,
 			   SSI_SxCCR_DC_MASK, SSI_SxCCR_DC(slots));
 
-	/* Save SSIEN bit of the SCR register */
+	/* Save the SCR register value */
 	regmap_read(regs, REG_SSI_SCR, &val);
-	val &= SSI_SCR_SSIEN;
 	/* Temporarily enable SSI to allow SxMSKs to be configurable */
 	regmap_update_bits(regs, REG_SSI_SCR, SSI_SCR_SSIEN, SSI_SCR_SSIEN);
 
-- 
2.7.4
