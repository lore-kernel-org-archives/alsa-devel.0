From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl: fix typos for sound/soc/fsl/*" to
	the asoc tree
Date: Fri, 14 Aug 2015 19:15:12 -0700
Message-ID: <E1ZQR04-0004SF-Bl@finisterre>
References: <1439361498-8489-1-git-send-email-lixiubo@cmss.chinamobile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C6C1266632
 for <alsa-devel@alsa-project.org>; Sat, 15 Aug 2015 04:15:19 +0200 (CEST)
In-Reply-To: <1439361498-8489-1-git-send-email-lixiubo@cmss.chinamobile.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Xiubo Li <lixiubo@cmss.chinamobile.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl: fix typos for sound/soc/fsl/*

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

>From dcfcf2c2cd71906073beef32aadb1989e8996951 Mon Sep 17 00:00:00 2001
From: Xiubo Li <lixiubo@cmss.chinamobile.com>
Date: Wed, 12 Aug 2015 14:38:18 +0800
Subject: [PATCH] ASoC: fsl: fix typos for sound/soc/fsl/*

There are too much noise about the typos for fsl's drivers. So I fix
all the typos here in this patch in almost every file I touched.

Signed-off-by: Xiubo Li <lixiubo@cmss.chinamobile.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
index d1e9be7..92efbc5 100644
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
index e122dab..6a338b8 100644
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
2.5.0
