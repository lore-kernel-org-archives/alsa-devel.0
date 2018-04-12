From: Peter Rosin <peda@axentia.se>
Subject: [PATCH v2 1/5] ASoC: max9860: fix whitespace issues caused by mindless conversion
Date: Thu, 12 Apr 2018 23:14:33 +0200
Message-ID: <20180412211437.21599-2-peda@axentia.se>
References: <20180412161601.GI9929@sirena.org.uk>
 <20180412211437.21599-1-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180412211437.21599-1-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Long lines and bad alignment disturbs the reading pleasure.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 sound/soc/codecs/max9860.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/max9860.c b/sound/soc/codecs/max9860.c
index 5bbf889ad98e..53448b7b7b28 100644
--- a/sound/soc/codecs/max9860.c
+++ b/sound/soc/codecs/max9860.c
@@ -443,7 +443,8 @@ static int max9860_hw_params(struct snd_pcm_substream *substream,
 		ret = regmap_update_bits(max9860->regmap, MAX9860_AUDIOCLKHIGH,
 					 MAX9860_PLL, MAX9860_PLL);
 		if (ret) {
-			dev_err(component->dev, "Failed to enable PLL: %d\n", ret);
+			dev_err(component->dev, "Failed to enable PLL: %d\n",
+				ret);
 			return ret;
 		}
 	}
@@ -515,7 +516,8 @@ static int max9860_set_bias_level(struct snd_soc_component *component,
 		ret = regmap_update_bits(max9860->regmap, MAX9860_PWRMAN,
 					 MAX9860_SHDN, MAX9860_SHDN);
 		if (ret) {
-			dev_err(component->dev, "Failed to remove SHDN: %d\n", ret);
+			dev_err(component->dev, "Failed to remove SHDN: %d\n",
+				ret);
 			return ret;
 		}
 		break;
@@ -698,7 +700,7 @@ static int max9860_probe(struct i2c_client *i2c,
 	pm_runtime_idle(dev);
 
 	ret = devm_snd_soc_register_component(dev, &max9860_component_driver,
-				     &max9860_dai, 1);
+					      &max9860_dai, 1);
 	if (ret) {
 		dev_err(dev, "Failed to register CODEC: %d\n", ret);
 		goto err_pm;
-- 
2.11.0
