From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 6/9] ARM: mx31ads: add audmux device
Date: Tue, 14 Feb 2012 09:23:43 -0800
Message-ID: <20120214172342.GA3916@opensource.wolfsonmicro.com>
References: <20120202091132.GD9773@S2101-09.ap.freescale.net>
 <20120202092427.GB32403@b20223-02.ap.freescale.net>
 <20120202130901.GE9773@S2101-09.ap.freescale.net>
 <20120202135805.GB3015@richard-laptop>
 <20120203021554.GE32403@b20223-02.ap.freescale.net>
 <20120203133240.GB12915@S2101-09.ap.freescale.net>
 <a9d9bad3-edd0-4a5f-9bb3-15787430d858@email.android.com>
 <20120214013506.GA3276@b20223-02.ap.freescale.net>
 <20120214060627.GB13456@opensource.wolfsonmicro.com>
 <20120214073414.GB3276@b20223-02.ap.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120214073414.GB3276@b20223-02.ap.freescale.net>
Sender: linux-doc-owner@vger.kernel.org
To: Richard Zhao <richard.zhao@freescale.com>
Cc: Richard Zhao <richard.zhao@linaro.org>, Shawn Guo <shawn.guo@linaro.org>, alsa-devel@alsa-project.org, kernel@pengutronix.de, patches@linaro.org, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, eric.miao@linaro.org, eric@eukrea.com, s.hauer@pengutronix.de, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 14, 2012 at 03:34:15PM +0800, Richard Zhao wrote:
> On Mon, Feb 13, 2012 at 10:06:28PM -0800, Mark Brown wrote:

> > Machine drivers can easily get platform data, they're just regular
> > drivers of whatever type so can get platform data in the same way that
> > any other driver for their bus can.

> Machine drivers don't correspond to any hw devices. If we create a
> virtual platform device, it'll be hard for DT binding.

As has been discussed repeatedly and at some considerable length the
board design for audio is considered sufficiently interesting to be
worth representing in the device tree directly, there are plenty of
choices made during board design.  There is absolutely no technical
problem from doing this on the device tree side.

People working on device tree really need to talk to each other more...

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPOpiYAAoJEBus8iNuMP3d/g0P/2rhrRBrhWm+0ZbuhCdim9+B
Sb7KT2Jz0GHdgOigKL0V+uaJcMFXxRnETNJQ4fgAJaOJxD+Ra8AP2enuSYuuUd8Z
aDtR1o+/iPMOaSdZ7izhyAlWPeGka3kWai5GwAtqmAkBfIUU2lbQyj/iyVe7P1/P
nD4hdHGAuQMaZBb268N91crMEyX1P243TbvIDqBRJWLZyLqHwYHCPAwTNzL2tgQg
5wEDG/Nzg3+CuxRlzRYcDyId9zX2zEc5xXLs2Jee5Iw+VTJDDvTZMX7Zxw10xpnQ
vl7fCvoZAByqs3hnhloar478XdpJPxfNQtoIAK8ByiF8qwehQSfRRF809nkK/AOx
T79XNRif3QlqbIM2rhzx+GKY2m9GsiUdAfdujxByaL1y1Rnxhsg9VCgY3DHWKV2b
Fzdv5DLc7sc0/qzOO2S4WQSQYFQzLeSLHDi1tUQuJCsQFvX059KbaD3n5YdY6flm
1c3Z7wPtkKLeKCFvQQ/sOVzlaaNwASIAzfLTSK4iE2FMX2YM66EMwfdZjbUJuwVu
OPcGuLqVUjF4wzm/aijOv5y/gmtJ4PXwhLWwr7NY6xT/TdILj3qgaOdd59bwY2my
p/sQwLYCy9GjlPyNlAVxd//npi95X4rW+g0BdIegwUNf8RHVDltSh6kRRXy/m96v
ZZu9VGYGTfajpN7i1kN+
=dmrw
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--
