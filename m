From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 03/14] ASoC: Convert cs42l51 to devm_kzalloc()
Date: Thu, 29 Dec 2011 12:00:13 +0800
Message-ID: <1325131213.19977.6.camel@phoenix>
References: <1325130983.19977.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id C39852463F
	for <alsa-devel@alsa-project.org>; Thu, 29 Dec 2011 05:00:19 +0100 (CET)
Received: by ggnv5 with SMTP id v5so8431836ggn.38
	for <alsa-devel@alsa-project.org>; Wed, 28 Dec 2011 20:00:19 -0800 (PST)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Arnaud Patard <arnaud.patard@rtp-net.org>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/cs42l51.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/cs42l51.c b/sound/soc/codecs/cs42l51.c
index ffce9f2..a8bf588 100644
--- a/sound/soc/codecs/cs42l51.c
+++ b/sound/soc/codecs/cs42l51.c
@@ -577,7 +577,8 @@ static int cs42l51_i2c_probe(struct i2c_client *i2c_client,
 	dev_info(&i2c_client->dev, "found device cs42l51 rev %d\n",
 				ret & 7);
 
-	cs42l51 = kzalloc(sizeof(struct cs42l51_private), GFP_KERNEL);
+	cs42l51 = devm_kzalloc(&i2c_client->dev, sizeof(struct cs42l51_private),
+			       GFP_KERNEL);
 	if (!cs42l51) {
 		dev_err(&i2c_client->dev, "could not allocate codec\n");
 		return -ENOMEM;
@@ -588,18 +589,13 @@ static int cs42l51_i2c_probe(struct i2c_client *i2c_client,
 
 	ret =  snd_soc_register_codec(&i2c_client->dev,
 			&soc_codec_device_cs42l51, &cs42l51_dai, 1);
-	if (ret < 0)
-		kfree(cs42l51);
 error:
 	return ret;
 }
 
 static int cs42l51_i2c_remove(struct i2c_client *client)
 {
-	struct cs42l51_private *cs42l51 = i2c_get_clientdata(client);
-
 	snd_soc_unregister_codec(&client->dev);
-	kfree(cs42l51);
 	return 0;
 }
 
-- 
1.7.5.4
