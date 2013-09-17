From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 2/3] ASoC: imx-spdif: Use
	devm_snd_soc_register_card
Date: Tue, 17 Sep 2013 09:42:47 +0530
Message-ID: <1379391168-5220-2-git-send-email-sachin.kamat@linaro.org>
References: <1379391168-5220-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f54.google.com (mail-pa0-f54.google.com
 [209.85.220.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 9854B261B25
 for <alsa-devel@alsa-project.org>; Tue, 17 Sep 2013 06:31:10 +0200 (CEST)
Received: by mail-pa0-f54.google.com with SMTP id kx10so6250302pab.41
 for <alsa-devel@alsa-project.org>; Mon, 16 Sep 2013 21:31:08 -0700 (PDT)
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
 sound/soc/fsl/imx-spdif.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/fsl/imx-spdif.c b/sound/soc/fsl/imx-spdif.c
index 816013b..8499d52 100644
--- a/sound/soc/fsl/imx-spdif.c
+++ b/sound/soc/fsl/imx-spdif.c
@@ -87,7 +87,7 @@ static int imx_spdif_audio_probe(struct platform_device *pdev)
 	if (ret)
 		goto error_dir;
 
-	ret = snd_soc_register_card(&data->card);
+	ret = devm_snd_soc_register_card(&pdev->dev, &data->card);
 	if (ret) {
 		dev_err(&pdev->dev, "snd_soc_register_card failed: %d\n", ret);
 		goto error_dir;
@@ -119,8 +119,6 @@ static int imx_spdif_audio_remove(struct platform_device *pdev)
 	if (data->txdev)
 		platform_device_unregister(data->txdev);
 
-	snd_soc_unregister_card(&data->card);
-
 	return 0;
 }
 
-- 
1.7.9.5
