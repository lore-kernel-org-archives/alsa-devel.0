From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: ml26124: Convert to devm_regmap_init_i2c
Date: Wed, 13 Jun 2012 14:36:07 +0800
Message-ID: <1339569367.11749.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f51.google.com (mail-pb0-f51.google.com
	[209.85.160.51]) by alsa0.perex.cz (Postfix) with ESMTP id C2A9C24133
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Jun 2012 08:36:20 +0200 (CEST)
Received: by pbbrp16 with SMTP id rp16so2162545pbb.38
	for <alsa-devel@alsa-project.org>; Tue, 12 Jun 2012 23:36:19 -0700 (PDT)
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
Cc: Tomoya MORINAGA <tomoya.rohm@gmail.com>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

This fixes a leak if snd_soc_register_codec fails.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/ml26124.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/sound/soc/codecs/ml26124.c b/sound/soc/codecs/ml26124.c
index 22cb5bf..96aa5fa 100644
--- a/sound/soc/codecs/ml26124.c
+++ b/sound/soc/codecs/ml26124.c
@@ -638,7 +638,7 @@ static __devinit int ml26124_i2c_probe(struct i2c_client *i2c,
 
 	i2c_set_clientdata(i2c, priv);
 
-	priv->regmap = regmap_init_i2c(i2c, &ml26124_i2c_regmap);
+	priv->regmap = devm_regmap_init_i2c(i2c, &ml26124_i2c_regmap);
 	if (IS_ERR(priv->regmap)) {
 		ret = PTR_ERR(priv->regmap);
 		dev_err(&i2c->dev, "regmap_init_i2c() failed: %d\n", ret);
@@ -651,10 +651,7 @@ static __devinit int ml26124_i2c_probe(struct i2c_client *i2c,
 
 static __devexit int ml26124_i2c_remove(struct i2c_client *client)
 {
-	struct ml26124_priv *priv = i2c_get_clientdata(client);
-
 	snd_soc_unregister_codec(&client->dev);
-	regmap_exit(priv->regmap);
 	return 0;
 }
 
-- 
1.7.9.5
