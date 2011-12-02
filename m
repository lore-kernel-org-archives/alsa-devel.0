From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: Drop unused state parameter from CODEC
	suspend callback
Date: Fri, 2 Dec 2011 10:18:28 +0100
Message-ID: <1322817508-23150-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from AM1EHSOBE003.bigfish.com (am1ehsobe003.messaging.microsoft.com
	[213.199.154.206])
	by alsa0.perex.cz (Postfix) with ESMTP id 55382246B6
	for <alsa-devel@alsa-project.org>; Fri,  2 Dec 2011 10:18:20 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The existence of this parameter is purely historical. None of the CODEC drivers
uses it and we always pass in the same value anyway, so it should be safe to
remove it.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc.h              |    3 +--
 sound/soc/codecs/ac97.c          |    2 +-
 sound/soc/codecs/ad1836.c        |    2 +-
 sound/soc/codecs/adau1373.c      |    2 +-
 sound/soc/codecs/adav80x.c       |    2 +-
 sound/soc/codecs/ak4535.c        |    2 +-
 sound/soc/codecs/ak4641.c        |    2 +-
 sound/soc/codecs/alc5623.c       |    2 +-
 sound/soc/codecs/alc5632.c       |    2 +-
 sound/soc/codecs/cs4270.c        |    2 +-
 sound/soc/codecs/cs4271.c        |    2 +-
 sound/soc/codecs/cs42l73.c       |    2 +-
 sound/soc/codecs/jz4740.c        |    2 +-
 sound/soc/codecs/max98088.c      |    2 +-
 sound/soc/codecs/max98095.c      |    2 +-
 sound/soc/codecs/max9850.c       |    2 +-
 sound/soc/codecs/pcm3008.c       |    2 +-
 sound/soc/codecs/rt5631.c        |    2 +-
 sound/soc/codecs/sgtl5000.c      |    2 +-
 sound/soc/codecs/ssm2602.c       |    2 +-
 sound/soc/codecs/sta32x.c        |    2 +-
 sound/soc/codecs/stac9766.c      |    3 +--
 sound/soc/codecs/tlv320aic23.c   |    3 +--
 sound/soc/codecs/tlv320aic32x4.c |    2 +-
 sound/soc/codecs/tlv320aic3x.c   |    2 +-
 sound/soc/codecs/tlv320dac33.c   |    2 +-
 sound/soc/codecs/twl4030.c       |    2 +-
 sound/soc/codecs/twl6040.c       |    2 +-
 sound/soc/codecs/uda134x.c       |    3 +--
 sound/soc/codecs/uda1380.c       |    2 +-
 sound/soc/codecs/wm8350.c        |    2 +-
 sound/soc/codecs/wm8400.c        |    2 +-
 sound/soc/codecs/wm8510.c        |    2 +-
 sound/soc/codecs/wm8523.c        |    2 +-
 sound/soc/codecs/wm8711.c        |    2 +-
 sound/soc/codecs/wm8728.c        |    2 +-
 sound/soc/codecs/wm8731.c        |    2 +-
 sound/soc/codecs/wm8737.c        |    2 +-
 sound/soc/codecs/wm8750.c        |    2 +-
 sound/soc/codecs/wm8753.c        |    2 +-
 sound/soc/codecs/wm8770.c        |    2 +-
 sound/soc/codecs/wm8776.c        |    2 +-
 sound/soc/codecs/wm8804.c        |    2 +-
 sound/soc/codecs/wm8900.c        |    2 +-
 sound/soc/codecs/wm8903.c        |    2 +-
 sound/soc/codecs/wm8904.c        |    2 +-
 sound/soc/codecs/wm8940.c        |    2 +-
 sound/soc/codecs/wm8955.c        |    2 +-
 sound/soc/codecs/wm8960.c        |    2 +-
 sound/soc/codecs/wm8961.c        |    2 +-
 sound/soc/codecs/wm8971.c        |    2 +-
 sound/soc/codecs/wm8974.c        |    2 +-
 sound/soc/codecs/wm8978.c        |    2 +-
 sound/soc/codecs/wm8983.c        |    2 +-
 sound/soc/codecs/wm8985.c        |    2 +-
 sound/soc/codecs/wm8988.c        |    2 +-
 sound/soc/codecs/wm8990.c        |    2 +-
 sound/soc/codecs/wm8991.c        |    2 +-
 sound/soc/codecs/wm8993.c        |    2 +-
 sound/soc/codecs/wm8994.c        |    2 +-
 sound/soc/codecs/wm8995.c        |    2 +-
 sound/soc/codecs/wm9081.c        |    2 +-
 sound/soc/codecs/wm9090.c        |    2 +-
 sound/soc/codecs/wm9705.c        |    2 +-
 sound/soc/codecs/wm9712.c        |    3 +--
 sound/soc/codecs/wm9713.c        |    3 +--
 sound/soc/soc-core.c             |    2 +-
 67 files changed, 67 insertions(+), 73 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 737a4f4..d9aa66b 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -592,8 +592,7 @@ struct snd_soc_codec_driver {
 	/* driver ops */
 	int (*probe)(struct snd_soc_codec *);
 	int (*remove)(struct snd_soc_codec *);
-	int (*suspend)(struct snd_soc_codec *,
-			pm_message_t state);
+	int (*suspend)(struct snd_soc_codec *);
 	int (*resume)(struct snd_soc_codec *);
 
 	/* Default control and setup, added after probe() is run */
diff --git a/sound/soc/codecs/ac97.c b/sound/soc/codecs/ac97.c
index 221ec29..1bbad4c 100644
--- a/sound/soc/codecs/ac97.c
+++ b/sound/soc/codecs/ac97.c
@@ -99,7 +99,7 @@ static int ac97_soc_remove(struct snd_soc_codec *codec)
 }
 
 #ifdef CONFIG_PM
