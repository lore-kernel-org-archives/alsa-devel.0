From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/9] ASoC: sun8i-codec: Add support for A64 SoC
Date: Wed, 6 Dec 2017 15:48:10 +0000
Message-ID: <20171206154810.eb2czpb4kusxv5kj@sirena.org.uk>
References: <20171203204157.20829-1-anarsoul@gmail.com>
 <20171203204157.20829-5-anarsoul@gmail.com>
 <20171205080444.zo2rlusqpjyraqcw@flea.lan>
 <CA+E=qVdZME2fiMw09NUP4DNCYhk58dqSapCdfBjLrdMq5HFwyg@mail.gmail.com>
 <20171206153205.k3l5sofdco3t75mi@flea.lan>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7235640817146618898=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20171206153205.k3l5sofdco3t75mi@flea.lan>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Vasily Khoruzhick <anarsoul@gmail.com>, Marcus Cooper <codekipper@gmail.com>, Chen-Yu Tsai <wens@csie.org>, =?iso-8859-1?Q?Myl=E8ne?= Josserand <mylene.josserand@free-electrons.com>, arm-linux <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--===============7235640817146618898==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t5qz4gmjfnzvktxe"
Content-Disposition: inline


--t5qz4gmjfnzvktxe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 06, 2017 at 04:32:05PM +0100, Maxime Ripard wrote:

> BCLK is sample rate * sample size * channels, and LRCK is running at
> the sample rate. So the ratio is the sample size * channels.

> Anything deviating from those standard i2s concepts should at least be
> documented, with arguments to back them off.

BCLK can be higher than the minimum there in most formats, though some
hardware is more restrictive so we tend to go for the minimum clock rate.

--t5qz4gmjfnzvktxe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlooETkACgkQJNaLcl1U
h9BqtAf9FnjCgsCNcLgqsqoU2P1T+nt3Vb72nPpPiVetLU8iUeqzErxABOUCYTHU
WvjI5T8ig4GiMdK3HqRebQuPzA7+q+tdoPMGmb5qh7RXANeYd1FpZIQN7W0+pXQ9
blXd3vLH8pJooQOWssulDvNPB1EAadHRBgWCcSuprDxiOf8eErtktQEdPcw5UwO5
0XltWNg1CA5cE2Cpj6UxmG8i8eodX2lj4nfiAbU/MB2cj47NdcyIEdiga0p2tvAv
NI1x+UWRGfKGcsfVqKHzKaGspM8E0ak1Ig9oAcxyJagAWkRBcwjaWCwBf2pkF4bu
k7Mig4yEuUBJ3yfJ9KRVyTckWJufvg==
=R7ID
-----END PGP SIGNATURE-----

--t5qz4gmjfnzvktxe--


--===============7235640817146618898==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7235640817146618898==--
