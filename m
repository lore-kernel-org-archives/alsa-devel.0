From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH] ASoC: tpa6130a2: unmerge power enable error path from power disable path
Date: Mon, 26 Sep 2016 13:35:50 +0300
Message-ID: <1474886150-16207-1-git-send-email-nikita.yoush@cogentembedded.com>
References: <20160924183110.s4lxuigycpxegamq@sirena.org.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160924183110.s4lxuigycpxegamq@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Helen Koike <helen.koike@collabora.co.uk>, Lars-Peter Clausen <lars@metafoo.de>, Sebastian Reichel <sre@kernel.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Chris Healy <cphealy@gmail.com>, Nikita Yushchenko <nikita.yoush@cogentembedded.com>
List-Id: alsa-devel@alsa-project.org

Code undo operations in power enable errror path explicitly, instead of
reusing power disable path and playing with return values there.

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
I doubt that copying 7 lines into error path is better than having a tiny
logic with return values, but still here it is.

 sound/soc/codecs/tpa6130a2.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/tpa6130a2.c b/sound/soc/codecs/tpa6130a2.c
index 3b6faed91d7e..3712db0881d0 100644
--- a/sound/soc/codecs/tpa6130a2.c
+++ b/sound/soc/codecs/tpa6130a2.c
@@ -71,7 +71,14 @@ static int tpa6130a2_power(struct tpa6130a2_data *data, bool enable)
 		if (ret != 0) {
 			dev_err(data->dev,
 				"Failed to sync registers: %d\n", ret);
-			goto regcache_sync_failed;
+			regcache_cache_only(data->regmap, true);
+			if (data->power_gpio >= 0)
+				gpio_set_value(data->power_gpio, 0);
+			ret2 = regulator_disable(data->supply);
+			if (ret2 != 0)
+				dev_err(data->dev,
+					"Failed to disable supply: %d\n", ret2);
+			return ret;
 		}
 	} else {
 		/* Powered off device does not retain registers. While device
@@ -79,18 +86,17 @@ static int tpa6130a2_power(struct tpa6130a2_data *data, bool enable)
 		 * happen in cache only.
 		 */
 		regcache_mark_dirty(data->regmap);
-regcache_sync_failed:
 		regcache_cache_only(data->regmap, true);
 
 		/* Power off */
 		if (data->power_gpio >= 0)
 			gpio_set_value(data->power_gpio, 0);
 
-		ret2 = regulator_disable(data->supply);
-		if (ret2 != 0) {
+		ret = regulator_disable(data->supply);
+		if (ret != 0) {
 			dev_err(data->dev,
-				"Failed to disable supply: %d\n", ret2);
-			return ret ? ret : ret2;
+				"Failed to disable supply: %d\n", ret);
+			return ret;
 		}
 	}
 
-- 
2.1.4
