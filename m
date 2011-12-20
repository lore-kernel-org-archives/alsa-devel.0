From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 4/5] ASoC: Convert ak4642 to devm_kzalloc()
Date: Tue, 20 Dec 2011 14:40:12 +0800
Message-ID: <1324363212.5632.4.camel@phoenix>
References: <1324363032.5632.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 68BAF1038E3
	for <alsa-devel@alsa-project.org>; Tue, 20 Dec 2011 07:40:19 +0100 (CET)
Received: by yenr11 with SMTP id r11so459793yen.38
	for <alsa-devel@alsa-project.org>; Mon, 19 Dec 2011 22:40:18 -0800 (PST)
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
Cc: Kuninori Morimoto <morimoto.kuninori@renesas.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Clausen <lars@metafoo.de>, Lars-Peter@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/ak4642.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/ak4642.c b/sound/soc/codecs/ak4642.c
index 9b4ee6c..5ef70b5 100644
--- a/sound/soc/codecs/ak4642.c
+++ b/sound/soc/codecs/ak4642.c
@@ -525,7 +525,8 @@ static __devinit int ak4642_i2c_probe(struct i2c_client *i2c,
 	struct ak4642_priv *ak4642;
 	int ret;
 
-	ak4642 = kzalloc(sizeof(struct ak4642_priv), GFP_KERNEL);
+	ak4642 = devm_kzalloc(&i2c->dev, sizeof(struct ak4642_priv),
+			      GFP_KERNEL);
 	if (!ak4642)
 		return -ENOMEM;
 
@@ -535,15 +536,12 @@ static __devinit int ak4642_i2c_probe(struct i2c_client *i2c,
 	ret =  snd_soc_register_codec(&i2c->dev,
 				(struct snd_soc_codec_driver *)id->driver_data,
 				&ak4642_dai, 1);
-	if (ret < 0)
-		kfree(ak4642);
 	return ret;
 }
 
 static __devexit int ak4642_i2c_remove(struct i2c_client *client)
 {
 	snd_soc_unregister_codec(&client->dev);
-	kfree(i2c_get_clientdata(client));
 	return 0;
 }
 
-- 
1.7.5.4
