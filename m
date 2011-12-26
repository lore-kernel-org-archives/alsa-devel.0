From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 05/10] ASoC: Convert adau1701 to devm_kzalloc()
Date: Mon, 26 Dec 2011 20:53:09 +0800
Message-ID: <1324903989.26543.6.camel@phoenix>
References: <1324903728.26543.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id DD4A11038AF
	for <alsa-devel@alsa-project.org>; Mon, 26 Dec 2011 13:53:15 +0100 (CET)
Received: by iaae16 with SMTP id e16so18097619iaa.38
	for <alsa-devel@alsa-project.org>; Mon, 26 Dec 2011 04:53:15 -0800 (PST)
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
 sound/soc/codecs/adau1701.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/adau1701.c b/sound/soc/codecs/adau1701.c
index 6a6af56..6b325ea 100644
--- a/sound/soc/codecs/adau1701.c
+++ b/sound/soc/codecs/adau1701.c
@@ -496,23 +496,19 @@ static __devinit int adau1701_i2c_probe(struct i2c_client *client,
 	struct adau1701 *adau1701;
 	int ret;
 
-	adau1701 = kzalloc(sizeof(*adau1701), GFP_KERNEL);
+	adau1701 = devm_kzalloc(&client->dev, sizeof(*adau1701), GFP_KERNEL);
 	if (!adau1701)
 		return -ENOMEM;
 
 	i2c_set_clientdata(client, adau1701);
 	ret = snd_soc_register_codec(&client->dev, &adau1701_codec_drv,
 			&adau1701_dai, 1);
-	if (ret < 0)
-		kfree(adau1701);
-
 	return ret;
 }
 
 static __devexit int adau1701_i2c_remove(struct i2c_client *client)
 {
 	snd_soc_unregister_codec(&client->dev);
-	kfree(i2c_get_clientdata(client));
 	return 0;
 }
 
-- 
1.7.5.4
