From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/4] add a mc13783 codec driver
Date: Sun, 11 Mar 2012 11:38:48 +0000
Message-ID: <20120311113848.GA3233@opensource.wolfsonmicro.com>
References: <1331304916-4724-1-git-send-email-philippe.retornaz@epfl.ch>
	<1331304916-4724-2-git-send-email-philippe.retornaz@epfl.ch>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0332965966878058601=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C7E4424338
	for <alsa-devel@alsa-project.org>; Sun, 11 Mar 2012 12:38:52 +0100 (CET)
In-Reply-To: <1331304916-4724-2-git-send-email-philippe.retornaz@epfl.ch>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Philippe =?iso-8859-1?Q?R=E9tornaz?= <philippe.retornaz@epfl.ch>
Cc: juergen.lambrecht@gmail.com, s.hauer@pengutronix.de, festevam@gmail.com, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============0332965966878058601==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 09, 2012 at 03:55:13PM +0100, Philippe R=E9tornaz wrote:

> From: Sascha Hauer <s.hauer@pengutronix.de>
>=20
> sha 20111307:
> - rebased to 3.0-rc2
> - implement tdm slot settings
> - made it work with single ssi port
> - more register names instead of hardcoded numbers
>=20
> philippe 20120803:
> - Add headset detection
> - add mic2 bias
> - enable headset output by default

If including stuff like this please include it after the ---.  Things
like notes about the odd arrangements with the SSI ports which will have
ongoing meaning are much more useful in the changelog.

Overall this looks fairly clean but very out of date, for example
there's a custom register cache impelementation and no DAPM.

> diff --git a/drivers/mfd/mc13xxx-core.c b/drivers/mfd/mc13xxx-core.c
> index 7122386..7b7b55e 100644
> --- a/drivers/mfd/mc13xxx-core.c
> +++ b/drivers/mfd/mc13xxx-core.c
> @@ -807,7 +807,8 @@ err_revision:
>  		mc13xxx_add_subdevice(mc13xxx, "%s-adc");
> =20
>  	if (mc13xxx->flags & MC13XXX_USE_CODEC)
> -		mc13xxx_add_subdevice(mc13xxx, "%s-codec");
> +		mc13xxx_add_subdevice_pdata(mc13xxx, "%s-codec",
> +					pdata->codec, sizeof(*pdata->codec));
> =20
>  	if (mc13xxx->flags & MC13XXX_USE_RTC)
>  		mc13xxx_add_subdevice(mc13xxx, "%s-rtc");

It's probably worth pushing the MFD updates separately to Samuel,
ideally they could go in during the next merge window even if the CODEC
driver doesn't make it.

>  	select SND_SOC_MAX98095 if I2C
>  	select SND_SOC_MAX9850 if I2C
>  	select SND_SOC_MAX9877 if I2C
> +	select SND_SOC_MC13783 if SPI
>  	select SND_SOC_PCM3008

This should depend on the MFD core, not the bus - it won't build without
the MFD core.

> +struct mc13783_priv {
> +	struct snd_soc_codec codec;
> +	struct mc13xxx *mc13xxx;
> +
> +	u32 reg_cache[42];

No custom register caches please (use the framework), and magic numbers
are generally bad.  Ideally the MFD would be converted over to regmap
which would give even more of a win.

> +	/* DAI clock master masks */
> +	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
> +	case SND_SOC_DAIFMT_CBM_CFM:
> +		val |=3D AUDIO_C_CLK_EN;
> +		break;
> +	case SND_SOC_DAIFMT_CBS_CFS:
> +		val |=3D AUDIO_CSM;
> +		break;
> +	case SND_SOC_DAIFMT_CBM_CFS:
> +	case SND_SOC_DAIFMT_CBS_CFM:
> +		return -EINVAL;
> +	}
> +
> +	val |=3D AUDIO_C_RESET;
> +
> +	mc13783_write(codec, reg, val);

This would be better using snd_soc_update_bits(), that way repeated
calls won't actually write to the hardware.  A similar issue applies
throughout, in some cases it looks like this will also fix locking
issues with doing read/modify/writes on partial register bits.

