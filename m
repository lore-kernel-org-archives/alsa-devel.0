From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: [PATCH] ASoC: fsl_sai: Fix incorrect condition check in trigger()
Date: Fri, 11 Apr 2014 22:10:00 +0800
Message-ID: <1397225400-2769-1-git-send-email-Guangyu.Chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org, timur@tabi.org, Li.Xiubo@freescale.com
List-Id: alsa-devel@alsa-project.org

Patch ASoC: fsl_sai: Fix buggy configurations in trigger() doesn't entirely
fix the condition: FRDE of the current substream direction is being cleared
while the code is still using the non-updated one.

Thus this patch fixes this issue by checking the opposite one's FRDE alone
since the current one's is absolutely disabled.

Signed-off-by: Nicolin Chen <Guangyu.Chen@freescale.com>
---
 sound/soc/fsl/fsl_sai.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 9858d42..1716a41 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -343,7 +343,8 @@ static int fsl_sai_trigger(struct snd_pcm_substream *substream, int cmd,
 		regmap_update_bits(sai->regmap, FSL_SAI_xCSR(tx),
 				   FSL_SAI_CSR_xIE_MASK, 0);
 
-		if (!(tcsr & FSL_SAI_CSR_FRDE || rcsr & FSL_SAI_CSR_FRDE)) {
+		/* Check if the opposite FRDE is also disabled */
+		if (!(tx ? rcsr & FSL_SAI_CSR_FRDE : tcsr & FSL_SAI_CSR_FRDE)) {
 			regmap_update_bits(sai->regmap, FSL_SAI_TCSR,
 					   FSL_SAI_CSR_TERE, 0);
 			regmap_update_bits(sai->regmap, FSL_SAI_RCSR,
-- 
1.8.4
