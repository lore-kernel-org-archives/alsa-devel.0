From: Zidan Wang <zidan.wang@freescale.com>
Subject: [PATCH] ASoC: fsl-sai: set xCR4/xCR5/xMR for SAI
	master mode
Date: Mon, 9 Nov 2015 19:03:13 +0800
Message-ID: <090f3aafd8c07a5a29e97c568c6fc0602a0bd5ad.1447066800.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0135.outbound.protection.outlook.com [157.56.110.135])
 by alsa0.perex.cz (Postfix) with ESMTP id 626B72619FB
 for <alsa-devel@alsa-project.org>; Mon,  9 Nov 2015 12:01:00 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: nicoleotsuka@gmail.com, alsa-devel@alsa-project.org, tiwai@suse.com, Zidan Wang <zidan.wang@freescale.com>, Xiubo.Lee@gmail.com
List-Id: alsa-devel@alsa-project.org

For SAI master mode, when Tx(Rx) sync with Rx(Tx) clock, Rx(Tx) will
generate bclk and frame clock for Tx(Rx), we should set RCR4(TCR4),
RCR5(TCR5) and RMR(TMR) for playback(capture), or there will be sync
error sometimes.

Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
---
 sound/soc/fsl/fsl_sai.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 14c3078..9d74ff3 100644
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
1.9.1
