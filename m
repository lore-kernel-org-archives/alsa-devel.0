From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH] ASoC: tlv320dac33: Add support for changing
	upper threshold
Date: Mon,  7 Jun 2010 10:50:39 +0300
Message-ID: <1275897039-7577-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 5E33B1037EA
	for <alsa-devel@alsa-project.org>;
	Mon,  7 Jun 2010 09:51:30 +0200 (CEST)
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

Upper threshold is used in mode7 of DAC33.
Instead of hard wired UTHR, add control to change the upper threshold
value.
Changing upper threshold is not allowed when the playback is already
running, since wrongly timed change in the UTHR can cause problems
with the codec.
With this control the length of the burst in mode7 can be changed.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/tlv320dac33.c |   57 +++++++++++++++++++++++++++++++++------
 1 files changed, 48 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index 65adc77..2fa946c 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -120,6 +120,8 @@ struct tlv320dac33_priv {
 					 * samples */
 	unsigned int mode7_us_to_lthr;	/* Time to reach lthr from uthr */
 
+	unsigned int uthr;
+
 	enum dac33_state state;
 };
 
@@ -442,6 +444,39 @@ static int dac33_set_nsample(struct snd_kcontrol *kcontrol,
 	return ret;
 }
 
+static int dac33_get_uthr(struct snd_kcontrol *kcontrol,
+			 struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct tlv320dac33_priv *dac33 = snd_soc_codec_get_drvdata(codec);
+
+	ucontrol->value.integer.value[0] = dac33->uthr;
+
+	return 0;
+}
+
+static int dac33_set_uthr(struct snd_kcontrol *kcontrol,
+			 struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct tlv320dac33_priv *dac33 = snd_soc_codec_get_drvdata(codec);
+	int ret = 0;
+
+	if (dac33->substream)
+		return -EBUSY;
+
+	if (dac33->uthr == ucontrol->value.integer.value[0])
+		return 0;
+
+	if (ucontrol->value.integer.value[0] < (MODE7_LTHR + 10) ||
+	    ucontrol->value.integer.value[0] > MODE7_UTHR)
+		ret = -EINVAL;
+	else
+		dac33->uthr = ucontrol->value.integer.value[0];
+
+	return ret;
+}
+
 static int dac33_get_fifo_mode(struct snd_kcontrol *kcontrol,
 			 struct snd_ctl_elem_value *ucontrol)
 {
@@ -506,6 +541,8 @@ static const struct snd_kcontrol_new dac33_snd_controls[] = {
 static const struct snd_kcontrol_new dac33_nsample_snd_controls[] = {
 	SOC_SINGLE_EXT("nSample", 0, 0, 5900, 0,
 		 dac33_get_nsample, dac33_set_nsample),
+	SOC_SINGLE_EXT("UTHR", 0, 0, MODE7_UTHR, 0,
+		 dac33_get_uthr, dac33_set_uthr),
 	SOC_ENUM_EXT("FIFO Mode", dac33_fifo_mode_enum,
 		 dac33_get_fifo_mode, dac33_set_fifo_mode),
 };
@@ -985,7 +1022,7 @@ static int dac33_prepare_chip(struct snd_pcm_substream *substream)
 		 * Configure the threshold levels, and leave 10 sample space
 		 * at the bottom, and also at the top of the FIFO
 		 */
-		dac33_write16(codec, DAC33_UTHR_MSB, DAC33_THRREG(MODE7_UTHR));
+		dac33_write16(codec, DAC33_UTHR_MSB, DAC33_THRREG(dac33->uthr));
 		dac33_write16(codec, DAC33_LTHR_MSB, DAC33_THRREG(MODE7_LTHR));
 		break;
 	default:
@@ -1052,8 +1089,8 @@ static void dac33_calculate_times(struct snd_pcm_substream *substream)
 		break;
 	case DAC33_FIFO_MODE7:
 		dac33->mode7_us_to_lthr =
-					SAMPLES_TO_US(substream->runtime->rate,
-						MODE7_UTHR - MODE7_LTHR + 1);
+				SAMPLES_TO_US(substream->runtime->rate,
+					dac33->uthr - MODE7_LTHR + 1);
 		dac33->t_stamp1 = 0;
 		break;
 	default:
@@ -1104,7 +1141,7 @@ static snd_pcm_sframes_t dac33_dai_delay(
 	struct snd_soc_codec *codec = socdev->card->codec;
 	struct tlv320dac33_priv *dac33 = snd_soc_codec_get_drvdata(codec);
 	unsigned long long t0, t1, t_now;
-	unsigned int time_delta;
+	unsigned int time_delta, uthr;
 	int samples_out, samples_in, samples;
 	snd_pcm_sframes_t delay = 0;
 
@@ -1182,6 +1219,7 @@ static snd_pcm_sframes_t dac33_dai_delay(
 	case DAC33_FIFO_MODE7:
 		spin_lock(&dac33->lock);
 		t0 = dac33->t_stamp1;
+		uthr = dac33->uthr;
 		spin_unlock(&dac33->lock);
 		t_now = ktime_to_us(ktime_get());
 
@@ -1194,7 +1232,7 @@ static snd_pcm_sframes_t dac33_dai_delay(
 			 * Either the timestamps are messed or equal. Report
 			 * maximum delay
 			 */
-			delay = MODE7_UTHR;
+			delay = uthr;
 			goto out;
 		}
 
@@ -1208,8 +1246,8 @@ static snd_pcm_sframes_t dac33_dai_delay(
 					substream->runtime->rate,
 					time_delta);
 
-			if (likely(MODE7_UTHR > samples_out))
-				delay = MODE7_UTHR - samples_out;
+			if (likely(uthr > samples_out))
+				delay = uthr - samples_out;
 			else
 				delay = 0;
 		} else {
@@ -1227,8 +1265,8 @@ static snd_pcm_sframes_t dac33_dai_delay(
 					time_delta);
 			delay = MODE7_LTHR + samples_in - samples_out;
 
-			if (unlikely(delay > MODE7_UTHR))
-				delay = MODE7_UTHR;
+			if (unlikely(delay > uthr))
+				delay = uthr;
 		}
 		break;
 	default:
@@ -1484,6 +1522,7 @@ static int __devinit dac33_i2c_probe(struct i2c_client *client,
 	dac33->irq = client->irq;
 	dac33->nsample = NSAMPLE_MAX;
 	dac33->nsample_max = NSAMPLE_MAX;
+	dac33->uthr = MODE7_UTHR;
 	/* Disable FIFO use by default */
 	dac33->fifo_mode = DAC33_FIFO_BYPASS;
 
-- 
1.7.1
