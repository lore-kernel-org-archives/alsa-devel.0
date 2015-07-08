From: Zidan Wang <zidan.wang@freescale.com>
Subject: [PATCH v2 2/4] ASoC: fsl_esai: Add driver suspend and
	resume to support MEGA Fast
Date: Wed, 8 Jul 2015 15:22:28 +0800
Message-ID: <60254232400b21246e63e31f88645397d4f6834b.1436339869.git.zidan.wang@freescale.com>
References: <ee6572bca11f44288db1d38e1934c0a7e7fb9ed2.1436339869.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0121.outbound.protection.outlook.com [65.55.169.121])
 by alsa0.perex.cz (Postfix) with ESMTP id 45601265189
 for <alsa-devel@alsa-project.org>; Wed,  8 Jul 2015 09:21:26 +0200 (CEST)
In-Reply-To: <ee6572bca11f44288db1d38e1934c0a7e7fb9ed2.1436339869.git.zidan.wang@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: timur@tabi.org
Cc: alsa-devel@alsa-project.org, Zidan Wang <zidan.wang@freescale.com>, tiwai@suse.de, nicoleotsuka@gmail.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

For i.MX6 SoloX, there is a mode of the SoC to shutdown all power source of
modules during system suspend and resume procedure. Thus, ESAI needs to save
all the values of registers before the system suspend and restore them after
the system resume.

Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
---
 sound/soc/fsl/fsl_esai.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index 5c75971..b749a29 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -684,6 +684,32 @@ static bool fsl_esai_readable_reg(struct device *dev, unsigned int reg)
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
+
+}
+
 static bool fsl_esai_writeable_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
@@ -722,7 +748,9 @@ static const struct regmap_config fsl_esai_regmap_config = {
 
 	.max_register = REG_ESAI_PCRC,
 	.readable_reg = fsl_esai_readable_reg,
+	.volatile_reg = fsl_esai_volatile_reg,
 	.writeable_reg = fsl_esai_writeable_reg,
+	.cache_type = REGCACHE_RBTREE,
 };
 
 static int fsl_esai_probe(struct platform_device *pdev)
@@ -853,10 +881,51 @@ static const struct of_device_id fsl_esai_dt_ids[] = {
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
