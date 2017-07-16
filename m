From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 6/8] ASoC: cs42l42: Remove unneeded gpiod NULL
	check
Date: Sun, 16 Jul 2017 18:11:11 -0300
Message-ID: <1500239473-14886-6-git-send-email-festevam@gmail.com>
References: <1500239473-14886-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f196.google.com (mail-qk0-f196.google.com
 [209.85.220.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 87CAD266D69
 for <alsa-devel@alsa-project.org>; Sun, 16 Jul 2017 23:11:38 +0200 (CEST)
Received: by mail-qk0-f196.google.com with SMTP id q66so18630618qki.1
 for <alsa-devel@alsa-project.org>; Sun, 16 Jul 2017 14:11:38 -0700 (PDT)
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
 sound/soc/codecs/cs42l42.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index 55e4520..55caf5f 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -1898,8 +1898,7 @@ static int cs42l42_i2c_remove(struct i2c_client *i2c_client)
 	snd_soc_unregister_codec(&i2c_client->dev);
 
 	/* Hold down reset */
-	if (cs42l42->reset_gpio)
-		gpiod_set_value_cansleep(cs42l42->reset_gpio, 0);
+	gpiod_set_value_cansleep(cs42l42->reset_gpio, 0);
 
 	return 0;
 }
@@ -1913,8 +1912,7 @@ static int cs42l42_runtime_suspend(struct device *dev)
 	regcache_mark_dirty(cs42l42->regmap);
 
 	/* Hold down reset */
-	if (cs42l42->reset_gpio)
-		gpiod_set_value_cansleep(cs42l42->reset_gpio, 0);
+	gpiod_set_value_cansleep(cs42l42->reset_gpio, 0);
 
 	/* remove power */
 	regulator_bulk_disable(ARRAY_SIZE(cs42l42->supplies),
@@ -1937,8 +1935,7 @@ static int cs42l42_runtime_resume(struct device *dev)
 		return ret;
 	}
 
-	if (cs42l42->reset_gpio)
-		gpiod_set_value_cansleep(cs42l42->reset_gpio, 1);
+	gpiod_set_value_cansleep(cs42l42->reset_gpio, 1);
 
 	regcache_cache_only(cs42l42->regmap, false);
 	regcache_sync(cs42l42->regmap);
-- 
2.7.4
