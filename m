From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: tlv320aic3x: add missing registers
	and bits
Date: Tue, 26 Jun 2012 14:21:18 +0100
Message-ID: <20120626132117.GV30406@opensource.wolfsonmicro.com>
References: <4FE9AD5F.7080302@aksignal.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8614747185358070540=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7180224361
	for <alsa-devel@alsa-project.org>;
	Tue, 26 Jun 2012 15:21:19 +0200 (CEST)
In-Reply-To: <4FE9AD5F.7080302@aksignal.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Prchal =?utf-8?B?SmnFmcOt?= <jiri.prchal@aksignal.cz>
Cc: vbarinov@embeddedalley.com, alsa-devel@alsa-project.org, sudhakar.raj@ti.com, nsekhar@ti.com, peter.ujfalusi@ti.com, mr.swami.reddy@ti.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org


--===============8614747185358070540==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="X9hp/qFlD/MyfJCu"
Content-Disposition: inline


--X9hp/qFlD/MyfJCu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 26, 2012 at 02:38:55PM +0200, Prchal Ji=C5=99=C3=AD wrote:
> This patch adds missing registers and bits for TLV320AIC3106.

>  static const u8 aic3x_reg[AIC3X_CACHEREGNUM] =3D {
> -	0x00, 0x00, 0x00, 0x10,	/* 0 */

> +	0x00, 0x00, 0x00, 0x10, 0x04, 0x00, 0x00, 0x00, /* 0 */

This is essentially impossible to review as you've not said what's being
fixed and have completely reformatted the table so the diff doesn't
highlight the changes at all.  What's wrong and what is the change
fixing?

--X9hp/qFlD/MyfJCu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP6bdHAAoJEBus8iNuMP3dGwQP+wc2obDhyOoV/ht3uKkZ8lef
FxbKY0sGcBfPfNFpofAd3CoTXT1rJFmlB99pNTluNgaNA2L66krCF6TieKp7VFXy
ry0u4LFzvSLYUX3T147vRAZjsc/Z3x4rdWlnlalVbNNQmt0I3Rec8equHBJRYjyh
ozOaylWfEqWCe/FUWAHseFrfWBqUBWcUcLjce/GxuXY+89tEDiSkh6LCBOEvZTOJ
H8HFDFDXif9s0DJze/JGQE2YNiPr/+91v3XW67go35b7W8FIajvJdQhWBDRjBe3E
s8e1EdVcxV4U9lmk5bDs5U7VNTvHDAqczGfDUpMYFx51n4yoQydQfwvzJC9f4cSd
ZybyRjSHmdGYJxsdyGSsdZQ+hNM8yr/0hgdBbmJCf0SabZ0KkxDQznNHAm73CBxf
liXcrEzPPG6vxz7ilSqLAdR+dJvlCuJNaKwLZ5Cw8VF0Hy+a3z+Wfh34zakiwTux
0aKVu3P/CGLHkpO8AnZD5bO9kW5dDYkZWwpCTvpMal0JYl0q90m66EVKEkPqewyl
1IlEKZRLmWeNeojC0NHI417fHih9SvTiWkxxFlmt19ODn0kBzJ8CV2mVZjGKoQ2Y
ktVkiBFi1oQRjDmMVvjYvoS+0Fi0+WKvSkMugylwxKtsgSn4faED/vhD50qOh+gr
lKPNYzU3854vZxK+bfvV
=6x/R
-----END PGP SIGNATURE-----

--X9hp/qFlD/MyfJCu--

--===============8614747185358070540==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8614747185358070540==--
