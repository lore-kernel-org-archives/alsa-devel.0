From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 09/19] ASoC: tlv320aic31xx: Remove platform data
Date: Fri, 1 Dec 2017 13:26:06 +0000
Message-ID: <20171201132606.vyw7wthmql5trkwq@sirena.org.uk>
References: <20171129213300.20021-1-afd@ti.com>
 <20171129213300.20021-10-afd@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pbmekllj6q4ry7sm"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171129213300.20021-10-afd-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--pbmekllj6q4ry7sm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 29, 2017 at 03:32:50PM -0600, Andrew F. Davis wrote:
> Platform data is not used by anyone (at least in upstream) so
> drop this data and switch to using fwnode(DT/ACPI) only.

The advantage being...?  Not all architectures use DT or ACPI so it's
not clear that this is a step forwards in itself.

--pbmekllj6q4ry7sm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlohWG0ACgkQJNaLcl1U
h9B5lAf/VCJZ12gEhT3qQnSRuTmB/blB+tHjP8v0AWZ0ExLDKti6MbxgLZ0/wir2
7rGZNO3+JtU3zUIlJQlQlrl9rylFMOrWFLyA9a/xdfqMsBSBMEmDG5cDpBhk878I
iR3nwHFiRcvvaPa0cftZEZVpgQhHi5I6XaVYwMD5BuIKU5SM+vR9X8IuH/NPECW/
LxZ9II/Og1nSL61b3LrXdMfgsfiZgvQOUM+bwJ5u53EqjT21jkjPDDvHaPVVMino
DtABa98FW/Li2qEq/15oOoqwU1GH5d29hYr9FtjGIIqAdElC6GRWGT+/Qp7xOufu
KAefRfsCfLyB5bEOCTdgA2/dEQg+eA==
=wile
-----END PGP SIGNATURE-----

--pbmekllj6q4ry7sm--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
