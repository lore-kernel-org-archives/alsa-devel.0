From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 8/9] ASoC: tlv320aic31xx: Fix the reset GPIO OF name
Date: Wed, 8 Nov 2017 21:36:39 +0000
Message-ID: <20171108213639.iymb7wuyjpuirbdu@sirena.co.uk>
References: <20171108212505.28320-1-afd@ti.com>
 <20171108212505.28320-9-afd@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="da2whi6s6moxbdfk"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171108212505.28320-9-afd-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--da2whi6s6moxbdfk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 08, 2017 at 03:25:04PM -0600, Andrew F. Davis wrote:

> -	ret = of_get_named_gpio(np, "gpio-reset", 0);
> +	ret = of_get_named_gpio(np, "reset-gpio", 0);

This is obviously an incompatible change in the binding which will break
any production DTs relying on the current behaviour.  You need to keep
support for the existing property.

It also doesn't look like a good fix if we're aiming for conformance
with DT naming conventions as unless things changed all GPIO related
properties are supposed to end -gpios even if they can only ever specify
a single GPIO.

--da2whi6s6moxbdfk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAloDeOcACgkQJNaLcl1U
h9AFewf5ASk4x+ieP4b/HvYCDyYdfSFIOn2fdmQ23uW5Zir/IjLxodbkXaBfh18c
jJ9FCNWB4cyRtfEErbbinhVuHm83gQvojLZkq1qFOvWiFgFrk42HA4YLi8CtBsXg
bnNYNyG6gwmmr48ureC2ocGo/V0u7OerKL+1qt9F9Uk2vu6mAVeN09U1p4m3SmIu
LfsYvKrrBgrwJRdvYoXHP8rxgWe5j6MAIxU343oVMfjPTFIskkWVo4IyN+h9s8SU
3sBjr7lWYTyVH6TK9SrvhOFiUKN6M/IRm4D4Y1R8+SjuMZUcwNcfSFNPzmKz6Q/h
twDoj/eHNVQBm6jsszKTyTtA6VwGpA==
=xKdq
-----END PGP SIGNATURE-----

--da2whi6s6moxbdfk--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
