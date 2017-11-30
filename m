From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 5/8] ARM: dts: am335x-pepper: Fix the audio CODEC's
 reset pin
Date: Thu, 30 Nov 2017 16:33:44 +0000
Message-ID: <20171130163344.kudopvsljywb4hyw@sirena.org.uk>
References: <20171129171359.29382-1-afd@ti.com>
 <20171129171359.29382-6-afd@ti.com>
 <20171130161826.GP28152@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kwgqqqwuee32e2oo"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171130161826.GP28152-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--kwgqqqwuee32e2oo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 30, 2017 at 08:18:26AM -0800, Tony Lindgren wrote:

> So it seems this and patch 8/8 are safe for me to pick separately?

It might make sense to pull in the relevant branches from ASoC first
however IIRC the reset GPIO code currently does nothing useful anyway so
it won't have any impact on bisection.  Andrew?

--kwgqqqwuee32e2oo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlogMucACgkQJNaLcl1U
h9BIswf/bF+EmdJGcT8C6UfAqqxpPjFh4g/bovqhUA/Ka7devJCUsCp354VuU/Ij
LfvpoxYc+cPJqXP1LJ3XlCTnSm8qZzgpxCwjskilDNRgHRaKUR5sHzs5OvFR6I1p
u10+JHGtb/nqDeiE6DsWAufzg+5hTLxGFgjamEPKJa1qL6pZpKFM2zlnrxUOfIHr
ykUpdVZ+/i3KgiVXYqgm6kn7A8A4qfGZYU0DAUXhvyBcenEYXqU9rSgogsEqMI2x
NIqzxPsP2bAd9ixvCGxAbfHkzwwJul9FLiu51YPOHAZfkSHnh6BCv3YeO9eGA+Ge
hm20RpFN4J38pk3a37mtBGatcSTNhA==
=wQhX
-----END PGP SIGNATURE-----

--kwgqqqwuee32e2oo--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
