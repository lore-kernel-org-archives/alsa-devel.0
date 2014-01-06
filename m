From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 5/5] ASoC: mc13783: Add devicetree support
Date: Mon, 6 Jan 2014 13:28:41 +0000
Message-ID: <20140106132841.GV31886@sirena.org.uk>
References: <1388907515-18975-1-git-send-email-shc_work@mail.ru>
 <1388907515-18975-5-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8756701581528606485=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F0AE0261A8F
 for <alsa-devel@alsa-project.org>; Mon,  6 Jan 2014 14:28:45 +0100 (CET)
In-Reply-To: <1388907515-18975-5-git-send-email-shc_work@mail.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8756701581528606485==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Gwp7Ha71EYc9lgOD"
Content-Disposition: inline


--Gwp7Ha71EYc9lgOD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 05, 2014 at 11:38:35AM +0400, Alexander Shiyan wrote:
> This patch adds devicetree support for mc13783-codec.
> Since we have not compatible string for this codec, just override
> of_node for allow using phandle of node in the DT.

All DT patches should be sent to the DT maintainers for review.

>  Documentation/devicetree/bindings/mfd/mc13xxx.txt |  4 +++-
>  drivers/mfd/mc13xxx-core.c                        | 12 +++++++-----
>=20
Since this has MFD updates you also need to send it to the MFD
maintainers.

>  Optional properties:
>  - fsl,mc13xxx-uses-adc : Indicate the ADC is being used
> -- fsl,mc13xxx-uses-codec : Indicate the Audio Codec is being used

This is an incompatible binding change; deprecating is fine but it
should still be supported.  Is there not a default set of port
assignments that can be used?

> +	pdev->dev.of_node =3D of_find_node_by_name(pdev->dev.parent->of_node,
> +						 "codec");
> +

You shouldn't be messing with the of_node in the struct device, this is
managed by the driver model and setting one that wasn't added in sync
with everything else can introduce breakage.

> +	if (priv->adc_ssi_port !=3D MC13783_SSI1_PORT &&
> +	    priv->adc_ssi_port !=3D MC13783_SSI2_PORT)
> +		return -EINVAL;
> +	if (priv->dac_ssi_port !=3D MC13783_SSI1_PORT &&
> +	    priv->dac_ssi_port !=3D MC13783_SSI2_PORT)
> +		return -EINVAL;

What about DAC or ADC only systems?

--Gwp7Ha71EYc9lgOD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSyq+GAAoJELSic+t+oim992oP/0mXBv4Qv2fAUqVC6vK3i1jS
kuPvKsR6U+/N67f5VgYkETRaPAQ936IeiFlgT+ajjh/PibWpaSKLNu38dbhBOE9/
kuEm7JvXe1NpSYVTut1fqGRcjiHPrF6Z9RuKtRcH4dnpV6TftXm9TvSK9Bhv+ziy
mgEKUonnN+b0bsFi7DUsTSHZN0t/BRJQ8HtQOhjCDsPakKJycEsV+jucGt49SS6i
Dt4X3E26ZXSM31UNoc0iGebZGj26i0Rz5mbCa+YV9whlhggDYd2VbOsiAxAUGJFx
vU1XvbYa6ENHPI1mOypqBHWL/ENQ9fz+YmBlkkcDhbfFBtUI90KSIq14I4jWVZzQ
qyB0YIHbiofYHQRe9gj6DTAUWHUplSAILSOUIeCNFtOS9CQCUvsi/BkFH6rhTFuO
3LInxePuFAHnJIHYh8mWz0Hy4zwATxHFN3WgaDSOeCJaI9djonx/Bj6Vq+0qgyGz
cyakpk+Gb5GSX9NexmBFN4o1/Ig8Rnpoy6c1Lg9gM09lOCgf8AoPqd9aaoyIXkp/
ThKHY2rEyUj3ZI12ZgtCCN5fRzYF9hVfkXMqQDBpIv5CQX0dZnoAHZEuRez4E0mE
ss/F0hWt776dQKJ4wMZ5b0a9x8Lyj6lt1GAkCzPrDcIWL9H/SjLH0iC7sOlYar+O
hzRCWKtbfiQxgenKupHf
=atQ8
-----END PGP SIGNATURE-----

--Gwp7Ha71EYc9lgOD--

--===============8756701581528606485==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8756701581528606485==--
