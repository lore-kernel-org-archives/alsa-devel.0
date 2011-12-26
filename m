From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 06/10] ASoC: Convert da7210 to devm_kzalloc()
Date: Mon, 26 Dec 2011 20:54:04 +0800
Message-ID: <1324904044.26543.7.camel@phoenix>
References: <1324903728.26543.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 4A5851038AF
	for <alsa-devel@alsa-project.org>; Mon, 26 Dec 2011 13:54:12 +0100 (CET)
Received: by iaae16 with SMTP id e16so18098845iaa.38
	for <alsa-devel@alsa-project.org>; Mon, 26 Dec 2011 04:54:10 -0800 (PST)
In-Reply-To: <1324903728.26543.1.camel@phoenix>
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, David Dajun Chen <dchen@diasemi.com>, Liam Girdwood <lrg@ti.com>, Ashish Chavan <ashish.chavan@kpitcummins.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/da7210.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/da7210.c b/sound/soc/codecs/da7210.c
index e4ca61c..62e6a9c 100644
--- a/sound/soc/codecs/da7210.c
+++ b/sound/soc/codecs/da7210.c
@@ -944,7 +944,8 @@ static int __devinit da7210_i2c_probe(struct i2c_client *i2c,
 	struct da7210_priv *da7210;
 	int ret;
 
-	da7210 = kzalloc(sizeof(struct da7210_priv), GFP_KERNEL);
+	da7210 = devm_kzalloc(&i2c->dev, sizeof(struct da7210_priv),
+			      GFP_KERNEL);
 	if (!da7210)
 		return -ENOMEM;
 
@@ -953,16 +954,12 @@ static int __devinit da7210_i2c_probe(struct i2c_client *i2c,
 
 	ret =  snd_soc_register_codec(&i2c->dev,
 			&soc_codec_dev_da7210, &da7210_dai, 1);
-	if (ret < 0)
-		kfree(da7210);
-
 	return ret;
 }
 
 static int __devexit da7210_i2c_remove(struct i2c_client *client)
 {
 	snd_soc_unregister_codec(&client->dev);
-	kfree(i2c_get_clientdata(client));
 	return 0;
 }
 
-- 
1.7.5.4
