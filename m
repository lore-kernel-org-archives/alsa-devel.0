From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rsnd: call rsnd_dai_pointer_update()
 from outside of lock
Date: Wed, 23 Apr 2014 12:17:25 +0100
Message-ID: <20140423111725.GP12304@sirena.org.uk>
References: <20140418.140133.428086893.ko-abe@nk4lx2>
 <5350B75C.6030500@renesas.com>
 <20140418.145315.172551492.ko-abe@nk4lx2>
 <5350CD5D.9060800@renesas.com>
 <5b6857d989484e3690995c92920930ac@HKXPR06MB040.apcprd06.prod.outlook.com>
 <874n1kj3je.wl%kuninori.morimoto.gx@renesas.com>
 <8738h4j2wo.wl%kuninori.morimoto.gx@renesas.com>
 <3977b65ffbb84cc89b66739c5b13ebdd@HKXPR06MB040.apcprd06.prod.outlook.com>
 <871twoio27.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8965425878756615719=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 23F2B261A3B
 for <alsa-devel@alsa-project.org>; Wed, 23 Apr 2014 13:17:35 +0200 (CEST)
In-Reply-To: <871twoio27.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: TOMOHARU FUKAWA <tomoharu.fukawa.eb@renesas.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Ryo Kataoka <ryo.kataoka.wt@renesas.com>, YOSHIFUMI HOSOYA <yoshifumi.hosoya.wj@renesas.com>, Ryusuke Sakato <ryusuke.sakato.bx@renesas.com>, Koei Abe <kouei.abe.cp@renesas.com>, Magnus <magnus.damm@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, TOSHIAKI KOMATSU <toshiaki.komatsu.ud@renesas.com>, KHIEM NGUYEN <khiem.nguyen.xt@renesas.com>, Yusuke Goda <yusuke.goda.sx@renesas.com>, Simon <horms@verge.net.au>, "simon@horms.net" <simon@horms.net>, NAOYA SHIIBA <naoya.shiiba.nx@renesas.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, YOSHIYUKI ITO <yoshiyuki.ito.ub@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============8965425878756615719==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NoillsJCK92BJ/Cw"
Content-Disposition: inline


--NoillsJCK92BJ/Cw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 23, 2014 at 02:59:12PM +0900, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> rsnd_soc_dai_trigger() will be called
> after rsnd_dai_pointer_update() function
> which is using rsnd_lock().
> Thus, it should be called from outside of rsnd_lock().
> Kernel will be hangup without this patch.
> Special thanks to Kataoka-san

Applied, thanks.

--NoillsJCK92BJ/Cw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTV6FBAAoJELSic+t+oim9BYUQAI5QG32jnGfAQsPERwKeWZrE
AZ2wY4V2ZiNAYwL/pes3R1muQ2oSHGsYGkR6A/4EjjhjJWvTP4mRB67h8Ol/8hCX
pcWqs4Slay0xk6GL/GfQpfVrKasJCIPWLFeV+DXkm0yuTevSoGylsIbY1zWGkNav
YVxKvSZbKVEDbPZ15Ba0/mGSIvW3mi5IZ89jB4O+LBqrD/TYh7dO2/Wg9J9srxZC
CDkSJok5Kh/5eOZ9ioe1xf63mdEEIEJHFxeQrj5JUYNDYHBfozlkNhM0JjrjQhgD
W0y4petbnXRQl/S5Jzyz71ylmf/5NyA/QkcreWgqPfEZdBdAcmLO4zeIlTzVzWZ9
k8RrQJVhTVhmWl2fop6mIT+W3un/Fjg7xQnddwsTPbxkQugQi/CSRyP1dshxOsYW
OGqSR0g160fTcNto1sEXsP0NFMvyk/vDkw/DzUM6XN4iIHoE36MMknE6KCVER7P1
IEbodWajGlLWSsdAjAS3ZgP+C/unYYzNLANAJGlv6nE8WHFa/H+Tks+6CnuKiwxs
e8NU5L8BHAf/PVxhMbPSGyYeu/tV2S7tMmJcWMBYLBR4fwcCZKR381IrygimmwqZ
eW0DB4z1t0eieGDAf1Tpxd33OUfcrYmW9/aXYjIZgDgnjklcv4ub1X70+DXXWTND
xFHIuY9tMUncYbyR8VHG
=sTJ0
-----END PGP SIGNATURE-----

--NoillsJCK92BJ/Cw--

--===============8965425878756615719==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8965425878756615719==--
