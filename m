From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tpa6130a2: fix volume setting when no
	stream is running" to the asoc tree
Date: Sat, 24 Sep 2016 22:58:32 -0700
Message-ID: <E1bo2SO-0002yo-Fd@finisterre>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4A7D52665B0
 for <alsa-devel@alsa-project.org>; Sun, 25 Sep 2016 07:58:50 +0200 (CEST)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tpa6130a2: fix volume setting when no stream is running

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From a114580f8f3e5bdefc14d75d6c3ba7032210b980 Mon Sep 17 00:00:00 2001
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Date: Thu, 22 Sep 2016 13:10:40 +0300
Subject: [PATCH] ASoC: tpa6130a2: fix volume setting when no stream is running

After moving tpa6130a2 power management to DAPM, if chip can be physically
powered off (either reset_gpio is defined, or regulator indeed removes
power), then volume change no longer works unless chip is on due to
a running stream.

Fix that by entering regcache cache_only mode while chip is off.

Move regcache calls to tpa6130a2_power() to get them at driver init time
as well.

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tpa6130a2.c | 49 +++++++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 23 deletions(-)

diff --git a/sound/soc/codecs/tpa6130a2.c b/sound/soc/codecs/tpa6130a2.c
index f1ea052a822e..3b6faed91d7e 100644
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
2.9.3
