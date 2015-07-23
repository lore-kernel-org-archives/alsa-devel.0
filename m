From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/2] ASoC: cs35l32: Remove unneeded NULL test
 for cs35l32->reset_gpio
Date: Thu, 23 Jul 2015 08:29:57 +0800
Message-ID: <1437611397.6620.5.camel@ingics.com>
References: <1437611330.6620.4.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f46.google.com (mail-pa0-f46.google.com
 [209.85.220.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 9E37026559B
 for <alsa-devel@alsa-project.org>; Thu, 23 Jul 2015 02:30:02 +0200 (CEST)
Received: by pachj5 with SMTP id hj5so146794138pac.3
 for <alsa-devel@alsa-project.org>; Wed, 22 Jul 2015 17:30:01 -0700 (PDT)
In-Reply-To: <1437611330.6620.4.camel@ingics.com>
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
Cc: Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>
List-Id: alsa-devel@alsa-project.org

It's safe to call gpiod_set_value_cansleep() with NULL desc.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/cs35l32.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/cs35l32.c b/sound/soc/codecs/cs35l32.c
index 7e7d243..203c720 100644
--- a/sound/soc/codecs/cs35l32.c
+++ b/sound/soc/codecs/cs35l32.c
@@ -441,8 +441,7 @@ static int cs35l32_i2c_probe(struct i2c_client *i2c_client,
 	if (IS_ERR(cs35l32->reset_gpio))
 		return PTR_ERR(cs35l32->reset_gpio);
 
-	if (cs35l32->reset_gpio)
-		gpiod_set_value_cansleep(cs35l32->reset_gpio, 1);
+	gpiod_set_value_cansleep(cs35l32->reset_gpio, 1);
 
 	/* initialize codec */
 	ret = regmap_read(cs35l32->regmap, CS35L32_DEVID_AB, &reg);
@@ -536,8 +535,7 @@ static int cs35l32_i2c_remove(struct i2c_client *i2c_client)
 	snd_soc_unregister_codec(&i2c_client->dev);
 
 	/* Hold down reset */
-	if (cs35l32->reset_gpio)
-		gpiod_set_value_cansleep(cs35l32->reset_gpio, 0);
+	gpiod_set_value_cansleep(cs35l32->reset_gpio, 0);
 
 	return 0;
 }
@@ -551,8 +549,7 @@ static int cs35l32_runtime_suspend(struct device *dev)
 	regcache_mark_dirty(cs35l32->regmap);
 
 	/* Hold down reset */
-	if (cs35l32->reset_gpio)
-		gpiod_set_value_cansleep(cs35l32->reset_gpio, 0);
+	gpiod_set_value_cansleep(cs35l32->reset_gpio, 0);
 
 	/* remove power */
 	regulator_bulk_disable(ARRAY_SIZE(cs35l32->supplies),
@@ -575,8 +572,7 @@ static int cs35l32_runtime_resume(struct device *dev)
 		return ret;
 	}
 
-	if (cs35l32->reset_gpio)
-		gpiod_set_value_cansleep(cs35l32->reset_gpio, 1);
+	gpiod_set_value_cansleep(cs35l32->reset_gpio, 1);
 
 	regcache_cache_only(cs35l32->regmap, false);
 	regcache_sync(cs35l32->regmap);
-- 
2.1.0
