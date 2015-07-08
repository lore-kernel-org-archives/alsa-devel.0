From: Zidan Wang <zidan.wang@freescale.com>
Subject: [PATCH v2 1/4] ASoC: fsl_sai: Add driver suspend and
	resume to support MEGA Fast
Date: Wed, 8 Jul 2015 15:22:27 +0800
Message-ID: <ee6572bca11f44288db1d38e1934c0a7e7fb9ed2.1436339869.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0106.outbound.protection.outlook.com [65.55.169.106])
 by alsa0.perex.cz (Postfix) with ESMTP id 19783262607
 for <alsa-devel@alsa-project.org>; Wed,  8 Jul 2015 09:21:12 +0200 (CEST)
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
modules during system suspend and resume procedure. Thus, SAI needs to save
all the values of registers before the system suspend and restore them after
the system resume.

Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
---
 sound/soc/fsl/fsl_sai.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 5c73bea..62187e4 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -637,6 +637,8 @@ static bool fsl_sai_readable_reg(struct device *dev, unsigned int reg)
 static bool fsl_sai_volatile_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
+	case FSL_SAI_TCSR:
+	case FSL_SAI_RCSR:
 	case FSL_SAI_TFR:
 	case FSL_SAI_RFR:
 	case FSL_SAI_TDR:
@@ -681,6 +683,7 @@ static const struct regmap_config fsl_sai_regmap_config = {
 	.readable_reg = fsl_sai_readable_reg,
 	.volatile_reg = fsl_sai_volatile_reg,
 	.writeable_reg = fsl_sai_writeable_reg,
+	.cache_type = REGCACHE_RBTREE,
 };
 
 static int fsl_sai_probe(struct platform_device *pdev)
@@ -802,10 +805,40 @@ static const struct of_device_id fsl_sai_ids[] = {
 	{ /* sentinel */ }
 };
 
+#if CONFIG_PM_SLEEP
+static int fsl_sai_suspend(struct device *dev)
+{
+	struct fsl_sai *sai = dev_get_drvdata(dev);
+
+	regcache_cache_only(sai->regmap, true);
+	regcache_mark_dirty(sai->regmap);
+
+	return 0;
+}
+
+static int fsl_sai_resume(struct device *dev)
+{
+	struct fsl_sai *sai = dev_get_drvdata(dev);
+
+	regcache_cache_only(sai->regmap, false);
+	regmap_write(sai->regmap, FSL_SAI_TCSR, FSL_SAI_CSR_SR);
+	regmap_write(sai->regmap, FSL_SAI_RCSR, FSL_SAI_CSR_SR);
+	msleep(1);
+	regmap_write(sai->regmap, FSL_SAI_TCSR, 0);
+	regmap_write(sai->regmap, FSL_SAI_RCSR, 0);
+	return regcache_sync(sai->regmap);
+}
+#endif /* CONFIG_PM_SLEEP */
+
+static const struct dev_pm_ops fsl_sai_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(fsl_sai_suspend, fsl_sai_resume)
+};
+
 static struct platform_driver fsl_sai_driver = {
 	.probe = fsl_sai_probe,
 	.driver = {
 		.name = "fsl-sai",
+		.pm = &fsl_sai_pm_ops,
 		.of_match_table = fsl_sai_ids,
 	},
 };
-- 
1.9.1
