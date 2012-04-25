From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] ASoC: bf5xx-ssm2602: Setup sysclock in
	init callback
Date: Wed, 25 Apr 2012 11:20:53 +0100
Message-ID: <20120425102053.GK3195@opensource.wolfsonmicro.com>
References: <1335346188-29823-2-git-send-email-lars@metafoo.>
	<1335346494-30781-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1906896400169331952=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8448810486D
	for <alsa-devel@alsa-project.org>;
	Wed, 25 Apr 2012 12:20:54 +0200 (CEST)
In-Reply-To: <1335346494-30781-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============1906896400169331952==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vk/v8fjDPiDepTtA"
Content-Disposition: inline


--vk/v8fjDPiDepTtA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 25, 2012 at 11:34:54AM +0200, Lars-Peter Clausen wrote:
> The sysclock is fixed, so just set it up once in the init callback instea=
d of
> setting it repeatably in the hw_params callback.
>=20
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Applied, thanks.  I had to do a bit of fixup to apply for 3.5 as it
depends on your previous 3.4 only patch but the conflicts are trivial so
it should all work out fine.  I'll merge things up when the DAI format
patch has propagated into an -rc.

This feels like it should be a framework feature, though we might want
to punt on that for a while in the hope that we'll be able to start
using the clock framework for more and more of this stuff.

--vk/v8fjDPiDepTtA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPl8/+AAoJEBus8iNuMP3duWQP/itJTnT8fUD2rSpqBIv/LAdy
0kCMsGBCpz6nnvCzD/grzaZJ6dxfzbLVmvFyfK5w+xcd6GlCjDld4ad5CH9arUUL
STSNZDNOG3brsWXDi0L/Lk7LUD+SVQvlY0P2ooT+Fmj89y3FGHJ2e2pfD3IErf3q
UdfZ8wTY3uzYwCGICrLK0wZZJog4gycvSTCB+JR/nJ1igS03k6TR/6DYhIj0Z8Ml
tX2lU7VQnMbuRf95i/TJPvdHgHszTV+x3gcbBM1jcfS9qzQPPkgdSrfV89vnoXwS
9v1+SwkYh84XK7uz2SDJ+y7HB5pinCovNfJWSCi98dLiuWKL56gv0fnPJm0v6k5t
lia9BeL65uz0TojTYvGRfFqRHx6oJ3dggg4pxn7a8JyZqcM4f7yQfyYtOWyI9xHe
xWMEGKdw+3JPEUBbcoUiaL2WY2TNwAOp4zWUMl2JUaaL6n8YnqxIMj/ReVEV7wa1
hgt/OXklt2glgGkXinCgBthDmt1Z/6mQ+obyPxbK4LO1Xo1QnEHck4VqLNKT1HX9
nbQ1gpp0ccJ9Ibk1ZqJ9N+O5SoNwUaXQlxELiZ9fzIC7yhkdxRt3eWNrRp7MHFTS
tjOq/EfgkQrCGbUfe4lOGxfYyCl5Y4G9PWkWiQRztMphzFWpmidhdY1KLI4HtwPd
fgyuJ3XzVgPaC4GJP4fo
=AywG
-----END PGP SIGNATURE-----

--vk/v8fjDPiDepTtA--

--===============1906896400169331952==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1906896400169331952==--
