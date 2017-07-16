From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 4/8] ASoC: cs35l33: Remove unneeded gpiod NULL
	check
Date: Sun, 16 Jul 2017 18:11:09 -0300
Message-ID: <1500239473-14886-4-git-send-email-festevam@gmail.com>
References: <1500239473-14886-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f193.google.com (mail-qk0-f193.google.com
 [209.85.220.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4928C266D49
 for <alsa-devel@alsa-project.org>; Sun, 16 Jul 2017 23:11:34 +0200 (CEST)
Received: by mail-qk0-f193.google.com with SMTP id v17so16284517qka.3
 for <alsa-devel@alsa-project.org>; Sun, 16 Jul 2017 14:11:34 -0700 (PDT)
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
 sound/soc/codecs/cs35l33.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/cs35l33.c b/sound/soc/codecs/cs35l33.c
index 6df29fa..1eea912 100644
--- a/sound/soc/codecs/cs35l33.c
+++ b/sound/soc/codecs/cs35l33.c
@@ -869,8 +869,7 @@ static int __maybe_unused cs35l33_runtime_resume(struct device *dev)
 
 	dev_dbg(dev, "%s\n", __func__);
 
-	if (cs35l33->reset_gpio)
-		gpiod_set_value_cansleep(cs35l33->reset_gpio, 0);
+	gpiod_set_value_cansleep(cs35l33->reset_gpio, 0);
 
 	ret = regulator_bulk_enable(cs35l33->num_core_supplies,
 		cs35l33->core_supplies);
@@ -881,8 +880,7 @@ static int __maybe_unused cs35l33_runtime_resume(struct device *dev)
 
 	regcache_cache_only(cs35l33->regmap, false);
 
-	if (cs35l33->reset_gpio)
-		gpiod_set_value_cansleep(cs35l33->reset_gpio, 1);
+	gpiod_set_value_cansleep(cs35l33->reset_gpio, 1);
 
 	msleep(CS35L33_BOOT_DELAY);
 
@@ -1191,8 +1189,7 @@ static int cs35l33_i2c_probe(struct i2c_client *i2c_client,
 		return ret;
 	}
 
-	if (cs35l33->reset_gpio)
-		gpiod_set_value_cansleep(cs35l33->reset_gpio, 1);
+	gpiod_set_value_cansleep(cs35l33->reset_gpio, 1);
 
 	msleep(CS35L33_BOOT_DELAY);
 	regcache_cache_only(cs35l33->regmap, false);
@@ -1262,8 +1259,7 @@ static int cs35l33_i2c_remove(struct i2c_client *client)
 
 	snd_soc_unregister_codec(&client->dev);
 
-	if (cs35l33->reset_gpio)
-		gpiod_set_value_cansleep(cs35l33->reset_gpio, 0);
+	gpiod_set_value_cansleep(cs35l33->reset_gpio, 0);
 
 	pm_runtime_disable(&client->dev);
 	regulator_bulk_disable(cs35l33->num_core_supplies,
-- 
2.7.4