> +static int mc13783_set_fmt_sync(struct snd_soc_dai *dai, unsigned int fm=
t)
> +{
> +	int ret;
> +
> +	ret =3D mc13783_set_fmt(dai, fmt, MC13783_AUDIO_DAC);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * In synchronous mode force the voice codec into slave mode
> +	 * so that the clock / framesync from the stereo DAC is used
> +	 */
> +	fmt &=3D ~SND_SOC_DAIFMT_MASTER_MASK;
> +	fmt |=3D SND_SOC_DAIFMT_CBS_CFS;
> +	ret =3D mc13783_set_fmt(dai, fmt, MC13783_AUDIO_CODEC);

This looks like you want to be complaining about some invalid setups?

> +static void mc13783_startup(struct snd_soc_dai *dai, int reg)
> +{
> +	struct snd_soc_codec *codec =3D dai->codec;
> +	unsigned int val;
> +
> +	val =3D mc13783_read(codec, reg);
> +	val &=3D ~AUDIO_C_RESET;
> +	val |=3D AUDIO_C_EN;
> +	mc13783_write(codec, reg, val);
> +}

This looks like it should be either DAPM or set_bias_level...

> +static void mc13783_shutdown(struct snd_soc_dai *dai, int reg)
> +{
> +	struct snd_soc_codec *codec =3D dai->codec;
> +	unsigned int val;
> +
> +	val =3D mc13783_read(codec, reg);
> +	mc13783_write(codec, reg, val & ~AUDIO_C_EN);
> +}

=2E..and I suspect there's issues with simultaneous playback and record.

> +static int mc13783_capure_cache;

Don't use global statics, use the private data.

> +static const char *mc13783_asp[] =3D {"Off", "Codec", "Right"};
> +static const char *mc13783_alsp[] =3D {"Off", "Codec", "Right"};
> +
> +static const char *mc13783_ahs[] =3D {"Codec", "Mixer"};
> +
> +static const char *mc13783_ahsout[] =3D {"Off", "Auto", "On"};
> +
> +static const char *mc13783_arxout[] =3D {"Codec", "Mixer"};

A lot of this looks like it should be in DAPM - it looks like routing
control.

> +static const char *mc13783_capture[] =3D {"off/off", "rxinl/rxinr",
> +	"mc1lin/mc1rin", "off/mc1rin", "off/mc2in", "mc1lin/mc2in",
> +	"off/txin", "mc1lin/txin", "mc1lin/rxinr", "mc1lin/off"};

This does too, looking at the code that implements the enum it appears
that the chip is more flexible than the what's being offered here, it
looks like there's a bunch of separate controls.

> +	SOC_SINGLE("MC1 Bias enable", 38, 0, 1, 0),
> +	SOC_SINGLE("MC2 Bias enable", 38, 1, 1, 0),

This should definitely be DAPM, users shouldn't have to manually control
the bias from userspace.

> +	priv =3D kzalloc(sizeof(struct mc13783_priv), GFP_KERNEL);
> +	if (priv =3D=3D NULL)
> +		return -ENOMEM;

devm_kzalloc() (which will fix a memory leak on remove).

> +static __init int mc13783_init(void)
> +{
> +	return platform_driver_register(&mc13783_codec_driver);
> +}

module_platform_driver().

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIbBAEBAgAGBQJPXI6ZAAoJEBus8iNuMP3dlo4P9AxPJNb9ILTxszAOp2dBVbwh
5xh7zdmqmCmmKWapaXTkRLXHrHmcyT+Uo0JZi7an2hd324xgu5SQhKanr7vVcsI7
U0gnbqMW2h5VOsxzrkiLnZ1/0/rA19yPAJ4ZHQHORnMYzxWSDWhDxk0fQ4l5/VST
Ybs62WcfL5o16NYcD2YIK8dIGzGGk3AAZX/Pog7vPKfQd7Yr90bcycX17ijXsyjo
m1Wu/5HYRiD/jpzsAuhFgPBW6y8Z+Eah6lAtinpC24eKLbbXzht6MhJ2YI1MDsAu
j+R5pZCiSNZ0FF7+BmpIHarDBHYVlvXqHCIugY4BVCls49QRxJbjJYo+0fLPBbf7
r2it7z7UcBDpapIVPon7suB/mB9e/8Qt7g5g7uZpClZj5jDxXhi58ZD2hbS+brXQ
qxsvSOy5yNpK/ztwQOFYEKZA5/6cwUcsw1JPPN7831zgqtpMSwRc92LKd3J8/Q9N
KXqCsHNfczyTfF7Up7uuWRWvfo99dDEP3UbAXyKfN1U9y5jXs2ZIf4VsotDCgA6G
imuzV1+U9LcJcKfX0T4TsCJOh7sk9je2WaFmXDbE4yOT8U05ZKl1/Qo96hGRIYx/
virMA3PZxcB6i+HFVQB0bfAc0XMH/BuTdMC1kz1hywyHR7rQt/9Uimv1gBPjKFdP
nONrTcx/G+ILXGJUcYU=
=ZLXL
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--

--===============0332965966878058601==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0332965966878058601==--
