From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 06/14] ASoC: Convert max9850 to devm_kzalloc()
Date: Thu, 29 Dec 2011 12:03:16 +0800
Message-ID: <1325131396.19977.9.camel@phoenix>
References: <1325130983.19977.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 5B9FD24642
	for <alsa-devel@alsa-project.org>; Thu, 29 Dec 2011 05:03:23 +0100 (CET)
Received: by ggnv5 with SMTP id v5so8432411ggn.38
	for <alsa-devel@alsa-project.org>; Wed, 28 Dec 2011 20:03:22 -0800 (PST)
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
Cc: Christian Glindkamp <christian.glindkamp@taskit.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/max9850.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/max9850.c b/sound/soc/codecs/max9850.c
index 47060d2..a191309 100644
--- a/sound/soc/codecs/max9850.c
+++ b/sound/soc/codecs/max9850.c
@@ -335,7 +335,8 @@ static int __devinit max9850_i2c_probe(struct i2c_client *i2c,
 	struct max9850_priv *max9850;
 	int ret;
 
-	max9850 = kzalloc(sizeof(struct max9850_priv), GFP_KERNEL);
+	max9850 = devm_kzalloc(&i2c->dev, sizeof(struct max9850_priv),
+			       GFP_KERNEL);
 	if (max9850 == NULL)
 		return -ENOMEM;
 
@@ -343,15 +344,12 @@ static int __devinit max9850_i2c_probe(struct i2c_client *i2c,
 
 	ret = snd_soc_register_codec(&i2c->dev,
 			&soc_codec_dev_max9850, &max9850_dai, 1);
-	if (ret < 0)
-		kfree(max9850);
 	return ret;
 }
 
 static __devexit int max9850_i2c_remove(struct i2c_client *client)
 {
 	snd_soc_unregister_codec(&client->dev);
-	kfree(i2c_get_clientdata(client));
 	return 0;
 }
 
-- 
1.7.5.4
