From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: Set idle_bias_off flag in
	snd_soc_codec_driver
Date: Fri, 27 Jan 2012 18:02:09 +0800
Message-ID: <1327658529.10143.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id E3E721038E8
	for <alsa-devel@alsa-project.org>; Fri, 27 Jan 2012 11:02:22 +0100 (CET)
Received: by yenl11 with SMTP id l11so716973yen.38
	for <alsa-devel@alsa-project.org>; Fri, 27 Jan 2012 02:02:22 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, Steve@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Vladimir Barinov <vova.barinov@gmail.com>, Harsha Priya <priya.harsha@intel.com>, Liam Girdwood <lrg@ti.com>, Sakoman <steve@sakoman.com>
List-Id: alsa-devel@alsa-project.org

Since commit 33c5f969 "ASoC: Allow idle_bias_off to be specified in CODEC
drivers", now we can set idle_bias_off flag in struct snd_soc_codec_driver
for devices can unconditionally support idle_bias_off.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Vinod Koul <vinod.koul@intel.com>
Cc: Harsha Priya <priya.harsha@intel.com>
Cc: Vladimir Barinov <vova.barinov@gmail.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Steve Sakoman <steve@sakoman.com>
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/adau1373.c    |    3 +--
 sound/soc/codecs/adau1701.c    |    2 +-
 sound/soc/codecs/sn95031.c     |    3 +--
 sound/soc/codecs/tlv320aic3x.c |    2 +-
 sound/soc/codecs/tlv320dac33.c |    2 +-
 sound/soc/codecs/twl4030.c     |    2 +-
 sound/soc/codecs/wm8770.c      |    3 +--
 sound/soc/codecs/wm8804.c      |    2 +-
 sound/soc/codecs/wm8904.c      |    2 +-
 sound/soc/codecs/wm8995.c      |    2 +-
 sound/soc/codecs/wm8996.c      |    4 +---
 11 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/sound/soc/codecs/adau1373.c b/sound/soc/codecs/adau1373.c
index 971ba45..facda33 100644
--- a/sound/soc/codecs/adau1373.c
+++ b/sound/soc/codecs/adau1373.c
@@ -1244,8 +1244,6 @@ static int adau1373_probe(struct snd_soc_codec *codec)
 		return ret;
 	}
 
