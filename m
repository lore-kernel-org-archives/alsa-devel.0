From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 03/17] ASoC: tlv320aic31xx: Fix GPIO1 register definition
Date: Thu, 9 Nov 2017 12:45:28 +0000
Message-ID: <20171109124528.nadkkb76clg5lw2g@sirena.co.uk>
References: <20171109002741.10897-1-afd@ti.com>
 <20171109002741.10897-4-afd@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="skcqwcgyc7suyywf"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171109002741.10897-4-afd-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--skcqwcgyc7suyywf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 08, 2017 at 06:27:27PM -0600, Andrew F. Davis wrote:
> GPIO1 control register is number 51, fix this here.
>=20
> Fixes: bafcbfe429eb ("ASoC: tlv320aic31xx: Make the register values human=
 readable")
> Signed-off-by: Andrew F. Davis <afd-l0cyMroinI0@public.gmane.org>
> ---

We should send this as a bug fix to stable but this depends on your
reformatting :(

--skcqwcgyc7suyywf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAloETecACgkQJNaLcl1U
h9A+rAf/YJrzWkLUK+YJV6i4vuGl7PxQFxJ3Zf9UmB3K9m8x9UdT7wzEATLoCRPi
xGd/o0PV/nGSBuOqlOcXbTYaV0MU83D5A+TqHpfQbgkkIWY9l6jH2svWSWVa929Z
W8QkPVI38WaYfssw05RMqd+/LEBPzK6rJZd8WiQJPL7YxI0rOve3vRr0xVyMPUCl
GJKF/WddCfP0+4sA4wtQwzBHDe8n6QMWnadwYhZ3SuLYLw77bY+R+rpYrJ58+IaV
JPQ5sVj2MphXVkQHvPejYtQ06u0VlnC7B41x8zQvekwJbXYhPP5dGXKdwzZOiCyu
I2+eHQQSsjqI01Biy8wIirL6iwMH9A==
=Fqxi
-----END PGP SIGNATURE-----

--skcqwcgyc7suyywf--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
