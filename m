From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 09/14] ASoC: Convert sta32x to devm_kzalloc()
Date: Thu, 29 Dec 2011 12:06:39 +0800
Message-ID: <1325131599.19977.13.camel@phoenix>
References: <1325130983.19977.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 9F30824603
	for <alsa-devel@alsa-project.org>; Thu, 29 Dec 2011 05:06:45 +0100 (CET)
Received: by yenr11 with SMTP id r11so3918350yen.38
	for <alsa-devel@alsa-project.org>; Wed, 28 Dec 2011 20:06:45 -0800 (PST)
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
Cc: Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Mark@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/sta32x.c |   13 ++++---------
 1 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/sta32x.c b/sound/soc/codecs/sta32x.c
index 6648af6..fbd1450 100644
--- a/sound/soc/codecs/sta32x.c
+++ b/sound/soc/codecs/sta32x.c
@@ -968,28 +968,23 @@ static __devinit int sta32x_i2c_probe(struct i2c_client *i2c,
 	struct sta32x_priv *sta32x;
 	int ret;
 
-	sta32x = kzalloc(sizeof(struct sta32x_priv), GFP_KERNEL);
+	sta32x = devm_kzalloc(&i2c->dev, sizeof(struct sta32x_priv),
+			      GFP_KERNEL);
 	if (!sta32x)
 		return -ENOMEM;
 
 	i2c_set_clientdata(i2c, sta32x);
 
 	ret = snd_soc_register_codec(&i2c->dev, &sta32x_codec, &sta32x_dai, 1);
-	if (ret != 0) {
+	if (ret != 0)
 		dev_err(&i2c->dev, "Failed to register codec (%d)\n", ret);
-		kfree(sta32x);
-		return ret;
-	}
 
-	return 0;
+	return ret;
 }
 
 static __devexit int sta32x_i2c_remove(struct i2c_client *client)
 {
-	struct sta32x_priv *sta32x = i2c_get_clientdata(client);
-
 	snd_soc_unregister_codec(&client->dev);
-	kfree(sta32x);
 	return 0;
 }
 
-- 
1.7.5.4
