From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 5/5] ASoC: tlv320dac33: FIFO caused delay
	reporting
Date: Thu, 22 Apr 2010 16:57:50 +0300
Message-ID: <1271944670-14588-6-git-send-email-peter.ujfalusi@nokia.com>
References: <1271944670-14588-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id B23291038A1
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Apr 2010 15:57:55 +0200 (CEST)
In-Reply-To: <1271944670-14588-1-git-send-email-peter.ujfalusi@nokia.com>
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

Delay reporting for the three implemented DAC33 FIFO modes.
DAC33 has FIFO depth status register(s), but it can not be used, since
inside of pcm_pointer we can not send I2C commands.
Timestamp based estimation need to be used. The method of calculating
the delay depends on the active FIFO mode.

Bypass mode: FIFO is bypassed, report 0 as delay

Mode1: nSample fill mode. In this mode I need to use two timestamp
ts1: taken when the interrupt has been received
ts2: taken before writing to nSample register.

Interrupts are coming when DAC33 FIFO depth goes under alarm threshold.

Phase1: when we received the alarm threshold, but our workqueue has
        not been executed (safeguard phase). Just count the played out
        samples since ts1 and subtract it from the alarm threshold
        value.
Phase2: During nSample burst (after writing to nSample register), count
        the played out samples since ts1, count the samples received
        since ts2 (in a burst). Estimate the FIFO depth using these and
        alarm threshold value.
Phase3: Draining phase (after the burst read), count the played out
        samples since ts1. Estimate the FIFO depth using the nSample
        configuration and the alarm threshold value.

Mode7: Threshold based fill mode. In this mode one timestamp is enough.
ts1: taken when the interrupt has been received

Interrupts are coming when DAC33 FIFO depth reaches upper threshold.

Phase1: Draining phase (after the burst), counting the played out
        samples since ts1, and subtract it from the upper threshold
        value.
Phase2: During burst operation. Using the pre calculated time needed to
        play out samples from the buffer during the drain period (from
        upper to lower threshold), move the time window to cover the
        estimated time from the burst start to the current time.
        Calculate the samples played out since lower threshold and also
        the samples received during the same time.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/tlv320dac33.c |  222 +++++++++++++++++++++++++++++++++++++++-
 1 files changed, 217 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index 7a3dea6..e937d32 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -55,6 +55,13 @@
 
 #define BURST_BASEFREQ_HZ	49152000
 
+#define SAMPLES_TO_US(rate, samples) \
+	(1000000000 / ((rate * 1000) / samples))
+
+#define US_TO_SAMPLES(rate, ns) \
+	(rate / (1000000 / ns))
+
+
 static struct snd_soc_codec *tlv320dac33_codec;
 
 enum dac33_state {
@@ -101,6 +108,14 @@ struct tlv320dac33_priv {
 
 	int keep_bclk;			/* Keep the BCLK continuously running
 					 * in FIFO modes */
+	spinlock_t lock;
+	unsigned long long t_stamp1;	/* Time stamp for FIFO modes to */
+	unsigned long long t_stamp2;	/* calculate the FIFO caused delay */
+
+	unsigned int mode1_us_burst;	/* Time to burst read n number of
+					 * samples */
+	unsigned int mode7_us_to_lthr;	/* Time to reach lthr from uthr */
+
 	enum dac33_state state;
 };
 
@@ -390,10 +405,14 @@ static int dac33_set_nsample(struct snd_kcontrol *kcontrol,
 		return 0;
 
 	if (ucontrol->value.integer.value[0] < dac33->nsample_min ||
-	    ucontrol->value.integer.value[0] > dac33->nsample_max)
+	    ucontrol->value.integer.value[0] > dac33->nsample_max) {
 		ret = -EINVAL;
-	else
+	} else {
 		dac33->nsample = ucontrol->value.integer.value[0];
+		/* Re calculate the burst time */
+		dac33->mode1_us_burst = SAMPLES_TO_US(dac33->burst_rate,
+						      dac33->nsample);
+	}
 
 	return ret;
 }
@@ -564,6 +583,13 @@ static inline void dac33_prefill_handler(struct tlv320dac33_priv *dac33)
 	case DAC33_FIFO_MODE1:
 		dac33_write16(codec, DAC33_NSAMPLE_MSB,
 			DAC33_THRREG(dac33->nsample + dac33->alarm_threshold));
+
+		/* Take the timestamps */
+		spin_lock_irq(&dac33->lock);
+		dac33->t_stamp2 = ktime_to_us(ktime_get());
+		dac33->t_stamp1 = dac33->t_stamp2;
+		spin_unlock_irq(&dac33->lock);
+
 		dac33_write16(codec, DAC33_PREFILL_MSB,
 				DAC33_THRREG(dac33->alarm_threshold));
 		/* Enable Alarm Threshold IRQ */
