From: Clemens Gruber <clemens.gruber@pqgruber.com>
Subject: [PATCH 5/6] ASoC: sgtl5000: Do not disable regulators in SND_SOC_BIAS_OFF
Date: Tue,  7 Jun 2016 01:14:52 +0200
Message-ID: <20160606231453.19377-6-clemens.gruber@pqgruber.com>
References: <20160606231453.19377-1-clemens.gruber@pqgruber.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160606231453.19377-1-clemens.gruber@pqgruber.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@kernel.org>, Fabio Estevam <festevam@gmail.com>, Eric Nelson <eric@nelint.com>, linux-kernel@vger.kernel.org, Clemens Gruber <clemens.gruber@pqgruber.com>
List-Id: alsa-devel@alsa-project.org

From: Eric Nelson <eric@nelint.com>

Disabling the SGTL5000 through regulators would certainly save more
power than simply disabling the reference voltages as described in the
data sheet, but won't properly restore things on resume.

This driver does not support active regulators. So we simply disable the
reference bias currents.

Signed-off-by: Eric Nelson <eric@nelint.com>
Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
---
 sound/soc/codecs/sgtl5000.c | 35 +++++------------------------------
 1 file changed, 5 insertions(+), 30 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 9f1d51e..b8a2de85 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -761,42 +761,17 @@ static int sgtl5000_pcm_hw_params(struct snd_pcm_substream *substream,
 static int sgtl5000_set_bias_level(struct snd_soc_codec *codec,
 				   enum snd_soc_bias_level level)
 {
-	int ret;
-	struct sgtl5000_priv *sgtl5000 = snd_soc_codec_get_drvdata(codec);
-
 	switch (level) {
 	case SND_SOC_BIAS_ON:
 	case SND_SOC_BIAS_PREPARE:
-		break;
 	case SND_SOC_BIAS_STANDBY:
-		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_OFF) {
-			ret = regulator_bulk_enable(
-						sgtl5000->num_supplies,
-						sgtl5000->supplies);
-			if (ret)
-				return ret;
-			udelay(10);
-
-			regcache_cache_only(sgtl5000->regmap, false);
-
-			ret = regcache_sync(sgtl5000->regmap);
-			if (ret != 0) {
-				dev_err(codec->dev,
-					"Failed to restore cache: %d\n", ret);
-
-				regcache_cache_only(sgtl5000->regmap, true);
-				regulator_bulk_disable(sgtl5000->num_supplies,
-						       sgtl5000->supplies);
-
-				return ret;
-			}
-		}
-
+		snd_soc_update_bits(codec, SGTL5000_CHIP_ANA_POWER,
+				    SGTL5000_REFTOP_POWERUP,
+				    SGTL5000_REFTOP_POWERUP);
 		break;
 	case SND_SOC_BIAS_OFF:
-		regcache_cache_only(sgtl5000->regmap, true);
-		regulator_bulk_disable(sgtl5000->num_supplies,
-				       sgtl5000->supplies);
+		snd_soc_update_bits(codec, SGTL5000_CHIP_ANA_POWER,
+				    SGTL5000_REFTOP_POWERUP, 0);
 		break;
 	}
 
-- 
2.8.3
