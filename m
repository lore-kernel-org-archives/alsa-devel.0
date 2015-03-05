From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 2/3] ASoC: wm8804: Use new devres regulator_register_notifier
Date: Thu,  5 Mar 2015 15:39:21 +0000
Message-ID: <1425569962-14285-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1425569962-14285-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425569962-14285-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: lgirdwood@gmail.com, info@crazy-audio.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

From: Charles Keepax <ckeepax@gmail.com>

This is more idiomatic and also fixes an issue where the notifiers were
being leaked if probe failed.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8804.c |   15 ++++-----------
 1 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/sound/soc/codecs/wm8804.c b/sound/soc/codecs/wm8804.c
index 1bd4ace..7804ddf 100644
--- a/sound/soc/codecs/wm8804.c
+++ b/sound/soc/codecs/wm8804.c
@@ -601,8 +601,10 @@ int wm8804_probe(struct device *dev, struct regmap *regmap)
 
 	/* This should really be moved into the regulator core */
 	for (i = 0; i < ARRAY_SIZE(wm8804->supplies); i++) {
-		ret = regulator_register_notifier(wm8804->supplies[i].consumer,
-						  &wm8804->disable_nb[i]);
+		struct regulator *regulator = wm8804->supplies[i].consumer;
+
+		ret = devm_regulator_register_notifier(regulator,
+						       &wm8804->disable_nb[i]);
 		if (ret != 0) {
 			dev_err(dev,
 				"Failed to register regulator notifier: %d\n",
@@ -662,15 +664,6 @@ EXPORT_SYMBOL_GPL(wm8804_probe);
 
 void wm8804_remove(struct device *dev)
 {
-	struct wm8804_priv *wm8804;
-	int i;
-
-	wm8804 = dev_get_drvdata(dev);
-
-	for (i = 0; i < ARRAY_SIZE(wm8804->supplies); ++i)
-		regulator_unregister_notifier(wm8804->supplies[i].consumer,
-					      &wm8804->disable_nb[i]);
-
 	snd_soc_unregister_codec(dev);
 }
 EXPORT_SYMBOL_GPL(wm8804_remove);
-- 
1.7.2.5
