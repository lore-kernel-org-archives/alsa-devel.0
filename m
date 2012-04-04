From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: codecs: Remove rtd->codec usage from
	CODEC drivers
Date: Wed,  4 Apr 2012 15:58:55 +0100
Message-ID: <1333551535-11795-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 68E4D246BC
	for <alsa-devel@alsa-project.org>;
	Wed,  4 Apr 2012 16:59:00 +0200 (CEST)
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

In order to support CODEC<->CODEC links remove the assumption that there
is only a single CODEC on a DAI link by removing the use of the CODEC
pointer in the rtd from the CODEC drivers. They are already being passed
their DAI whenever they are passed an rtd and can get the CODEC from
there.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/ac97.c        |    4 +---
 sound/soc/codecs/ad1836.c      |    4 +---
 sound/soc/codecs/ad193x.c      |    4 +---
 sound/soc/codecs/adau1701.c    |    3 +--
 sound/soc/codecs/ak4104.c      |    3 +--
 sound/soc/codecs/ak4535.c      |    3 +--
 sound/soc/codecs/ak4641.c      |    3 +--
 sound/soc/codecs/alc5623.c     |    3 +--
 sound/soc/codecs/alc5632.c     |    3 +--
 sound/soc/codecs/cs4270.c      |    3 +--
 sound/soc/codecs/cs4271.c      |    3 +--
 sound/soc/codecs/cs42l51.c     |    3 +--
 sound/soc/codecs/cs42l73.c     |    3 +--
 sound/soc/codecs/da7210.c      |    3 +--
 sound/soc/codecs/jz4740.c      |    3 +--
 sound/soc/codecs/lm49453.c     |    3 +--
 sound/soc/codecs/rt5631.c      |    3 +--
 sound/soc/codecs/sgtl5000.c    |    3 +--
 sound/soc/codecs/ssm2602.c     |    9 +++------
 sound/soc/codecs/sta32x.c      |    3 +--
 sound/soc/codecs/tlv320aic23.c |    9 +++------
 sound/soc/codecs/tlv320aic26.c |    3 +--
 sound/soc/codecs/tlv320aic3x.c |    3 +--
 sound/soc/codecs/tlv320dac33.c |   35 +++++++++++++++--------------------
 sound/soc/codecs/twl4030.c     |   18 ++++++------------
 sound/soc/codecs/twl6040.c     |    9 +++------
 sound/soc/codecs/uda134x.c     |    6 ++----
 sound/soc/codecs/uda1380.c     |    6 ++----
 sound/soc/codecs/wl1273.c      |    6 ++----
 sound/soc/codecs/wm8400.c      |    3 +--
 sound/soc/codecs/wm8510.c      |    3 +--
 sound/soc/codecs/wm8523.c      |    3 +--
 sound/soc/codecs/wm8728.c      |    3 +--
 sound/soc/codecs/wm8737.c      |    3 +--
 sound/soc/codecs/wm8741.c      |    3 +--
 sound/soc/codecs/wm8750.c      |    3 +--
 sound/soc/codecs/wm8753.c      |    6 ++----
 sound/soc/codecs/wm8900.c      |    3 +--
 sound/soc/codecs/wm8903.c      |    3 +--
 sound/soc/codecs/wm8940.c      |    3 +--
 sound/soc/codecs/wm8960.c      |    3 +--
 sound/soc/codecs/wm8962.c      |    3 +--
 sound/soc/codecs/wm8971.c      |    3 +--
 sound/soc/codecs/wm8978.c      |    3 +--
 sound/soc/codecs/wm8988.c      |    3 +--
 sound/soc/codecs/wm8990.c      |    3 +--
 sound/soc/codecs/wm9705.c      |    4 +---
 sound/soc/codecs/wm9712.c      |    8 ++------
 48 files changed, 78 insertions(+), 152 deletions(-)

diff --git a/sound/soc/codecs/ac97.c b/sound/soc/codecs/ac97.c
index 1bbad4c..a99a1b3 100644
--- a/sound/soc/codecs/ac97.c
+++ b/sound/soc/codecs/ac97.c
@@ -26,9 +26,7 @@
 static int ac97_prepare(struct snd_pcm_substream *substream,
 			struct snd_soc_dai *dai)
 {
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_codec *codec = dai->codec;
 
 	int reg = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) ?
 		  AC97_PCM_FRONT_DAC_RATE : AC97_PCM_LR_ADC_RATE;
