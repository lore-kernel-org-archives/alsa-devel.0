From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 7/8] ASoC: cs53l30: Remove unneeded gpiod NULL
	check
Date: Sun, 16 Jul 2017 18:11:12 -0300
Message-ID: <1500239473-14886-7-git-send-email-festevam@gmail.com>
References: <1500239473-14886-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f194.google.com (mail-qk0-f194.google.com
 [209.85.220.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 5D8FB266A74
 for <alsa-devel@alsa-project.org>; Sun, 16 Jul 2017 23:11:40 +0200 (CEST)
Received: by mail-qk0-f194.google.com with SMTP id q66so18630665qki.1
 for <alsa-devel@alsa-project.org>; Sun, 16 Jul 2017 14:11:40 -0700 (PDT)
In-Reply-To: <1500239473-14886-1-git-send-email-festevam@gmail.com>
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
Cc: Fabio Estevam <fabio.estevam@nxp.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@nxp.com>

The gpiod API checks for NULL descriptors, so there is no need to
duplicate the check in the driver.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 sound/soc/codecs/cs53l30.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/cs53l30.c b/sound/soc/codecs/cs53l30.c
index 06933a5..92fbe63 100644
--- a/sound/soc/codecs/cs53l30.c
+++ b/sound/soc/codecs/cs53l30.c
@@ -842,8 +842,7 @@ static int cs53l30_mute_stream(struct snd_soc_dai *dai, int mute, int stream)
 {
 	struct cs53l30_private *priv = snd_soc_codec_get_drvdata(dai->codec);
 
-	if (priv->mute_gpio)
-		gpiod_set_value_cansleep(priv->mute_gpio, mute);
+	gpiod_set_value_cansleep(priv->mute_gpio, mute);
 
 	return 0;
 }
@@ -960,8 +959,7 @@ static int cs53l30_i2c_probe(struct i2c_client *client,
 		goto error;
 	}
 
-	if (cs53l30->reset_gpio)
-		gpiod_set_value_cansleep(cs53l30->reset_gpio, 1);
+	gpiod_set_value_cansleep(cs53l30->reset_gpio, 1);
 
 	i2c_set_clientdata(client, cs53l30);
 
@@ -1056,8 +1054,7 @@ static int cs53l30_i2c_remove(struct i2c_client *client)
 	snd_soc_unregister_codec(&client->dev);
 
 	/* Hold down reset */
-	if (cs53l30->reset_gpio)
-		gpiod_set_value_cansleep(cs53l30->reset_gpio, 0);
+	gpiod_set_value_cansleep(cs53l30->reset_gpio, 0);
 
 	regulator_bulk_disable(ARRAY_SIZE(cs53l30->supplies),
 			       cs53l30->supplies);
@@ -1073,8 +1070,7 @@ static int cs53l30_runtime_suspend(struct device *dev)
 	regcache_cache_only(cs53l30->regmap, true);
 
 	/* Hold down reset */
-	if (cs53l30->reset_gpio)
-		gpiod_set_value_cansleep(cs53l30->reset_gpio, 0);
+	gpiod_set_value_cansleep(cs53l30->reset_gpio, 0);
 
 	regulator_bulk_disable(ARRAY_SIZE(cs53l30->supplies),
 			       cs53l30->supplies);
@@ -1094,8 +1090,7 @@ static int cs53l30_runtime_resume(struct device *dev)
 		return ret;
 	}
 
-	if (cs53l30->reset_gpio)
-		gpiod_set_value_cansleep(cs53l30->reset_gpio, 1);
+	gpiod_set_value_cansleep(cs53l30->reset_gpio, 1);
 
 	regcache_cache_only(cs53l30->regmap, false);
 	ret = regcache_sync(cs53l30->regmap);
-- 
2.7.4
