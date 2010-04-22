From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 5/5] ASoC: tlv320dac33: FIFO caused delay
 reporting
Date: Thu, 22 Apr 2010 18:57:54 +0100
Message-ID: <1271959074.3228.527.camel@odin>
References: <1271944670-14588-1-git-send-email-peter.ujfalusi@nokia.com>
	<1271944670-14588-6-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id D45C62459D
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Apr 2010 19:57:59 +0200 (CEST)
Received: by wyb36 with SMTP id 36so875048wyb.38
	for <alsa-devel@alsa-project.org>; Thu, 22 Apr 2010 10:57:58 -0700 (PDT)
In-Reply-To: <1271944670-14588-6-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Thu, 2010-04-22 at 16:57 +0300, Peter Ujfalusi wrote:
> Delay reporting for the three implemented DAC33 FIFO modes.
> DAC33 has FIFO depth status register(s), but it can not be used, since
> inside of pcm_pointer we can not send I2C commands.
> Timestamp based estimation need to be used. The method of calculating
> the delay depends on the active FIFO mode.
> 
> Bypass mode: FIFO is bypassed, report 0 as delay
> 
> Mode1: nSample fill mode. In this mode I need to use two timestamp
> ts1: taken when the interrupt has been received
> ts2: taken before writing to nSample register.
> 
> Interrupts are coming when DAC33 FIFO depth goes under alarm threshold.
> 
> Phase1: when we received the alarm threshold, but our workqueue has
>         not been executed (safeguard phase). Just count the played out
>         samples since ts1 and subtract it from the alarm threshold
>         value.
> Phase2: During nSample burst (after writing to nSample register), count
>         the played out samples since ts1, count the samples received
>         since ts2 (in a burst). Estimate the FIFO depth using these and
>         alarm threshold value.
> Phase3: Draining phase (after the burst read), count the played out
>         samples since ts1. Estimate the FIFO depth using the nSample
>         configuration and the alarm threshold value.
> 
> Mode7: Threshold based fill mode. In this mode one timestamp is enough.
> ts1: taken when the interrupt has been received
> 
> Interrupts are coming when DAC33 FIFO depth reaches upper threshold.
> 
> Phase1: Draining phase (after the burst), counting the played out
>         samples since ts1, and subtract it from the upper threshold
>         value.
> Phase2: During burst operation. Using the pre calculated time needed to
>         play out samples from the buffer during the drain period (from
>         upper to lower threshold), move the time window to cover the
>         estimated time from the burst start to the current time.
>         Calculate the samples played out since lower threshold and also
>         the samples received during the same time.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> ---
>  sound/soc/codecs/tlv320dac33.c |  222 +++++++++++++++++++++++++++++++++++++++-
>  1 files changed, 217 insertions(+), 5 deletions(-)
> 
> diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
> index 7a3dea6..e937d32 100644
> --- a/sound/soc/codecs/tlv320dac33.c
> +++ b/sound/soc/codecs/tlv320dac33.c
> @@ -55,6 +55,13 @@
>  
>  #define BURST_BASEFREQ_HZ	49152000
>  
> +#define SAMPLES_TO_US(rate, samples) \
> +	(1000000000 / ((rate * 1000) / samples))
> +
> +#define US_TO_SAMPLES(rate, ns) \
> +	(rate / (1000000 / ns))
> +
> +

Is it microseconds or nanoseconds here (us or ns) ? 

