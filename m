From: Zidan Wang <zidan.wang@freescale.com>
Subject: [PATCH v3 4/4] ASoC: fsl_esai: Add driver suspend and
	resume to support MEGA Fast
Date: Fri, 7 Aug 2015 14:21:08 +0800
Message-ID: <410baabbc6d51a2a5bc2f0496368764214a2abc6.1438928296.git.zidan.wang@freescale.com>
References: <6fa4e6ebf1f34f5d637324c9f62e68b03037568c.1438928296.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bbn0101.outbound.protection.outlook.com [157.56.111.101])
 by alsa0.perex.cz (Postfix) with ESMTP id 8F01E2604C5
 for <alsa-devel@alsa-project.org>; Fri,  7 Aug 2015 08:20:07 +0200 (CEST)
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

For i.MX6 SoloX, there is a mode of the SoC to shutdown all power source of
modules during system suspend and resume procedure. Thus, ESAI needs to save
all the values of registers before the system suspend and restore them after
the system resume.

Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
---
 sound/soc/fsl/fsl_esai.c | 88 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index 8c2ddc1..521e8cb 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -652,6 +652,24 @@ static const struct snd_soc_component_driver fsl_esai_component = {
 	.name		= "fsl-esai",
 };
 
+static const struct reg_default fsl_esai_reg_defaults[] = {
+	{0x8,  0x00000000},
+	{0x10, 0x00000000},
+	{0x18, 0x00000000},
+	{0x98, 0x00000000},
+	{0xd0, 0x00000000},
+	{0xd4, 0x00000000},
+	{0xd8, 0x00000000},
+	{0xdc, 0x00000000},
+	{0xe0, 0x00000000},
+	{0xe4, 0x0000ffff},
+	{0xe8, 0x0000ffff},
+	{0xec, 0x0000ffff},
+	{0xf0, 0x0000ffff},
+	{0xf8, 0x00000000},
+	{0xfc, 0x00000000},
+};
+
 static bool fsl_esai_readable_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
@@ -684,6 +702,31 @@ static bool fsl_esai_readable_reg(struct device *dev, unsigned int reg)
 	}
 }
 
+static bool fsl_esai_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case REG_ESAI_ETDR:
+	case REG_ESAI_ERDR:
+	case REG_ESAI_ESR:
+	case REG_ESAI_TFSR:
+	case REG_ESAI_RFSR:
+	case REG_ESAI_TX0:
+	case REG_ESAI_TX1:
+	case REG_ESAI_TX2:
+	case REG_ESAI_TX3:
+	case REG_ESAI_TX4:
+	case REG_ESAI_TX5:
+	case REG_ESAI_RX0:
+	case REG_ESAI_RX1:
+	case REG_ESAI_RX2:
+	case REG_ESAI_RX3:
+	case REG_ESAI_SAISR:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static bool fsl_esai_writeable_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
@@ -721,8 +764,12 @@ static const struct regmap_config fsl_esai_regmap_config = {
 	.val_bits = 32,
 
 	.max_register = REG_ESAI_PCRC,
+	.reg_defaults = fsl_esai_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(fsl_esai_reg_defaults),
 	.readable_reg = fsl_esai_readable_reg,
+	.volatile_reg = fsl_esai_volatile_reg,
 	.writeable_reg = fsl_esai_writeable_reg,
+	.cache_type = REGCACHE_RBTREE,
 };
 
 static int fsl_esai_probe(struct platform_device *pdev)
@@ -853,10 +900,51 @@ static const struct of_device_id fsl_esai_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, fsl_esai_dt_ids);
 
+#if CONFIG_PM_SLEEP
+static int fsl_esai_suspend(struct device *dev)
+{
+	struct fsl_esai *esai = dev_get_drvdata(dev);
+
+	regcache_cache_only(esai->regmap, true);
+	regcache_mark_dirty(esai->regmap);
+
+	return 0;
+}
+
+static int fsl_esai_resume(struct device *dev)
+{
+	struct fsl_esai *esai = dev_get_drvdata(dev);
+	int ret;
+
+	regcache_cache_only(esai->regmap, false);
+
+	/* FIFO reset for safety */
+	regmap_update_bits(esai->regmap, REG_ESAI_TFCR,
+			   ESAI_xFCR_xFR, ESAI_xFCR_xFR);
+	regmap_update_bits(esai->regmap, REG_ESAI_RFCR,
+			   ESAI_xFCR_xFR, ESAI_xFCR_xFR);
+
+	ret = regcache_sync(esai->regmap);
+	if (ret)
+		return ret;
+
+	/* FIFO reset done */
+	regmap_update_bits(esai->regmap, REG_ESAI_TFCR, ESAI_xFCR_xFR, 0);
+	regmap_update_bits(esai->regmap, REG_ESAI_RFCR, ESAI_xFCR_xFR, 0);
+
+	return 0;
+}
+#endif /* CONFIG_PM_SLEEP */
+
+static const struct dev_pm_ops fsl_esai_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(fsl_esai_suspend, fsl_esai_resume)
+};
+
 static struct platform_driver fsl_esai_driver = {
 	.probe = fsl_esai_probe,
 	.driver = {
 		.name = "fsl-esai-dai",
+		.pm = &fsl_esai_pm_ops,
 		.of_match_table = fsl_esai_dt_ids,
 	},
 };
-- 
1.9.1
