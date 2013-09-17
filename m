From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/1] ASoC: omap-mcpdm: Use
	devm_snd_soc_register_component
Date: Tue, 17 Sep 2013 10:28:02 +0530
Message-ID: <1379393882-17769-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f182.google.com (mail-pd0-f182.google.com
 [209.85.192.182])
 by alsa0.perex.cz (Postfix) with ESMTP id C99BA261AF4
 for <alsa-devel@alsa-project.org>; Tue, 17 Sep 2013 07:16:20 +0200 (CEST)
Received: by mail-pd0-f182.google.com with SMTP id r10so5058969pdi.41
 for <alsa-devel@alsa-project.org>; Mon, 16 Sep 2013 22:16:19 -0700 (PDT)
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
Cc: peter.ujfalusi@ti.com, sachin.kamat@linaro.org, misael.lopez@ti.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

devm_snd_soc_register_component makes code simpler.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
Compile tested.
---
 sound/soc/omap/omap-mcpdm.c |   12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/sound/soc/omap/omap-mcpdm.c b/sound/soc/omap/omap-mcpdm.c
index 90d2a7c..cd9ee16 100644
--- a/sound/soc/omap/omap-mcpdm.c
+++ b/sound/soc/omap/omap-mcpdm.c
@@ -490,14 +490,9 @@ static int asoc_mcpdm_probe(struct platform_device *pdev)
 
 	mcpdm->dev = &pdev->dev;
 
-	return snd_soc_register_component(&pdev->dev, &omap_mcpdm_component,
-					  &omap_mcpdm_dai, 1);
-}
-
-static int asoc_mcpdm_remove(struct platform_device *pdev)
-{
-	snd_soc_unregister_component(&pdev->dev);
-	return 0;
+	return devm_snd_soc_register_component(&pdev->dev,
+					       &omap_mcpdm_component,
+					       &omap_mcpdm_dai, 1);
 }
 
 static const struct of_device_id omap_mcpdm_of_match[] = {
@@ -514,7 +509,6 @@ static struct platform_driver asoc_mcpdm_driver = {
 	},
 
 	.probe	= asoc_mcpdm_probe,
-	.remove	= asoc_mcpdm_remove,
 };
 
 module_platform_driver(asoc_mcpdm_driver);
-- 
1.7.9.5
