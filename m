From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ux500: adjust devm usage" to the asoc
	tree
Date: Mon, 20 Jul 2015 18:52:08 +0100
Message-ID: <E1ZHFEW-0002qp-4g@debutante>
References: <1437333136-20908-1-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1FD582614D0
 for <alsa-devel@alsa-project.org>; Mon, 20 Jul 2015 19:52:16 +0200 (CEST)
In-Reply-To: <1437333136-20908-1-git-send-email-Julia.Lawall@lip6.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Julia Lawall <Julia.Lawall@lip6.fr>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: ux500: adjust devm usage

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

>From 4313489c25622b05adac55dbb9590fb5674c3f45 Mon Sep 17 00:00:00 2001
From: Julia Lawall <Julia.Lawall@lip6.fr>
Date: Sun, 19 Jul 2015 21:12:16 +0200
Subject: [PATCH] ASoC: ux500: adjust devm usage

The explicit call to devm_regulator_put in the probe and remove functions
does not seem to be necessary.  In particular, the functions
prcmu_qos_remove_requirement and ux500_msp_i2s_cleanup_msp in the remove
function seem to do nothing that can interfere with devm_regulator_put,
making it safe to allow devm_regulator_put to occur after the end of the
remove function.

Convert the calls to clk_get to devm_clk_get, and remove the corresponding
calls to clk_put in the probe and remove functions.

Replace various gotos by direct returns, and drop unneeded labels.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/ux500/ux500_msp_dai.c | 29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

diff --git a/sound/soc/ux500/ux500_msp_dai.c b/sound/soc/ux500/ux500_msp_dai.c
index 978f2d7316b0..f5df08ded770 100644
--- a/sound/soc/ux500/ux500_msp_dai.c
+++ b/sound/soc/ux500/ux500_msp_dai.c
@@ -773,20 +773,22 @@ static int ux500_msp_drv_probe(struct platform_device *pdev)
 	}
 	prcmu_qos_add_requirement(PRCMU_QOS_APE_OPP, (char *)pdev->name, 50);
 
-	drvdata->pclk = clk_get(&pdev->dev, "apb_pclk");
+	drvdata->pclk = devm_clk_get(&pdev->dev, "apb_pclk");
 	if (IS_ERR(drvdata->pclk)) {
 		ret = (int)PTR_ERR(drvdata->pclk);
-		dev_err(&pdev->dev, "%s: ERROR: clk_get of pclk failed (%d)!\n",
+		dev_err(&pdev->dev,
+			"%s: ERROR: devm_clk_get of pclk failed (%d)!\n",
 			__func__, ret);
-		goto err_pclk;
+		return ret;
 	}
 
-	drvdata->clk = clk_get(&pdev->dev, NULL);
+	drvdata->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(drvdata->clk)) {
 		ret = (int)PTR_ERR(drvdata->clk);
-		dev_err(&pdev->dev, "%s: ERROR: clk_get failed (%d)!\n",
+		dev_err(&pdev->dev,
+			"%s: ERROR: devm_clk_get failed (%d)!\n",
 			__func__, ret);
-		goto err_clk;
+		return ret;
 	}
 
 	ret = ux500_msp_i2s_init_msp(pdev, &drvdata->msp,
@@ -795,7 +797,7 @@ static int ux500_msp_drv_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev,
 			"%s: ERROR: Failed to init MSP-struct (%d)!",
 			__func__, ret);
-		goto err_init_msp;
+		return ret;
 	}
 	dev_set_drvdata(&pdev->dev, drvdata);
 
@@ -804,7 +806,7 @@ static int ux500_msp_drv_probe(struct platform_device *pdev)
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Error: %s: Failed to register MSP%d!\n",
 			__func__, drvdata->msp->id);
-		goto err_init_msp;
+		return ret;
 	}
 
 	ret = ux500_pcm_register_platform(pdev);
@@ -819,13 +821,6 @@ static int ux500_msp_drv_probe(struct platform_device *pdev)
 
 err_reg_plat:
 	snd_soc_unregister_component(&pdev->dev);
-err_init_msp:
-	clk_put(drvdata->clk);
-err_clk:
-	clk_put(drvdata->pclk);
-err_pclk:
-	devm_regulator_put(drvdata->reg_vape);
-
 	return ret;
 }
 
@@ -837,12 +832,8 @@ static int ux500_msp_drv_remove(struct platform_device *pdev)
 
 	snd_soc_unregister_component(&pdev->dev);
 
-	devm_regulator_put(drvdata->reg_vape);
 	prcmu_qos_remove_requirement(PRCMU_QOS_APE_OPP, "ux500_msp_i2s");
 
-	clk_put(drvdata->clk);
-	clk_put(drvdata->pclk);
-
 	ux500_msp_i2s_cleanup_msp(pdev, drvdata->msp);
 
 	return 0;
-- 
2.1.4
