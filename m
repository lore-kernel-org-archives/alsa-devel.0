From: Ed Blake <ed.blake@sondrel.com>
Subject: [PATCH 1/3] ASoC: img-i2s-out: Rename suspend / resume
	funcs
Date: Mon,  2 Oct 2017 10:59:45 +0100
Message-ID: <1506938387-627-2-git-send-email-ed.blake@sondrel.com>
References: <1506938387-627-1-git-send-email-ed.blake@sondrel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-eopbgr10079.outbound.protection.outlook.com [40.107.1.79])
 by alsa0.perex.cz (Postfix) with ESMTP id B8B78266DF4
 for <alsa-devel@alsa-project.org>; Mon,  2 Oct 2017 12:00:00 +0200 (CEST)
In-Reply-To: <1506938387-627-1-git-send-email-ed.blake@sondrel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, Ed Blake <ed.blake@sondrel.com>
List-Id: alsa-devel@alsa-project.org

Rename suspend and resume functions to runtime_suspend and
runtime_resume, which is what they actually are. This will avoid
confusion when adding suspend and resume functions in a subsequent
patch.

Signed-off-by: Ed Blake <ed.blake@sondrel.com>
---
 sound/soc/img/img-i2s-out.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/img/img-i2s-out.c b/sound/soc/img/img-i2s-out.c
index 78b7f6c..adc6902 100644
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
 
@@ -545,8 +545,8 @@ static int img_i2s_out_dev_remove(struct platform_device *pdev)
 MODULE_DEVICE_TABLE(of, img_i2s_out_of_match);
 
 static const struct dev_pm_ops img_i2s_out_pm_ops = {
-	SET_RUNTIME_PM_OPS(img_i2s_out_suspend,
-			   img_i2s_out_resume, NULL)
+	SET_RUNTIME_PM_OPS(img_i2s_out_runtime_suspend,
+			   img_i2s_out_runtime_resume, NULL)
 };
 
 static struct platform_driver img_i2s_out_driver = {
-- 
1.9.1
