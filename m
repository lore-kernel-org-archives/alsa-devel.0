From: "Howe, Tim" <Tim.Howe@cirrus.com>
Subject: Re: [PATCH v2] ASoC: cs4349: Add support for Cirrus
	Logic CS4349
Date: Wed, 15 Jul 2015 00:51:41 +0000
Message-ID: <C7829A9AA458CC489F3E44C3D5243399C497BB85@ex1.ad.cirrus.com>
References: <55a5ace1.6267320a.46fe.ffff95ab@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from m0077474.ppops.net (mx0b-001ae601.pphosted.com [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 9D7D5265711
 for <alsa-devel@alsa-project.org>; Wed, 15 Jul 2015 02:51:45 +0200 (CEST)
In-Reply-To: <55a5ace1.6267320a.46fe.ffff95ab@mx.google.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "Austin, Brian" <Brian.Austin@cirrus.com>, "broonie@kernel.org" <broonie@kernel.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Sorry sent the wrong patch.  Resending soon.

Tim

-----Original Message-----
From: timothyc.howe@gmail.com [mailto:timothyc.howe@gmail.com] 
Sent: Tuesday, July 14, 2015 7:44 PM
To: alsa-devel@alsa-project.org
Cc: lgirdwood@gmail.com; broonie@kernel.org; Austin, Brian; Howe, Tim
Subject: [PATCH v2] ASoC: cs4349: Add support for Cirrus Logic CS4349

From: Tim Howe <tim.howe@cirrus.com>

Signed-off-by: Tim Howe <tim.howe@cirrus.com>
---
 sound/soc/codecs/cs4349.c | 27 ++++++++-------------------
 1 file changed, 8 insertions(+), 19 deletions(-)

diff --git a/sound/soc/codecs/cs4349.c b/sound/soc/codecs/cs4349.c index c9a96b6..ee6b676 100644
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
