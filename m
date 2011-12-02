From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Convert WM8903 to devm_kzalloc()
Date: Fri,  2 Dec 2011 18:16:22 +0000
Message-ID: <1322849782-13276-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A4FF6243D4
	for <alsa-devel@alsa-project.org>; Fri,  2 Dec 2011 19:16:25 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8903.c |    7 +++----
 sound/soc/codecs/wm8960.c |   23 ++++++++++++++++-------
 2 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index 12dae43..fa44c9a 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -2281,7 +2281,8 @@ static __devinit int wm8903_i2c_probe(struct i2c_client *i2c,
 	struct wm8903_priv *wm8903;
 	int ret;
 
-	wm8903 = kzalloc(sizeof(struct wm8903_priv), GFP_KERNEL);
+	wm8903 = devm_kzalloc(&i2c->dev,  sizeof(struct wm8903_priv),
+			      GFP_KERNEL);
 	if (wm8903 == NULL)
 		return -ENOMEM;
 
@@ -2290,15 +2291,13 @@ static __devinit int wm8903_i2c_probe(struct i2c_client *i2c,
 
 	ret = snd_soc_register_codec(&i2c->dev,
 			&soc_codec_dev_wm8903, &wm8903_dai, 1);
-	if (ret < 0)
-		kfree(wm8903);
+
 	return ret;
 }
 
 static __devexit int wm8903_i2c_remove(struct i2c_client *client)
 {
 	snd_soc_unregister_codec(&client->dev);
-	kfree(i2c_get_clientdata(client));
 	return 0;
 }
 
diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index ed2773f..4393394 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -14,6 +14,7 @@
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/i2c.h>
+#include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -71,6 +72,7 @@ static const u16 wm8960_reg[WM8960_CACHEREGNUM] = {
 
 struct wm8960_priv {
 	enum snd_soc_control_type control_type;
+	void *control_data;
 	int (*set_bias_level)(struct snd_soc_codec *,
 			      enum snd_soc_bias_level level);
 	struct snd_soc_dapm_widget *lout1;
@@ -264,7 +266,7 @@ SND_SOC_DAPM_INPUT("RINPUT2"),
 SND_SOC_DAPM_INPUT("LINPUT3"),
 SND_SOC_DAPM_INPUT("RINPUT3"),
 
-SND_SOC_DAPM_SUPPLY("MICB", WM8960_POWER1, 1, 0, NULL, 0),
+SND_SOC_DAPM_MICBIAS("MICB", WM8960_POWER1, 1, 0),
 
 SND_SOC_DAPM_MIXER("Left Boost Mixer", WM8960_POWER1, 5, 0,
 		   wm8960_lin_boost, ARRAY_SIZE(wm8960_lin_boost)),
@@ -573,8 +575,6 @@ static int wm8960_set_bias_level_out3(struct snd_soc_codec *codec,
 
 	case SND_SOC_BIAS_STANDBY:
 		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF) {
-			snd_soc_cache_sync(codec);
-
 			/* Enable anti-pop features */
 			snd_soc_write(codec, WM8960_APOP1,
 				      WM8960_POBCTRL | WM8960_SOFT_ST |
@@ -677,9 +677,6 @@ static int wm8960_set_bias_level_capless(struct snd_soc_codec *codec,
 					    WM8960_VREF | WM8960_VMID_MASK, 0);
 			break;
 
-		case SND_SOC_BIAS_OFF:
-			snd_soc_cache_sync(codec);
-			break;
 		default:
 			break;
 		}
@@ -868,7 +865,7 @@ static int wm8960_set_bias_level(struct snd_soc_codec *codec,
 	(SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE | \
 	SNDRV_PCM_FMTBIT_S24_LE)
 
-static const struct snd_soc_dai_ops wm8960_dai_ops = {
+static struct snd_soc_dai_ops wm8960_dai_ops = {
 	.hw_params = wm8960_hw_params,
 	.digital_mute = wm8960_mute,
 	.set_fmt = wm8960_set_dai_fmt,
@@ -905,6 +902,16 @@ static int wm8960_suspend(struct snd_soc_codec *codec, pm_message_t state)
 static int wm8960_resume(struct snd_soc_codec *codec)
 {
 	struct wm8960_priv *wm8960 = snd_soc_codec_get_drvdata(codec);
+	int i;
+	u8 data[2];
+	u16 *cache = codec->reg_cache;
+
+	/* Sync reg_cache with the hardware */
+	for (i = 0; i < ARRAY_SIZE(wm8960_reg); i++) {
+		data[0] = (i << 1) | ((cache[i] >> 8) & 0x0001);
+		data[1] = cache[i] & 0x00ff;
+		codec->hw_write(codec->control_data, data, 2);
+	}
 
 	wm8960->set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 	return 0;
@@ -918,6 +925,7 @@ static int wm8960_probe(struct snd_soc_codec *codec)
 	u16 reg;
 
 	wm8960->set_bias_level = wm8960_set_bias_level_out3;
+	codec->control_data = wm8960->control_data;
 
 	if (!pdata) {
 		dev_warn(codec->dev, "No platform data supplied\n");
@@ -1007,6 +1015,7 @@ static __devinit int wm8960_i2c_probe(struct i2c_client *i2c,
 
 	i2c_set_clientdata(i2c, wm8960);
 	wm8960->control_type = SND_SOC_I2C;
+	wm8960->control_data = i2c;
 
 	ret = snd_soc_register_codec(&i2c->dev,
 			&soc_codec_dev_wm8960, &wm8960_dai, 1);
-- 
1.7.7.3
