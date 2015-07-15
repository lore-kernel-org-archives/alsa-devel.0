From: timothyc.howe@gmail.com
Subject: [PATCH v2] ASoC: cs4349: Add support for Cirrus Logic
	CS4349
Date: Tue, 14 Jul 2015 19:44:11 -0500
Message-ID: <55a5ace1.6267320a.46fe.ffff95ab@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f171.google.com (mail-ig0-f171.google.com
 [209.85.213.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 3EAD9265711
 for <alsa-devel@alsa-project.org>; Wed, 15 Jul 2015 02:44:19 +0200 (CEST)
Received: by iggf3 with SMTP id f3so24885322igg.1
 for <alsa-devel@alsa-project.org>; Tue, 14 Jul 2015 17:44:18 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: brian.austin@cirrus.com, broonie@kernel.org, lgirdwood@gmail.com, Tim Howe <tim.howe@cirrus.com>
List-Id: alsa-devel@alsa-project.org

From: Tim Howe <tim.howe@cirrus.com>

Signed-off-by: Tim Howe <tim.howe@cirrus.com>
---
 sound/soc/codecs/cs4349.c | 27 ++++++++-------------------
 1 file changed, 8 insertions(+), 19 deletions(-)

diff --git a/sound/soc/codecs/cs4349.c b/sound/soc/codecs/cs4349.c
index c9a96b6..ee6b676 100644
--- a/sound/soc/codecs/cs4349.c
+++ b/sound/soc/codecs/cs4349.c
@@ -305,19 +305,8 @@ static int cs4349_i2c_probe(struct i2c_client *client,
 		return ret;
 	}
 
-	if (pdata) {
+	if (pdata)
 		cs4349->pdata = *pdata;
-	} else {
-		pdata = devm_kzalloc(&client->dev,
-				     sizeof(struct cs4349_platform_data),
-				     GFP_KERNEL);
-		if (!pdata) {
-			dev_err(&client->dev,
-				"could not allocate pdata\n");
-			return -ENOMEM;
-		}
-		cs4349->pdata = *pdata;
-	}
 
 	/* Reset the Device */
 	cs4349->reset_gpio = devm_gpiod_get_optional(&client->dev,
@@ -330,9 +319,6 @@ static int cs4349_i2c_probe(struct i2c_client *client,
 
 	i2c_set_clientdata(client, cs4349);
 
-	dev_info(&client->dev,
-		 "Cirrus Logic CS4349\n");
-
 	return snd_soc_register_codec(&client->dev, &soc_codec_dev_cs4349,
 		&cs4349_dai, 1);
 }
@@ -357,14 +343,17 @@ static int cs4349_runtime_suspend(struct device *dev)
 	struct snd_soc_pcm_runtime *rtd = dev_get_drvdata(dev);
 	int ret;
 
-	/* Hold down reset */
-	if (cs4349->reset_gpio)
-		gpiod_set_value_cansleep(cs4349->reset_gpio, 0);
-
 	ret = snd_soc_update_bits(rtd->codec, CS4349_MISC, PWR_DWN, 1);
 	if (ret < 0)
 		return ret;
 
+	regcache_cache_only(cs4349->regmap, true);
+	regcache_sync(cs4349->regmap);
+
+	/* Hold down reset */
+	if (cs4349->reset_gpio)
+		gpiod_set_value_cansleep(cs4349->reset_gpio, 0);
+
 	return 0;
 }
 
-- 
2.4.5
