From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: img-spdif-out: Add control of sys clock
	to runtime PM" to the asoc tree
Date: Mon, 09 Oct 2017 09:49:40 +0100
Message-ID: <E1e1Tkq-0006KY-7W@debutante>
References: <1506938517-810-4-git-send-email-ed.blake@sondrel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 1A02C267141
 for <alsa-devel@alsa-project.org>; Mon,  9 Oct 2017 10:49:42 +0200 (CEST)
In-Reply-To: <1506938517-810-4-git-send-email-ed.blake@sondrel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ed Blake <ed.blake@sondrel.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: img-spdif-out: Add control of sys clock to runtime PM

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

>From e8639d0c65ba4036b51d63e222080e56384b0573 Mon Sep 17 00:00:00 2001
From: Ed Blake <ed.blake@sondrel.com>
Date: Fri, 6 Oct 2017 15:56:07 +0100
Subject: [PATCH] ASoC: img-spdif-out: Add control of sys clock to runtime PM

Disable sys clock as well as ref clock when runtime suspended.

Signed-off-by: Ed Blake <ed.blake@sondrel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/img/img-spdif-out.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/sound/soc/img/img-spdif-out.c b/sound/soc/img/img-spdif-out.c
index 1808a5542fd1..934ed3df2ebf 100644
--- a/sound/soc/img/img-spdif-out.c
+++ b/sound/soc/img/img-spdif-out.c
@@ -57,6 +57,7 @@ static int img_spdif_out_runtime_suspend(struct device *dev)
 	struct img_spdif_out *spdif = dev_get_drvdata(dev);
 
 	clk_disable_unprepare(spdif->clk_ref);
+	clk_disable_unprepare(spdif->clk_sys);
 
 	return 0;
 }
@@ -66,9 +67,16 @@ static int img_spdif_out_runtime_resume(struct device *dev)
 	struct img_spdif_out *spdif = dev_get_drvdata(dev);
 	int ret;
 
+	ret = clk_prepare_enable(spdif->clk_sys);
+	if (ret) {
+		dev_err(dev, "clk_enable failed: %d\n", ret);
+		return ret;
+	}
+
 	ret = clk_prepare_enable(spdif->clk_ref);
 	if (ret) {
 		dev_err(dev, "clk_enable failed: %d\n", ret);
+		clk_disable_unprepare(spdif->clk_sys);
 		return ret;
 	}
 
@@ -358,21 +366,21 @@ static int img_spdif_out_probe(struct platform_device *pdev)
 		return PTR_ERR(spdif->clk_ref);
 	}
 
-	ret = clk_prepare_enable(spdif->clk_sys);
-	if (ret)
-		return ret;
-
-	img_spdif_out_writel(spdif, IMG_SPDIF_OUT_CTL_FS_MASK,
-				IMG_SPDIF_OUT_CTL);
-
-	img_spdif_out_reset(spdif);
-
 	pm_runtime_enable(&pdev->dev);
 	if (!pm_runtime_enabled(&pdev->dev)) {
 		ret = img_spdif_out_runtime_resume(&pdev->dev);
 		if (ret)
 			goto err_pm_disable;
 	}
+	ret = pm_runtime_get_sync(&pdev->dev);
+	if (ret < 0)
+		goto err_suspend;
+
+	img_spdif_out_writel(spdif, IMG_SPDIF_OUT_CTL_FS_MASK,
+			     IMG_SPDIF_OUT_CTL);
+
+	img_spdif_out_reset(spdif);
+	pm_runtime_put(&pdev->dev);
 
 	spin_lock_init(&spdif->lock);
 
@@ -399,21 +407,16 @@ static int img_spdif_out_probe(struct platform_device *pdev)
 		img_spdif_out_runtime_suspend(&pdev->dev);
 err_pm_disable:
 	pm_runtime_disable(&pdev->dev);
-	clk_disable_unprepare(spdif->clk_sys);
 
 	return ret;
 }
 
 static int img_spdif_out_dev_remove(struct platform_device *pdev)
 {
-	struct img_spdif_out *spdif = platform_get_drvdata(pdev);
-
 	pm_runtime_disable(&pdev->dev);
 	if (!pm_runtime_status_suspended(&pdev->dev))
 		img_spdif_out_runtime_suspend(&pdev->dev);
 
-	clk_disable_unprepare(spdif->clk_sys);
-
 	return 0;
 }
 
-- 
2.14.1
