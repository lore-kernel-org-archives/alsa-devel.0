From: "Ambrose, Martin" <martin@ti.com>
Subject: Re: [PATCH 1/1] Add AIC3106 support.
Date: Tue, 19 May 2009 15:17:19 -0500
Message-ID: <A24693684029E5489D1D202277BE89443E661419@dlee02.ent.ti.com>
References: <200905091720.n49HKTSx020571@localhost.localdomain>
	<A24693684029E5489D1D202277BE89443E39393F@dlee02.ent.ti.com>
	<20090513161829.GA3629@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 304CB10388B
	for <alsa-devel@alsa-project.org>;
	Tue, 19 May 2009 22:17:29 +0200 (CEST)
In-Reply-To: <20090513161829.GA3629@sirena.org.uk>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Steve Chen <schen@mvista.com>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>
List-Id: alsa-devel@alsa-project.org

On Wed, May 13, 2009 at 11:18:30, Mark Brown wrote:

Thanks for the review comments -- sorry for the delay in responding.

 
> > Signed-off-by: Steve Chen <schen@mvista.com>
> > Signed-off-by: Martin Ambrose <martin@ti.com>
> 
> You should really provide a changelog explaining what's going on with
> the chip here, especially with regard to the effect on the 
> other devices
> that are supported.

This is an area I'm struggling with a bit and could use your advice.

My primary intent is to enable all AIC3106 functionality since my current 
focus is on platforms which use this codec. My first patch set, which 
admittedly was basically just a diff with the MV5 tree, added more than just 
AIC3106 specifics. It added controls for effects, de-emphasis, and 
attenuation coefficients which are common between the AIC33 and AIC3106 and 
lie in the page 1 register set. To digress, I'm curious why these don't 
already exist for the AIC33 since the source file indicates " It supports 
full aic33 codec functionality." 

In addition the patch provided controls for those page 1 registers (high 
pass coefficients) which are on the AIC3106 but not the AIC33. But did not 
add controls for the new AIC3106 page 0 registers. So, to get to my point, I 
propose three sets of patches. The first would add page 1 register support 
to AIC33 then a follow on patch would add the AIC3106 high pass coeff 
support. The concept/variable of a codec variant would only be introduced in 
the second patch set. A third patch, further out in time when I understand 
better ALSA AGC and power management, would add support for the new page 0 
registers.

Regarding the firs patch set, one concern I have is that this file is also 
compatible with AIC31 and AIC32. The addition of controls without 
qualification would result in these appearing in amixer but not actually 
present. On the other hand this seems to be the general strategy of this 
file. For example the AIC32 does not have register 73 but the 
LINE2L_2_MONOLOPM_VOL control is added for all devices since it is on the 
AIC33. Of course everything could be restructured to be more accurate on a 
device by device basis but this seems too severe and far reaching.

  
> Please also always try to remember to CC the maintainers for things on
> patch submissions.

Ack.


> > +static enum aic3x_codec_variant codec_variant;
> 
> This shouldn't be static data, it should be stored in the private data
> for the codec in order to account for future support for 
> multiple codecs.

Ack.

 
> > -static int aic3x_write(struct snd_soc_codec *codec, 
> unsigned int reg,
> > -		       unsigned int value)
> > +static int _aic3x_write(struct snd_soc_codec *codec, 
> unsigned int reg,
> > +			unsigned int value)
> 
> Please come up with a better name for this.

I may subsume the new function into the old. However I do like the convention of leading underscore (_) to represent local/private helper functions. I guess this is frowned upon in the kernel source.


> > +
> > +	/* adjust for page 1 before updating hardware if necessary */
> > +	if (data[0] >= AIC3X_GEN_PG1_BEG)
> > +		data[0] -= AIC3X_GEN_PG1_BEG;
> > +
> 
> You really need some comments explaining what's going on with the
> register paging stuff here.
>
> > +	cur_pg = aic3x_read_reg_cache(codec, 0);
> > +	if (reg < pg0_end)
> > +		reg_pg = 0;
> > +	else if ((reg >= AIC3X_GEN_PG1_BEG) && (reg < pg1_end))
> > +		reg_pg = 1;
> > +	else
> > +		return -EIO;
>
> Should be a different return code, probably -EINVAL or something.

