From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 1/15] sound/soc/mxs/mxs-saif.c: add missing
 iounmap
Date: Thu, 26 Jan 2012 12:05:06 +0100
Message-ID: <20120126110506.GB2611@pengutronix.de>
References: <1326362117-29371-1-git-send-email-Julia.Lawall@lip6.fr>
	<7FE21149F4667147B645348EC605788508FBDB@039-SN2MPN1-013.039d.mgd.msft.net>
	<alpine.DEB.2.02.1201241828480.1779@localhost6.localdomain6>
	<20120124202203.GD1135@opensource.wolfsonmicro.com>
	<alpine.DEB.2.02.1201242144580.1998@hadrien>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7406536346827743354=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id D979B103B79
	for <alsa-devel@alsa-project.org>; Thu, 26 Jan 2012 12:05:10 +0100 (CET)
In-Reply-To: <alpine.DEB.2.02.1201242144580.1998@hadrien>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dong Aisheng-B29396 <B29396@freescale.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============7406536346827743354==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i0/AhcQY5QxfSsSZ"
Content-Disposition: inline


--i0/AhcQY5QxfSsSZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> @@ -666,18 +666,19 @@ static int mxs_saif_probe(struct platform_device *p=
dev)
>   		goto failed_get_resource;
>   	}
>=20
> -	if (!request_mem_region(iores->start, resource_size(iores),
> -				"mxs-saif")) {
> +	if (!devm_request_mem_region(&pdev->dev, iores->start,
> +				     resource_size(iores), "mxs-saif")) {
>   		dev_err(&pdev->dev, "request_mem_region failed\n");
>   		ret =3D -EBUSY;
>   		goto failed_get_resource;
>   	}
>=20
> -	saif->base =3D ioremap(iores->start, resource_size(iores));
> +	saif->base =3D devm_ioremap(&pdev->dev, iores->start,
> +				  resource_size(iores));

devm_request_and_ioremap() to save even more code?

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--i0/AhcQY5QxfSsSZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk8hM2IACgkQD27XaX1/VRvl4wCeIArqrtl8+wIySL0w/s4TqXzx
lqEAnAhHR20GfGR2Q7lfl1+fj7lcw7Z2
=Skak
-----END PGP SIGNATURE-----

--i0/AhcQY5QxfSsSZ--

--===============7406536346827743354==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7406536346827743354==--
