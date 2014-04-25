From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 1/4] ASoC: tlv320dac3: Use
	devm_regulator_bulk_get()
Date: Thu, 24 Apr 2014 22:27:03 -0300
Message-ID: <1398389226-18569-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yh0-f54.google.com (mail-yh0-f54.google.com
 [209.85.213.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 10539265324
 for <alsa-devel@alsa-project.org>; Fri, 25 Apr 2014 03:27:27 +0200 (CEST)
Received: by mail-yh0-f54.google.com with SMTP id b6so211023yha.13
 for <alsa-devel@alsa-project.org>; Thu, 24 Apr 2014 18:27:27 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Using devm_regulator_bulk_get() can make the code cleaner and smaller as we
do not need to call regulator_bulk_free() in the error and remove paths.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/codecs/tlv320dac33.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index 517055a..df3a750 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -1540,7 +1540,7 @@ static int dac33_i2c_probe(struct i2c_client *client,
 	for (i = 0; i < ARRAY_SIZE(dac33->supplies); i++)
 		dac33->supplies[i].supply = dac33_supply_names[i];
 
-	ret = regulator_bulk_get(&client->dev, ARRAY_SIZE(dac33->supplies),
+	ret = devm_regulator_bulk_get(&client->dev, ARRAY_SIZE(dac33->supplies),
 				 dac33->supplies);
 
 	if (ret != 0) {
@@ -1551,11 +1551,9 @@ static int dac33_i2c_probe(struct i2c_client *client,
 	ret = snd_soc_register_codec(&client->dev,
 			&soc_codec_dev_tlv320dac33, &dac33_dai, 1);
 	if (ret < 0)
-		goto err_register;
+		goto err_get;
 
 	return ret;
-err_register:
-	regulator_bulk_free(ARRAY_SIZE(dac33->supplies), dac33->supplies);
 err_get:
 	if (dac33->power_gpio >= 0)
 		gpio_free(dac33->power_gpio);
@@ -1573,8 +1571,6 @@ static int dac33_i2c_remove(struct i2c_client *client)
 	if (dac33->power_gpio >= 0)
 		gpio_free(dac33->power_gpio);
 
-	regulator_bulk_free(ARRAY_SIZE(dac33->supplies), dac33->supplies);
-
 	snd_soc_unregister_codec(&client->dev);
 	return 0;
 }
-- 
1.8.3.2