>  static struct snd_soc_codec *tlv320dac33_codec;
>  
>  enum dac33_state {
> @@ -101,6 +108,14 @@ struct tlv320dac33_priv {
>  
>  	int keep_bclk;			/* Keep the BCLK continuously running
>  					 * in FIFO modes */
> +	spinlock_t lock;
> +	unsigned long long t_stamp1;	/* Time stamp for FIFO modes to */
> +	unsigned long long t_stamp2;	/* calculate the FIFO caused delay */
> +
> +	unsigned int mode1_us_burst;	/* Time to burst read n number of
> +					 * samples */
> +	unsigned int mode7_us_to_lthr;	/* Time to reach lthr from uthr */
> +
>  	enum dac33_state state;
>  };
>  
> @@ -390,10 +405,14 @@ static int dac33_set_nsample(struct snd_kcontrol *kcontrol,
>  		return 0;
>  
>  	if (ucontrol->value.integer.value[0] < dac33->nsample_min ||
> -	    ucontrol->value.integer.value[0] > dac33->nsample_max)
> +	    ucontrol->value.integer.value[0] > dac33->nsample_max) {
>  		ret = -EINVAL;
> -	else
> +	} else {
>  		dac33->nsample = ucontrol->value.integer.value[0];
> +		/* Re calculate the burst time */
> +		dac33->mode1_us_burst = SAMPLES_TO_US(dac33->burst_rate,
> +						      dac33->nsample);
> +	}
>  
>  	return ret;
>  }
> @@ -564,6 +583,13 @@ static inline void dac33_prefill_handler(struct tlv320dac33_priv *dac33)
>  	case DAC33_FIFO_MODE1:
>  		dac33_write16(codec, DAC33_NSAMPLE_MSB,
>  			DAC33_THRREG(dac33->nsample + dac33->alarm_threshold));
> +
> +		/* Take the timestamps */
> +		spin_lock_irq(&dac33->lock);
> +		dac33->t_stamp2 = ktime_to_us(ktime_get());
> +		dac33->t_stamp1 = dac33->t_stamp2;
> +		spin_unlock_irq(&dac33->lock);
> +
>  		dac33_write16(codec, DAC33_PREFILL_MSB,
>  				DAC33_THRREG(dac33->alarm_threshold));
>  		/* Enable Alarm Threshold IRQ */
> @@ -571,8 +597,18 @@ static inline void dac33_prefill_handler(struct tlv320dac33_priv *dac33)
>  		dac33_write(codec, DAC33_FIFO_IRQ_MASK, DAC33_MAT);
>  		break;
>  	case DAC33_FIFO_MODE7:
> +		/* Take the timestamp */
> +		spin_lock_irq(&dac33->lock);
> +		dac33->t_stamp1 = ktime_to_us(ktime_get());
> +		/* Move back the timestamp with drain time */
> +		dac33->t_stamp1 -= dac33->mode7_us_to_lthr;
> +		spin_unlock_irq(&dac33->lock);
> +
>  		dac33_write16(codec, DAC33_PREFILL_MSB,
>  				DAC33_THRREG(MODE7_LTHR));
> +
> +		/* Enable Upper Threshold IRQ */
> +		dac33_write(codec, DAC33_FIFO_IRQ_MASK, DAC33_MUT);
>  		break;
>  	default:
>  		dev_warn(codec->dev, "Unhandled FIFO mode: %d\n",
> @@ -589,6 +625,11 @@ static inline void dac33_playback_handler(struct tlv320dac33_priv *dac33)
>  
>  	switch (dac33->fifo_mode) {
>  	case DAC33_FIFO_MODE1:
> +		/* Take the timestamp */
> +		spin_lock_irq(&dac33->lock);
> +		dac33->t_stamp2 = ktime_to_us(ktime_get());
> +		spin_unlock_irq(&dac33->lock);
> +
>  		dac33_write16(codec, DAC33_NSAMPLE_MSB,
>  				DAC33_THRREG(dac33->nsample));
>  		break;
> @@ -641,7 +682,13 @@ static irqreturn_t dac33_interrupt_handler(int irq, void *dev)
>  	struct snd_soc_codec *codec = dev;
>  	struct tlv320dac33_priv *dac33 = snd_soc_codec_get_drvdata(codec);
>  
> -	queue_work(dac33->dac33_wq, &dac33->work);
> +	spin_lock(&dac33->lock);
> +	dac33->t_stamp1 = ktime_to_us(ktime_get());
> +	spin_unlock(&dac33->lock);
> +
> +	/* Do not schedule the workqueue in Mode7 */
> +	if (dac33->fifo_mode != DAC33_FIFO_MODE7)
> +		queue_work(dac33->dac33_wq, &dac33->work);
>  
>  	return IRQ_HANDLED;
>  }
> @@ -793,8 +840,8 @@ static int dac33_prepare_chip(struct snd_pcm_substream *substream)
>  			    DAC33_ATM(DAC33_FIFO_IRQ_MODE_LEVEL));
>  		break;
>  	case DAC33_FIFO_MODE7:
> -		/* Disable all interrupts */
> -		dac33_write(codec, DAC33_FIFO_IRQ_MASK, 0);
> +		dac33_write(codec, DAC33_FIFO_IRQ_MODE_A,
> +			DAC33_UTM(DAC33_FIFO_IRQ_MODE_LEVEL));
>  		break;
>  	default:
>  		/* in FIFO bypass mode, the interrupts are not used */
> @@ -929,6 +976,24 @@ static void dac33_calculate_times(struct snd_pcm_substream *substream)
>  
>  	if (dac33->nsample > dac33->nsample_max)
>  		dac33->nsample = dac33->nsample_max;
> +
> +	switch (dac33->fifo_mode) {
> +	case DAC33_FIFO_MODE1:
> +		dac33->mode1_us_burst = SAMPLES_TO_US(dac33->burst_rate,
> +						      dac33->nsample);
> +		dac33->t_stamp1 = 0;
> +		dac33->t_stamp2 = 0;
> +		break;
> +	case DAC33_FIFO_MODE7:
> +		dac33->mode7_us_to_lthr =
> +					SAMPLES_TO_US(substream->runtime->rate,
> +						MODE7_UTHR - MODE7_LTHR + 1);
> +		dac33->t_stamp1 = 0;
> +		break;
> +	default:
> +		break;
> +	}
> +
>  }
>  
>  static int dac33_pcm_prepare(struct snd_pcm_substream *substream,
> @@ -973,6 +1038,151 @@ static int dac33_pcm_trigger(struct snd_pcm_substream *substream, int cmd,
>  	return ret;
>  }
>  
> +static snd_pcm_sframes_t dac33_dai_delay(
> +			struct snd_pcm_substream *substream,
> +			struct snd_soc_dai *dai)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_soc_device *socdev = rtd->socdev;
> +	struct snd_soc_codec *codec = socdev->card->codec;
> +	struct tlv320dac33_priv *dac33 = snd_soc_codec_get_drvdata(codec);
> +	unsigned long long t0, t1, t_now;
> +	unsigned int time_delta;
> +	int samples_out, samples_in, samples;
> +	snd_pcm_sframes_t delay = 0;
> +
> +	switch (dac33->fifo_mode) {
> +	case DAC33_FIFO_BYPASS:
> +		break;
> +	case DAC33_FIFO_MODE1:
> +		spin_lock(&dac33->lock);
> +		t0 = dac33->t_stamp1;
> +		t1 = dac33->t_stamp2;
> +		spin_unlock(&dac33->lock);
> +		t_now = ktime_to_us(ktime_get());
> +
> +		/* We have not started to fill the FIFO yet, delay is 0 */
> +		if (!t1)
> +			goto out;
> +

We may need some logic here to handle any underruns (e.g. recalc our
delay based on underrun), as ALSA will re-call prepare() and there may
still be data playing through the DAC33 FIFO.

Have you tried forcing underruns to see how it behaves ?

Liam


-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
