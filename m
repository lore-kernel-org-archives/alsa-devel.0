From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 2/2] ASoC: SPEAr spdif_out: Use
	devm_snd_soc_register_component
Date: Tue, 17 Sep 2013 10:41:37 +0530
Message-ID: <1379394697-19810-2-git-send-email-sachin.kamat@linaro.org>
References: <1379394697-19810-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f45.google.com (mail-pa0-f45.google.com
 [209.85.220.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 8A27D2650C1
 for <alsa-devel@alsa-project.org>; Tue, 17 Sep 2013 07:29:58 +0200 (CEST)
Received: by mail-pa0-f45.google.com with SMTP id bg4so6295904pad.4
 for <alsa-devel@alsa-project.org>; Mon, 16 Sep 2013 22:29:57 -0700 (PDT)
In-Reply-To: <1379394697-19810-1-git-send-email-sachin.kamat@linaro.org>
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
Cc: vipin.kumar@st.com, sachin.kamat@linaro.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

devm_snd_soc_register_component makes code simpler.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 sound/soc/spear/spdif_out.c |   12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/sound/soc/spear/spdif_out.c b/sound/soc/spear/spdif_out.c
index 2fdf68c..70fc4d6 100644
--- a/sound/soc/spear/spdif_out.c
+++ b/sound/soc/spear/spdif_out.c
@@ -307,18 +307,11 @@ static int spdif_out_probe(struct platform_device *pdev)
 
 	dev_set_drvdata(&pdev->dev, host);
 
-	ret = snd_soc_register_component(&pdev->dev, &spdif_out_component,
-					 &spdif_out_dai, 1);
+	ret = devm_snd_soc_register_component(&pdev->dev, &spdif_out_component,
+					      &spdif_out_dai, 1);
 	return ret;
 }
 
-static int spdif_out_remove(struct platform_device *pdev)
-{
-	snd_soc_unregister_component(&pdev->dev);
-
-	return 0;
-}
-
 #ifdef CONFIG_PM
 static int spdif_out_suspend(struct device *dev)
 {
@@ -357,7 +350,6 @@ static SIMPLE_DEV_PM_OPS(spdif_out_dev_pm_ops, spdif_out_suspend, \
 
 static struct platform_driver spdif_out_driver = {
 	.probe		= spdif_out_probe,
-	.remove		= spdif_out_remove,
 	.driver		= {
 		.name	= "spdif-out",
 		.owner	= THIS_MODULE,
-- 
1.7.9.5
