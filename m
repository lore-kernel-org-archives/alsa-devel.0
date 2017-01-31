From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v3 2/8] ASoC: sun4i-i2s: Add quirks to
 handle a31 compatible
Date: Tue, 31 Jan 2017 11:31:23 +0100
Message-ID: <20170131103123.6ldkmxhkpaihllmp@lukather>
References: <20170131100552.27949-1-mylene.josserand@free-electrons.com>
 <20170131100552.27949-3-mylene.josserand@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3770042874258146638=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.free-electrons.com (mail.free-electrons.com [62.4.15.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 22FE2267284
 for <alsa-devel@alsa-project.org>; Tue, 31 Jan 2017 11:31:23 +0100 (CET)
In-Reply-To: <20170131100552.27949-3-mylene.josserand@free-electrons.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?iso-8859-1?Q?Myl=E8ne?= Josserand <mylene.josserand@free-electrons.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.com, lgirdwood@gmail.com, robh+dt@kernel.org, wens@csie.org, broonie@kernel.org, alexandre.belloni@free-electrons.com, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============3770042874258146638==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vmgisapw3be5myiv"
Content-Disposition: inline


--vmgisapw3be5myiv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 31, 2017 at 11:05:46AM +0100, Myl=E8ne Josserand wrote:
> Some SoCs have a reset line that must be asserted/deasserted.
> This patch adds a quirk to handle the new compatible
> "allwinner,sun6i-a31-i2s" which will deassert the reset
> line on probe function and assert it on remove's one.
>=20
> This new compatible is useful in case of A33 codec driver, for example.
>=20
> Signed-off-by: Myl=E8ne Josserand <mylene.josserand@free-electrons.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--vmgisapw3be5myiv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYkGd7AAoJEBx+YmzsjxAg2QwQALyyGcnDoYV3rl+FNVM8PhxR
10KbgzT/HO2XfDCCuiXhxkOGkEDxa1S15pKIS5RF5zZeN4XhC4CiVmCS3EUlKc7y
iiMo3SsqPW+htRZDqlYqQdQIjiT+RY7uJWkMz2y+X2B769WAOv/wy9LmLfNOFG1e
kqBHTPRUsLXTpTnJlb6vGg3DWxPxPXrRvLVvVcrjSDmyTgfw56q4qLMxQ7Cm6RjX
LliXUqnlBe4Ec7QcYWrnpb7kxksUTlYyxHv7eW7HTgGRXnAjQCUFgdTo6kjN53aE
avLEchAbocQqWRgvczVx2KXEpT0GBhrrFzjeLFIOKZ48rf84QG00VeFFlPfvF9mv
tE9Q2tSal+oKfXrfwrvIpv1CUxXSgBrwi+M1ActxawXecRjx9MsbBrMixWBrDlpz
/BpMZOw60QDKgyTcgaW4KQ4vOkduQSgYx9by94xzsRK4d2JVB69TOMScH1WujIJh
W6BmmREBzDNQoAofVdhs33aOtSMi3WJtaq8fG8gKVj0vCR+VTYoyAjZj0HXLimQ5
IF7hsFNiUQh0s6em6zfB8jC2LECaZel/KhqATfJzqH5ONaE68wBI1Af4gJoqPWd+
IuntS3Q7k3iuZ9ZHqQBUxsW9mbBnaIrnrjYHzciVHANKp6zX4MDdG+r8vTjweg/p
giVPebbag9GyD+bBSiJS
=jALR
-----END PGP SIGNATURE-----

--vmgisapw3be5myiv--

--===============3770042874258146638==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3770042874258146638==--
