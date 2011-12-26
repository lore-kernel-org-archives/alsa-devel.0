From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 08/10] ASoC: Convert lm4857 to devm_kzalloc()
Date: Mon, 26 Dec 2011 20:56:25 +0800
Message-ID: <1324904185.26543.9.camel@phoenix>
References: <1324903728.26543.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 331111038DD
	for <alsa-devel@alsa-project.org>; Mon, 26 Dec 2011 13:56:32 +0100 (CET)
Received: by iaae16 with SMTP id e16so18101605iaa.38
	for <alsa-devel@alsa-project.org>; Mon, 26 Dec 2011 04:56:31 -0800 (PST)
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
 sound/soc/codecs/lm4857.c |   13 ++-----------
 1 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/sound/soc/codecs/lm4857.c b/sound/soc/codecs/lm4857.c
index c387daf..3190392 100644
--- a/sound/soc/codecs/lm4857.c
+++ b/sound/soc/codecs/lm4857.c
@@ -215,7 +215,7 @@ static int __devinit lm4857_i2c_probe(struct i2c_client *i2c,
 	struct lm4857 *lm4857;
 	int ret;
 
-	lm4857 = kzalloc(sizeof(*lm4857), GFP_KERNEL);
+	lm4857 = devm_kzalloc(&i2c->dev, sizeof(*lm4857), GFP_KERNEL);
 	if (!lm4857)
 		return -ENOMEM;
 
@@ -225,21 +225,12 @@ static int __devinit lm4857_i2c_probe(struct i2c_client *i2c,
 
 	ret = snd_soc_register_codec(&i2c->dev, &soc_codec_dev_lm4857, NULL, 0);
 
-	if (ret) {
-		kfree(lm4857);
-		return ret;
-	}
-
-	return 0;
+	return ret;
 }
 
 static int __devexit lm4857_i2c_remove(struct i2c_client *i2c)
 {
-	struct lm4857 *lm4857 = i2c_get_clientdata(i2c);
-
 	snd_soc_unregister_codec(&i2c->dev);
-	kfree(lm4857);
-
 	return 0;
 }
 
-- 
1.7.5.4
