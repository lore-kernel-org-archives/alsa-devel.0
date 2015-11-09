From: Zidan Wang <zidan.wang@freescale.com>
Subject: [PATCH] ASoC: fsl-sai: don't set bclk for Tx/Rx
	Synchronous with another SAI mode
Date: Mon, 9 Nov 2015 19:02:29 +0800
Message-ID: <b1cf60241eab0069250d00e47e80bb04ce676412.1447066811.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0115.outbound.protection.outlook.com [157.56.111.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 4F0F326153C
 for <alsa-devel@alsa-project.org>; Mon,  9 Nov 2015 12:00:34 +0100 (CET)
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

In fsl_sai_set_bclk function, we should not set bclk for Tx/Rx Synchronous
with another SAI mode.

Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
---
 sound/soc/fsl/fsl_sai.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index ffd5f9a..14c3078 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -354,13 +354,25 @@ static int fsl_sai_set_bclk(struct snd_soc_dai *dai, bool tx, u32 freq)
 		return -EINVAL;
 	}
 
-	if ((tx && sai->synchronous[TX]) || (!tx && !sai->synchronous[RX])) {
+	/*
+	 * 1) For Asynchronous mode, we must set RCR2 register for capture, and
+	 *    set TCR2 register for playback.
+	 * 2) For Tx sync with Rx clock, we must set RCR2 register for playback
+	 *    and capture.
+	 * 3) For Rx sync with Tx clock, we must set TCR2 register for playback
+	 *    and capture.
+	 * 4) For Tx and Rx are both Synchronous with another SAI, we just
+	 *    ignore it.
+	 */
+	if ((sai->synchronous[TX] && !sai->synchronous[RX]) ||
+	    (!tx && !sai->synchronous[RX])) {
 		regmap_update_bits(sai->regmap, FSL_SAI_RCR2,
 				   FSL_SAI_CR2_MSEL_MASK,
 				   FSL_SAI_CR2_MSEL(sai->mclk_id[tx]));
 		regmap_update_bits(sai->regmap, FSL_SAI_RCR2,
 				   FSL_SAI_CR2_DIV_MASK, savediv - 1);
-	} else {
+	} else if ((sai->synchronous[RX] && !sai->synchronous[TX]) ||
+		   (tx && !sai->synchronous[TX])) {
 		regmap_update_bits(sai->regmap, FSL_SAI_TCR2,
 				   FSL_SAI_CR2_MSEL_MASK,
 				   FSL_SAI_CR2_MSEL(sai->mclk_id[tx]));
-- 
1.9.1
