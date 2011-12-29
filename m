From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 10/14] ASoC: Convert tlv320aic23 to
	devm_kzalloc()
Date: Thu, 29 Dec 2011 12:07:30 +0800
Message-ID: <1325131650.19977.14.camel@phoenix>
References: <1325130983.19977.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 35DBE24651
	for <alsa-devel@alsa-project.org>; Thu, 29 Dec 2011 05:07:37 +0100 (CET)
Received: by ggnv5 with SMTP id v5so8433189ggn.38
	for <alsa-devel@alsa-project.org>; Wed, 28 Dec 2011 20:07:36 -0800 (PST)
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
Cc: Brown <broonie@opensource.wolfsonmicro.com>, Arun KS <arunks@mistralsolutions.com>, Liam Girdwood <lrg@ti.com>, Mark@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/tlv320aic23.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic23.c b/sound/soc/codecs/tlv320aic23.c
index 60d08aea..dfa41a9 100644
--- a/sound/soc/codecs/tlv320aic23.c
+++ b/sound/soc/codecs/tlv320aic23.c
@@ -634,7 +634,7 @@ static int tlv320aic23_codec_probe(struct i2c_client *i2c,
 	if (!i2c_check_functionality(i2c->adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		return -EINVAL;
 
-	aic23 = kzalloc(sizeof(struct aic23), GFP_KERNEL);
+	aic23 = devm_kzalloc(&i2c->dev, sizeof(struct aic23), GFP_KERNEL);
 	if (aic23 == NULL)
 		return -ENOMEM;
 
@@ -643,14 +643,11 @@ static int tlv320aic23_codec_probe(struct i2c_client *i2c,
 
 	ret =  snd_soc_register_codec(&i2c->dev,
 			&soc_codec_dev_tlv320aic23, &tlv320aic23_dai, 1);
-	if (ret < 0)
-		kfree(aic23);
 	return ret;
 }
 static int __exit tlv320aic23_i2c_remove(struct i2c_client *i2c)
 {
 	snd_soc_unregister_codec(&i2c->dev);
-	kfree(i2c_get_clientdata(i2c));
 	return 0;
 }
 
-- 
1.7.5.4
