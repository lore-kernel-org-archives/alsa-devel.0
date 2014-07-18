From: Dan Murphy <dmurphy@ti.com>
Subject: [PATCH 1/2] ASoC: tas2552: Fix PM sequencing
Date: Fri, 18 Jul 2014 12:31:07 -0500
Message-ID: <1405704668-8038-1-git-send-email-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-sound@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, broonie@kernel.org, Dan Murphy <dmurphy@ti.com>
List-Id: alsa-devel@alsa-project.org

In the pm suspend/resume it is better
to disable the GPIO after the regmap_cache
setting calls so that if the call is interrupted
the new reg values will be cached and set on resume.

Also add pm_runtime_put in the remove call.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 sound/soc/codecs/tas2552.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/tas2552.c b/sound/soc/codecs/tas2552.c
index f0760af..a3ae394 100644
--- a/sound/soc/codecs/tas2552.c
+++ b/sound/soc/codecs/tas2552.c
@@ -239,12 +239,12 @@ static int tas2552_runtime_suspend(struct device *dev)
 
 	tas2552_sw_shutdown(tas2552, 0);
 
-	if (tas2552->enable_gpio)
-		gpiod_set_value(tas2552->enable_gpio, 0);
-
 	regcache_cache_only(tas2552->regmap, true);
 	regcache_mark_dirty(tas2552->regmap);
 
+	if (tas2552->enable_gpio)
+		gpiod_set_value(tas2552->enable_gpio, 0);
+
 	return 0;
 }
 
@@ -382,6 +382,8 @@ static int tas2552_codec_remove(struct snd_soc_codec *codec)
 {
 	struct tas2552_data *tas2552 = snd_soc_codec_get_drvdata(codec);
 
+	pm_runtime_put(codec->dev);
+
 	if (tas2552->enable_gpio)
 		gpiod_set_value(tas2552->enable_gpio, 0);
 
-- 
1.7.9.5
