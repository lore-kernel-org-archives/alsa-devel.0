From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: twl6040: Support for DT
Date: Tue, 8 May 2012 13:26:31 +0100
Message-ID: <20120508122630.GM15893@opensource.wolfsonmicro.com>
References: <1336477945-27460-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1964264984964436195=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DBF60243C8
	for <alsa-devel@alsa-project.org>;
	Tue,  8 May 2012 14:26:33 +0200 (CEST)
In-Reply-To: <1336477945-27460-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============1964264984964436195==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2VXyA7JGja7B50zs"
Content-Disposition: inline


--2VXyA7JGja7B50zs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 08, 2012 at 02:52:25PM +0300, Peter Ujfalusi wrote:

> +static const struct of_device_id twl6040_codec_of_match[] = {
> +	{.compatible = "ti,twl6040-codec", },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, twl6040_codec_of_match);

Why are we loading MFD components using device tree?  It seems like
we're doing something very wrong if we need people to explicitly write
this stuff out in the device tree, the whole MFD thing is purely a Linux
implementation detail, as is the way the interrupt controller has been
structured.  I'd really not expect to see a specific node like this,
especially not one that does nothing but device registration.

--2VXyA7JGja7B50zs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPqRDhAAoJEBus8iNuMP3dvx8QAIQhJhq0HWeC6Vsime0+qYoP
NDS7kCOhBdEuC46s45Wh+W5/31jluvuHE3hmO3QEU3jx8iKW4dss63K8bMMXEFNL
pgYsn5/qy76WbTRU4wNhdbZuKvM+KFIjIOD76i2Vjmw/jJT2Zn4/eApyy1F4pBoO
MeicT8S5HnmpMPHq1ohUEsvRTd1fSXez6DJL8MOFscVEMJBMy1h5h7NM3aPxbLCD
7BuT+ILE6griY5wx6lTf9Qy3WRPnzcRJeNtW775GCpRKFlWKgg1NgtYdZnLm3klg
uUsFxpCnrN0mJXKT9dsQ266WRmXnYsyS4VBYqT0YnlHNMC92dlHIO9JlKc/nMm1u
HnJFieFdisuq2jl1vR2+09DCqKKlNU1c3BYb+hZeYu/Qk5Md6h+AmuM+1cjQPdnq
goELh2czgJDgRqd2Yi3vCPeaeEUrqvbvRdiEu/wSHAvy2i2t/qHYuJyP1niRsFMM
GJHjSDB9lxS2sO7CxYWnzeivJJhNMQg+40cvKZJAJPm3N5yEc3Vl877r3HeADv+T
nZse5P2m5/wJUgbnSlVFF6jEWoEu/XD2vpzjFa6bqT2UwJRR3dMHOmDuetYAXoSF
z3D3z2qNBZzrTspdcFYKqnDz+hCs+wAyaMSmyL+h2TcZLGinNdBHWCjxabJyCNNO
lSGWB0DqlLPpqqB/3k3F
=Ve5Q
-----END PGP SIGNATURE-----

--2VXyA7JGja7B50zs--

--===============1964264984964436195==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1964264984964436195==--
