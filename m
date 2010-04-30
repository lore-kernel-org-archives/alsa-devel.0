From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 4/4] ASoC: tlv320dac33: Support for turning off
	the codec in BIAS_STANDBY
Date: Fri, 30 Apr 2010 10:31:55 +0300
Message-ID: <1272612715-13387-5-git-send-email-peter.ujfalusi@nokia.com>
References: <1272612715-13387-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 09AF21038E1
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Apr 2010 09:32:05 +0200 (CEST)
In-Reply-To: <1272612715-13387-1-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

When the codec is in STANDBY we can actually turn it off.
When the codec is off, than the associated regulator can be also turned
off (if the number of users on the regulator is 0).

After initialization, the codec remains in power off, it is only turned
on for reading the ID registers (also testing the regulators).

The codec power is enabled, when the codec is moving from BIAS_STANDBY
to BIAS_ON (via the BIAS_PREPARE state).
The codec is turned off, when it hits BIAS_STANDBY or BIAS_OFF.

There are few scenarios, which has to be taken care::
1. Analog bypass caused BIAS_STANDBY -> BIAS_ON
   We need to power on the codec, and do the chip init, but we does not
   need to execute the playback related configuration
2. Playback caused  BIAS_STANDBY -> BIAS_ON
   We need to power on the codec, and do the chip init, and also we need
   to execute the playback related configuration.
3. Playback start, while Analog bypass is on (BIAS_ON -> BIAS_ON)
   We need to execute the playback related configuration. The codec is
   already on.
4. Analog bypass enable, while playback (BIAS_ON -> BIAS_ON)
   Nothing need to be done.
5. Playback start withing soc power down timeout (BIAS_ON -> BIAS_ON)
   We need to execute the playback related configuration. The codec is
   still on.

Since the power up, and the codec init is optimized, the added overhead
in stream start is minimal.

Withing this patch, the hard_power function is now only doing what it
supposed to: only handle the powers, and GPIO reset line.
The codec initialization and state restore has been moved out.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/tlv320dac33.c |   62 +++++++++++++++++++++++++++++++---------
 1 files changed, 48 insertions(+), 14 deletions(-)

diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index 6edad36..d513f86 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -62,6 +62,8 @@
 	(rate / (1000000 / us))
 
 
+static int dac33_prepare_chip(struct snd_pcm_substream *substream);
+
 static struct snd_soc_codec *tlv320dac33_codec;
 
 enum dac33_state {
@@ -360,9 +362,17 @@ static inline void dac33_soft_power(struct snd_soc_codec *codec, int power)
 static int dac33_hard_power(struct snd_soc_codec *codec, int power)
 {
 	struct tlv320dac33_priv *dac33 = snd_soc_codec_get_drvdata(codec);
-	int ret;
+	int ret = 0;
 
 	mutex_lock(&dac33->mutex);
+
+	/* Safety check */
+	if (unlikely(power == dac33->chip_power)) {
+		dev_warn(codec->dev, "Trying to set the same power state: %s\n",
+			power ? "ON" : "OFF");
+		goto exit;
+	}
+
 	if (power) {
 		ret = regulator_bulk_enable(ARRAY_SIZE(dac33->supplies),
 					  dac33->supplies);
@@ -376,10 +386,6 @@ static int dac33_hard_power(struct snd_soc_codec *codec, int power)
 			gpio_set_value(dac33->power_gpio, 1);
 
 		dac33->chip_power = 1;
-
-		dac33_init_chip(codec);
-
-		dac33_soft_power(codec, 1);
 	} else {
 		dac33_soft_power(codec, 0);
 		if (dac33->power_gpio >= 0)
@@ -562,6 +568,7 @@ static int dac33_add_widgets(struct snd_soc_codec *codec)
 static int dac33_set_bias_level(struct snd_soc_codec *codec,
 				enum snd_soc_bias_level level)
 {
+	struct tlv320dac33_priv *dac33 = snd_soc_codec_get_drvdata(codec);
 	int ret;
 
 	switch (level) {
@@ -569,21 +576,36 @@ static int dac33_set_bias_level(struct snd_soc_codec *codec,
 		dac33_soft_power(codec, 1);
 		break;
 	case SND_SOC_BIAS_PREPARE:
+		if (codec->bias_level == SND_SOC_BIAS_STANDBY) {
+			/* Coming from STANDBY, power up, and init the chip */
+			ret = dac33_hard_power(codec, 1);
+			if (ret != 0)
+				return ret;
+
+			dac33_init_chip(codec);
+			/*
+			 * If we have a stream started do the postponded
+			 * configuration here
+			 */
+			if (dac33->substream)
+				dac33_prepare_chip(dac33->substream);
+		}
 		break;
 	case SND_SOC_BIAS_STANDBY:
-		if (codec->bias_level == SND_SOC_BIAS_OFF) {
-			ret = dac33_hard_power(codec, 1);
+		if (codec->bias_level != SND_SOC_BIAS_OFF) {
+			/* Not coming from OFF, switch off codec */
+			ret = dac33_hard_power(codec, 0);
 			if (ret != 0)
 				return ret;
 		}
-
-		dac33_soft_power(codec, 0);
 		break;
 	case SND_SOC_BIAS_OFF:
-		ret = dac33_hard_power(codec, 0);
-		if (ret != 0)
-			return ret;
-
+		if (codec->bias_level != SND_SOC_BIAS_STANDBY) {
+			/* Not coming from STANDBY, switch off codec */
+			ret = dac33_hard_power(codec, 0);
+			if (ret != 0)
+				return ret;
+		}
 		break;
 	}
 	codec->bias_level = level;
@@ -834,6 +856,16 @@ static int dac33_prepare_chip(struct snd_pcm_substream *substream)
 	}
 
 	mutex_lock(&dac33->mutex);
+
+	if (!dac33->chip_power) {
+		/*
+		 * Chip is not powered yet.
+		 * Do the init in the dac33_set_bias_level later.
+		 */
+		mutex_unlock(&dac33->mutex);
+		return 0;
+	}
+
 	dac33_soft_power(codec, 0);
 	dac33_soft_power(codec, 1);
 
@@ -1341,7 +1373,7 @@ static int dac33_soc_probe(struct platform_device *pdev)
 
 	dac33_add_widgets(codec);
 
-	/* power on device */
+	/* Set codec BIAS */
 	dac33_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
 	return 0;
@@ -1380,6 +1412,8 @@ static int dac33_soc_resume(struct platform_device *pdev)
 	struct snd_soc_codec *codec = socdev->card->codec;
 
 	dac33_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+	if (codec->suspend_bias_level == SND_SOC_BIAS_ON)
+		dac33_set_bias_level(codec, SND_SOC_BIAS_PREPARE);
 	dac33_set_bias_level(codec, codec->suspend_bias_level);
 
 	return 0;
-- 
1.7.0.4
