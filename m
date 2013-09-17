From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/1] ASoC: mxs-saif: Use
	devm_snd_soc_register_component
Date: Tue, 17 Sep 2013 10:20:09 +0530
Message-ID: <1379393409-13607-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f49.google.com (mail-pa0-f49.google.com
 [209.85.220.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 75FC32650C1
 for <alsa-devel@alsa-project.org>; Tue, 17 Sep 2013 07:08:27 +0200 (CEST)
Received: by mail-pa0-f49.google.com with SMTP id ld10so6282984pab.22
 for <alsa-devel@alsa-project.org>; Mon, 16 Sep 2013 22:08:26 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: sachin.kamat@linaro.org, broonie@kernel.org, shawn.guo@linaro.org
List-Id: alsa-devel@alsa-project.org

devm_snd_soc_register_component makes code simpler.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 sound/soc/mxs/mxs-saif.c |   12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/sound/soc/mxs/mxs-saif.c b/sound/soc/mxs/mxs-saif.c
index b56b8a0..14152f6 100644
--- a/sound/soc/mxs/mxs-saif.c
+++ b/sound/soc/mxs/mxs-saif.c
@@ -768,8 +768,8 @@ static int mxs_saif_probe(struct platform_device *pdev)
 			dev_warn(&pdev->dev, "failed to init clocks\n");
 	}
 
-	ret = snd_soc_register_component(&pdev->dev, &mxs_saif_component,
-					 &mxs_saif_dai, 1);
+	ret = devm_snd_soc_register_component(&pdev->dev, &mxs_saif_component,
+					      &mxs_saif_dai, 1);
 	if (ret) {
 		dev_err(&pdev->dev, "register DAI failed\n");
 		return ret;
@@ -778,21 +778,15 @@ static int mxs_saif_probe(struct platform_device *pdev)
 	ret = mxs_pcm_platform_register(&pdev->dev);
 	if (ret) {
 		dev_err(&pdev->dev, "register PCM failed: %d\n", ret);
-		goto failed_pdev_alloc;
+		return ret;
 	}
 
 	return 0;
-
-failed_pdev_alloc:
-	snd_soc_unregister_component(&pdev->dev);
-
-	return ret;
 }
 
 static int mxs_saif_remove(struct platform_device *pdev)
 {
 	mxs_pcm_platform_unregister(&pdev->dev);
-	snd_soc_unregister_component(&pdev->dev);
 
 	return 0;
 }
-- 
1.7.9.5
