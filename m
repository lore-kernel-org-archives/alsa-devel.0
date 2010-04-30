From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCHv2 4/4] ASoC: tlv320dac33: Support for turning
	off the codec
Date: Fri, 30 Apr 2010 14:59:36 +0300
Message-ID: <1272628776-23185-5-git-send-email-peter.ujfalusi@nokia.com>
References: <1272628776-23185-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 0A72D103918
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Apr 2010 13:59:46 +0200 (CEST)
In-Reply-To: <1272628776-23185-1-git-send-email-peter.ujfalusi@nokia.com>
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

Let the codec to hit OFF instead of STANDBY, when there is no activity.
When the codec is off, than the associated regulator can be also turned
off (if the number of users on the regulator is 0).

After initialization, the codec remains in power off, it is only turned
on for reading the ID registers (also testing the regulators).

The codec power is enabled, when the codec is moving from BIAS_OFF
to BIAS_STANDBY.
The codec is turned off, when it hits BIAS_OFF.

There are few scenarios, which has to be taken care::
1. Analog bypass caused BIAS_OFF -> BIAS_ON
   We need to power on the codec, and do the chip init, but we does not
   need to execute the playback related configuration
2. Playback caused  BIAS_OFF -> BIAS_ON
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
 sound/soc/codecs/tlv320dac33.c |   66 +++++++++++++++++++++++++++-------------
 1 files changed, 45 insertions(+), 21 deletions(-)

diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index 50d1522..68b7ccb 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -61,6 +61,8 @@
 #define US_TO_SAMPLES(rate, us) \
 	(rate / (1000000 / us))
 
+static void dac33_calculate_times(struct snd_pcm_substream *substream);
+static int dac33_prepare_chip(struct snd_pcm_substream *substream);
 
 static struct snd_soc_codec *tlv320dac33_codec;
 
@@ -355,9 +357,17 @@ static inline void dac33_soft_power(struct snd_soc_codec *codec, int power)
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
@@ -371,10 +381,6 @@ static int dac33_hard_power(struct snd_soc_codec *codec, int power)
 			gpio_set_value(dac33->power_gpio, 1);
 
 		dac33->chip_power = 1;
-
-		dac33_init_chip(codec);
-
-		dac33_soft_power(codec, 1);
 	} else {
 		dac33_soft_power(codec, 0);
 		if (dac33->power_gpio >= 0)
@@ -396,6 +402,22 @@ exit:
 	return ret;
 }
 
+static int playback_event(struct snd_soc_dapm_widget *w,
+		struct snd_kcontrol *kcontrol, int event)
+{
+	struct tlv320dac33_priv *dac33 = snd_soc_codec_get_drvdata(w->codec);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		if (likely(dac33->substream)) {
+			dac33_calculate_times(dac33->substream);
+			dac33_prepare_chip(dac33->substream);
+		}
+		break;
+	}
+	return 0;
+}
+
 static int dac33_get_nsample(struct snd_kcontrol *kcontrol,
 			 struct snd_ctl_elem_value *ucontrol)
 {
@@ -525,6 +547,8 @@ static const struct snd_soc_dapm_widget dac33_dapm_widgets[] = {
 			 DAC33_OUT_AMP_PWR_CTRL, 6, 3, 3, 0),
 	SND_SOC_DAPM_REG(snd_soc_dapm_mixer, "Output Right Amp Power",
 			 DAC33_OUT_AMP_PWR_CTRL, 4, 3, 3, 0),
+
+	SND_SOC_DAPM_PRE("Prepare Playback", playback_event),
 };
 
 static const struct snd_soc_dapm_route audio_map[] = {
@@ -567,18 +591,18 @@ static int dac33_set_bias_level(struct snd_soc_codec *codec,
 		break;
 	case SND_SOC_BIAS_STANDBY:
 		if (codec->bias_level == SND_SOC_BIAS_OFF) {
+			/* Coming from OFF, switch on the codec */
 			ret = dac33_hard_power(codec, 1);
 			if (ret != 0)
 				return ret;
-		}
 
-		dac33_soft_power(codec, 0);
+			dac33_init_chip(codec);
+		}
 		break;
 	case SND_SOC_BIAS_OFF:
 		ret = dac33_hard_power(codec, 0);
 		if (ret != 0)
 			return ret;
-
 		break;
 	}
 	codec->bias_level = level;
@@ -829,6 +853,16 @@ static int dac33_prepare_chip(struct snd_pcm_substream *substream)
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
 
@@ -1035,15 +1069,6 @@ static void dac33_calculate_times(struct snd_pcm_substream *substream)
 
 }
 
-static int dac33_pcm_prepare(struct snd_pcm_substream *substream,
-			     struct snd_soc_dai *dai)
-{
-	dac33_calculate_times(substream);
-	dac33_prepare_chip(substream);
-
-	return 0;
-}
-
 static int dac33_pcm_trigger(struct snd_pcm_substream *substream, int cmd,
 			     struct snd_soc_dai *dai)
 {
@@ -1336,9 +1361,6 @@ static int dac33_soc_probe(struct platform_device *pdev)
 
 	dac33_add_widgets(codec);
 
-	/* power on device */
-	dac33_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-
 	return 0;
 
 pcm_err:
@@ -1375,6 +1397,8 @@ static int dac33_soc_resume(struct platform_device *pdev)
 	struct snd_soc_codec *codec = socdev->card->codec;
 
 	dac33_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+	if (codec->suspend_bias_level == SND_SOC_BIAS_ON)
+		dac33_set_bias_level(codec, SND_SOC_BIAS_PREPARE);
 	dac33_set_bias_level(codec, codec->suspend_bias_level);
 
 	return 0;
@@ -1396,7 +1420,6 @@ static struct snd_soc_dai_ops dac33_dai_ops = {
 	.startup	= dac33_startup,
 	.shutdown	= dac33_shutdown,
 	.hw_params	= dac33_hw_params,
-	.prepare	= dac33_pcm_prepare,
 	.trigger	= dac33_pcm_trigger,
 	.delay		= dac33_dai_delay,
 	.set_sysclk	= dac33_set_dai_sysclk,
@@ -1450,6 +1473,7 @@ static int __devinit dac33_i2c_probe(struct i2c_client *client,
 	codec->hw_write = (hw_write_t) i2c_master_send;
 	codec->bias_level = SND_SOC_BIAS_OFF;
 	codec->set_bias_level = dac33_set_bias_level;
+	codec->idle_bias_off = 1;
 	codec->dai = &dac33_dai;
 	codec->num_dai = 1;
 	codec->reg_cache_size = ARRAY_SIZE(dac33_reg);
-- 
1.7.0.4
