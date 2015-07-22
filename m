From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] ASoC: cs4349: Remove unneeded NULL test for
 cs4349->reset_gpio
Date: Wed, 22 Jul 2015 09:59:47 +0800
Message-ID: <1437530387.24723.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f54.google.com (mail-pa0-f54.google.com
 [209.85.220.54])
 by alsa0.perex.cz (Postfix) with ESMTP id A9B602605FF
 for <alsa-devel@alsa-project.org>; Wed, 22 Jul 2015 03:59:54 +0200 (CEST)
Received: by pacan13 with SMTP id an13so130948494pac.1
 for <alsa-devel@alsa-project.org>; Tue, 21 Jul 2015 18:59:53 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Tim Howe <tim.howe@cirrus.com>
List-Id: alsa-devel@alsa-project.org

It's safe to call gpiod_set_value_cansleep() with NULL desc.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/cs4349.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/cs4349.c b/sound/soc/codecs/cs4349.c
index a7538ae..852be85 100644
--- a/sound/soc/codecs/cs4349.c
+++ b/sound/soc/codecs/cs4349.c
@@ -300,8 +300,7 @@ static int cs4349_i2c_probe(struct i2c_client *client,
 	if (IS_ERR(cs4349->reset_gpio))
 		return PTR_ERR(cs4349->reset_gpio);
 
-	if (cs4349->reset_gpio)
-		gpiod_set_value_cansleep(cs4349->reset_gpio, 1);
+	gpiod_set_value_cansleep(cs4349->reset_gpio, 1);
 
 	i2c_set_clientdata(client, cs4349);
 
@@ -316,8 +315,7 @@ static int cs4349_i2c_remove(struct i2c_client *client)
 	snd_soc_unregister_codec(&client->dev);
 
 	/* Hold down reset */
-	if (cs4349->reset_gpio)
-		gpiod_set_value_cansleep(cs4349->reset_gpio, 0);
+	gpiod_set_value_cansleep(cs4349->reset_gpio, 0);
 
 	return 0;
 }
@@ -335,8 +333,7 @@ static int cs4349_runtime_suspend(struct device *dev)
 	regcache_cache_only(cs4349->regmap, true);
 
 	/* Hold down reset */
-	if (cs4349->reset_gpio)
-		gpiod_set_value_cansleep(cs4349->reset_gpio, 0);
+	gpiod_set_value_cansleep(cs4349->reset_gpio, 0);
 
 	return 0;
 }
@@ -350,8 +347,7 @@ static int cs4349_runtime_resume(struct device *dev)
 	if (ret < 0)
 		return ret;
 
-	if (cs4349->reset_gpio)
-		gpiod_set_value_cansleep(cs4349->reset_gpio, 1);
+	gpiod_set_value_cansleep(cs4349->reset_gpio, 1);
 
 	regcache_cache_only(cs4349->regmap, false);
 	regcache_sync(cs4349->regmap);
-- 
2.1.0
