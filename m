From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl_sai: Add support for runtime pm" to
	the asoc tree
Date: Thu, 25 Apr 2019 20:26:26 +0100 (BST)
Message-ID: <20190425192626.9A677441D3B@finisterre.ee.mobilebroadband>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 90B97F89723
 for <alsa-devel@alsa-project.org>; Thu, 25 Apr 2019 21:26:32 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Shengjiu Wang <shengjiu.wang@nxp.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl_sai: Add support for runtime pm

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

>From 812ad463e0894d78e93ab8017e0edbe69038c55c Mon Sep 17 00:00:00 2001
From: Daniel Baluta <daniel.baluta@nxp.com>
Date: Sun, 21 Apr 2019 19:39:09 +0000
Subject: [PATCH] ASoC: fsl_sai: Add support for runtime pm

Basically the same actions as for system PM, so make use
of pm_runtime_force_suspend/pm_runtime_force_resume.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_sai.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 7549b74e464e..26c27dc0781f 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -9,6 +9,7 @@
 #include <linux/dmaengine.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
 #include <linux/time.h>
@@ -901,6 +902,8 @@ static int fsl_sai_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, sai);
 
+	pm_runtime_enable(&pdev->dev);
+
 	ret = devm_snd_soc_register_component(&pdev->dev, &fsl_component,
 			&fsl_sai_dai, 1);
 	if (ret)
@@ -912,6 +915,11 @@ static int fsl_sai_probe(struct platform_device *pdev)
 		return devm_snd_dmaengine_pcm_register(&pdev->dev, NULL, 0);
 }
 
+static int fsl_sai_remove(struct platform_device *pdev)
+{
+	pm_runtime_disable(&pdev->dev);
+}
+
 static const struct of_device_id fsl_sai_ids[] = {
 	{ .compatible = "fsl,vf610-sai", },
 	{ .compatible = "fsl,imx6sx-sai", },
@@ -920,8 +928,8 @@ static const struct of_device_id fsl_sai_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, fsl_sai_ids);
 
-#ifdef CONFIG_PM_SLEEP
-static int fsl_sai_suspend(struct device *dev)
+#ifdef CONFIG_PM
+static int fsl_sai_runtime_suspend(struct device *dev)
 {
 	struct fsl_sai *sai = dev_get_drvdata(dev);
 
@@ -931,7 +939,7 @@ static int fsl_sai_suspend(struct device *dev)
 	return 0;
 }
 
-static int fsl_sai_resume(struct device *dev)
+static int fsl_sai_runtime_resume(struct device *dev)
 {
 	struct fsl_sai *sai = dev_get_drvdata(dev);
 
@@ -943,14 +951,18 @@ static int fsl_sai_resume(struct device *dev)
 	regmap_write(sai->regmap, FSL_SAI_RCSR, 0);
 	return regcache_sync(sai->regmap);
 }
-#endif /* CONFIG_PM_SLEEP */
+#endif /* CONFIG_PM */
 
 static const struct dev_pm_ops fsl_sai_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(fsl_sai_suspend, fsl_sai_resume)
+	SET_RUNTIME_PM_OPS(fsl_sai_runtime_suspend,
+			   fsl_sai_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
 };
 
 static struct platform_driver fsl_sai_driver = {
 	.probe = fsl_sai_probe,
+	.remove = fsl_sai_remove,
 	.driver = {
 		.name = "fsl-sai",
 		.pm = &fsl_sai_pm_ops,
-- 
2.20.1
