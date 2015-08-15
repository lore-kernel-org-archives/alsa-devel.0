From: Vaishali Thakkar <vthakkar1994@gmail.com>
Subject: [PATCH] ASoC: davinci-vcif: Use devm_snd_soc_register_component
Date: Sat, 15 Aug 2015 08:01:55 +0530
Message-ID: <20150815023155.GA27364@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Wolfram Sang <wsa@the-dreams.de>, Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Use resource managed function devm_snd_soc_register_component for
component registration instead of snd_soc_register_component.

Also, remove davinci_vcif_remove as it is now redundant.

Signed-off-by: Vaishali Thakkar <vthakkar1994@gmail.com>
---
 sound/soc/davinci/davinci-vcif.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/sound/soc/davinci/davinci-vcif.c b/sound/soc/davinci/davinci-vcif.c
index fabd05f..c77d921 100644
--- a/sound/soc/davinci/davinci-vcif.c
+++ b/sound/soc/davinci/davinci-vcif.c
@@ -231,8 +231,9 @@ static int davinci_vcif_probe(struct platform_device *pdev)
 
 	dev_set_drvdata(&pdev->dev, davinci_vcif_dev);
 
-	ret = snd_soc_register_component(&pdev->dev, &davinci_vcif_component,
-					 &davinci_vcif_dai, 1);
+	ret = devm_snd_soc_register_component(&pdev->dev,
+					      &davinci_vcif_component,
+					      &davinci_vcif_dai, 1);
 	if (ret != 0) {
 		dev_err(&pdev->dev, "could not register dai\n");
 		return ret;
@@ -241,23 +242,14 @@ static int davinci_vcif_probe(struct platform_device *pdev)
 	ret = edma_pcm_platform_register(&pdev->dev);
 	if (ret) {
 		dev_err(&pdev->dev, "register PCM failed: %d\n", ret);
-		snd_soc_unregister_component(&pdev->dev);
 		return ret;
 	}
 
 	return 0;
 }
 
-static int davinci_vcif_remove(struct platform_device *pdev)
-{
-	snd_soc_unregister_component(&pdev->dev);
-
-	return 0;
-}
-
 static struct platform_driver davinci_vcif_driver = {
 	.probe		= davinci_vcif_probe,
-	.remove		= davinci_vcif_remove,
 	.driver		= {
 		.name	= "davinci-vcif",
 	},
-- 
1.9.1
