From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 07/14] ASoC: Convert rt5631 to devm_kzalloc()
Date: Thu, 29 Dec 2011 12:04:15 +0800
Message-ID: <1325131455.19977.10.camel@phoenix>
References: <1325130983.19977.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51]) by alsa0.perex.cz (Postfix) with ESMTP id E76C724642
	for <alsa-devel@alsa-project.org>; Thu, 29 Dec 2011 05:04:21 +0100 (CET)
Received: by yhjj56 with SMTP id j56so7874747yhj.38
	for <alsa-devel@alsa-project.org>; Wed, 28 Dec 2011 20:04:21 -0800 (PST)
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
Cc: Brown <broonie@opensource.wolfsonmicro.com>, Johnny Hsu <johnnyhsu@realtek.com>, Liam Girdwood <lrg@ti.com>, Mark@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/rt5631.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/rt5631.c b/sound/soc/codecs/rt5631.c
index f6e4f5e..20c324c 100644
--- a/sound/soc/codecs/rt5631.c
+++ b/sound/soc/codecs/rt5631.c
@@ -1724,7 +1724,8 @@ static int rt5631_i2c_probe(struct i2c_client *i2c,
 	struct rt5631_priv *rt5631;
 	int ret;
 
-	rt5631 = kzalloc(sizeof(struct rt5631_priv), GFP_KERNEL);
+	rt5631 = devm_kzalloc(&i2c->dev, sizeof(struct rt5631_priv),
+			      GFP_KERNEL);
 	if (NULL == rt5631)
 		return -ENOMEM;
 
@@ -1732,16 +1733,12 @@ static int rt5631_i2c_probe(struct i2c_client *i2c,
 
 	ret = snd_soc_register_codec(&i2c->dev, &soc_codec_dev_rt5631,
 			rt5631_dai, ARRAY_SIZE(rt5631_dai));
-	if (ret < 0)
-		kfree(rt5631);
-
 	return ret;
 }
 
 static __devexit int rt5631_i2c_remove(struct i2c_client *client)
 {
 	snd_soc_unregister_codec(&client->dev);
-	kfree(i2c_get_clientdata(client));
 	return 0;
 }
 
-- 
1.7.5.4
