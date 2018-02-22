From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl_ssi: Clean up set_dai_tdm_slot()"
	to the asoc tree
Date: Thu, 22 Feb 2018 13:17:06 +0000
Message-ID: <E1eoqkE-0006S8-AE@debutante>
References: <1513702819-42310-2-git-send-email-nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id F22432677D8
 for <alsa-devel@alsa-project.org>; Thu, 22 Feb 2018 14:17:19 +0100 (CET)
In-Reply-To: <1513702819-42310-2-git-send-email-nicoleotsuka@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: mail@maciej.szmigiero.name, arnaud.mouiche@invoxia.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, timur@tabi.org, caleb@crome.org, lgirdwood@gmail.com, broonie@kernel.org, kernel@pengutronix.de, lukma@denx.de, fabio.estevam@nxp.com, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl_ssi: Clean up set_dai_tdm_slot()

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 09947634829ccc5568a80ac02c3395a8b77276c1 Mon Sep 17 00:00:00 2001
From: Nicolin Chen <nicoleotsuka@gmail.com>
Date: Mon, 12 Feb 2018 14:03:11 -0800
Subject: [PATCH] ASoC: fsl_ssi: Clean up set_dai_tdm_slot()

This patch replaces the register read with ssi->i2s_net for
simplification. It also removes masking SSIEN from scr value
since it's handled later by regmap_update_bits() to set this
scr value back.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Tested-by: Caleb Crome <caleb@crome.org>
Tested-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Reviewed-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_ssi.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index d4f1f0d64136..14046c32dc07 100644
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
2.16.1