-static int ac97_soc_suspend(struct snd_soc_codec *codec, pm_message_t msg)
+static int ac97_soc_suspend(struct snd_soc_codec *codec)
 {
 	snd_ac97_suspend(codec->ac97);
 
diff --git a/sound/soc/codecs/ad1836.c b/sound/soc/codecs/ad1836.c
index fab0948..919322d 100644
--- a/sound/soc/codecs/ad1836.c
+++ b/sound/soc/codecs/ad1836.c
@@ -223,7 +223,7 @@ static struct snd_soc_dai_driver ad183x_dais[] = {
 };
 
 #ifdef CONFIG_PM
-static int ad1836_suspend(struct snd_soc_codec *codec, pm_message_t state)
+static int ad1836_suspend(struct snd_soc_codec *codec)
 {
 	/* reset clock control mode */
 	return snd_soc_update_bits(codec, AD1836_ADC_CTRL2,
diff --git a/sound/soc/codecs/adau1373.c b/sound/soc/codecs/adau1373.c
index 45c6302..637b114 100644
--- a/sound/soc/codecs/adau1373.c
+++ b/sound/soc/codecs/adau1373.c
@@ -1321,7 +1321,7 @@ static int adau1373_remove(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static int adau1373_suspend(struct snd_soc_codec *codec, pm_message_t state)
+static int adau1373_suspend(struct snd_soc_codec *codec)
 {
 	return adau1373_set_bias_level(codec, SND_SOC_BIAS_OFF);
 }
diff --git a/sound/soc/codecs/adav80x.c b/sound/soc/codecs/adav80x.c
index f9f0894..ebd7b37 100644
--- a/sound/soc/codecs/adav80x.c
+++ b/sound/soc/codecs/adav80x.c
@@ -798,7 +798,7 @@ static int adav80x_probe(struct snd_soc_codec *codec)
 	return adav80x_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 }
 
-static int adav80x_suspend(struct snd_soc_codec *codec, pm_message_t state)
+static int adav80x_suspend(struct snd_soc_codec *codec)
 {
 	return adav80x_set_bias_level(codec, SND_SOC_BIAS_OFF);
 }
diff --git a/sound/soc/codecs/ak4535.c b/sound/soc/codecs/ak4535.c
index e1f5310..96296fd 100644
--- a/sound/soc/codecs/ak4535.c
+++ b/sound/soc/codecs/ak4535.c
@@ -354,7 +354,7 @@ static struct snd_soc_dai_driver ak4535_dai = {
 	.ops = &ak4535_dai_ops,
 };
 
-static int ak4535_suspend(struct snd_soc_codec *codec, pm_message_t state)
+static int ak4535_suspend(struct snd_soc_codec *codec)
 {
 	ak4535_set_bias_level(codec, SND_SOC_BIAS_OFF);
 	return 0;
diff --git a/sound/soc/codecs/ak4641.c b/sound/soc/codecs/ak4641.c
index f53f314..9018470 100644
--- a/sound/soc/codecs/ak4641.c
+++ b/sound/soc/codecs/ak4641.c
@@ -498,7 +498,7 @@ static struct snd_soc_dai_driver ak4641_dai[] = {
 },
 };
 
-static int ak4641_suspend(struct snd_soc_codec *codec, pm_message_t state)
+static int ak4641_suspend(struct snd_soc_codec *codec)
 {
 	ak4641_set_bias_level(codec, SND_SOC_BIAS_OFF);
 	return 0;
diff --git a/sound/soc/codecs/alc5623.c b/sound/soc/codecs/alc5623.c
index 6a5c001..da97f02 100644
--- a/sound/soc/codecs/alc5623.c
+++ b/sound/soc/codecs/alc5623.c
@@ -868,7 +868,7 @@ static struct snd_soc_dai_driver alc5623_dai = {
 	.ops = &alc5623_dai_ops,
 };
 
-static int alc5623_suspend(struct snd_soc_codec *codec, pm_message_t mesg)
+static int alc5623_suspend(struct snd_soc_codec *codec)
 {
 	alc5623_set_bias_level(codec, SND_SOC_BIAS_OFF);
 	return 0;
diff --git a/sound/soc/codecs/alc5632.c b/sound/soc/codecs/alc5632.c
index 3f750de..08613c7 100644
--- a/sound/soc/codecs/alc5632.c
+++ b/sound/soc/codecs/alc5632.c
@@ -956,7 +956,7 @@ static struct snd_soc_dai_driver alc5632_dai = {
 };
 
 #ifdef CONFIG_PM
-static int alc5632_suspend(struct snd_soc_codec *codec, pm_message_t mesg)
+static int alc5632_suspend(struct snd_soc_codec *codec)
 {
 	alc5632_set_bias_level(codec, SND_SOC_BIAS_OFF);
 	return 0;
diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
index dc77ff7..fef0f48 100644
--- a/sound/soc/codecs/cs4270.c
+++ b/sound/soc/codecs/cs4270.c
@@ -578,7 +578,7 @@ static int cs4270_remove(struct snd_soc_codec *codec)
  * and all registers are written back to the hardware when resuming.
  */
 
-static int cs4270_soc_suspend(struct snd_soc_codec *codec, pm_message_t mesg)
+static int cs4270_soc_suspend(struct snd_soc_codec *codec)
 {
 	struct cs4270_private *cs4270 = snd_soc_codec_get_drvdata(codec);
 	int reg, ret;
diff --git a/sound/soc/codecs/cs4271.c b/sound/soc/codecs/cs4271.c
index a6f77a8..f6fe846 100644
--- a/sound/soc/codecs/cs4271.c
+++ b/sound/soc/codecs/cs4271.c
@@ -430,7 +430,7 @@ static struct snd_soc_dai_driver cs4271_dai = {
 };
 
 #ifdef CONFIG_PM
-static int cs4271_soc_suspend(struct snd_soc_codec *codec, pm_message_t mesg)
+static int cs4271_soc_suspend(struct snd_soc_codec *codec)
 {
 	int ret;
 	/* Set power-down bit */
diff --git a/sound/soc/codecs/cs42l73.c b/sound/soc/codecs/cs42l73.c
index da3125a..9d38db8 100644
--- a/sound/soc/codecs/cs42l73.c
+++ b/sound/soc/codecs/cs42l73.c
@@ -1262,7 +1262,7 @@ static struct snd_soc_dai_driver cs42l73_dai[] = {
 	 }
 };
 
-static int cs42l73_suspend(struct snd_soc_codec *codec, pm_message_t state)
+static int cs42l73_suspend(struct snd_soc_codec *codec)
 {
 	cs42l73_set_bias_level(codec, SND_SOC_BIAS_OFF);
 
diff --git a/sound/soc/codecs/jz4740.c b/sound/soc/codecs/jz4740.c
index 4fca8bc..517e2a5 100644
--- a/sound/soc/codecs/jz4740.c
+++ b/sound/soc/codecs/jz4740.c
@@ -311,7 +311,7 @@ static int jz4740_codec_dev_remove(struct snd_soc_codec *codec)
 
 #ifdef CONFIG_PM_SLEEP
 
-static int jz4740_codec_suspend(struct snd_soc_codec *codec, pm_message_t state)
+static int jz4740_codec_suspend(struct snd_soc_codec *codec)
 {
 	return jz4740_codec_set_bias_level(codec, SND_SOC_BIAS_OFF);
 }
diff --git a/sound/soc/codecs/max98088.c b/sound/soc/codecs/max98088.c
index 9b6036e..ba4f6f1 100644
--- a/sound/soc/codecs/max98088.c
+++ b/sound/soc/codecs/max98088.c
@@ -1946,7 +1946,7 @@ static void max98088_handle_pdata(struct snd_soc_codec *codec)
 }
 
 #ifdef CONFIG_PM
-static int max98088_suspend(struct snd_soc_codec *codec, pm_message_t state)
+static int max98088_suspend(struct snd_soc_codec *codec)
 {
        max98088_set_bias_level(codec, SND_SOC_BIAS_OFF);
 
diff --git a/sound/soc/codecs/max98095.c b/sound/soc/codecs/max98095.c
index 01f4ad7..c69dd02 100644
--- a/sound/soc/codecs/max98095.c
+++ b/sound/soc/codecs/max98095.c
@@ -2174,7 +2174,7 @@ static void max98095_handle_pdata(struct snd_soc_codec *codec)
 }
 
 #ifdef CONFIG_PM
-static int max98095_suspend(struct snd_soc_codec *codec, pm_message_t state)
+static int max98095_suspend(struct snd_soc_codec *codec)
 {
 	max98095_set_bias_level(codec, SND_SOC_BIAS_OFF);
 
diff --git a/sound/soc/codecs/max9850.c b/sound/soc/codecs/max9850.c
index 94c2b58..7dfd6e8 100644
--- a/sound/soc/codecs/max9850.c
+++ b/sound/soc/codecs/max9850.c
@@ -273,7 +273,7 @@ static struct snd_soc_dai_driver max9850_dai = {
 };
 
 #ifdef CONFIG_PM
-static int max9850_suspend(struct snd_soc_codec *codec, pm_message_t state)
+static int max9850_suspend(struct snd_soc_codec *codec)
 {
 	max9850_set_bias_level(codec, SND_SOC_BIAS_OFF);
 
diff --git a/sound/soc/codecs/pcm3008.c b/sound/soc/codecs/pcm3008.c
index b12d01f..edcaa7e 100644
--- a/sound/soc/codecs/pcm3008.c
+++ b/sound/soc/codecs/pcm3008.c
@@ -118,7 +118,7 @@ static int pcm3008_soc_remove(struct snd_soc_codec *codec)
 }
 
 #ifdef CONFIG_PM
-static int pcm3008_soc_suspend(struct snd_soc_codec *codec, pm_message_t msg)
+static int pcm3008_soc_suspend(struct snd_soc_codec *codec)
 {
 	struct pcm3008_setup_data *setup = codec->dev->platform_data;
 
diff --git a/sound/soc/codecs/rt5631.c b/sound/soc/codecs/rt5631.c
index 9fd50bd..f6e4f5e 100644
--- a/sound/soc/codecs/rt5631.c
+++ b/sound/soc/codecs/rt5631.c
@@ -1641,7 +1641,7 @@ static int rt5631_remove(struct snd_soc_codec *codec)
 }
 
 #ifdef CONFIG_PM
-static int rt5631_suspend(struct snd_soc_codec *codec, pm_message_t state)
+static int rt5631_suspend(struct snd_soc_codec *codec)
 {
 	rt5631_set_bias_level(codec, SND_SOC_BIAS_OFF);
 	return 0;
diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index ff0a107..2501757 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -967,7 +967,7 @@ static int sgtl5000_volatile_register(struct snd_soc_codec *codec,
 }
 
 #ifdef CONFIG_SUSPEND
-static int sgtl5000_suspend(struct snd_soc_codec *codec, pm_message_t state)
+static int sgtl5000_suspend(struct snd_soc_codec *codec)
 {
 	sgtl5000_set_bias_level(codec, SND_SOC_BIAS_OFF);
 
diff --git a/sound/soc/codecs/ssm2602.c b/sound/soc/codecs/ssm2602.c
index 0d43e4b..7dfc7b0 100644
--- a/sound/soc/codecs/ssm2602.c
+++ b/sound/soc/codecs/ssm2602.c
@@ -523,7 +523,7 @@ static struct snd_soc_dai_driver ssm2602_dai = {
 	.ops = &ssm2602_dai_ops,
 };
 
-static int ssm2602_suspend(struct snd_soc_codec *codec, pm_message_t state)
+static int ssm2602_suspend(struct snd_soc_codec *codec)
 {
 	ssm2602_set_bias_level(codec, SND_SOC_BIAS_OFF);
 	return 0;
diff --git a/sound/soc/codecs/sta32x.c b/sound/soc/codecs/sta32x.c
index b3d1c78..6648af6 100644
--- a/sound/soc/codecs/sta32x.c
+++ b/sound/soc/codecs/sta32x.c
@@ -801,7 +801,7 @@ static struct snd_soc_dai_driver sta32x_dai = {
 };
 
 #ifdef CONFIG_PM
-static int sta32x_suspend(struct snd_soc_codec *codec, pm_message_t state)
+static int sta32x_suspend(struct snd_soc_codec *codec)
 {
 	sta32x_set_bias_level(codec, SND_SOC_BIAS_OFF);
 	return 0;
diff --git a/sound/soc/codecs/stac9766.c b/sound/soc/codecs/stac9766.c
index 5581953..e34969c 100644
--- a/sound/soc/codecs/stac9766.c
+++ b/sound/soc/codecs/stac9766.c
@@ -256,8 +256,7 @@ static int stac9766_reset(struct snd_soc_codec *codec, int try_warm)
 	return 0;
 }
 
-static int stac9766_codec_suspend(struct snd_soc_codec *codec,
-				  pm_message_t state)
+static int stac9766_codec_suspend(struct snd_soc_codec *codec)
 {
 	stac9766_set_bias_level(codec, SND_SOC_BIAS_OFF);
 	return 0;
diff --git a/sound/soc/codecs/tlv320aic23.c b/sound/soc/codecs/tlv320aic23.c
index cba798e..60d08ae 100644
--- a/sound/soc/codecs/tlv320aic23.c
+++ b/sound/soc/codecs/tlv320aic23.c
@@ -528,8 +528,7 @@ static struct snd_soc_dai_driver tlv320aic23_dai = {
 	.ops = &tlv320aic23_dai_ops,
 };
 
-static int tlv320aic23_suspend(struct snd_soc_codec *codec,
-			       pm_message_t state)
+static int tlv320aic23_suspend(struct snd_soc_codec *codec)
 {
 	tlv320aic23_set_bias_level(codec, SND_SOC_BIAS_OFF);
 
diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index f553375..81a26e1 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -621,7 +621,7 @@ static struct snd_soc_dai_driver aic32x4_dai = {
 	.symmetric_rates = 1,
 };
 
-static int aic32x4_suspend(struct snd_soc_codec *codec, pm_message_t state)
+static int aic32x4_suspend(struct snd_soc_codec *codec)
 {
 	aic32x4_set_bias_level(codec, SND_SOC_BIAS_OFF);
 	return 0;
diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 21625dd..6f963c5 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -1268,7 +1268,7 @@ static struct snd_soc_dai_driver aic3x_dai = {
 	.symmetric_rates = 1,
 };
 
-static int aic3x_suspend(struct snd_soc_codec *codec, pm_message_t state)
+static int aic3x_suspend(struct snd_soc_codec *codec)
 {
 	aic3x_set_bias_level(codec, SND_SOC_BIAS_OFF);
 
diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index 6b0f0e2..c7a61fb 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -1460,7 +1460,7 @@ static int dac33_soc_remove(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static int dac33_soc_suspend(struct snd_soc_codec *codec, pm_message_t state)
+static int dac33_soc_suspend(struct snd_soc_codec *codec)
 {
 	dac33_set_bias_level(codec, SND_SOC_BIAS_OFF);
 
diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 61d8a90..18e7101 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -2202,7 +2202,7 @@ static struct snd_soc_dai_driver twl4030_dai[] = {
 },
 };
 
-static int twl4030_soc_suspend(struct snd_soc_codec *codec, pm_message_t state)
+static int twl4030_soc_suspend(struct snd_soc_codec *codec)
 {
 	twl4030_set_bias_level(codec, SND_SOC_BIAS_OFF);
 	return 0;
diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index a4a65dc..3376e6f 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -1470,7 +1470,7 @@ static struct snd_soc_dai_driver twl6040_dai[] = {
 };
 
 #ifdef CONFIG_PM
-static int twl6040_suspend(struct snd_soc_codec *codec, pm_message_t state)
+static int twl6040_suspend(struct snd_soc_codec *codec)
 {
 	twl6040_set_bias_level(codec, SND_SOC_BIAS_OFF);
 
diff --git a/sound/soc/codecs/uda134x.c b/sound/soc/codecs/uda134x.c
index d0f9d90..8f4f469 100644
--- a/sound/soc/codecs/uda134x.c
+++ b/sound/soc/codecs/uda134x.c
@@ -571,8 +571,7 @@ static int uda134x_soc_remove(struct snd_soc_codec *codec)
 }
 
 #if defined(CONFIG_PM)
-static int uda134x_soc_suspend(struct snd_soc_codec *codec,
-						pm_message_t state)
+static int uda134x_soc_suspend(struct snd_soc_codec *codec)
 {
 	uda134x_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 	uda134x_set_bias_level(codec, SND_SOC_BIAS_OFF);
diff --git a/sound/soc/codecs/uda1380.c b/sound/soc/codecs/uda1380.c
index 6b933ef..d08b91d 100644
--- a/sound/soc/codecs/uda1380.c
+++ b/sound/soc/codecs/uda1380.c
@@ -705,7 +705,7 @@ static struct snd_soc_dai_driver uda1380_dai[] = {
 },
 };
 
-static int uda1380_suspend(struct snd_soc_codec *codec, pm_message_t state)
+static int uda1380_suspend(struct snd_soc_codec *codec)
 {
 	uda1380_set_bias_level(codec, SND_SOC_BIAS_OFF);
 	return 0;
diff --git a/sound/soc/codecs/wm8350.c b/sound/soc/codecs/wm8350.c
index 3f1ed5f..f39497f 100644
--- a/sound/soc/codecs/wm8350.c
+++ b/sound/soc/codecs/wm8350.c
@@ -1315,7 +1315,7 @@ static int wm8350_set_bias_level(struct snd_soc_codec *codec,
 	return 0;
 }
 
-static int wm8350_suspend(struct snd_soc_codec *codec, pm_message_t state)
+static int wm8350_suspend(struct snd_soc_codec *codec)
 {
 	wm8350_set_bias_level(codec, SND_SOC_BIAS_OFF);
 	return 0;
diff --git a/sound/soc/codecs/wm8400.c b/sound/soc/codecs/wm8400.c
index a1173eb..56a7b72 100644
--- a/sound/soc/codecs/wm8400.c
+++ b/sound/soc/codecs/wm8400.c
@@ -1352,7 +1352,7 @@ static struct snd_soc_dai_driver wm8400_dai = {
 	.ops = &wm8400_dai_ops,
 };
 
-static int wm8400_suspend(struct snd_soc_codec *codec, pm_message_t state)
+static int wm8400_suspend(struct snd_soc_codec *codec)
 {
 	wm8400_set_bias_level(codec, SND_SOC_BIAS_OFF);
 
diff --git a/sound/soc/codecs/wm8510.c b/sound/soc/codecs/wm8510.c
index 3a65571..5e84750 100644
--- a/sound/soc/codecs/wm8510.c
+++ b/sound/soc/codecs/wm8510.c
@@ -534,7 +534,7 @@ static struct snd_soc_dai_driver wm8510_dai = {
 	.symmetric_rates = 1,
 };
 
-static int wm8510_suspend(struct snd_soc_codec *codec, pm_message_t state)
+static int wm8510_suspend(struct snd_soc_codec *codec)
 {
 	wm8510_set_bias_level(codec, SND_SOC_BIAS_OFF);
 	return 0;
diff --git a/sound/soc/codecs/wm8523.c b/sound/soc/codecs/wm8523.c
index 0c89f8e..7fea2c3 100644
--- a/sound/soc/codecs/wm8523.c
+++ b/sound/soc/codecs/wm8523.c
@@ -384,7 +384,7 @@ static struct snd_soc_dai_driver wm8523_dai = {
 };
 
 #ifdef CONFIG_PM
-static int wm8523_suspend(struct snd_soc_codec *codec, pm_message_t state)
+static int wm8523_suspend(struct snd_soc_codec *codec)
 {
 	wm8523_set_bias_level(codec, SND_SOC_BIAS_OFF);
 	return 0;
diff --git a/sound/soc/codecs/wm8711.c b/sound/soc/codecs/wm8711.c
index 760080e..b9b1a2f 100644
--- a/sound/soc/codecs/wm8711.c
+++ b/sound/soc/codecs/wm8711.c
@@ -338,7 +338,7 @@ static struct snd_soc_dai_driver wm8711_dai = {
 	.ops = &wm8711_ops,
 };
 
-static int wm8711_suspend(struct snd_soc_codec *codec, pm_message_t state)
+static int wm8711_suspend(struct snd_soc_codec *codec)
 {
 	snd_soc_write(codec, WM8711_ACTIVE, 0x0);
 	wm8711_set_bias_level(codec, SND_SOC_BIAS_OFF);
diff --git a/sound/soc/codecs/wm8728.c b/sound/soc/codecs/wm8728.c
index 085c2f8..b1f01d9 100644
--- a/sound/soc/codecs/wm8728.c
+++ b/sound/soc/codecs/wm8728.c
@@ -214,7 +214,7 @@ static struct snd_soc_dai_driver wm8728_dai = {
 	.ops = &wm8728_dai_ops,
 };
 
-static int wm8728_suspend(struct snd_soc_codec *codec, pm_message_t state)
+static int wm8728_suspend(struct snd_soc_codec *codec)
 {
 	wm8728_set_bias_level(codec, SND_SOC_BIAS_OFF);
 
diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
index c18dee0..8821af7 100644
--- a/sound/soc/codecs/wm8731.c
+++ b/sound/soc/codecs/wm8731.c
@@ -490,7 +490,7 @@ static struct snd_soc_dai_driver wm8731_dai = {
 };
 
 #ifdef CONFIG_PM
-static int wm8731_suspend(struct snd_soc_codec *codec, pm_message_t state)
+static int wm8731_suspend(struct snd_soc_codec *codec)
 {
 	wm8731_set_bias_level(codec, SND_SOC_BIAS_OFF);
 
diff --git a/sound/soc/codecs/wm8737.c b/sound/soc/codecs/wm8737.c
index c13e4f7..ff95e62c 100644
--- a/sound/soc/codecs/wm8737.c
+++ b/sound/soc/codecs/wm8737.c
@@ -539,7 +539,7 @@ static struct snd_soc_dai_driver wm8737_dai = {
 };
 
 #ifdef CONFIG_PM
-static int wm8737_suspend(struct snd_soc_codec *codec, pm_message_t state)
+static int wm8737_suspend(struct snd_soc_codec *codec)
 {
 	wm8737_set_bias_level(codec, SND_SOC_BIAS_OFF);
 	return 0;
diff --git a/sound/soc/codecs/wm8750.c b/sound/soc/codecs/wm8750.c
index b312fcc..48cb78f 100644
--- a/sound/soc/codecs/wm8750.c
+++ b/sound/soc/codecs/wm8750.c
@@ -666,7 +666,7 @@ static struct snd_soc_dai_driver wm8750_dai = {
 	.ops = &wm8750_dai_ops,
 };
 
-static int wm8750_suspend(struct snd_soc_codec *codec, pm_message_t state)
+static int wm8750_suspend(struct snd_soc_codec *codec)
 {
 	wm8750_set_bias_level(codec, SND_SOC_BIAS_OFF);
 	return 0;
diff --git a/sound/soc/codecs/wm8753.c b/sound/soc/codecs/wm8753.c
index dc31538..b114c19 100644
--- a/sound/soc/codecs/wm8753.c
+++ b/sound/soc/codecs/wm8753.c
@@ -1380,7 +1380,7 @@ static void wm8753_work(struct work_struct *work)
 	wm8753_set_bias_level(codec, dapm->bias_level);
 }
 
-static int wm8753_suspend(struct snd_soc_codec *codec, pm_message_t state)
+static int wm8753_suspend(struct snd_soc_codec *codec)
 {
 	wm8753_set_bias_level(codec, SND_SOC_BIAS_OFF);
 	return 0;
diff --git a/sound/soc/codecs/wm8770.c b/sound/soc/codecs/wm8770.c
index 391c385..8976eb5 100644
--- a/sound/soc/codecs/wm8770.c
+++ b/sound/soc/codecs/wm8770.c
@@ -555,7 +555,7 @@ static struct snd_soc_dai_driver wm8770_dai = {
 };
 
 #ifdef CONFIG_PM
-static int wm8770_suspend(struct snd_soc_codec *codec, pm_message_t state)
+static int wm8770_suspend(struct snd_soc_codec *codec)
 {
 	wm8770_set_bias_level(codec, SND_SOC_BIAS_OFF);
 	return 0;
diff --git a/sound/soc/codecs/wm8776.c b/sound/soc/codecs/wm8776.c
index af542a2..fbf80c5 100644
--- a/sound/soc/codecs/wm8776.c
+++ b/sound/soc/codecs/wm8776.c
@@ -371,7 +371,7 @@ static struct snd_soc_dai_driver wm8776_dai[] = {
 };
 
 #ifdef CONFIG_PM
-static int wm8776_suspend(struct snd_soc_codec *codec, pm_message_t state)
+static int wm8776_suspend(struct snd_soc_codec *codec)
 {
 	wm8776_set_bias_level(codec, SND_SOC_BIAS_OFF);
 
diff --git a/sound/soc/codecs/wm8804.c b/sound/soc/codecs/wm8804.c
index d99c6a0..ae4b8fb 100644
--- a/sound/soc/codecs/wm8804.c
+++ b/sound/soc/codecs/wm8804.c
@@ -542,7 +542,7 @@ static int wm8804_set_bias_level(struct snd_soc_codec *codec,
 }
 
 #ifdef CONFIG_PM
-static int wm8804_suspend(struct snd_soc_codec *codec, pm_message_t state)
+static int wm8804_suspend(struct snd_soc_codec *codec)
 {
 	wm8804_set_bias_level(codec, SND_SOC_BIAS_OFF);
 	return 0;
diff --git a/sound/soc/codecs/wm8900.c b/sound/soc/codecs/wm8900.c
index 6ac80cf..85632ff 100644
--- a/sound/soc/codecs/wm8900.c
+++ b/sound/soc/codecs/wm8900.c
@@ -1106,7 +1106,7 @@ static int wm8900_set_bias_level(struct snd_soc_codec *codec,
 	return 0;
 }
 
-static int wm8900_suspend(struct snd_soc_codec *codec, pm_message_t state)
+static int wm8900_suspend(struct snd_soc_codec *codec)
 {
 	struct wm8900_priv *wm8900 = snd_soc_codec_get_drvdata(codec);
 	int fll_out = wm8900->fll_out;
diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index 70a2268..d663c97 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -1758,7 +1758,7 @@ static struct snd_soc_dai_driver wm8903_dai = {
 	.symmetric_rates = 1,
 };
 
-static int wm8903_suspend(struct snd_soc_codec *codec, pm_message_t state)
+static int wm8903_suspend(struct snd_soc_codec *codec)
 {
 	wm8903_set_bias_level(codec, SND_SOC_BIAS_OFF);
 
diff --git a/sound/soc/codecs/wm8904.c b/sound/soc/codecs/wm8904.c
index babca49..f0ae01b 100644
--- a/sound/soc/codecs/wm8904.c
+++ b/sound/soc/codecs/wm8904.c
@@ -2234,7 +2234,7 @@ static struct snd_soc_dai_driver wm8904_dai = {
 };
 
 #ifdef CONFIG_PM
-static int wm8904_suspend(struct snd_soc_codec *codec, pm_message_t state)
+static int wm8904_suspend(struct snd_soc_codec *codec)
 {
 	wm8904_set_bias_level(codec, SND_SOC_BIAS_OFF);
 
diff --git a/sound/soc/codecs/wm8940.c b/sound/soc/codecs/wm8940.c
index 9f1cce8..0fe4545 100644
--- a/sound/soc/codecs/wm8940.c
+++ b/sound/soc/codecs/wm8940.c
@@ -672,7 +672,7 @@ static struct snd_soc_dai_driver wm8940_dai = {
 	.symmetric_rates = 1,
 };
 
-static int wm8940_suspend(struct snd_soc_codec *codec, pm_message_t state)
+static int wm8940_suspend(struct snd_soc_codec *codec)
 {
 	return wm8940_set_bias_level(codec, SND_SOC_BIAS_OFF);
 }
diff --git a/sound/soc/codecs/wm8955.c b/sound/soc/codecs/wm8955.c
index ca38722..cdd5139 100644
--- a/sound/soc/codecs/wm8955.c
+++ b/sound/soc/codecs/wm8955.c
@@ -878,7 +878,7 @@ static struct snd_soc_dai_driver wm8955_dai = {
 };
 
 #ifdef CONFIG_PM
-static int wm8955_suspend(struct snd_soc_codec *codec, pm_message_t state)
+static int wm8955_suspend(struct snd_soc_codec *codec)
 {
 	wm8955_set_bias_level(codec, SND_SOC_BIAS_OFF);
 
diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index ed2773f..55b9a25 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -894,7 +894,7 @@ static struct snd_soc_dai_driver wm8960_dai = {
 	.symmetric_rates = 1,
 };
 
-static int wm8960_suspend(struct snd_soc_codec *codec, pm_message_t state)
+static int wm8960_suspend(struct snd_soc_codec *codec)
 {
 	struct wm8960_priv *wm8960 = snd_soc_codec_get_drvdata(codec);
 
diff --git a/sound/soc/codecs/wm8961.c b/sound/soc/codecs/wm8961.c
index c058701..9bcf846 100644
--- a/sound/soc/codecs/wm8961.c
+++ b/sound/soc/codecs/wm8961.c
@@ -1038,7 +1038,7 @@ static int wm8961_remove(struct snd_soc_codec *codec)
 }
 
 #ifdef CONFIG_PM
-static int wm8961_suspend(struct snd_soc_codec *codec, pm_message_t state)
+static int wm8961_suspend(struct snd_soc_codec *codec)
 {
 	wm8961_set_bias_level(codec, SND_SOC_BIAS_OFF);
 
diff --git a/sound/soc/codecs/wm8971.c b/sound/soc/codecs/wm8971.c
index b01df56..aadd14a 100644
--- a/sound/soc/codecs/wm8971.c
+++ b/sound/soc/codecs/wm8971.c
@@ -599,7 +599,7 @@ static void wm8971_work(struct work_struct *work)
 	wm8971_set_bias_level(codec, codec->dapm.bias_level);
 }
 
-static int wm8971_suspend(struct snd_soc_codec *codec, pm_message_t state)
+static int wm8971_suspend(struct snd_soc_codec *codec)
 {
 	wm8971_set_bias_level(codec, SND_SOC_BIAS_OFF);
 	return 0;
diff --git a/sound/soc/codecs/wm8974.c b/sound/soc/codecs/wm8974.c
index e41f999..a5fd017 100644
--- a/sound/soc/codecs/wm8974.c
+++ b/sound/soc/codecs/wm8974.c
@@ -582,7 +582,7 @@ static struct snd_soc_dai_driver wm8974_dai = {
 	.symmetric_rates = 1,
 };
 
-static int wm8974_suspend(struct snd_soc_codec *codec, pm_message_t state)
+static int wm8974_suspend(struct snd_soc_codec *codec)
 {
 	wm8974_set_bias_level(codec, SND_SOC_BIAS_OFF);
 	return 0;
diff --git a/sound/soc/codecs/wm8978.c b/sound/soc/codecs/wm8978.c
index 649a2e3..85d514d 100644
--- a/sound/soc/codecs/wm8978.c
+++ b/sound/soc/codecs/wm8978.c
@@ -892,7 +892,7 @@ static struct snd_soc_dai_driver wm8978_dai = {
 	.ops = &wm8978_dai_ops,
 };
 
-static int wm8978_suspend(struct snd_soc_codec *codec, pm_message_t state)
+static int wm8978_suspend(struct snd_soc_codec *codec)
 {
 	wm8978_set_bias_level(codec, SND_SOC_BIAS_OFF);
 	/* Also switch PLL off */
diff --git a/sound/soc/codecs/wm8983.c b/sound/soc/codecs/wm8983.c
index 362298c..cebde56 100644
--- a/sound/soc/codecs/wm8983.c
+++ b/sound/soc/codecs/wm8983.c
@@ -974,7 +974,7 @@ static int wm8983_set_bias_level(struct snd_soc_codec *codec,
 }
 
 #ifdef CONFIG_PM
-static int wm8983_suspend(struct snd_soc_codec *codec, pm_message_t state)
+static int wm8983_suspend(struct snd_soc_codec *codec)
 {
 	wm8983_set_bias_level(codec, SND_SOC_BIAS_OFF);
 	return 0;
diff --git a/sound/soc/codecs/wm8985.c b/sound/soc/codecs/wm8985.c
index 9e4481b..c0c86b3 100644
--- a/sound/soc/codecs/wm8985.c
+++ b/sound/soc/codecs/wm8985.c
@@ -945,7 +945,7 @@ static int wm8985_set_bias_level(struct snd_soc_codec *codec,
 }
 
 #ifdef CONFIG_PM
-static int wm8985_suspend(struct snd_soc_codec *codec, pm_message_t state)
+static int wm8985_suspend(struct snd_soc_codec *codec)
 {
 	wm8985_set_bias_level(codec, SND_SOC_BIAS_OFF);
 	return 0;
diff --git a/sound/soc/codecs/wm8988.c b/sound/soc/codecs/wm8988.c
index 608c672..0938847 100644
--- a/sound/soc/codecs/wm8988.c
+++ b/sound/soc/codecs/wm8988.c
@@ -728,7 +728,7 @@ static struct snd_soc_dai_driver wm8988_dai = {
 	.symmetric_rates = 1,
 };
 
-static int wm8988_suspend(struct snd_soc_codec *codec, pm_message_t state)
+static int wm8988_suspend(struct snd_soc_codec *codec)
 {
 	wm8988_set_bias_level(codec, SND_SOC_BIAS_OFF);
 	return 0;
diff --git a/sound/soc/codecs/wm8990.c b/sound/soc/codecs/wm8990.c
index 58d7f0b..b417d2e 100644
--- a/sound/soc/codecs/wm8990.c
+++ b/sound/soc/codecs/wm8990.c
@@ -1313,7 +1313,7 @@ static struct snd_soc_dai_driver wm8990_dai = {
 	.ops = &wm8990_dai_ops,
 };
 
-static int wm8990_suspend(struct snd_soc_codec *codec, pm_message_t state)
+static int wm8990_suspend(struct snd_soc_codec *codec)
 {
 	wm8990_set_bias_level(codec, SND_SOC_BIAS_OFF);
 	return 0;
diff --git a/sound/soc/codecs/wm8991.c b/sound/soc/codecs/wm8991.c
index 35c5389..7ee40da 100644
--- a/sound/soc/codecs/wm8991.c
+++ b/sound/soc/codecs/wm8991.c
@@ -1240,7 +1240,7 @@ static int wm8991_set_bias_level(struct snd_soc_codec *codec,
 	return 0;
 }
 
-static int wm8991_suspend(struct snd_soc_codec *codec, pm_message_t state)
+static int wm8991_suspend(struct snd_soc_codec *codec)
 {
 	wm8991_set_bias_level(codec, SND_SOC_BIAS_OFF);
 	return 0;
diff --git a/sound/soc/codecs/wm8993.c b/sound/soc/codecs/wm8993.c
index 780c24c..0f8278b 100644
--- a/sound/soc/codecs/wm8993.c
+++ b/sound/soc/codecs/wm8993.c
@@ -1544,7 +1544,7 @@ static int wm8993_remove(struct snd_soc_codec *codec)
 }
 
 #ifdef CONFIG_PM
-static int wm8993_suspend(struct snd_soc_codec *codec, pm_message_t state)
+static int wm8993_suspend(struct snd_soc_codec *codec)
 {
 	struct wm8993_priv *wm8993 = snd_soc_codec_get_drvdata(codec);
 	int fll_fout = wm8993->fll_fout;
diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 0699ed2..d9faa39 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -2801,7 +2801,7 @@ static struct snd_soc_dai_driver wm8994_dai[] = {
 };
 
 #ifdef CONFIG_PM
-static int wm8994_suspend(struct snd_soc_codec *codec, pm_message_t state)
+static int wm8994_suspend(struct snd_soc_codec *codec)
 {
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
 	struct wm8994 *control = wm8994->wm8994;
diff --git a/sound/soc/codecs/wm8995.c b/sound/soc/codecs/wm8995.c
index 8f6a36d..5863406 100644
--- a/sound/soc/codecs/wm8995.c
+++ b/sound/soc/codecs/wm8995.c
@@ -2009,7 +2009,7 @@ static int wm8995_set_bias_level(struct snd_soc_codec *codec,
 }
 
 #ifdef CONFIG_PM
-static int wm8995_suspend(struct snd_soc_codec *codec, pm_message_t state)
+static int wm8995_suspend(struct snd_soc_codec *codec)
 {
 	wm8995_set_bias_level(codec, SND_SOC_BIAS_OFF);
 	return 0;
diff --git a/sound/soc/codecs/wm9081.c b/sound/soc/codecs/wm9081.c
index 8a4b970..1f2672b 100644
--- a/sound/soc/codecs/wm9081.c
+++ b/sound/soc/codecs/wm9081.c
@@ -1302,7 +1302,7 @@ static int wm9081_remove(struct snd_soc_codec *codec)
 }
 
 #ifdef CONFIG_PM
-static int wm9081_suspend(struct snd_soc_codec *codec, pm_message_t state)
+static int wm9081_suspend(struct snd_soc_codec *codec)
 {
 	wm9081_set_bias_level(codec, SND_SOC_BIAS_OFF);
 
diff --git a/sound/soc/codecs/wm9090.c b/sound/soc/codecs/wm9090.c
index f94c060..5cb8759 100644
--- a/sound/soc/codecs/wm9090.c
+++ b/sound/soc/codecs/wm9090.c
@@ -604,7 +604,7 @@ static int wm9090_probe(struct snd_soc_codec *codec)
 }
 
 #ifdef CONFIG_PM
-static int wm9090_suspend(struct snd_soc_codec *codec, pm_message_t state)
+static int wm9090_suspend(struct snd_soc_codec *codec)
 {
 	wm9090_set_bias_level(codec, SND_SOC_BIAS_OFF);
 
diff --git a/sound/soc/codecs/wm9705.c b/sound/soc/codecs/wm9705.c
index b720a43..40c92ea 100644
--- a/sound/soc/codecs/wm9705.c
+++ b/sound/soc/codecs/wm9705.c
@@ -306,7 +306,7 @@ static int wm9705_reset(struct snd_soc_codec *codec)
 }
 
 #ifdef CONFIG_PM
-static int wm9705_soc_suspend(struct snd_soc_codec *codec, pm_message_t msg)
+static int wm9705_soc_suspend(struct snd_soc_codec *codec)
 {
 	soc_ac97_ops.write(codec->ac97, AC97_POWERDOWN, 0xffff);
 
diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
index 4ce73f5..b7b31f8 100644
--- a/sound/soc/codecs/wm9712.c
+++ b/sound/soc/codecs/wm9712.c
@@ -583,8 +583,7 @@ err:
 	return -EIO;
 }
 
-static int wm9712_soc_suspend(struct snd_soc_codec *codec,
-	pm_message_t state)
+static int wm9712_soc_suspend(struct snd_soc_codec *codec)
 {
 	wm9712_set_bias_level(codec, SND_SOC_BIAS_OFF);
 	return 0;
diff --git a/sound/soc/codecs/wm9713.c b/sound/soc/codecs/wm9713.c
index edb5981..2b8479b 100644
--- a/sound/soc/codecs/wm9713.c
+++ b/sound/soc/codecs/wm9713.c
@@ -1140,8 +1140,7 @@ static int wm9713_set_bias_level(struct snd_soc_codec *codec,
 	return 0;
 }
 
-static int wm9713_soc_suspend(struct snd_soc_codec *codec,
-	pm_message_t state)
+static int wm9713_soc_suspend(struct snd_soc_codec *codec)
 {
 	u16 reg;
 
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index ec783f0..5195f06 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -572,7 +572,7 @@ int snd_soc_suspend(struct device *dev)
 			switch (codec->dapm.bias_level) {
 			case SND_SOC_BIAS_STANDBY:
 			case SND_SOC_BIAS_OFF:
-				codec->driver->suspend(codec, PMSG_SUSPEND);
+				codec->driver->suspend(codec);
 				codec->suspended = 1;
 				codec->cache_sync = 1;
 				break;
-- 
1.7.7.3
