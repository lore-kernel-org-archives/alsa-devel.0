From: Xiubo Li <lixiubo@cmss.chinamobile.com>
Subject: [PATCH] ASoC: fsl: fix typos for sound/soc/fsl/*
Date: Wed, 12 Aug 2015 14:38:18 +0800
Message-ID: <1439361498-8489-1-git-send-email-lixiubo@cmss.chinamobile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cmccmta1.chinamobile.com (cmccmta1.chinamobile.com
 [221.176.66.79])
 by alsa0.perex.cz (Postfix) with ESMTP id C4590260670
 for <alsa-devel@alsa-project.org>; Wed, 12 Aug 2015 08:38:52 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Xiubo Li <lixiubo@cmss.chinamobile.com>
List-Id: alsa-devel@alsa-project.org

There are too much noise about the typos for fsl's drivers. So I fix
all the typos here in this patch in almost every file I touched.

Signed-off-by: Xiubo Li <lixiubo@cmss.chinamobile.com>
---
 sound/soc/fsl/eukrea-tlv320.c |  2 +-
 sound/soc/fsl/fsl_sai.h       | 12 ++++++------
 sound/soc/fsl/fsl_spdif.c     |  6 +++---
 sound/soc/fsl/fsl_ssi.c       |  4 ++--
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/sound/soc/fsl/eukrea-tlv320.c b/sound/soc/fsl/eukrea-tlv320.c
index e1aa3834..883087f 100644
--- a/sound/soc/fsl/eukrea-tlv320.c
+++ b/sound/soc/fsl/eukrea-tlv320.c
@@ -182,7 +182,7 @@ static int eukrea_tlv320_probe(struct platform_device *pdev)
 		);
 	} else {
 		if (np) {
-			/* The eukrea,asoc-tlv320 driver was explicitely
+			/* The eukrea,asoc-tlv320 driver was explicitly
 			 * requested (through the device tree).
 			 */
 			dev_err(&pdev->dev,
diff --git a/sound/soc/fsl/fsl_sai.h b/sound/soc/fsl/fsl_sai.h
index 0662809..b4666fd 100644
--- a/sound/soc/fsl/fsl_sai.h
+++ b/sound/soc/fsl/fsl_sai.h
@@ -45,7 +45,7 @@
 #define FSL_SAI_xFR(tx)		(tx ? FSL_SAI_TFR : FSL_SAI_RFR)
 #define FSL_SAI_xMR(tx)		(tx ? FSL_SAI_TMR : FSL_SAI_RMR)
 
-/* SAI Transmit/Recieve Control Register */
+/* SAI Transmit/Receive Control Register */
 #define FSL_SAI_CSR_TERE	BIT(31)
 #define FSL_SAI_CSR_FR		BIT(25)
 #define FSL_SAI_CSR_SR		BIT(24)
@@ -67,10 +67,10 @@
 #define FSL_SAI_CSR_FRIE	BIT(8)
 #define FSL_SAI_CSR_FRDE	BIT(0)
 
-/* SAI Transmit and Recieve Configuration 1 Register */
+/* SAI Transmit and Receive Configuration 1 Register */
 #define FSL_SAI_CR1_RFW_MASK	0x1f
 
-/* SAI Transmit and Recieve Configuration 2 Register */
+/* SAI Transmit and Receive Configuration 2 Register */
 #define FSL_SAI_CR2_SYNC	BIT(30)
 #define FSL_SAI_CR2_MSEL_MASK	(0x3 << 26)
 #define FSL_SAI_CR2_MSEL_BUS	0
@@ -82,12 +82,12 @@
 #define FSL_SAI_CR2_BCD_MSTR	BIT(24)
 #define FSL_SAI_CR2_DIV_MASK	0xff
 
-/* SAI Transmit and Recieve Configuration 3 Register */
+/* SAI Transmit and Receive Configuration 3 Register */
 #define FSL_SAI_CR3_TRCE	BIT(16)
 #define FSL_SAI_CR3_WDFL(x)	(x)
 #define FSL_SAI_CR3_WDFL_MASK	0x1f
 
-/* SAI Transmit and Recieve Configuration 4 Register */
+/* SAI Transmit and Receive Configuration 4 Register */
 #define FSL_SAI_CR4_FRSZ(x)	(((x) - 1) << 16)
 #define FSL_SAI_CR4_FRSZ_MASK	(0x1f << 16)
 #define FSL_SAI_CR4_SYWD(x)	(((x) - 1) << 8)
@@ -97,7 +97,7 @@
 #define FSL_SAI_CR4_FSP		BIT(1)
 #define FSL_SAI_CR4_FSD_MSTR	BIT(0)
 
-/* SAI Transmit and Recieve Configuration 5 Register */
+/* SAI Transmit and Receive Configuration 5 Register */
 #define FSL_SAI_CR5_WNW(x)	(((x) - 1) << 24)
 #define FSL_SAI_CR5_WNW_MASK	(0x1f << 24)
 #define FSL_SAI_CR5_W0W(x)	(((x) - 1) << 16)
diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index 8e93221..400d60e 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -707,7 +707,7 @@ static int fsl_spdif_subcode_get(struct snd_kcontrol *kcontrol,
 	return ret;
 }
 
-/* Q-subcode infomation. The byte size is SPDIF_UBITS_SIZE/8 */
+/* Q-subcode information. The byte size is SPDIF_UBITS_SIZE/8 */
 static int fsl_spdif_qinfo(struct snd_kcontrol *kcontrol,
 				struct snd_ctl_elem_info *uinfo)
 {
@@ -739,7 +739,7 @@ static int fsl_spdif_qget(struct snd_kcontrol *kcontrol,
 	return ret;
 }
 
-/* Valid bit infomation */
+/* Valid bit information */
 static int fsl_spdif_vbit_info(struct snd_kcontrol *kcontrol,
 				struct snd_ctl_elem_info *uinfo)
 {
@@ -767,7 +767,7 @@ static int fsl_spdif_vbit_get(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-/* DPLL lock infomation */
+/* DPLL lock information */
 static int fsl_spdif_rxrate_info(struct snd_kcontrol *kcontrol,
 				struct snd_ctl_elem_info *uinfo)
 {
diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index c0b940e..b759448 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -156,7 +156,7 @@ struct fsl_ssi_soc_data {
  *
  * @dbg_stats: Debugging statistics
  *
- * @soc: SoC specifc data
+ * @soc: SoC specific data
  */
 struct fsl_ssi_private {
 	struct regmap *regs;
@@ -1210,7 +1210,7 @@ static int fsl_ssi_imx_probe(struct platform_device *pdev,
 		}
 	}
 
-	/* For those SLAVE implementations, we ingore non-baudclk cases
+	/* For those SLAVE implementations, we ignore non-baudclk cases
 	 * and, instead, abandon MASTER mode that needs baud clock.
 	 */
 	ssi_private->baudclk = devm_clk_get(&pdev->dev, "baud");
-- 
1.9.1
