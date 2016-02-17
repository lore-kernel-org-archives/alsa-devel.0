From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/4] ASoC: simple-card: Support for selecting system
 clocks by ID
Date: Wed, 17 Feb 2016 11:31:36 +0000
Message-ID: <20160217113136.GN7544@sirena.org.uk>
References: <1455545495-20292-1-git-send-email-peter.ujfalusi@ti.com>
 <1455545495-20292-5-git-send-email-peter.ujfalusi@ti.com>
 <20160215152635.GN18988@sirena.org.uk>
 <56C2F00C.8080809@ti.com>
 <20160216134233.GN18327@sirena.org.uk>
 <20160216191346.2278.725@quark.deferred.io>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yklP1rR72f9kjNtc"
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160216191346.2278.725@quark.deferred.io>
Sender: linux-clk-owner@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, Jyri Sarha <jsarha@ti.com>, linux-clk@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Kristo, Tero" <t-kristo@ti.com>
List-Id: alsa-devel@alsa-project.org


--yklP1rR72f9kjNtc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 16, 2016 at 11:13:46AM -0800, Michael Turquette wrote:
> Quoting Mark Brown (2016-02-16 05:42:33)
> > On Tue, Feb 16, 2016 at 11:46:52AM +0200, Peter Ujfalusi wrote:

> > > I don't think it will bring any clarity or features we miss right now if we
> > > try to move CPU and codec drivers to clk API. IMHO.

> CPU drivers? Peter, you wrote the CCF clock provider driver for DRA7
> ATL, so I'm not sure what you mean here.

In this case he's referring to the drivers for the audio IP blocks
inside the SoC.

--yklP1rR72f9kjNtc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWxFoXAAoJECTWi3JdVIfQxqwH/jFoYdJg840EahFqi9mA6pYg
j2v8N1/s1qQc5nld1dNLTtt9NG2kEB/rNCLO3Id56D0ofZ52rc07lD/Wl9T7E5z9
ozzwHo+64omR53Z8nNGOFQrsqraeBPPIiwaHM2bZoquL1VZ2l5+6NADPXIQrVjfV
q3jKyrTjI3vohsdVVVfZndx90T2noiYYZrZJPbq3wQVz80dAzYDUrNa6/48Bbut+
2KgSxUHyQz/q6YLnatI0e/Zw/XehjOzbvcoCadwV0pNkEJgXRp6/fngpQnnRDqPy
gIKJB4ev3i8K+1teVXKJ3pYtjashT3yOz3d+jt4DeUDU6dVqx+IX2Uj/Es32gkc=
=33Yi
-----END PGP SIGNATURE-----

--yklP1rR72f9kjNtc--
