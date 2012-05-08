From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 3/3] ASoC: alc5632: Convert to
	devm_regmap_init_i2c()
Date: Tue, 08 May 2012 23:44:55 +0800
Message-ID: <1336491895.14361.3.camel@phoenix>
References: <1336491743.14361.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51])
	by alsa0.perex.cz (Postfix) with ESMTP id A3FA21044B8
	for <alsa-devel@alsa-project.org>;
	Tue,  8 May 2012 17:45:04 +0200 (CEST)
Received: by dajt11 with SMTP id t11so3331249daj.38
	for <alsa-devel@alsa-project.org>; Tue, 08 May 2012 08:45:03 -0700 (PDT)
In-Reply-To: <1336491743.14361.1.camel@phoenix>
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
Cc: Andrey Danin <danindrey@mail.ru>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Leon Romanovsky <leon@leon.nu>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/alc5632.c |    8 +-------
 1 files changed, 1 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/alc5632.c b/sound/soc/codecs/alc5632.c
index b29a53b..7dd0242 100644
--- a/sound/soc/codecs/alc5632.c
+++ b/sound/soc/codecs/alc5632.c
@@ -1130,7 +1130,7 @@ static __devinit int alc5632_i2c_probe(struct i2c_client *client,
 
 	i2c_set_clientdata(client, alc5632);
 
-	alc5632->regmap = regmap_init_i2c(client, &alc5632_regmap);
+	alc5632->regmap = devm_regmap_init_i2c(client, &alc5632_regmap);
 	if (IS_ERR(alc5632->regmap)) {
 		ret = PTR_ERR(alc5632->regmap);
 		dev_err(&client->dev, "regmap_init() failed: %d\n", ret);
@@ -1142,7 +1142,6 @@ static __devinit int alc5632_i2c_probe(struct i2c_client *client,
 	if (ret1 != 0 || ret2 != 0) {
 		dev_err(&client->dev,
 		"Failed to read chip ID: ret1=%d, ret2=%d\n", ret1, ret2);
-		regmap_exit(alc5632->regmap);
 		return -EIO;
 	}
 
@@ -1151,14 +1150,12 @@ static __devinit int alc5632_i2c_probe(struct i2c_client *client,
 	if ((vid1 != 0x10EC) || (vid2 != id->driver_data)) {
 		dev_err(&client->dev,
 		"Device is not a ALC5632: VID1=0x%x, VID2=0x%x\n", vid1, vid2);
-		regmap_exit(alc5632->regmap);
 		return -EINVAL;
 	}
 
 	ret = alc5632_reset(alc5632->regmap);
 	if (ret < 0) {
 		dev_err(&client->dev, "Failed to issue reset\n");
-		regmap_exit(alc5632->regmap);
 		return ret;
 	}
 
@@ -1176,7 +1173,6 @@ static __devinit int alc5632_i2c_probe(struct i2c_client *client,
 
 	if (ret < 0) {
 		dev_err(&client->dev, "Failed to register codec: %d\n", ret);
-		regmap_exit(alc5632->regmap);
 		return ret;
 	}
 
@@ -1185,9 +1181,7 @@ static __devinit int alc5632_i2c_probe(struct i2c_client *client,
 
 static __devexit int alc5632_i2c_remove(struct i2c_client *client)
 {
-	struct alc5632_priv *alc5632 = i2c_get_clientdata(client);
 	snd_soc_unregister_codec(&client->dev);
-	regmap_exit(alc5632->regmap);
 	return 0;
 }
 
-- 
1.7.5.4
