From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 04/10] ASoC: Convert adau1373 to devm_kzalloc()
Date: Mon, 26 Dec 2011 20:52:13 +0800
Message-ID: <1324903933.26543.5.camel@phoenix>
References: <1324903728.26543.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id C4897103894
	for <alsa-devel@alsa-project.org>; Mon, 26 Dec 2011 13:52:19 +0100 (CET)
Received: by iaae16 with SMTP id e16so18096351iaa.38
	for <alsa-devel@alsa-project.org>; Mon, 26 Dec 2011 04:52:19 -0800 (PST)
In-Reply-To: <1324903728.26543.1.camel@phoenix>
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
Cc: Lars-Peter Clausen <lars@metafoo.de>, Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Mark@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/adau1373.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/adau1373.c b/sound/soc/codecs/adau1373.c
index 637b114..971ba45 100644
--- a/sound/soc/codecs/adau1373.c
+++ b/sound/soc/codecs/adau1373.c
@@ -1360,7 +1360,7 @@ static int __devinit adau1373_i2c_probe(struct i2c_client *client,
 	struct adau1373 *adau1373;
 	int ret;
 
-	adau1373 = kzalloc(sizeof(*adau1373), GFP_KERNEL);
+	adau1373 = devm_kzalloc(&client->dev, sizeof(*adau1373), GFP_KERNEL);
 	if (!adau1373)
 		return -ENOMEM;
 
@@ -1368,16 +1368,12 @@ static int __devinit adau1373_i2c_probe(struct i2c_client *client,
 
 	ret = snd_soc_register_codec(&client->dev, &adau1373_codec_driver,
 			adau1373_dai_driver, ARRAY_SIZE(adau1373_dai_driver));
-	if (ret < 0)
-		kfree(adau1373);
-
 	return ret;
 }
 
 static int __devexit adau1373_i2c_remove(struct i2c_client *client)
 {
 	snd_soc_unregister_codec(&client->dev);
-	kfree(dev_get_drvdata(&client->dev));
 	return 0;
 }
 
-- 
1.7.5.4
