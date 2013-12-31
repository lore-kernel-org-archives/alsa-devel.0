From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH] ASoC: fsl_sai: fix the endianess for SAI fifo data.
Date: Tue, 31 Dec 2013 15:33:22 +0800
Message-ID: <1388475202-24946-2-git-send-email-Li.Xiubo@freescale.com>
References: <1388475202-24946-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1388475202-24946-1-git-send-email-Li.Xiubo@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Revert the SAI's endianess for fifo data to/from DMA engine.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 sound/soc/fsl/fsl_sai.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 2ece147..5d38a67 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -138,9 +138,9 @@ static int fsl_sai_set_dai_fmt_tr(struct snd_soc_dai *cpu_dai,
 	val_cr4 = sai_readl(sai, sai->base + reg_cr4);
 
 	if (sai->big_endian_data)
-		val_cr4 |= FSL_SAI_CR4_MF;
-	else
 		val_cr4 &= ~FSL_SAI_CR4_MF;
+	else
+		val_cr4 |= FSL_SAI_CR4_MF;
 
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
@@ -251,9 +251,9 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
 
 	val_cr5 &= ~FSL_SAI_CR5_FBT_MASK;
 	if (sai->big_endian_data)
-		val_cr5 |= FSL_SAI_CR5_FBT(word_width - 1);
-	else
 		val_cr5 |= FSL_SAI_CR5_FBT(0);
+	else
+		val_cr5 |= FSL_SAI_CR5_FBT(word_width - 1);
 
 	val_cr4 |= FSL_SAI_CR4_FRSZ(channels);
 	val_mr = ~0UL - ((1 << channels) - 1);
-- 
1.8.4
