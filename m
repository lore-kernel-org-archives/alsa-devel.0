From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl_audmix: remove "model" attribute"
	to the asoc tree
Date: Wed, 10 Apr 2019 13:26:39 +0100 (BST)
Message-ID: <20190410122639.DBD381128ED2@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0DC04F896DD
 for <alsa-devel@alsa-project.org>; Wed, 10 Apr 2019 14:26:41 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Viorel Suman <viorel.suman@nxp.com>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl_audmix: remove "model" attribute

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 830b857f7971b8f49471fee4e715ccac66400711 Mon Sep 17 00:00:00 2001
From: Viorel Suman <viorel.suman@nxp.com>
Date: Wed, 10 Apr 2019 11:06:36 +0000
Subject: [PATCH] ASoC: fsl_audmix: remove "model" attribute

Use "of_device_id.data" to specify the machine driver
instead of "model" DTS attribute.

Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_audmix.c | 43 ++++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/sound/soc/fsl/fsl_audmix.c b/sound/soc/fsl/fsl_audmix.c
index dabde0342c95..dc802d5c4ccd 100644
--- a/sound/soc/fsl/fsl_audmix.c
+++ b/sound/soc/fsl/fsl_audmix.c
@@ -445,13 +445,29 @@ static const struct regmap_config fsl_audmix_regmap_config = {
 	.cache_type = REGCACHE_FLAT,
 };
 
+static const struct of_device_id fsl_audmix_ids[] = {
+	{
+		.compatible = "fsl,imx8qm-audmix",
+		.data = "imx-audmix",
+	},
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, fsl_audmix_ids);
+
 static int fsl_audmix_probe(struct platform_device *pdev)
 {
 	struct fsl_audmix *priv;
 	struct resource *res;
+	const char *mdrv;
+	const struct of_device_id *of_id;
 	void __iomem *regs;
 	int ret;
-	const char *sprop;
+
+	of_id = of_match_device(fsl_audmix_ids, &pdev->dev);
+	if (!of_id || !of_id->data)
+		return -EINVAL;
+
+	mdrv = of_id->data;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -487,19 +503,12 @@ static int fsl_audmix_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	sprop = of_get_property(pdev->dev.of_node, "model", NULL);
-	if (sprop) {
-		priv->pdev = platform_device_register_data(&pdev->dev, sprop, 0,
-							   NULL, 0);
-		if (IS_ERR(priv->pdev)) {
-			ret = PTR_ERR(priv->pdev);
-			dev_err(&pdev->dev,
-				"failed to register platform %s: %d\n", sprop,
-				 ret);
-		}
-	} else {
-		dev_err(&pdev->dev, "[model] attribute missing.\n");
-		ret = -EINVAL;
+	priv->pdev = platform_device_register_data(&pdev->dev, mdrv, 0, NULL,
+						   0);
+	if (IS_ERR(priv->pdev)) {
+		ret = PTR_ERR(priv->pdev);
+		dev_err(&pdev->dev, "failed to register platform %s: %d\n",
+			mdrv, ret);
 	}
 
 	return ret;
@@ -553,12 +562,6 @@ static const struct dev_pm_ops fsl_audmix_pm = {
 				pm_runtime_force_resume)
 };
 
-static const struct of_device_id fsl_audmix_ids[] = {
-	{ .compatible = "fsl,imx8qm-audmix", },
-	{ /* sentinel */ }
-};
-MODULE_DEVICE_TABLE(of, fsl_audmix_ids);
-
 static struct platform_driver fsl_audmix_driver = {
 	.probe = fsl_audmix_probe,
 	.remove = fsl_audmix_remove,
-- 
2.20.1
