From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 8/9] ASoC: tlv320aic31xx: Fix the reset GPIO OF name
Date: Thu, 9 Nov 2017 13:22:06 +0000
Message-ID: <20171109132206.bo755bq3px6desax@sirena.co.uk>
References: <20171108212505.28320-1-afd@ti.com>
 <20171108212505.28320-9-afd@ti.com>
 <20171108213639.iymb7wuyjpuirbdu@sirena.co.uk>
 <80169c43-ad7f-d89c-61bf-5ca054aacda5@ti.com>
 <20171108221814.m6j3dgrlqpy4htxf@sirena.co.uk>
 <1374534b-ac17-82ef-7b3b-3c6e4d4c5cc9@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6d23stdrzi5nmm3x"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1374534b-ac17-82ef-7b3b-3c6e4d4c5cc9-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--6d23stdrzi5nmm3x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 08, 2017 at 05:25:20PM -0600, Andrew F. Davis wrote:
> On 11/08/2017 04:18 PM, Mark Brown wrote:

> > There is code in the driver to use the GPIO, including in the probe
> > where the GPIO is requested and set to high (which will bring it out of
> > reset if the default state was low).  At least the probe seems rather
> > likely to have a concrete effect.

> None of the 4 boards that defined this gpio have this pulled low in the
> pin control, boards should have an external pull-up on the reset line.

None of the boards in mainline...

> At any-rate, I'm pushing this fix to allow the driver to use new kernel
> frameworks that depend on the correct binding being used. This is not a
> case of a badly designed binding or trying to add incompatible
> functionality, it is a typo fix. If we have to keep this driver back
> using old frameworks and needlessly bloat the code solely for the sake
> of compatibility with a typo, then DT "stability" here is causing more
> issues than it solves. </rant>

This isn't a typographical error, that'd be a spelling mistake or
something.

> I guess the alternative would be to have of_find_gpio() also consider
> prefixing, the 'gpio_suffixes' to 'con_id' and checking for those. That
> is rather ugly and probably encourages the spread of this bad binding
> property, but whatever the best fix is it cannot be to force bloat into
> the driver.

Another option is to add an interface for telling the DT code about
renaming properties then the core code can do the fallback transparently
to the upper layers (when asked for X if it's not there then try the
legacy name Y).

--6d23stdrzi5nmm3x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAloEVn0ACgkQJNaLcl1U
h9DGLAf+LQZhbKeaFQldoLGys4Unvs5+M8qB5iKKeb/H9NmsoqUdHK8WRP9HY1n+
duZ6ohqdbzZ+OmI+f28x7qKONkZ/VVsCZGBypqMStXMkG5HUWv51NNh2HTUwCtJ8
snb3EUuk+yY2WjXhVqK0WehVnNhyjIaUdXOFPJCXJ46HeCd7TrW3pN2jfAY8YGda
AD8TInruS7dQr5pt1+gyXX+wxnZcj1elpbbDaLkaw29WG1Zv1TqM+I2jf5PwNTTC
hRCA7aw/KDJcL1/cAOKFCcuciAMzZOcya3WgabuBX0QUQaIefpad/aNsEtV3+Xtc
d3DdfKTuZKFMLB+YXZlXV4I8mfszLA==
=Y6V7
-----END PGP SIGNATURE-----

--6d23stdrzi5nmm3x--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