Ack.
 
> > +static int tlv320aic3x_dual_reg_info(struct snd_kcontrol *kcontrol,
> > +				     struct snd_ctl_elem_info *uinfo)
> > +{
> > +	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
> > +	uinfo->count = 1;
> > +	uinfo->value.integer.min = 0;
> > +	uinfo->value.integer.max = 0xffff;
> > +	return 0;
> > +}
> 
> Is this true for all of these registers?

I believe so but will double check.

 
> > +static int tlv320aic3x_dual_reg_put(struct snd_kcontrol *kcontrol,
> > +				    struct snd_ctl_elem_value *ucontrol)
> > +{
> > +	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
> > +	int err;
> > +	int reg_msb = kcontrol->private_value & 0xff;
> > +	int reg_lsb = (kcontrol->private_value >> 8) & 0xff;
> > +	int val_msb, val_lsb;
> > +
> > +	val_msb = (ucontrol->value.integer.value[0] >> 8) & 0xff;
> > +	val_lsb = ucontrol->value.integer.value[0] & 0xff;
> > +
> > +	/* convert unsigned int to 2's complement */
> > +	val_msb ^= 0x80;
> > +
> > +	err = snd_soc_update_bits(codec, reg_msb, 0xff, val_msb);
> > +	if (err < 0)
> > +		return err;
> 
> Just do the register write?

Steve's response but I need to also review:
-- Hardware values are in 2's complement and software values are in
unsigned int.  When a value of '0' is passed in, it translated to the
smallest possible value that should be written to hardware (which is
0x80000000).

 
> > +#define TLV320AIC3X_DUAL_R(xname, page, reg_msb, reg_lsb) \
> > +{      .iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname), \
> > +	.info = tlv320aic3x_dual_reg_info, \
> > +	.get = tlv320aic3x_dual_reg_get, .put = 
> tlv320aic3x_dual_reg_put, \
> > +	.private_value = ((reg_msb) + page) | (((reg_lsb) + 
> page) << 8) }
> > +
> > +#define TLV320AIC3X_PG1_DUAL_R(xname, reg_msb, reg_lsb) \
> > +	TLV320AIC3X_DUAL_R(xname, AIC3X_GEN_PG1_BEG, reg_msb, reg_lsb)
> 
> Given that your register write code hides the register pages is there
> any need for this to know anything about them?

Steve's response but I need to also review:
-- The registers 0-100 are mapped to register 0-100 of page 0, and
registers 128 - 204 are mapped to registers 0-76 of page 1.  This macro
adds the page 1 offset so that the write functions can tell the
registers are for page 1.

 
> > +	/* setup register cache sizes */
> > +	if (codec_variant == AIC3106_CODEC)
> > +		pg1_end = AIC3106_PG1_END;
> > +
> 
> This doesn't feel very well joined up with the way you've 
> supported this
> in the register cache - I'd expect the register code to know about the
> maximum register address and be able to check that attempts 
> aren't being
> made to use the second page on the less complex codecs.
> 
> It'd also be better to write all of these as switch statements so that
> any further devices can be supported more readily.

Ack.


> > @@ -284,6 +292,7 @@ int aic3x_button_pressed(struct 
> snd_soc_codec *codec);
> >  struct aic3x_setup_data {
> >  	int i2c_bus;
> >  	unsigned short i2c_address;
> > +	enum aic3x_codec_variant variant;
> >  	unsigned int gpio_func[2];
> >  };
> 
> It'd be nice to convert the driver to use the standard I2C probing
> stuff, though this is not essential to the patch.

Agreed and think this should be a separate stand-alone patch for othogonality purposes.


Regards, 
Martin
