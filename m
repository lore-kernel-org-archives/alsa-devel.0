From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 5/5] ASoC: Convert ak4671 to devm_kzalloc()
Date: Tue, 20 Dec 2011 14:41:19 +0800
Message-ID: <1324363279.5632.5.camel@phoenix>
References: <1324363032.5632.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 299031038F9
	for <alsa-devel@alsa-project.org>; Tue, 20 Dec 2011 07:41:26 +0100 (CET)
Received: by yenr11 with SMTP id r11so460034yen.38
	for <alsa-devel@alsa-project.org>; Mon, 19 Dec 2011 22:41:25 -0800 (PST)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/ak4671.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/ak4671.c b/sound/soc/codecs/ak4671.c
index 4f5c69f..a53b152 100644
--- a/sound/soc/codecs/ak4671.c
+++ b/sound/soc/codecs/ak4671.c
@@ -661,7 +661,8 @@ static int __devinit ak4671_i2c_probe(struct i2c_client *client,
 	struct ak4671_priv *ak4671;
 	int ret;
 
-	ak4671 = kzalloc(sizeof(struct ak4671_priv), GFP_KERNEL);
+	ak4671 = devm_kzalloc(&client->dev, sizeof(struct ak4671_priv),
+			      GFP_KERNEL);
 	if (ak4671 == NULL)
 		return -ENOMEM;
 
@@ -670,15 +671,12 @@ static int __devinit ak4671_i2c_probe(struct i2c_client *client,
 
 	ret = snd_soc_register_codec(&client->dev,
 			&soc_codec_dev_ak4671, &ak4671_dai, 1);
-	if (ret < 0)
-		kfree(ak4671);
 	return ret;
 }
 
 static __devexit int ak4671_i2c_remove(struct i2c_client *client)
 {
 	snd_soc_unregister_codec(&client->dev);
-	kfree(i2c_get_clientdata(client));
 	return 0;
 }
 
-- 
1.7.5.4
