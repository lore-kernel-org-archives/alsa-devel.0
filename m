From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: twl6040: Support for DT
Date: Tue, 8 May 2012 14:41:23 +0100
Message-ID: <20120508134123.GQ15893@opensource.wolfsonmicro.com>
References: <1336477945-27460-1-git-send-email-peter.ujfalusi@ti.com>
	<20120508122630.GM15893@opensource.wolfsonmicro.com>
	<4FA914C1.904@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1421316971539465743=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8E0C12444C
	for <alsa-devel@alsa-project.org>;
	Tue,  8 May 2012 15:41:25 +0200 (CEST)
In-Reply-To: <4FA914C1.904@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, "Cousson, Benoit" <b-cousson@ti.com>, Liam Girdwood <lrg@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============1421316971539465743==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Zbynv6TNPa9FrOf6"
Content-Disposition: inline


--Zbynv6TNPa9FrOf6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 08, 2012 at 03:42:41PM +0300, Peter Ujfalusi wrote:
> On 05/08/2012 03:26 PM, Mark Brown wrote:

> > Why are we loading MFD components using device tree?  It seems like
> > we're doing something very wrong if we need people to explicitly write

> I have based the twl6040 DT structure on the already existing twl4030,
> twl6030 MFD parts.

This really isn't relevant to the issue...

> Also without a DT entry I will not have a way to use phandle to connect
> the codec in the machine driver.

Of course you do!  There's going to be a device tree entry for the chip,
things can point at this perfectly happily.

> I would expect other operating systems should be able to sue this
> structure since in every environment there must be a way to handle MFD
> devices.

A lot of things would just handle them by providing a single device
driver which covers the entire chip.  Things like the split between the
vibra and CODEC drivers definitely vary between systems.

--Zbynv6TNPa9FrOf6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPqSJ8AAoJEBus8iNuMP3d9dwQAJCaddbcpbVqsUFCpHp378rK
WOWPMcN9s6KdzfrMa0POkcw7QPhiQprADisCzvo1zUywb+ogjAkOne6/tccMn/fX
45DhTZaU6m+dgdfKEop2Lru9eDFBS/68YvG9DCTJS0G8rPvBAwTVmdAUVACN/WgE
a54P2pzLVxp/2mxRlyligPlg9uiZjdjuhZNihsmFtrAuG78UYNU4mKrBZBfRaIVa
ChCB3S7ppuSsZtieqq6p8IHdPZbyRWsWrm0bpN78SWEh6t80vzaZzqyHRtNLSpTo
KyVEQ5dJ5f/H+pDyLHjnnuzn1D/iST45t9ay7YI4H7FKMaNWRz3u1L24UpUhE12o
0/RuOvlQvDC191eRJPLA1ZAF4ln9AwjZ0xFU+WrZ+6n5wIdp7IN6niCWMURZQezN
5r+HlHrNnGHYS1oc2bTBbBCLSYIQV4xbWsTqPLjsdnej6gr5x4eP2R5x/1dKZXfU
nFj+XsBZf8b13/IYVPyg8MF7zbjedGXFBoHkDRPOtoaUIQPvmZVkfpug/Z2egFuW
5nO5JTCoddERjc/NM3UWR9Wwi2XSNkqbJKk3x3OUQxDs4CxUg1pykRpZfnfNslaG
OB9udTU8wRBYAlImlPpkLCj+yFQR/UG9eaO4Ld90YMV6CGO6SekvIQw9VI7WHgmq
9ol+7Xh88MjZTN2+4R0r
=Kfbq
-----END PGP SIGNATURE-----

--Zbynv6TNPa9FrOf6--

--===============1421316971539465743==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1421316971539465743==--
