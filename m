From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 09/10] ASoC: Convert tlv320aic32x4 to
	devm_kzalloc()
Date: Mon, 26 Dec 2011 20:57:24 +0800
Message-ID: <1324904244.26543.10.camel@phoenix>
References: <1324903728.26543.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 6AE291038E2
	for <alsa-devel@alsa-project.org>; Mon, 26 Dec 2011 13:57:31 +0100 (CET)
Received: by iaae16 with SMTP id e16so18102673iaa.38
	for <alsa-devel@alsa-project.org>; Mon, 26 Dec 2011 04:57:30 -0800 (PST)
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
Cc: Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Wolfram Sang <w.sang@pengutronix.de>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/tlv320aic32x4.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index 81a26e1..eb401ef 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -709,7 +709,8 @@ static __devinit int aic32x4_i2c_probe(struct i2c_client *i2c,
 	struct aic32x4_priv *aic32x4;
 	int ret;
 
-	aic32x4 = kzalloc(sizeof(struct aic32x4_priv), GFP_KERNEL);
+	aic32x4 = devm_kzalloc(&i2c->dev, sizeof(struct aic32x4_priv),
+			       GFP_KERNEL);
 	if (aic32x4 == NULL)
 		return -ENOMEM;
 
@@ -728,15 +729,12 @@ static __devinit int aic32x4_i2c_probe(struct i2c_client *i2c,
 
 	ret = snd_soc_register_codec(&i2c->dev,
 			&soc_codec_dev_aic32x4, &aic32x4_dai, 1);
-	if (ret < 0)
-		kfree(aic32x4);
 	return ret;
 }
 
 static __devexit int aic32x4_i2c_remove(struct i2c_client *client)
 {
 	snd_soc_unregister_codec(&client->dev);
-	kfree(i2c_get_clientdata(client));
 	return 0;
 }
 
-- 
1.7.5.4
