From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] sound/soc/codecs/tas5720.c: add ACPI support
Date: Fri, 28 Jun 2019 15:30:37 +0100
Message-ID: <20190628143037.GH5379@sirena.org.uk>
References: <20190628123416.16298-1-nikolaus.voss@loewensteinmedical.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TBNym+cBXeFsS4Vs"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190628123416.16298-1-nikolaus.voss@loewensteinmedical.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Andreas Dannenberg <dannenberg@ti.com>, "Andrew F. Davis" <afd@ti.com>, Kate Stewart <kstewart@linuxfoundation.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, nv@vosn.de
List-Id: alsa-devel@alsa-project.org


--TBNym+cBXeFsS4Vs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 28, 2019 at 02:34:16PM +0200, Nikolaus Voss wrote:
> Add support for ACPI enumeration for tas5720 and tas5722.
> Use device_match API to unify access to driver data for DT and ACPI.
> Aggregate variant stuff into its own struct and directly reference
> it in variant data for i2c/of/acpi_device_id.

Please use subject lines matching the style for the subsystem.  This
makes it easier for people to identify relevant patches.

There's a huge amount of refactoring in here as well as the enumeration
changes, please split this up into a patch series as covered in
submitting-patches.rst for review.

--TBNym+cBXeFsS4Vs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0WJIwACgkQJNaLcl1U
h9Bvewf+JKdAlitakvrWEvLfVQ1ffjq8q2owD1IJsFcSFOLRl7mlZG1Hoq03PBBZ
lpYSKn/+9tbAlpNf6WYSCaNX9zvzGX0CJoHuOkVEap6zPFkWlYTqg8AlqEuFhM3c
di65cqFmifwWxkbRgHnl05I9cJXwCnm49Jkdd3dyNMpBhVtCVVk6W8NRt87/ODpR
b1iYRsLgSODnRju4Bs7H9NRmUhcNm8u0UFuV/WYfJLQB26Gsw9OrzBtvrjOssLOj
94HOzJlteXbHSpHKfL4SUliE7E3f+eRMjqTkxyswoJOUuwx/z9aKVlkDk2MiltRG
Uj9hG/2v/ooD/eenWJWkK082wI0FYg==
=LAqe
-----END PGP SIGNATURE-----

--TBNym+cBXeFsS4Vs--
