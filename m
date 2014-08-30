From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] rockchip-i2s: add power setting for I2S controller,
 also fix some bugs
Date: Sat, 30 Aug 2014 19:24:04 +0100
Message-ID: <20140830182404.GC29327@sirena.org.uk>
References: <1409350027-17604-1-git-send-email-jay.xu@rock-chips.com>
 <1409350196-17784-1-git-send-email-jay.xu@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aHyShe78FfJzbeER"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1409350196-17784-1-git-send-email-jay.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jianqun <jay.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-l3A5Bk7waGM@public.gmane.org, yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--aHyShe78FfJzbeER
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2014 at 03:09:56PM -0700, Jianqun wrote:
> changes:
> * add snd_soc_dai_init_dma_data
> * fix duplicated argument to "I2S_DMACR_TDE_DISABLE"
> * set 1.8v or 3.3v power for I2S controller by GRF interface
> * enable "hclk" always
> * dma maxburst change to 16
>=20
> Requested on RK3XXX I2S controllers, and tested ok on rk3288-pinky board.

Please don't submit multiple changes in one patch unless there's a
strong, specific reason to do so.  It makes it very hard to review the
change if there's lots of different things going on (in this case
there's also some coding style updates that aren't mentioned in the
changelog which doesn't help either).  Split the changes out into
multiple patches instead.

> Change-Id: If17b8022a38c2974f32bfb2dd4b8d16644ec57ac

Don't include noise from your internal review system in upstream
commits.

--aHyShe78FfJzbeER
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUAhbBAAoJELSic+t+oim9L/UP+waZzC2nnAKuXgalswRZorRW
gD+UBGesinIsvNLvBXjOUpQiorerMXKxtzssmxzf8ha1ryDb2nOuXEZX3SWGKWae
9TWlKqfH/e0mnht7HK6aTPOVFBGF2c3CLOqRZ+6gi/TxcpsnYicyWdH/WKB2fJnZ
yPhXbk2mjdbo5qtPa+hzs91OesMyYS9yd1d1r8QrWYOIvkudmZ0Q7yllDEW2q+KW
7FEaIkI26H4sfeD4x/RiOYTWaS5kuK0rtHm4Li2xZ1Lftnq0FRmfv9NKtZshQw81
OXPys6viSUif5cYOs5FDtJL+CxeqDHtPLRGA5MSsMPU8yfXHWkVX9HBxQz3x5Oot
8TvAd8Pa8eEydUW5xPl/f173mGal1mTQ7v6T8bkw6PRVDP8r0L4MZpeCAHYSXTP5
YhjUJ4ORO1RcltBb2biKedtpdJ6xmo9WKU3+hkzjAocA2HuAhcF8SxQuuS64QTVn
y3Gna0vxenUs0n5s7FWJhGF8JVYQymuK49ih/hsZqZpFazX2glt/OaXrGFDcmU1c
u4H54VGsURPX8wOkYTedPChWOjJnCWqcVoMEL1ctySMLQUO2OzfErlQifzn1CSCR
DmuLXP5HEgnwhLD0dOB4PFrH/Edo39lehNGE6yVmAyTSeyiV7vmKdjFnZMj9B7Uw
8nOc5ix5DgcrNHuyrK46
=Os88
-----END PGP SIGNATURE-----

--aHyShe78FfJzbeER--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
