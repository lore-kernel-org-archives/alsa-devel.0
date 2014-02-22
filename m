From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/2] ASoC: wm8996: Replace codec->control_data
	with wm8996->regmap
Date: Sat, 22 Feb 2014 18:32:04 +0100
Message-ID: <1393090325-10712-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-015.synserver.de (smtp-out-131.synserver.de
 [212.40.185.131])
 by alsa0.perex.cz (Postfix) with ESMTP id 33F0D261B0C
 for <alsa-devel@alsa-project.org>; Sat, 22 Feb 2014 18:31:47 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

With the ongoing component-ization of the ASoC framework and the continuing
migration to using regmap for IO the control_data field of the snd_soc_codec
struct will eventually be removed. Prepare the wm8996 driver for this by using
wm8996->regmap instead of accessing the CODEC's control_data field.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/wm8996.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm8996.c b/sound/soc/codecs/wm8996.c
index 0330165..e2d0dd7 100644
--- a/sound/soc/codecs/wm8996.c
+++ b/sound/soc/codecs/wm8996.c
@@ -1608,8 +1608,8 @@ static int wm8996_set_bias_level(struct snd_soc_codec *codec,
 				msleep(5);
 			}
 
-			regcache_cache_only(codec->control_data, false);
-			regcache_sync(codec->control_data);
+			regcache_cache_only(wm8996->regmap, false);
+			regcache_sync(wm8996->regmap);
 		}
 
 		/* Bypass the MICBIASes for lowest power */
@@ -1620,10 +1620,10 @@ static int wm8996_set_bias_level(struct snd_soc_codec *codec,
 		break;
 
 	case SND_SOC_BIAS_OFF:
-		regcache_cache_only(codec->control_data, true);
+		regcache_cache_only(wm8996->regmap, true);
 		if (wm8996->pdata.ldo_ena >= 0) {
 			gpio_set_value_cansleep(wm8996->pdata.ldo_ena, 0);
-			regcache_cache_only(codec->control_data, true);
+			regcache_cache_only(wm8996->regmap, true);
 		}
 		regulator_bulk_disable(ARRAY_SIZE(wm8996->supplies),
 				       wm8996->supplies);
-- 
1.8.0
