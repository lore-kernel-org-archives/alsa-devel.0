From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: img-spdif-out: Rename suspend / resume
	funcs" to the asoc tree
Date: Wed, 04 Oct 2017 12:28:36 +0100
Message-ID: <E1dzhqu-0004Nw-4P@debutante>
References: <1506938517-810-2-git-send-email-ed.blake@sondrel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 42D2E267441
 for <alsa-devel@alsa-project.org>; Wed,  4 Oct 2017 13:28:38 +0200 (CEST)
In-Reply-To: <1506938517-810-2-git-send-email-ed.blake@sondrel.com>
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

   ASoC: img-spdif-out: Rename suspend / resume funcs

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

>From 2ab18dfe87596e207f17ff0567660cd7356c715a Mon Sep 17 00:00:00 2001
From: Ed Blake <ed.blake@sondrel.com>
Date: Mon, 2 Oct 2017 11:01:55 +0100
Subject: [PATCH] ASoC: img-spdif-out: Rename suspend / resume funcs

Rename suspend and resume functions to runtime_suspend and
runtime_resume, which is what they actually are. This will avoid
confusion when adding suspend and resume functions in a subsequent
patch.

Signed-off-by: Ed Blake <ed.blake@sondrel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/img/img-spdif-out.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/img/img-spdif-out.c b/sound/soc/img/img-spdif-out.c
index 383655da2e60..416aa5786b93 100644
--- a/sound/soc/img/img-spdif-out.c
+++ b/sound/soc/img/img-spdif-out.c
@@ -49,7 +49,7 @@ struct img_spdif_out {
 	struct reset_control *rst;
 };
 
-static int img_spdif_out_suspend(struct device *dev)
+static int img_spdif_out_runtime_suspend(struct device *dev)
 {
 	struct img_spdif_out *spdif = dev_get_drvdata(dev);
 
@@ -58,7 +58,7 @@ static int img_spdif_out_suspend(struct device *dev)
 	return 0;
 }
 
-static int img_spdif_out_resume(struct device *dev)
+static int img_spdif_out_runtime_resume(struct device *dev)
 {
 	struct img_spdif_out *spdif = dev_get_drvdata(dev);
 	int ret;
@@ -366,7 +366,7 @@ static int img_spdif_out_probe(struct platform_device *pdev)
 
 	pm_runtime_enable(&pdev->dev);
 	if (!pm_runtime_enabled(&pdev->dev)) {
-		ret = img_spdif_out_resume(&pdev->dev);
+		ret = img_spdif_out_runtime_resume(&pdev->dev);
 		if (ret)
 			goto err_pm_disable;
 	}
@@ -393,7 +393,7 @@ static int img_spdif_out_probe(struct platform_device *pdev)
 
 err_suspend:
 	if (!pm_runtime_status_suspended(&pdev->dev))
-		img_spdif_out_suspend(&pdev->dev);
+		img_spdif_out_runtime_suspend(&pdev->dev);
 err_pm_disable:
 	pm_runtime_disable(&pdev->dev);
 	clk_disable_unprepare(spdif->clk_sys);
@@ -407,7 +407,7 @@ static int img_spdif_out_dev_remove(struct platform_device *pdev)
 
 	pm_runtime_disable(&pdev->dev);
 	if (!pm_runtime_status_suspended(&pdev->dev))
-		img_spdif_out_suspend(&pdev->dev);
+		img_spdif_out_runtime_suspend(&pdev->dev);
 
 	clk_disable_unprepare(spdif->clk_sys);
 
@@ -421,8 +421,8 @@ static const struct of_device_id img_spdif_out_of_match[] = {
 MODULE_DEVICE_TABLE(of, img_spdif_out_of_match);
 
 static const struct dev_pm_ops img_spdif_out_pm_ops = {
-	SET_RUNTIME_PM_OPS(img_spdif_out_suspend,
-			   img_spdif_out_resume, NULL)
+	SET_RUNTIME_PM_OPS(img_spdif_out_runtime_suspend,
+			   img_spdif_out_runtime_resume, NULL)
 };
 
 static struct platform_driver img_spdif_out_driver = {
-- 
2.14.1
