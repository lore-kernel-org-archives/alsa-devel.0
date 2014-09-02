From: Xavier Hsu <xavier.hsu@linaro.org>
Subject: [PATCHv3 7/9] WM8971 improves the function of regmap
Date: Tue,  2 Sep 2014 11:30:46 +0800
Message-ID: <1409628648-13732-7-git-send-email-xavier.hsu@linaro.org>
References: <1409628648-13732-1-git-send-email-xavier.hsu@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from Kraken (unknown [124.219.7.128])
 by alsa0.perex.cz (Postfix) with ESMTP id D04C4265476
 for <alsa-devel@alsa-project.org>; Tue,  2 Sep 2014 05:30:55 +0200 (CEST)
In-Reply-To: <1409628648-13732-1-git-send-email-xavier.hsu@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, patches@linaro.org
Cc: Xavier Hsu <xavier.hsu@linaro.org>, ckeepax@opensource.wolfsonmicro.com, lars@metafoo.de, Andy Green <andy.green@linaro.org>
List-Id: alsa-devel@alsa-project.org

This patch improves WM8971.
We modify the function of regmap.

Any comments about improving the patch are welcome.
Thanks.

Signed-off-by: Xavier Hsu <xavier.hsu@linaro.org>
Signed-off-by: Andy Green <andy.green@linaro.org>
---
 sound/soc/codecs/wm8971.c |   26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/wm8971.c b/sound/soc/codecs/wm8971.c
index 68b4f52..95e7c39 100755
--- a/sound/soc/codecs/wm8971.c
+++ b/sound/soc/codecs/wm8971.c
@@ -38,6 +38,7 @@
 
 /* codec private data */
 struct wm8971_priv {
+	struct regmap *regmap;
 	unsigned int sysclk;
 	struct snd_pcm_hw_constraint_list *sysclk_constraints;
 	int playback_fs;
@@ -716,6 +717,7 @@ static int wm8971_mute(struct snd_soc_dai *dai, int mute)
 static int wm8971_set_bias_level(struct snd_soc_codec *codec,
 				 enum snd_soc_bias_level level)
 {
+	struct wm8971_priv *wm8971 = snd_soc_codec_get_drvdata(codec);
 	u16 pwr_reg = snd_soc_read(codec, WM8971_PWR1) & 0xfe3e;
 
 	switch (level) {
@@ -727,7 +729,7 @@ static int wm8971_set_bias_level(struct snd_soc_codec *codec,
 		break;
 	case SND_SOC_BIAS_STANDBY:
 		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF)
-			snd_soc_cache_sync(codec);
+			regcache_sync(wm8971->regmap);
 
 		/* mute dac and set vmid to 500k, enable VREF */
 		snd_soc_write(codec, WM8971_PWR1, pwr_reg | 0x0140);
@@ -774,7 +776,11 @@ static struct snd_soc_dai_driver wm8971_dai = {
 
 static int wm8971_suspend(struct snd_soc_codec *codec)
 {
+	struct wm8971_priv *wm8971 = snd_soc_codec_get_drvdata(codec);
+
 	wm8971_set_bias_level(codec, SND_SOC_BIAS_OFF);
+	regcache_mark_dirty(wm8971->regmap);
+
 	return 0;
 }
 
@@ -797,9 +803,12 @@ static int wm8971_resume(struct snd_soc_codec *codec)
 
 static int wm8971_probe(struct snd_soc_codec *codec)
 {
+	struct wm8971_priv *wm8971 = snd_soc_codec_get_drvdata(codec);
 	int ret = 0;
 	u16 reg;
 
+	codec->control_data = wm8971->regmap;
+
 	wm8971_reset(codec);
 
 	/* charge output caps - set vmid to 5k for quick power up */
@@ -830,12 +839,20 @@ static int wm8971_remove(struct snd_soc_codec *codec)
 	return 0;
 }
 
+struct regmap *wm8971_get_regmap(struct device *dev)
+{
+	struct wm8971_priv *priv = dev_get_drvdata(dev);
+
+	return priv->regmap;
+}
+
 static struct snd_soc_codec_driver soc_codec_dev_wm8971 = {
 	.probe =	wm8971_probe,
 	.remove =	wm8971_remove,
 	.suspend =	wm8971_suspend,
 	.resume =	wm8971_resume,
 	.set_bias_level = wm8971_set_bias_level,
+	.get_regmap =	wm8971_get_regmap,
 
 	.controls = wm8971_snd_controls,
 	.num_controls = ARRAY_SIZE(wm8971_snd_controls),
@@ -859,7 +876,6 @@ static int wm8971_i2c_probe(struct i2c_client *i2c,
 			    const struct i2c_device_id *id)
 {
 	struct wm8971_priv *wm8971;
-	struct regmap *regmap;
 	int ret;
 
 	wm8971 = devm_kzalloc(&i2c->dev, sizeof(struct wm8971_priv),
@@ -867,9 +883,9 @@ static int wm8971_i2c_probe(struct i2c_client *i2c,
 	if (wm8971 == NULL)
 		return -ENOMEM;
 
-	regmap = devm_regmap_init_i2c(i2c, &wm8971_regmap);
-	if (IS_ERR(regmap))
-		return PTR_ERR(regmap);
+	wm8971->regmap = devm_regmap_init_i2c(i2c, &wm8971_regmap);
+	if (IS_ERR(wm8971->regmap))
+		return PTR_ERR(wm8971->regmap);
 
 	i2c_set_clientdata(i2c, wm8971);
 
-- 
1.7.9.5
