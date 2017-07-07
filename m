From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 8/9] ASoC: atmel-classd: remove aclk clock
Date: Fri, 7 Jul 2017 13:44:32 +0100
Message-ID: <20170707124432.b5h2ugtxsz3zqysx@sirena.org.uk>
References: <20170704115927.32662-1-quentin.schulz@free-electrons.com>
 <20170704115927.32662-9-quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="exdyu7fmnfly6tbs"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170704115927.32662-9-quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, cyrille.pitchen-yU5RGvR974pGWvitb5QawA@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--exdyu7fmnfly6tbs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 04, 2017 at 01:59:26PM +0200, Quentin Schulz wrote:
> Since gclk (generated-clk) is now able to determine the rate of the
> audio_pll, there is no need for classd to have a direct phandle to the
> audio_pll while already having a phandle to gclk.

Acked-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

--exdyu7fmnfly6tbs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAllfgi8ACgkQJNaLcl1U
h9DzAQf/dC3hmT2cJGuO5WN2WUEdJi8i15jUGACz08lH+qnyfGQ2vIaHDa7Gk2Ro
kZLHscJuR5tzN5xi16pUGAH2klyPaOQdVpNVXv+wzxvOsVKxsB0woKIVaFo/DhmM
y8HfO6l6J09CReewm4Ij2LzXNJy+gz9lh4GYzfWnqtqjPcns1KBEmYhmAZtvX8lh
/7Q6oZ9yeBJY3xWORvD8zv/vxof39ZbdXpRd1zb/7HYDQYnhoJlRPkn/1KtyWmAG
1lJ1+r6Ao1DEYdfwDB3jvxdtdg8zD7H0ggRyPw9fpcwSzfBUEIzFr/7Y3hrlNfus
nTT5B70tS9bBhc1bZ89tgaHoWT4yWQ==
=4O/E
-----END PGP SIGNATURE-----

--exdyu7fmnfly6tbs--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
