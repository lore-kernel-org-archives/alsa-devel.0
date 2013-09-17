From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/2] ASoC: SPEAr spdif_in: Use
	devm_snd_soc_register_component
Date: Tue, 17 Sep 2013 10:41:36 +0530
Message-ID: <1379394697-19810-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f180.google.com (mail-pd0-f180.google.com
 [209.85.192.180])
 by alsa0.perex.cz (Postfix) with ESMTP id ADCF02650B4
 for <alsa-devel@alsa-project.org>; Tue, 17 Sep 2013 07:29:55 +0200 (CEST)
Received: by mail-pd0-f180.google.com with SMTP id y10so5085736pdj.11
 for <alsa-devel@alsa-project.org>; Mon, 16 Sep 2013 22:29:54 -0700 (PDT)
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
 sound/soc/spear/spdif_in.c |   12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/sound/soc/spear/spdif_in.c b/sound/soc/spear/spdif_in.c
index 63acfeb..21a8c95 100644
--- a/sound/soc/spear/spdif_in.c
+++ b/sound/soc/spear/spdif_in.c
@@ -257,20 +257,12 @@ static int spdif_in_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	return snd_soc_register_component(&pdev->dev, &spdif_in_component,
-					 &spdif_in_dai, 1);
-}
-
-static int spdif_in_remove(struct platform_device *pdev)
-{
-	snd_soc_unregister_component(&pdev->dev);
-
-	return 0;
+	return devm_snd_soc_register_component(&pdev->dev, &spdif_in_component,
+					       &spdif_in_dai, 1);
 }
 
 static struct platform_driver spdif_in_driver = {
 	.probe		= spdif_in_probe,
-	.remove		= spdif_in_remove,
 	.driver		= {
 		.name	= "spdif-in",
 		.owner	= THIS_MODULE,
-- 
1.7.9.5
