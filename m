From: Ryder Lee <ryder.lee-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 01/12] ASoC: mediatek: fix error handling in mt2701_afe_pcm_dev_probe()
Date: Tue, 2 Jan 2018 19:47:18 +0800
Message-ID: <6081b70610c31f2c92ae1b83decb887a3f690f80.1514881870.git.ryder.lee@mediatek.com>
References: <cover.1514881870.git.ryder.lee@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1514881870.git.ryder.lee-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Garlic Tseng <garlic.tseng-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Ryder Lee <ryder.lee-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Fix unbalanced error handling path which will get incorrect counts
if probe failed. The .remove() should be adjusted accordingly.

Signed-off-by: Ryder Lee <ryder.lee-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Tested-by: Garlic Tseng <garlic.tseng-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
---
 sound/soc/mediatek/mt2701/mt2701-afe-pcm.c | 31 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
index 8fda182..a7362d1 100644
--- a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
+++ b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
@@ -1590,12 +1590,16 @@ static int mt2701_afe_pcm_dev_probe(struct platform_device *pdev)
 	}
 
 	platform_set_drvdata(pdev, afe);
-	pm_runtime_enable(&pdev->dev);
-	if (!pm_runtime_enabled(&pdev->dev))
-		goto err_pm_disable;
-	pm_runtime_get_sync(&pdev->dev);
 
-	ret = snd_soc_register_platform(&pdev->dev, &mtk_afe_pcm_platform);
+	pm_runtime_enable(dev);
+	if (!pm_runtime_enabled(dev)) {
+		ret = mt2701_afe_runtime_resume(dev);
+		if (ret)
+			goto err_pm_disable;
+	}
+	pm_runtime_get_sync(dev);
+
+	ret = snd_soc_register_platform(dev, &mtk_afe_pcm_platform);
 	if (ret) {
 		dev_warn(dev, "err_platform\n");
 		goto err_platform;
@@ -1610,35 +1614,28 @@ static int mt2701_afe_pcm_dev_probe(struct platform_device *pdev)
 		goto err_dai_component;
 	}
 
-	mt2701_afe_runtime_resume(&pdev->dev);
-
 	return 0;
 
 err_dai_component:
-	snd_soc_unregister_component(&pdev->dev);
-
+	snd_soc_unregister_platform(dev);
 err_platform:
-	snd_soc_unregister_platform(&pdev->dev);
-
+	pm_runtime_put_sync(dev);
 err_pm_disable:
-	pm_runtime_disable(&pdev->dev);
+	pm_runtime_disable(dev);
 
 	return ret;
 }
 
 static int mt2701_afe_pcm_dev_remove(struct platform_device *pdev)
 {
-	struct mtk_base_afe *afe = platform_get_drvdata(pdev);
-
+	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	if (!pm_runtime_status_suspended(&pdev->dev))
 		mt2701_afe_runtime_suspend(&pdev->dev);
-	pm_runtime_put_sync(&pdev->dev);
 
 	snd_soc_unregister_component(&pdev->dev);
 	snd_soc_unregister_platform(&pdev->dev);
-	/* disable afe clock */
-	mt2701_afe_disable_clock(afe);
+
 	return 0;
 }
 
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
