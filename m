From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/4] ASoC: when initializing CPU DAI,
 don't duplicate any CODEC init
Date: Wed, 13 Jun 2012 13:18:22 +0100
Message-ID: <20120613121821.GO4545@opensource.wolfsonmicro.com>
References: <1339180463-21178-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5006455971779354560=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1FC2B104517
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Jun 2012 14:18:23 +0200 (CEST)
In-Reply-To: <1339180463-21178-1-git-send-email-swarren@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============5006455971779354560==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Iys0Un1O+0sigPHU"
Content-Disposition: inline


--Iys0Un1O+0sigPHU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 08, 2012 at 12:34:20PM -0600, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
>=20
> If the CPU-side of a DAI link is a CODEC rather than a standalone DAI,
> the codec initialization will call try_module_get() and create the DAI
> widgets. Ensure that this isn't duplicated when the CPU DAI itself is
> probed, if the CPU DAI is part of a CODEC.

Applied all, thanks.

--Iys0Un1O+0sigPHU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP2IUHAAoJEBus8iNuMP3dGUgP/ib9ypfyO/69QCIreJAcCuyD
oBC6xejfQifKQFdD+jE+CGz2CC1uNS63v1wkgddbeTYe90LMaEkgQcyZ4ywwIvcf
8QW6Oc/XGYwjzMi6XCI9Vj3nKZRnIzW274BYJXbXX2adUWJ+TZ9K1xJ4QuKK/vZE
rPDRc7uCaE/UxZ+pUb9NK5fddMNaJA0ML3/cknFHKtHfR2sFqF/L9qYkRwXtxDP9
YeZeqt46w2vuexPnBydc4CNaonlgb7Ger7tWwuJ468hNd2euiCJNCLPfHTyGFNXc
+ZCOyN1ESTFFAxr5YD0y/fpVdUKrZQ30Ahm5RS4vZT2iKhslBocxecSICXJJDOC6
E9tETkDckxdz8ZcY7QhCYqC6tPFmM48DHfRcVa/r5fbK3ldxXEnyYkJrkL0vStPF
lDIQ8g5c4sY32uQ+rmGM9QigCa9n2jLSYFrlFMcpFjdqajF70ljlp89y0oQdgg4e
/dfaGvjdN2o8CbgrTd0vt5ZyS7cb+jpCrP3C9YOiO8nX987bLMHSDMa+Pt9kUyef
MbTrBdLPj9AbjfXvNqROUhmbJj+j+OnvQB/XZmxUJEmVk7DDeL0JYduvS4pn396o
RnyE2obegdE1Wk9Xrcia6C403KHaHBLqnaN3KQpyeRxCiTeneEbA3iTMsRPMzoSX
ldj/liA+SQsPmvsGAtmG
=y6Sm
-----END PGP SIGNATURE-----

--Iys0Un1O+0sigPHU--

--===============5006455971779354560==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5006455971779354560==--
