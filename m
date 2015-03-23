From: Howard Mitchell <hm@hmbedded.co.uk>
Subject: [PATCH] ASoC: pcm512x: Remove hardcoding of pll-lock to GPIO4
Date: Mon, 23 Mar 2015 21:17:01 +0000
Message-ID: <1427145421-5544-1-git-send-email-hm@hmbedded.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, peda@axentia.se
Cc: tiwai@suse.de, lgirdwood@gmail.com, perex@perex.cz, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Howard Mitchell <hm@hmbedded.co.uk>
List-Id: alsa-devel@alsa-project.org

Currently GPIO4 is hardcoded to output the pll-lock signal.
Unfortunately this is after the pll-out GPIO is configured which
is selectable in the device tree. Therefore it is not possible to
use GPIO4 for pll-out. Therefore this patch removes the
configuration of GPIO4.

Signed-off-by: Howard Mitchell <hm@hmbedded.co.uk>
---
 sound/soc/codecs/pcm512x.c |   19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/sound/soc/codecs/pcm512x.c b/sound/soc/codecs/pcm512x.c
index 8472099..5a30fdd 100644
--- a/sound/soc/codecs/pcm512x.c
+++ b/sound/soc/codecs/pcm512x.c
@@ -1296,25 +1296,6 @@ static int pcm512x_hw_params(struct snd_pcm_substream *substream,
 				ret, pcm512x->pll_out);
 			return ret;
 		}
-
-		gpio = PCM512x_G1OE << (4 - 1);
-		ret = regmap_update_bits(pcm512x->regmap, PCM512x_GPIO_EN,
-					 gpio, gpio);
-		if (ret != 0) {
-			dev_err(codec->dev, "Failed to enable gpio %d: %d\n",
-				4, ret);
-			return ret;
-		}
-
-		gpio = PCM512x_GPIO_OUTPUT_1 + 4 - 1;
-		ret = regmap_update_bits(pcm512x->regmap, gpio,
-					 PCM512x_GxSL, PCM512x_GxSL_PLLLK);
-		if (ret != 0) {
-			dev_err(codec->dev,
-				"Failed to output pll lock on %d: %d\n",
-				ret, 4);
-			return ret;
-		}
 	}
 
 	ret = regmap_update_bits(pcm512x->regmap, PCM512x_SYNCHRONIZE,
-- 
1.7.9.5
