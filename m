From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 12/14] ASoC: Convert tlv320aic3x to
	devm_kzalloc()
Date: Thu, 29 Dec 2011 12:10:04 +0800
Message-ID: <1325131804.19977.17.camel@phoenix>
References: <1325130983.19977.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51]) by alsa0.perex.cz (Postfix) with ESMTP id BFD5F24649
	for <alsa-devel@alsa-project.org>; Thu, 29 Dec 2011 05:10:10 +0100 (CET)
Received: by yhjj56 with SMTP id j56so7875759yhj.38
	for <alsa-devel@alsa-project.org>; Wed, 28 Dec 2011 20:10:10 -0800 (PST)
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
Cc: Vladimir Barinov <vbarinov@embeddedalley.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/tlv320aic3x.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 6f963c5..492f22f 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -1504,7 +1504,7 @@ static int aic3x_i2c_probe(struct i2c_client *i2c,
 	struct aic3x_priv *aic3x;
 	int ret;
 
-	aic3x = kzalloc(sizeof(struct aic3x_priv), GFP_KERNEL);
+	aic3x = devm_kzalloc(&i2c->dev, sizeof(struct aic3x_priv), GFP_KERNEL);
 	if (aic3x == NULL) {
 		dev_err(&i2c->dev, "failed to create private data\n");
 		return -ENOMEM;
@@ -1524,15 +1524,12 @@ static int aic3x_i2c_probe(struct i2c_client *i2c,
 
 	ret = snd_soc_register_codec(&i2c->dev,
 			&soc_codec_dev_aic3x, &aic3x_dai, 1);
-	if (ret < 0)
-		kfree(aic3x);
 	return ret;
 }
 
 static int aic3x_i2c_remove(struct i2c_client *client)
 {
 	snd_soc_unregister_codec(&client->dev);
-	kfree(i2c_get_clientdata(client));
 	return 0;
 }
 
-- 
1.7.5.4