@@ -571,8 +597,18 @@ static inline void dac33_prefill_handler(struct tlv320dac33_priv *dac33)
 		dac33_write(codec, DAC33_FIFO_IRQ_MASK, DAC33_MAT);
 		break;
 	case DAC33_FIFO_MODE7:
+		/* Take the timestamp */
+		spin_lock_irq(&dac33->lock);
+		dac33->t_stamp1 = ktime_to_us(ktime_get());
+		/* Move back the timestamp with drain time */
+		dac33->t_stamp1 -= dac33->mode7_us_to_lthr;
+		spin_unlock_irq(&dac33->lock);
+
 		dac33_write16(codec, DAC33_PREFILL_MSB,
 				DAC33_THRREG(MODE7_LTHR));
+
+		/* Enable Upper Threshold IRQ */
+		dac33_write(codec, DAC33_FIFO_IRQ_MASK, DAC33_MUT);
 		break;
 	default:
 		dev_warn(codec->dev, "Unhandled FIFO mode: %d\n",
@@ -589,6 +625,11 @@ static inline void dac33_playback_handler(struct tlv320dac33_priv *dac33)
 
 	switch (dac33->fifo_mode) {
 	case DAC33_FIFO_MODE1:
+		/* Take the timestamp */
+		spin_lock_irq(&dac33->lock);
+		dac33->t_stamp2 = ktime_to_us(ktime_get());
+		spin_unlock_irq(&dac33->lock);
+
 		dac33_write16(codec, DAC33_NSAMPLE_MSB,
 				DAC33_THRREG(dac33->nsample));
 		break;
@@ -641,7 +682,13 @@ static irqreturn_t dac33_interrupt_handler(int irq, void *dev)
 	struct snd_soc_codec *codec = dev;
 	struct tlv320dac33_priv *dac33 = snd_soc_codec_get_drvdata(codec);
 
-	queue_work(dac33->dac33_wq, &dac33->work);
+	spin_lock(&dac33->lock);
+	dac33->t_stamp1 = ktime_to_us(ktime_get());
+	spin_unlock(&dac33->lock);
+
+	/* Do not schedule the workqueue in Mode7 */
+	if (dac33->fifo_mode != DAC33_FIFO_MODE7)
+		queue_work(dac33->dac33_wq, &dac33->work);
 
 	return IRQ_HANDLED;
 }
@@ -793,8 +840,8 @@ static int dac33_prepare_chip(struct snd_pcm_substream *substream)
 			    DAC33_ATM(DAC33_FIFO_IRQ_MODE_LEVEL));
 		break;
 	case DAC33_FIFO_MODE7:
-		/* Disable all interrupts */
-		dac33_write(codec, DAC33_FIFO_IRQ_MASK, 0);
+		dac33_write(codec, DAC33_FIFO_IRQ_MODE_A,
+			DAC33_UTM(DAC33_FIFO_IRQ_MODE_LEVEL));
 		break;
 	default:
 		/* in FIFO bypass mode, the interrupts are not used */
@@ -929,6 +976,24 @@ static void dac33_calculate_times(struct snd_pcm_substream *substream)
 
 	if (dac33->nsample > dac33->nsample_max)
 		dac33->nsample = dac33->nsample_max;
