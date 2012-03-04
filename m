From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 20/20] ASoC: fsl: add imx-sgtl5000 machine
	driver
Date: Sun, 4 Mar 2012 13:38:18 +0000
Message-ID: <20120304133818.GE3083@opensource.wolfsonmicro.com>
References: <1330788001-10158-1-git-send-email-shawn.guo@linaro.org>
	<1330788001-10158-21-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1097450015369295131=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A43A7245A1
	for <alsa-devel@alsa-project.org>; Sun,  4 Mar 2012 14:38:21 +0100 (CET)
In-Reply-To: <1330788001-10158-21-git-send-email-shawn.guo@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: alsa-devel@alsa-project.org, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org


--===============1097450015369295131==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sfyO1m2EN8ZOtJL6"
Content-Disposition: inline


--sfyO1m2EN8ZOtJL6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 03, 2012 at 11:20:01PM +0800, Shawn Guo wrote:

> +	ret =3D snd_soc_dai_set_fmt(rtd->codec_dai, SND_SOC_DAIFMT_I2S |
> +						  SND_SOC_DAIFMT_NB_NF |
> +						  SND_SOC_DAIFMT_CBM_CFM);

Initialise this from the card. =20

Since none of the startup is dynamic it should all be done on DAI init
rather than rerun each time audio is started.

> +	/* Add soc-audio device */
> +	data->soc_audio_pdev =3D platform_device_alloc("soc-audio", -1);
> +	if (!data->soc_audio_pdev) {
> +		ret =3D -ENOMEM;
> +		goto err;
> +	}

No, use snd_soc_register_card().  soc-audio has been deprecated since
2.6.38.

> +static int __devexit imx_sgtl5000_remove(struct platform_device *pdev)
> +{
> +	struct imx_sgtl5000_data *data =3D dev_get_drvdata(&pdev->dev);
> +
> +	platform_device_unregister(data->pcm_audio_pdev);

This looks like there's a problem with the bindings, why are you
registering the DMA device from the card?

--sfyO1m2EN8ZOtJL6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPU3BDAAoJEBus8iNuMP3dm4MP/R/CpRCrJYJrxDYLJJQ2NrPf
RmPy/P/Pf/9w+ZgA6LuMT8TMRBGivBEweeqBshr6fRHFENiwQJQCe+R1vhWxbdyF
5JeLHPwjbahvSjLmLLs9wso9a4C9tp8mTB86Yb0Zo7iPXOkf1KyKKbRaIBfjIbDU
HlALVxc8Hv2q62uwN27xMmN20RKPas4jfJE7HVmpxQCIc63aF4Ubz+Ebs4cH7q4s
G57XezwBfgWVDBTXTuhHwXHmMMxG/2gk2seGruTMrgfbJR26OhR6dJ1n+XItthR0
hPLgSHcUbOl3gTY+ETMJQtuFUX0plDlOy/Jfmz2SY8SOx/GO+dBpcl7XmVYBePzF
eEzE+SSWU9Aa2Kwi/TODFhZNAtsF/QCht3SS6tqDh4QoafhbJOFfyW9IWryk3DWP
LNdfLwRsVLS/uWaQLZjzGhOH9tD80MZspnEUNKEA3bTX09ALWVFac57ZJ1FjU4U/
QW5qsDSboapsdI7YWXBzjvh5iG3lpqfKCR5LKvHoxjUAJrpBaVBWS3DpFBdUJM8k
4fzxZ8MxuGrXuUNATsJoG8tkhLgXDWui415ww9k/jYltxYB0Qm1uavYu2DrNvTdT
kkJScLOhk41yvGPH95b9yDgYc7sVhvEDkf6McoxfUCX2dh2EEPsM0p6rBmM3Xak5
6rAcYrjK3SylexFc3Ul8
=no6A
-----END PGP SIGNATURE-----

--sfyO1m2EN8ZOtJL6--

--===============1097450015369295131==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1097450015369295131==--
