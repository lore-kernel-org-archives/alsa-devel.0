From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 2/2] ASoC: samsung-i2s: Use
	devm_snd_soc_register_component()
Date: Wed,  4 Sep 2013 20:39:04 +0100
Message-ID: <1378323544-5932-2-git-send-email-broonie@kernel.org>
References: <1378323544-5932-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 45E2826556C
 for <alsa-devel@alsa-project.org>; Wed,  4 Sep 2013 21:39:14 +0200 (CEST)
In-Reply-To: <1378323544-5932-1-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/samsung/i2s.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index b302f3b..821c28c 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -1143,9 +1143,9 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev, "Unable to get drvdata\n");
 			return -EFAULT;
 		}
-		snd_soc_register_component(&sec_dai->pdev->dev,
-					   &samsung_i2s_component,
-					   &sec_dai->i2s_dai_drv, 1);
+		devm_snd_soc_register_component(&sec_dai->pdev->dev,
+						&samsung_i2s_component,
+						&sec_dai->i2s_dai_drv, 1);
 		samsung_asoc_dma_platform_register(&pdev->dev);
 		return 0;
 	}
@@ -1258,8 +1258,9 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	snd_soc_register_component(&pri_dai->pdev->dev, &samsung_i2s_component,
-				   &pri_dai->i2s_dai_drv, 1);
+	devm_snd_soc_register_component(&pri_dai->pdev->dev,
+					&samsung_i2s_component,
+					&pri_dai->i2s_dai_drv, 1);
 
 	pm_runtime_enable(&pdev->dev);
 
@@ -1294,7 +1295,6 @@ static int samsung_i2s_remove(struct platform_device *pdev)
 	i2s->sec_dai = NULL;
 
 	samsung_asoc_dma_platform_unregister(&pdev->dev);
-	snd_soc_unregister_component(&pdev->dev);
 
 	return 0;
 }
-- 
1.8.4.rc3
