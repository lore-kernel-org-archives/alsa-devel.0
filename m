From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH] ASoC: fsl-sai: Clean up the code
Date: Wed, 8 Jan 2014 16:13:05 +0800
Message-ID: <1389168785-1944-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe003.messaging.microsoft.com [207.46.163.26])
 by alsa0.perex.cz (Postfix) with ESMTP id 461F5261622
 for <alsa-devel@alsa-project.org>; Wed,  8 Jan 2014 10:09:16 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, Xiubo Li <Li.Xiubo@freescale.com>, timur@tabi.org
List-Id: alsa-devel@alsa-project.org

Makes the code slightly shorter.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 sound/soc/fsl/fsl_sai.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 5d38a67..cdd3fa8 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -62,26 +62,25 @@ static int fsl_sai_set_dai_sysclk_tr(struct snd_soc_dai *cpu_dai,
 		reg_cr2 = FSL_SAI_RCR2;
 
 	val_cr2 = sai_readl(sai, sai->base + reg_cr2);
+	val_cr2 &= ~FSL_SAI_CR2_MSEL_MASK;
+
 	switch (clk_id) {
 	case FSL_SAI_CLK_BUS:
-		val_cr2 &= ~FSL_SAI_CR2_MSEL_MASK;
 		val_cr2 |= FSL_SAI_CR2_MSEL_BUS;
 		break;
 	case FSL_SAI_CLK_MAST1:
-		val_cr2 &= ~FSL_SAI_CR2_MSEL_MASK;
 		val_cr2 |= FSL_SAI_CR2_MSEL_MCLK1;
 		break;
 	case FSL_SAI_CLK_MAST2:
-		val_cr2 &= ~FSL_SAI_CR2_MSEL_MASK;
 		val_cr2 |= FSL_SAI_CR2_MSEL_MCLK2;
 		break;
 	case FSL_SAI_CLK_MAST3:
-		val_cr2 &= ~FSL_SAI_CR2_MSEL_MASK;
 		val_cr2 |= FSL_SAI_CR2_MSEL_MCLK3;
 		break;
 	default:
 		return -EINVAL;
 	}
+
 	sai_writel(sai, val_cr2, sai->base + reg_cr2);
 
 	return 0;
-- 
1.8.4
