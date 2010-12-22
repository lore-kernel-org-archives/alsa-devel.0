From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 1/3] ASoC: tlv320dac33: Remove manual FIFO
	configuration
Date: Wed, 22 Dec 2010 10:45:16 +0200
Message-ID: <1293007518-3870-2-git-send-email-peter.ujfalusi@nokia.com>
References: <1293007518-3870-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-da01.nokia.com (smtp.nokia.com [147.243.128.24])
	by alsa0.perex.cz (Postfix) with ESMTP id A4AF7103862
	for <alsa-devel@alsa-project.org>; Wed, 22 Dec 2010 09:45:20 +0100 (CET)
In-Reply-To: <1293007518-3870-1-git-send-email-peter.ujfalusi@nokia.com>
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

The manual FIFO configuration was the first version to enable
the use of the FIFO in the codec.
It had served it's purpose as debugging aid, but the automatic
FIFO configuration is much safer to use.
The removal of the manual controls, and configuration makes
it easier to add new features for the codec later, since
the manual mode neded different ways to calculate, and
protect against misconfiguration.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/tlv320dac33.c |  157 +++++-----------------------------------
 1 files changed, 20 insertions(+), 137 deletions(-)

diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index 776ac80..c574ae2 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -46,8 +46,6 @@
 						 * 6144 stereo */
 #define DAC33_BUFFER_SIZE_SAMPLES	6144
 
-#define NSAMPLE_MAX		5700
-
 #define MODE7_LTHR		10
 #define MODE7_UTHR		(DAC33_BUFFER_SIZE_SAMPLES - 10)
 
