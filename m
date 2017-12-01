From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 18/19] ASoC: tlv320aic31xx: Add headphone/headset
 detection
Date: Fri, 1 Dec 2017 13:41:27 +0000
Message-ID: <20171201134127.2msgmjrfj47ypl3w@sirena.org.uk>
References: <20171129213300.20021-1-afd@ti.com>
 <20171129213300.20021-19-afd@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4qvvzcstbefwku4o"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171129213300.20021-19-afd-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--4qvvzcstbefwku4o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2017 at 03:32:59PM -0600, Andrew F. Davis wrote:
> This device can detect the insertion/removal of headphones and headsets.
> Enable reporting this status by enabling this interrupt and forwarding
> this to upper-layers if a jack has been defined.
>=20
> This jack definition and the resulting operation from a jack detection
> event must currently be defined by sound card platform code until CODEC
> outputs to jack mappings can be defined generically.

This only does half the job, there's no way for anything to specify a
jack here.

--4qvvzcstbefwku4o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlohXAYACgkQJNaLcl1U
h9Dklwf/RSM3QE9jlbFVebFEu6XP7NKawKDxgqAr0t2QcuTXF3jY9c0jnqBtORDO
ACAql/kM+xjQlNpAiBxohoQgO6bOZLpJHqWgDCa1Zx90706NHwkR+Bono14rIuyN
9QtDH0uW4bn/E8ksVPPb6nG0tmFBOOekwv02jMgGLd/pA9ZakpiFlQPcVMfw0xVr
bmnU0OmjFPOlaQxHjUs5BzNBn42mLbbhkToBdU+5CFo9NsbGWnVKdHfqls0ZP1FX
ZPe/YEIrkaekuLIEwVwPorDsEi29ZQp+lMeTM82NM+rzn1oz/52/PB/pRMptSs38
NOeSz3BM9BRGu4DaJOThZ/imb8sD4Q==
=A3Px
-----END PGP SIGNATURE-----

--4qvvzcstbefwku4o--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
