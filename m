From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Add max98926 codec driver
Date: Tue, 2 Jun 2015 21:30:05 +0100
Message-ID: <20150602203005.GT14071@sirena.org.uk>
References: <1432931525-24193-1-git-send-email-yesanishhere@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7152420082299264428=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0958A260523
 for <alsa-devel@alsa-project.org>; Tue,  2 Jun 2015 22:30:16 +0200 (CEST)
In-Reply-To: <1432931525-24193-1-git-send-email-yesanishhere@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anish Kumar <yesanishhere@gmail.com>
Cc: alsa-devel@alsa-project.org, nitin.mittal@maximintegrated.com
List-Id: alsa-devel@alsa-project.org


--===============7152420082299264428==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="EIrXVFSPgsocVIgL"
Content-Disposition: inline


--EIrXVFSPgsocVIgL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2015 at 01:32:05PM -0700, Anish Kumar wrote:

This looks mostly good, there's a few things below but they're mostly
pretty small and should be easy to update.

> +static const char *const max98926_hpf_cutoff_txt[] =3D {
> +	"hpf_disable", "hpf_dc_block", "hpf_enable_100",
> +	"hpf_enable_200", "hpf_enable_400", "hpf_enable_800",
> +};

Please write these like other ALSA controls write user visible strings -
"Disable", "DC Block", "100Hz" and so on.

> +static const char *const max98926_input_txt[] =3D {
> +	"Pcm", "Analog",
> +};

PCM.

