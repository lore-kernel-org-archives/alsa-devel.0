From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: da732x: Use da732x->regmap instead of
	codec->control_data
Date: Sat, 22 Feb 2014 18:34:45 +0100
Message-ID: <1393090485-10894-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-015.synserver.de (smtp-out-131.synserver.de
 [212.40.185.131])
 by alsa0.perex.cz (Postfix) with ESMTP id D8E1A261B0C
 for <alsa-devel@alsa-project.org>; Sat, 22 Feb 2014 18:34:25 +0100 (CET)
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
Cc: Adam Thomson <Adam.Thomson@diasemi.com>, Lars-Peter Clausen <lars@metafoo.de>, Michal Hajduk <Michal.Hajduk@diasemi.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

With the ongoing component-ization of the ASoC framework and the continuing
migration to using regmap for IO the control_data field of the snd_soc_codec
struct will eventually be removed. Prepare the da732x driver for this by using
da732x->regmap instead of accessing the CODEC's control_data field.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/da732x.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/da732x.c b/sound/soc/codecs/da732x.c
index f295b65..54db45d 100644
--- a/sound/soc/codecs/da732x.c
+++ b/sound/soc/codecs/da732x.c
@@ -1487,8 +1487,8 @@ static int da732x_set_bias_level(struct snd_soc_codec *codec,
 
 			da732x_hp_dc_offset_cancellation(codec);
 
-			regcache_cache_only(codec->control_data, false);
-			regcache_sync(codec->control_data);
+			regcache_cache_only(da732x->regmap, false);
+			regcache_sync(da732x->regmap);
 		} else {
 			snd_soc_update_bits(codec, DA732X_REG_BIAS_EN,
 					    DA732X_BIAS_BOOST_MASK,
@@ -1499,7 +1499,7 @@ static int da732x_set_bias_level(struct snd_soc_codec *codec,
 		}
 		break;
 	case SND_SOC_BIAS_OFF:
-		regcache_cache_only(codec->control_data, true);
+		regcache_cache_only(da732x->regmap, true);
 		da732x_set_charge_pump(codec, DA732X_DISABLE_CP);
 		snd_soc_update_bits(codec, DA732X_REG_BIAS_EN, DA732X_BIAS_EN,
 				    DA732X_BIAS_DIS);
-- 
1.8.0
