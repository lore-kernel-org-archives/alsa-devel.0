From: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] dmaengine: Add support for BCM2835.
Date: Wed, 13 Nov 2013 10:30:17 +0530
Message-ID: <20131113050017.GO8834@intel.com>
References: <527D1DDA.2040004@koalo.de>
 <20131108181743.GR2493@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20131108181743.GR2493-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Florian Meier <florian.meier-oZ8rN/sblLk@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 08, 2013 at 06:17:43PM +0000, Mark Brown wrote:
> On Fri, Nov 08, 2013 at 06:22:34PM +0100, Florian Meier wrote:
> > Add support for DMA controller of BCM2835 as used in the Raspberry Pi.
> > Currently it only supports cyclic DMA for serving the I2S driver.
>=20
> Adding in Martin Sperl who's been looking at DMA with regard to the SPI
> controller (which will want non-cyclic mode but I guess there's a lot of
> shared code).
Is there a plan to add a library in SPI for dma ops, on lines of what is do=
ne in
sound?

--
~Vinod

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJSgwdgAAoJEHwUBw8lI4NHrV4P/iBW7SdKykUvv5lB6ZJzQHSd
jVSeXWxhazFdnDCdL7ZuBCcyw/ntuXjvd8/qDTGv0b8DzIuGj4aulNH8AeETnkqs
5vVrdydONihL762FcFjFCpBEvRwOfvTaO2Omp0v5z4oiaE2ijTB7BtX5MLWA3YZp
llbTauhmSJbjynOju3PBcbBPFXGua9KKQeL3eYS82PUIOMW/vI6XDO4V0hvSLkpv
qqySDcai22jBlcEkexw71hgf89BAY9W8x1sJGTkJLK8z4ekB5sqrHe+kBJJRzzLr
X2MAjxbMl4NaEbKuGSLRAei/LA75qrBfVxEIHPzBJG6jcsNWyjhxeDvZI47Rphnq
8vKhZapjfWbl6/zUMVZ2flmOdIIzgjfgF9KEhb/EzANalScNYy68xIy11aa5bIs3
L3yEEl7wMo/dvqa1i8R4eh95rlkcgGWedJGYWyjqUGlab1RKLwtQlwr+WVHh+ouy
d/Yb+PY3nCp7S/xjlMoGoumxeya6DsC2vclD3TZP07d7OekgwiwyrWhsAeCsqPDV
5rm+qoJgiuny4HfGDi55njmk+GHm/SJyvypDB4zDcuWGHqxI90XgAWwOtSG0JqHH
iXu7ZsTpq+0maF9/J4tMKYnY5EXDHn+i3upNO5ttl8GQrQjd0hKG4BSJpmF7uKSJ
yCfB8iZLqEePCJXXNpQF
=WRDa
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
