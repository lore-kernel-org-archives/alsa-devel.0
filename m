From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/3] ASoC: imx-sgtl5000: Use
	devm_snd_soc_register_card
Date: Tue, 17 Sep 2013 09:42:46 +0530
Message-ID: <1379391168-5220-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f174.google.com (mail-pd0-f174.google.com
 [209.85.192.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 69E22261AF4
 for <alsa-devel@alsa-project.org>; Tue, 17 Sep 2013 06:31:10 +0200 (CEST)
Received: by mail-pd0-f174.google.com with SMTP id y13so5003804pdi.5
 for <alsa-devel@alsa-project.org>; Mon, 16 Sep 2013 21:31:08 -0700 (PDT)
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
Cc: sachin.kamat@linaro.org, broonie@kernel.org, lgirdwood@gmail.com, shawn.guo@linaro.org
List-Id: alsa-devel@alsa-project.org

devm_snd_soc_register_card makes code simpler.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
This series compile tested.
---
 sound/soc/fsl/imx-sgtl5000.c |   12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/sound/soc/fsl/imx-sgtl5000.c b/sound/soc/fsl/imx-sgtl5000.c
index 46c5b4f..78f86d8 100644
--- a/sound/soc/fsl/imx-sgtl5000.c
+++ b/sound/soc/fsl/imx-sgtl5000.c
@@ -159,7 +159,7 @@ static int imx_sgtl5000_probe(struct platform_device *pdev)
 	data->card.dapm_widgets = imx_sgtl5000_dapm_widgets;
 	data->card.num_dapm_widgets = ARRAY_SIZE(imx_sgtl5000_dapm_widgets);
 
-	ret = snd_soc_register_card(&data->card);
+	ret = devm_snd_soc_register_card(&pdev->dev, &data->card);
 	if (ret) {
 		dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n", ret);
 		goto fail;
@@ -180,15 +180,6 @@ fail:
 	return ret;
 }
 
-static int imx_sgtl5000_remove(struct platform_device *pdev)
-{
-	struct imx_sgtl5000_data *data = platform_get_drvdata(pdev);
-
-	snd_soc_unregister_card(&data->card);
-
-	return 0;
-}
-
 static const struct of_device_id imx_sgtl5000_dt_ids[] = {
 	{ .compatible = "fsl,imx-audio-sgtl5000", },
 	{ /* sentinel */ }
@@ -202,7 +193,6 @@ static struct platform_driver imx_sgtl5000_driver = {
 		.of_match_table = imx_sgtl5000_dt_ids,
 	},
 	.probe = imx_sgtl5000_probe,
-	.remove = imx_sgtl5000_remove,
 };
 module_platform_driver(imx_sgtl5000_driver);
 
-- 
1.7.9.5
