From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl-sai: set xCR4/xCR5/xMR for SAI
	master mode" to the asoc tree
Date: Tue, 17 Nov 2015 18:54:44 +0000
Message-ID: <E1ZylOu-0003zm-Sm@debutante>
References: <090f3aafd8c07a5a29e97c568c6fc0602a0bd5ad.1447066800.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7CECB2652E2
 for <alsa-devel@alsa-project.org>; Tue, 17 Nov 2015 19:54:54 +0100 (CET)
In-Reply-To: <090f3aafd8c07a5a29e97c568c6fc0602a0bd5ad.1447066800.git.zidan.wang@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Zidan Wang <zidan.wang@freescale.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl-sai: set xCR4/xCR5/xMR for SAI master mode

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 51659ca069ce5bdf20675a7967a39ef8419e87f2 Mon Sep 17 00:00:00 2001
From: Zidan Wang <zidan.wang@freescale.com>
Date: Mon, 9 Nov 2015 19:03:13 +0800
Subject: [PATCH] ASoC: fsl-sai: set xCR4/xCR5/xMR for SAI master mode

For SAI master mode, when Tx(Rx) sync with Rx(Tx) clock, Rx(Tx) will
generate bclk and frame clock for Tx(Rx), we should set RCR4(TCR4),
RCR5(TCR5) and RMR(TMR) for playback(capture), or there will be sync
error sometimes.

Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_sai.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 7e421a97c090..520dbadaa8b1 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -427,6 +427,35 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
 
 	val_cr4 |= FSL_SAI_CR4_FRSZ(channels);
 
+	/*
+	 * For SAI master mode, when Tx(Rx) sync with Rx(Tx) clock, Rx(Tx) will
+	 * generate bclk and frame clock for Tx(Rx), we should set RCR4(TCR4),
+	 * RCR5(TCR5) and RMR(TMR) for playback(capture), or there will be sync
+	 * error.
+	 */
+
+	if (!sai->is_slave_mode) {
+		if (!sai->synchronous[TX] && sai->synchronous[RX] && !tx) {
+			regmap_update_bits(sai->regmap, FSL_SAI_TCR4,
+				FSL_SAI_CR4_SYWD_MASK | FSL_SAI_CR4_FRSZ_MASK,
+				val_cr4);
+			regmap_update_bits(sai->regmap, FSL_SAI_TCR5,
+				FSL_SAI_CR5_WNW_MASK | FSL_SAI_CR5_W0W_MASK |
+				FSL_SAI_CR5_FBT_MASK, val_cr5);
+			regmap_write(sai->regmap, FSL_SAI_TMR,
+				~0UL - ((1 << channels) - 1));
+		} else if (!sai->synchronous[RX] && sai->synchronous[TX] && tx) {
+			regmap_update_bits(sai->regmap, FSL_SAI_RCR4,
+				FSL_SAI_CR4_SYWD_MASK | FSL_SAI_CR4_FRSZ_MASK,
+				val_cr4);
+			regmap_update_bits(sai->regmap, FSL_SAI_RCR5,
+				FSL_SAI_CR5_WNW_MASK | FSL_SAI_CR5_W0W_MASK |
+				FSL_SAI_CR5_FBT_MASK, val_cr5);
+			regmap_write(sai->regmap, FSL_SAI_RMR,
+				~0UL - ((1 << channels) - 1));
+		}
+	}
+
 	regmap_update_bits(sai->regmap, FSL_SAI_xCR4(tx),
 			   FSL_SAI_CR4_SYWD_MASK | FSL_SAI_CR4_FRSZ_MASK,
 			   val_cr4);
-- 
2.6.2
