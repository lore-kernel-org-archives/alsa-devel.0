From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 14/19] ASoC: tlv320aic31xx: Remove regulator
 notification handling
Date: Fri, 1 Dec 2017 13:36:04 +0000
Message-ID: <20171201133604.6v3ychahwvlaygxi@sirena.org.uk>
References: <20171129213300.20021-1-afd@ti.com>
 <20171129213300.20021-15-afd@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zz655pgq72ejmwat"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171129213300.20021-15-afd@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--zz655pgq72ejmwat
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 29, 2017 at 03:32:55PM -0600, Andrew F. Davis wrote:
> A regulator being forcefully disabled is a catastrophic event that
> should never happen to most devices, especially not sound CODECs.

That's not what the disable notification handling is for.  It's there so
that the driver can skip having to reinitialize the device if other
constraints mean the power doesn't actually get turned off when it
disables the regualtors.  It's nothing to do with forced disables.

--zz655pgq72ejmwat
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlohWsQACgkQJNaLcl1U
h9DHDQf/VJYgtZiBK2kVZU7Zukf0jPk5LRA7vtaWoMEXx+JASmoxUbx9TdXxqZ8g
ri4Y+8Lpd4/K2I2kaEOwAqkly9MgCZ6IgIKNAXkAsXT94Nv8JfwO2MOarx0gCBOx
v3YKanLrKDeW5B3q4o2Dh/Hoi9UOuwwrSMKHuNgWThoYUk9VUGCaRdtfu1WwATaz
Y3WdosUYRhJW8bogCyny1+XqinjmijhsVZguLaOG68fPcGI4dY8VO0HLHbIKs5Ru
Z4M/HI3fR18s3bz3JfhjV1ZbmtP/C6+6ekX8E+SbmNSaSRlB6r8HaZYni/GVcfkC
i/biP0ibPe0Blyh42neDmDDXK5BpHA==
=/q7x
-----END PGP SIGNATURE-----

--zz655pgq72ejmwat--
