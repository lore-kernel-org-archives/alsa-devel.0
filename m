From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 10/19] ASoC: tlv320aic31xx: Add MICBIAS off setting
Date: Fri, 1 Dec 2017 13:30:28 +0000
Message-ID: <20171201133028.svemo5qedyfqrt7y@sirena.org.uk>
References: <20171129213300.20021-1-afd@ti.com>
 <20171129213300.20021-11-afd@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3u3da4kf5tad5zv2"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171129213300.20021-11-afd-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--3u3da4kf5tad5zv2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 29, 2017 at 03:32:51PM -0600, Andrew F. Davis wrote:
> Leaving microphone bias off is a valid setting and even used in the DT
> binding document example. Add this setting here and document the same.

>  - ai31xx-micbias-vg - MicBias Voltage setting
> +        0 or MICBIAS_OFF - MICBIAS output is powered off
>          1 or MICBIAS_2_0V - MICBIAS output is powered to 2.0V
>          2 or MICBIAS_2_5V - MICBIAS output is powered to 2.5V
>          3 or MICBIAS_AVDD - MICBIAS output is connected to AVDD

This doesn't make much sense.  If we enable the microphone with a
voltage of 0V that's not going to work terribly well - I'd expect this
property to control the voltage set when it's enabled, not if it's
enabled.

--3u3da4kf5tad5zv2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlohWXMACgkQJNaLcl1U
h9BmiQf8CWrRSWJbECiDWRHQKvcTz29h4qoSKMxIGJFgkEtoPQ2fe5pJ0M+o46OE
czxWVOdpsSzQp2P3BdlPSpRxkSBLW3OdjxTPgd+UyOtTnYzJHAEh2FWApNa+FOut
ywqVoFh8bcd3D2IJUGmlsBle+2KhXlT4rkRKie4M/6AXSHgxwEIFvVEqRnHLA3Mb
qXIveiDWRi/vjhZCEajlMSyhfzIsMLWomslNXIL1h9RZwhK9BJ4XRkDHKsrFD34e
ZBYe8Rxy+5e56YrILOhyFUkwFs/wB7o2/IQEbINtMVKYTaJeFYS4GJieCMNePCWA
xxH3Mqb/cOINddtP++ecZXNvtzCsQA==
=M0+j
-----END PGP SIGNATURE-----

--3u3da4kf5tad5zv2--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
