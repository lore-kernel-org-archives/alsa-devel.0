From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] ASoC: max98090: Convert to devm_regmap_init_i2c
Date: Sun, 03 Mar 2013 16:49:06 +0800
Message-ID: <1362300546.9569.6.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-da0-f46.google.com (mail-da0-f46.google.com
 [209.85.210.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 060902616CF
 for <alsa-devel@alsa-project.org>; Sun,  3 Mar 2013 09:49:16 +0100 (CET)
Received: by mail-da0-f46.google.com with SMTP id z8so2054672dad.33
 for <alsa-devel@alsa-project.org>; Sun, 03 Mar 2013 00:49:15 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, Ralph Birt <ralph.birt@maximintegrated.com>, Jerry Wong <jerry.wong@maximintegrated.com>, Matthew Mowdy <matthew.mowdy@maximintegrated.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/max98090.c |   16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index fc17604..6dd36da 100755
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -2324,28 +2324,20 @@ static int max98090_i2c_probe(struct i2c_client *i2c,
 	max98090->pdata = i2c->dev.platform_data;
 	max98090->irq = i2c->irq;
 
-	max98090->regmap = regmap_init_i2c(i2c, &max98090_regmap);
+	max98090->regmap = devm_regmap_init_i2c(i2c, &max98090_regmap);
 	if (IS_ERR(max98090->regmap)) {
 		ret = PTR_ERR(max98090->regmap);
 		dev_err(&i2c->dev, "Failed to allocate regmap: %d\n", ret);
-		goto err_enable;
+		return ret;
 	}
 
-	ret = snd_soc_register_codec(&i2c->dev,
-			&soc_codec_dev_max98090, max98090_dai,
-			ARRAY_SIZE(max98090_dai));
-	if (ret < 0)
-		regmap_exit(max98090->regmap);
-
-err_enable:
-	return ret;
+	return snd_soc_register_codec(&i2c->dev, &soc_codec_dev_max98090,
+				      max98090_dai, ARRAY_SIZE(max98090_dai));
 }
 
 static int max98090_i2c_remove(struct i2c_client *client)
 {
-	struct max98090_priv *max98090 = dev_get_drvdata(&client->dev);
 	snd_soc_unregister_codec(&client->dev);
-	regmap_exit(max98090->regmap);
 	return 0;
 }
 
-- 
1.7.9.5
