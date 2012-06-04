From: Brian Austin <brian.austin@cirrus.com>
Subject: [PATCH 1/2] ASoC: cs42l73: Convert to
	devm_regmap_init_i2c()
Date: Mon, 4 Jun 2012 13:19:41 -0500
Message-ID: <1338833982-25482-1-git-send-email-brian.austin@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
	by alsa0.perex.cz (Postfix) with ESMTP id 81D702448D
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Jun 2012 20:22:39 +0200 (CEST)
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
Cc: Brian Austin <brian.austin@cirrus.com>, broonie@opensource.wolfsonmicro.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Brian Austin <brian.austin@cirrus.com>
---
 sound/soc/codecs/cs42l73.c |   20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/sound/soc/codecs/cs42l73.c b/sound/soc/codecs/cs42l73.c
index e0d45fd..2c08c4c 100644
--- a/sound/soc/codecs/cs42l73.c
+++ b/sound/soc/codecs/cs42l73.c
@@ -1362,11 +1362,11 @@ static __devinit int cs42l73_i2c_probe(struct i2c_client *i2c_client,
 
 	i2c_set_clientdata(i2c_client, cs42l73);
 
-	cs42l73->regmap = regmap_init_i2c(i2c_client, &cs42l73_regmap);
+	cs42l73->regmap = devm_regmap_init_i2c(i2c_client, &cs42l73_regmap);
 	if (IS_ERR(cs42l73->regmap)) {
 		ret = PTR_ERR(cs42l73->regmap);
 		dev_err(&i2c_client->dev, "regmap_init() failed: %d\n", ret);
-		goto err;
+		return ret;
 	}
 	/* initialize codec */
 	ret = regmap_read(cs42l73->regmap, CS42L73_DEVID_AB, &reg);
@@ -1384,13 +1384,13 @@ static __devinit int cs42l73_i2c_probe(struct i2c_client *i2c_client,
 		dev_err(&i2c_client->dev,
 			"CS42L73 Device ID (%X). Expected %X\n",
 			devid, CS42L73_DEVID);
-		goto err_regmap;
+		return ret;
 	}
 
 	ret = regmap_read(cs42l73->regmap, CS42L73_REVID, &reg);
 	if (ret < 0) {
 		dev_err(&i2c_client->dev, "Get Revision ID failed\n");
-		goto err_regmap;
+		return ret;;
 	}
 
 	dev_info(&i2c_client->dev,
@@ -1402,23 +1402,13 @@ static __devinit int cs42l73_i2c_probe(struct i2c_client *i2c_client,
 			&soc_codec_dev_cs42l73, cs42l73_dai,
 			ARRAY_SIZE(cs42l73_dai));
 	if (ret < 0)
-		goto err_regmap;
+		return ret;
 	return 0;
-
-err_regmap:
-	regmap_exit(cs42l73->regmap);
-
-err:
-	return ret;
 }
 
 static __devexit int cs42l73_i2c_remove(struct i2c_client *client)
 {
-	struct cs42l73_private *cs42l73 = i2c_get_clientdata(client);
-
 	snd_soc_unregister_codec(&client->dev);
-	regmap_exit(cs42l73->regmap);
-
 	return 0;
 }
 
-- 
1.7.10