> +static struct reg_default max98926_reg[] =3D {
> +	{ 0x00, 0x00 }, /* Battery Voltage Data */
> +	{ 0x01, 0x00 }, /* Boost Voltage Data */
> +	{ 0x02, 0x00 }, /* Live Status0 */
> +	{ 0x03, 0x00 }, /* Live Status1 */
> +	{ 0x04, 0x00 }, /* Live Status2 */

These and some of the other registers sound like volatile registers
which shouldn't have defaults since they shouldn't be in the cache at
all but rather read from the device - and you do in fact have a function
marking them as volatile further down.

> +static int max98926_dac_event(struct snd_soc_dapm_widget *w,
> +		struct snd_kcontrol *kcontrol, int event)
> +{
> +	struct snd_soc_codec *codec =3D snd_soc_dapm_to_codec(w->dapm);
> +	struct max98926_priv *max98926 =3D snd_soc_codec_get_drvdata(codec);
> +
> +	switch (event) {
> +	case SND_SOC_DAPM_PRE_PMU:
> +		regmap_update_bits(max98926->regmap,
> +			MAX98926_BLOCK_ENABLE, MAX98926_BST_EN_MASK |
> +			MAX98926_ADC_IMON_EN_MASK |
> +			MAX98926_ADC_VMON_EN_MASK,
> +			MAX98926_BST_EN_MASK |
> +			MAX98926_ADC_IMON_EN_MASK |
> +			MAX98926_ADC_VMON_EN_MASK);
> +		break;

Why not just use DAPM widgets for these?  BST looks like a boost
amplifier so should probably be a PGA, IMON and VMON can probably be
represented usefully as supplies (or could be PGAs routed through when
recording the signal, presumably users could save a little power by not
enabling the monitoring if they don't care for some reason).

> +static int pdm_ch_zero;
> +static int pdm_ch_one;

No global variables, store any state you need in driver data.

> +			MAX98926_PDM_CHANNEL_1_MASK);
> +	}
> +	switch (source) {

Coding style: blank line between blocks.

> +	case 0:
> +		/* enable current */
> +		regmap_update_bits(max98926->regmap,
> +			reg, MAX98926_PDM_CURRENT_MASK,
> +			MAX98926_PDM_CURRENT_MASK);
> +		/* enable source*/
> +		if (channel =3D=3D 0)
> +			regmap_update_bits(max98926->regmap,
> +				reg, MAX98926_PDM_SOURCE_0_MASK,
> +				MAX98926_PDM_SOURCE_0_MASK);
> +		else
> +			regmap_update_bits(max98926->regmap,
> +				reg, MAX98926_PDM_SOURCE_1_MASK,
> +				MAX98926_PDM_SOURCE_1_MASK);
> +		break;
> +	case 1:
> +		/* enable voltage */
> +		regmap_update_bits(max98926->regmap,
> +			reg, MAX98926_PDM_VOLTAGE_MASK,
> +			MAX98926_PDM_VOLTAGE_MASK);
> +		/* enable source*/
> +		if (channel =3D=3D 0)
> +			regmap_update_bits(max98926->regmap,
> +				reg, MAX98926_PDM_SOURCE_0_MASK, 0);
> +		else
> +			regmap_update_bits(max98926->regmap,
> +				reg, MAX98926_PDM_SOURCE_1_MASK, 0);
> +		break;

This seems a bit magic numberish (what are 0 and 1 here?).

> +static const struct soc_enum max98926_global_enum[] =3D {
> +	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(pdm_text), pdm_text),
> +};

Not sure what this control is supposed to do?

> +	SOC_ENUM("Input Sel", max98926_input_sel),
> +	SOC_ENUM("DAI Input Sel", max98926_dai_input_sel),

These look like DAPM controls?

> +	SOC_ENUM_EXT("PDM CH0 Enable", max98926_global_enum[0],
> +		max98926_get_pdm_ch_zero, max98926_put_pdm_ch_zero),
> +	SOC_ENUM_EXT("PDM CH1 Enable", max98926_global_enum[0],
> +		max98926_get_pdm_ch_one, max98926_put_pdm_ch_one),

There's two different controls mapping to one element of an array?

> +static void max98926_set_sense_data(struct max98926_priv *max98926)
> +{
> +	if (max98926->intrleave_mode) {

interleave.

> +	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
> +	case SND_SOC_DAIFMT_CBS_CFS:
> +		max98926_set_sense_data(max98926);
> +		break;
> +	case SND_SOC_DAIFMT_CBM_CFM:
> +	case SND_SOC_DAIFMT_CBS_CFM:
> +	case SND_SOC_DAIFMT_CBM_CFS:
> +	default:
> +		dev_err(codec->dev, "DAI clock mode unsupported");
> +		return -EINVAL;

No need to list all the formats you don't support.

> +	}
> +
> +	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
> +	case SND_SOC_DAIFMT_I2S:
> +	case SND_SOC_DAIFMT_LEFT_J:
> +		break;

I'm not seeing anything that handles these diffeerently, they are
different formats so you should only list whichever one is actually
supported.

> +	default:
> +		dev_dbg(codec->dev, "format unsupported %d",
> +				params_format(params));
> +		return -EINVAL;
> +	}
> +	return max98926_set_clock(max98926, params);

May as well just inline set_clock() here - this appears to be the only
place it's used.

> +static int max98926_dai_set_sysclk(struct snd_soc_dai *dai,
> +				   int clk_id, unsigned int freq, int dir)
> +{
> +	struct snd_soc_codec *codec =3D dai->codec;
> +	struct max98926_priv *max98926 =3D snd_soc_codec_get_drvdata(codec);
> +
> +	max98926->sysclk =3D freq;
> +	return 0;
> +}

You had error checking on sysclk in hw_params(), it'd bet better to do
that here too so people can tell they set a bad clock before they start
a stream.

> +	ret =3D regmap_read(max98926->regmap,
> +			MAX98926_VERSION, &reg);
> +	if ((ret < 0) ||
> +		((reg !=3D MAX98926_CHIP_VERSION) &&
> +		(reg !=3D MAX98926_CHIP_VERSION1))) {
> +		dev_err(codec->dev, "Failed to read: %x\n", reg);
> +		return -EINVAL;
> +	}

You should do this check in the I2C level probe.  The error message is
also wrong if the register does read but isn't what we expected.=20

Are you *sure* no new revisions of the device will be made?

> +	/* It's not the default but we need to set DAI_DLY */
> +	regmap_write(max98926->regmap,
> +			MAX98926_FORMAT, MAX98926_DAI_DLY_MASK);

Sounds like this might be the I2S vs left justified configuration?

--EIrXVFSPgsocVIgL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVbhJNAAoJECTWi3JdVIfQwNoH/RIaKW4QMrBZS5Ey5uIdAFWj
l0nZsWZWRhhi/Y85trFT+/Rj2kBA+mV9ROLFDxaiUaP6vMo2tNjVJxr/OZz2uYEt
gWq4pVHGnbnnGvYugiZpPZXzy9xVDUhB7BCCi+uFdnQmlAHKk+kvp6hpKBA8G0SH
ukrBuE34F82dpVqklgiKu+Na/V2JzZvl95qIFVnnSC2XqFZdbBPfV7hE5IPVjvfY
7OCNt2xUxsERV+zNgoFPO2PRRyK+yMl3C/UGPRfdcOXXaiTeq0Vh3CnIg0BYXe7E
JAYYdQ6upedAZv4hxJkG4XSzaNqgpzYfNC7uSUuXzZzLaMMbjSkYnr8sLbUwcsU=
=Kq1Y
-----END PGP SIGNATURE-----

--EIrXVFSPgsocVIgL--

--===============7152420082299264428==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7152420082299264428==--
