From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ARM: kirkwood: enable S/PDIF
Date: Tue, 23 Jul 2013 14:31:19 +0100
Message-ID: <20130723133119.GG9858@sirena.org.uk>
References: <20130723102320.56bc4555@armhf>
 <20130723084347.GP24642@n2100.arm.linux.org.uk>
 <20130723130622.GB9858@sirena.org.uk>
 <20130723132104.GT24642@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vZRzFRtr9HMcP32e"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130723132104.GT24642@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Jean-Francois Moine <moinejf@free.fr>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Rob Herring <rob.herring@calxeda.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org


--vZRzFRtr9HMcP32e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 23, 2013 at 02:21:04PM +0100, Russell King - ARM Linux wrote:
> On Tue, Jul 23, 2013 at 02:06:22PM +0100, Mark Brown wrote:

> > This patch will do absolutely nothing unless it's used in a machine
> > driver which connects a S/PDIF CODEC to it.  I see no reason not to
> > apply it, someone with hardware with more complex needs can always build
> > on it later.

> So... what if setting this bit causes the SoC to start wiggling a pin
> with the SPDIF signal which has been used for a different purpose?

Right, yup - didn't read it fully.  Like I say doing it conditional on
the DAI format should be fine though.

--vZRzFRtr9HMcP32e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR7oWkAAoJELSic+t+oim9EIMP/0M2rod+o4SXCcLwDdQii7et
V2aahoI7DMNl7adfP6Ctbkhluq4Znf/WoDmff9H5azDrQ4ObndXY0Xlah4uYnRyi
5mONoLO54O+flc+Xb2yzsQr7hUm8D7qliFEefxSaxttNDHo/UctHi23IwiU9ekiR
MGBL05DX/JlR8Ft7GEuqoAyROiUo4Av3qXjrk1/C4Zr2wafnX+Gmi/hoBxEcYuID
at0ojCIdDWIc848Je3dclf8Z1pAFPqWyRm4hcqqijpIOq1GQNsJkLhHa18oU7+PE
PIehljhQnHzzKOEAKMh6OYn6Wlf/dwuoPfw4TUw81jbxzYdpmNDtF2eXqYN0bE68
6sz+287VQELUrH3+3aN/9kneibjbWxqUP5q90LwekHuC78o1PrFyN/xZ+zkTX28q
1dNXGnR/P0kfdp5wWfh3BrG9mrLw4wsz3laC98fi7i3OJiBETxDAGsPhrZoa23lf
RRwDK6XN15t8h1f9htrIx6tIBPTDDPBS4U7hWDRMuYCqM2QN9IJzkhdBMwZzwJcn
Zn9uKbrKkiO7/ydFwiUzQtrS9Zh6/kvigM3+aBAd17pCmaJoygkrIoD5jAtGyfSA
O5sqerQF3PtjRkMz8787WbE+SOvWz13h9qwew/u1BKrhRnLUp4fCNXMtcfZ0iT5q
3ZX0WVydScoHhx9/viQH
=iQoc
-----END PGP SIGNATURE-----

--vZRzFRtr9HMcP32e--
