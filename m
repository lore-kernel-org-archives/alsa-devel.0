From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 3/3] ASoC: imx-wm8962: Use
	devm_snd_soc_register_card
Date: Tue, 17 Sep 2013 09:42:48 +0530
Message-ID: <1379391168-5220-3-git-send-email-sachin.kamat@linaro.org>
References: <1379391168-5220-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f41.google.com (mail-pb0-f41.google.com
 [209.85.160.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 70FA8265074
 for <alsa-devel@alsa-project.org>; Tue, 17 Sep 2013 06:31:12 +0200 (CEST)
Received: by mail-pb0-f41.google.com with SMTP id rp2so5013554pbb.28
 for <alsa-devel@alsa-project.org>; Mon, 16 Sep 2013 21:31:11 -0700 (PDT)
In-Reply-To: <1379391168-5220-1-git-send-email-sachin.kamat@linaro.org>
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
 sound/soc/fsl/imx-wm8962.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/fsl/imx-wm8962.c b/sound/soc/fsl/imx-wm8962.c
index 722afe6..6c60666 100644
--- a/sound/soc/fsl/imx-wm8962.c
+++ b/sound/soc/fsl/imx-wm8962.c
@@ -266,7 +266,7 @@ static int imx_wm8962_probe(struct platform_device *pdev)
 	data->card.late_probe = imx_wm8962_late_probe;
 	data->card.set_bias_level = imx_wm8962_set_bias_level;
 
-	ret = snd_soc_register_card(&data->card);
+	ret = devm_snd_soc_register_card(&pdev->dev, &data->card);
 	if (ret) {
 		dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n", ret);
 		goto clk_fail;
@@ -296,7 +296,6 @@ static int imx_wm8962_remove(struct platform_device *pdev)
 
 	if (!IS_ERR(data->codec_clk))
 		clk_disable_unprepare(data->codec_clk);
-	snd_soc_unregister_card(&data->card);
 
 	return 0;
 }
-- 
1.7.9.5
