From: Zidan Wang <zidan.wang@freescale.com>
Subject: [PATCH v3 3/4] ASoC: fsl_ssi: Add driver suspend and
	resume to support MEGA Fast
Date: Fri, 7 Aug 2015 14:21:07 +0800
Message-ID: <5aa6b56070fec04f7ddea266080641e2d9780df6.1438928296.git.zidan.wang@freescale.com>
References: <6fa4e6ebf1f34f5d637324c9f62e68b03037568c.1438928296.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0112.outbound.protection.outlook.com [157.56.111.112])
 by alsa0.perex.cz (Postfix) with ESMTP id E3B95260701
 for <alsa-devel@alsa-project.org>; Fri,  7 Aug 2015 08:20:03 +0200 (CEST)
In-Reply-To: <6fa4e6ebf1f34f5d637324c9f62e68b03037568c.1438928296.git.zidan.wang@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: nicoleotsuka@gmail.com
Cc: alsa-devel@alsa-project.org, timur@tabi.org, Zidan Wang <zidan.wang@freescale.com>, Xiubo.Lee@gmail.com, tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

For i.MX6 SoloX, there is a mode of the SoC to shutdown all power
source of modules during system suspend and resume procedure. Thus,
SSI needs to save all the values of registers before the system
suspend and restore them after the system resume.

The register SFCSR is volatile, but some bits in it need to be
recovered after suspend/resume.

Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
---
 sound/soc/fsl/fsl_ssi.c | 102 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 484ff20..f322cec 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -111,12 +111,75 @@ struct fsl_ssi_rxtx_reg_val {
 	struct fsl_ssi_reg_val rx;
 	struct fsl_ssi_reg_val tx;
 };
+
+static const struct reg_default fsl_ssi_reg_defaults[] = {
+	{0x10, 0x00000000},
+	{0x18, 0x00003003},
+	{0x1c, 0x00000200},
+	{0x20, 0x00000200},
+	{0x24, 0x00040000},
+	{0x28, 0x00040000},
+	{0x38, 0x00000000},
+	{0x48, 0x00000000},
+	{0x4c, 0x00000000},
+	{0x54, 0x00000000},
+	{0x58, 0x00000000},
+};
+
+static bool fsl_ssi_readable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case CCSR_SSI_SACCEN:
+	case CCSR_SSI_SACCDIS:
+		return false;
+	default:
+		return true;
+	}
+}
+
+static bool fsl_ssi_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case CCSR_SSI_STX0:
+	case CCSR_SSI_STX1:
+	case CCSR_SSI_SRX0:
+	case CCSR_SSI_SRX1:
+	case CCSR_SSI_SISR:
+	case CCSR_SSI_SFCSR:
+	case CCSR_SSI_SACADD:
+	case CCSR_SSI_SACDAT:
+	case CCSR_SSI_SATAG:
+	case CCSR_SSI_SACCST:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool fsl_ssi_writeable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case CCSR_SSI_SRX0:
+	case CCSR_SSI_SRX1:
+	case CCSR_SSI_SACCST:
+		return false;
+	default:
+		return true;
+	}
+}
+
 static const struct regmap_config fsl_ssi_regconfig = {
 	.max_register = CCSR_SSI_SACCDIS,
 	.reg_bits = 32,
 	.val_bits = 32,
 	.reg_stride = 4,
 	.val_format_endian = REGMAP_ENDIAN_NATIVE,
+	.reg_defaults = fsl_ssi_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(fsl_ssi_reg_defaults),
+	.readable_reg = fsl_ssi_readable_reg,
+	.volatile_reg = fsl_ssi_volatile_reg,
+	.writeable_reg = fsl_ssi_writeable_reg,
+	.cache_type = REGCACHE_RBTREE,
 };
 
 struct fsl_ssi_soc_data {
@@ -176,6 +239,9 @@ struct fsl_ssi_private {
 	unsigned int baudclk_streams;
 	unsigned int bitclk_freq;
 
+	/*regcache for SFCSR*/
+	u32 regcache_sfcsr;
+
 	/* DMA params */
 	struct snd_dmaengine_dai_dma_data dma_params_tx;
 	struct snd_dmaengine_dai_dma_data dma_params_rx;
@@ -1461,10 +1527,46 @@ static int fsl_ssi_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int fsl_ssi_suspend(struct device *dev)
+{
+	struct fsl_ssi_private *ssi_private = dev_get_drvdata(dev);
+	struct regmap *regs = ssi_private->regs;
+
+	regmap_read(regs, CCSR_SSI_SFCSR,
+			&ssi_private->regcache_sfcsr);
+
+	regcache_cache_only(regs, true);
+	regcache_mark_dirty(regs);
+
+	return 0;
+}
+
+static int fsl_ssi_resume(struct device *dev)
+{
+	struct fsl_ssi_private *ssi_private = dev_get_drvdata(dev);
+	struct regmap *regs = ssi_private->regs;
+
+	regcache_cache_only(regs, false);
+
+	regmap_update_bits(regs, CCSR_SSI_SFCSR,
+			CCSR_SSI_SFCSR_RFWM1_MASK | CCSR_SSI_SFCSR_TFWM1_MASK |
+			CCSR_SSI_SFCSR_RFWM0_MASK | CCSR_SSI_SFCSR_TFWM0_MASK,
+			ssi_private->regcache_sfcsr);
+
+	return regcache_sync(regs);
+}
+#endif /* CONFIG_PM_SLEEP */
+
+static const struct dev_pm_ops fsl_ssi_pm = {
+	SET_SYSTEM_SLEEP_PM_OPS(fsl_ssi_suspend, fsl_ssi_resume)
+};
+
 static struct platform_driver fsl_ssi_driver = {
 	.driver = {
 		.name = "fsl-ssi-dai",
 		.of_match_table = fsl_ssi_ids,
+		.pm = &fsl_ssi_pm,
 	},
 	.probe = fsl_ssi_probe,
 	.remove = fsl_ssi_remove,
-- 
1.9.1
