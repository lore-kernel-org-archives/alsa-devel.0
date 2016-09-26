From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tpa6130a2: unmerge power enable error path from power disable path" to the asoc tree
Date: Mon, 26 Sep 2016 09:15:29 -0700
Message-ID: <E1boYYz-0005Lq-B6@finisterre>
References: <1474886150-16207-1-git-send-email-nikita.yoush@cogentembedded.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1474886150-16207-1-git-send-email-nikita.yoush@cogentembedded.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Helen Koike <helen.koike@collabora.co.uk>, Lars-Peter Clausen <lars@metafoo.de>, Sebastian Reichel <sre@kernel.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Chris Healy <cphealy@gmail.com>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tpa6130a2: unmerge power enable error path from power disable path

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

>From 020eab35390b976e6b93b61805002d3e2cd195de Mon Sep 17 00:00:00 2001
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Date: Mon, 26 Sep 2016 13:35:50 +0300
Subject: [PATCH] ASoC: tpa6130a2: unmerge power enable error path from power
 disable path

Code undo operations in power enable errror path explicitly, instead of
reusing power disable path and playing with return values there.

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
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
2.9.3
