From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 05/14] ASoC: Convert max98095 to devm_kzalloc()
Date: Thu, 29 Dec 2011 12:02:21 +0800
Message-ID: <1325131341.19977.8.camel@phoenix>
References: <1325130983.19977.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 0DB2724642
	for <alsa-devel@alsa-project.org>; Thu, 29 Dec 2011 05:02:27 +0100 (CET)
Received: by yenr11 with SMTP id r11so3917549yen.38
	for <alsa-devel@alsa-project.org>; Wed, 28 Dec 2011 20:02:27 -0800 (PST)
In-Reply-To: <1325130983.19977.2.camel@phoenix>
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
Cc: Peter Hsiang <peter.hsiang@maxim-ic.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/max98095.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/max98095.c b/sound/soc/codecs/max98095.c
index c69dd02..fcfa749 100644
--- a/sound/soc/codecs/max98095.c
+++ b/sound/soc/codecs/max98095.c
@@ -2340,7 +2340,8 @@ static int max98095_i2c_probe(struct i2c_client *i2c,
 	struct max98095_priv *max98095;
 	int ret;
 
-	max98095 = kzalloc(sizeof(struct max98095_priv), GFP_KERNEL);
+	max98095 = devm_kzalloc(&i2c->dev, sizeof(struct max98095_priv),
+				GFP_KERNEL);
 	if (max98095 == NULL)
 		return -ENOMEM;
 
@@ -2350,16 +2351,12 @@ static int max98095_i2c_probe(struct i2c_client *i2c,
 
 	ret = snd_soc_register_codec(&i2c->dev, &soc_codec_dev_max98095,
 				     max98095_dai, ARRAY_SIZE(max98095_dai));
-	if (ret < 0)
-		kfree(max98095);
 	return ret;
 }
 
 static int __devexit max98095_i2c_remove(struct i2c_client *client)
 {
 	snd_soc_unregister_codec(&client->dev);
-	kfree(i2c_get_clientdata(client));
-
 	return 0;
 }
 
-- 
1.7.5.4
