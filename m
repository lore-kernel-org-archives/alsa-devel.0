From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 4/5] ASoC: sirf-soc-inner: add drivers
 for both CPU and Codec DAIs
Date: Mon, 6 Jan 2014 17:29:28 +0000
Message-ID: <20140106172928.GN31886@sirena.org.uk>
References: <1388729104-28643-1-git-send-email-rongjun.ying@csr.com>
 <1388729104-28643-5-git-send-email-rongjun.ying@csr.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8741436353945716359=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 88F672610CA
 for <alsa-devel@alsa-project.org>; Mon,  6 Jan 2014 18:29:38 +0100 (CET)
In-Reply-To: <1388729104-28643-5-git-send-email-rongjun.ying@csr.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: RongJun Ying <rjying@gmail.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Workgroup.linux@csr.com, Rongjun Ying <Rongjun.Ying@csr.com>
List-Id: alsa-devel@alsa-project.org


--===============8741436353945716359==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FhLCAOpkK55HfMa0"
Content-Disposition: inline


--FhLCAOpkK55HfMa0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 03, 2014 at 02:05:03PM +0800, RongJun Ying wrote:

> @@ -6,5 +6,8 @@ config SND_SIRF_SOC
>  config SND_SOC_SIRF_I2S
>  	tristate
> =20
> +config SND_SIRF_SOC_INNER
> +	tristate
> +
>  config SND_SOC_SIRF_USP

Everything else is SND_SOC_SIRF_, please keep this consistent.

> +static struct sirf_soc_inner_audio_reg_bits sirf_soc_inner_audio_reg_bit=
s_prima2 =3D {
> +	20, 21, 22, 23, 24, 25, 26, 27,
> +};

> +static struct sirf_soc_inner_audio_reg_bits sirf_soc_inner_audio_reg_bit=
s_atlas6 =3D {
> +	22, 23, 24, 25, 26, 27, 28, 29,
> +};

Please used named initialisers to set these values rather than just a
list of numbers, this isn't very easy to read.

> +static const struct snd_kcontrol_new sirf_inner_input_mode_control =3D
> +	SOC_DAPM_ENUM("Route", sirf_inner_enum[0]);

Either use constants to reference the array or (better) use named
variables for each enum.  This is more readable and less error prone.

> +static struct snd_kcontrol_new volume_controls_atlas6[] =3D {
> +	SOC_DOUBLE("Playback Volume", AUDIO_IC_CODEC_CTRL0, 21, 14,
> +			0x7F, 0),
> +	SOC_DOUBLE("Capture Volume", AUDIO_IC_CODEC_CTRL1, 16, 10,
> +			0x3F, 0),

Please provide TLV information.

> +static struct snd_kcontrol_new left_input_path_controls[] =3D {
> +	SOC_DAPM_SINGLE("Line left Switch", AUDIO_IC_CODEC_CTRL1, 6, 1, 0),

Line Left Switch.

> +	switch (event) {
> +	case SND_SOC_DAPM_PRE_PMU:
> +		/* Enable capture power of codec*/
> +		val =3D sirfsoc_rtc_iobrg_readl(sinner_audio->sys_pwrc_reg_base +
> +			PWRC_PDN_CTRL_OFFSET);
> +		val |=3D (1 << AUDIO_POWER_EN_BIT);
> +		sirfsoc_rtc_iobrg_writel(val,
> +			sinner_audio->sys_pwrc_reg_base + PWRC_PDN_CTRL_OFFSET);
> +		break;
> +	case SND_SOC_DAPM_POST_PMU:
> +		/*After enable adc, Delay 200ms to avoid pop noise*/
> +		msleep(200);

No need to split these operations, just have one callback.  Why is there
no power down callback?

> +static int hp_amp_left_event(struct snd_soc_dapm_widget *w,
> +		struct snd_kcontrol *kcontrol, int event)
> +{
> +	struct snd_soc_codec *codec =3D w->codec;
> +	struct sirf_soc_inner_audio *sinner_audio =3D dev_get_drvdata(codec->de=
v);
> +	u32 val;
> +
> +	val =3D snd_soc_read(codec, AUDIO_IC_CODEC_CTRL1);
> +	switch (event) {
> +	case SND_SOC_DAPM_PRE_PMU:
> +		val |=3D (1 << sinner_audio->reg_bits->firdac_hsl_en_bits);
> +		break;
> +	case SND_SOC_DAPM_POST_PMD:
> +		val &=3D ~(1 << sinner_audio->reg_bits->firdac_hsl_en_bits);
> +	default:
> +		break;
> +	}
> +	snd_soc_write(codec, AUDIO_IC_CODEC_CTRL1, val);
> +	return 0;

snd_soc_update_bits().  Can this not be represented as multiple widgets
- remember that DAPM will coalesce writes as much as it can.

> +	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
> +		spin_lock(&sinner_audio->lock);
> +		if (playback) {

The lock only gets used in the trigger function, is it needed?

> +static struct snd_soc_codec_driver soc_codec_device_sirf_inner_codec =3D=
 {
> +	.probe =3D sirf_inner_codec_probe,
> +	.remove =3D sirf_inner_codec_remove,
> +	.read =3D sirf_inner_codec_reg_read,
> +	.write =3D sirf_inner_codec_reg_write,

Don't use custom read and write callbacks, use a MMIO regmap.

--FhLCAOpkK55HfMa0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSyuf1AAoJELSic+t+oim9LvgP/jKjtcXoiB5rpDw6tSD3EXE9
DOd46ehyIX4HPiiI4zfmbRUo0hgS1RN4BlKizpwX+ZKJQJnqT+EtRxku+NDPLmas
qyYLUGr8PYHieQVImkWd82KTM3h6UYPRZDNCSYpELqXnGqcA8IZyiAOKzxmnG0pm
oib+MtHPd7t57cw3uprsS1L9U7v5hkEGgv5omlr3BJyUh7J0jKg4JV7NZEjJPI3S
nSRhZcBny0D1KgSmhXu+BY3MZzKV65OYBWPenEwsCSl5Xz1CumOltosL6GwN7Jre
RXO12MPfRvVjS82211vbFakkLFY/6QKaxVvlc/zbPwZt/KxqGLu25h2Ih/57VT7x
GDUBBKCuMQMcgu6yRZEEgFmLkumo6kdFQWZEZYAIy9kIGQYSZgZRIWUvHwOdFp2V
Uec+p690dKGdC63otvhKz8YiBU1kYPDHTCcUsAheF/gEdtGItJmul9o4SWCX95JE
qtgs7H5mZI+4roLWSVxUbMjcm4wvNgAXvoQMLouD2cEGG5uFi7dwAZfBEhwA03br
i6ts3pF5fZB/v0WbSje+zXht6e4aEsrCNQRfL+ku2ExPR98SMotiyK4uRB5dhMoD
l2nqIG8MxW/0qhNeuWAwSECigmnNRV+Uwa0jCkdZ0E5iNGaS1LB5PPJnT4tGfYKM
kp/EPEHf8cHp/oJjQyhP
=G1vt
-----END PGP SIGNATURE-----

--FhLCAOpkK55HfMa0--

--===============8741436353945716359==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8741436353945716359==--
