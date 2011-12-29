From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 02/14] ASoC: Convert cs4270 to devm_kzalloc()
Date: Thu, 29 Dec 2011 11:58:22 +0800
Message-ID: <1325131102.19977.4.camel@phoenix>
References: <1325130983.19977.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id C5F6824636
	for <alsa-devel@alsa-project.org>; Thu, 29 Dec 2011 04:58:29 +0100 (CET)
Received: by ggnv5 with SMTP id v5so8431522ggn.38
	for <alsa-devel@alsa-project.org>; Wed, 28 Dec 2011 19:58:29 -0800 (PST)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Timur Tabi <timur@freescale.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/cs4270.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
index fef0f48..0555366 100644
--- a/sound/soc/codecs/cs4270.c
+++ b/sound/soc/codecs/cs4270.c
@@ -671,7 +671,8 @@ static int cs4270_i2c_probe(struct i2c_client *i2c_client,
 		i2c_client->addr);
 	dev_info(&i2c_client->dev, "hardware revision %X\n", ret & 0xF);
 
-	cs4270 = kzalloc(sizeof(struct cs4270_private), GFP_KERNEL);
+	cs4270 = devm_kzalloc(&i2c_client->dev, sizeof(struct cs4270_private),
+			      GFP_KERNEL);
 	if (!cs4270) {
 		dev_err(&i2c_client->dev, "could not allocate codec\n");
 		return -ENOMEM;
@@ -682,8 +683,6 @@ static int cs4270_i2c_probe(struct i2c_client *i2c_client,
 
 	ret = snd_soc_register_codec(&i2c_client->dev,
 			&soc_codec_device_cs4270, &cs4270_dai, 1);
-	if (ret < 0)
-		kfree(cs4270);
 	return ret;
 }
 
@@ -696,7 +695,6 @@ static int cs4270_i2c_probe(struct i2c_client *i2c_client,
 static int cs4270_i2c_remove(struct i2c_client *i2c_client)
 {
 	snd_soc_unregister_codec(&i2c_client->dev);
-	kfree(i2c_get_clientdata(i2c_client));
 	return 0;
 }
 
-- 
1.7.5.4
