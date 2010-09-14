From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH] ASoC: Remove needless codec->bias_level
	assignment to SND_SOC_BIAS_OFF
Date: Tue, 14 Sep 2010 15:24:38 +0300
Message-ID: <1284467078-6164-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id A8507103896
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Sep 2010 14:24:50 +0200 (CEST)
Received: by eye27 with SMTP id 27so2021496eye.38
	for <alsa-devel@alsa-project.org>; Tue, 14 Sep 2010 05:24:50 -0700 (PDT)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

This assignment is done by the snd_soc_register_codec so there is no need
to redo it in probe function of a codec driver.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
I can separate this patch between TI and other codecs but I think this is
trivial enough to be carried either through Mark's or Liam's tree.
---
 sound/soc/codecs/ak4671.c      |    1 -
 sound/soc/codecs/ssm2602.c     |    1 -
 sound/soc/codecs/tlv320dac33.c |    1 -
 sound/soc/codecs/twl4030.c     |    1 -
 sound/soc/codecs/wm8510.c      |    1 -
 sound/soc/codecs/wm8731.c      |    2 --
 sound/soc/codecs/wm8753.c      |    1 -
 sound/soc/codecs/wm8990.c      |    1 -
 8 files changed, 0 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/ak4671.c b/sound/soc/codecs/ak4671.c
index 239f056..24f5f49 100644
--- a/sound/soc/codecs/ak4671.c
+++ b/sound/soc/codecs/ak4671.c
@@ -642,7 +642,6 @@ static int ak4671_probe(struct snd_soc_codec *codec)
 	int ret;
 
 	codec->hw_write = (hw_write_t)i2c_master_send;
-	codec->bias_level = SND_SOC_BIAS_OFF;
 
 	ret = snd_soc_codec_set_cache_io(codec, 8, 8, ak4671->control_type);
 	if (ret < 0) {
diff --git a/sound/soc/codecs/ssm2602.c b/sound/soc/codecs/ssm2602.c
index 67d8c04..6f38d61 100644
--- a/sound/soc/codecs/ssm2602.c
+++ b/sound/soc/codecs/ssm2602.c
@@ -560,7 +560,6 @@ static int ssm2602_probe(struct snd_soc_codec *codec)
 
 	pr_info("ssm2602 Audio Codec %s", SSM2602_VERSION);
 
-	codec->bias_level = SND_SOC_BIAS_OFF,
 	codec->control_data = ssm2602->control_data;
 
 	ssm2602_reset(codec);
diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index a3c5b52..bf6d01f 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -1385,7 +1385,6 @@ static int dac33_soc_probe(struct snd_soc_codec *codec)
 
 	codec->control_data = dac33->control_data;
 	codec->hw_write = (hw_write_t) i2c_master_send;
-	codec->bias_level = SND_SOC_BIAS_OFF;
 	codec->idle_bias_off = 1;
 	dac33->codec = codec;
 
diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index c7ee1a4..cbebec6 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -2245,7 +2245,6 @@ static int twl4030_soc_probe(struct snd_soc_codec *codec)
 	snd_soc_codec_set_drvdata(codec, twl4030);
 	/* Set the defaults, and power up the codec */
 	twl4030->sysclk = twl4030_codec_get_mclk() / 1000;
-	codec->bias_level = SND_SOC_BIAS_OFF;
 	codec->idle_bias_off = 1;
 
 	twl4030_init_chip(codec);
diff --git a/sound/soc/codecs/wm8510.c b/sound/soc/codecs/wm8510.c
index d00da20..02ecf54 100644
--- a/sound/soc/codecs/wm8510.c
+++ b/sound/soc/codecs/wm8510.c
@@ -569,7 +569,6 @@ static int wm8510_probe(struct snd_soc_codec *codec)
 	wm8510_reset(codec);
 
 	/* power on device */
-	codec->bias_level = SND_SOC_BIAS_OFF;
 	wm8510_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 	snd_soc_add_controls(codec, wm8510_snd_controls,
 				ARRAY_SIZE(wm8510_snd_controls));
diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
index 56f5408..6980ff8 100644
--- a/sound/soc/codecs/wm8731.c
+++ b/sound/soc/codecs/wm8731.c
@@ -488,8 +488,6 @@ static int wm8731_probe(struct snd_soc_codec *codec)
 	struct wm8731_priv *wm8731 = snd_soc_codec_get_drvdata(codec);
 	int ret = 0, i;
 
-	codec->bias_level = SND_SOC_BIAS_OFF,
-
 	ret = snd_soc_codec_set_cache_io(codec, 7, 9, wm8731->control_type);
 	if (ret < 0) {
 		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
diff --git a/sound/soc/codecs/wm8753.c b/sound/soc/codecs/wm8753.c
index 4a945d3..6c0ff35 100644
--- a/sound/soc/codecs/wm8753.c
+++ b/sound/soc/codecs/wm8753.c
@@ -1550,7 +1550,6 @@ static int wm8753_probe(struct snd_soc_codec *codec)
 	struct wm8753_priv *wm8753 = snd_soc_codec_get_drvdata(codec);
 	int ret = 0, reg;
 
-	codec->bias_level = SND_SOC_BIAS_OFF;
 	INIT_DELAYED_WORK(&codec->delayed_work, wm8753_work);
 
 	ret = snd_soc_codec_set_cache_io(codec, 7, 9, wm8753->control_type);
diff --git a/sound/soc/codecs/wm8990.c b/sound/soc/codecs/wm8990.c
index 0ffecbd..264828e 100644
--- a/sound/soc/codecs/wm8990.c
+++ b/sound/soc/codecs/wm8990.c
@@ -1354,7 +1354,6 @@ static int wm8990_probe(struct snd_soc_codec *codec)
 	wm8990_reset(codec);
 
 	/* charge output caps */
-	codec->bias_level = SND_SOC_BIAS_OFF;
 	wm8990_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
 	reg = snd_soc_read(codec, WM8990_AUDIO_INTERFACE_4);
-- 
1.7.1
