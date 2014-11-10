From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 11/11] ASoC: ac97: Push snd_ac97 pointer to the
	driver level
Date: Mon, 10 Nov 2014 22:41:53 +0100
Message-ID: <1415655713-29842-12-git-send-email-lars@metafoo.de>
References: <1415655713-29842-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-111.synserver.de (smtp-out-111.synserver.de
 [212.40.185.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 6AA78261AE7
 for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2014 22:49:09 +0100 (CET)
In-Reply-To: <1415655713-29842-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Stephen Warren <swarren@wwwdotorg.org>, Sangbeom Kim <sbkim73@samsung.com>, patches@opensource.wolfsonmicro.com, Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Li.Xiubo@freescale.com>, Markus Pargmann <mpa@pengutronix.de>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Now that the ASoC core no longer needs a handle to the AC'97 device that is
associated with a CODEC we can remove it from the snd_soc_codec struct and
push it into the individual driver state structs like we do for other
communication buses. Doing so creates a clean separation between the AC'97
bus support and the ASoC core.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc.h         |  5 ++---
 sound/soc/codecs/ac97.c     | 17 +++++++++++++----
 sound/soc/codecs/ad1980.c   | 27 ++++++++++++++++++---------
 sound/soc/codecs/stac9766.c | 38 ++++++++++++++++++++++++--------------
 sound/soc/codecs/wm9705.c   | 31 ++++++++++++++++++++++---------
 sound/soc/codecs/wm9712.c   | 32 +++++++++++++++++++++-----------
 sound/soc/codecs/wm9713.c   | 31 ++++++++++++++++++++-----------
 sound/soc/soc-ac97.c        | 40 +++++++++++++++++++++-------------------
 8 files changed, 141 insertions(+), 80 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 2a3da45..67e9e79 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -498,8 +498,8 @@ int snd_soc_test_bits(struct snd_soc_codec *codec, unsigned int reg,
 				unsigned int mask, unsigned int value);
 
 #ifdef CONFIG_SND_SOC_AC97_BUS
-int snd_soc_new_ac97_codec(struct snd_soc_codec *codec);
-void snd_soc_free_ac97_codec(struct snd_soc_codec *codec);
+struct snd_ac97 *snd_soc_new_ac97_codec(struct snd_soc_codec *codec);
+void snd_soc_free_ac97_codec(struct snd_ac97 *ac97);
 
 int snd_soc_set_ac97_ops(struct snd_ac97_bus_ops *ops);
 int snd_soc_set_ac97_ops_of_reset(struct snd_ac97_bus_ops *ops,
@@ -790,7 +790,6 @@ struct snd_soc_codec {
 	struct list_head card_list;
 
 	/* runtime */
-	struct snd_ac97 *ac97;  /* for ad-hoc ac97 devices */
 	unsigned int cache_bypass:1; /* Suppress access to the cache */
 	unsigned int suspended:1; /* Codec is in suspend PM state */
 	unsigned int cache_init:1; /* codec cache has been initialized */
diff --git a/sound/soc/codecs/ac97.c b/sound/soc/codecs/ac97.c
index 5d90924..c6e5a31 100644
--- a/sound/soc/codecs/ac97.c
+++ b/sound/soc/codecs/ac97.c
@@ -37,10 +37,11 @@ static int ac97_prepare(struct snd_pcm_substream *substream,
 			struct snd_soc_dai *dai)
 {
 	struct snd_soc_codec *codec = dai->codec;
+	struct snd_ac97 *ac97 = snd_soc_codec_get_drvdata(codec);
 
 	int reg = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) ?
 		  AC97_PCM_FRONT_DAC_RATE : AC97_PCM_LR_ADC_RATE;
-	return snd_ac97_set_rate(codec->ac97, reg, substream->runtime->rate);
+	return snd_ac97_set_rate(ac97, reg, substream->runtime->rate);
 }
 
 #define STD_AC97_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 |\
@@ -70,6 +71,7 @@ static struct snd_soc_dai_driver ac97_dai = {
 
 static int ac97_soc_probe(struct snd_soc_codec *codec)
 {
+	struct snd_ac97 *ac97;
 	struct snd_ac97_bus *ac97_bus;
 	struct snd_ac97_template ac97_template;
 	int ret;
@@ -81,24 +83,31 @@ static int ac97_soc_probe(struct snd_soc_codec *codec)
 		return ret;
 
 	memset(&ac97_template, 0, sizeof(struct snd_ac97_template));
-	ret = snd_ac97_mixer(ac97_bus, &ac97_template, &codec->ac97);
+	ret = snd_ac97_mixer(ac97_bus, &ac97_template, &ac97);
 	if (ret < 0)
 		return ret;
 
+	snd_soc_codec_set_drvdata(codec, ac97);
+
 	return 0;
 }
 
 #ifdef CONFIG_PM
 static int ac97_soc_suspend(struct snd_soc_codec *codec)
 {
-	snd_ac97_suspend(codec->ac97);
+	struct snd_ac97 *ac97 = snd_soc_codec_get_drvdata(codec);
+
+	snd_ac97_suspend(ac97);
 
 	return 0;
 }
 
 static int ac97_soc_resume(struct snd_soc_codec *codec)
 {
-	snd_ac97_resume(codec->ac97);
+
+	struct snd_ac97 *ac97 = snd_soc_codec_get_drvdata(codec);
+
+	snd_ac97_resume(ac97);
 
 	return 0;
 }
diff --git a/sound/soc/codecs/ad1980.c b/sound/soc/codecs/ad1980.c
index c6cb101..93bd47d 100644
--- a/sound/soc/codecs/ad1980.c
+++ b/sound/soc/codecs/ad1980.c
@@ -135,6 +135,7 @@ static const struct snd_soc_dapm_route ad1980_dapm_routes[] = {
 static unsigned int ac97_read(struct snd_soc_codec *codec,
 	unsigned int reg)
 {
+	struct snd_ac97 *ac97 = snd_soc_codec_get_drvdata(codec);
 	u16 *cache = codec->reg_cache;
 
 	switch (reg) {
@@ -144,7 +145,7 @@ static unsigned int ac97_read(struct snd_soc_codec *codec,
 	case AC97_EXTENDED_STATUS:
 	case AC97_VENDOR_ID1:
 	case AC97_VENDOR_ID2:
-		return soc_ac97_ops->read(codec->ac97, reg);
+		return soc_ac97_ops->read(ac97, reg);
 	default:
 		reg = reg >> 1;
 
@@ -158,9 +159,10 @@ static unsigned int ac97_read(struct snd_soc_codec *codec,
 static int ac97_write(struct snd_soc_codec *codec, unsigned int reg,
 	unsigned int val)
 {
+	struct snd_ac97 *ac97 = snd_soc_codec_get_drvdata(codec);
 	u16 *cache = codec->reg_cache;
 
-	soc_ac97_ops->write(codec->ac97, reg, val);
+	soc_ac97_ops->write(ac97, reg, val);
 	reg = reg >> 1;
 	if (reg < ARRAY_SIZE(ad1980_reg))
 		cache[reg] = val;
@@ -186,16 +188,17 @@ static struct snd_soc_dai_driver ad1980_dai = {
 
 static int ad1980_reset(struct snd_soc_codec *codec, int try_warm)
 {
+	struct snd_ac97 *ac97 = snd_soc_codec_get_drvdata(codec);
 	unsigned int retry_cnt = 0;
 
 	do {
 		if (try_warm && soc_ac97_ops->warm_reset) {
-			soc_ac97_ops->warm_reset(codec->ac97);
+			soc_ac97_ops->warm_reset(ac97);
 			if (ac97_read(codec, AC97_RESET) == 0x0090)
 				return 1;
 		}
 
-		soc_ac97_ops->reset(codec->ac97);
+		soc_ac97_ops->reset(ac97);
 		/*
 		 * Set bit 16slot in register 74h, then every slot will has only
 		 * 16 bits. This command is sent out in 20bit mode, in which
@@ -215,16 +218,20 @@ static int ad1980_reset(struct snd_soc_codec *codec, int try_warm)
 
 static int ad1980_soc_probe(struct snd_soc_codec *codec)
 {
+	struct snd_ac97 *ac97;
 	int ret;
 	u16 vendor_id2;
 	u16 ext_status;
 
-	ret = snd_soc_new_ac97_codec(codec);
-	if (ret < 0) {
-		dev_err(codec->dev, "Failed to register AC97 codec\n");
+	ac97 = snd_soc_new_ac97_codec(codec);
+	if (IS_ERR(ac97)) {
+		ret = PTR_ERR(ac97);
+		dev_err(codec->dev, "Failed to register AC97 codec: %d\n", ret);
 		return ret;
 	}
 
+	snd_soc_codec_set_drvdata(codec, ac97);
+
 	ret = ad1980_reset(codec, 0);
 	if (ret < 0)
 		goto reset_err;
@@ -261,13 +268,15 @@ static int ad1980_soc_probe(struct snd_soc_codec *codec)
 	return 0;
 
 reset_err:
-	snd_soc_free_ac97_codec(codec);
+	snd_soc_free_ac97_codec(ac97);
 	return ret;
 }
 
 static int ad1980_soc_remove(struct snd_soc_codec *codec)
 {
-	snd_soc_free_ac97_codec(codec);
+	struct snd_ac97 *ac97 = snd_soc_codec_get_drvdata(codec);
+
+	snd_soc_free_ac97_codec(ac97);
 	return 0;
 }
 
diff --git a/sound/soc/codecs/stac9766.c b/sound/soc/codecs/stac9766.c
index 4fb9f1d..dbff0c89 100644
--- a/sound/soc/codecs/stac9766.c
+++ b/sound/soc/codecs/stac9766.c
@@ -139,18 +139,19 @@ static const struct snd_kcontrol_new stac9766_snd_ac97_controls[] = {
 static int stac9766_ac97_write(struct snd_soc_codec *codec, unsigned int reg,
 			       unsigned int val)
 {
+	struct snd_ac97 *ac97 = snd_soc_codec_get_drvdata(codec);
 	u16 *cache = codec->reg_cache;
 
 	if (reg > AC97_STAC_PAGE0) {
 		stac9766_ac97_write(codec, AC97_INT_PAGING, 0);
-		soc_ac97_ops->write(codec->ac97, reg, val);
+		soc_ac97_ops->write(ac97, reg, val);
 		stac9766_ac97_write(codec, AC97_INT_PAGING, 1);
 		return 0;
 	}
 	if (reg / 2 >= ARRAY_SIZE(stac9766_reg))
 		return -EIO;
 
-	soc_ac97_ops->write(codec->ac97, reg, val);
+	soc_ac97_ops->write(ac97, reg, val);
 	cache[reg / 2] = val;
 	return 0;
 }
@@ -158,11 +159,12 @@ static int stac9766_ac97_write(struct snd_soc_codec *codec, unsigned int reg,
 static unsigned int stac9766_ac97_read(struct snd_soc_codec *codec,
 				       unsigned int reg)
 {
+	struct snd_ac97 *ac97 = snd_soc_codec_get_drvdata(codec);
 	u16 val = 0, *cache = codec->reg_cache;
 
 	if (reg > AC97_STAC_PAGE0) {
 		stac9766_ac97_write(codec, AC97_INT_PAGING, 0);
-		val = soc_ac97_ops->read(codec->ac97, reg - AC97_STAC_PAGE0);
+		val = soc_ac97_ops->read(ac97, reg - AC97_STAC_PAGE0);
 		stac9766_ac97_write(codec, AC97_INT_PAGING, 1);
 		return val;
 	}
@@ -173,7 +175,7 @@ static unsigned int stac9766_ac97_read(struct snd_soc_codec *codec,
 		reg == AC97_INT_PAGING || reg == AC97_VENDOR_ID1 ||
 		reg == AC97_VENDOR_ID2) {
 
-		val = soc_ac97_ops->read(codec->ac97, reg);
+		val = soc_ac97_ops->read(ac97, reg);
 		return val;
 	}
 	return cache[reg / 2];
@@ -240,15 +242,17 @@ static int stac9766_set_bias_level(struct snd_soc_codec *codec,
 
 static int stac9766_reset(struct snd_soc_codec *codec, int try_warm)
 {
+	struct snd_ac97 *ac97 = snd_soc_codec_get_drvdata(codec);
+
 	if (try_warm && soc_ac97_ops->warm_reset) {
-		soc_ac97_ops->warm_reset(codec->ac97);
+		soc_ac97_ops->warm_reset(ac97);
 		if (stac9766_ac97_read(codec, 0) == stac9766_reg[0])
 			return 1;
 	}
 
-	soc_ac97_ops->reset(codec->ac97);
+	soc_ac97_ops->reset(ac97);
 	if (soc_ac97_ops->warm_reset)
-		soc_ac97_ops->warm_reset(codec->ac97);
+		soc_ac97_ops->warm_reset(ac97);
 	if (stac9766_ac97_read(codec, 0) != stac9766_reg[0])
 		return -EIO;
 	return 0;
@@ -256,6 +260,7 @@ static int stac9766_reset(struct snd_soc_codec *codec, int try_warm)
 
 static int stac9766_codec_resume(struct snd_soc_codec *codec)
 {
+	struct snd_ac97 *ac97 = snd_soc_codec_get_drvdata(codec);
 	u16 id, reset;
 
 	reset = 0;
@@ -265,8 +270,8 @@ reset:
 		dev_err(codec->dev, "Failed to resume\n");
 		return -EIO;
 	}
-	codec->ac97->bus->ops->warm_reset(codec->ac97);
-	id = soc_ac97_ops->read(codec->ac97, AC97_VENDOR_ID2);
+	ac97->bus->ops->warm_reset(ac97);
+	id = soc_ac97_ops->read(ac97, AC97_VENDOR_ID2);
 	if (id != 0x4c13) {
 		stac9766_reset(codec, 0);
 		reset++;
@@ -325,11 +330,14 @@ static struct snd_soc_dai_driver stac9766_dai[] = {
 
 static int stac9766_codec_probe(struct snd_soc_codec *codec)
 {
+	struct snd_ac97 *ac97;
 	int ret = 0;
 
-	ret = snd_soc_new_ac97_codec(codec);
-	if (ret < 0)
-		goto codec_err;
+	ac97 = snd_soc_new_ac97_codec(codec);
+	if (IS_ERR(ac97))
+		return PTR_ERR(ac97);
+
+	snd_soc_codec_set_drvdata(codec, ac97);
 
 	/* do a cold reset for the controller and then try
 	 * a warm reset followed by an optional cold reset for codec */
@@ -343,13 +351,15 @@ static int stac9766_codec_probe(struct snd_soc_codec *codec)
 	return 0;
 
 codec_err:
-	snd_soc_free_ac97_codec(codec);
+	snd_soc_free_ac97_codec(ac97);
 	return ret;
 }
 
 static int stac9766_codec_remove(struct snd_soc_codec *codec)
 {
-	snd_soc_free_ac97_codec(codec);
+	struct snd_ac97 *ac97 = snd_soc_codec_get_drvdata(codec);
+
+	snd_soc_free_ac97_codec(ac97);
 	return 0;
 }
 
diff --git a/sound/soc/codecs/wm9705.c b/sound/soc/codecs/wm9705.c
index 5b5118b..d3a800f 100644
--- a/sound/soc/codecs/wm9705.c
+++ b/sound/soc/codecs/wm9705.c
@@ -203,13 +203,14 @@ static const struct snd_soc_dapm_route wm9705_audio_map[] = {
 /* We use a register cache to enhance read performance. */
 static unsigned int ac97_read(struct snd_soc_codec *codec, unsigned int reg)
 {
+	struct snd_ac97 *ac97 = snd_soc_codec_get_drvdata(codec);
 	u16 *cache = codec->reg_cache;
 
 	switch (reg) {
 	case AC97_RESET:
 	case AC97_VENDOR_ID1:
 	case AC97_VENDOR_ID2:
-		return soc_ac97_ops->read(codec->ac97, reg);
+		return soc_ac97_ops->read(ac97, reg);
 	default:
 		reg = reg >> 1;
 
@@ -223,9 +224,10 @@ static unsigned int ac97_read(struct snd_soc_codec *codec, unsigned int reg)
 static int ac97_write(struct snd_soc_codec *codec, unsigned int reg,
 	unsigned int val)
 {
+	struct snd_ac97 *ac97 = snd_soc_codec_get_drvdata(codec);
 	u16 *cache = codec->reg_cache;
 
-	soc_ac97_ops->write(codec->ac97, reg, val);
+	soc_ac97_ops->write(ac97, reg, val);
 	reg = reg >> 1;
 	if (reg < (ARRAY_SIZE(wm9705_reg)))
 		cache[reg] = val;
@@ -293,8 +295,10 @@ static struct snd_soc_dai_driver wm9705_dai[] = {
 
 static int wm9705_reset(struct snd_soc_codec *codec)
 {
+	struct snd_ac97 *ac97 = snd_soc_codec_get_drvdata(codec);
+
 	if (soc_ac97_ops->reset) {
-		soc_ac97_ops->reset(codec->ac97);
+		soc_ac97_ops->reset(ac97);
 		if (ac97_read(codec, 0) == wm9705_reg[0])
 			return 0; /* Success */
 	}
@@ -307,13 +311,16 @@ static int wm9705_reset(struct snd_soc_codec *codec)
 #ifdef CONFIG_PM
 static int wm9705_soc_suspend(struct snd_soc_codec *codec)
 {
-	soc_ac97_ops->write(codec->ac97, AC97_POWERDOWN, 0xffff);
+	struct snd_ac97 *ac97 = snd_soc_codec_get_drvdata(codec);
+
+	soc_ac97_ops->write(ac97, AC97_POWERDOWN, 0xffff);
 
 	return 0;
 }
 
 static int wm9705_soc_resume(struct snd_soc_codec *codec)
 {
+	struct snd_ac97 *ac97 = snd_soc_codec_get_drvdata(codec);
 	int i, ret;
 	u16 *cache = codec->reg_cache;
 
@@ -322,7 +329,7 @@ static int wm9705_soc_resume(struct snd_soc_codec *codec)
 		return ret;
 
 	for (i = 2; i < ARRAY_SIZE(wm9705_reg) << 1; i += 2) {
-		soc_ac97_ops->write(codec->ac97, i, cache[i>>1]);
+		soc_ac97_ops->write(ac97, i, cache[i>>1]);
 	}
 
 	return 0;
@@ -334,14 +341,18 @@ static int wm9705_soc_resume(struct snd_soc_codec *codec)
 
 static int wm9705_soc_probe(struct snd_soc_codec *codec)
 {
+	struct snd_ac97 *ac97;
 	int ret = 0;
 
-	ret = snd_soc_new_ac97_codec(codec);
-	if (ret < 0) {
+	ac97 = snd_soc_new_ac97_codec(codec);
+	if (IS_ERR(ac97)) {
+		ret = PTR_ERR(ac97);
 		dev_err(codec->dev, "Failed to register AC97 codec\n");
 		return ret;
 	}
 
+	snd_soc_codec_set_drvdata(codec, ac97);
+
 	ret = wm9705_reset(codec);
 	if (ret)
 		goto reset_err;
@@ -349,13 +360,15 @@ static int wm9705_soc_probe(struct snd_soc_codec *codec)
 	return 0;
 
 reset_err:
-	snd_soc_free_ac97_codec(codec);
+	snd_soc_free_ac97_codec(ac97);
 	return ret;
 }
 
 static int wm9705_soc_remove(struct snd_soc_codec *codec)
 {
-	snd_soc_free_ac97_codec(codec);
+	struct snd_ac97 *ac97 = snd_soc_codec_get_drvdata(codec);
+
+	snd_soc_free_ac97_codec(ac97);
 	return 0;
 }
 
diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
index 9fa794b..52a211b 100644
--- a/sound/soc/codecs/wm9712.c
+++ b/sound/soc/codecs/wm9712.c
@@ -24,6 +24,7 @@
 #include "wm9712.h"
 
 struct wm9712_priv {
+	struct snd_ac97 *ac97;
 	unsigned int hp_mixer[2];
 	struct mutex lock;
 };
@@ -484,12 +485,13 @@ static const struct snd_soc_dapm_route wm9712_audio_map[] = {
 static unsigned int ac97_read(struct snd_soc_codec *codec,
 	unsigned int reg)
 {
+	struct wm9712_priv *wm9712 = snd_soc_codec_get_drvdata(codec);
 	u16 *cache = codec->reg_cache;
 
 	if (reg == AC97_RESET || reg == AC97_GPIO_STATUS ||
 		reg == AC97_VENDOR_ID1 || reg == AC97_VENDOR_ID2 ||
 		reg == AC97_REC_GAIN)
-		return soc_ac97_ops->read(codec->ac97, reg);
+		return soc_ac97_ops->read(wm9712->ac97, reg);
 	else {
 		reg = reg >> 1;
 
@@ -503,9 +505,10 @@ static unsigned int ac97_read(struct snd_soc_codec *codec,
 static int ac97_write(struct snd_soc_codec *codec, unsigned int reg,
 	unsigned int val)
 {
+	struct wm9712_priv *wm9712 = snd_soc_codec_get_drvdata(codec);
 	u16 *cache = codec->reg_cache;
 
-	soc_ac97_ops->write(codec->ac97, reg, val);
+	soc_ac97_ops->write(wm9712->ac97, reg, val);
 	reg = reg >> 1;
 	if (reg < (ARRAY_SIZE(wm9712_reg)))
 		cache[reg] = val;
@@ -613,15 +616,17 @@ static int wm9712_set_bias_level(struct snd_soc_codec *codec,
 
 static int wm9712_reset(struct snd_soc_codec *codec, int try_warm)
 {
+	struct wm9712_priv *wm9712 = snd_soc_codec_get_drvdata(codec);
+
 	if (try_warm && soc_ac97_ops->warm_reset) {
-		soc_ac97_ops->warm_reset(codec->ac97);
+		soc_ac97_ops->warm_reset(wm9712->ac97);
 		if (ac97_read(codec, 0) == wm9712_reg[0])
 			return 1;
 	}
 
-	soc_ac97_ops->reset(codec->ac97);
+	soc_ac97_ops->reset(wm9712->ac97);
 	if (soc_ac97_ops->warm_reset)
-		soc_ac97_ops->warm_reset(codec->ac97);
+		soc_ac97_ops->warm_reset(wm9712->ac97);
 	if (ac97_read(codec, 0) != wm9712_reg[0])
 		goto err;
 	return 0;
@@ -639,6 +644,7 @@ static int wm9712_soc_suspend(struct snd_soc_codec *codec)
 
 static int wm9712_soc_resume(struct snd_soc_codec *codec)
 {
+	struct wm9712_priv *wm9712 = snd_soc_codec_get_drvdata(codec);
 	int i, ret;
 	u16 *cache = codec->reg_cache;
 
@@ -654,7 +660,7 @@ static int wm9712_soc_resume(struct snd_soc_codec *codec)
 			if (i == AC97_INT_PAGING || i == AC97_POWERDOWN ||
 			    (i > 0x58 && i != 0x5c))
 				continue;
-			soc_ac97_ops->write(codec->ac97, i, cache[i>>1]);
+			soc_ac97_ops->write(wm9712->ac97, i, cache[i>>1]);
 		}
 	}
 
@@ -663,11 +669,13 @@ static int wm9712_soc_resume(struct snd_soc_codec *codec)
 
 static int wm9712_soc_probe(struct snd_soc_codec *codec)
 {
+	struct wm9712_priv *wm9712 = snd_soc_codec_get_drvdata(codec);
 	int ret = 0;
 
-	ret = snd_soc_new_ac97_codec(codec);
-	if (ret < 0) {
-		dev_err(codec->dev, "Failed to register AC97 codec\n");
+	wm9712->ac97 = snd_soc_new_ac97_codec(codec);
+	if (IS_ERR(wm9712->ac97)) {
+		ret = PTR_ERR(wm9712->ac97);
+		dev_err(codec->dev, "Failed to register AC97 codec: %d\n", ret);
 		return ret;
 	}
 
@@ -683,13 +691,15 @@ static int wm9712_soc_probe(struct snd_soc_codec *codec)
 	return 0;
 
 reset_err:
-	snd_soc_free_ac97_codec(codec);
+	snd_soc_free_ac97_codec(wm9712->ac97);
 	return ret;
 }
 
 static int wm9712_soc_remove(struct snd_soc_codec *codec)
 {
-	snd_soc_free_ac97_codec(codec);
+	struct wm9712_priv *wm9712 = snd_soc_codec_get_drvdata(codec);
+
+	snd_soc_free_ac97_codec(wm9712->ac97);
 	return 0;
 }
 
diff --git a/sound/soc/codecs/wm9713.c b/sound/soc/codecs/wm9713.c
index cd1b266..6c95d98b 100644
--- a/sound/soc/codecs/wm9713.c
+++ b/sound/soc/codecs/wm9713.c
@@ -30,6 +30,7 @@
 #include "wm9713.h"
 
 struct wm9713_priv {
+	struct snd_ac97 *ac97;
 	u32 pll_in; /* PLL input frequency */
 	unsigned int hp_mixer[2];
 	struct mutex lock;
@@ -674,12 +675,13 @@ static const struct snd_soc_dapm_route wm9713_audio_map[] = {
 static unsigned int ac97_read(struct snd_soc_codec *codec,
 	unsigned int reg)
 {
+	struct wm9713_priv *wm9713 = snd_soc_codec_get_drvdata(codec);
 	u16 *cache = codec->reg_cache;
 
 	if (reg == AC97_RESET || reg == AC97_GPIO_STATUS ||
 		reg == AC97_VENDOR_ID1 || reg == AC97_VENDOR_ID2 ||
 		reg == AC97_CD)
-		return soc_ac97_ops->read(codec->ac97, reg);
+		return soc_ac97_ops->read(wm9713->ac97, reg);
 	else {
 		reg = reg >> 1;
 
@@ -693,8 +695,10 @@ static unsigned int ac97_read(struct snd_soc_codec *codec,
 static int ac97_write(struct snd_soc_codec *codec, unsigned int reg,
 	unsigned int val)
 {
+	struct wm9713_priv *wm9713 = snd_soc_codec_get_drvdata(codec);
+
 	u16 *cache = codec->reg_cache;
-	soc_ac97_ops->write(codec->ac97, reg, val);
+	soc_ac97_ops->write(wm9713->ac97, reg, val);
 	reg = reg >> 1;
 	if (reg < (ARRAY_SIZE(wm9713_reg)))
 		cache[reg] = val;
@@ -1121,15 +1125,17 @@ static struct snd_soc_dai_driver wm9713_dai[] = {
 
 int wm9713_reset(struct snd_soc_codec *codec, int try_warm)
 {
+	struct wm9713_priv *wm9713 = snd_soc_codec_get_drvdata(codec);
+
 	if (try_warm && soc_ac97_ops->warm_reset) {
-		soc_ac97_ops->warm_reset(codec->ac97);
+		soc_ac97_ops->warm_reset(wm9713->ac97);
 		if (ac97_read(codec, 0) == wm9713_reg[0])
 			return 1;
 	}
 
-	soc_ac97_ops->reset(codec->ac97);
+	soc_ac97_ops->reset(wm9713->ac97);
 	if (soc_ac97_ops->warm_reset)
-		soc_ac97_ops->warm_reset(codec->ac97);
+		soc_ac97_ops->warm_reset(wm9713->ac97);
 	if (ac97_read(codec, 0) != wm9713_reg[0]) {
 		dev_err(codec->dev, "Failed to reset: AC97 link error\n");
 		return -EIO;
@@ -1207,7 +1213,7 @@ static int wm9713_soc_resume(struct snd_soc_codec *codec)
 			if (i == AC97_POWERDOWN || i == AC97_EXTENDED_MID ||
 				i == AC97_EXTENDED_MSTATUS || i > 0x66)
 				continue;
-			soc_ac97_ops->write(codec->ac97, i, cache[i>>1]);
+			soc_ac97_ops->write(wm9713->ac97, i, cache[i>>1]);
 		}
 	}
 
@@ -1216,11 +1222,12 @@ static int wm9713_soc_resume(struct snd_soc_codec *codec)
 
 static int wm9713_soc_probe(struct snd_soc_codec *codec)
 {
+	struct wm9713_priv *wm9713 = snd_soc_codec_get_drvdata(codec);
 	int ret = 0, reg;
 
-	ret = snd_soc_new_ac97_codec(codec);
-	if (ret < 0)
-		return ret;
+	wm9713->ac97 = snd_soc_new_ac97_codec(codec);
+	if (IS_ERR(wm9713->ac97))
+		return PTR_ERR(wm9713->ac97);
 
 	/* do a cold reset for the controller and then try
 	 * a warm reset followed by an optional cold reset for codec */
@@ -1238,13 +1245,15 @@ static int wm9713_soc_probe(struct snd_soc_codec *codec)
 	return 0;
 
 reset_err:
-	snd_soc_free_ac97_codec(codec);
+	snd_soc_free_ac97_codec(wm9713->ac97);
 	return ret;
 }
 
 static int wm9713_soc_remove(struct snd_soc_codec *codec)
 {
-	snd_soc_free_ac97_codec(codec);
+	struct wm9713_priv *wm9713 = snd_soc_codec_get_drvdata(codec);
+
+	snd_soc_free_ac97_codec(wm9713->ac97);
 	return 0;
 }
 
diff --git a/sound/soc/soc-ac97.c b/sound/soc/soc-ac97.c
index 920d76c..2e10e9a 100644
--- a/sound/soc/soc-ac97.c
+++ b/sound/soc/soc-ac97.c
@@ -53,30 +53,33 @@ static void soc_ac97_device_release(struct device *dev)
  *
  * Initialises AC97 codec resources for use by ad-hoc devices only.
  */
-int snd_soc_new_ac97_codec(struct snd_soc_codec *codec)
+struct snd_ac97 *snd_soc_new_ac97_codec(struct snd_soc_codec *codec)
 {
+	struct snd_ac97 *ac97;
 	int ret;
 
-	codec->ac97 = kzalloc(sizeof(struct snd_ac97), GFP_KERNEL);
-	if (codec->ac97 == NULL)
-		return -ENOMEM;
+	ac97 = kzalloc(sizeof(struct snd_ac97), GFP_KERNEL);
+	if (ac97 == NULL)
+		return ERR_PTR(-ENOMEM);
 
-	codec->ac97->bus = &soc_ac97_bus;
-	codec->ac97->num = 0;
+	ac97->bus = &soc_ac97_bus;
+	ac97->num = 0;
 
-	codec->ac97->dev.bus = &ac97_bus_type;
-	codec->ac97->dev.parent = codec->component.card->dev;
-	codec->ac97->dev.release = soc_ac97_device_release;
+	ac97->dev.bus = &ac97_bus_type;
+	ac97->dev.parent = codec->component.card->dev;
+	ac97->dev.release = soc_ac97_device_release;
 
-	dev_set_name(&codec->ac97->dev, "%d-%d:%s",
+	dev_set_name(&ac97->dev, "%d-%d:%s",
 		     codec->component.card->snd_card->number, 0,
 		     codec->component.name);
 
-	ret = device_register(&codec->ac97->dev);
-	if (ret)
-		put_device(&codec->ac97->dev);
+	ret = device_register(&ac97->dev);
+	if (ret) {
+		put_device(&ac97->dev);
+		return ERR_PTR(ret);
+	}
 
-	return ret;
+	return ac97;
 }
 EXPORT_SYMBOL_GPL(snd_soc_new_ac97_codec);
 
@@ -86,12 +89,11 @@ EXPORT_SYMBOL_GPL(snd_soc_new_ac97_codec);
  *
  * Frees AC97 codec device resources.
  */
-void snd_soc_free_ac97_codec(struct snd_soc_codec *codec)
+void snd_soc_free_ac97_codec(struct snd_ac97 *ac97)
 {
-	device_del(&codec->ac97->dev);
-	codec->ac97->bus = NULL;
-	put_device(&codec->ac97->dev);
-	codec->ac97 = NULL;
+	device_del(&ac97->dev);
+	ac97->bus = NULL;
+	put_device(&ac97->dev);
 }
 EXPORT_SYMBOL_GPL(snd_soc_free_ac97_codec);
 
-- 
1.8.0
