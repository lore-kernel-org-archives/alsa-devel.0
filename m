From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/1] ASoC: mmp-sspa: Use
	devm_snd_soc_register_component
Date: Tue, 17 Sep 2013 10:32:48 +0530
Message-ID: <1379394168-18507-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f50.google.com (mail-pa0-f50.google.com
 [209.85.220.50])
 by alsa0.perex.cz (Postfix) with ESMTP id EAC45261AF4
 for <alsa-devel@alsa-project.org>; Tue, 17 Sep 2013 07:21:07 +0200 (CEST)
Received: by mail-pa0-f50.google.com with SMTP id fb10so6259138pad.23
 for <alsa-devel@alsa-project.org>; Mon, 16 Sep 2013 22:21:07 -0700 (PDT)
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
Cc: sachin.kamat@linaro.org, broonie@kernel.org, eric.y.miao@gmail.com, haojian.zhuang@gmail.com
List-Id: alsa-devel@alsa-project.org

devm_snd_soc_register_component makes code simpler.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 sound/soc/pxa/mmp-sspa.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/pxa/mmp-sspa.c b/sound/soc/pxa/mmp-sspa.c
index 41752a5..5bf5f1f 100644
--- a/sound/soc/pxa/mmp-sspa.c
+++ b/sound/soc/pxa/mmp-sspa.c
@@ -455,8 +455,8 @@ static int asoc_mmp_sspa_probe(struct platform_device *pdev)
 	priv->dai_fmt = (unsigned int) -1;
 	platform_set_drvdata(pdev, priv);
 
-	return snd_soc_register_component(&pdev->dev, &mmp_sspa_component,
-					  &mmp_sspa_dai, 1);
+	return devm_snd_soc_register_component(&pdev->dev, &mmp_sspa_component,
+					       &mmp_sspa_dai, 1);
 }
 
 static int asoc_mmp_sspa_remove(struct platform_device *pdev)
@@ -466,7 +466,6 @@ static int asoc_mmp_sspa_remove(struct platform_device *pdev)
 	clk_disable(priv->audio_clk);
 	clk_put(priv->audio_clk);
 	clk_put(priv->sysclk);
-	snd_soc_unregister_component(&pdev->dev);
 	return 0;
 }
 
-- 
1.7.9.5
