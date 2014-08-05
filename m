From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [PATCH] ASoC: fsl_sai: Initialize with software reset
Date: Tue, 5 Aug 2014 17:20:21 +0800
Message-ID: <1407230421-20953-1-git-send-email-nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (dns-bn1lp0143.outbound.protection.outlook.com [207.46.163.143])
 by alsa0.perex.cz (Postfix) with ESMTP id 1E5D5261AFF
 for <alsa-devel@alsa-project.org>; Tue,  5 Aug 2014 11:18:10 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Li.Xiubo@freescale.com, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, timur@tabi.org
List-Id: alsa-devel@alsa-project.org

This patch adds software reset code in dai_probe() so as to make a true init
by clearing SAI's internal logic, including the bit clock generation, status
flags, and FIFO pointers.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 sound/soc/fsl/fsl_sai.c | 9 +++++++--
 sound/soc/fsl/fsl_sai.h | 1 +
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index dc84f98..ef7c758 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -438,8 +438,13 @@ static int fsl_sai_dai_probe(struct snd_soc_dai *cpu_dai)
 {
 	struct fsl_sai *sai = dev_get_drvdata(cpu_dai->dev);
 
-	regmap_update_bits(sai->regmap, FSL_SAI_TCSR, 0xffffffff, 0x0);
-	regmap_update_bits(sai->regmap, FSL_SAI_RCSR, 0xffffffff, 0x0);
+	/* Software Reset for both Tx and Rx */
+	regmap_write(sai->regmap, FSL_SAI_TCSR, FSL_SAI_CSR_SR);
+	regmap_write(sai->regmap, FSL_SAI_RCSR, FSL_SAI_CSR_SR);
+	/* Clear SR bit to finish the reset */
+	regmap_write(sai->regmap, FSL_SAI_TCSR, 0);
+	regmap_write(sai->regmap, FSL_SAI_RCSR, 0);
+
 	regmap_update_bits(sai->regmap, FSL_SAI_TCR1, FSL_SAI_CR1_RFW_MASK,
 			   FSL_SAI_MAXBURST_TX * 2);
 	regmap_update_bits(sai->regmap, FSL_SAI_RCR1, FSL_SAI_CR1_RFW_MASK,
diff --git a/sound/soc/fsl/fsl_sai.h b/sound/soc/fsl/fsl_sai.h
index c24d3fd..b3d8864 100644
--- a/sound/soc/fsl/fsl_sai.h
+++ b/sound/soc/fsl/fsl_sai.h
@@ -48,6 +48,7 @@
 /* SAI Transmit/Recieve Control Register */
 #define FSL_SAI_CSR_TERE	BIT(31)
 #define FSL_SAI_CSR_FR		BIT(25)
+#define FSL_SAI_CSR_SR		BIT(24)
 #define FSL_SAI_CSR_xF_SHIFT	16
 #define FSL_SAI_CSR_xF_W_SHIFT	18
 #define FSL_SAI_CSR_xF_MASK	(0x1f << FSL_SAI_CSR_xF_SHIFT)
-- 
1.8.4