diff --git a/sound/soc/codecs/ad1836.c b/sound/soc/codecs/ad1836.c
index 12e3b41..c67b50d 100644
--- a/sound/soc/codecs/ad1836.c
+++ b/sound/soc/codecs/ad1836.c
@@ -162,9 +162,7 @@ static int ad1836_hw_params(struct snd_pcm_substream *substream,
 		struct snd_soc_dai *dai)
 {
 	int word_len = 0;
-
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_codec *codec = dai->codec;
 
 	/* bit size */
 	switch (params_format(params)) {
diff --git a/sound/soc/codecs/ad193x.c b/sound/soc/codecs/ad193x.c
index a4a6bef..13e62be 100644
--- a/sound/soc/codecs/ad193x.c
+++ b/sound/soc/codecs/ad193x.c
@@ -245,9 +245,7 @@ static int ad193x_hw_params(struct snd_pcm_substream *substream,
 		struct snd_soc_dai *dai)
 {
 	int word_len = 0, master_rate = 0;
-
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_codec *codec = dai->codec;
 	struct ad193x_priv *ad193x = snd_soc_codec_get_drvdata(codec);
 
 	/* bit size */
diff --git a/sound/soc/codecs/adau1701.c b/sound/soc/codecs/adau1701.c
index 78e9ce4..3d50fc8 100644
--- a/sound/soc/codecs/adau1701.c
+++ b/sound/soc/codecs/adau1701.c
@@ -258,8 +258,7 @@ static int adau1701_set_playback_pcm_format(struct snd_soc_codec *codec,
 static int adau1701_hw_params(struct snd_pcm_substream *substream,
 		struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_codec *codec = dai->codec;
 	snd_pcm_format_t format;
 	unsigned int val;
 
diff --git a/sound/soc/codecs/ak4104.c b/sound/soc/codecs/ak4104.c
index ceb96ec..31d4483 100644
--- a/sound/soc/codecs/ak4104.c
+++ b/sound/soc/codecs/ak4104.c
@@ -88,8 +88,7 @@ static int ak4104_hw_params(struct snd_pcm_substream *substream,
 			    struct snd_pcm_hw_params *params,
 			    struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_codec *codec = dai->codec;
 	int val = 0;
 
 	/* set the IEC958 bits: consumer mode, no copyright bit */
diff --git a/sound/soc/codecs/ak4535.c b/sound/soc/codecs/ak4535.c
index 838ae8b..618fdc3 100644
--- a/sound/soc/codecs/ak4535.c
+++ b/sound/soc/codecs/ak4535.c
@@ -262,8 +262,7 @@ static int ak4535_hw_params(struct snd_pcm_substream *substream,
 			    struct snd_pcm_hw_params *params,
 			    struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_codec *codec = dai->codec;
 	struct ak4535_priv *ak4535 = snd_soc_codec_get_drvdata(codec);
 	u8 mode2 = snd_soc_read(codec, AK4535_MODE2) & ~(0x3 << 5);
 	int rate = params_rate(params), fs = 256;
diff --git a/sound/soc/codecs/ak4641.c b/sound/soc/codecs/ak4641.c
index 7f42d4a..543a12f 100644
--- a/sound/soc/codecs/ak4641.c
+++ b/sound/soc/codecs/ak4641.c
@@ -296,8 +296,7 @@ static int ak4641_i2s_hw_params(struct snd_pcm_substream *substream,
 				 struct snd_pcm_hw_params *params,
 				 struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_codec *codec = dai->codec;
 	struct ak4641_priv *ak4641 = snd_soc_codec_get_drvdata(codec);
 	int rate = params_rate(params), fs = 256;
 	u8 mode2;
diff --git a/sound/soc/codecs/alc5623.c b/sound/soc/codecs/alc5623.c
index d47b62d..3061d35 100644
--- a/sound/soc/codecs/alc5623.c
+++ b/sound/soc/codecs/alc5623.c
@@ -705,8 +705,7 @@ static int alc5623_set_dai_fmt(struct snd_soc_dai *codec_dai,
 static int alc5623_pcm_hw_params(struct snd_pcm_substream *substream,
 		struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_codec *codec = dai->codec;
 	struct alc5623_priv *alc5623 = snd_soc_codec_get_drvdata(codec);
 	int coeff, rate;
 	u16 iface;
diff --git a/sound/soc/codecs/alc5632.c b/sound/soc/codecs/alc5632.c
index e2111e0..93a5909 100644
--- a/sound/soc/codecs/alc5632.c
+++ b/sound/soc/codecs/alc5632.c
@@ -861,8 +861,7 @@ static int alc5632_set_dai_fmt(struct snd_soc_dai *codec_dai,
 static int alc5632_pcm_hw_params(struct snd_pcm_substream *substream,
 		struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_codec *codec = dai->codec;
 	int coeff, rate;
 	u16 iface;
 
diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
index df8fe38..047917f 100644
--- a/sound/soc/codecs/cs4270.c
+++ b/sound/soc/codecs/cs4270.c
@@ -307,8 +307,7 @@ static int cs4270_hw_params(struct snd_pcm_substream *substream,
 			    struct snd_pcm_hw_params *params,
 			    struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_codec *codec = dai->codec;
 	struct cs4270_private *cs4270 = snd_soc_codec_get_drvdata(codec);
 	int ret;
 	unsigned int i;
diff --git a/sound/soc/codecs/cs4271.c b/sound/soc/codecs/cs4271.c
index bf71412..9eb01d7 100644
--- a/sound/soc/codecs/cs4271.c
+++ b/sound/soc/codecs/cs4271.c
@@ -318,8 +318,7 @@ static int cs4271_hw_params(struct snd_pcm_substream *substream,
 			    struct snd_pcm_hw_params *params,
 			    struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_codec *codec = dai->codec;
 	struct cs4271_private *cs4271 = snd_soc_codec_get_drvdata(codec);
 	int i, ret;
 	unsigned int ratio, val;
diff --git a/sound/soc/codecs/cs42l51.c b/sound/soc/codecs/cs42l51.c
index 85d6069..091d019 100644
--- a/sound/soc/codecs/cs42l51.c
+++ b/sound/soc/codecs/cs42l51.c
@@ -356,8 +356,7 @@ static int cs42l51_hw_params(struct snd_pcm_substream *substream,
 		struct snd_pcm_hw_params *params,
 		struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_codec *codec = dai->codec;
 	struct cs42l51_private *cs42l51 = snd_soc_codec_get_drvdata(codec);
 	int ret;
 	unsigned int i;
diff --git a/sound/soc/codecs/cs42l73.c b/sound/soc/codecs/cs42l73.c
index d39b3e7..2cc50b3 100644
--- a/sound/soc/codecs/cs42l73.c
+++ b/sound/soc/codecs/cs42l73.c
@@ -1089,8 +1089,7 @@ static int cs42l73_pcm_hw_params(struct snd_pcm_substream *substream,
 				 struct snd_pcm_hw_params *params,
 				 struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_codec *codec = dai->codec;
 	struct cs42l73_private *priv = snd_soc_codec_get_drvdata(codec);
 	int id = dai->id;
 	int mclk_coeff;
diff --git a/sound/soc/codecs/da7210.c b/sound/soc/codecs/da7210.c
index 8e45aa9..5dfdf6e 100644
--- a/sound/soc/codecs/da7210.c
+++ b/sound/soc/codecs/da7210.c
@@ -716,8 +716,7 @@ static int da7210_hw_params(struct snd_pcm_substream *substream,
 			    struct snd_pcm_hw_params *params,
 			    struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_codec *codec = dai->codec;
 	u32 dai_cfg1;
 	u32 fs, bypass;
 
diff --git a/sound/soc/codecs/jz4740.c b/sound/soc/codecs/jz4740.c
index 4624e75..85d9cab 100644
--- a/sound/soc/codecs/jz4740.c
+++ b/sound/soc/codecs/jz4740.c
@@ -164,8 +164,7 @@ static int jz4740_codec_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
 {
 	uint32_t val;
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec =rtd->codec;
+	struct snd_soc_codec *codec = dai->codec;
 
 	switch (params_rate(params)) {
 	case 8000:
diff --git a/sound/soc/codecs/lm49453.c b/sound/soc/codecs/lm49453.c
index 744063d..89bbe03 100644
--- a/sound/soc/codecs/lm49453.c
+++ b/sound/soc/codecs/lm49453.c
@@ -1140,8 +1140,7 @@ static int lm49453_hw_params(struct snd_pcm_substream *substream,
 			     struct snd_pcm_hw_params *params,
 			     struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_codec *codec = dai->codec;
 	struct lm49453_priv *lm49453 = snd_soc_codec_get_drvdata(codec);
 	u16 clk_div = 0;
 
diff --git a/sound/soc/codecs/rt5631.c b/sound/soc/codecs/rt5631.c
index 20c324c..95147e4 100644
--- a/sound/soc/codecs/rt5631.c
+++ b/sound/soc/codecs/rt5631.c
@@ -1361,8 +1361,7 @@ static int get_coeff(int mclk, int rate, int timesofbclk)
 static int rt5631_hifi_pcm_params(struct snd_pcm_substream *substream,
 		struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_codec *codec = dai->codec;
 	struct rt5631_priv *rt5631 = snd_soc_codec_get_drvdata(codec);
 	int timesofbclk = 32, coeff;
 	unsigned int iface = 0;
diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index ce1d5ce..8af6a524 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -665,8 +665,7 @@ static int sgtl5000_pcm_hw_params(struct snd_pcm_substream *substream,
 				  struct snd_pcm_hw_params *params,
 				  struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_codec *codec = dai->codec;
 	struct sgtl5000_priv *sgtl5000 = snd_soc_codec_get_drvdata(codec);
 	int channels = params_channels(params);
 	int i2s_ctl = 0;
diff --git a/sound/soc/codecs/ssm2602.c b/sound/soc/codecs/ssm2602.c
index de2b2054..4c94fd2 100644
--- a/sound/soc/codecs/ssm2602.c
+++ b/sound/soc/codecs/ssm2602.c
@@ -254,8 +254,7 @@ static int ssm2602_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params,
 	struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_codec *codec = dai->codec;
 	struct ssm2602_priv *ssm2602 = snd_soc_codec_get_drvdata(codec);
 	u16 iface = snd_soc_read(codec, SSM2602_IFACE) & 0xfff3;
 	int srate = ssm2602_get_coeff(ssm2602->sysclk, params_rate(params));
@@ -291,8 +290,7 @@ static int ssm2602_hw_params(struct snd_pcm_substream *substream,
 static int ssm2602_startup(struct snd_pcm_substream *substream,
 			   struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_codec *codec = dai->codec;
 	struct ssm2602_priv *ssm2602 = snd_soc_codec_get_drvdata(codec);
 	struct snd_pcm_runtime *master_runtime;
 
@@ -328,8 +326,7 @@ static int ssm2602_startup(struct snd_pcm_substream *substream,
 static void ssm2602_shutdown(struct snd_pcm_substream *substream,
 			     struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_codec *codec = dai->codec;
 	struct ssm2602_priv *ssm2602 = snd_soc_codec_get_drvdata(codec);
 
 	if (ssm2602->master_substream == substream)
diff --git a/sound/soc/codecs/sta32x.c b/sound/soc/codecs/sta32x.c
index 7db6fa5..8d717f4 100644
--- a/sound/soc/codecs/sta32x.c
+++ b/sound/soc/codecs/sta32x.c
@@ -609,8 +609,7 @@ static int sta32x_hw_params(struct snd_pcm_substream *substream,
 			    struct snd_pcm_hw_params *params,
 			    struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_codec *codec = dai->codec;
 	struct sta32x_priv *sta32x = snd_soc_codec_get_drvdata(codec);
 	unsigned int rate;
 	int i, mcs = -1, ir = -1;
diff --git a/sound/soc/codecs/tlv320aic23.c b/sound/soc/codecs/tlv320aic23.c
index b0cafd3..8c758b21 100644
--- a/sound/soc/codecs/tlv320aic23.c
+++ b/sound/soc/codecs/tlv320aic23.c
@@ -323,8 +323,7 @@ static int tlv320aic23_hw_params(struct snd_pcm_substream *substream,
 				 struct snd_pcm_hw_params *params,
 				 struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_codec *codec = dai->codec;
 	u16 iface_reg;
 	int ret;
 	struct aic23 *aic23 = snd_soc_codec_get_drvdata(codec);
@@ -369,8 +368,7 @@ static int tlv320aic23_hw_params(struct snd_pcm_substream *substream,
 static int tlv320aic23_pcm_prepare(struct snd_pcm_substream *substream,
 				   struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_codec *codec = dai->codec;
 
 	/* set active */
 	snd_soc_write(codec, TLV320AIC23_ACTIVE, 0x0001);
@@ -381,8 +379,7 @@ static int tlv320aic23_pcm_prepare(struct snd_pcm_substream *substream,
 static void tlv320aic23_shutdown(struct snd_pcm_substream *substream,
 				 struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_codec *codec = dai->codec;
 	struct aic23 *aic23 = snd_soc_codec_get_drvdata(codec);
 
 	/* deactivate */
diff --git a/sound/soc/codecs/tlv320aic26.c b/sound/soc/codecs/tlv320aic26.c
index 802064b..85944e9 100644
--- a/sound/soc/codecs/tlv320aic26.c
+++ b/sound/soc/codecs/tlv320aic26.c
@@ -126,8 +126,7 @@ static int aic26_hw_params(struct snd_pcm_substream *substream,
 			   struct snd_pcm_hw_params *params,
 			   struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_codec *codec = dai->codec;
 	struct aic26 *aic26 = snd_soc_codec_get_drvdata(codec);
 	int fsref, divisor, wlen, pval, jval, dval, qval;
 	u16 reg;
diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 8d20f6e..bde2d1a 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -802,8 +802,7 @@ static int aic3x_hw_params(struct snd_pcm_substream *substream,
 			   struct snd_pcm_hw_params *params,
 			   struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec =rtd->codec;
+	struct snd_soc_codec *codec = dai->codec;
 	struct aic3x_priv *aic3x = snd_soc_codec_get_drvdata(codec);
 	int codec_clk = 0, bypass_pll = 0, fsref, last_clk = 0;
 	u8 data, j, r, p, pll_q, pll_p = 1, pll_r = 1, pll_j = 1;
diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index 4587ddd..0dd41077 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -62,8 +62,10 @@
 #define UTHR_FROM_PERIOD_SIZE(samples, playrate, burstrate) \
 	(((samples)*5000) / (((burstrate)*5000) / ((burstrate) - (playrate))))
 
-static void dac33_calculate_times(struct snd_pcm_substream *substream);
-static int dac33_prepare_chip(struct snd_pcm_substream *substream);
+static void dac33_calculate_times(struct snd_pcm_substream *substream,
+				  struct snd_soc_codec *codec);
+static int dac33_prepare_chip(struct snd_pcm_substream *substream,
+			      struct snd_soc_codec *codec);
 
 enum dac33_state {
 	DAC33_IDLE = 0,
@@ -427,8 +429,8 @@ static int dac33_playback_event(struct snd_soc_dapm_widget *w,
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
 		if (likely(dac33->substream)) {
-			dac33_calculate_times(dac33->substream);
-			dac33_prepare_chip(dac33->substream);
+			dac33_calculate_times(dac33->substream, w->codec);
+			dac33_prepare_chip(dac33->substream, w->codec);
 		}
 		break;
 	case SND_SOC_DAPM_POST_PMD:
@@ -799,8 +801,7 @@ static void dac33_oscwait(struct snd_soc_codec *codec)
 static int dac33_startup(struct snd_pcm_substream *substream,
 			   struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_codec *codec = dai->codec;
 	struct tlv320dac33_priv *dac33 = snd_soc_codec_get_drvdata(codec);
 
 	/* Stream started, save the substream pointer */
@@ -812,8 +813,7 @@ static int dac33_startup(struct snd_pcm_substream *substream,
 static void dac33_shutdown(struct snd_pcm_substream *substream,
 			     struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_codec *codec = dai->codec;
 	struct tlv320dac33_priv *dac33 = snd_soc_codec_get_drvdata(codec);
 
 	dac33->substream = NULL;
@@ -825,8 +825,7 @@ static int dac33_hw_params(struct snd_pcm_substream *substream,
 			   struct snd_pcm_hw_params *params,
 			   struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_codec *codec = dai->codec;
 	struct tlv320dac33_priv *dac33 = snd_soc_codec_get_drvdata(codec);
 
 	/* Check parameters for validity */
@@ -868,10 +867,9 @@ static int dac33_hw_params(struct snd_pcm_substream *substream,
  * writes happens in different order, than dac33 might end up in unknown state.
  * Use the known, working sequence of register writes to initialize the dac33.
  */
-static int dac33_prepare_chip(struct snd_pcm_substream *substream)
+static int dac33_prepare_chip(struct snd_pcm_substream *substream,
+			      struct snd_soc_codec *codec)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->codec;
 	struct tlv320dac33_priv *dac33 = snd_soc_codec_get_drvdata(codec);
 	unsigned int oscset, ratioset, pwr_ctrl, reg_tmp;
 	u8 aictrl_a, aictrl_b, fifoctrl_a;
@@ -1067,10 +1065,9 @@ static int dac33_prepare_chip(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static void dac33_calculate_times(struct snd_pcm_substream *substream)
+static void dac33_calculate_times(struct snd_pcm_substream *substream,
+				  struct snd_soc_codec *codec)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->codec;
 	struct tlv320dac33_priv *dac33 = snd_soc_codec_get_drvdata(codec);
 	unsigned int period_size = substream->runtime->period_size;
 	unsigned int rate = substream->runtime->rate;
@@ -1128,8 +1125,7 @@ static void dac33_calculate_times(struct snd_pcm_substream *substream)
 static int dac33_pcm_trigger(struct snd_pcm_substream *substream, int cmd,
 			     struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_codec *codec = dai->codec;
 	struct tlv320dac33_priv *dac33 = snd_soc_codec_get_drvdata(codec);
 	int ret = 0;
 
@@ -1161,8 +1157,7 @@ static snd_pcm_sframes_t dac33_dai_delay(
 			struct snd_pcm_substream *substream,
 			struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_codec *codec = dai->codec;
 	struct tlv320dac33_priv *dac33 = snd_soc_codec_get_drvdata(codec);
 	unsigned long long t0, t1, t_now;
 	unsigned int time_delta, uthr;
diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 170cf9a..391fcfc 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -1685,8 +1685,7 @@ static void twl4030_tdm_enable(struct snd_soc_codec *codec, int direction,
 static int twl4030_startup(struct snd_pcm_substream *substream,
 			   struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_codec *codec = dai->codec;
 	struct twl4030_priv *twl4030 = snd_soc_codec_get_drvdata(codec);
 
 	if (twl4030->master_substream) {
@@ -1715,8 +1714,7 @@ static int twl4030_startup(struct snd_pcm_substream *substream,
 static void twl4030_shutdown(struct snd_pcm_substream *substream,
 			     struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_codec *codec = dai->codec;
 	struct twl4030_priv *twl4030 = snd_soc_codec_get_drvdata(codec);
 
 	if (twl4030->master_substream == substream)
@@ -1740,8 +1738,7 @@ static int twl4030_hw_params(struct snd_pcm_substream *substream,
 			   struct snd_pcm_hw_params *params,
 			   struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_codec *codec = dai->codec;
 	struct twl4030_priv *twl4030 = snd_soc_codec_get_drvdata(codec);
 	u8 mode, old_mode, format, old_format;
 
@@ -1974,8 +1971,7 @@ static void twl4030_voice_enable(struct snd_soc_codec *codec, int direction,
 static int twl4030_voice_startup(struct snd_pcm_substream *substream,
 		struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_codec *codec = dai->codec;
 	struct twl4030_priv *twl4030 = snd_soc_codec_get_drvdata(codec);
 	u8 mode;
 
@@ -2007,8 +2003,7 @@ static int twl4030_voice_startup(struct snd_pcm_substream *substream,
 static void twl4030_voice_shutdown(struct snd_pcm_substream *substream,
 				struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_codec *codec = dai->codec;
 
 	/* Enable voice digital filters */
 	twl4030_voice_enable(codec, substream->stream, 0);
@@ -2017,8 +2012,7 @@ static void twl4030_voice_shutdown(struct snd_pcm_substream *substream,
 static int twl4030_voice_hw_params(struct snd_pcm_substream *substream,
 		struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_codec *codec = dai->codec;
 	struct twl4030_priv *twl4030 = snd_soc_codec_get_drvdata(codec);
 	u8 old_mode, mode;
 
diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 2d8c6b8..ccbc88a 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -1340,8 +1340,7 @@ static int twl6040_set_bias_level(struct snd_soc_codec *codec,
 static int twl6040_startup(struct snd_pcm_substream *substream,
 			struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_codec *codec = dai->codec;
 	struct twl6040_data *priv = snd_soc_codec_get_drvdata(codec);
 
 	snd_pcm_hw_constraint_list(substream->runtime, 0,
@@ -1355,8 +1354,7 @@ static int twl6040_hw_params(struct snd_pcm_substream *substream,
 			struct snd_pcm_hw_params *params,
 			struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_codec *codec = dai->codec;
 	struct twl6040_data *priv = snd_soc_codec_get_drvdata(codec);
 	int rate;
 
@@ -1392,8 +1390,7 @@ static int twl6040_hw_params(struct snd_pcm_substream *substream,
 static int twl6040_prepare(struct snd_pcm_substream *substream,
 			struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_codec *codec = dai->codec;
 	struct twl6040 *twl6040 = codec->control_data;
 	struct twl6040_data *priv = snd_soc_codec_get_drvdata(codec);
 	int ret;
diff --git a/sound/soc/codecs/uda134x.c b/sound/soc/codecs/uda134x.c
index 797b0dd..6c3d43b 100644
--- a/sound/soc/codecs/uda134x.c
+++ b/sound/soc/codecs/uda134x.c
@@ -159,8 +159,7 @@ static int uda134x_mute(struct snd_soc_dai *dai, int mute)
 static int uda134x_startup(struct snd_pcm_substream *substream,
 	struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec =rtd->codec;
+	struct snd_soc_codec *codec = dai->codec;
 	struct uda134x_priv *uda134x = snd_soc_codec_get_drvdata(codec);
 	struct snd_pcm_runtime *master_runtime;
 
@@ -191,8 +190,7 @@ static int uda134x_startup(struct snd_pcm_substream *substream,
 static void uda134x_shutdown(struct snd_pcm_substream *substream,
 	struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_codec *codec = dai->codec;
 	struct uda134x_priv *uda134x = snd_soc_codec_get_drvdata(codec);
 
 	if (uda134x->master_substream == substream)
diff --git a/sound/soc/codecs/uda1380.c b/sound/soc/codecs/uda1380.c
index 4f1b23d..2502214 100644
--- a/sound/soc/codecs/uda1380.c
+++ b/sound/soc/codecs/uda1380.c
@@ -502,8 +502,7 @@ static int uda1380_set_dai_fmt_capture(struct snd_soc_dai *codec_dai,
 static int uda1380_trigger(struct snd_pcm_substream *substream, int cmd,
 		struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_codec *codec = dai->codec;
 	struct uda1380_priv *uda1380 = snd_soc_codec_get_drvdata(codec);
 	int mixer = uda1380_read_reg_cache(codec, UDA1380_MIXER);
 
@@ -528,8 +527,7 @@ static int uda1380_pcm_hw_params(struct snd_pcm_substream *substream,
 				 struct snd_pcm_hw_params *params,
 				 struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_codec *codec = dai->codec;
 	u16 clk = uda1380_read_reg_cache(codec, UDA1380_CLK);
 
 	/* set WSPLL power and divider if running from this clock */
diff --git a/sound/soc/codecs/wl1273.c b/sound/soc/codecs/wl1273.c
index 3d868dc..7b24d6d 100644
--- a/sound/soc/codecs/wl1273.c
+++ b/sound/soc/codecs/wl1273.c
@@ -293,8 +293,7 @@ static const struct snd_kcontrol_new wl1273_controls[] = {
 static int wl1273_startup(struct snd_pcm_substream *substream,
 			  struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_codec *codec = dai->codec;
 	struct wl1273_priv *wl1273 = snd_soc_codec_get_drvdata(codec);
 
 	switch (wl1273->mode) {
@@ -329,8 +328,7 @@ static int wl1273_hw_params(struct snd_pcm_substream *substream,
 			    struct snd_pcm_hw_params *params,
 			    struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct wl1273_priv *wl1273 = snd_soc_codec_get_drvdata(rtd->codec);
+	struct wl1273_priv *wl1273 = snd_soc_codec_get_drvdata(dai->codec);
 	struct wl1273_core *core = wl1273->core;
 	unsigned int rate, width, r;
 
diff --git a/sound/soc/codecs/wm8400.c b/sound/soc/codecs/wm8400.c
index 898979d..fcc0cac 100644
--- a/sound/soc/codecs/wm8400.c
+++ b/sound/soc/codecs/wm8400.c
@@ -1145,8 +1145,7 @@ static int wm8400_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params,
 	struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_codec *codec = dai->codec;
 	u16 audio1 = wm8400_read(codec, WM8400_AUDIO_INTERFACE_1);
 
 	audio1 &= ~WM8400_AIF_WL_MASK;
diff --git a/sound/soc/codecs/wm8510.c b/sound/soc/codecs/wm8510.c
index 9166126..56a0495 100644
--- a/sound/soc/codecs/wm8510.c
+++ b/sound/soc/codecs/wm8510.c
@@ -392,8 +392,7 @@ static int wm8510_pcm_hw_params(struct snd_pcm_substream *substream,
 				struct snd_pcm_hw_params *params,
 				struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_codec *codec = dai->codec;
 	u16 iface = snd_soc_read(codec, WM8510_IFACE) & 0x19f;
 	u16 adn = snd_soc_read(codec, WM8510_ADD) & 0x1f1;
 
diff --git a/sound/soc/codecs/wm8523.c b/sound/soc/codecs/wm8523.c
index 7fea2c3..1c3ffb2 100644
--- a/sound/soc/codecs/wm8523.c
+++ b/sound/soc/codecs/wm8523.c
@@ -145,8 +145,7 @@ static int wm8523_hw_params(struct snd_pcm_substream *substream,
 			    struct snd_pcm_hw_params *params,
 			    struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_codec *codec = dai->codec;
 	struct wm8523_priv *wm8523 = snd_soc_codec_get_drvdata(codec);
 	int i;
 	u16 aifctrl1 = snd_soc_read(codec, WM8523_AIF_CTRL1);
diff --git a/sound/soc/codecs/wm8728.c b/sound/soc/codecs/wm8728.c
index fc3d59e..1467f97 100644
--- a/sound/soc/codecs/wm8728.c
+++ b/sound/soc/codecs/wm8728.c
@@ -88,8 +88,7 @@ static int wm8728_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params,
 	struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_codec *codec = dai->codec;
 	u16 dac = snd_soc_read(codec, WM8728_DACCTL);
 
 	dac &= ~0x18;
diff --git a/sound/soc/codecs/wm8737.c b/sound/soc/codecs/wm8737.c
index 4fe9d19..d052012 100644
--- a/sound/soc/codecs/wm8737.c
+++ b/sound/soc/codecs/wm8737.c
@@ -329,8 +329,7 @@ static int wm8737_hw_params(struct snd_pcm_substream *substream,
 			    struct snd_pcm_hw_params *params,
 			    struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_codec *codec = dai->codec;
 	struct wm8737_priv *wm8737 = snd_soc_codec_get_drvdata(codec);
 	int i;
 	u16 clocking = 0;
diff --git a/sound/soc/codecs/wm8741.c b/sound/soc/codecs/wm8741.c
index 3941f50..6e849cb 100644
--- a/sound/soc/codecs/wm8741.c
+++ b/sound/soc/codecs/wm8741.c
@@ -203,8 +203,7 @@ static int wm8741_hw_params(struct snd_pcm_substream *substream,
 			    struct snd_pcm_hw_params *params,
 			    struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_codec *codec = dai->codec;
 	struct wm8741_priv *wm8741 = snd_soc_codec_get_drvdata(codec);
 	u16 iface = snd_soc_read(codec, WM8741_FORMAT_CONTROL) & 0x1FC;
 	int i;
diff --git a/sound/soc/codecs/wm8750.c b/sound/soc/codecs/wm8750.c
index e4c50ce..89151ca 100644
--- a/sound/soc/codecs/wm8750.c
+++ b/sound/soc/codecs/wm8750.c
@@ -547,8 +547,7 @@ static int wm8750_pcm_hw_params(struct snd_pcm_substream *substream,
 				struct snd_pcm_hw_params *params,
 				struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_codec *codec = dai->codec;
 	struct wm8750_priv *wm8750 = snd_soc_codec_get_drvdata(codec);
 	u16 iface = snd_soc_read(codec, WM8750_IFACE) & 0x1f3;
 	u16 srate = snd_soc_read(codec, WM8750_SRATE) & 0x1c0;
diff --git a/sound/soc/codecs/wm8753.c b/sound/soc/codecs/wm8753.c
index e27e7b6..a26482c 100644
--- a/sound/soc/codecs/wm8753.c
+++ b/sound/soc/codecs/wm8753.c
@@ -931,8 +931,7 @@ static int wm8753_pcm_hw_params(struct snd_pcm_substream *substream,
 				struct snd_pcm_hw_params *params,
 				struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_codec *codec = dai->codec;
 	struct wm8753_priv *wm8753 = snd_soc_codec_get_drvdata(codec);
 	u16 voice = snd_soc_read(codec, WM8753_PCM) & 0x01f3;
 	u16 srate = snd_soc_read(codec, WM8753_SRATE1) & 0x017f;
@@ -1161,8 +1160,7 @@ static int wm8753_i2s_hw_params(struct snd_pcm_substream *substream,
 				struct snd_pcm_hw_params *params,
 				struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_codec *codec = dai->codec;
 	struct wm8753_priv *wm8753 = snd_soc_codec_get_drvdata(codec);
 	u16 srate = snd_soc_read(codec, WM8753_SRATE1) & 0x01c0;
 	u16 hifi = snd_soc_read(codec, WM8753_HIFI) & 0x01f3;
diff --git a/sound/soc/codecs/wm8900.c b/sound/soc/codecs/wm8900.c
index f18c554..077c962 100644
--- a/sound/soc/codecs/wm8900.c
+++ b/sound/soc/codecs/wm8900.c
@@ -610,8 +610,7 @@ static int wm8900_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params,
 	struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_codec *codec = dai->codec;
 	u16 reg;
 
 	reg = snd_soc_read(codec, WM8900_REG_AUDIO1) & ~0x60;
diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index 302c76a..8365b43 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -1453,8 +1453,7 @@ static int wm8903_hw_params(struct snd_pcm_substream *substream,
 			    struct snd_pcm_hw_params *params,
 			    struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec =rtd->codec;
+	struct snd_soc_codec *codec = dai->codec;
 	struct wm8903_priv *wm8903 = snd_soc_codec_get_drvdata(codec);
 	int fs = params_rate(params);
 	int bclk;
diff --git a/sound/soc/codecs/wm8940.c b/sound/soc/codecs/wm8940.c
index d2883af..481a3d9 100644
--- a/sound/soc/codecs/wm8940.c
+++ b/sound/soc/codecs/wm8940.c
@@ -371,8 +371,7 @@ static int wm8940_i2s_hw_params(struct snd_pcm_substream *substream,
 				struct snd_pcm_hw_params *params,
 				struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_codec *codec = dai->codec;
 	u16 iface = snd_soc_read(codec, WM8940_IFACE) & 0xFD9F;
 	u16 addcntrl = snd_soc_read(codec, WM8940_ADDCNTRL) & 0xFFF1;
 	u16 companding =  snd_soc_read(codec,
diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index 840d720..8bc659d 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -505,8 +505,7 @@ static int wm8960_hw_params(struct snd_pcm_substream *substream,
 			    struct snd_pcm_hw_params *params,
 			    struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_codec *codec = dai->codec;
 	struct wm8960_priv *wm8960 = snd_soc_codec_get_drvdata(codec);
 	u16 iface = snd_soc_read(codec, WM8960_IFACE1) & 0xfff3;
 	int i;
diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 7dba006..28a0fe2 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -2534,8 +2534,7 @@ static int wm8962_hw_params(struct snd_pcm_substream *substream,
 			    struct snd_pcm_hw_params *params,
 			    struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_codec *codec = dai->codec;
 	struct wm8962_priv *wm8962 = snd_soc_codec_get_drvdata(codec);
 	int i;
 	int aif0 = 0;
diff --git a/sound/soc/codecs/wm8971.c b/sound/soc/codecs/wm8971.c
index 28fe59e..eef783f 100644
--- a/sound/soc/codecs/wm8971.c
+++ b/sound/soc/codecs/wm8971.c
@@ -478,8 +478,7 @@ static int wm8971_pcm_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params,
 	struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_codec *codec = dai->codec;
 	struct wm8971_priv *wm8971 = snd_soc_codec_get_drvdata(codec);
 	u16 iface = snd_soc_read(codec, WM8971_IFACE) & 0x1f3;
 	u16 srate = snd_soc_read(codec, WM8971_SRATE) & 0x1c0;
diff --git a/sound/soc/codecs/wm8978.c b/sound/soc/codecs/wm8978.c
index 72d5fdc..a5be3ad 100644
--- a/sound/soc/codecs/wm8978.c
+++ b/sound/soc/codecs/wm8978.c
@@ -723,8 +723,7 @@ static int wm8978_hw_params(struct snd_pcm_substream *substream,
 			    struct snd_pcm_hw_params *params,
 			    struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_codec *codec = dai->codec;
 	struct wm8978_priv *wm8978 = snd_soc_codec_get_drvdata(codec);
 	/* Word length mask = 0x60 */
 	u16 iface_ctl = snd_soc_read(codec, WM8978_AUDIO_INTERFACE) & ~0x60;
diff --git a/sound/soc/codecs/wm8988.c b/sound/soc/codecs/wm8988.c
index 6cdf6a2b..1d4c5cf 100644
--- a/sound/soc/codecs/wm8988.c
+++ b/sound/soc/codecs/wm8988.c
@@ -668,8 +668,7 @@ static int wm8988_pcm_hw_params(struct snd_pcm_substream *substream,
 				struct snd_pcm_hw_params *params,
 				struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_codec *codec = dai->codec;
 	struct wm8988_priv *wm8988 = snd_soc_codec_get_drvdata(codec);
 	u16 iface = snd_soc_read(codec, WM8988_IFACE) & 0x1f3;
 	u16 srate = snd_soc_read(codec, WM8988_SRATE) & 0x180;
diff --git a/sound/soc/codecs/wm8990.c b/sound/soc/codecs/wm8990.c
index 9d24235..db63c97 100644
--- a/sound/soc/codecs/wm8990.c
+++ b/sound/soc/codecs/wm8990.c
@@ -1112,8 +1112,7 @@ static int wm8990_hw_params(struct snd_pcm_substream *substream,
 			    struct snd_pcm_hw_params *params,
 			    struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_codec *codec = dai->codec;
 	u16 audio1 = snd_soc_read(codec, WM8990_AUDIO_INTERFACE_1);
 
 	audio1 &= ~WM8990_AIF_WL_MASK;
diff --git a/sound/soc/codecs/wm9705.c b/sound/soc/codecs/wm9705.c
index cacc6a8..7c09593 100644
--- a/sound/soc/codecs/wm9705.c
+++ b/sound/soc/codecs/wm9705.c
@@ -236,9 +236,7 @@ static int ac97_write(struct snd_soc_codec *codec, unsigned int reg,
 static int ac97_prepare(struct snd_pcm_substream *substream,
 			struct snd_soc_dai *dai)
 {
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_codec *codec = dai->codec;
 	int reg;
 	u16 vra;
 
diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
index b342ae5..2603863 100644
--- a/sound/soc/codecs/wm9712.c
+++ b/sound/soc/codecs/wm9712.c
@@ -467,9 +467,7 @@ static int ac97_write(struct snd_soc_codec *codec, unsigned int reg,
 static int ac97_prepare(struct snd_pcm_substream *substream,
 			struct snd_soc_dai *dai)
 {
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec =rtd->codec;
+	struct snd_soc_codec *codec = dai->codec;
 	int reg;
 	u16 vra;
 
@@ -487,9 +485,7 @@ static int ac97_prepare(struct snd_pcm_substream *substream,
 static int ac97_aux_prepare(struct snd_pcm_substream *substream,
 			    struct snd_soc_dai *dai)
 {
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_codec *codec = dai->codec;
 	u16 vra, xsle;
 
 	vra = ac97_read(codec, AC97_EXTENDED_STATUS);
-- 
1.7.9.1
