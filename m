From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/8] ASoC: tlv320aic31xx: Fix typo in DT binding
 documentation
Date: Thu, 30 Nov 2017 11:43:32 +0000
Message-ID: <20171130114332.decoq4b5zrth3r6c@sirena.org.uk>
References: <20171129171359.29382-1-afd@ti.com>
 <20171129171359.29382-2-afd@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hvcqbqcmhfxn7e3r"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171129171359.29382-2-afd-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--hvcqbqcmhfxn7e3r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 29, 2017 at 11:13:52AM -0600, Andrew F. Davis wrote:
> The property used to specify a GPIO intended for reset is "reset-gpios",
> this binding uses "gpio-reset", as almost all other bindings use the
> former name this use of the latter was certainly not intended. It is not
> compatible with newer methods used to fetch GPIO pins and to prevent the
> spread of this error to other bindings lets fix this here.

When you say you're fixing a typo I'm looking for a fix for something
like two letters being transposed.  This isn't that, it's a completely
different property name.

--hvcqbqcmhfxn7e3r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlof7uQACgkQJNaLcl1U
h9CvIwf/YadZJ2lET+uHIGa9oIZOifvUb+/z0OS5gg72gDEZ50Xx2+FN7EIMd8YB
MR+GnteSzxbHS2BZl8OGquD9TaHZuZj4r26NNoQehgwxzC9f53CnciLF7eDjEOEz
TSHdH3qdXTMcJZUmlu3Xg8SfslRnRF+unb29rcp6yjyi5rGINLgGKZDvwPL/J3zZ
tB5t9tPiPmxIcPrTFUB0AGKRjIiQWrlNDqEFlfXC2HgyDC/dUYLQjHKir52G2bpJ
K1kZX/nx12S2310bH1QIk3jgJeRL7mCQi2D2sVgQ7+YTFeVqkTZ2SIe7zsA+b/iA
wfw7Hp3fjYbaX3Ldr02191xZf8Qvuw==
=rxS3
-----END PGP SIGNATURE-----

--hvcqbqcmhfxn7e3r--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
