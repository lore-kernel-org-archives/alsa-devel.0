From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl_spdif: Add driver suspend and
	resume to support MEGA Fast" to the asoc tree
Date: Mon, 05 Oct 2015 17:44:45 +0100
Message-ID: <E1Zj8sX-0003I2-TN@finisterre>
References: <b8c48d059848c030a47b44407964eb473ea2c240.1438928296.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DB23C261510
 for <alsa-devel@alsa-project.org>; Mon,  5 Oct 2015 18:45:04 +0200 (CEST)
In-Reply-To: <b8c48d059848c030a47b44407964eb473ea2c240.1438928296.git.zidan.wang@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Zidan Wang <zidan.wang@freescale.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl_spdif: Add driver suspend and resume to support MEGA Fast

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

>From f9f4fa61aab9417e40898cf6706fffa94005dc44 Mon Sep 17 00:00:00 2001
From: Zidan Wang <zidan.wang@freescale.com>
Date: Fri, 18 Sep 2015 11:09:11 +0800
Subject: [PATCH] ASoC: fsl_spdif: Add driver suspend and resume to support
 MEGA Fast

For i.MX6 SoloX, there is a mode of the SoC to shutdown all power source of
modules during system suspend and resume procedure. Thus, SPDIF needs to save
all the values of registers before the system suspend and restore them after
the system resume.

The SRPC register should be volatile, LOCK bit is set by the hardware.

Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_spdif.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index ab729f2..3d59bb6 100644
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
@@ -997,6 +1005,14 @@ static const struct snd_soc_component_driver fsl_spdif_component = {
 };
 
 /* FSL SPDIF REGMAP */
+static const struct reg_default fsl_spdif_reg_defaults[] = {
+	{0x0,  0x00000400},
+	{0x4,  0x00000000},
+	{0xc,  0x00000000},
+	{0x34, 0x00000000},
+	{0x38, 0x00000000},
+	{0x50, 0x00020f00},
+};
 
 static bool fsl_spdif_readable_reg(struct device *dev, unsigned int reg)
 {
@@ -1022,6 +1038,26 @@ static bool fsl_spdif_readable_reg(struct device *dev, unsigned int reg)
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
+}
+
 static bool fsl_spdif_writeable_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
@@ -1047,8 +1083,12 @@ static const struct regmap_config fsl_spdif_regmap_config = {
 	.val_bits = 32,
 
 	.max_register = REG_SPDIF_STC,
+	.reg_defaults = fsl_spdif_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(fsl_spdif_reg_defaults),
 	.readable_reg = fsl_spdif_readable_reg,
+	.volatile_reg = fsl_spdif_volatile_reg,
 	.writeable_reg = fsl_spdif_writeable_reg,
+	.cache_type = REGCACHE_RBTREE,
 };
 
 static u32 fsl_spdif_txclk_caldiv(struct fsl_spdif_priv *spdif_priv,
@@ -1271,6 +1311,38 @@ static int fsl_spdif_probe(struct platform_device *pdev)
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
@@ -1282,6 +1354,7 @@ static struct platform_driver fsl_spdif_driver = {
 	.driver = {
 		.name = "fsl-spdif-dai",
 		.of_match_table = fsl_spdif_dt_ids,
+		.pm = &fsl_spdif_pm,
 	},
 	.probe = fsl_spdif_probe,
 };
-- 
2.5.0
