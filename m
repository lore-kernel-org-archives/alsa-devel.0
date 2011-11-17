From: Leon Romanovsky <leon@leon.nu>
Subject: [PATCH v2 3/3] ASoC: alc5632: Update of i2c_probe
	function to use regmap API only
Date: Thu, 17 Nov 2011 12:01:30 +0200
Message-ID: <1321524090-8935-3-git-send-email-leon@leon.nu>
References: <1321524090-8935-1-git-send-email-leon@leon.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 2CF51103A48
	for <alsa-devel@alsa-project.org>; Thu, 17 Nov 2011 11:01:49 +0100 (CET)
Received: by mail-ey0-f179.google.com with SMTP id 10so1774085eyz.38
	for <alsa-devel@alsa-project.org>; Thu, 17 Nov 2011 02:01:49 -0800 (PST)
In-Reply-To: <1321524090-8935-1-git-send-email-leon@leon.nu>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, lrg@ti.com
Cc: alsa-devel@alsa-project.org, Leon Romanovsky <leon@leon.nu>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Leon Romanovsky <leon@leon.nu>
---
 sound/soc/codecs/alc5632.c |   67 +++++++++++++++++++------------------------
 1 files changed, 30 insertions(+), 37 deletions(-)

diff --git a/sound/soc/codecs/alc5632.c b/sound/soc/codecs/alc5632.c
index be10228..c32eade 100644
--- a/sound/soc/codecs/alc5632.c
+++ b/sound/soc/codecs/alc5632.c
@@ -1053,48 +1053,14 @@ static __devinit int alc5632_i2c_probe(struct i2c_client *client,
 				const struct i2c_device_id *id)
 {
 	struct alc5632_priv *alc5632;
-	int ret, vid1, vid2;
-
-	vid1 = i2c_smbus_read_word_data(client, ALC5632_VENDOR_ID1);
-	if (vid1 < 0) {
-		dev_err(&client->dev, "failed to read I2C\n");
-		return -EIO;
-	} else {
-		dev_info(&client->dev, "got vid1: %x\n", vid1);
-	}
-	vid1 = ((vid1 & 0xff) << 8) | (vid1 >> 8);
-
-	vid2 = i2c_smbus_read_word_data(client, ALC5632_VENDOR_ID2);
-	if (vid2 < 0) {
-		dev_err(&client->dev, "failed to read I2C\n");
-		return -EIO;
-	} else {
-		dev_info(&client->dev, "got vid2: %x\n", vid2);
-	}
-	vid2 = (vid2 & 0xff);
-
-	if ((vid1 != 0x10ec) || (vid2 != id->driver_data)) {
-		dev_err(&client->dev, "unknown or wrong codec\n");
-		dev_err(&client->dev, "Expected %x:%lx, got %x:%x\n",
-				0x10ec, id->driver_data,
-				vid1, vid2);
-		return -ENODEV;
-	}
+	int ret, ret1, ret2;
+	unsigned int vid1, vid2;
 
 	alc5632 = devm_kzalloc(&client->dev,
 			 sizeof(struct alc5632_priv), GFP_KERNEL);
 	if (alc5632 == NULL)
 		return -ENOMEM;
 
-	alc5632->id = vid2;
-	switch (alc5632->id) {
-	case 0x5c:
-		alc5632_dai.name = "alc5632-hifi";
-		break;
-	default:
-		return -EINVAL;
-	}
-
 	i2c_set_clientdata(client, alc5632);
 
 	alc5632->regmap = regmap_init_i2c(client, &alc5632_regmap);
@@ -1104,6 +1070,24 @@ static __devinit int alc5632_i2c_probe(struct i2c_client *client,
 		return ret;
 	}
 
+	ret1 = regmap_read(alc5632->regmap, ALC5632_VENDOR_ID1, &vid1);
+	ret2 = regmap_read(alc5632->regmap, ALC5632_VENDOR_ID2, &vid2);
+	if (ret1 != 0 || ret2 != 0) {
+		dev_err(&client->dev,
+		"Failed to read chip ID: ret1=%d, ret2=%d\n", ret1, ret2);
+		regmap_exit(alc5632->regmap);
+		return -EIO;
+	}
+
+	vid2 >>= 8;
+
+	if ((vid1 != 0x10EC) || (vid2 != id->driver_data)) {
+		dev_err(&client->dev,
+		"Device is not a ALC5632: VID1=0x%x, VID2=0x%x\n", vid1, vid2);
+		regmap_exit(alc5632->regmap);
+		return -EINVAL;
+	}
+
 	ret = alc5632_reset(alc5632->regmap);
 	if (ret < 0) {
 		dev_err(&client->dev, "Failed to issue reset\n");
@@ -1111,7 +1095,16 @@ static __devinit int alc5632_i2c_probe(struct i2c_client *client,
 		return ret;
 	}
 
-	ret =  snd_soc_register_codec(&client->dev,
+	alc5632->id = vid2;
+	switch (alc5632->id) {
+	case 0x5c:
+		alc5632_dai.name = "alc5632-hifi";
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = snd_soc_register_codec(&client->dev,
 		&soc_codec_device_alc5632, &alc5632_dai, 1);
 
 	if (ret < 0) {
-- 
1.7.3.4
