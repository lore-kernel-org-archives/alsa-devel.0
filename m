From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: img-i2s-out: Rename suspend / resume
	funcs" to the asoc tree
Date: Wed, 04 Oct 2017 12:28:42 +0100
Message-ID: <E1dzhr0-0004Pb-9H@debutante>
References: <1506938387-627-2-git-send-email-ed.blake@sondrel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 31893267472
 for <alsa-devel@alsa-project.org>; Wed,  4 Oct 2017 13:28:44 +0200 (CEST)
In-Reply-To: <1506938387-627-2-git-send-email-ed.blake@sondrel.com>
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

   ASoC: img-i2s-out: Rename suspend / resume funcs

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

>From 6f9dfab7fc5fdd51ed67da370fc83f3b7dbf08da Mon Sep 17 00:00:00 2001
From: Ed Blake <ed.blake@sondrel.com>
Date: Mon, 2 Oct 2017 10:59:45 +0100
Subject: [PATCH] ASoC: img-i2s-out: Rename suspend / resume funcs

Rename suspend and resume functions to runtime_suspend and
runtime_resume, which is what they actually are. This will avoid
confusion when adding suspend and resume functions in a subsequent
patch.

Signed-off-by: Ed Blake <ed.blake@sondrel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/img/img-i2s-out.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/img/img-i2s-out.c b/sound/soc/img/img-i2s-out.c
index 78b7f6cd675b..adc6902fcbd4 100644
--- a/sound/soc/img/img-i2s-out.c
+++ b/sound/soc/img/img-i2s-out.c
@@ -65,7 +65,7 @@ struct img_i2s_out {
 	struct snd_soc_dai_driver dai_driver;
 };
 
-static int img_i2s_out_suspend(struct device *dev)
+static int img_i2s_out_runtime_suspend(struct device *dev)
 {
 	struct img_i2s_out *i2s = dev_get_drvdata(dev);
 
@@ -75,7 +75,7 @@ static int img_i2s_out_suspend(struct device *dev)
 	return 0;
 }
 
-static int img_i2s_out_resume(struct device *dev)
+static int img_i2s_out_runtime_resume(struct device *dev)
 {
 	struct img_i2s_out *i2s = dev_get_drvdata(dev);
 	int ret;
@@ -486,7 +486,7 @@ static int img_i2s_out_probe(struct platform_device *pdev)
 
 	pm_runtime_enable(&pdev->dev);
 	if (!pm_runtime_enabled(&pdev->dev)) {
-		ret = img_i2s_out_resume(&pdev->dev);
+		ret = img_i2s_out_runtime_resume(&pdev->dev);
 		if (ret)
 			goto err_pm_disable;
 	}
@@ -517,7 +517,7 @@ static int img_i2s_out_probe(struct platform_device *pdev)
 
 err_suspend:
 	if (!pm_runtime_status_suspended(&pdev->dev))
-		img_i2s_out_suspend(&pdev->dev);
+		img_i2s_out_runtime_suspend(&pdev->dev);
 err_pm_disable:
 	pm_runtime_disable(&pdev->dev);
 	clk_disable_unprepare(i2s->clk_sys);
@@ -531,7 +531,7 @@ static int img_i2s_out_dev_remove(struct platform_device *pdev)
 
 	pm_runtime_disable(&pdev->dev);
 	if (!pm_runtime_status_suspended(&pdev->dev))
-		img_i2s_out_suspend(&pdev->dev);
+		img_i2s_out_runtime_suspend(&pdev->dev);
 
 	clk_disable_unprepare(i2s->clk_sys);
 
@@ -545,8 +545,8 @@ static const struct of_device_id img_i2s_out_of_match[] = {
 MODULE_DEVICE_TABLE(of, img_i2s_out_of_match);
 
 static const struct dev_pm_ops img_i2s_out_pm_ops = {
-	SET_RUNTIME_PM_OPS(img_i2s_out_suspend,
-			   img_i2s_out_resume, NULL)
+	SET_RUNTIME_PM_OPS(img_i2s_out_runtime_suspend,
+			   img_i2s_out_runtime_resume, NULL)
 };
 
 static struct platform_driver img_i2s_out_driver = {
-- 
2.14.1
