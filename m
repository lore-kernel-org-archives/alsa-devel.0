From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v5 1/4] ASoC: tlv320aic32x4: Support for master clock
Date: Wed, 19 Feb 2014 12:54:06 +0900
Message-ID: <20140219035406.GP2669@sirena.org.uk>
References: <1392575252-9222-1-git-send-email-mpa@pengutronix.de>
 <1392631460-32002-1-git-send-email-mpa@pengutronix.de>
 <1392631460-32002-2-git-send-email-mpa@pengutronix.de>
 <20140218012329.GR2669@sirena.org.uk>
 <20140218204646.GB10590@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3m6VNgM56Nljn+Yv"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140218204646.GB10590-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--3m6VNgM56Nljn+Yv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 09:46:46PM +0100, Markus Pargmann wrote:
> On Tue, Feb 18, 2014 at 10:23:29AM +0900, Mark Brown wrote:

> > Looking at the code the clock isn't physically optional, why not make it
> > mandatory?  There's only one mainline user, it looks like it should be
> > straightforward to update with a fixed clock.

> The masterclock is physically optional. There are several modes to use
> this codec without master clock. The PLL can use different clock inputs,
> BCLK, MCLK, etc. and even the PLL is not necessary. Instead BCLK and so
> on can be used as direct codec clock input. However, most of this is not
> supported by the driver yet and I can't test these cases.

Are any of these modes supported by the driver yet?  If there's modes
that don't use MCLK supported then I'd expect them to only enable MCLK
if it's actively being used in the current configuration (triggered via
set_sysclk()).

--3m6VNgM56Nljn+Yv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTBCrbAAoJELSic+t+oim9M/cP/i1Kg/KU66DlCHJpcmHmlGLr
Pw+uH5nZc6YgnO/b7A9GEhPQsby7DPxXeBdlbFMIo3U+mQOUbG7PhIvDCajIL1vc
hvVJmmlCbrVlBTuaVmy8YIl1SmYkmqHYp3WvD8hQ27tZo16zeBAnkWBMBU1f+T9D
MZ5kZlLgaSwfZjLhGhvtVpBkbT698dqUO+VuQHOucSzkYzkU2TzxwYyCKSoTSnJM
+st7OxqBnHNUdm4q/aNYqyKnlrLx1erVk+7jxgv63CHsDrHsx3kJAn4fCViU4owP
K6IMlasFMnGTwqAHPVS8rIpDADUJF9JAPTNsesi2mHOdR1AVd4kpW0M33+C661yg
M1nQlZ+sSQKKs3FyQIGujJ0vh04fkfKUo8lakhtn3PQway0MAzfv9qvFNqTuf1WB
tjHH4zbNJWYlu09aoY+yQWcvlmxIMf5a16eVK5vOI8D1C99INp775m+Cd+GB7xXV
TglUpx7guJZMjHsHaf7UPE/WF8AXg1SMOWpM8UaEsWdTEYBDzPi1Y4BgnfHhgZuK
TIyjvZACo8lNOY/XfVFlYMCwltm2DG0VKn6dcA3T/dZpcA386B9DqwgjsGaoridn
fQNhcNXzQ4sJR5eAVXTHf0g/m2N3fN24Pq2K+9XEGaWX5dPWh+VZLT8cFYK1rsXs
dGkIEa5AnuwGYZNKJW8J
=+LIA
-----END PGP SIGNATURE-----

--3m6VNgM56Nljn+Yv--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
