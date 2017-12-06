From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 09/19] ASoC: tlv320aic31xx: Remove platform data
Date: Wed, 6 Dec 2017 18:15:34 +0000
Message-ID: <20171206181534.7t23ljja6fgle4ar@sirena.org.uk>
References: <20171129213300.20021-1-afd@ti.com>
 <20171129213300.20021-10-afd@ti.com>
 <20171201132606.vyw7wthmql5trkwq@sirena.org.uk>
 <4fee76ef-e518-69b6-3bcc-f65b0a31cacc@ti.com>
 <20171206124540.GC1827@finisterre>
 <10f1b19b-4a0a-e336-b757-933d46b5c8e9@ti.com>
 <20171206173059.qw4tt7nizmyo6xbl@sirena.org.uk>
 <b6f581be-6d3a-6fc3-036f-9efc1bfc2429@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sf73rz5ma6hcwrye"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <b6f581be-6d3a-6fc3-036f-9efc1bfc2429-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--sf73rz5ma6hcwrye
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 06, 2017 at 11:48:43AM -0600, Andrew F. Davis wrote:

> That would be unreasonable I agree, but it's also completely
> hypothetical, as again, there are no in-tree users and most platforms
> are DT/ACPI, so the odds of anyone needing it are next to nothing.

You're removing support for something someone might want to use for no
clear gain.  The bar for doing that needs to be higher than just random
cleanup, it needs to actively bring some benefit that justifies the
cost.  If something is sitting there not getting in the way and is
potentially going to be helpful for something in the future then there
needs to be a positive reason to take it away.

--sf73rz5ma6hcwrye
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlooM8YACgkQJNaLcl1U
h9C4KAf+J5EEWOHNBz6NQHyN5xIhKKKdokxv7MvQcXArxPCNpYcAy5TsezYyCE+Z
NfoQKN09GrVZXkuMN5fQCFxqizpD7EDRRwhiunuhmpAQcSRlQwdrivodBay8nfB3
g3E7bYbwaLliqGah2qpknTET3I43LhMlfPbp/OFPXx79CZhed+IWsHGII04aaOhK
P7LjIl2FRUlNO048q3kx1cxDktoP267URezQTJmFLi8sVqdOAcHMUHuSkXzU22vz
PHhVBXhIImlFsyAfEhC5rl6ns8pLhA9DzZl3i8f9nYDPvxDnwCcLIgPE7Kj3l0vZ
5gOTycA9QTZv4z6nmQp8wKNn7h6ITw==
=exOx
-----END PGP SIGNATURE-----

--sf73rz5ma6hcwrye--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
