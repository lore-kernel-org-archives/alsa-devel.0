From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 2/5] ASoC: Convert ak4535 to devm_kzalloc()
Date: Tue, 20 Dec 2011 14:38:09 +0800
Message-ID: <1324363089.5632.2.camel@phoenix>
References: <1324363032.5632.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 377231038BD
	for <alsa-devel@alsa-project.org>; Tue, 20 Dec 2011 07:38:16 +0100 (CET)
Received: by ghrr11 with SMTP id r11so4015948ghr.38
	for <alsa-devel@alsa-project.org>; Mon, 19 Dec 2011 22:38:15 -0800 (PST)
In-Reply-To: <1324363032.5632.1.camel@phoenix>
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
Cc: Brown <broonie@opensource.wolfsonmicro.com>, Richard Purdie <rpurdie@rpsys.net>, Liam Girdwood <lrg@ti.com>, Lars-Peter Clausen <lars@metafoo.de>, Mark@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/ak4535.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/ak4535.c b/sound/soc/codecs/ak4535.c
index 96296fd..9e809e0 100644
--- a/sound/soc/codecs/ak4535.c
+++ b/sound/soc/codecs/ak4535.c
@@ -416,7 +416,8 @@ static __devinit int ak4535_i2c_probe(struct i2c_client *i2c,
 	struct ak4535_priv *ak4535;
 	int ret;
 
-	ak4535 = kzalloc(sizeof(struct ak4535_priv), GFP_KERNEL);
+	ak4535 = devm_kzalloc(&i2c->dev, sizeof(struct ak4535_priv),
+			      GFP_KERNEL);
 	if (ak4535 == NULL)
 		return -ENOMEM;
 
@@ -425,15 +426,12 @@ static __devinit int ak4535_i2c_probe(struct i2c_client *i2c,
 
 	ret = snd_soc_register_codec(&i2c->dev,
 			&soc_codec_dev_ak4535, &ak4535_dai, 1);
-	if (ret < 0)
-		kfree(ak4535);
 	return ret;
 }
 
 static __devexit int ak4535_i2c_remove(struct i2c_client *client)
 {
 	snd_soc_unregister_codec(&client->dev);
-	kfree(i2c_get_clientdata(client));
 	return 0;
 }
 
-- 
1.7.5.4
