From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 01/10] ASoC: Convert 88pm860x-codec to
	devm_kzalloc()
Date: Mon, 26 Dec 2011 20:48:48 +0800
Message-ID: <1324903728.26543.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 24FB110386D
	for <alsa-devel@alsa-project.org>; Mon, 26 Dec 2011 13:49:00 +0100 (CET)
Received: by iaae16 with SMTP id e16so18092152iaa.38
	for <alsa-devel@alsa-project.org>; Mon, 26 Dec 2011 04:48:59 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Haojian Zhuang <haojian.zhuang@marvell.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/88pm860x-codec.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/88pm860x-codec.c b/sound/soc/codecs/88pm860x-codec.c
index 99ca53c..9fd3b68 100644
--- a/sound/soc/codecs/88pm860x-codec.c
+++ b/sound/soc/codecs/88pm860x-codec.c
@@ -1430,7 +1430,8 @@ static int __devinit pm860x_codec_probe(struct platform_device *pdev)
 	struct resource *res;
 	int i, ret;
 
-	pm860x = kzalloc(sizeof(struct pm860x_priv), GFP_KERNEL);
+	pm860x = devm_kzalloc(&pdev->dev, sizeof(struct pm860x_priv),
+			      GFP_KERNEL);
 	if (pm860x == NULL)
 		return -ENOMEM;
 
@@ -1459,17 +1460,13 @@ static int __devinit pm860x_codec_probe(struct platform_device *pdev)
 
 out:
 	platform_set_drvdata(pdev, NULL);
-	kfree(pm860x);
 	return -EINVAL;
 }
 
 static int __devexit pm860x_codec_remove(struct platform_device *pdev)
 {
-	struct pm860x_priv *pm860x = platform_get_drvdata(pdev);
-
 	snd_soc_unregister_codec(&pdev->dev);
 	platform_set_drvdata(pdev, NULL);
-	kfree(pm860x);
 	return 0;
 }
 
-- 
1.7.5.4
