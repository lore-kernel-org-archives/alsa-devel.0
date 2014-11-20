From: Zidan Wang <b50113@freescale.com>
Subject: [alsa-devel][PATCH v2 2/2] ASoC: wm8960: LRCM operation should after software reset
Date: Thu, 20 Nov 2014 16:41:18 +0800
Message-ID: <1416472878-12108-2-git-send-email-b50113@freescale.com>
References: <1416472878-12108-1-git-send-email-b50113@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1416472878-12108-1-git-send-email-b50113@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, lars@metafoo.de, ckeepax@opensource.wolfsonmicro.com, Li.Xiubo@freescale.com, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Zidan Wang <b50113@freescale.com>
List-Id: alsa-devel@alsa-project.org

When shared_lrclk is set, LRCM will be enabled. But the following software
reset in wm8960_probe will reset it to the default state. So LRCM operation
should after software reset.

Signed-off-by: Zidan Wang <b50113@freescale.com>
---
 sound/soc/codecs/wm8960.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index e5d89a2..a7f60b7 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -976,6 +976,14 @@ static int wm8960_probe(struct snd_soc_codec *codec)
 		return ret;
 	}
 
+    if (pdata->shared_lrclk) {
+		ret = snd_soc_update_bits(codec, WM8960_ADDCTL2, 0x4, 0x4);
+		if (ret < 0) {
+			dev_err(codec->dev, "Failed to enable LRCM: %d\n", ret);
+			return ret;
+		}
+	}
+
 	wm8960->set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
 	/* Latch the update bits */
@@ -1059,16 +1067,6 @@ static int wm8960_i2c_probe(struct i2c_client *i2c,
 	else if (i2c->dev.of_node)
 		wm8960_set_pdata_from_of(i2c, &wm8960->pdata);
 
-	if (pdata && pdata->shared_lrclk) {
-		ret = regmap_update_bits(wm8960->regmap, WM8960_ADDCTL2,
-					 0x4, 0x4);
-		if (ret != 0) {
-			dev_err(&i2c->dev, "Failed to enable LRCM: %d\n",
-				ret);
-			return ret;
-		}
-	}
-
 	i2c_set_clientdata(i2c, wm8960);
 
 	ret = snd_soc_register_codec(&i2c->dev,
-- 
1.9.1
