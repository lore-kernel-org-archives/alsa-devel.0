From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Codec driver for Texas Instruments
 tlv320dac33 codec
Date: Mon, 12 Oct 2009 16:18:00 +0100
Message-ID: <20091012151800.GB18283@rakim.wolfsonmicro.main>
References: <1255348139-13609-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D33CF10386F
	for <alsa-devel@alsa-project.org>;
	Mon, 12 Oct 2009 17:18:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1255348139-13609-1-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 12, 2009 at 02:48:58PM +0300, Peter Ujfalusi wrote:

> +static struct i2c_client *tlv320dac33_client;

> +static struct workqueue_struct *dac33_wq;

I'm surprised to see these done as static variables - is there any great
reason for doing that?

> +static int dac33_read(struct snd_soc_codec *codec, unsigned int reg,
> +		      u8 *value)
> +{
> +	struct tlv320dac33_priv *dac33 = codec->private_data;
> +	int val;
> +
> +	*value = reg & 0xff;
> +
> +	/* If powered off, return the cached value */
> +	mutex_lock(&dac33->mutex);
> +	if (dac33->power_state) {
> +		val = i2c_smbus_read_byte_data(codec->control_data, value[0]);
> +		if (val < 0) {

This is happening a lot - it should probably be factored into the shared
register cache code, there's a lot of devices which could use something
like this especially as regulator support is added to more and more
drivers.

> +			dev_err(codec->dev, "Read failed\n");

It'd be useful to print val here.

> +	 * data is
> +	 *   D23..D16 dac33 register offset
> +	 *   D15..D8  register data MSB
> +	 *   D7...D0  register data LSB
> +	 */
> +	data[0] = reg & 0xff;
> +	data[1] = (value >> 8) & 0xff;
> +	data[2] = value & 0xff;

This looks just like a 16 bit register write - would it make sense to
just treat the CODEC as having 16 bit registers and deal with the
autoincrement fun by latching the top bit of each 16 bit register in the
cache?  That seems to be equivalent to what the current code is doing
but it's a little more direct.

> +static void dac33_set_power(struct snd_soc_codec *codec, int power)
> +{
> +	struct tlv320dac33_priv *dac33 = codec->private_data;
> +
> +	if (power) {
> +		if (dac33->power_gpio >= 0) {
> +			mutex_lock(&dac33->mutex);
> +			gpio_set_value(dac33->power_gpio, 1);
> +			dac33->power_state = 1;
> +			mutex_unlock(&dac33->mutex);
> +		}
> +		dac33_soft_power(codec, 1);

What exactly is the mutex protecting here?  I'd expect it to cover the
soft power function too.

> +static int dac33_set_nsample(struct snd_kcontrol *kcontrol,
> +			 struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
> +	struct tlv320dac33_priv *dac33 = codec->private_data;
> +	int ret = -EINVAL;
> +
> +	if (dac33->nsample == ucontrol->value.integer.value[0])
> +		return 0;
> +	if (ucontrol->value.integer.value[0] < dac33->nsample_min)
> +		dac33->nsample = dac33->nsample_min;
> +	else if (ucontrol->value.integer.value[0] > dac33->nsample_max)
> +		dac33->nsample = dac33->nsample_max;

I'd expect these cases to just return the error and not update the
driver state?

> +static int dac33_set_nsample_switch(struct snd_kcontrol *kcontrol,
> +			 struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
> +	struct tlv320dac33_priv *dac33 = codec->private_data;
> +	int ret = -EINVAL;
> +
> +	if (dac33->nsample_switch == ucontrol->value.integer.value[0])
> +		return 0;
> +	if (ucontrol->value.integer.value[0] < 0)
> +		dac33->nsample_switch = 0;
> +	else if (ucontrol->value.integer.value[0] > 1)
> +		dac33->nsample_switch = 1;
> +	else {
> +		dac33->nsample_switch = ucontrol->value.integer.value[0];
> +		ret = 0;
> +	}

Similarly here.

> +static int dac33_set_bias_level(struct snd_soc_codec *codec,
> +				enum snd_soc_bias_level level)
> +{
> +	switch (level) {
> +	case SND_SOC_BIAS_ON:
> +		dac33_soft_power(codec, 1);
> +		break;
> +	case SND_SOC_BIAS_PREPARE:
> +		break;
> +	case SND_SOC_BIAS_STANDBY:
> +		dac33_soft_power(codec, 0);
> +		break;
> +	case SND_SOC_BIAS_OFF:
> +		dac33_set_power(codec, 0);
> +		break;
> +	}

Hrm.  I'm finding the set_power/soft_power thing a little abstruse here,
partly due to the very close naming and partly due to the asymmetry in
the calls - I can see what they do but it's not entirely obvious.  I'd
also expect to see one of these functions doing a register cache restore
which none of these do. 

I think some refactoring would clarify things here but I don't have a
sufficiently clear understanding of how all the pieces fit together to
offer any concrete suggestions.

> +static int dac33_startup(struct snd_pcm_substream *substream,
> +			   struct snd_soc_dai *dai)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_soc_device *socdev = rtd->socdev;
> +	struct snd_soc_codec *codec = socdev->card->codec;
> +	struct tlv320dac33_priv *dac33 = codec->private_data;
> +	int err;
> +
> +	/* Save the nsample mode to be used until the stream terminates */
> +	dac33->nsmaple_cmode = dac33->nsample_switch;

If you're doing this I'd suggest making the control unwritable while
playback is active in order to avoid confusion.

> +	/* We only need the interrupt in nSample mode */
> +	if (dac33->nsmaple_cmode) {
> +		err = request_irq(dac33->irq, dac33_interrupt_handler,
> +				  IRQF_TRIGGER_RISING | IRQF_DISABLED,
> +				  codec->name, codec);
> +		if (err < 0) {
> +			dev_err(codec->dev, "Could not request IRQ\n");
> +			return err;
> +		}
> +	}

It'd be better to request the IRQ at startup and refuse to offer nsample
mode if you don't have it rather than requesting at the start of each
stream - that's more the expected usage from an IRQ point of view and it
would improve usability since users wouldn't be able to set the mode if
it can't be used.

> +	pwr_ctrl = dac33_read_reg_cache(codec, DAC33_PWR_CTRL);
> +	pwr_ctrl &= ~(OSCPDNB | DACRPDNB | DACLPDNB);
> +	dac33_write(codec, DAC33_PWR_CTRL, pwr_ctrl);

This looks like a case for DAPM?

> +       switch (cmd) {
> +       case SNDRV_PCM_TRIGGER_START:
> +       case SNDRV_PCM_TRIGGER_RESUME:
> +       case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> +               if (dac33->nsmaple_cmode) {
> +                       dac33->state = DAC33_PREFILL;
> +                       queue_work(dac33_wq, &dac33->work);
> +               }

I don't see anything that cancels this work or synchronises with it on
shutdown?

> +static void dac33_init_chip(struct snd_soc_codec *codec)
> +{
> +	/* 44-46: DAC Control Registers */
> +	/* A : DAC sample rate Fsref/1.5 */
> +	dac33_write(codec, DAC33_DAC_CTRL_A, DACRATE(1));
> +	/* B : DAC src=normal, not muted */
> +	dac33_write(codec, DAC33_DAC_CTRL_B, DACSRCR_RIGHT | DACSRCL_LEFT);
> +	/* C : (defaults) */
> +	dac33_write(codec, DAC33_DAC_CTRL_C, 0x00);

Is there any great reason for setting all of this stuff rather than
using the hardware defaults?

> +/* Bit definitions */

Pretty much all the bit definitions need to be namespaced - a lot of
them are very generic and likely to generate clashes.
