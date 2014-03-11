From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: cs42888: Add codec driver support
Date: Tue, 11 Mar 2014 18:46:06 +0000
Message-ID: <20140311184606.GW28112@sirena.org.uk>
References: <1394536791-8381-1-git-send-email-Guangyu.Chen@freescale.com>
 <alpine.DEB.2.02.1403111026280.3558@heelrod>
 <531F320E.70605@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MUSEnV6akQk4QhdD"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <531F320E.70605@metafoo.de>
Sender: linux-doc-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Brian Austin <brian.austin@cirrus.com>, Nicolin Chen <Guangyu.Chen@freescale.com>, Paul.Handrigan@cirrus.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, rob@landley.net, lgirdwood@gmail.com, grant.likely@linaro.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--MUSEnV6akQk4QhdD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 11, 2014 at 04:55:58PM +0100, Lars-Peter Clausen wrote:
> On 03/11/2014 04:41 PM, Brian Austin wrote:

> >So WRT the CS42888, this is one device in a series of 2 devices that are
> >register compatible with the only difference being that the CS42488 has 2
> >extra ADC's. Same die and same DeviceID.

> >Would it make more sense to submit the driver with the extra ADC's to make
> >it feature complete for both devices? Wouldn't be odd to have 2 drivers that
> >do the same for 98% of the code.

> This should be in one driver. But support for the second device can
> always be added in a follow up patch.

Yes, we can add support later.  It might be helpful to name the driver
with some generic name I guess.

--MUSEnV6akQk4QhdD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTH1nqAAoJELSic+t+oim9C/gP/i5BAh0i6DINdS77d401B9NC
PQQulo2Wjz08u6THrD0oASQB+4wOaM6xI1U+YMyXBtXbw4zYW0isO/3MmXTGhFcm
Kj7+MMtZcSaLuxm/17n9WDNiErgqmxCwsBaemnIN3fLHX8mrJd8r9MBkGOI5Puc5
RTn1fgig48xlGcnD+Or+14oUyUIGrZlKAZ7ybLBOlj6DEsLBAY6lja1Uc68qyC/f
5wsijto7NLacEbQULXO3pxiAd4m3D4NO8btb7xWk8YTw2omyJFhOepzmGdaUFESU
938ngC8XyWc5+BVWDnt29hBHP0vuzDq0Qvzsge6wEVsz/2XUl/Bm83mxxYW+q2kw
5MB0+t6QJUeOWncvmd1mlNAo13QaXeXcD3KZiC+If7Zgpq2SoVAGqAgvxBDntY8x
ukBbnLLVnEAr1uugmdNUvsz0O4AOdaEiYJycNRQQAszQxMEeBogyGMn/LJEjXY9U
JqCHNGNIyiU2ptFXE9ISIDI9d1BzUFxfWjVY3zgWRqvTn2795X5Wdb1jwVcqv+Rb
wasU2ncCCy43+ICORRCRACTQozmR5hfsDAxZNBf8oojg7us4CIhcDGDOM2EU7yLa
UuSkEPWrzGi8KomI8zKlqnPeAYbNVmRlVHVfoe6pL+4H92EECgAHlnKoIuntw1os
2PKpZFYXjt43jn4wkfvB
=WB+k
-----END PGP SIGNATURE-----

--MUSEnV6akQk4QhdD--