@@ -99,16 +97,10 @@ struct tlv320dac33_priv {
 	unsigned int refclk;
 
 	unsigned int alarm_threshold;	/* set to be half of LATENCY_TIME_MS */
-	unsigned int nsample_min;	/* nsample should not be lower than
-					 * this */
-	unsigned int nsample_max;	/* nsample should not be higher than
-					 * this */
 	enum dac33_fifo_modes fifo_mode;/* FIFO mode selection */
 	unsigned int nsample;		/* burst read amount from host */
 	int mode1_latency;		/* latency caused by the i2c writes in
 					 * us */
-	int auto_fifo_config; 		/* Configure the FIFO based on the
-					 * period size */
 	u8 burst_bclkdiv;		/* BCLK divider value in burst mode */
 	unsigned int burst_rate;	/* Interface speed in Burst modes */
 
@@ -436,73 +428,6 @@ static int dac33_playback_event(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
-static int dac33_get_nsample(struct snd_kcontrol *kcontrol,
-			 struct snd_ctl_elem_value *ucontrol)
-{
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
-	struct tlv320dac33_priv *dac33 = snd_soc_codec_get_drvdata(codec);
-
-	ucontrol->value.integer.value[0] = dac33->nsample;
-
-	return 0;
-}
-
-static int dac33_set_nsample(struct snd_kcontrol *kcontrol,
-			 struct snd_ctl_elem_value *ucontrol)
-{
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
-	struct tlv320dac33_priv *dac33 = snd_soc_codec_get_drvdata(codec);
-	int ret = 0;
-
-	if (dac33->nsample == ucontrol->value.integer.value[0])
-		return 0;
-
-	if (ucontrol->value.integer.value[0] < dac33->nsample_min ||
-	    ucontrol->value.integer.value[0] > dac33->nsample_max) {
-		ret = -EINVAL;
-	} else {
-		dac33->nsample = ucontrol->value.integer.value[0];
-		/* Re calculate the burst time */
-		dac33->mode1_us_burst = SAMPLES_TO_US(dac33->burst_rate,
-						      dac33->nsample);
-	}
-
-	return ret;
-}
-
-static int dac33_get_uthr(struct snd_kcontrol *kcontrol,
-			 struct snd_ctl_elem_value *ucontrol)
-{
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
-	struct tlv320dac33_priv *dac33 = snd_soc_codec_get_drvdata(codec);
-
-	ucontrol->value.integer.value[0] = dac33->uthr;
-
-	return 0;
-}
-
-static int dac33_set_uthr(struct snd_kcontrol *kcontrol,
-			 struct snd_ctl_elem_value *ucontrol)
-{
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
-	struct tlv320dac33_priv *dac33 = snd_soc_codec_get_drvdata(codec);
-	int ret = 0;
-
-	if (dac33->substream)
-		return -EBUSY;
-
-	if (dac33->uthr == ucontrol->value.integer.value[0])
-		return 0;
-
-	if (ucontrol->value.integer.value[0] < (MODE7_LTHR + 10) ||
-	    ucontrol->value.integer.value[0] > MODE7_UTHR)
-		ret = -EINVAL;
-	else
-		dac33->uthr = ucontrol->value.integer.value[0];
-
-	return ret;
-}
-
 static int dac33_get_fifo_mode(struct snd_kcontrol *kcontrol,
 			 struct snd_ctl_elem_value *ucontrol)
 {
@@ -587,13 +512,6 @@ static const struct snd_kcontrol_new dac33_mode_snd_controls[] = {
 		 dac33_get_fifo_mode, dac33_set_fifo_mode),
 };
 
-static const struct snd_kcontrol_new dac33_fifo_snd_controls[] = {
-	SOC_SINGLE_EXT("nSample", 0, 0, 5900, 0,
-		dac33_get_nsample, dac33_set_nsample),
-	SOC_SINGLE_EXT("UTHR", 0, 0, MODE7_UTHR, 0,
-		 dac33_get_uthr, dac33_set_uthr),
-};
-
 /* Analog bypass */
 static const struct snd_kcontrol_new dac33_dapm_abypassl_control =
 	SOC_DAPM_SINGLE("Switch", DAC33_LINEL_TO_LLO_VOL, 7, 1, 1);
@@ -853,10 +771,6 @@ static void dac33_shutdown(struct snd_pcm_substream *substream,
 	struct tlv320dac33_priv *dac33 = snd_soc_codec_get_drvdata(codec);
 
 	dac33->substream = NULL;
-
-	/* Reset the nSample restrictions */
-	dac33->nsample_min = 0;
-	dac33->nsample_max = NSAMPLE_MAX;
 }
 
 static int dac33_hw_params(struct snd_pcm_substream *substream,
@@ -1112,39 +1026,19 @@ static void dac33_calculate_times(struct snd_pcm_substream *substream)
 		nsample_limit = DAC33_BUFFER_SIZE_SAMPLES -
 				dac33->alarm_threshold;
 
-		if (dac33->auto_fifo_config) {
-			if (period_size <= dac33->alarm_threshold)
-				/*
-				 * Configure nSamaple to number of periods,
-				 * which covers the latency requironment.
-				 */
-				dac33->nsample = period_size *
-				       ((dac33->alarm_threshold / period_size) +
-				       (dac33->alarm_threshold % period_size ?
-				       1 : 0));
-			else if (period_size > nsample_limit)
-				dac33->nsample = nsample_limit;
-			else
-				dac33->nsample = period_size;
-		} else {
-			/* nSample time shall not be shorter than i2c latency */
-			dac33->nsample_min = dac33->alarm_threshold;
+		if (period_size <= dac33->alarm_threshold)
 			/*
-			 * nSample should not be bigger than alsa buffer minus
-			 * size of one period to avoid overruns
+			 * Configure nSamaple to number of periods,
+			 * which covers the latency requironment.
 			 */
-			dac33->nsample_max = substream->runtime->buffer_size -
-						period_size;
-
-			if (dac33->nsample_max > nsample_limit)
-				dac33->nsample_max = nsample_limit;
-
-			/* Correct the nSample if it is outside of the ranges */
-			if (dac33->nsample < dac33->nsample_min)
-				dac33->nsample = dac33->nsample_min;
-			if (dac33->nsample > dac33->nsample_max)
-				dac33->nsample = dac33->nsample_max;
-		}
+			dac33->nsample = period_size *
+				((dac33->alarm_threshold / period_size) +
+				(dac33->alarm_threshold % period_size ?
+				1 : 0));
+		else if (period_size > nsample_limit)
+			dac33->nsample = nsample_limit;
+		else
+			dac33->nsample = period_size;
 
 		dac33->mode1_us_burst = SAMPLES_TO_US(dac33->burst_rate,
 						      dac33->nsample);
@@ -1152,16 +1046,13 @@ static void dac33_calculate_times(struct snd_pcm_substream *substream)
 		dac33->t_stamp2 = 0;
 		break;
 	case DAC33_FIFO_MODE7:
-		if (dac33->auto_fifo_config) {
-			dac33->uthr = UTHR_FROM_PERIOD_SIZE(
-					period_size,
-					rate,
-					dac33->burst_rate) + 9;
-			if (dac33->uthr > MODE7_UTHR)
-				dac33->uthr = MODE7_UTHR;
-			if (dac33->uthr < (MODE7_LTHR + 10))
-				dac33->uthr = (MODE7_LTHR + 10);
-		}
+		dac33->uthr = UTHR_FROM_PERIOD_SIZE(period_size, rate,
+						    dac33->burst_rate) + 9;
+		if (dac33->uthr > MODE7_UTHR)
+			dac33->uthr = MODE7_UTHR;
+		if (dac33->uthr < (MODE7_LTHR + 10))
+			dac33->uthr = (MODE7_LTHR + 10);
+
 		dac33->mode7_us_to_lthr =
 				SAMPLES_TO_US(substream->runtime->rate,
 					dac33->uthr - MODE7_LTHR + 1);
@@ -1486,14 +1377,10 @@ static int dac33_soc_probe(struct snd_soc_codec *codec)
 	snd_soc_add_controls(codec, dac33_snd_controls,
 			     ARRAY_SIZE(dac33_snd_controls));
 	/* Only add the FIFO controls, if we have valid IRQ number */
-	if (dac33->irq >= 0) {
+	if (dac33->irq >= 0)
 		snd_soc_add_controls(codec, dac33_mode_snd_controls,
 				     ARRAY_SIZE(dac33_mode_snd_controls));
-		/* FIFO usage controls only, if autoio config is not selected */
-		if (!dac33->auto_fifo_config)
-			snd_soc_add_controls(codec, dac33_fifo_snd_controls,
-					ARRAY_SIZE(dac33_fifo_snd_controls));
-	}
+
 	dac33_add_widgets(codec);
 
 err_power:
@@ -1593,14 +1480,10 @@ static int __devinit dac33_i2c_probe(struct i2c_client *client,
 	/* Pre calculate the burst rate */
 	dac33->burst_rate = BURST_BASEFREQ_HZ / dac33->burst_bclkdiv / 32;
 	dac33->keep_bclk = pdata->keep_bclk;
-	dac33->auto_fifo_config = pdata->auto_fifo_config;
 	dac33->mode1_latency = pdata->mode1_latency;
 	if (!dac33->mode1_latency)
 		dac33->mode1_latency = 10000; /* 10ms */
 	dac33->irq = client->irq;
-	dac33->nsample = NSAMPLE_MAX;
-	dac33->nsample_max = NSAMPLE_MAX;
-	dac33->uthr = MODE7_UTHR;
 	/* Disable FIFO use by default */
 	dac33->fifo_mode = DAC33_FIFO_BYPASS;
 
-- 
1.7.3.4
