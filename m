From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RESEND RFC PATCH 2/3] ASoC: mediatek: Add AFE connection control
Date: Mon, 20 Apr 2015 21:52:30 +0100
Message-ID: <20150420205230.GK14892@sirena.org.uk>
References: <1428653649-38200-1-git-send-email-koro.chen@mediatek.com>
 <1428653649-38200-3-git-send-email-koro.chen@mediatek.com>
 <20150418173740.GF26185@sirena.org.uk>
 <20150420045017.GI6325@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3CAnR4CLEnEWqRMR"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150420045017.GI6325-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Koro Chen <koro.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-l3A5Bk7waGM@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--3CAnR4CLEnEWqRMR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 20, 2015 at 06:50:17AM +0200, Sascha Hauer wrote:
> On Sat, Apr 18, 2015 at 06:37:40PM +0100, Mark Brown wrote:
> > On Fri, Apr 10, 2015 at 04:14:08PM +0800, Koro Chen wrote:

> > > +	[0][0] =   { .creg = 0x020, .cshift =  0, .sreg = 0x020, .sshift = 10},
> > > +	[0][1] =   { .creg = 0x020, .cshift = 16, .sreg = 0x020, .sshift = 26},

> > It'd also be nice to have less magic numbers in the table, at least for
> > the indexes (which I guess correspond to some of the defines in the
> > headers)?

> With defines the above two lines would become something like:

> [0][0] = { .creg = AFE_CONN0, .cshift = CONN0_I00_O00_S, .sreg = AFE_CONN0, .sshift = CONN0_I00_O00_R },
> [0][1] = { .creg = AFE_CONN0, .cshift = CONN0_I00_O01_S, .sreg = AFE_CONN0, .sshift = CONN0_I00_O01_S },

> For the registers we could use defines, but I think using defines for
> the shifts doesn't add much value given they are only used once.

By indexes I actually meant the [0][0] and so on - they seem the more
magic bit.

--3CAnR4CLEnEWqRMR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVNWcNAAoJECTWi3JdVIfQWJQH/jaJOqXbcGyS2jBWSjHJsKu4
IoYzOs1j8P93OccaxiF22jNqjQLyYZ/CJRlwAPsKolPu57hReFklvzEbf/lbGZUf
08R3KrSUBvhwdGJWm5OXF3f8flaZ/v47XsU+KwDscbrGBEU4S1PDnfq7B0nvlfM/
4ZqaZPHtHMOgfo5aYi6zifkILLqf1vG2mOx1yiOrUx0jP3H/7WN7hSSUHZS10+HF
BdnWu/8CY3N0tel3oC5nMxp0Uh6Glx+CuGOPDR3O1ZwgLV96WytaZSj/TTfjqwbx
WozW9HJ8ETH6PNSOTWv3PfHwsXBAgtuIpDOnZxpl0l/aWFslWJ/K7Wi0Z9LamFE=
=aVHV
-----END PGP SIGNATURE-----

--3CAnR4CLEnEWqRMR--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
