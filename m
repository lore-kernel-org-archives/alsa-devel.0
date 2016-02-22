From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH 4/4] ASoC: simple-card: Support for
 selecting system clocks by ID
Date: Mon, 22 Feb 2016 12:21:08 +0900
Message-ID: <20160222032108.GU18327@sirena.org.uk>
References: <1455545495-20292-1-git-send-email-peter.ujfalusi@ti.com>
 <1455545495-20292-5-git-send-email-peter.ujfalusi@ti.com>
 <20160215152635.GN18988@sirena.org.uk>
 <56C2F00C.8080809@ti.com>
 <20160216134233.GN18327@sirena.org.uk>
 <20160216191346.2278.725@quark.deferred.io>
 <alpine.DEB.2.02.1602171516260.10339@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0kAGJ5Hb5f/LtdyK"
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1602171516260.10339@lnxricardw1.se.axis.com>
Sender: linux-clk-owner@vger.kernel.org
To: Ricard Wanderlof <ricard.wanderlof@axis.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel <alsa-devel@alsa-project.org>, Stephen Boyd <sboyd@codeaurora.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jyri Sarha <jsarha@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, "Kristo, Tero" <t-kristo@ti.com>, linux-clk@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>
List-Id: alsa-devel@alsa-project.org


--0kAGJ5Hb5f/LtdyK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 17, 2016 at 03:18:57PM +0100, Ricard Wanderlof wrote:

> It makes sense to use an already existing clock framework, but I'm=20
> wondering, how do we model the clock select function? Using a clock mux?=
=20

Yes, that looks like a mux to me.

--0kAGJ5Hb5f/LtdyK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWyn6iAAoJECTWi3JdVIfQx7EH/3J5PT27YZ3ntIIDi2PrKBhf
RKAlzOzL1SU6i6QH4mr2rJ5zcYEDcRYOr6Q1gQi1CKbwKrq41XjP2YwCjvbN9odh
ZL71+kinLVk96YRQyJDnFePo79Qe/MczX3Tb+CRpm1dUhA8kGNk9inc6Kj8szvKR
W1eMhlLLP1ipaWlFTGVATqD/bs+1Y1Sn3agdevleKFRek1RwWvNmfyd7xNZx84sC
QLWP5mOiXFLQkHMyWkKKFpT9LdKB1tjKfitfrbbTTzZmkSWfTvD2bXBJKYYM0kQe
f3qSIjJmDFAIEm3X5AJYq04kU3kPYnMSUQWCyndS39GpP6JhiJ2TIZeRBnmUYEc=
=vppu
-----END PGP SIGNATURE-----

--0kAGJ5Hb5f/LtdyK--
