From: Ma Haijun <mahaijuns@gmail.com>
Subject: [PATCH 2/2] ASoC: wm8960: Fix shared LRCLK support
Date: Wed, 14 Aug 2013 09:15:39 +0800
Message-ID: <1376442946-2803-2-git-send-email-mahaijuns@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Shared LRCLK initialization does not survive wm8960_reset,
so place it after the reset.

Signed-off-by: Ma Haijun <mahaijuns@gmail.com>
---
 sound/soc/codecs/wm8960.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index 368d39f..b606dd3 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -990,6 +990,9 @@ static int wm8960_probe(struct snd_soc_codec *codec)
 
 	wm8960->set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
+	if (pdata && pdata->shared_lrclk)
+		snd_soc_update_bits(codec, WM8960_ADDCTL2, 0x4, 0x4);
+
 	/* Latch the update bits */
 	snd_soc_update_bits(codec, WM8960_LINVOL, 0x100, 0x100);
 	snd_soc_update_bits(codec, WM8960_RINVOL, 0x100, 0x100);
@@ -1041,7 +1044,6 @@ static const struct regmap_config wm8960_regmap = {
 static int wm8960_i2c_probe(struct i2c_client *i2c,
 			    const struct i2c_device_id *id)
 {
-	struct wm8960_data *pdata = dev_get_platdata(&i2c->dev);
 	struct wm8960_priv *wm8960;
 	int ret;
 
@@ -1054,16 +1056,6 @@ static int wm8960_i2c_probe(struct i2c_client *i2c,
 	if (IS_ERR(wm8960->regmap))
 		return PTR_ERR(wm8960->regmap);
 
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
1.8.1.2
