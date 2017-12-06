From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 09/19] ASoC: tlv320aic31xx: Remove platform data
Date: Wed, 6 Dec 2017 17:30:59 +0000
Message-ID: <20171206173059.qw4tt7nizmyo6xbl@sirena.org.uk>
References: <20171129213300.20021-1-afd@ti.com>
 <20171129213300.20021-10-afd@ti.com>
 <20171201132606.vyw7wthmql5trkwq@sirena.org.uk>
 <4fee76ef-e518-69b6-3bcc-f65b0a31cacc@ti.com>
 <20171206124540.GC1827@finisterre>
 <10f1b19b-4a0a-e336-b757-933d46b5c8e9@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="o7ev3g3plen6snoe"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <10f1b19b-4a0a-e336-b757-933d46b5c8e9-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--o7ev3g3plen6snoe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 06, 2017 at 10:19:28AM -0600, Andrew F. Davis wrote:
> On 12/06/2017 06:45 AM, Mark Brown wrote:

> > Then if you want to upstream the driver you'll have to add the platform
> > data support again.  Like I say not all architectures have anything
> > other than board files.

> Then they can try, but they will rightfully get nack'd and told to stop
> using board files and use DT/ACPI. Most upstream architectures don't use
> board files anymore anyway, so I doubt this will ever happen.

No.  To repeat, not all architectures use DT or ACPI.  Expecting someone
to impelement DT or ACPI support for an entire architecture and try to
bring the ecosystem for that architecture along in order to add machine
support is obviously totally unreasonable.

--o7ev3g3plen6snoe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlooKVIACgkQJNaLcl1U
h9DHHgf/dcFEwPjSXOiuiAmEK1h6J/o49iNbWu9oqixhlyJSvovutr4Oe7+Q7CWd
Wib+Pvk5fL7OzKn/TOBuIPPdqv0vRg/flTx9wKNRtXYeM0v5vFMGfy+r4cf6ABfv
PXpHeDktWrD5wX//TQpHWWFr8041jtZRIWi7oFSP5m3pEUO55vnn4J/v8sEsOmLh
XCWthc9tZntlFVsffXwDs2NwkfyYLUcrbXB6faPDaJI5IAfeUvkGuf6hxUiEfvf0
iEqEzf5ANOK1Oaoujo/Ek4B8cadM7iHj2u7cpTjh3KrVFuw651gzJjUNvLh8gH1g
LOm+sly/6DwcL3ljCbem/eL/03JPNQ==
=uq3M
-----END PGP SIGNATURE-----

--o7ev3g3plen6snoe--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
