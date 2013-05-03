From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 5/6] ASoC: 88pm860x: Remove redundant
	platform_set_drvdata()
Date: Fri,  3 May 2013 14:39:23 +0530
Message-ID: <1367572164-19523-5-git-send-email-sachin.kamat@linaro.org>
References: <1367572164-19523-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f45.google.com (mail-pa0-f45.google.com
 [209.85.220.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 4446626166B
 for <alsa-devel@alsa-project.org>; Fri,  3 May 2013 11:29:43 +0200 (CEST)
Received: by mail-pa0-f45.google.com with SMTP id lj1so840075pab.4
 for <alsa-devel@alsa-project.org>; Fri, 03 May 2013 02:29:42 -0700 (PDT)
In-Reply-To: <1367572164-19523-1-git-send-email-sachin.kamat@linaro.org>
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
Cc: tiwai@suse.de, sachin.kamat@linaro.org, broonie@kernel.org, Haojian Zhuang <haojian.zhuang@marvell.com>, patches@linaro.org
List-Id: alsa-devel@alsa-project.org

Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
driver is bound) removes the need to set driver data field to
NULL.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 sound/soc/codecs/88pm860x-codec.c |    9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/88pm860x-codec.c b/sound/soc/codecs/88pm860x-codec.c
index 60159c0..1382f3f 100644
--- a/sound/soc/codecs/88pm860x-codec.c
+++ b/sound/soc/codecs/88pm860x-codec.c
@@ -1444,7 +1444,7 @@ static int pm860x_codec_probe(struct platform_device *pdev)
 		res = platform_get_resource(pdev, IORESOURCE_IRQ, i);
 		if (!res) {
 			dev_err(&pdev->dev, "Failed to get IRQ resources\n");
-			goto out;
+			return -EINVAL;
 		}
 		pm860x->irq[i] = res->start + chip->irq_base;
 		strncpy(pm860x->name[i], res->name, MAX_NAME_LEN);
@@ -1454,19 +1454,14 @@ static int pm860x_codec_probe(struct platform_device *pdev)
 				     pm860x_dai, ARRAY_SIZE(pm860x_dai));
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to register codec\n");
-		goto out;
+		return -EINVAL;
 	}
 	return ret;
-
-out:
-	platform_set_drvdata(pdev, NULL);
-	return -EINVAL;
 }
 
 static int pm860x_codec_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_codec(&pdev->dev);
-	platform_set_drvdata(pdev, NULL);
 	return 0;
 }
 
-- 
1.7.9.5
