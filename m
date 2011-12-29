From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 01/14] ASoC: Convert alc5623 to devm_kzalloc()
Date: Thu, 29 Dec 2011 11:56:23 +0800
Message-ID: <1325130983.19977.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51]) by alsa0.perex.cz (Postfix) with ESMTP id 1C47424634
	for <alsa-devel@alsa-project.org>; Thu, 29 Dec 2011 04:56:34 +0100 (CET)
Received: by yhjj56 with SMTP id j56so7873356yhj.38
	for <alsa-devel@alsa-project.org>; Wed, 28 Dec 2011 19:56:34 -0800 (PST)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Arnaud Patard <arnaud.patard@rtp-net.org>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/alc5623.c |   11 +++--------
 1 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/alc5623.c b/sound/soc/codecs/alc5623.c
index 6a9b621..3feee56 100644
--- a/sound/soc/codecs/alc5623.c
+++ b/sound/soc/codecs/alc5623.c
@@ -1022,7 +1022,8 @@ static int alc5623_i2c_probe(struct i2c_client *client,
 
 	dev_dbg(&client->dev, "Found codec id : alc56%02x\n", vid2);
 
-	alc5623 = kzalloc(sizeof(struct alc5623_priv), GFP_KERNEL);
+	alc5623 = devm_kzalloc(&client->dev, sizeof(struct alc5623_priv),
+			       GFP_KERNEL);
 	if (alc5623 == NULL)
 		return -ENOMEM;
 
@@ -1044,7 +1045,6 @@ static int alc5623_i2c_probe(struct i2c_client *client,
 		alc5623_dai.name = "alc5623-hifi";
 		break;
 	default:
-		kfree(alc5623);
 		return -EINVAL;
 	}
 
@@ -1053,20 +1053,15 @@ static int alc5623_i2c_probe(struct i2c_client *client,
 
 	ret =  snd_soc_register_codec(&client->dev,
 		&soc_codec_device_alc5623, &alc5623_dai, 1);
-	if (ret != 0) {
+	if (ret != 0)
 		dev_err(&client->dev, "Failed to register codec: %d\n", ret);
-		kfree(alc5623);
-	}
 
 	return ret;
 }
 
 static int alc5623_i2c_remove(struct i2c_client *client)
 {
-	struct alc5623_priv *alc5623 = i2c_get_clientdata(client);
-
 	snd_soc_unregister_codec(&client->dev);
-	kfree(alc5623);
 	return 0;
 }
 
-- 
1.7.5.4
