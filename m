From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: sglt5000: Provide the reg_stride
	field
Date: Thu, 4 Jul 2013 23:51:04 +0100
Message-ID: <20130704225104.GL27646@sirena.org.uk>
References: <1372972130-32451-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2980694396412668398=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 9ECC52657EC
 for <alsa-devel@alsa-project.org>; Fri,  5 Jul 2013 00:51:11 +0200 (CEST)
In-Reply-To: <1372972130-32451-1-git-send-email-festevam@gmail.com>
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


--===============2980694396412668398==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QKoJkuK3/9uDCifc"
Content-Disposition: inline


--QKoJkuK3/9uDCifc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 04, 2013 at 06:08:48PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>=20
> sgtl5000 has 16-bit registers, so we need to tell regmap to use a reg_str=
ide of
> two bytes.

No we don't, the stride is in terms of registers not bytes.  At least
not according to that patch description anyway.

--QKoJkuK3/9uDCifc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR1fxVAAoJELSic+t+oim9UWAP/0VNsOyF/EVGCNS6/dKS+iCd
k6bCEzeY8/2hdbiC9Cok42pSlM4GcpAYx5jJ4HR03JRBNOEfhYDqUuzBciG0+7On
tIySvSsoEV2XGRTWsjOmr/ErVUKUcqCrz85ajGxMEhsiNAOl8INKSR+3LkruzHHJ
HPllVNTnWrJcHJhHcYsmFLs6jJPF/pCrxRqEaXneYgt9ra+wUvyeh+bgRGX2/rNn
yDTHRwbfV5J/2nO9/DdEKFt8qx5wMFAofuIe3qGV+Lwtz7EhvyZpE+N/0Yn18h1g
BAAXepWFF24oD1M0p6L6HB2CIxRi6uA/fEV20q1ztYWRxBUePJzSgzy++7mlx5Td
y6v/mTVR7DWXHdknW7GkKcVnS/0ap49iW4IA4WghvWt1kw/M1rz/GWQqnDHF5PJM
we9Blb5jmug95l9cife0WAaRhiqGrMjBC2gOTJ4TVGmtjhmqof+zD3v705p3kRkS
0GOuuXi6wgTEson+iOx9gvJ0ox/dG71tgHCTzFkIs/TDkrOdcr92vkVjej6VTLmq
epettAj3gOZHDzSg4YtOyk4GltpzlELPwz8NXRGuR9IDZqB3TsOuv0k1H3Sjp/ur
oVLNMafgnE/V7yu6tWEJUdVoWXGqfMW9rFq9RF5oVUORF0tkI9tvjUDbxkdV5xjF
69TSdOV9YHRu4WsKbCto
=xNc4
-----END PGP SIGNATURE-----

--QKoJkuK3/9uDCifc--

--===============2980694396412668398==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2980694396412668398==--
