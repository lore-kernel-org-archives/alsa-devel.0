From: Zidan Wang <zidan.wang@freescale.com>
Subject: [PATCH v2 4/4] ASoC: fsl_spdif: Add driver suspend and
	resume to support MEGA Fast
Date: Wed, 8 Jul 2015 15:22:30 +0800
Message-ID: <85fd343e78e9881923557d936548bb215fbf673e.1436339869.git.zidan.wang@freescale.com>
References: <ee6572bca11f44288db1d38e1934c0a7e7fb9ed2.1436339869.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bn0103.outbound.protection.outlook.com [157.56.110.103])
 by alsa0.perex.cz (Postfix) with ESMTP id D8867262607
 for <alsa-devel@alsa-project.org>; Wed,  8 Jul 2015 09:21:31 +0200 (CEST)
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
modules during system suspend and resume procedure. Thus, SPDIF needs to save
all the values of registers before the system suspend and restore them after
the system resume.

The SRPC register should be volatile, LOCK bit is set by the hardware.

Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
---
 sound/soc/fsl/fsl_spdif.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index 8e93221..5c1d3bf 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -108,6 +108,8 @@ struct fsl_spdif_priv {
 	struct clk *sysclk;
 	struct snd_dmaengine_dai_dma_data dma_params_tx;
 	struct snd_dmaengine_dai_dma_data dma_params_rx;
+	/* regcache for SRPC */
+	u32 regcache_srpc;
 };
 
 /* DPLL locked and lock loss interrupt handler */
@@ -300,6 +302,8 @@ static int spdif_softreset(struct fsl_spdif_priv *spdif_priv)
 	struct regmap *regmap = spdif_priv->regmap;
 	u32 val, cycle = 1000;
 
+	regcache_cache_bypass(regmap, true);
+
 	regmap_write(regmap, REG_SPDIF_SCR, SCR_SOFT_RESET);
 
 	/*
@@ -310,6 +314,10 @@ static int spdif_softreset(struct fsl_spdif_priv *spdif_priv)
 		regmap_read(regmap, REG_SPDIF_SCR, &val);
 	} while ((val & SCR_SOFT_RESET) && cycle--);
 
+	regcache_cache_bypass(regmap, false);
+	regcache_mark_dirty(regmap);
+	regcache_sync(regmap);
+
 	if (cycle)
 		return 0;
 	else
@@ -1013,6 +1021,27 @@ static bool fsl_spdif_readable_reg(struct device *dev, unsigned int reg)
 	}
 }
 
+static bool fsl_spdif_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case REG_SPDIF_SRPC:
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
@@ -1039,7 +1068,9 @@ static const struct regmap_config fsl_spdif_regmap_config = {
 
 	.max_register = REG_SPDIF_STC,
 	.readable_reg = fsl_spdif_readable_reg,
+	.volatile_reg = fsl_spdif_volatile_reg,
 	.writeable_reg = fsl_spdif_writeable_reg,
+	.cache_type = REGCACHE_RBTREE,
 };
 
 static u32 fsl_spdif_txclk_caldiv(struct fsl_spdif_priv *spdif_priv,
@@ -1262,6 +1293,38 @@ static int fsl_spdif_probe(struct platform_device *pdev)
 	return ret;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int fsl_spdif_suspend(struct device *dev)
+{
+	struct fsl_spdif_priv *spdif_priv = dev_get_drvdata(dev);
+
+	regmap_read(spdif_priv->regmap, REG_SPDIF_SRPC,
+			&spdif_priv->regcache_srpc);
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
+
+	regmap_update_bits(spdif_priv->regmap, REG_SPDIF_SRPC,
+			SRPC_CLKSRC_SEL_MASK | SRPC_GAINSEL_MASK,
+			spdif_priv->regcache_srpc);
+
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
@@ -1273,6 +1336,7 @@ static struct platform_driver fsl_spdif_driver = {
 	.driver = {
 		.name = "fsl-spdif-dai",
 		.of_match_table = fsl_spdif_dt_ids,
+		.pm = &fsl_spdif_pm,
 	},
 	.probe = fsl_spdif_probe,
 };
-- 
1.9.1