+
+	switch (dac33->fifo_mode) {
+	case DAC33_FIFO_MODE1:
+		dac33->mode1_us_burst = SAMPLES_TO_US(dac33->burst_rate,
+						      dac33->nsample);
+		dac33->t_stamp1 = 0;
+		dac33->t_stamp2 = 0;
+		break;
+	case DAC33_FIFO_MODE7:
+		dac33->mode7_us_to_lthr =
+					SAMPLES_TO_US(substream->runtime->rate,
+						MODE7_UTHR - MODE7_LTHR + 1);
+		dac33->t_stamp1 = 0;
+		break;
+	default:
+		break;
+	}
+
 }
 
 static int dac33_pcm_prepare(struct snd_pcm_substream *substream,
@@ -973,6 +1038,151 @@ static int dac33_pcm_trigger(struct snd_pcm_substream *substream, int cmd,
 	return ret;
 }
 
+static snd_pcm_sframes_t dac33_dai_delay(
+			struct snd_pcm_substream *substream,
+			struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_device *socdev = rtd->socdev;
+	struct snd_soc_codec *codec = socdev->card->codec;
+	struct tlv320dac33_priv *dac33 = snd_soc_codec_get_drvdata(codec);
+	unsigned long long t0, t1, t_now;
+	unsigned int time_delta;
+	int samples_out, samples_in, samples;
+	snd_pcm_sframes_t delay = 0;
+
+	switch (dac33->fifo_mode) {
+	case DAC33_FIFO_BYPASS:
+		break;
+	case DAC33_FIFO_MODE1:
+		spin_lock(&dac33->lock);
+		t0 = dac33->t_stamp1;
+		t1 = dac33->t_stamp2;
+		spin_unlock(&dac33->lock);
+		t_now = ktime_to_us(ktime_get());
+
+		/* We have not started to fill the FIFO yet, delay is 0 */
+		if (!t1)
+			goto out;
+
+		if (t0 > t1) {
+			/*
+			 * Phase 1:
+			 * After Alarm threshold, and before nSample write
+			 */
+			time_delta = t_now - t0;
+			samples_out = time_delta ? US_TO_SAMPLES(
+						substream->runtime->rate,
+						time_delta) : 0;
+
+			if (likely(dac33->alarm_threshold > samples_out))
+				delay = dac33->alarm_threshold - samples_out;
+			else
+				delay = 0;
+		} else if ((t_now - t1) <= dac33->mode1_us_burst) {
+			/*
+			 * Phase 2:
+			 * After nSample write (during burst operation)
+			 */
+			time_delta = t_now - t0;
+			samples_out = time_delta ? US_TO_SAMPLES(
+						substream->runtime->rate,
+						time_delta) : 0;
+
+			time_delta = t_now - t1;
+			samples_in = time_delta ? US_TO_SAMPLES(
+						dac33->burst_rate,
+						time_delta) : 0;
+
+			samples = dac33->alarm_threshold;
+			samples += (samples_in - samples_out);
+
+			if (likely(samples > 0))
+				delay = samples;
+			else
+				delay = 0;
+		} else {
+			/*
+			 * Phase 3:
+			 * After burst operation, before next alarm threshold
+			 */
+			time_delta = t_now - t0;
+			samples_out = time_delta ? US_TO_SAMPLES(
+						substream->runtime->rate,
+						time_delta) : 0;
+
+			samples_in = dac33->nsample;
+			samples = dac33->alarm_threshold;
+			samples += (samples_in - samples_out);
+
+			if (likely(samples > 0))
+				delay = samples > DAC33_BUFFER_SIZE_SAMPLES ?
+					DAC33_BUFFER_SIZE_SAMPLES : samples;
+			else
+				delay = 0;
+		}
+		break;
+	case DAC33_FIFO_MODE7:
+		spin_lock(&dac33->lock);
+		t0 = dac33->t_stamp1;
+		spin_unlock(&dac33->lock);
+		t_now = ktime_to_us(ktime_get());
+
+		/* We have not started to fill the FIFO yet, delay is 0 */
+		if (!t0)
+			goto out;
+
+		if (t_now <= t0) {
+			/*
+			 * Either the timestamps are messed or equal. Report
+			 * maximum delay
+			 */
+			delay = MODE7_UTHR;
+			goto out;
+		}
+
+		time_delta = t_now - t0;
+		if (time_delta <= dac33->mode7_us_to_lthr) {
+			/*
+			* Phase 1:
+			* After burst (draining phase)
+			*/
+			samples_out = US_TO_SAMPLES(
+					substream->runtime->rate,
+					time_delta);
+
+			if (likely(MODE7_UTHR > samples_out))
+				delay = MODE7_UTHR - samples_out;
+			else
+				delay = 0;
+		} else {
+			/*
+			* Phase 2:
+			* During burst operation
+			*/
+			time_delta = time_delta - dac33->mode7_us_to_lthr;
+
+			samples_out = US_TO_SAMPLES(
+					substream->runtime->rate,
+					time_delta);
+			samples_in = US_TO_SAMPLES(
+					dac33->burst_rate,
+					time_delta);
+			delay = MODE7_LTHR + samples_in - samples_out;
+
+			if (unlikely(delay > MODE7_UTHR))
+				delay = MODE7_UTHR;
+		}
+		break;
+	default:
+		dev_warn(codec->dev, "Unhandled FIFO mode: %d\n",
+							dac33->fifo_mode);
+		break;
+	}
+out:
+	return delay;
+}
+
 static int dac33_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 		int clk_id, unsigned int freq, int dir)
 {
@@ -1184,6 +1394,7 @@ static struct snd_soc_dai_ops dac33_dai_ops = {
 	.hw_params	= dac33_hw_params,
 	.prepare	= dac33_pcm_prepare,
 	.trigger	= dac33_pcm_trigger,
+	.delay		= dac33_dai_delay,
 	.set_sysclk	= dac33_set_dai_sysclk,
 	.set_fmt	= dac33_set_dai_fmt,
 };
@@ -1224,6 +1435,7 @@ static int __devinit dac33_i2c_probe(struct i2c_client *client,
 
 	mutex_init(&codec->mutex);
 	mutex_init(&dac33->mutex);
+	spin_lock_init(&dac33->lock);
 	INIT_LIST_HEAD(&codec->dapm_widgets);
 	INIT_LIST_HEAD(&codec->dapm_paths);
 
-- 
1.7.0.4
