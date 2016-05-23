From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [alsa-devel] [RFC-PATCH 0/2] ASoC: simple_card: support for
 hw-params rules
Date: Mon, 23 May 2016 20:02:18 +0100
Message-ID: <20160523190218.GE8206@sirena.org.uk>
References: <1463747445-14167-1-git-send-email-kernel@martin.sperl.org>
 <573F6279.8040008@metafoo.de>
 <20160523165931.GY8206@sirena.org.uk>
 <20160523171515.GI4976@leverpostej>
 <57434B61.2080705@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="V7LzxcfGKRikha15"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <57434B61.2080705-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--V7LzxcfGKRikha15
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 23, 2016 at 08:26:41PM +0200, Lars-Peter Clausen wrote:

> My opinion is that if the interdependence between the components in your
> system is non-trivial you should write a proper driver. Otherwise we'll end

Yes, I tend to agree - I've not looked at the actual patch yet but
there's a good, solid reason why we have explicit drivers for system
integration.  There is no value in pushing absoutely everything into DT,
at some point you just end up with something at least as complicated as
a real programming language with worse tooling.

> up with DT-script and replicate all the terrible things from the ACPI world
> where people ship completely horrendous and broken byte code in the firmware.

I think that's unfair, there are good solid reasons for having AML and
any interface is open to abuse.

--V7LzxcfGKRikha15
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXQ1O4AAoJECTWi3JdVIfQfNoH/3CNa8aN07SfoHb3qYhtbz1C
d/l4O5B6o9+qY0ml1HcQosM7UbQ/ymxsdYmaez8pM5FeQmqXBV2/T544KRuLWLL7
XfZPHdl/RbyoP9PVQDss07QMdX74XoWpqEJw2mu9gn41+T5xrlblsWYm4h24GITz
sbXocY8sFJyRcOuXRIAbtc3Q5ipleLNJ88pxS5UFQz3L8Sxu0JtCFqM2JPvU+1nh
3a0jLz5XC8eSWcfFwszXufVN48bYwPAEhGg2U2VW/ZPTZMk2Tne8/ms/Gy8iNoqi
S5snjwc/cGBOSRiKaut+G6j5TDV+kPEF14534mBFnhFiuVlJswusUKeAJKHNbFw=
=PL4P
-----END PGP SIGNATURE-----

--V7LzxcfGKRikha15--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
