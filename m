From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Add max98925 codec driver
Date: Tue, 24 Feb 2015 18:03:48 +0900
Message-ID: <20150224090348.GD6236@finisterre.sirena.org.uk>
References: <1424318986-18895-1-git-send-email-yesanishhere@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2255707106398329798=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C6E66260462
 for <alsa-devel@alsa-project.org>; Tue, 24 Feb 2015 14:25:16 +0100 (CET)
In-Reply-To: <1424318986-18895-1-git-send-email-yesanishhere@gmail.com>
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
Cc: liam.r.girdwood@linux.intel.com, Maxwell.McKinnon@maximintegrated.com, alsa-devel@alsa-project.org, lars@metafoo.de, nitin.mittal@maximintegrated.com
List-Id: alsa-devel@alsa-project.org


--===============2255707106398329798==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xugVLPVe/nLWwmIL"
Content-Disposition: inline


--xugVLPVe/nLWwmIL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 18, 2015 at 08:09:46PM -0800, Anish Kumar wrote:

> +config SND_SOC_MAX98925
> +       tristate "Support MAX98925 audio codec"
> +       depends on I2C
> +       help
> +       MAX98925 is a high-efficiency mono
> +       Class DG audio amplifier. Use this
> +       option to enable the codec.
> +

As I said in reply to an earlier version of this patch please format
this using the normal style for Kconfig entries.

> +static const char *const dai_text[] =3D {
> +	"left", "right", "leftright", "leftrightdiv2",
> +};
> +
> +static const char *const hpf_text[] =3D {
> +	"disable", "dc_block", "100Hz",	"200Hz", "400Hz", "800Hz",
> +};

As I also said in reply to an earlier version please follow the normal
style for enumeration entries with capitalization, use of spaces and so
on.

> +static struct reg_default max98925_reg[] =3D {
> +	{ 0x00, 0x00 }, /* Battery Voltage Data */
> +	{ 0x01, 0x00 }, /* Boost Voltage Data */
> +	{ 0x02, 0x00 }, /* Live Status0 */
> +	{ 0x03, 0x00 }, /* Live Status1 */
> +	{ 0x04, 0x00 }, /* Live Status2 */

As I said in reply to a previous version of this patch these seem like
volatile registers so why do they have defaults defined? =20

I'm going to glance through the rest of this but not too closely given
that a number of issues from the original review appear to remain
unaddressed and (perhaps more importantly) I'm about to run out of
batter).

> +static int max98925_reg_put(struct snd_kcontrol *kcontrol,
> +		struct snd_ctl_elem_value *ucontrol, unsigned int reg,
> +		unsigned int mask, unsigned int shift)
> +{
> +	struct snd_soc_codec *codec =3D snd_kcontrol_chip(kcontrol);
> +	struct max98925_priv *max98925 =3D snd_soc_codec_get_drvdata(codec);
> +	unsigned int sel =3D ucontrol->value.integer.value[0];
> +
> +	regmap_update_bits(max98925->regmap, reg, mask, sel<<shift);
> +	dev_dbg(codec->dev, "%s: register 0x%02X, value 0x%02X\n",
> +				__func__, reg, sel);
> +	return 0;
> +}

This looks like a standard control, why is this open coded?  I'd also
expect some bounds checking on the write.

> +static int max98925_dac_event(struct snd_soc_dapm_widget *w,
> +		struct snd_kcontrol *kcontrol, int event)
> +{
> +	struct snd_soc_codec *codec =3D w->codec;
> +	struct max98925_priv *max98925 =3D snd_soc_codec_get_drvdata(codec);
> +
> +	regmap_update_bits(max98925->regmap,
> +		MAX98925_R036_BLOCK_ENABLE,
> +		M98925_BST_EN_MASK |
> +		M98925_ADC_IMON_EN_MASK | M98925_ADC_VMON_EN_MASK,
> +		M98925_BST_EN_MASK |
> +		M98925_ADC_IMON_EN_MASK | M98925_ADC_VMON_EN_MASK);
> +	regmap_write(max98925->regmap,
> +	MAX98925_R038_GLOBAL_ENABLE, M98925_EN_MASK);
> +	return 0;
> +}

It's a bit surprising not to see any of these enables getting turned off
when we power down - won't that waste power?  Looking at the names I'm
wondering if these might make more sense as supply widgets.

> +static int max98925_spk_gain_put(struct snd_kcontrol *kcontrol,
> +				struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_codec *codec =3D snd_kcontrol_chip(kcontrol);
> +	struct max98925_priv *max98925 =3D snd_soc_codec_get_drvdata(codec);
> +	unsigned int sel =3D ucontrol->value.integer.value[0];
> +
> +	if (sel < ((1 << M98925_SPK_GAIN_WIDTH) - 1)) {
> +		regmap_update_bits(max98925->regmap, MAX98925_R02D_GAIN,
> +			M98925_SPK_GAIN_MASK, sel << M98925_SPK_GAIN_SHIFT);
> +		max98925->spk_gain =3D sel;

Why is this not just a normal control?  I can't see any reference to
spk_gain elsewhere...  similar things apply to a lot of these controls.

--xugVLPVe/nLWwmIL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU7D50AAoJECTWi3JdVIfQRvsH/iDlwPFGCg4Sh2YZBouU5JTG
01RkOmBFwcK8SOeHZjNOd4r6aJgSz4k0oAB0Qyi+qDZLoZQLDzTxdVaBWS1kEjIs
/joyo153Tndmz1GzdMaAEngvDiKENNZ24u+TfouhKsU1GAl7lDyqPBHaoGtTi3Z9
KpBVmHFFQUfFwxKlM779N60ed+ar+PBKE9yHQj7jJv/uvfjO41WVzRgtVX6wm7UE
Ou0vVdqUScl69QkLa6hn6/ZeMIwCUbW9N5ZdCPT3LebXnC4inwGI6rFK1IwztOtz
wDseRQ1h6fBCy4wfli/bHIPeq+SUCnfS1j4aJ6YoCdv0HIXS/ZY3kwms5oUIw/A=
=HJuX
-----END PGP SIGNATURE-----

--xugVLPVe/nLWwmIL--

--===============2255707106398329798==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2255707106398329798==--
