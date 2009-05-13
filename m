From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/1] Add AIC3106 support.
Date: Wed, 13 May 2009 17:18:30 +0100
Message-ID: <20090513161829.GA3629@sirena.org.uk>
References: <200905091720.n49HKTSx020571@localhost.localdomain>
	<A24693684029E5489D1D202277BE89443E39393F@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id BD1051038BF
	for <alsa-devel@alsa-project.org>;
	Wed, 13 May 2009 18:18:30 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <A24693684029E5489D1D202277BE89443E39393F@dlee02.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Ambrose, Martin" <martin@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>
List-Id: alsa-devel@alsa-project.org

On Wed, May 13, 2009 at 10:28:23AM -0500, Ambrose, Martin wrote:

> Signed-off-by: Steve Chen <schen@mvista.com>
> Signed-off-by: Martin Ambrose <martin@ti.com>

You should really provide a changelog explaining what's going on with
the chip here, especially with regard to the effect on the other devices
that are supported.

Please also always try to remember to CC the maintainers for things on
patch submissions.

> +static enum aic3x_codec_variant codec_variant;

This shouldn't be static data, it should be stored in the private data
for the codec in order to account for future support for multiple codecs.

> -static int aic3x_write(struct snd_soc_codec *codec, unsigned int reg,
> -		       unsigned int value)
> +static int _aic3x_write(struct snd_soc_codec *codec, unsigned int reg,
> +			unsigned int value)

Please come up with a better name for this.

> +
> +	/* adjust for page 1 before updating hardware if necessary */
> +	if (data[0] >= AIC3X_GEN_PG1_BEG)
> +		data[0] -= AIC3X_GEN_PG1_BEG;
> +

You really need some comments explaining what's going on with the
register paging stuff here.

> +	cur_pg = aic3x_read_reg_cache(codec, 0);
> +	if (reg < pg0_end)
> +		reg_pg = 0;
> +	else if ((reg >= AIC3X_GEN_PG1_BEG) && (reg < pg1_end))
> +		reg_pg = 1;
> +	else
> +		return -EIO;

Should be a different return code, probably -EINVAL or something.

> +static int tlv320aic3x_dual_reg_info(struct snd_kcontrol *kcontrol,
> +				     struct snd_ctl_elem_info *uinfo)
> +{
> +	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
> +	uinfo->count = 1;
> +	uinfo->value.integer.min = 0;
> +	uinfo->value.integer.max = 0xffff;
> +	return 0;
> +}

Is this true for all of these registers?

> +static int tlv320aic3x_dual_reg_put(struct snd_kcontrol *kcontrol,
> +				    struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
> +	int err;
> +	int reg_msb = kcontrol->private_value & 0xff;
> +	int reg_lsb = (kcontrol->private_value >> 8) & 0xff;
> +	int val_msb, val_lsb;
> +
> +	val_msb = (ucontrol->value.integer.value[0] >> 8) & 0xff;
> +	val_lsb = ucontrol->value.integer.value[0] & 0xff;
> +
> +	/* convert unsigned int to 2's complement */
> +	val_msb ^= 0x80;
> +
> +	err = snd_soc_update_bits(codec, reg_msb, 0xff, val_msb);
> +	if (err < 0)
> +		return err;

Just do the register write?

> +#define TLV320AIC3X_DUAL_R(xname, page, reg_msb, reg_lsb) \
> +{      .iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname), \
> +	.info = tlv320aic3x_dual_reg_info, \
> +	.get = tlv320aic3x_dual_reg_get, .put = tlv320aic3x_dual_reg_put, \
> +	.private_value = ((reg_msb) + page) | (((reg_lsb) + page) << 8) }
> +
> +#define TLV320AIC3X_PG1_DUAL_R(xname, reg_msb, reg_lsb) \
> +	TLV320AIC3X_DUAL_R(xname, AIC3X_GEN_PG1_BEG, reg_msb, reg_lsb)

Given that your register write code hides the register pages is there
any need for this to know anything about them?

> +	/* setup register cache sizes */
> +	if (codec_variant == AIC3106_CODEC)
> +		pg1_end = AIC3106_PG1_END;
> +

This doesn't feel very well joined up with the way you've supported this
in the register cache - I'd expect the register code to know about the
maximum register address and be able to check that attempts aren't being
made to use the second page on the less complex codecs.

It'd also be better to write all of these as switch statements so that
any further devices can be supported more readily.

> @@ -284,6 +292,7 @@ int aic3x_button_pressed(struct snd_soc_codec *codec);
>  struct aic3x_setup_data {
>  	int i2c_bus;
>  	unsigned short i2c_address;
> +	enum aic3x_codec_variant variant;
>  	unsigned int gpio_func[2];
>  };

It'd be nice to convert the driver to use the standard I2C probing
stuff, though this is not essential to the patch.
