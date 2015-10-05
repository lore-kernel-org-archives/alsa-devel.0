From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl_sai: Add driver suspend and resume
	to support MEGA Fast" to the asoc tree
Date: Mon, 05 Oct 2015 17:44:48 +0100
Message-ID: <E1Zj8sa-0003IV-8n@finisterre>
References: <6fa4e6ebf1f34f5d637324c9f62e68b03037568c.1438928296.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B1B01261519
 for <alsa-devel@alsa-project.org>; Mon,  5 Oct 2015 18:45:05 +0200 (CEST)
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
To: Zidan Wang <zidan.wang@freescale.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl_sai: Add driver suspend and resume to support MEGA Fast

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

>From 1fde5e83a17acbcfcce27f68be46a6da4344efbd Mon Sep 17 00:00:00 2001
From: Zidan Wang <zidan.wang@freescale.com>
Date: Fri, 18 Sep 2015 11:09:10 +0800
Subject: [PATCH] ASoC: fsl_sai: Add driver suspend and resume to support MEGA
 Fast

For i.MX6 SoloX, there is a mode of the SoC to shutdown all power source of
modules during system suspend and resume procedure. Thus, SAI needs to save
all the values of registers before the system suspend and restore them after
the system resume.

Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_sai.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index a18fd92..5c737f1 100644
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
+	.cache_type = REGCACHE_FLAT,
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
2.5.0
