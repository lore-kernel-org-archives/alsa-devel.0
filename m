From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: mxs-sgtl5000: Remove MCLK
	restriction
Date: Thu, 27 Nov 2014 17:42:54 +0000
Message-ID: <20141127174254.GA7712@sirena.org.uk>
References: <1417100521-8483-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6941128065652864086=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 72FFD261533
 for <alsa-devel@alsa-project.org>; Thu, 27 Nov 2014 18:43:09 +0100 (CET)
In-Reply-To: <1417100521-8483-1-git-send-email-festevam@gmail.com>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, shawn.guo@linaro.org, craig.mcqueen@beamcommunications.com
List-Id: alsa-devel@alsa-project.org


--===============6941128065652864086==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yyNREU0woCyfxUz6"
Content-Disposition: inline


--yyNREU0woCyfxUz6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 27, 2014 at 01:01:59PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>=20
> According to the sgtl5000 datasheet the MCLK frequency range restriction =
of
> 8 to 27 MHz only applies when the PLL is used - synchronous SYS_MCLK inpu=
t mode.

Applied all, thanks.

--yyNREU0woCyfxUz6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUd2KdAAoJECTWi3JdVIfQOL8H/iOE4lwLB3HPAXVmObzmQF3S
HyWXrBukFXrkOQ+rOd5NgLlw8vaAp54x9yf4XzOUO2gWZO82CiQFmaGpIWESWleA
6SyDEYwwcCtRNhEje8yJKnWsd36DI2nBBO0X4DlY1eqgD8NgY9yQs6WvBLL83yfp
6WCJMR8wCk/ZmG5KNR+JvTgH/xZQmL1TWqTr9BzYVXwlIvYCLu7SfYX9FnN02klM
apmdX9foiWDwpcwiqrcrccQP3Jrbf9TWRUCKJr9WiA2sYCR9V427PrO1c2c4n+R3
XFYw3YxaotFdUfLsDFGYKUFfIyKugjXs+Ej/K4ks4I/Gf+35yEEEikxFZgnMgbA=
=n47t
-----END PGP SIGNATURE-----

--yyNREU0woCyfxUz6--

--===============6941128065652864086==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6941128065652864086==--
