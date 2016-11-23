From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ALSA SoC MAX98927 driver - Initial release
Date: Wed, 23 Nov 2016 15:46:19 +0000
Message-ID: <20161123154619.6kw5devrzsw7fapm@sirena.org.uk>
References: <1479877026-5172-1-git-send-email-RyanS.Lee@maximintegrated.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nci7c2psfevbhbrl"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1479877026-5172-1-git-send-email-RyanS.Lee@maximintegrated.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ryan Lee <RyanS.Lee@maximintegrated.com>
Cc: lgirdwood@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, perex@perex.cz, tiwai@suse.com, arnd@arndb.de, michael@amarulasolutions.com, oder_chiou@realtek.com, yesanishhere@gmail.com, jacob@teenage.engineering, Damien.Horsley@imgtec.com, bardliao@realtek.com, kuninori.morimoto.gx@renesas.com, petr@barix.com, lars@metafoo.de, nh6z@nh6z.net, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--nci7c2psfevbhbrl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 23, 2016 at 01:57:06PM +0900, Ryan Lee wrote:

> +static struct reg_default max98927_reg_map[] =3D {
> +	{0x0014,  0x78},
> +	{0x0015,  0xFF},
> +	{0x0043,  0x04},
> +	{0x0017,  0x55},
> +	/* For mono driver we are just enabling one channel*/

If this table contains anything other than the physical defaults the
device has it is broken.

> +	{MAX98927_PCM_Rx_Enables_A,  0x03},
> +	{MAX98927_PCM_Tx_HiZ_Control_A, 0xfc},
> +	{MAX98927_PCM_Tx_HiZ_Control_B, 0xff},
> +	{MAX98927_PCM_Tx_Channel_Sources_A, 0x01},
> +	{MAX98927_PCM_Tx_Channel_Sources_B, 0x01},
> +	{MAX98927_Measurement_DSP_Config, 0xf7},
> +	{0x0025,  0x80},

This random mix of strangely formatted #defines and numbers isn't great
- can we please be consistent and ideally use normal style defines?

> +void max98927_wrapper_write(struct max98927_priv *max98927,
> +	unsigned int reg, unsigned int val)
> +{
> +	if (max98927->regmap)
> +		regmap_write(max98927->regmap, reg, val);
> +	if (max98927->sub_regmap)
> +		regmap_write(max98927->sub_regmap, reg, val);
> +}

I don't really know what this is doing but it looks very confused.
Having multiple regmaps is a bit worrying but even more so is having
some of those regmaps be optional.  If the device does sensibly have
multiple register maps I'd really not expect to see them appearing and
disappearing at runtime.  Whatever this is doing it at least needs to be
documented.

> +	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
> +	case SND_SOC_DAIFMT_CBS_CFS:
> +		max98927_wrap_update_bits(max98927, MAX98927_PCM_Master_Mode,
> +		MAX98927_PCM_Master_Mode_PCM_MSTR_MODE_Mask,
> +		MAX98927_PCM_Master_Mode_PCM_MSTR_MODE_SLAVE);
> +		break;

Please use a normal kernel coding style, I can't think of any coding
style where it's normal to indent continuation lines in a multi line
statement like this.  There are severe coding style problems throughout
the driver which make it hard to read, it doesn't visually resemble
normal Linux kernel code.

> +	case SND_SOC_DAIFMT_IB_NF:
> +		invert =3D MAX98927_PCM_Mode_Config_PCM_BCLKEDGE;
> +		break;

> +	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
> +	case SND_SOC_DAIFMT_I2S:
> +		max98927->iface |=3D SND_SOC_DAIFMT_I2S;
> +		max98927_wrap_update_bits(max98927,
> +			MAX98927_PCM_Mode_Config,
> +		max98927->iface, max98927->iface);
> +	break;

The indentation of the break statements isn't consistent within this
function :(  The former is the normal kernel coding style.

> +		if (i =3D=3D ARRAY_SIZE(rate_table)) {
> +			pr_err("%s couldn't get the MCLK to match codec\n",
> +				__func__);

dev_err() and I'm not sure anyone's going to be able to understand that
error message...

> +static void max98927_handle_pdata(struct snd_soc_codec *codec)
> +{
> +	struct max98927_priv *max98927 =3D snd_soc_codec_get_drvdata(codec);
> +	struct max98927_reg_default *regInfo;
> +	int cfg_size =3D 0;
> +	int x;
> +
> +	if (max98927->regcfg !=3D NULL)
> +		cfg_size =3D max98927->regcfg_sz / sizeof(uint32_t);
> +
> +	if (cfg_size <=3D 0) {
> +		dev_dbg(codec->dev,
> +			"Register configuration is not required.\n");
> +		return;
> +	}
> +
> +	/* direct configuration from device tree */
> +	for (x =3D 0; x < cfg_size; x +=3D 3) {
> +		regInfo =3D (struct max98927_reg_default *)&max98927->regcfg[x];
> +		dev_info(codec->dev, "CH:%d, reg:0x%02x, value:0x%02x\n",
> +			be32_to_cpu(regInfo->ch),
> +			be32_to_cpu(regInfo->reg),
> +			be32_to_cpu(regInfo->def));
> +		if (be32_to_cpu(regInfo->ch) =3D=3D PRI_MAX98927
> +			&& max98927->regmap)
> +			regmap_write(max98927->regmap,
> +				be32_to_cpu(regInfo->reg),
> +				be32_to_cpu(regInfo->def));
> +		else if (be32_to_cpu(regInfo->ch) =3D=3D SEC_MAX98927
> +			&& max98927->sub_regmap)
> +			regmap_write(max98927->sub_regmap,
> +				be32_to_cpu(regInfo->reg),
> +				be32_to_cpu(regInfo->def));
> +	}
> +}

This also looks like it probably shouldn't be doing whatever it is doing
but needs some documentation.

I've stopped here.  In general it seems like this driver needs a *lot*
of work to work with the kernel interfaces in a normal style.  Aside
=66rom the coding style issues (which really get in the way) the bulk of
the code appears to be coming from unusual and undocumented ways of
working with kernel APIs.  I'd strongly recommend taking a look at other
drivers for similar hardware and making sure that your driver looks like
them textually and structurally.  If there are things about your
hardware that mean it needs something unusual then it should be clear to
someone reading the code what's going on.

--nci7c2psfevbhbrl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJYNbnKAAoJECTWi3JdVIfQpxMIAIAqMoQIJykRDu+CAEpeD31c
bPwK9s9tJDltoKzxEVf5V7ZxQJDhd5w+LZAph5vpuAjZal5km/EXtB3A2qi42pGH
hnQ2bK8cjfKI+gh+u26/+NqV7q0BRWnKncujA57GMzEDjs43i3A6l7sH+cNp19Sm
yuFyCO6GPTnVbBYYbXQeMvCtGK6DIfpGc0a5heVC1Z5NUtbjvhxvVbF9s6tAMdjr
GXBFlzSvLaq2boePopmZV1bmNum8nLiH+LO87e4expPOtVPU6LWGX42hAdd3nLO5
6rTxngfGyLQItj2toPcp3qp8GAU/baaVXQ+4HmRnCM5yjyI3kWN14y9Il3EHnU0=
=Cu8B
-----END PGP SIGNATURE-----

--nci7c2psfevbhbrl--
