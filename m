From: Brian Austin <brian.austin@cirrus.com>
Subject: [PATCH 2/2] ASoC: cs42l52: Convert to
	devm_regmap_init_i2c()
Date: Mon, 4 Jun 2012 13:19:42 -0500
Message-ID: <1338833982-25482-2-git-send-email-brian.austin@cirrus.com>
References: <1338833982-25482-1-git-send-email-brian.austin@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
	by alsa0.perex.cz (Postfix) with ESMTP id A7EBA2448A
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Jun 2012 20:22:38 +0200 (CEST)
In-Reply-To: <1338833982-25482-1-git-send-email-brian.austin@cirrus.com>
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
 sound/soc/codecs/cs42l52.c |   18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/sound/soc/codecs/cs42l52.c b/sound/soc/codecs/cs42l52.c
index ec03abc..628daf6 100644
--- a/sound/soc/codecs/cs42l52.c
+++ b/sound/soc/codecs/cs42l52.c
@@ -1216,11 +1216,11 @@ static int cs42l52_i2c_probe(struct i2c_client *i2c_client,
 		return -ENOMEM;
 	cs42l52->dev = &i2c_client->dev;
 
-	cs42l52->regmap = regmap_init_i2c(i2c_client, &cs42l52_regmap);
+	cs42l52->regmap = devm_regmap_init_i2c(i2c_client, &cs42l52_regmap);
 	if (IS_ERR(cs42l52->regmap)) {
 		ret = PTR_ERR(cs42l52->regmap);
 		dev_err(&i2c_client->dev, "regmap_init() failed: %d\n", ret);
-		goto err;
+		return ret;
 	}
 
 	i2c_set_clientdata(i2c_client, cs42l52);
@@ -1242,7 +1242,7 @@ static int cs42l52_i2c_probe(struct i2c_client *i2c_client,
 		dev_err(&i2c_client->dev,
 			"CS42L52 Device ID (%X). Expected %X\n",
 			devid, CS42L52_CHIP_ID);
-		goto err_regmap;
+		return ret;
 	}
 
 	regcache_cache_only(cs42l52->regmap, true);
@@ -1250,23 +1250,13 @@ static int cs42l52_i2c_probe(struct i2c_client *i2c_client,
 	ret =  snd_soc_register_codec(&i2c_client->dev,
 			&soc_codec_dev_cs42l52, &cs42l52_dai, 1);
 	if (ret < 0)
-		goto err_regmap;
+		return ret;
 	return 0;
-
-err_regmap:
-	regmap_exit(cs42l52->regmap);
-
-err:
-	return ret;
 }
 
 static int cs42l52_i2c_remove(struct i2c_client *client)
 {
-	struct cs42l52_private *cs42l52 = i2c_get_clientdata(client);
-
 	snd_soc_unregister_codec(&client->dev);
-	regmap_exit(cs42l52->regmap);
-
 	return 0;
 }
 
-- 
1.7.10
