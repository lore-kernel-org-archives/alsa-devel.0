From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Add support for NAU8824 codec to ASoC
Date: Tue, 24 Feb 2015 23:13:14 +0900
Message-ID: <20150224141314.GI6236@finisterre.sirena.org.uk>
References: <1423986570-6355-1-git-send-email-Vincent.wan@amd.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bzuizT9vlVVqWfw+"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1423986570-6355-1-git-send-email-Vincent.wan@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wan Zongshun <Vincent.wan@amd.com>
Cc: mcuos.com@gmail.com, tiwai@suse.de, alsa-devel@alsa-project.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, Chih-Chiang Chang <ccchang12@nuvoton.com>
List-Id: alsa-devel@alsa-project.org


--bzuizT9vlVVqWfw+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 15, 2015 at 03:49:30PM +0800, Wan Zongshun wrote:

> +	/* SP Class-D mute control */
> +	SOC_DOUBLE("HP Playback Switch", NAU8824_HP_MUTE, NAU8824_L_MUTE_SFT,
> +				NAU8824_R_MUTE_SFT, 1, 1),
> +	SOC_SINGLE_TLV("HP Left Volume", NAU8824_HP_VOL, NAU8824_L_VOL_SFT,
> +				NAU8824_VOL_RSCL_RANGE, 1, out_hp_vol_tlv),
> +	SOC_SINGLE_TLV("HP Right Volume", NAU8824_HP_VOL, NAU8824_R_VOL_SFT,
> +				NAU8824_VOL_RSCL_RANGE, 1, out_hp_vol_tlv),

I would have expected the headphone volume control to be a stereo
(double) control - same for speakers.

> +	/* DMIC control */
> +	SOC_DOUBLE("DMIC L R Switch", NAU8824_ENA_CTRL, NAU8824_DMIC_CH0_SFT,
> +				NAU8824_DMIC_CH1_SFT, 1, 0),
> +	SOC_SINGLE("DMIC Enable", NAU8824_BIAS_ADJ, NAU8824_DMIC1_SFT, 1, 0),
> +	SOC_SINGLE("VMID Switch", NAU8824_BIAS_ADJ, NAU8824_VMID_SFT, 1, 0),
> +	SOC_SINGLE("BIAS Switch", NAU8824_BOOST, NAU8824_G_BIAS_SFT, 1, 0),

This all looks like stuff that should be done with DAPM...

> +	SOC_DOUBLE_R_TLV("MIC L R Gain", NAU8824_ADC_CH0_DGAIN_CTRL,
> +				NAU8824_ADC_CH1_DGAIN_CTRL, 0,
> +				NAU8824_ADC_VOL_RSCL_RANGE,	0, adc_vol_tlv),

All volume controls should be called Volume.

