From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 10/10] ASoC: Convert uda1380 to devm_kzalloc()
Date: Mon, 26 Dec 2011 20:58:14 +0800
Message-ID: <1324904294.26543.11.camel@phoenix>
References: <1324903728.26543.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 060CD1038F4
	for <alsa-devel@alsa-project.org>; Mon, 26 Dec 2011 13:58:20 +0100 (CET)
Received: by iaae16 with SMTP id e16so18103547iaa.38
	for <alsa-devel@alsa-project.org>; Mon, 26 Dec 2011 04:58:20 -0800 (PST)
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
Cc: Lars-Peter Clausen <lars@metafoo.de>, Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Mark@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/uda1380.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/uda1380.c b/sound/soc/codecs/uda1380.c
index 8f734d6..4f1b23d 100644
--- a/sound/soc/codecs/uda1380.c
+++ b/sound/soc/codecs/uda1380.c
@@ -803,7 +803,8 @@ static __devinit int uda1380_i2c_probe(struct i2c_client *i2c,
 	struct uda1380_priv *uda1380;
 	int ret;
 
-	uda1380 = kzalloc(sizeof(struct uda1380_priv), GFP_KERNEL);
+	uda1380 = devm_kzalloc(&i2c->dev, sizeof(struct uda1380_priv),
+			       GFP_KERNEL);
 	if (uda1380 == NULL)
 		return -ENOMEM;
 
@@ -812,15 +813,12 @@ static __devinit int uda1380_i2c_probe(struct i2c_client *i2c,
 
 	ret =  snd_soc_register_codec(&i2c->dev,
 			&soc_codec_dev_uda1380, uda1380_dai, ARRAY_SIZE(uda1380_dai));
-	if (ret < 0)
-		kfree(uda1380);
 	return ret;
 }
 
 static int __devexit uda1380_i2c_remove(struct i2c_client *i2c)
 {
 	snd_soc_unregister_codec(&i2c->dev);
-	kfree(i2c_get_clientdata(i2c));
 	return 0;
 }
 
-- 
1.7.5.4
