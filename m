From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: wm8804: Fix small issues in probe
	error path
Date: Mon,  2 Mar 2015 17:57:54 +0000
Message-ID: <1425319075-10400-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0AD352605D7
 for <alsa-devel@alsa-project.org>; Mon,  2 Mar 2015 18:59:10 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, info@crazy-audio.com, lgirdwood@gmail.com, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

The regulator notifiers were not being cleared up on the error path in
wm8804_probe and the nothing was being cleared up if
snd_soc_register_codec failed. This patch fixes these issues.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8804.c |   18 +++++++++++++++---
 1 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm8804.c b/sound/soc/codecs/wm8804.c
index 1bd4ace..6131c2a 100644
--- a/sound/soc/codecs/wm8804.c
+++ b/sound/soc/codecs/wm8804.c
@@ -607,6 +607,7 @@ int wm8804_probe(struct device *dev, struct regmap *regmap)
 			dev_err(dev,
 				"Failed to register regulator notifier: %d\n",
 				ret);
+			return ret;
 		}
 	}
 
@@ -614,7 +615,7 @@ int wm8804_probe(struct device *dev, struct regmap *regmap)
 				    wm8804->supplies);
 	if (ret) {
 		dev_err(dev, "Failed to enable supplies: %d\n", ret);
-		goto err_reg_enable;
+		goto err_reg_notify;
 	}
 
 	ret = regmap_read(regmap, WM8804_RST_DEVID1, &id1);
@@ -651,11 +652,22 @@ int wm8804_probe(struct device *dev, struct regmap *regmap)
 		goto err_reg_enable;
 	}
 
-	return snd_soc_register_codec(dev, &soc_codec_dev_wm8804,
-				      &wm8804_dai, 1);
+	ret = snd_soc_register_codec(dev, &soc_codec_dev_wm8804,
+				     &wm8804_dai, 1);
+	if (ret < 0) {
+		dev_err(dev, "Failed to register CODEC: %d\n", ret);
+		goto err_reg_enable;
+	}
+
+	return 0;
 
 err_reg_enable:
 	regulator_bulk_disable(ARRAY_SIZE(wm8804->supplies), wm8804->supplies);
+err_reg_notify:
+	for (i = 0; i < ARRAY_SIZE(wm8804->supplies); ++i)
+		regulator_unregister_notifier(wm8804->supplies[i].consumer,
+					      &wm8804->disable_nb[i]);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(wm8804_probe);
-- 
1.7.2.5
