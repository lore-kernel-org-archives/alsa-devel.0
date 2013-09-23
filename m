From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 3/3] ASoC: max98095: Convert to direct regmap
	API usage
Date: Mon, 23 Sep 2013 19:10:13 +0100
Message-ID: <1379959813-22993-3-git-send-email-broonie@kernel.org>
References: <1379959813-22993-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 1C5472610BF
 for <alsa-devel@alsa-project.org>; Mon, 23 Sep 2013 20:10:37 +0200 (CEST)
In-Reply-To: <1379959813-22993-1-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Hsiang <peter.hsiang@maxim-ic.com>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

Saves code and moves us towards being able to remove the duplicate ASoC
level register I/O functionality.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/max98095.c | 434 +++++++++++++++++---------------------------
 1 file changed, 166 insertions(+), 268 deletions(-)

diff --git a/sound/soc/codecs/max98095.c b/sound/soc/codecs/max98095.c
index 474823a..67db783 100644
--- a/sound/soc/codecs/max98095.c
+++ b/sound/soc/codecs/max98095.c
@@ -39,6 +39,7 @@ struct max98095_cdata {
 };
 
 struct max98095_priv {
+	struct regmap *regmap;
 	enum max98095_type devtype;
 	struct max98095_pdata *pdata;
 	unsigned int sysclk;
@@ -56,263 +57,145 @@ struct max98095_priv {
 	struct snd_soc_jack *mic_jack;
 };
 
-static const u8 max98095_reg_def[M98095_REG_CNT] = {
-	0x00, /* 00 */
-	0x00, /* 01 */
-	0x00, /* 02 */
-	0x00, /* 03 */
-	0x00, /* 04 */
-	0x00, /* 05 */
-	0x00, /* 06 */
-	0x00, /* 07 */
-	0x00, /* 08 */
-	0x00, /* 09 */
-	0x00, /* 0A */
-	0x00, /* 0B */
-	0x00, /* 0C */
-	0x00, /* 0D */
-	0x00, /* 0E */
-	0x00, /* 0F */
-	0x00, /* 10 */
-	0x00, /* 11 */
-	0x00, /* 12 */
-	0x00, /* 13 */
-	0x00, /* 14 */
-	0x00, /* 15 */
-	0x00, /* 16 */
-	0x00, /* 17 */
-	0x00, /* 18 */
-	0x00, /* 19 */
-	0x00, /* 1A */
-	0x00, /* 1B */
-	0x00, /* 1C */
-	0x00, /* 1D */
-	0x00, /* 1E */
-	0x00, /* 1F */
-	0x00, /* 20 */
-	0x00, /* 21 */
-	0x00, /* 22 */
-	0x00, /* 23 */
-	0x00, /* 24 */
-	0x00, /* 25 */
-	0x00, /* 26 */
-	0x00, /* 27 */
-	0x00, /* 28 */
-	0x00, /* 29 */
-	0x00, /* 2A */
-	0x00, /* 2B */
-	0x00, /* 2C */
-	0x00, /* 2D */
-	0x00, /* 2E */
-	0x00, /* 2F */
-	0x00, /* 30 */
-	0x00, /* 31 */
-	0x00, /* 32 */
-	0x00, /* 33 */
-	0x00, /* 34 */
-	0x00, /* 35 */
-	0x00, /* 36 */
-	0x00, /* 37 */
-	0x00, /* 38 */
-	0x00, /* 39 */
-	0x00, /* 3A */
-	0x00, /* 3B */
-	0x00, /* 3C */
-	0x00, /* 3D */
-	0x00, /* 3E */
-	0x00, /* 3F */
-	0x00, /* 40 */
-	0x00, /* 41 */
-	0x00, /* 42 */
-	0x00, /* 43 */
-	0x00, /* 44 */
-	0x00, /* 45 */
-	0x00, /* 46 */
-	0x00, /* 47 */
-	0x00, /* 48 */
-	0x00, /* 49 */
-	0x00, /* 4A */
-	0x00, /* 4B */
-	0x00, /* 4C */
-	0x00, /* 4D */
-	0x00, /* 4E */
-	0x00, /* 4F */
-	0x00, /* 50 */
-	0x00, /* 51 */
-	0x00, /* 52 */
-	0x00, /* 53 */
-	0x00, /* 54 */
-	0x00, /* 55 */
-	0x00, /* 56 */
-	0x00, /* 57 */
-	0x00, /* 58 */
-	0x00, /* 59 */
-	0x00, /* 5A */
-	0x00, /* 5B */
-	0x00, /* 5C */
-	0x00, /* 5D */
-	0x00, /* 5E */
-	0x00, /* 5F */
-	0x00, /* 60 */
-	0x00, /* 61 */
-	0x00, /* 62 */
-	0x00, /* 63 */
-	0x00, /* 64 */
-	0x00, /* 65 */
-	0x00, /* 66 */
-	0x00, /* 67 */
-	0x00, /* 68 */
-	0x00, /* 69 */
-	0x00, /* 6A */
-	0x00, /* 6B */
-	0x00, /* 6C */
-	0x00, /* 6D */
-	0x00, /* 6E */
-	0x00, /* 6F */
-	0x00, /* 70 */
-	0x00, /* 71 */
-	0x00, /* 72 */
-	0x00, /* 73 */
-	0x00, /* 74 */
-	0x00, /* 75 */
-	0x00, /* 76 */
-	0x00, /* 77 */
-	0x00, /* 78 */
-	0x00, /* 79 */
-	0x00, /* 7A */
-	0x00, /* 7B */
-	0x00, /* 7C */
-	0x00, /* 7D */
-	0x00, /* 7E */
-	0x00, /* 7F */
-	0x00, /* 80 */
-	0x00, /* 81 */
-	0x00, /* 82 */
-	0x00, /* 83 */
-	0x00, /* 84 */
-	0x00, /* 85 */
-	0x00, /* 86 */
-	0x00, /* 87 */
-	0x00, /* 88 */
-	0x00, /* 89 */
-	0x00, /* 8A */
-	0x00, /* 8B */
-	0x00, /* 8C */
-	0x00, /* 8D */
-	0x00, /* 8E */
-	0x00, /* 8F */
-	0x00, /* 90 */
-	0x00, /* 91 */
-	0x30, /* 92 */
-	0xF0, /* 93 */
-	0x00, /* 94 */
-	0x00, /* 95 */
-	0x3F, /* 96 */
-	0x00, /* 97 */
-	0x00, /* 98 */
-	0x00, /* 99 */
-	0x00, /* 9A */
-	0x00, /* 9B */
-	0x00, /* 9C */
-	0x00, /* 9D */
-	0x00, /* 9E */
-	0x00, /* 9F */
-	0x00, /* A0 */
-	0x00, /* A1 */
-	0x00, /* A2 */
-	0x00, /* A3 */
-	0x00, /* A4 */
-	0x00, /* A5 */
-	0x00, /* A6 */
-	0x00, /* A7 */
-	0x00, /* A8 */
-	0x00, /* A9 */
-	0x00, /* AA */
-	0x00, /* AB */
-	0x00, /* AC */
-	0x00, /* AD */
-	0x00, /* AE */
-	0x00, /* AF */
-	0x00, /* B0 */
-	0x00, /* B1 */
-	0x00, /* B2 */
-	0x00, /* B3 */
-	0x00, /* B4 */
-	0x00, /* B5 */
-	0x00, /* B6 */
-	0x00, /* B7 */
-	0x00, /* B8 */
-	0x00, /* B9 */
-	0x00, /* BA */
-	0x00, /* BB */
-	0x00, /* BC */
-	0x00, /* BD */
-	0x00, /* BE */
-	0x00, /* BF */
-	0x00, /* C0 */
-	0x00, /* C1 */
-	0x00, /* C2 */
-	0x00, /* C3 */
-	0x00, /* C4 */
-	0x00, /* C5 */
-	0x00, /* C6 */
-	0x00, /* C7 */
-	0x00, /* C8 */
-	0x00, /* C9 */
-	0x00, /* CA */
-	0x00, /* CB */
-	0x00, /* CC */
-	0x00, /* CD */
-	0x00, /* CE */
-	0x00, /* CF */
-	0x00, /* D0 */
-	0x00, /* D1 */
-	0x00, /* D2 */
-	0x00, /* D3 */
-	0x00, /* D4 */
-	0x00, /* D5 */
-	0x00, /* D6 */
-	0x00, /* D7 */
-	0x00, /* D8 */
-	0x00, /* D9 */
-	0x00, /* DA */
-	0x00, /* DB */
-	0x00, /* DC */
-	0x00, /* DD */
-	0x00, /* DE */
-	0x00, /* DF */
-	0x00, /* E0 */
-	0x00, /* E1 */
-	0x00, /* E2 */
-	0x00, /* E3 */
-	0x00, /* E4 */
-	0x00, /* E5 */
-	0x00, /* E6 */
-	0x00, /* E7 */
-	0x00, /* E8 */
-	0x00, /* E9 */
-	0x00, /* EA */
-	0x00, /* EB */
-	0x00, /* EC */
-	0x00, /* ED */
-	0x00, /* EE */
-	0x00, /* EF */
-	0x00, /* F0 */
-	0x00, /* F1 */
-	0x00, /* F2 */
-	0x00, /* F3 */
-	0x00, /* F4 */
-	0x00, /* F5 */
-	0x00, /* F6 */
-	0x00, /* F7 */
-	0x00, /* F8 */
-	0x00, /* F9 */
-	0x00, /* FA */
-	0x00, /* FB */
-	0x00, /* FC */
-	0x00, /* FD */
-	0x00, /* FE */
-	0x00, /* FF */
+static const struct reg_default max98095_reg_def[] = {
+	{  0xf, 0x00 }, /* 0F */
+	{ 0x10, 0x00 }, /* 10 */
+	{ 0x11, 0x00 }, /* 11 */
+	{ 0x12, 0x00 }, /* 12 */
+	{ 0x13, 0x00 }, /* 13 */
+	{ 0x14, 0x00 }, /* 14 */
+	{ 0x15, 0x00 }, /* 15 */
+	{ 0x16, 0x00 }, /* 16 */
+	{ 0x17, 0x00 }, /* 17 */
+	{ 0x18, 0x00 }, /* 18 */
+	{ 0x19, 0x00 }, /* 19 */
+	{ 0x1a, 0x00 }, /* 1A */
+	{ 0x1b, 0x00 }, /* 1B */
+	{ 0x1c, 0x00 }, /* 1C */
+	{ 0x1d, 0x00 }, /* 1D */
+	{ 0x1e, 0x00 }, /* 1E */
+	{ 0x1f, 0x00 }, /* 1F */
+	{ 0x20, 0x00 }, /* 20 */
+	{ 0x21, 0x00 }, /* 21 */
+	{ 0x22, 0x00 }, /* 22 */
+	{ 0x23, 0x00 }, /* 23 */
+	{ 0x24, 0x00 }, /* 24 */
+	{ 0x25, 0x00 }, /* 25 */
+	{ 0x26, 0x00 }, /* 26 */
+	{ 0x27, 0x00 }, /* 27 */
+	{ 0x28, 0x00 }, /* 28 */
+	{ 0x29, 0x00 }, /* 29 */
+	{ 0x2a, 0x00 }, /* 2A */
+	{ 0x2b, 0x00 }, /* 2B */
+	{ 0x2c, 0x00 }, /* 2C */
+	{ 0x2d, 0x00 }, /* 2D */
+	{ 0x2e, 0x00 }, /* 2E */
+	{ 0x2f, 0x00 }, /* 2F */
+	{ 0x30, 0x00 }, /* 30 */
+	{ 0x31, 0x00 }, /* 31 */
+	{ 0x32, 0x00 }, /* 32 */
+	{ 0x33, 0x00 }, /* 33 */
+	{ 0x34, 0x00 }, /* 34 */
+	{ 0x35, 0x00 }, /* 35 */
+	{ 0x36, 0x00 }, /* 36 */
+	{ 0x37, 0x00 }, /* 37 */
+	{ 0x38, 0x00 }, /* 38 */
+	{ 0x39, 0x00 }, /* 39 */
+	{ 0x3a, 0x00 }, /* 3A */
+	{ 0x3b, 0x00 }, /* 3B */
+	{ 0x3c, 0x00 }, /* 3C */
+	{ 0x3d, 0x00 }, /* 3D */
+	{ 0x3e, 0x00 }, /* 3E */
+	{ 0x3f, 0x00 }, /* 3F */
+	{ 0x40, 0x00 }, /* 40 */
+	{ 0x41, 0x00 }, /* 41 */
+	{ 0x42, 0x00 }, /* 42 */
+	{ 0x43, 0x00 }, /* 43 */
+	{ 0x44, 0x00 }, /* 44 */
+	{ 0x45, 0x00 }, /* 45 */
+	{ 0x46, 0x00 }, /* 46 */
+	{ 0x47, 0x00 }, /* 47 */
+	{ 0x48, 0x00 }, /* 48 */
+	{ 0x49, 0x00 }, /* 49 */
+	{ 0x4a, 0x00 }, /* 4A */
+	{ 0x4b, 0x00 }, /* 4B */
+	{ 0x4c, 0x00 }, /* 4C */
+	{ 0x4d, 0x00 }, /* 4D */
+	{ 0x4e, 0x00 }, /* 4E */
+	{ 0x4f, 0x00 }, /* 4F */
+	{ 0x50, 0x00 }, /* 50 */
+	{ 0x51, 0x00 }, /* 51 */
+	{ 0x52, 0x00 }, /* 52 */
+	{ 0x53, 0x00 }, /* 53 */
+	{ 0x54, 0x00 }, /* 54 */
+	{ 0x55, 0x00 }, /* 55 */
+	{ 0x56, 0x00 }, /* 56 */
+	{ 0x57, 0x00 }, /* 57 */
+	{ 0x58, 0x00 }, /* 58 */
+	{ 0x59, 0x00 }, /* 59 */
+	{ 0x5a, 0x00 }, /* 5A */
+	{ 0x5b, 0x00 }, /* 5B */
+	{ 0x5c, 0x00 }, /* 5C */
+	{ 0x5d, 0x00 }, /* 5D */
+	{ 0x5e, 0x00 }, /* 5E */
+	{ 0x5f, 0x00 }, /* 5F */
+	{ 0x60, 0x00 }, /* 60 */
+	{ 0x61, 0x00 }, /* 61 */
+	{ 0x62, 0x00 }, /* 62 */
+	{ 0x63, 0x00 }, /* 63 */
+	{ 0x64, 0x00 }, /* 64 */
+	{ 0x65, 0x00 }, /* 65 */
+	{ 0x66, 0x00 }, /* 66 */
+	{ 0x67, 0x00 }, /* 67 */
+	{ 0x68, 0x00 }, /* 68 */
+	{ 0x69, 0x00 }, /* 69 */
+	{ 0x6a, 0x00 }, /* 6A */
+	{ 0x6b, 0x00 }, /* 6B */
+	{ 0x6c, 0x00 }, /* 6C */
+	{ 0x6d, 0x00 }, /* 6D */
+	{ 0x6e, 0x00 }, /* 6E */
+	{ 0x6f, 0x00 }, /* 6F */
+	{ 0x70, 0x00 }, /* 70 */
+	{ 0x71, 0x00 }, /* 71 */
+	{ 0x72, 0x00 }, /* 72 */
+	{ 0x73, 0x00 }, /* 73 */
+	{ 0x74, 0x00 }, /* 74 */
+	{ 0x75, 0x00 }, /* 75 */
+	{ 0x76, 0x00 }, /* 76 */
+	{ 0x77, 0x00 }, /* 77 */
+	{ 0x78, 0x00 }, /* 78 */
+	{ 0x79, 0x00 }, /* 79 */
+	{ 0x7a, 0x00 }, /* 7A */
+	{ 0x7b, 0x00 }, /* 7B */
+	{ 0x7c, 0x00 }, /* 7C */
+	{ 0x7d, 0x00 }, /* 7D */
+	{ 0x7e, 0x00 }, /* 7E */
+	{ 0x7f, 0x00 }, /* 7F */
+	{ 0x80, 0x00 }, /* 80 */
+	{ 0x81, 0x00 }, /* 81 */
+	{ 0x82, 0x00 }, /* 82 */
+	{ 0x83, 0x00 }, /* 83 */
+	{ 0x84, 0x00 }, /* 84 */
+	{ 0x85, 0x00 }, /* 85 */
+	{ 0x86, 0x00 }, /* 86 */
+	{ 0x87, 0x00 }, /* 87 */
+	{ 0x88, 0x00 }, /* 88 */
+	{ 0x89, 0x00 }, /* 89 */
+	{ 0x8a, 0x00 }, /* 8A */
+	{ 0x8b, 0x00 }, /* 8B */
+	{ 0x8c, 0x00 }, /* 8C */
+	{ 0x8d, 0x00 }, /* 8D */
+	{ 0x8e, 0x00 }, /* 8E */
+	{ 0x8f, 0x00 }, /* 8F */
+	{ 0x90, 0x00 }, /* 90 */
+	{ 0x91, 0x00 }, /* 91 */
+	{ 0x92, 0x30 }, /* 92 */
+	{ 0x93, 0xF0 }, /* 93 */
+	{ 0x94, 0x00 }, /* 94 */
+	{ 0x95, 0x00 }, /* 95 */
+	{ 0x96, 0x3F }, /* 96 */
+	{ 0x97, 0x00 }, /* 97 */
+	{ 0xff, 0x00 }, /* FF */
 };
 
 static struct {
@@ -577,14 +460,14 @@ static struct {
 	{ 0xFF, 0x00 }, /* FF */
 };
 
-static int max98095_readable(struct snd_soc_codec *codec, unsigned int reg)
+static bool max98095_readable(struct device *dev, unsigned int reg)
 {
 	if (reg >= M98095_REG_CNT)
 		return 0;
 	return max98095_access[reg].readable != 0;
 }
 
-static int max98095_volatile(struct snd_soc_codec *codec, unsigned int reg)
+static bool max98095_volatile(struct device *dev, unsigned int reg)
 {
 	if (reg > M98095_REG_MAX_CACHED)
 		return 1;
@@ -611,6 +494,18 @@ static int max98095_volatile(struct snd_soc_codec *codec, unsigned int reg)
 	return 0;
 }
 
+static const struct regmap_config max98095_regmap = {
+	.reg_bits = 8,
+	.val_bits = 8,
+
+	.reg_defaults = max98095_reg_def,
+	.num_reg_defaults = ARRAY_SIZE(max98095_reg_def),
+	.max_register = M98095_0FF_REV_ID,
+
+	.readable_reg = max98095_readable,
+	.volatile_reg = max98095_volatile,
+};
+
 /*
  * Load equalizer DSP coefficient configurations registers
  */
@@ -1723,6 +1618,7 @@ static int max98095_dai3_set_fmt(struct snd_soc_dai *codec_dai,
 static int max98095_set_bias_level(struct snd_soc_codec *codec,
 				   enum snd_soc_bias_level level)
 {
+	struct max98095_priv *max98095 = snd_soc_codec_get_drvdata(codec);
 	int ret;
 
 	switch (level) {
@@ -1734,7 +1630,7 @@ static int max98095_set_bias_level(struct snd_soc_codec *codec,
 
 	case SND_SOC_BIAS_STANDBY:
 		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF) {
-			ret = snd_soc_cache_sync(codec);
+			ret = regcache_sync(max98095->regmap);
 
 			if (ret != 0) {
 				dev_err(codec->dev, "Failed to sync cache: %d\n", ret);
@@ -1749,7 +1645,7 @@ static int max98095_set_bias_level(struct snd_soc_codec *codec,
 	case SND_SOC_BIAS_OFF:
 		snd_soc_update_bits(codec, M98095_090_PWR_EN_IN,
 				M98095_MBEN, 0);
-		codec->cache_sync = 1;
+		regcache_mark_dirty(max98095->regmap);
 		break;
 	}
 	codec->dapm.bias_level = level;
@@ -2316,7 +2212,7 @@ static int max98095_reset(struct snd_soc_codec *codec)
 	/* Reset to hardware default for registers, as there is not
 	 * a soft reset hardware control register */
 	for (i = M98095_010_HOST_INT_CFG; i < M98095_REG_MAX_CACHED; i++) {
-		ret = snd_soc_write(codec, i, max98095_reg_def[i]);
+		ret = snd_soc_write(codec, i, snd_soc_read(codec, i));
 		if (ret < 0) {
 			dev_err(codec->dev, "Failed to reset: %d\n", ret);
 			return ret;
@@ -2333,7 +2229,7 @@ static int max98095_probe(struct snd_soc_codec *codec)
 	struct i2c_client *client;
 	int ret = 0;
 
-	ret = snd_soc_codec_set_cache_io(codec, 8, 8, SND_SOC_I2C);
+	ret = snd_soc_codec_set_cache_io(codec, 8, 8, SND_SOC_REGMAP);
 	if (ret != 0) {
 		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
 		return ret;
@@ -2455,11 +2351,6 @@ static struct snd_soc_codec_driver soc_codec_dev_max98095 = {
 	.set_bias_level = max98095_set_bias_level,
 	.controls = max98095_snd_controls,
 	.num_controls = ARRAY_SIZE(max98095_snd_controls),
-	.reg_cache_size = ARRAY_SIZE(max98095_reg_def),
-	.reg_word_size = sizeof(u8),
-	.reg_cache_default = max98095_reg_def,
-	.readable_register = max98095_readable,
-	.volatile_register = max98095_volatile,
 	.dapm_widgets	  = max98095_dapm_widgets,
 	.num_dapm_widgets = ARRAY_SIZE(max98095_dapm_widgets),
 	.dapm_routes     = max98095_audio_map,
@@ -2477,6 +2368,13 @@ static int max98095_i2c_probe(struct i2c_client *i2c,
 	if (max98095 == NULL)
 		return -ENOMEM;
 
+	max98095->regmap = devm_regmap_init_i2c(i2c, &max98095_regmap);
+	if (IS_ERR(max98095->regmap)) {
+		ret = PTR_ERR(max98095->regmap);
+		dev_err(&i2c->dev, "Failed to allocate regmap: %d\n", ret);
+		return ret;
+	}
+
 	max98095->devtype = id->driver_data;
 	i2c_set_clientdata(i2c, max98095);
 	max98095->pdata = i2c->dev.platform_data;
-- 
1.8.4.rc3
