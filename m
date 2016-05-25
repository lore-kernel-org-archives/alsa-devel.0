From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6] ASoC: cs53l30: Add codec driver support for Cirrus
 CS53L30
Date: Wed, 25 May 2016 19:16:03 +0100
Message-ID: <20160525181603.GD8206@sirena.org.uk>
References: <1464045237-4074-1-git-send-email-nicoleotsuka@gmail.com>
 <20160525172800.GB3056@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1iEpPD5yDbvq0asf"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160525172800.GB3056@rob-hp-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, brian.austin@cirrus.com, Paul.Handrigan@cirrus.com, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, lgirdwood@gmail.com, Tim.Howe@cirrus.com, somduttar@nvidia.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--1iEpPD5yDbvq0asf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 25, 2016 at 12:28:00PM -0500, Rob Herring wrote:
> On Mon, May 23, 2016 at 04:13:57PM -0700, Nicolin Chen wrote:

> > +  - VA-supply, VP-supply : power supplies for the device,
> > +    as covered in Documentation/devicetree/bindings/regulator/regulato=
r.txt.

> Also, these are missing from the example yet are required. I'd argue=20
> they should be optional as you could have designs with no regulator=20
> control.

The general rule is that regulators should only be omitted if they are
physically absent, we can describe simple fixed supplies with no control
so we should do so (though in practice Linux is much more forgiving and
will provide one if the supply is just plain missing from the DT).  This
is a simpler rule for people to follow than making them officially
optional and is more robust in the face of things like implementation
changes that allow supplies to become controlable or drivers that
suddenly form a desire to look at their supply voltages, as well as
allowing other OSs to have simpler implementations if it's followed.

--1iEpPD5yDbvq0asf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXRevhAAoJECTWi3JdVIfQMSMIAIGqGM0uxZ6U4J4rOgEChwTI
HdwfDIMSCWxaM15j4HAAaW9G1H3VINciYveHSBe8NU+skRwW1M0CGu5A593yZ1cZ
E2NW+8QeYCs9dPOISLmjWyIxrAV6TBu3x4v2zjiRpkLd0WcNS6HOcSActrb7Ky2C
WFfuXrfj/SCOBMexcBmesg7E65gsjdDkB4UVtv69glWsvcb2nf5KeTGNPEVki9qW
WVj9/blu3y8K0pW5vXSNjbS31dJe0iKCa7qGL665Vj4AgqXyOX7+ksZ6B4OPdjD7
1vi+OMQjmD3x9jf4CgJ3UoKZOjtzZ6zAPlP/NIpxvwc11FxqVb3r6ar7utn8SXI=
=PpaN
-----END PGP SIGNATURE-----

--1iEpPD5yDbvq0asf--
