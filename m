From: Peter Hsiang <Peter.Hsiang@maxim-ic.com>
Subject: Re: [PATCH] ASoC: Add max98088 CODEC driver
Date: Wed, 29 Sep 2010 14:42:32 -0700
Message-ID: <B2150E1E4418E1438554A300EA5040E40D46F2D8D8@ITSVLEX06.it.maxim-ic.internal>
References: <B2150E1E4418E1438554A300EA5040E40D469C124D@ITSVLEX06.it.maxim-ic.internal>
	<20100929033757.GB29975@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from antispam01.maxim-ic.com (antispam01.maxim-ic.com
	[205.153.101.182])
	by alsa0.perex.cz (Postfix) with ESMTP id DA1492449B
	for <alsa-devel@alsa-project.org>;
	Wed, 29 Sep 2010 23:42:12 +0200 (CEST)
In-Reply-To: <20100929033757.GB29975@opensource.wolfsonmicro.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Jesse@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Marroquin <Jesse.Marroquin@maxim-ic.com>, Liam@alsa-project.org, Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 29, 2010, Mark Brown wrote:
> On Tue, Sep 28, 2010 at 07:34:34PM -0700, Peter Hsiang wrote:
> 
> > +#define EQ_CFG_MAX 32
> 
> There doesn't seem to be any need to hard code a limit here?

Are you requiring the implementation be exactly the same way you did?

> 
> > +/*
> > + * For kernels compiled without unsigned long long int division
> > + */
> > +unsigned long long int ulldiv(unsigned long long int dividend,
> > +                             unsigned long long int divisor)
> 
> This is causing me some concern.  Even if it is required this does not
> look like something that should be part of a specific driver - what
> happens if some other driver needs the same thing?

You are more than welcome to use this in your driver as well :)
Just use it.  Sounds like you are suggesting to have it located in a
central location outside of the codec driver?
Would you like that in soc-core.c?  Let me know.

