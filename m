From: Software Maintainer <software.maintainer@diasemi.com>
Subject: Re: [PATCH] ASoC: codecs: Add DA732x codec driver
Date: Thu, 24 May 2012 08:15:54 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A03372E3F6249@SW-EX-MBX01.diasemi.com>
References: <2E89032DDAA8B9408CB92943514A03372E3F5F40@SW-EX-MBX01.diasemi.com>
	<20120523111434.GL4085@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailrelay1.diasemi.com (mailrelay1.diasemi.com [82.210.246.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 2DFD424346
	for <alsa-devel@alsa-project.org>;
	Thu, 24 May 2012 10:16:03 +0200 (CEST)
In-Reply-To: <20120523111434.GL4085@opensource.wolfsonmicro.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Michal Hajduk <Michal.Hajduk@diasemi.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 23 May, 2012 at 12:15, Mark Brown wrote:
> 
> You only ever enable this and it seems like it should be a widget - why
> is it not a widget?
> 

Makes sense. Will change this.

> This should be a switch not an enum.

Agreed.

> 
> > +static int da732x_hpf_set(struct snd_kcontrol *kcontrol,
> > +			  struct snd_ctl_elem_value *ucontrol)
> > +{
> > +	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
> > +	struct soc_enum *enum_ctrl = (struct soc_enum *)kcontrol->private_value;
> > +	unsigned int reg = enum_ctrl->reg;
> > +	unsigned int sel = ucontrol->value.integer.value[0];
> > +	unsigned int bits;
> > +
> > +	switch (sel) {
> > +	case DA732X_HPF_DISABLED:
> > +		bits = DA732X_HPF_DIS;
> > +		break;
> > +	case DA732X_HPF_VOICE:
> > +		bits = DA732X_HPF_VOICE_EN;
> > +		break;
> > +	case DA732X_HPF_MUSIC:
> > +		bits = DA732X_HPF_MUSIC_EN;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	snd_soc_update_bits(codec, reg, DA732X_HPF_MASK, bits);
> 
> Why is this not done using a normal enum?

> Similarly here, and this looks like a switch statement.

Agreed.

> This should be generic code, there's nothing device specific about this
> control type and it'd be useful for other devices.

Will look at this and see if we can create something generic.

> Just MIC1 Switch.

Agreed.

> All these should be Volumes, and really they should be stereo controls.

Agreed.

> Volume needs to be the last thing in the name.

Ok, will change this.

> This looks like you perhaps need some supply widgets.  Similarly for
> most of your events.

Ok, will update.

> Don't use MICBIAS widgets for new code, use supply widgets.

Will change it.

> The MICBIASes should be connected on the board.

Will look at this.

> Use dai->base.

Will change.

> Use snd_soc_update_bits, this will fix the issue where you don't
> currently clear the register.  You're also missing error handling in the
> default: case.

Agreed. Will change this.

> Don't make up private defines for generic things like this.  Though
> really a define like this is a bit silly...

Fair point, will update.

> This should either stop and restart the PLL or return an error if it's
> already enabled.

Will change this accordingly.
 
> This doesn't validate against the sysclk rate...

> Pass back the error code.
 
> This means there's no way to stop the PLL.

Will do some rework here to improve this area of the code.

> This appears to mute all the DACs but you have two audio interfaces and
> also had some other code which also managed the mutes...  If there's no
> mutes on the actual audio interfaces just don't implement this.

Will look at this. Some rework required.
 
> SNDRV_PCM_RATE_8000_48000

Will change to use SNDRV_PCM_RATE_8000_96000.

> Almost all of this sequence looks like it should be in set_bias_level(),
> it'll be needed every time the chip is powered up and sequencing looks
> important.

Makes sense. Will rearrange the code for this.

> Shouldn't this be a supply, or again in set_bias_level()?

Again, will look at this.

> Should be dynamically managed.

Will update.

> devm_regmap_init_i2c().

Yes, this is nicer. Will change.

> Remove the i2c, devices connected by I2C are generally i2c devices...
> 
> > +		.name	= "da732x-i2c",

Ok, no problem. Will do that.
 
> module_i2c_driver().

Ok, that's neater. Will change.

> Really not sure how helpful I found any of these reading the code.

Ok will remove.

Thanks

Adam
