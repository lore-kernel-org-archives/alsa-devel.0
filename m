From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] ASoC: generic: Add generic DT based simple codec
Date: Thu, 19 Sep 2013 19:12:03 +0100
Message-ID: <20130919181203.GI21013@sirena.org.uk>
References: <20130919105437.75e0f0a3@armhf>
 <20130919104028.GI21013@sirena.org.uk>
 <20130919193403.30ac5764@armhf>
 <20130919174952.GC12758@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yEBrs0e8Ns0RDnuy"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130919174952.GC12758-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--yEBrs0e8Ns0RDnuy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 19, 2013 at 06:49:52PM +0100, Russell King - ARM Linux wrote:
> On Thu, Sep 19, 2013 at 07:34:03PM +0200, Jean-Francois Moine wrote:
> > Otherwise, for Dove, we need at least "s16_le", "s24_le" and "s32_le"
> > and, perhaps, "iec958_subframe_le" and "iec958_subframe_be".

> The audio block can't do IEC958 subframes in the format ALSA wants
> them.  The hardware format is different.  I've sent a commit removing
> these foramts from sound/soc/kirkwood with a full explanation.  Mark
> seems not to have merged even that one though.

It's there in -next, it missed the merge window - there's no DAI in
mainline yet that would allow those formats anyway.

--yEBrs0e8Ns0RDnuy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSOz5wAAoJELSic+t+oim9TjYQAINkQVgfl/mCfZdoPPkXAB5E
guctEP5NecyaRjh9VrKt2x206n6Ika1K6Ydz8xfBhs8zFwRTdt5MiF/F6/hBXn0z
X79rOm8m8zOfFCXkEjtUl9+H4ni7aOwhenKEbTh5zpgXqqOWL5ZRtosywv12W0hp
mnWEn2DQv3Xxl7y5uYa0FrJSEjIZcIWDVsqDav7OGjfp/bcSCTwAU3v5CQIw1zJC
bjbj2BkuolnHjSWttrTyqlM08YO6/dITqjWy+stRFmOCp6GRZxdrmbmz1EJHvI+e
THL+Lja42W5gpOWFCSvaI8/vVHnpahqvGmiacrJuhuAr+wYibe+sdc7ymc4BgnX5
TIkv6nRYo9NCkITP77lyMgPX7dTBy+DMLz6RtkunGgVLiFj2xuSjOvzaXkgQSQb1
XabIvexWf4O3Qbj5aISM2z/3dwrAdNOTzU22S9FDZ1aJh/w1q86A1g8KYFD6EIKU
gqJSdC0m1cwD21JVumFh+QG7PG92USSC7LYmstccDivaTA51DTeWE8ti/0Rwqa6v
GYwaACps9ZvxOT4kzza+MYyt2eTprVfCyjJRmV4u8x/lBzV1HmlQsrB7sPB3p0e3
GjJoy3tzEyGM4UJBGRF/7EgN8cxe3zyDZ9A7VdAZeSZaOYr407g3kamurnuoHep8
UVB9srdU1pJVYlRYWmBm
=rlLS
-----END PGP SIGNATURE-----

--yEBrs0e8Ns0RDnuy--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
