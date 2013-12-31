From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH v2] ASoC: fsl_sai: Fix one bug for hardware
	limitation.
Date: Tue, 31 Dec 2013 15:33:21 +0800
Message-ID: <1388475202-24946-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0250.outbound.messaging.microsoft.com [213.199.154.250])
 by alsa0.perex.cz (Postfix) with ESMTP id E853C2619D0
 for <alsa-devel@alsa-project.org>; Tue, 31 Dec 2013 09:27:38 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This is maybe one bug or a limitation of the hardware that the {T,R}CR2's
Synchronous Mode bits must be set as late as possible, or the SAI device
maybe hanged up, and there has not any explaination about this limitation
in the SAI Data Sheet.

And the {T,R}CR2's Synchronous Mode bits must be set at the same time whether
for Tx or Rx stream.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 sound/soc/fsl/fsl_sai.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index af80246..2ece147 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -145,7 +145,6 @@ static int fsl_sai_set_dai_fmt_tr(struct snd_soc_dai *cpu_dai,
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
 		val_cr4 |= FSL_SAI_CR4_FSE;
-		val_cr4 |= FSL_SAI_CR4_FSP;
 		break;
 	default:
 		return -EINVAL;
@@ -185,9 +184,6 @@ static int fsl_sai_set_dai_fmt_tr(struct snd_soc_dai *cpu_dai,
 		return -EINVAL;
 	}
 
-	if (fsl_dir == FSL_FMT_RECEIVER)
-		val_cr2 |= FSL_SAI_CR2_SYNC;
-
 	sai_writel(sai, val_cr2, sai->base + reg_cr2);
 	sai_writel(sai, val_cr4, sai->base + reg_cr4);
 
@@ -253,6 +249,7 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
 	val_cr5 |= FSL_SAI_CR5_WNW(word_width);
 	val_cr5 |= FSL_SAI_CR5_W0W(word_width);
 
+	val_cr5 &= ~FSL_SAI_CR5_FBT_MASK;
 	if (sai->big_endian_data)
 		val_cr5 |= FSL_SAI_CR5_FBT(word_width - 1);
 	else
@@ -272,7 +269,15 @@ static int fsl_sai_trigger(struct snd_pcm_substream *substream, int cmd,
 		struct snd_soc_dai *cpu_dai)
 {
 	struct fsl_sai *sai = snd_soc_dai_get_drvdata(cpu_dai);
-	u32 tcsr, rcsr, val_cr3, reg_cr3;
+	u32 tcsr, rcsr, val_cr2, val_cr3, reg_cr3;
+
+	val_cr2 = sai_readl(sai, sai->base + FSL_SAI_TCR2);
+	val_cr2 &= ~FSL_SAI_CR2_SYNC;
+	sai_writel(sai, val_cr2, sai->base + FSL_SAI_TCR2);
+
+	val_cr2 = sai_readl(sai, sai->base + FSL_SAI_RCR2);
+	val_cr2 |= FSL_SAI_CR2_SYNC;
+	sai_writel(sai, val_cr2, sai->base + FSL_SAI_RCR2);
 
 	tcsr = sai_readl(sai, sai->base + FSL_SAI_TCSR);
 	rcsr = sai_readl(sai, sai->base + FSL_SAI_RCSR);
-- 
1.8.4
