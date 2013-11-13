From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] dmaengine: Add support for BCM2835.
Date: Wed, 13 Nov 2013 12:51:11 +0000
Message-ID: <20131113125111.GE878@sirena.org.uk>
References: <527D1DDA.2040004@koalo.de>
 <20131108181743.GR2493@sirena.org.uk>
 <20131113050017.GO8834@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T6xhMxlHU34Bk0ad"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20131113050017.GO8834-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Florian Meier <florian.meier-oZ8rN/sblLk@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--T6xhMxlHU34Bk0ad
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 13, 2013 at 10:30:17AM +0530, Vinod Koul wrote:
> On Fri, Nov 08, 2013 at 06:17:43PM +0000, Mark Brown wrote:

> > Adding in Martin Sperl who's been looking at DMA with regard to the SPI
> > controller (which will want non-cyclic mode but I guess there's a lot of
> > shared code).

> Is there a plan to add a library in SPI for dma ops, on lines of what
> is done in sound?

I'm probably going to be looking at that at some point, though perhaps
Martin will get to it since he seems to be looking at this.

--T6xhMxlHU34Bk0ad
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSg3W8AAoJELSic+t+oim9lAIP/i2DqKmTzrViDNzR93jn6mvc
yk4mHQ8T7rHUOhGCAgFhIahzj+oNnxem4IjfXPOdzKEHBAE8VaKrAFV7qRlWbCbU
4PloFqW65C5HjAidUgZQaWnKsk0HrfJhjKlN48LoBqQCKqwunL7fJ5EnL2dki0db
lmRND/wiZ9W3/6rIxxXYGWWZFQ0zdtdbeKV/h27fYZAv3OgVZabd8DdFlb9vUniP
bRJbLwBfBXZX8e/p1XrZQJ/5eP6yTFLqNGSZVM+/8vWwLEhOZriU6KTlxF4TtE2Y
0EmesN4Wzc+B7PIqIziu9BtV+YiyoaUypKs/Z6r60np6j1Wo5E8aXG+APwDTHfgM
eSPy5oqglsYNxxjR32AgXWpDORuZBqH3SobWvZjBrk1phFPMLzqYbRwWpY0x/U8i
nTvo/yEkhwsdt623Csl10u67UAG044fyBoSr+/pHgkuBdKuVs5HGnik8bTsfoa2a
1iBFJdUXHVJ8ip9AKO4oidekpjgV9gg4JD7qXBWbLWbhWKPvNUdTmuPeT1626nor
qZdgUa90tNZewLuJh+8GwdYGo+ep/lrnsA2ZDI3a5v3QWj/MJH0E9s5dKwqMRVzd
zfocxUDLM50cMtqAtHlUwcMdW7u0sAYcgWAEghWAh68jTYJ/D31YY6VqXvU+DlK+
Us6gLYk4U+Z158P8Wub3
=4s61
-----END PGP SIGNATURE-----

--T6xhMxlHU34Bk0ad--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
