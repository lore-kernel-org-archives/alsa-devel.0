From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl_ssi: Use devm_ioremap_resource()
Date: Fri, 10 Apr 2015 15:38:45 +0100
Message-ID: <20150410143845.GI6023@sirena.org.uk>
References: <1428660749-9637-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5208867401108858632=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A835426065A
 for <alsa-devel@alsa-project.org>; Fri, 10 Apr 2015 16:38:54 +0200 (CEST)
In-Reply-To: <1428660749-9637-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: nicoleotsuka@gmail.com, Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, timur@tabi.org
List-Id: alsa-devel@alsa-project.org


--===============5208867401108858632==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JOxPqSG7pNtL7OAi"
Content-Disposition: inline


--JOxPqSG7pNtL7OAi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2015 at 07:12:29AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>=20
> Using platform_get_resource() and devm_ioremap_resource() can make the
> code a bit simpler.=20

Applied, thanks.

--JOxPqSG7pNtL7OAi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVJ+B1AAoJECTWi3JdVIfQ7IQH/1wZ0WrPXKcHdh5aO+k8Ku6o
R5nV/M9o4266nSUDf243xc/8B8gtLF+6tPtpVr5IIm6TlLEnMghAkBV47ZjdF1Mv
sKnmapk2Ck8CGjeSH80dZxfMyhXwNd0h5mDDGXRnXwZW4TwAFkMdjsHL8nkDVO++
sJJv50kPuo7UyFMwgH3WFK6roq6BUh/DAiGplou2U/EbMXgoQ6x27zGuQ3t6Xk0f
oRrWgnMficcFtrl8drM2bgdbT3q8uIHLSCepnS6/1qP+D2idfpEMj+WCcgi4q0wC
Ybk7MeCspxahJqghRAPPtUMp7Q9QndsVfXjWQ8Z75RECVsZkvkloYPd5aw6m7FM=
=dZFb
-----END PGP SIGNATURE-----

--JOxPqSG7pNtL7OAi--

--===============5208867401108858632==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5208867401108858632==--
