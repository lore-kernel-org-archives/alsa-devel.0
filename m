From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v5 1/4] ASoC: tlv320aic32x4: Support for master clock
Date: Thu, 20 Feb 2014 20:47:49 +0900
Message-ID: <20140220114749.GD2669@sirena.org.uk>
References: <1392575252-9222-1-git-send-email-mpa@pengutronix.de>
 <1392631460-32002-1-git-send-email-mpa@pengutronix.de>
 <1392631460-32002-2-git-send-email-mpa@pengutronix.de>
 <20140218012329.GR2669@sirena.org.uk>
 <20140218204646.GB10590@pengutronix.de>
 <20140219035406.GP2669@sirena.org.uk>
 <20140220113749.GB16727@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5Y6yyRKXBtz3ep6u"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140220113749.GB16727-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--5Y6yyRKXBtz3ep6u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 20, 2014 at 12:37:49PM +0100, Markus Pargmann wrote:

> It seems none of these modes are supported yet. aic32x4_hw_params setups
> the clock tree relying on a master clock to be used for the PLL.
> Otherwise hw_params fails. So currently mclk is not optional for the
> driver. But it is still optional for the real hardware.

> What do you think about declaring the mclk as optional property in the
> DT bindings documentation but to handle it as a required clock in the
> driver?

That's fine, makes sense.

--5Y6yyRKXBtz3ep6u
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTBetiAAoJELSic+t+oim9q3kP/23Y9mhvviVYhLMR0KqovX1M
KRiUQG16/2CaKB4AB6nTHBa0oaWYZAIuffmFy57grwoamQpo+5VPEVN6czydZpmC
+vK034bk3mDNgCRzLMMgordIHfYEV7KUDdz1SAQExSP/N8RFg8h+JZCLza414aCG
NUYM9HWGWfyG4lqiUI/g6n0YocjmvNnYB3umbwMKw/74+q3QxFonw1SUPFYFFVOx
zC731yI0dMudpZ8ER5OJx9vLTttcgshm8+ULAobUCvGqCGLwbILLREoDz+PHSwcz
m95YEqfwwNakepioo6tpCt8xTlNZAGojULB7FU1SWBtWWT6YS0OScmBpVjN6NT+A
hmXHslYUbJoq2u7o2W46joKxBF92htISca+93xWXbiqb09gEpn0vo7deiEwj8XOu
wp49/Pk/jI4no03NZu2RaKndZ/s8JtbHzbTgVD5Cmw7/JP5AwGD07EBSG6ICRfaV
RWDPXO3cVjvB8YWpa9E0+9CcCwe6guN2DwPvIi/TZd5hlYCeKonnQD7PYBf2D/iu
SHVxWX0xwNG4w2qK1A8aly+YOBQHiuwoQdRxs8LyDXVGukNnfhzWVBJCn7Dvhivi
+0WWTg0/sU0hLFieBV3sWlbEVwIHp0rN3vW8Z2bInTmPqQu+j8MIboMUaL4IjCHF
2Ky20F8Efy+20eS8MIlt
=HxYV
-----END PGP SIGNATURE-----

--5Y6yyRKXBtz3ep6u--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
