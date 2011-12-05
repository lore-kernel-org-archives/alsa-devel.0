From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Convert Samsung I2S driver to
	devm_kzalloc()
Date: Mon,  5 Dec 2011 00:07:15 +0000
Message-ID: <1323043635-8420-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 838161039DD
	for <alsa-devel@alsa-project.org>; Mon,  5 Dec 2011 01:07:18 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sangbeom Kim <sbkim73@samsung.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/samsung/i2s.c |   20 ++++++--------------
 1 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 5de500c..ff5d919 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -945,7 +945,7 @@ struct i2s_dai *i2s_alloc_dai(struct platform_device *pdev, bool sec)
 {
 	struct i2s_dai *i2s;
 
-	i2s = kzalloc(sizeof(struct i2s_dai), GFP_KERNEL);
+	i2s = devm_kzalloc(&pdev->dev, sizeof(struct i2s_dai), GFP_KERNEL);
 	if (i2s == NULL)
 		return NULL;
 
@@ -972,10 +972,8 @@ struct i2s_dai *i2s_alloc_dai(struct platform_device *pdev, bool sec)
 		i2s->pdev = platform_device_register_resndata(NULL,
 				pdev->name, pdev->id + SAMSUNG_I2S_SECOFF,
 				NULL, 0, NULL, 0);
-		if (IS_ERR(i2s->pdev)) {
-			kfree(i2s);
+		if (IS_ERR(i2s->pdev))
 			return NULL;
-		}
 	}
 
 	/* Pre-assign snd_soc_dai_set_drvdata */
@@ -1048,7 +1046,7 @@ static __devinit int samsung_i2s_probe(struct platform_device *pdev)
 	if (!pri_dai) {
 		dev_err(&pdev->dev, "Unable to alloc I2S_pri\n");
 		ret = -ENOMEM;
-		goto err1;
+		goto err;
 	}
 
 	pri_dai->dma_playback.dma_addr = regs_base + I2STXD;
@@ -1073,7 +1071,7 @@ static __devinit int samsung_i2s_probe(struct platform_device *pdev)
 		if (!sec_dai) {
 			dev_err(&pdev->dev, "Unable to alloc I2S_sec\n");
 			ret = -ENOMEM;
-			goto err2;
+			goto err;
 		}
 		sec_dai->dma_playback.dma_addr = regs_base + I2STXDS;
 		sec_dai->dma_playback.client =
@@ -1092,17 +1090,13 @@ static __devinit int samsung_i2s_probe(struct platform_device *pdev)
 	if (i2s_pdata->cfg_gpio && i2s_pdata->cfg_gpio(pdev)) {
 		dev_err(&pdev->dev, "Unable to configure gpio\n");
 		ret = -EINVAL;
-		goto err3;
+		goto err;
 	}
 
 	snd_soc_register_dai(&pri_dai->pdev->dev, &pri_dai->i2s_dai_drv);
 
 	return 0;
-err3:
-	kfree(sec_dai);
-err2:
-	kfree(pri_dai);
-err1:
+err:
 	release_mem_region(regs_base, resource_size(res));
 
 	return ret;
@@ -1128,8 +1122,6 @@ static __devexit int samsung_i2s_remove(struct platform_device *pdev)
 	i2s->pri_dai = NULL;
 	i2s->sec_dai = NULL;
 
-	kfree(i2s);
-
 	snd_soc_unregister_dai(&pdev->dev);
 
 	return 0;
-- 
1.7.7.3
