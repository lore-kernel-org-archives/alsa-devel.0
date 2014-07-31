From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] ASoC: Add support for CS35L32 Boosted Amplifier
Date: Thu, 31 Jul 2014 21:27:18 +0100
Message-ID: <20140731202718.GZ17528@sirena.org.uk>
References: <1406664163-10506-1-git-send-email-brian.austin@cirrus.com>
 <20140731200729.GW17528@sirena.org.uk>
 <alpine.DEB.2.02.1407311520490.7394@heelrod>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZKE/1Mm+6y0nReWg"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1407311520490.7394@heelrod>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Brian Austin <brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--ZKE/1Mm+6y0nReWg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 31, 2014 at 03:27:13PM -0500, Brian Austin wrote:
> On Thu, 31 Jul 2014, Mark Brown wrote:

> > Should the interrupt and LED status registers not also be volatile?

> Sure. I guess precious doesn't have any effect on cache then?

It doesn't.

> > > +	case CS35L32_MCLK_6144MHZ:

> > Not sure these defines add anything over just using the numbers and it
> > avoids ickyness with the fact that I bet this isn't really 6.144GHz.

> I was trying to avoid using numbers, but if it is OK I can do that.

If the define just ends up shoving some characters in front of a number
it's not really adding anything.

--ZKE/1Mm+6y0nReWg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT2qaiAAoJELSic+t+oim9y+MP/j8G1XxyhXeU6D4BB9TXdmF6
MC7V1LmOodCsORt9hbXQNig+YSAhESLP1BJbXyQXaQ7ClyEZrSBhVyyiSyBNJPkG
lRu7Y3s2pPHI8bSTTPGQzdOPPyOEON4KIDA8junvfvCRneV0n4KFTJTDvwo/cW9H
yLnPEXuwzBqcjlf3L/udEAr6kjn++ea59WxUkgoDDk1nhG+MxOu8T1e4HcHwOjgL
dvIehmK0J/4PquZkbt6DyB2826xwbEYB0AfxdGVr8KVwmJhD6RsSDdx82SN2gkfh
V/8NqTecatp/quxBGKECk9M8AIGlm+p9kW42B43aVNx5Cml9vc8FR6Fzff+TYg2B
GOnXx/oGIrsJQCwyxuWnqailNsKBWmwTawlnbgY5DTc12CaU9nwjAsL5Bqg+PF5d
H57xteL2IBYHXF5fcb70vNZbXiOUsfIaD5kxrYNKVy/2vo7K7Mq95Klf2w7vjUUw
HvRSwcIClQwLiNHHSQ7j5o26jsoFW3HyaHxIGQTV5fAOea6TAk6TRyGzQPwKg476
5JJfhWe9f8nOTiakaCpyllnkXFpS0zcEB4kKeDCz00qb1jskm6i/+j3/0beAPB8m
g59aTCTMOgngZd14YxIBTfjsCpQ2IOaKSIO3GkFrdEmVoQ0fWLKhJ339cBFDxH9G
U6MOPvx1nffRFPeyPuwa
=xjKW
-----END PGP SIGNATURE-----

--ZKE/1Mm+6y0nReWg--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
