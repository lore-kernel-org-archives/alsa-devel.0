From: Zidan Wang <zidan.wang@freescale.com>
Subject: [alsa-devel][PATCH 2/3] ASoC: fsl_spdif: Add driver suspend and resume to support MEGA Fast
Date: Mon, 6 Jul 2015 17:50:35 +0800
Message-ID: <dfaae3aacf6cf985adfd4394429cc90518c00dc0.1436176158.git.zidan.wang@freescale.com>
References: <d626b0b7ad28a96fea0a60e7db29b894fb948166.1436176158.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d626b0b7ad28a96fea0a60e7db29b894fb948166.1436176158.git.zidan.wang@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: timur@tabi.org
Cc: nicoleotsuka@gmail.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.de, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Zidan Wang <zidan.wang@freescale.com>
List-Id: alsa-devel@alsa-project.org

For i.MX6 SoloX, there is a mode of the SoC to shutdown all power source of
modules during system suspend and resume procedure. Thus, SAI needs to save
all the values of registers before the system suspend and restore them after
the system resume.

Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
---
 sound/soc/fsl/fsl_spdif.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index 8e93221..caf20d1 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -300,6 +300,8 @@ static int spdif_softreset(struct fsl_spdif_priv *spdif_priv)
 	struct regmap *regmap = spdif_priv->regmap;
 	u32 val, cycle = 1000;
 
+	regcache_cache_bypass(regmap, true);
+
 	regmap_write(regmap, REG_SPDIF_SCR, SCR_SOFT_RESET);
 
 	/*
@@ -310,6 +312,10 @@ static int spdif_softreset(struct fsl_spdif_priv *spdif_priv)
 		regmap_read(regmap, REG_SPDIF_SCR, &val);
 	} while ((val & SCR_SOFT_RESET) && cycle--);
 
+	regcache_cache_bypass(regmap, false);
+	regcache_mark_dirty(regmap);
+	regcache_sync(regmap);
+
 	if (cycle)
 		return 0;
 	else
@@ -1013,6 +1019,26 @@ static bool fsl_spdif_readable_reg(struct device *dev, unsigned int reg)
 	}
 }
 
+static bool fsl_spdif_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case REG_SPDIF_SIS:
+	case REG_SPDIF_SRL:
+	case REG_SPDIF_SRR:
+	case REG_SPDIF_SRCSH:
+	case REG_SPDIF_SRCSL:
+	case REG_SPDIF_SRU:
+	case REG_SPDIF_SRQ:
+	case REG_SPDIF_STL:
+	case REG_SPDIF_STR:
+	case REG_SPDIF_SRFM:
+		return true;
+	default:
+		return false;
+	}
+
+}
+
 static bool fsl_spdif_writeable_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
@@ -1039,7 +1065,9 @@ static const struct regmap_config fsl_spdif_regmap_config = {
 
 	.max_register = REG_SPDIF_STC,
 	.readable_reg = fsl_spdif_readable_reg,
+	.volatile_reg = fsl_spdif_volatile_reg,
 	.writeable_reg = fsl_spdif_writeable_reg,
+	.cache_type = REGCACHE_RBTREE,
 };
 
 static u32 fsl_spdif_txclk_caldiv(struct fsl_spdif_priv *spdif_priv,
@@ -1262,6 +1290,30 @@ static int fsl_spdif_probe(struct platform_device *pdev)
 	return ret;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int fsl_spdif_suspend(struct device *dev)
+{
+	struct fsl_spdif_priv *spdif_priv = dev_get_drvdata(dev);
+
+	regcache_cache_only(spdif_priv->regmap, true);
+	regcache_mark_dirty(spdif_priv->regmap);
+
+	return 0;
+}
+
+static int fsl_spdif_resume(struct device *dev)
+{
+	struct fsl_spdif_priv *spdif_priv = dev_get_drvdata(dev);
+
+	regcache_cache_only(spdif_priv->regmap, false);
+	return regcache_sync(spdif_priv->regmap);
+}
+#endif /* CONFIG_PM_SLEEP */
+
+static const struct dev_pm_ops fsl_spdif_pm = {
+	SET_SYSTEM_SLEEP_PM_OPS(fsl_spdif_suspend, fsl_spdif_resume)
+};
+
 static const struct of_device_id fsl_spdif_dt_ids[] = {
 	{ .compatible = "fsl,imx35-spdif", },
 	{ .compatible = "fsl,vf610-spdif", },
@@ -1273,6 +1325,7 @@ static struct platform_driver fsl_spdif_driver = {
 	.driver = {
 		.name = "fsl-spdif-dai",
 		.of_match_table = fsl_spdif_dt_ids,
+		.pm = &fsl_spdif_pm,
 	},
 	.probe = fsl_spdif_probe,
 };
-- 
1.9.1
