From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 2/3] ASoC: davinci-mcasp: Convert to use
	devm_snd_soc_register_component()
Date: Tue, 22 Apr 2014 14:03:13 +0300
Message-ID: <1398164594-29169-3-git-send-email-peter.ujfalusi@ti.com>
References: <1398164594-29169-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id B372F261AB0
 for <alsa-devel@alsa-project.org>; Tue, 22 Apr 2014 13:03:24 +0200 (CEST)
In-Reply-To: <1398164594-29169-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, daniel@zonque.org, Jyri Sarha <jsarha@ti.com>
List-Id: alsa-devel@alsa-project.org

It allows to remove code from the cleanup paths.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/davinci-mcasp.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 44a03840f76c..14058dc6eaf8 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -1134,7 +1134,7 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 	if (!mcasp->base) {
 		dev_err(&pdev->dev, "ioremap failed\n");
 		ret = -ENOMEM;
-		goto err_release_clk;
+		goto err;
 	}
 
 	mcasp->op_mode = pdata->op_mode;
@@ -1215,11 +1215,12 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 
 	mcasp_reparent_fck(pdev);
 
-	ret = snd_soc_register_component(&pdev->dev, &davinci_mcasp_component,
-					 &davinci_mcasp_dai[pdata->op_mode], 1);
+	ret = devm_snd_soc_register_component(&pdev->dev,
+					&davinci_mcasp_component,
+					&davinci_mcasp_dai[pdata->op_mode], 1);
 
 	if (ret != 0)
-		goto err_release_clk;
+		goto err;
 
 	switch (mcasp->version) {
 	case MCASP_VERSION_1:
@@ -1239,14 +1240,12 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 
 	if (ret) {
 		dev_err(&pdev->dev, "register PCM failed: %d\n", ret);
-		goto err_unregister_component;
+		goto err;
 	}
 
 	return 0;
 
-err_unregister_component:
-	snd_soc_unregister_component(&pdev->dev);
-err_release_clk:
+err:
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	return ret;
@@ -1254,8 +1253,6 @@ err_release_clk:
 
 static int davinci_mcasp_remove(struct platform_device *pdev)
 {
-	snd_soc_unregister_component(&pdev->dev);
-
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
-- 
1.9.2
