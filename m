From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH] ASoC: tpa6130a2: fix volume setting when no stream is running
Date: Thu, 22 Sep 2016 13:10:40 +0300
Message-ID: <1474539040-25347-1-git-send-email-nikita.yoush@cogentembedded.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Helen Koike <helen.koike@collabora.co.uk>, Lars-Peter Clausen <lars@metafoo.de>, Sebastian Reichel <sre@kernel.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Chris Healy <cphealy@gmail.com>, Nikita Yushchenko <nikita.yoush@cogentembedded.com>
List-Id: alsa-devel@alsa-project.org

After moving tpa6130a2 power management to DAPM, if chip can be physically
powered off (either reset_gpio is defined, or regulator indeed removes
power), then volume change no longer works unless chip is on due to
a running stream.

Fix that by entering regcache cache_only mode while chip is off.

Move regcache calls to tpa6130a2_power() to get them at driver init time
as well.

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 sound/soc/codecs/tpa6130a2.c | 49 +++++++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 23 deletions(-)

diff --git a/sound/soc/codecs/tpa6130a2.c b/sound/soc/codecs/tpa6130a2.c
index f1ea052..3b6faed 100644
--- a/sound/soc/codecs/tpa6130a2.c
+++ b/sound/soc/codecs/tpa6130a2.c
@@ -52,7 +52,7 @@ struct tpa6130a2_data {
 
 static int tpa6130a2_power(struct tpa6130a2_data *data, bool enable)
 {
-	int ret;
+	int ret = 0, ret2;
 
 	if (enable) {
 		ret = regulator_enable(data->supply);
@@ -64,20 +64,34 @@ static int tpa6130a2_power(struct tpa6130a2_data *data, bool enable)
 		/* Power on */
 		if (data->power_gpio >= 0)
 			gpio_set_value(data->power_gpio, 1);
+
+		/* Sync registers */
+		regcache_cache_only(data->regmap, false);
+		ret = regcache_sync(data->regmap);
+		if (ret != 0) {
+			dev_err(data->dev,
+				"Failed to sync registers: %d\n", ret);
+			goto regcache_sync_failed;
+		}
 	} else {
+		/* Powered off device does not retain registers. While device
+		 * is off, any register updates (i.e. volume changes) should
+		 * happen in cache only.
+		 */
+		regcache_mark_dirty(data->regmap);
+regcache_sync_failed:
+		regcache_cache_only(data->regmap, true);
+
 		/* Power off */
 		if (data->power_gpio >= 0)
 			gpio_set_value(data->power_gpio, 0);
 
-		ret = regulator_disable(data->supply);
-		if (ret != 0) {
+		ret2 = regulator_disable(data->supply);
+		if (ret2 != 0) {
 			dev_err(data->dev,
-				"Failed to disable supply: %d\n", ret);
-			return ret;
+				"Failed to disable supply: %d\n", ret2);
+			return ret ? ret : ret2;
 		}
-
-		/* device regs does not match the cache state anymore */
-		regcache_mark_dirty(data->regmap);
 	}
 
 	return ret;
@@ -88,25 +102,14 @@ static int tpa6130a2_power_event(struct snd_soc_dapm_widget *w,
 {
 	struct snd_soc_component *c = snd_soc_dapm_to_component(w->dapm);
 	struct tpa6130a2_data *data = snd_soc_component_get_drvdata(c);
-	int ret;
 
-	/* before widget power up */
 	if (SND_SOC_DAPM_EVENT_ON(event)) {
-		/* Turn on the chip */
-		tpa6130a2_power(data, true);
-		/* Sync the registers */
-		ret = regcache_sync(data->regmap);
-		if (ret < 0) {
-			dev_err(c->dev, "Failed to initialize chip\n");
-			tpa6130a2_power(data, false);
-			return ret;
-		}
-	/* after widget power down */
+		/* Before widget power up: turn chip on, sync registers */
+		return tpa6130a2_power(data, true);
 	} else {
-		tpa6130a2_power(data, false);
+		/* After widget power down: turn chip off */
+		return tpa6130a2_power(data, false);
 	}
-
-	return 0;
 }
 
 /*
-- 
2.1.4
