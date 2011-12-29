From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 08/14] ASoC: Convert ssm2602 to devm_kzalloc()
Date: Thu, 29 Dec 2011 12:05:20 +0800
Message-ID: <1325131520.19977.11.camel@phoenix>
References: <1325130983.19977.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 1F25924644
	for <alsa-devel@alsa-project.org>; Thu, 29 Dec 2011 05:05:26 +0100 (CET)
Received: by ggnv5 with SMTP id v5so8432785ggn.38
	for <alsa-devel@alsa-project.org>; Wed, 28 Dec 2011 20:05:26 -0800 (PST)
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
Cc: Lars-Peter Clausen <lars@metafoo.de>, Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Mark@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/ssm2602.c |   12 ++++--------
 1 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/ssm2602.c b/sound/soc/codecs/ssm2602.c
index 7dfc7b0..333dd98 100644
--- a/sound/soc/codecs/ssm2602.c
+++ b/sound/soc/codecs/ssm2602.c
@@ -652,7 +652,8 @@ static int __devinit ssm2602_spi_probe(struct spi_device *spi)
 	struct ssm2602_priv *ssm2602;
 	int ret;
 
-	ssm2602 = kzalloc(sizeof(struct ssm2602_priv), GFP_KERNEL);
+	ssm2602 = devm_kzalloc(&spi->dev, sizeof(struct ssm2602_priv),
+			       GFP_KERNEL);
 	if (ssm2602 == NULL)
 		return -ENOMEM;
 
@@ -662,15 +663,12 @@ static int __devinit ssm2602_spi_probe(struct spi_device *spi)
 
 	ret = snd_soc_register_codec(&spi->dev,
 			&soc_codec_dev_ssm2602, &ssm2602_dai, 1);
-	if (ret < 0)
-		kfree(ssm2602);
 	return ret;
 }
 
 static int __devexit ssm2602_spi_remove(struct spi_device *spi)
 {
 	snd_soc_unregister_codec(&spi->dev);
-	kfree(spi_get_drvdata(spi));
 	return 0;
 }
 
@@ -697,7 +695,8 @@ static int __devinit ssm2602_i2c_probe(struct i2c_client *i2c,
 	struct ssm2602_priv *ssm2602;
 	int ret;
 
-	ssm2602 = kzalloc(sizeof(struct ssm2602_priv), GFP_KERNEL);
+	ssm2602 = devm_kzalloc(&i2c->dev, sizeof(struct ssm2602_priv),
+			       GFP_KERNEL);
 	if (ssm2602 == NULL)
 		return -ENOMEM;
 
@@ -707,15 +706,12 @@ static int __devinit ssm2602_i2c_probe(struct i2c_client *i2c,
 
 	ret = snd_soc_register_codec(&i2c->dev,
 			&soc_codec_dev_ssm2602, &ssm2602_dai, 1);
-	if (ret < 0)
-		kfree(ssm2602);
 	return ret;
 }
 
 static int __devexit ssm2602_i2c_remove(struct i2c_client *client)
 {
 	snd_soc_unregister_codec(&client->dev);
-	kfree(i2c_get_clientdata(client));
 	return 0;
 }
 
-- 
1.7.5.4
