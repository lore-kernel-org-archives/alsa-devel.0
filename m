From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 8/9] ASoC: tlv320aic31xx: Fix the reset GPIO OF name
Date: Wed, 8 Nov 2017 22:18:14 +0000
Message-ID: <20171108221814.m6j3dgrlqpy4htxf@sirena.co.uk>
References: <20171108212505.28320-1-afd@ti.com>
 <20171108212505.28320-9-afd@ti.com>
 <20171108213639.iymb7wuyjpuirbdu@sirena.co.uk>
 <80169c43-ad7f-d89c-61bf-5ca054aacda5@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7d2ntdd63qtrknrn"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <80169c43-ad7f-d89c-61bf-5ca054aacda5-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--7d2ntdd63qtrknrn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 08, 2017 at 03:53:51PM -0600, Andrew F. Davis wrote:
> On 11/08/2017 03:36 PM, Mark Brown wrote:
> > On Wed, Nov 08, 2017 at 03:25:04PM -0600, Andrew F. Davis wrote:

> > This is obviously an incompatible change in the binding which will break
> > any production DTs relying on the current behaviour.  You need to keep
> > support for the existing property.

> I understand the reasons not to change driver behavior wrt DT, but this
> driver did not make functional use of this gpio, only going forward will
> this gpio be used for actually reseting the device (in some patches I
> will post soon). So I would like to fix this incorrect binding *before*
> fixing it will cause behavior incompatibilities.

There is code in the driver to use the GPIO, including in the probe
where the GPIO is requested and set to high (which will bring it out of
reset if the default state was low).  At least the probe seems rather
likely to have a concrete effect.

> > It also doesn't look like a good fix if we're aiming for conformance
> > with DT naming conventions as unless things changed all GPIO related
> > properties are supposed to end -gpios even if they can only ever specify
> > a single GPIO.

> If that is the new standard I can fix this patch to use -gpios.

It's always been the standard AFAIK.

--7d2ntdd63qtrknrn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAloDgqUACgkQJNaLcl1U
h9CSOAf+Ir4pnlEIWea9MYuR24yOMUTcHTIKLFsKZpRlKpMA99Db30FPRtHIAzIw
/wZJjbDgBz1jPoCN0x2h9GEKcIlZzckNgNxPTSMYL/6PwT1Un8O+QDXWSYAnCkf+
6xji1obTMx40KiQLcBRVl/Wiws5mj5JXIMEL5qdHTAbNGnOUk77pgtuP4s2icX4n
WyOXuDPZ+rTrs+nRqv/iv93a5GE/HARrKUCgyeyXgyhdUd56YUczBi2T2/RpdJZX
FYBIYQ+gVJETJWOkKGbrge79bLcq/QFQlk1l4XSH53rs0SadxIORq6zDaIrHPbKb
MxuDE1AzWsBeIjDqB6BBHoMIfE+hrw==
=GnA0
-----END PGP SIGNATURE-----

--7d2ntdd63qtrknrn--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