> 
> > +/*
> > + * The INx1 and INx2 PGAs share a power control signal.
> > + * This function OR's the two power events to keep an unpowered INx
> > + * from turning off it's counterpart.
> > + * The control names are used to identify the PGA.
> > + */
> 
> This...
> 
> > +       if (strncmp(w->name, "INA1", 4) == 0) {
> > +               pga = INA1_PGA_BIT;
> > +               mask = INA1_PGA_BIT | INA2_PGA_BIT;
> 
> ...doesn't seem to correspond to this, at least with the normal way mask
> is used.  Apart from anything else it looks like you have individual
> mask bits for each of the INx1 and INx2 PGAs (since you can define mask
> bits for each of them).  It would be much clearer if the code made it
> obvious that these aren't register bits but rather that you're storing
> the data in a register-like bitfield in a variable.  I can't help but
> think that a reference count would be much clearer.

There are more than one way to solve a problem, and they all can be
correct.
Would additional comments to clarify that this is not register bits
satisfy your requirement?

> 
> > +       if (event == SND_SOC_DAPM_POST_PMU) {
> > +               /* ON */
> > +               *state |= pga;
> > +
> > +               /* Turn on, avoiding unnecessary writes */
> > +               val = snd_soc_read(codec, w->reg);
> > +               if (!(val & (1 << w->shift))) {
> > +                       val |= (1 << w->shift);
> > +                       snd_soc_write(codec, w->reg, val);
> > +               }
> 
> snd_soc_update_bits() will suppress unwanted register writes.

>From the comments sounds like it resemble snd_soc_update_bits.
The code logic here is different from snd_soc_update_bits,
and therefore snd_soc_update_bits can not be used for this
like you suggested.

> > +
> > +static const unsigned int ex_mode_table[] = {
> > +       0x00,           /* disabled */
> > +       (0<<4)|3,       /* 100Hz */
> > +       (1<<4)|0,       /* 400Hz */
> > +       (2<<4)|0,       /* 600Hz */
> > +       (3<<4)|0,       /* 800Hz */
> > +       (4<<4)|0,       /* 1000Hz */
> > +       (1<<4)|1,       /* 200-400Hz */
> > +       (2<<4)|2,       /* 400-600Hz */
> > +       (3<<4)|2,       /* 400-800Hz */
> > +};
> 
> You should add value muxes like we have for DAPM.

Please clarify what you mean by referencing the specific 
code usage case in the dapm source module.

> 
> > +static const char *max98088_extmic[] = {
> > +       "Off",
> > +       "MIC1",
> > +       "MIC2",
> > +};
> 
> > +static const struct soc_enum max98088_extmic_enum[] = {
> > +       SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(max98088_extmic), max98088_extmic),
> > +};
> 
> This looks like it should be in DAPM.

This has nothing to do with power management.  
I guess you were confused by the word "Off" in the options list.
The "Off" case means the input for external mic is not used,
i.e. disconnected.  It does not power up or down anything.

> 
> > +static int max98088_mic1pre_set(struct snd_kcontrol *kcontrol,
> > +                               struct snd_ctl_elem_value *ucontrol)
> > +{
> > +       struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
> > +       struct max98088_priv *max98088 = snd_soc_codec_get_drvdata(codec);
> > +       unsigned int *mode = &max98088->mic1pre;
> > +       int sel = ucontrol->value.integer.value[0];
> > +
> > +       if (sel >= ARRAY_SIZE(max98088_micpre))
> > +               return -EINVAL;
> > +
> > +       *mode = ucontrol->value.integer.value[0];
> > +       return 0;
> > +}
> 
> I'd expect that some action would be taken when the value is set here.
> All this does is set a variable, changing the control will have no
> effect.

The register field works like this:
00 = preamp disabled
01 = 0dB
10 = 20dB
11 = 30dB
So the gain and the power setting are in the same bit field.
DAPM owns the power control.  Here the user settings are stored,
and they get picked up by DAPM.

> 
> > +static int max98088_hp_event(struct snd_soc_dapm_widget *w,
> > +                            struct snd_kcontrol *kcontrol, int event)
> > +{
> > +       struct snd_soc_codec *codec = w->codec;
> > +       u16 status;
> > +
> > +       BUG_ON(event != SND_SOC_DAPM_PRE_PMD);
> > +
> > +       /* powering down headphone gracefully */
> > +       status = snd_soc_read(codec, M98088_REG_4D_PWR_EN_OUT);
> > +       if ((status & M98088_HPEN) == M98088_HPEN) {
> > +               max98088_hw_write(codec, M98088_REG_4D_PWR_EN_OUT,
> > +                       (status & ~M98088_HPEN));
> > +       }
> > +       schedule_timeout(msecs_to_jiffies(20));
> 
> This looks rather like it should just be a post event implementing a
> timeout?

This needs to work as a pre event.

> 
> > +       if (rate != cdata->rate) {
> > +               /* set DAI1 SR1 value for the DSP; FREQ1:0=anyclock */
> > +               if (rate_value(rate, &regval))
> > +                       return -EINVAL;
> > +
> > +               snd_soc_write(codec, M98088_REG_11_DAI1_CLKMODE, regval);
> > +               cdata->rate = rate;
> > +       }
> 
> Just use snd_soc_update_bits() to suppress unneeded writes.  Many of the
> operaations have this issue.

The full value for this register is accounted for here and so there
is no need to use snd_soc_update_bits for this case.

> 
> > +               & M98088_DAI_MAS) {
> > +               if (max98088->sysclk == 0)
> > +                       return -EINVAL;
> 
> You should print an error here so users can tell what went wrong.

Yes thank you.

> 
> > +       case SND_SOC_BIAS_STANDBY:
> > +               max98088_sync_cache(codec);
> > +               snd_soc_update_bits(codec, M98088_REG_4C_PWR_EN_IN,
> > +                               M98088_MBEN, M98088_MBEN);
> > +               break;
> 
> Do you really want to sync the cache *every* time you go into standby?

The sync_cache function itself will just return if the
codec->cache_sync flag is cleared from the first time it ran.
You do the exact same thing in your codec driver...
What is the change that you are suggesting?

> 
> > +module_init(max98088_init);
> 
> Normally this would be next to the function it references.

Is this a new formatting style of the kernel now all across,
or is this a personal preference?
Not a problem, I can change it.  Just that I find a huge number 
of drivers in the kernel having the module_init and module_exit 
together at the very end.