-	codec->dapm.idle_bias_off = true;
-
 	if (pdata) {
 		if (pdata->num_drc > ARRAY_SIZE(pdata->drc_setting))
 			return -EINVAL;
@@ -1340,6 +1338,7 @@ static struct snd_soc_codec_driver adau1373_codec_driver = {
 	.suspend =	adau1373_suspend,
 	.resume =	adau1373_resume,
 	.set_bias_level = adau1373_set_bias_level,
+	.idle_bias_off = true,
 	.reg_cache_size = ARRAY_SIZE(adau1373_default_regs),
 	.reg_cache_default = adau1373_default_regs,
 	.reg_word_size = sizeof(uint8_t),
diff --git a/sound/soc/codecs/adau1701.c b/sound/soc/codecs/adau1701.c
index 6b325ea..78e9ce4 100644
--- a/sound/soc/codecs/adau1701.c
+++ b/sound/soc/codecs/adau1701.c
@@ -457,7 +457,6 @@ static int adau1701_probe(struct snd_soc_codec *codec)
 {
 	int ret;
 
-	codec->dapm.idle_bias_off = 1;
 	codec->control_data = to_i2c_client(codec->dev);
 
 	ret = adau1701_load_firmware(codec);
@@ -473,6 +472,7 @@ static int adau1701_probe(struct snd_soc_codec *codec)
 static struct snd_soc_codec_driver adau1701_codec_drv = {
 	.probe			= adau1701_probe,
 	.set_bias_level		= adau1701_set_bias_level,
+	.idle_bias_off		= true,
 
 	.reg_cache_size		= ADAU1701_NUM_REGS,
 	.reg_word_size		= sizeof(u16),
diff --git a/sound/soc/codecs/sn95031.c b/sound/soc/codecs/sn95031.c
index f99baa0..aa03923 100644
--- a/sound/soc/codecs/sn95031.c
+++ b/sound/soc/codecs/sn95031.c
@@ -827,8 +827,6 @@ static int sn95031_codec_probe(struct snd_soc_codec *codec)
 {
 	pr_debug("codec_probe called\n");
 
-	codec->dapm.idle_bias_off = 1;
-
 	/* PCM interface config
 	 * This sets the pcm rx slot conguration to max 6 slots
 	 * for max 4 dais (2 stereo and 2 mono)
@@ -891,6 +889,7 @@ struct snd_soc_codec_driver sn95031_codec = {
 	.read		= sn95031_read,
 	.write		= sn95031_write,
 	.set_bias_level	= sn95031_set_vaud_bias,
+	.idle_bias_off	= true,
 	.dapm_widgets	= sn95031_dapm_widgets,
 	.num_dapm_widgets	= ARRAY_SIZE(sn95031_dapm_widgets),
 	.dapm_routes	= sn95031_audio_map,
diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 492f22f..285b7a2 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -1377,7 +1377,6 @@ static int aic3x_probe(struct snd_soc_codec *codec)
 
 	INIT_LIST_HEAD(&aic3x->list);
 	aic3x->codec = codec;
-	codec->dapm.idle_bias_off = 1;
 
 	ret = snd_soc_codec_set_cache_io(codec, 8, 8, aic3x->control_type);
 	if (ret != 0) {
@@ -1471,6 +1470,7 @@ static int aic3x_remove(struct snd_soc_codec *codec)
 
 static struct snd_soc_codec_driver soc_codec_dev_aic3x = {
 	.set_bias_level = aic3x_set_bias_level,
+	.idle_bias_off = true,
 	.reg_cache_size = ARRAY_SIZE(aic3x_reg),
 	.reg_word_size = sizeof(u8),
 	.reg_cache_default = aic3x_reg,
diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index c06c3e4..2c957c8 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -1395,7 +1395,6 @@ static int dac33_soc_probe(struct snd_soc_codec *codec)
 
 	codec->control_data = dac33->control_data;
 	codec->hw_write = (hw_write_t) i2c_master_send;
-	codec->dapm.idle_bias_off = 1;
 	dac33->codec = codec;
 
 	/* Read the tlv320dac33 ID registers */
@@ -1476,6 +1475,7 @@ static struct snd_soc_codec_driver soc_codec_dev_tlv320dac33 = {
 	.read = dac33_read_reg_cache,
 	.write = dac33_write_locked,
 	.set_bias_level = dac33_set_bias_level,
+	.idle_bias_off = true,
 	.reg_cache_size = ARRAY_SIZE(dac33_reg),
 	.reg_word_size = sizeof(u8),
 	.reg_cache_default = dac33_reg,
diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index a193f5f..3039ba2 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -2227,7 +2227,6 @@ static int twl4030_soc_probe(struct snd_soc_codec *codec)
 	snd_soc_codec_set_drvdata(codec, twl4030);
 	/* Set the defaults, and power up the codec */
 	twl4030->sysclk = twl4030_audio_get_mclk() / 1000;
-	codec->dapm.idle_bias_off = 1;
 
 	twl4030_init_chip(codec);
 
@@ -2253,6 +2252,7 @@ static struct snd_soc_codec_driver soc_codec_dev_twl4030 = {
 	.read = twl4030_read_reg_cache,
 	.write = twl4030_write,
 	.set_bias_level = twl4030_set_bias_level,
+	.idle_bias_off = true,
 	.reg_cache_size = sizeof(twl4030_reg),
 	.reg_word_size = sizeof(u8),
 	.reg_cache_default = twl4030_reg,
diff --git a/sound/soc/codecs/wm8770.c b/sound/soc/codecs/wm8770.c
index 19374a9..bd60f84 100644
--- a/sound/soc/codecs/wm8770.c
+++ b/sound/soc/codecs/wm8770.c
@@ -580,8 +580,6 @@ static int wm8770_probe(struct snd_soc_codec *codec)
 	wm8770 = snd_soc_codec_get_drvdata(codec);
 	wm8770->codec = codec;
 
-	codec->dapm.idle_bias_off = 1;
-
 	ret = snd_soc_codec_set_cache_io(codec, 7, 9, wm8770->control_type);
 	if (ret < 0) {
 		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
@@ -679,6 +677,7 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8770 = {
 	.suspend = wm8770_suspend,
 	.resume = wm8770_resume,
 	.set_bias_level = wm8770_set_bias_level,
+	.idle_bias_off = true,
 	.reg_cache_size = ARRAY_SIZE(wm8770_reg_defs),
 	.reg_word_size = sizeof (u16),
 	.reg_cache_default = wm8770_reg_defs
diff --git a/sound/soc/codecs/wm8804.c b/sound/soc/codecs/wm8804.c
index 8abe375..7ee8dcf 100644
--- a/sound/soc/codecs/wm8804.c
+++ b/sound/soc/codecs/wm8804.c
@@ -549,7 +549,6 @@ static int wm8804_probe(struct snd_soc_codec *codec)
 
 	wm8804 = snd_soc_codec_get_drvdata(codec);
 
-	codec->dapm.idle_bias_off = 1;
 	codec->control_data = wm8804->regmap;
 
 	ret = snd_soc_codec_set_cache_io(codec, 8, 8, SND_SOC_REGMAP);
@@ -678,6 +677,7 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8804 = {
 	.suspend = wm8804_suspend,
 	.resume = wm8804_resume,
 	.set_bias_level = wm8804_set_bias_level,
+	.idle_bias_off = true,
 
 	.controls = wm8804_snd_controls,
 	.num_controls = ARRAY_SIZE(wm8804_snd_controls),
diff --git a/sound/soc/codecs/wm8904.c b/sound/soc/codecs/wm8904.c
index 14afc11..37079ea 100644
--- a/sound/soc/codecs/wm8904.c
+++ b/sound/soc/codecs/wm8904.c
@@ -2088,7 +2088,6 @@ static int wm8904_probe(struct snd_soc_codec *codec)
 	int ret, i;
 
 	codec->cache_sync = 1;
-	codec->dapm.idle_bias_off = 1;
 	codec->control_data = wm8904->regmap;
 
 	switch (wm8904->devtype) {
@@ -2237,6 +2236,7 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8904 = {
 	.suspend =	wm8904_suspend,
 	.resume =	wm8904_resume,
 	.set_bias_level = wm8904_set_bias_level,
+	.idle_bias_off = true,
 };
 
 static const struct regmap_config wm8904_regmap = {
diff --git a/sound/soc/codecs/wm8995.c b/sound/soc/codecs/wm8995.c
index c8aada5..89a8642 100644
--- a/sound/soc/codecs/wm8995.c
+++ b/sound/soc/codecs/wm8995.c
@@ -2047,7 +2047,6 @@ static int wm8995_probe(struct snd_soc_codec *codec)
 	int i;
 	int ret;
 
-	codec->dapm.idle_bias_off = 1;
 	wm8995 = snd_soc_codec_get_drvdata(codec);
 	wm8995->codec = codec;
 
@@ -2241,6 +2240,7 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8995 = {
 	.suspend = wm8995_suspend,
 	.resume = wm8995_resume,
 	.set_bias_level = wm8995_set_bias_level,
+	.idle_bias_off = true,
 };
 
 static struct regmap_config wm8995_regmap = {
diff --git a/sound/soc/codecs/wm8996.c b/sound/soc/codecs/wm8996.c
index c70b7e6..f41e17a 100644
--- a/sound/soc/codecs/wm8996.c
+++ b/sound/soc/codecs/wm8996.c
@@ -2805,7 +2805,6 @@ static int wm8996_probe(struct snd_soc_codec *codec)
 	int ret;
 	struct wm8996_priv *wm8996 = snd_soc_codec_get_drvdata(codec);
 	struct i2c_client *i2c = to_i2c_client(codec->dev);
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	int i, irq_flags;
 
 	wm8996->codec = codec;
@@ -2813,8 +2812,6 @@ static int wm8996_probe(struct snd_soc_codec *codec)
 	init_completion(&wm8996->dcs_done);
 	init_completion(&wm8996->fll_lock);
 
-	dapm->idle_bias_off = true;
-
 	codec->control_data = wm8996->regmap;
 
 	ret = snd_soc_codec_set_cache_io(codec, 16, 16, SND_SOC_REGMAP);
@@ -3068,6 +3065,7 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8996 = {
 	.probe =	wm8996_probe,
 	.remove =	wm8996_remove,
 	.set_bias_level = wm8996_set_bias_level,
+	.idle_bias_off	= true,
 	.seq_notifier = wm8996_seq_notifier,
 	.controls = wm8996_snd_controls,
 	.num_controls = ARRAY_SIZE(wm8996_snd_controls),
-- 
1.7.5.4
