From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 3/3] ASoC: sglt5000: Fix
	SGTL5000_PLL_FRAC_DIV_MASK
Date: Fri, 5 Jul 2013 10:46:18 +0100
Message-ID: <20130705094618.GR27646@sirena.org.uk>
References: <1372978863-4872-1-git-send-email-festevam@gmail.com>
 <1372978863-4872-3-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8886909404553326394=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 3AC50265861
 for <alsa-devel@alsa-project.org>; Fri,  5 Jul 2013 11:46:23 +0200 (CEST)
In-Reply-To: <1372978863-4872-3-git-send-email-festevam@gmail.com>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, oskar@scara.com
List-Id: alsa-devel@alsa-project.org


--===============8886909404553326394==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CJhilzLIyAgaRUK6"
Content-Disposition: inline


--CJhilzLIyAgaRUK6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 04, 2013 at 08:01:03PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>=20
> SGTL5000_PLL_FRAC_DIV_MASK is used to mask bits 0-10 (11 bits in total) of
> register CHIP_PLL_CTRL, so fix the mask to accomodate all this bit range.

Applied, thanks.

--CJhilzLIyAgaRUK6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR1pXnAAoJELSic+t+oim9y0QP/3WUusGjoRDPYaYtZZ9zWA9V
CUYh7UU70PzMsqMHVrThZSnkIQceSEQx85ZbWqxoRbaCfw0wf/p7D7w4OU3++HNa
qwaaBa/Xh6nfBKQe4W0vONu5GoTEgUBXhiL//VnecHhUuG1X4eOyfsDsNVQUic2L
bNSGmPKC5qoqHEl8T2jSxDk/9Ri4+R/Pd5j7XOJ0u4Ca13t5e+lG6XsMZtYX1mGo
lwn5wAU4bM+tMKPMgUOovkD2KuMjBv1fh/FLWx5G92Pge1fBaxUelcdlqt34/aIC
NzpXvMlufCpwyu5lqRT1T3/9XLlwPmFGozfNgNLT+8csFBwv/xqs8p75FHjmxMsF
kKH0EDgUoWOKWz/cuv3LLBwwOPX6agiM6aX1dKvydY2xO36cwm0jpJdc317ck0jO
gU0wSkbunqdd5JMWhNMmVSwD5UFr/TgmK8rAdoFe4hr9I6ys4vGtosogKR3dMDFw
wzrJDm4+i5IQIjEZKfYiy4gjBleB5cUgfjGVRTpZGHzbyj1p6WUIYBlIvUCq/bqw
FQp6d0Cm+rebkGF+vY82fwc7aQdW6Wz7qZ7gOG3QyG6Agrf/Ib712nrGYJP/FOGm
nNrG1xdMBgES+i0FgJATpLB1gO4YCBDl+uPCZsoOQ0dICw7RI7264jXXRYeZy2n1
OrM01WEMraEBQ1pmi1VZ
=6ZYu
-----END PGP SIGNATURE-----

--CJhilzLIyAgaRUK6--

--===============8886909404553326394==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8886909404553326394==--
