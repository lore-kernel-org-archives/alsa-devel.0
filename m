From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 3/5] ASoC: Convert ak4641 to devm_kzalloc()
Date: Tue, 20 Dec 2011 14:39:20 +0800
Message-ID: <1324363160.5632.3.camel@phoenix>
References: <1324363032.5632.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id A3BBF1038BD
	for <alsa-devel@alsa-project.org>; Tue, 20 Dec 2011 07:39:27 +0100 (CET)
Received: by yenr11 with SMTP id r11so459628yen.38
	for <alsa-devel@alsa-project.org>; Mon, 19 Dec 2011 22:39:26 -0800 (PST)
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
Cc: Mark@alsa-project.org, Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Lars-Peter Clausen <lars@metafoo.de>, Dmitry Artamonow <mad_soft@inbox.ru>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/ak4641.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/ak4641.c b/sound/soc/codecs/ak4641.c
index 9018470..266ebea 100644
--- a/sound/soc/codecs/ak4641.c
+++ b/sound/soc/codecs/ak4641.c
@@ -602,7 +602,8 @@ static int __devinit ak4641_i2c_probe(struct i2c_client *i2c,
 	struct ak4641_priv *ak4641;
 	int ret;
 
-	ak4641 = kzalloc(sizeof(struct ak4641_priv), GFP_KERNEL);
+	ak4641 = devm_kzalloc(&i2c->dev, sizeof(struct ak4641_priv),
+			      GFP_KERNEL);
 	if (!ak4641)
 		return -ENOMEM;
 
@@ -610,16 +611,12 @@ static int __devinit ak4641_i2c_probe(struct i2c_client *i2c,
 
 	ret = snd_soc_register_codec(&i2c->dev, &soc_codec_dev_ak4641,
 				ak4641_dai, ARRAY_SIZE(ak4641_dai));
-	if (ret < 0)
-		kfree(ak4641);
-
 	return ret;
 }
 
 static int __devexit ak4641_i2c_remove(struct i2c_client *i2c)
 {
 	snd_soc_unregister_codec(&i2c->dev);
-	kfree(i2c_get_clientdata(i2c));
 	return 0;
 }
 
-- 
1.7.5.4
