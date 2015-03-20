From: Howard Mitchell <hm@hmbedded.co.uk>
Subject: [PATCH] ASoC:pcm512x: Make PLL lock output selectable via device tree.
Date: Fri, 20 Mar 2015 21:22:43 +0000
Message-ID: <1426886563-10936-1-git-send-email-hm@hmbedded.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, peda@axentia.se
Cc: tiwai@suse.de, lgirdwood@gmail.com, perex@perex.cz, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Howard Mitchell <hm@hmbedded.co.uk>
List-Id: alsa-devel@alsa-project.org

Currently the PLL Lock output signal is hardcoded to GPIO4. This
makes it seletable in the same way as pll-in and pll-out.

Signed-off-by: Howard Mitchell <hm@hmbedded.co.uk>
---
 .../devicetree/bindings/sound/pcm512x.txt          |    3 ++
 sound/soc/codecs/pcm512x.c                         |   47 +++++++++++++-------
 2 files changed, 33 insertions(+), 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/pcm512x.txt b/Documentation/devicetree/bindings/sound/pcm512x.txt
index 3aae3b4..432f186 100644
--- a/Documentation/devicetree/bindings/sound/pcm512x.txt
+++ b/Documentation/devicetree/bindings/sound/pcm512x.txt
@@ -26,6 +26,8 @@ Optional properties:
     given pll-in pin and PLL output on the given pll-out pin.  An
     external connection from the pll-out pin to the SCLK pin is assumed.
 
+  - pll-lock : gpio pin used to output the PLL lock flag.
+
 Examples:
 
 	pcm5122: pcm5122@4c {
@@ -49,4 +51,5 @@ Examples:
 		clocks = <&sck>;
 		pll-in = <3>;
 		pll-out = <6>;
+		pll-lock = <4>;
 	};
diff --git a/sound/soc/codecs/pcm512x.c b/sound/soc/codecs/pcm512x.c
index 8472099..a4217d7 100644
--- a/sound/soc/codecs/pcm512x.c
+++ b/sound/soc/codecs/pcm512x.c
@@ -49,6 +49,7 @@ struct pcm512x_priv {
 	int fmt;
 	int pll_in;
 	int pll_out;
+	int pll_lock;
 	int pll_r;
 	int pll_j;
 	int pll_d;
@@ -1296,24 +1297,26 @@ static int pcm512x_hw_params(struct snd_pcm_substream *substream,
 				ret, pcm512x->pll_out);
 			return ret;
 		}
+	}
 
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
+	if (pcm512x->pll_lock) {
+                gpio = PCM512x_G1OE << (pcm512x->pll_lock - 1);
+                ret = regmap_update_bits(pcm512x->regmap, PCM512x_GPIO_EN,
+                                         gpio, gpio);
+                if (ret != 0) {
+                        dev_err(codec->dev, "Failed to enable gpio %d: %d\n",
+                                pcm512x->pll_lock, ret);
+                        return ret;
+                }
+
+                gpio = PCM512x_GPIO_OUTPUT_1 + pcm512x->pll_lock - 1;
+                ret = regmap_update_bits(pcm512x->regmap, gpio,
+                                         PCM512x_GxSL, PCM512x_GxSL_PLLLK);
+                if (ret != 0) {
+                        dev_err(codec->dev,
+                                "Failed to output pll lock on %d: %d\n",
+                                ret, pcm512x->pll_lock);
+                        return ret;
 		}
 	}
 
@@ -1518,6 +1521,16 @@ int pcm512x_probe(struct device *dev, struct regmap *regmap)
 			ret = -EINVAL;
 			goto err_clk;
 		}
+
+                if (of_property_read_u32(np, "pll-lock", &val) >= 0) {
+                        if (val > 6) {
+                                dev_err(dev, "Invalid pll-lock\n");
+                                ret = -EINVAL;
+                                goto err_clk;
+                        }
+                        pcm512x->pll_lock = val;
+                }
+
 	}
 #endif
 
-- 
1.7.9.5