> +static int set_dmic_clk(struct snd_soc_dapm_widget *w,
> +				struct snd_kcontrol *kcontrol, int event)
> +{
> +	struct snd_soc_codec *codec =3D w->codec;

w->codec is going away, use snd_soc_dapm_to_codec().  You should always
submit against current code.

> +static const struct snd_kcontrol_new nau8824_rec_l_mix[] =3D {
> +				SOC_DAPM_SINGLE("BST1 Switch", SND_SOC_NOPM,
> +				0, 0, 0),
> +};

Please use normal indentation, a single tab is enough.

> +static int nau8824_hp_event(struct snd_soc_dapm_widget *w,
> +				struct snd_kcontrol *kcontrol, int event)
> +{
> +	return 0;
> +}

Remove empty functions.

> +	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
> +	case SND_SOC_DAIFMT_CBM_CFM:
> +		reg_val_2 |=3D NAU8824_I2S_MS_M;
> +		break;
> +	case SND_SOC_DAIFMT_CBS_CFS:
> +		break;
> +	case SND_SOC_DAIFMT_CBS_CFM:
> +		break;

These two clocking configurations appear not to differ in terms of what
we do to the device - this suggests that only one of them is actually
supported.

> +static int nau8824_FLL_freerun_mode(struct snd_soc_codec *codec, int IsE=
nable)
> +{
> +	if (IsEnable =3D=3D true) {

This doesn't look like Linux coding style...

> +void set_sys_clk(struct snd_soc_codec *codec, int sys_clk)
> +{
> +	pr_debug("%s sys_clk=3D%x\n", __func__, sys_clk);
> +	switch (sys_clk) {
> +	case NAU8824_INTERNALCLOCK:
> +		nau8824_FLL_freerun_mode(codec, true);
> +		break;
> +
> +	case NAU8824_MCLK:
> +	default:
> +		nau8824_FLL_freerun_mode(codec, false);
> +		break;
> +	}
> +}

=2E..and I don't entirely see why it's a separate function to this (which
is itself an internal wrapper function which possibly shouldn't exist)>

> +static int nau8824_set_sysclk(struct snd_soc_codec *codec,
> +		int clk_id, int source, unsigned int freq, int dir)
> +{
> +	int divider =3D 1;
> +
> +	if (clk_id =3D=3D NAU8824_MCLK) {
> +		set_sys_clk(codec, NAU8824_MCLK);
> +		dev_dbg(codec->dev, "%s: input freq =3D %d divider =3D %d",
> +		__func__, freq, divider);
> +
> +	} else if (clk_id =3D=3D NAU8824_INTERNALCLOCK) {
> +		set_sys_clk(codec, NAU8824_INTERNALCLOCK);
> +	} else {
> +		dev_err(codec->dev, "Wrong clock src\n");
> +		return -EINVAL;
> +	}

Use switch statements rather than if trees like other drivers.  It looks
like clk_id should actually be source since we're selecting the clock to
use rather than selecting which clock to configure.

> +static int nau8824_set_bias_level(struct snd_soc_codec *codec,
> +				enum snd_soc_bias_level level)
> +{
> +	dev_dbg(codec->dev, "## nau8824_set_bias_level %d\n", level);
> +	if (level =3D=3D codec->dapm.bias_level) {
> +		dev_dbg(codec->dev, "##set_bias_level: level returning...\r\n");
> +		return -EINVAL;
> +	}

Why is this here - other drivers don't do this and it doesn't look
device specific?

> +	switch (level) {
> +	case SND_SOC_BIAS_ON:
> +		/* All power is driven by DAPM system*/
> +		dev_dbg(codec->dev, "###nau8824_set_bias_level BIAS_ON\n");
> +		snd_soc_update_bits(codec, NAU8824_BIAS_ADJ,
> +			NAU8824_VMID_MASK, NAU8824_VMID_EN);
> +		snd_soc_update_bits(codec, NAU8824_BOOST,
> +				NAU8824_G_BIAS_MASK, NAU8824_G_BIAS_EN);

We turn on VMID last?  That's a strange thing to do...

> +static int nau8824_suspend(struct snd_soc_codec *codec)
> +{
> +	dev_dbg(codec->dev, "%s: Entered\n", __func__);
> +	nau8824_set_bias_level(codec, SND_SOC_BIAS_OFF);
> +	dev_dbg(codec->dev, "%s: Exiting\n", __func__);
> +	return 0;
> +}

Set idle_bias_off (which it looks like you should be doing) and this
becomes redundant.  If you're *not* using idle_bias_off for some reason
then the set_bias_level() work done in _ON should be undone in at least
_SUSPEND rather than _OFF so we save power on idle.

> +struct nau8824_init_reg {
> +	u8 reg;
> +	u16 val;
> +};

This looks like you're reimplementing regmap's register sequence
stuff...  It's also a *very* large sequence you have, are you sure it's
all required?  It seems like this may be doing a bunch of machine
specific configuration but since it's all magic numbers it's hard to
tell.

> +#define NAU8824_INIT_REG_LEN ARRAY_SIZE(init_list)

Just use ARRAY_SIZE().

> +static int nau8824_reg_init(struct snd_soc_codec *codec)
> +{
> +	int i;
> +
> +	mdelay(1);
> +	for (i =3D 0; i < NAU8824_INIT_REG_LEN; i++) {
> +		if (init_list[i].reg =3D=3D 0xFFFF)
> +			mdelay(1);
> +		else
> +			snd_soc_write(codec, init_list[i].reg,
> +			init_list[i].val);
> +	}

Use the standard regmap patch stuff.  If you need the delays in the
sequence implement that in the core, though I guess you don't since=20
reg is a u8 and you're looking for 0xffff in it...

> +	/* Dynamic Headset detection enabled */
> +	snd_soc_update_bits(codec, 0x01, 0x400, 0x400);
> +	snd_soc_update_bits(codec, 0x02, 0x0008, 0x0008);
> +	snd_soc_update_bits(codec, 0x0f, 0x0300, 0x0100);
> +	snd_soc_write(codec, 0x09, 0xE000);
> +	snd_soc_write(codec, NAU8824_IRQ_SETTING, 0x1006);
> +	snd_soc_write(codec, 0x13, 0x1615);
> +	snd_soc_write(codec, 0x15, 0x0414);
> +	snd_soc_update_bits(codec, 0x16, 0xFF00, 0x5900);
> +	snd_soc_update_bits(codec, 0x66, 0x0070, 0x0060);

Too many magic numbers here I think and this looks like it should be
configured using platform data and/or the machine driver (what if the
headphone detection/IRQ aren't wired up?).  I'd also expect to see
reporting via the standard interfaces for jack reporting.

> +static const struct i2c_device_id nau8824_i2c_id[] =3D {
> +	{ "nau8824", 0},
> +	{"10508824:00", 0},
> +	{"10508824", 0},
> +	{ }
> +};

It looks like you've put some ACPI IDs in the I2C ID table here.  At
least I hope that's what the last two entries are...  if they are ACPI
IDs they should be registered as such.  If they're something else then
what are they?

--bzuizT9vlVVqWfw+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU7Ib2AAoJECTWi3JdVIfQglQH/ipducwZ4Fpp/tP1Yraa6DJX
gHxd5T8hAR7zncrd62xxiiRxS9ZRHIfpNY/NDsXElEnCnPcYaTdBXTm+jtxbtZoI
afk9b7hXhJqP+nLXndbqeLbdoIUZnlJgnUSzZ+S5/dbbP7NyinvaWTbOt35KvRr/
znvr3xa2pTRHfJ3ykawdFShRKeWioBV/wuQtp2cfuRzLfznomBs9nfqPmIaEGFrx
Yf2WxRukR52612m4Vf6RNmjGTBjziQVRPsTc2AzZ4/NdjViBL7PSzdZiyrGodILr
HEO7XosF1gIX92zu3mc3uS2m0R12lhGcrCKLK1LEOri/sebOjRNUtoECb4tXbnc=
=lUHX
-----END PGP SIGNATURE-----

--bzuizT9vlVVqWfw+--
