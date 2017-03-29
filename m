From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3] ASoC: Add support for Maxim Integrated
 MAX98927 Amplifier
Date: Wed, 29 Mar 2017 15:23:04 +0100
Message-ID: <20170329142304.qovnyqd6izackny2@sirena.org.uk>
References: <1490748828-31701-1-git-send-email-ryans.lee@maximintegrated.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2985705725163388728=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 67FA4266F2E
 for <alsa-devel@alsa-project.org>; Wed, 29 Mar 2017 16:24:10 +0200 (CEST)
In-Reply-To: <1490748828-31701-1-git-send-email-ryans.lee@maximintegrated.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ryan Lee <ryans.lee@maximintegrated.com>
Cc: mark.rutland@arm.com, alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com, lgirdwood@gmail.com, tiwai@suse.com, srinivas.kandagatla@linaro.org, romain.perier@collabora.com, bardliao@realtek.com, lars@metafoo.de, axel.lin@ingics.com, Paul.Handrigan@cirrus.com, devicetree@vger.kernel.org, arnd@arndb.de, nh6z@nh6z.net, robh+dt@kernel.org, ckeepax@opensource.wolfsonmicro.com, dgreid@google.com, oder_chiou@realtek.com, ryan.lee.maxim@gmail.com, KCHSU0@nuvoton.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============2985705725163388728==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uluqcjpydlhtmbyh"
Content-Disposition: inline


--uluqcjpydlhtmbyh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 29, 2017 at 09:53:48AM +0900, Ryan Lee wrote:

> +	case SND_SOC_DAIFMT_CBS_CFM:
> +		mode = MAX98927_PCM_MASTER_MODE_HYBRID;
> +	default:
> +		dev_err(codec->dev, "DAI clock mode unsupported");

Either we don't support _CBS_CFM or there's a missing break there.

> +	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
> +	case SND_SOC_DAIFMT_I2S:
> +		max98927->iface |= SND_SOC_DAIFMT_I2S;
> +
> +	break;

Please use the kernel coding style as you do in the rest of this
function.

> +	int reg = MAX98927_R0022_PCM_CLK_SETUP;
> +	int mask = MAX98927_PCM_CLK_SETUP_BSEL_MASK;

> +	regmap_update_bits(max98927->regmap, reg, mask, value);

reg and mask have exactly one user (as you'd expect), just use the
constants directly here to make things clearer.

> +	switch (snd_pcm_format_width(params_format(params))) {
> +	case 16:
> +		chan_sz = MAX98927_PCM_MODE_CFG_CHANSZ_16;
> +		max98927->ch_size = 16;

You could just assign ch_size directly.

> +	/* sampling rate configuration */
> +	switch (params_rate(params)) {
> +	case 8000:
> +		sampling_rate |= MAX98927_PCM_SR_SET1_SR_8000;

sampling_rate is only ever set to a real value in this switch statement,
you're not oring with anything else so you can just use an assignment
which would be a lot clearer (it's not obvious what else might go in
there) and the initial assignment to 0 for this and chan_sz can only
mask errors.

> +	/* set sampling rate of IV */
> +	if (max98927->interleave_mode &&
> +		sampling_rate > MAX98927_PCM_SR_SET1_SR_16000)
> +		regmap_update_bits(max98927->regmap,

Please use the kernel coding style, indent the second line of the if
with the ( so that it doesn't look like part of the conditional code.

> +	switch (reg) {
> +	case MAX98927_R0001_INT_RAW1 ... MAX98927_R0028_ICC_RX_EN_B:


> +		return true;
> +	}
> +	return false;

It'd be clearer to put the return false in the switch statement like the
return true, and also consistent with the _volatile_reg() function.

> +static const char * const max98927_speaker_source_text[] = {
> +	"i2s", "reserved", "tone", "pdm"
> +};

This looks like it should be a DAPM control.

> +static const char * const max98927_monomix_output_text[] = {
> +	"ch_0", "ch_1", "ch_1_2_div"
> +};

Similarly here.

> +	SOC_SINGLE_TLV("Digital Gain", MAX98927_R0036_AMP_VOL_CTRL,
> +		0, (1<<MAX98927_AMP_VOL_WIDTH)-1, 0,
> +		max98927_digital_tlv),

All volume controls should end with Volume as per control-names.rst.

> +	SOC_SINGLE("Amp DSP Enable", MAX98927_R0052_BROWNOUT_EN,
> +		MAX98927_BROWNOUT_DSP_SHIFT, 1, 0),

All on/off switches should end with Switch as per control-names.rst.

> +static int max98927_probe(struct snd_soc_codec *codec)
> +{

> +       /* Check Revision ID */
> +       ret = regmap_read(max98927->regmap,
> +               MAX98927_R01FF_REV_ID, &reg);

Basic device identification and setup should be done at the chip level
probe not at the CODEC level so that if there are problems we fail as
early as possible and so that diagnostic information is available to
users as soon as possible, even if there's no sound card for the device
in the system.

> +	/* Set inital volume (+13dB) */

As with all other CODEC drivers you should leave the hardware defaults
alone, what makes sense for your system may not make sense for other
systems and the hardware defaults are a fixed thing.

> +	/* Boost Output Voltage & Current limit */
> +	regmap_write(max98927->regmap,
> +		MAX98927_R0040_BOOST_CTRL0,
> +		0x1C);
> +	regmap_write(max98927->regmap,
> +		MAX98927_R0042_BOOST_CTRL1,
> +		0x3E);

This should be system specific, these values might be unsafe in some
systems.

> +err:
> +	if (max98927)
> +		devm_kfree(&i2c->dev, max98927);

There is no need to explicitly free devm_ allocated memory, that's the
point of devm.

--uluqcjpydlhtmbyh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAljbw0cACgkQJNaLcl1U
h9BLKQf9F+OMjAAsyQrholcyWs+MPxLuPasoQUC/kwFDZEGnG4AsxQIqJDlxm/LQ
48eU2WaV4Xc/s7/ueUkCFBNlUINKuifT8myEFT9mwx+EHLIlO0BJxp8bYah1QNva
VYAGZmzcf8AJX+dBFVNX2H0BUeOlbad1VXIzmsjNd2ZAMYNRwVl/hAyM3Kll4OcJ
x95Dnc13wGloNSDYRJYY8cyYjRJ4RqpvysC1z2O45H8xGka+0jSa9NpbR3aq+S4U
ZzL9NGs+kbs7yzS/CXbS3nE+zzA2Hp5VqAGpf2q3BegSDa2Tsl2C6u60i3o7uEJl
x9XjDDjW1wMotNwBAKjZmp8bQEEL9A==
=0dWR
-----END PGP SIGNATURE-----

--uluqcjpydlhtmbyh--

--===============2985705725163388728==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2985705725163388728==--
