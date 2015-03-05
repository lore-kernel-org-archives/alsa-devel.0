From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 3/3] ASoC: wm8804: Fix small issues in probe
	error paths
Date: Thu,  5 Mar 2015 15:39:22 +0000
Message-ID: <1425569962-14285-3-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1425569962-14285-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0FF2D260527
 for <alsa-devel@alsa-project.org>; Thu,  5 Mar 2015 16:40:47 +0100 (CET)
In-Reply-To: <1425569962-14285-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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
Cc: patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, info@crazy-audio.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patch fixes some small issues on the probe error paths. Firstly,
fail probe if we can't register the regulator notifiers as this
will cause the cache to never be synchronised which will result in odd
behaviour if the regulators are controllable. Secondly, we don't need to
call regulator_bulk_disable if the enable fails, because the regulator
core will handle this clean up for us. Finally, we need to disable the
regulators if snd_soc_register_codecs fails.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8804.c |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm8804.c b/sound/soc/codecs/wm8804.c
index 7804ddf..f44da83 100644
--- a/sound/soc/codecs/wm8804.c
+++ b/sound/soc/codecs/wm8804.c
@@ -609,6 +609,7 @@ int wm8804_probe(struct device *dev, struct regmap *regmap)
 			dev_err(dev,
 				"Failed to register regulator notifier: %d\n",
 				ret);
+			return ret;
 		}
 	}
 
@@ -616,7 +617,7 @@ int wm8804_probe(struct device *dev, struct regmap *regmap)
 				    wm8804->supplies);
 	if (ret) {
 		dev_err(dev, "Failed to enable supplies: %d\n", ret);
-		goto err_reg_enable;
+		return ret;
 	}
 
 	ret = regmap_read(regmap, WM8804_RST_DEVID1, &id1);
@@ -653,8 +654,14 @@ int wm8804_probe(struct device *dev, struct regmap *regmap)
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
-- 
1.7.2.5
