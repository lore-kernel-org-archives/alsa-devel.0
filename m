From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl: imx-audmux: Check the return
 value from clk_prepare_enable()
Date: Mon, 22 Jul 2013 00:58:51 +0100
Message-ID: <20130721235851.GH9858@sirena.org.uk>
References: <1374424748-4438-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1925420652252950177=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 48693261696
 for <alsa-devel@alsa-project.org>; Mon, 22 Jul 2013 01:58:54 +0200 (CEST)
In-Reply-To: <1374424748-4438-1-git-send-email-festevam@gmail.com>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============1925420652252950177==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mMdCh5/a0q2ATNCM"
Content-Disposition: inline


--mMdCh5/a0q2ATNCM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 21, 2013 at 01:39:08PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>=20
> clk_prepare_enable() may fail, so let's check its return value and propag=
ate it
> in the case of error.

Applied, thanks.

--mMdCh5/a0q2ATNCM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR7HW4AAoJELSic+t+oim93zYP/j1YJupQTmXaUduvUrJPswnw
bYexfT4L7W7ejoU7zwVDyLRbtbkPUQ6No/eljcNOrO1CTPsVNjmiHySsqjvibiiC
SFqOxzfTOWQeESWnEmZW7it49QbLPV4veUw1m9FzFr54meZdTtILh0vl6OC23rAm
+nXS4uiuQZ5mqIty2+MaBf7+3PxI+f8W7ApWtZjjIA1RaIsfCD9ZJWcu43+I8Ve2
ksR4bBZfPGFcu/uGobtYW87g+GdYNI475w3RNSAxcyPxA2ruvgLx+YNeU7HWtbws
HbWPLhyKnnM7uBLX9wL3PlroPORQ/YEBPC8yGr0hnZHNvll7TO54zajrqlgQxcVk
HQx9ZaF8Lvwzls5ddtPIajvPu3lgiXIqymhELyqXxCdXMNcriPBb5uZy/8JYlGjM
9cM3hYYY3G11Ko8zvDzNxhUaSVdqkMb/ztqGAoVF/RpPlIM5TD169ATjGrGPGyTE
SvM6yggW31rZNocXAq1UDRVUh2ro6OHXyAoaxg5h40u20xK1P0Ga8iWWM5iGeLr1
faLPxp689x1XuuOlwH0FNMMkDX2DjyelPSgAUY9D2QLDH1Mq3sBc3KtLAjXUZ0NA
R08DRFh0WNTNdTxiZVa7xeU3gl9kq9HeSDDaFnA9BiYTBktfuT0/oncA1kk7VM8y
vLRL0rL6ippw/O1wWFNC
=Z0vJ
-----END PGP SIGNATURE-----

--mMdCh5/a0q2ATNCM--

--===============1925420652252950177==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1925420652252950177==--
