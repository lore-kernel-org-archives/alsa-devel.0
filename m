From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH] ASoC: Codec driver for Texas Instruments
	tlv320dac33 codec
Date: Tue, 13 Oct 2009 10:12:59 +0300
Message-ID: <200910131013.00050.peter.ujfalusi@nokia.com>
References: <1255348139-13609-1-git-send-email-peter.ujfalusi@nokia.com>
	<20091012151800.GB18283@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id CDC4C10388F
	for <alsa-devel@alsa-project.org>;
	Tue, 13 Oct 2009 09:14:15 +0200 (CEST)
In-Reply-To: <20091012151800.GB18283@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Monday 12 October 2009 18:18:00 ext Mark Brown wrote:
> On Mon, Oct 12, 2009 at 02:48:58PM +0300, Peter Ujfalusi wrote:
> > +static struct i2c_client *tlv320dac33_client;
> >
> > +static struct workqueue_struct *dac33_wq;
> =

> I'm surprised to see these done as static variables - is there any great
> reason for doing that?

Hmm, I'm surprised as well, will be fixed.

> =

> > +static int dac33_read(struct snd_soc_codec *codec, unsigned int reg,
> > +		      u8 *value)
> > +{
> > +	struct tlv320dac33_priv *dac33 =3D codec->private_data;
> > +	int val;
> > +
> > +	*value =3D reg & 0xff;
> > +
> > +	/* If powered off, return the cached value */
> > +	mutex_lock(&dac33->mutex);
> > +	if (dac33->power_state) {
> > +		val =3D i2c_smbus_read_byte_data(codec->control_data, value[0]);
> > +		if (val < 0) {
> =

> This is happening a lot - it should probably be factored into the shared
> register cache code, there's a lot of devices which could use something
> like this especially as regulator support is added to more and more
> drivers.

Actually this does not happen that much, since the reg_cache is used for mo=
st of =

the read operation, but the write through I2C might be happening more.

> =

> > +			dev_err(codec->dev, "Read failed\n");
> =

> It'd be useful to print val here.

Sure.

> =

> > +	 * data is
> > +	 *   D23..D16 dac33 register offset
> > +	 *   D15..D8  register data MSB
> > +	 *   D7...D0  register data LSB
> > +	 */
> > +	data[0] =3D reg & 0xff;
> > +	data[1] =3D (value >> 8) & 0xff;
> > +	data[2] =3D value & 0xff;
> =

> This looks just like a 16 bit register write - would it make sense to
> just treat the CODEC as having 16 bit registers and deal with the
> autoincrement fun by latching the top bit of each 16 bit register in the
> cache?  That seems to be equivalent to what the current code is doing
> but it's a little more direct.

Most of the registers are 8 bit, there are few exception to this, where 2 =

registers holds the MSB and LSB of the value, that's justify the existence =
of =

this function. I could have used two writes for the registers, but in this =
way =

the code looks cleaner.

> =

> > +static void dac33_set_power(struct snd_soc_codec *codec, int power)
> > +{
> > +	struct tlv320dac33_priv *dac33 =3D codec->private_data;
> > +
> > +	if (power) {
> > +		if (dac33->power_gpio >=3D 0) {
> > +			mutex_lock(&dac33->mutex);
> > +			gpio_set_value(dac33->power_gpio, 1);
> > +			dac33->power_state =3D 1;
> > +			mutex_unlock(&dac33->mutex);
> > +		}
> > +		dac33_soft_power(codec, 1);
> =

> What exactly is the mutex protecting here?  I'd expect it to cover the
> soft power function too.

It suppose to protect the dac33->power_state, which is checked when accessi=
ng to =

the chip (via I2C). Probably there would be no problems, if I don't use the =

mutex for protecting the dac33->power_state...
Basically nothing will brake, but the I2C access would fail and the driver =
would =

print an error to the log.
I'm not sure how to make sure that we can access to the chip, and at the sa=
me =

time do not use extensive mutex lock/unlock for the I2C accesses.
Ideas?

> =

> > +static int dac33_set_nsample(struct snd_kcontrol *kcontrol,
> > +			 struct snd_ctl_elem_value *ucontrol)
> > +{
> > +	struct snd_soc_codec *codec =3D snd_kcontrol_chip(kcontrol);
> > +	struct tlv320dac33_priv *dac33 =3D codec->private_data;
> > +	int ret =3D -EINVAL;
> > +
> > +	if (dac33->nsample =3D=3D ucontrol->value.integer.value[0])
> > +		return 0;
> > +	if (ucontrol->value.integer.value[0] < dac33->nsample_min)
> > +		dac33->nsample =3D dac33->nsample_min;
> > +	else if (ucontrol->value.integer.value[0] > dac33->nsample_max)
> > +		dac33->nsample =3D dac33->nsample_max;
> =

> I'd expect these cases to just return the error and not update the
> driver state?

Will do that.

> =

> > +static int dac33_set_nsample_switch(struct snd_kcontrol *kcontrol,
> > +			 struct snd_ctl_elem_value *ucontrol)
> > +{
> > +	struct snd_soc_codec *codec =3D snd_kcontrol_chip(kcontrol);
> > +	struct tlv320dac33_priv *dac33 =3D codec->private_data;
> > +	int ret =3D -EINVAL;
> > +
> > +	if (dac33->nsample_switch =3D=3D ucontrol->value.integer.value[0])
> > +		return 0;
> > +	if (ucontrol->value.integer.value[0] < 0)
> > +		dac33->nsample_switch =3D 0;
> > +	else if (ucontrol->value.integer.value[0] > 1)
> > +		dac33->nsample_switch =3D 1;
> > +	else {
> > +		dac33->nsample_switch =3D ucontrol->value.integer.value[0];
> > +		ret =3D 0;
> > +	}
> =

> Similarly here.

I'll fix this as well. =


> =

> > +static int dac33_set_bias_level(struct snd_soc_codec *codec,
> > +				enum snd_soc_bias_level level)
> > +{
> > +	switch (level) {
> > +	case SND_SOC_BIAS_ON:
> > +		dac33_soft_power(codec, 1);
> > +		break;
> > +	case SND_SOC_BIAS_PREPARE:
> > +		break;
> > +	case SND_SOC_BIAS_STANDBY:
> > +		dac33_soft_power(codec, 0);
> > +		break;
> > +	case SND_SOC_BIAS_OFF:
> > +		dac33_set_power(codec, 0);
> > +		break;
> > +	}
> =

> Hrm.  I'm finding the set_power/soft_power thing a little abstruse here,
> partly due to the very close naming and partly due to the asymmetry in
> the calls - I can see what they do but it's not entirely obvious.

Hmm, yes you are right, it is kind of a mess...
I can think of the following:
dac33_set_power -> dac33_hard_reset
dac33_soft_power -> dac33_soft_reset

In dac33_set_bias_level only toggle the dac33_soft_reset.
In dac33_soc_suspend/dac33_soc_resume I can use the dac33_hard_reset with =

register restore.

Does it makes it a bit cleaner?

> I'd also expect to see one of these functions doing a register cache rest=
ore
> which none of these do.

After dac33_set_power(1) there is a place for restoring the registers, yes.
At the moment the only place where this is happening is in dac33_soc_resume,
there I can add the register restore.

> =

> I think some refactoring would clarify things here but I don't have a
> sufficiently clear understanding of how all the pieces fit together to
> offer any concrete suggestions.
> =

> > +static int dac33_startup(struct snd_pcm_substream *substream,
> > +			   struct snd_soc_dai *dai)
> > +{
> > +	struct snd_soc_pcm_runtime *rtd =3D substream->private_data;
> > +	struct snd_soc_device *socdev =3D rtd->socdev;
> > +	struct snd_soc_codec *codec =3D socdev->card->codec;
> > +	struct tlv320dac33_priv *dac33 =3D codec->private_data;
> > +	int err;
> > +
> > +	/* Save the nsample mode to be used until the stream terminates */
> > +	dac33->nsmaple_cmode =3D dac33->nsample_switch;
> =

> If you're doing this I'd suggest making the control unwritable while
> playback is active in order to avoid confusion.

Yes, than I don't need the nsample_cmode.

> =

> > +	/* We only need the interrupt in nSample mode */
> > +	if (dac33->nsmaple_cmode) {
> > +		err =3D request_irq(dac33->irq, dac33_interrupt_handler,
> > +				  IRQF_TRIGGER_RISING | IRQF_DISABLED,
> > +				  codec->name, codec);
> > +		if (err < 0) {
> > +			dev_err(codec->dev, "Could not request IRQ\n");
> > +			return err;
> > +		}
> > +	}
> =

> It'd be better to request the IRQ at startup and refuse to offer nsample
> mode if you don't have it rather than requesting at the start of each
> stream - that's more the expected usage from an IRQ point of view and it
> would improve usability since users wouldn't be able to set the mode if
> it can't be used.

Good point.

> =

> > +	pwr_ctrl =3D dac33_read_reg_cache(codec, DAC33_PWR_CTRL);
> > +	pwr_ctrl &=3D ~(OSCPDNB | DACRPDNB | DACLPDNB);
> > +	dac33_write(codec, DAC33_PWR_CTRL, pwr_ctrl);
> =

> This looks like a case for DAPM?

Well, yes. I have tried that. The problem is that tlv320dac33 is really pic=
ky on =

the sequence of the register writes. what I mean by 'picky' is that if the =

register accesses are not in certain order, than dac33 would be not operati=
onal.
This particular shutdown is in place, because otherwise dac33 would be dead=
 in =

certain cases...
There might be a possibility to find another sequence, which is working, bu=
t =

this is really time consuming process.
I'd also like to move these to DAPM domain, but for now, I'd like to leave =
this =

as it is and fix it later, if it is possible at all.

> =

> > +       switch (cmd) {
> > +       case SNDRV_PCM_TRIGGER_START:
> > +       case SNDRV_PCM_TRIGGER_RESUME:
> > +       case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> > +               if (dac33->nsmaple_cmode) {
> > +                       dac33->state =3D DAC33_PREFILL;
> > +                       queue_work(dac33_wq, &dac33->work);
> > +               }
> =

> I don't see anything that cancels this work or synchronises with it on
> shutdown?

Good point, also the dac33->state is not really protected, which can cause =
some =

interesting behavior, I think.
I'll look at this as well..

> =

> > +static void dac33_init_chip(struct snd_soc_codec *codec)
> > +{
> > +	/* 44-46: DAC Control Registers */
> > +	/* A : DAC sample rate Fsref/1.5 */
> > +	dac33_write(codec, DAC33_DAC_CTRL_A, DACRATE(1));
> > +	/* B : DAC src=3Dnormal, not muted */
> > +	dac33_write(codec, DAC33_DAC_CTRL_B, DACSRCR_RIGHT | DACSRCL_LEFT);
> > +	/* C : (defaults) */
> > +	dac33_write(codec, DAC33_DAC_CTRL_C, 0x00);
> =

> Is there any great reason for setting all of this stuff rather than
> using the hardware defaults?

Yes and no. I can wipe out the unneeded things, but most of the settings he=
re is =

needed to get the dac33 working. If we use the HW defaults, than dac33 woul=
d not =

work.
The DAC_CTRL_B register for example controls the digital routing to the DAC=
s.
I will try to find a way to use user controls for most of the settings in a =

future, if it is OK.

> =

> > +/* Bit definitions */
> =

> Pretty much all the bit definitions need to be namespaced - a lot of
> them are very generic and likely to generate clashes.

I'll go through all of them.


Thanks,
P=E9ter
