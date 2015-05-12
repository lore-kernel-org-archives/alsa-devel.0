From: Mark Brown <broonie@kernel.org>
Subject: Re: commit b1ef29725865 (ACPI _REV=2) causes sound regression on
 Dell XPS 13 [Was: Discussion around quirking the _REV behavior for the XPS
 13 (2015) until 4.2]
Date: Tue, 12 May 2015 18:32:50 +0100
Message-ID: <20150512173250.GG3066@sirena.org.uk>
References: <55401602.5050907@dell.com>
 <55480021.1090402@dell.com>
 <20150511182658.GA8516@isilmar-3.linta.de>
 <20150512101258.GL2761@sirena.org.uk>
 <55521BA0.3030606@dell.com>
 <20150512161849.GD3066@sirena.org.uk>
 <CAPeXnHtdU=9bMjHh8NSArYngxDC1wSp3ZDiN96e5gHB_LQjr5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jt0yj30bxbg11sci"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPeXnHtdU=9bMjHh8NSArYngxDC1wSp3ZDiN96e5gHB_LQjr5g@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Matthew Garrett <matthew.garrett@coreos.com>
Cc: Mario Limonciello <mario_limonciello@dell.com>, Dominik Brodowski <linux@dominikbrodowski.net>, "robert.moore@intel.com" <robert.moore@intel.com>, "lv.zheng@intel.com" <lv.zheng@intel.com>, "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "han.lu@intel.com" <han.lu@intel.com>, "yang.jie@intel.com" <yang.jie@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Matthew Garrett <mjg59@coreos.com>, "liam.r.girdwood@intel.com" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org


--jt0yj30bxbg11sci
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 12, 2015 at 10:21:41AM -0700, Matthew Garrett wrote:

> Since there's no way to get this working without using new userspace,
> we're basically stuck with having to support _REV 5. And since we're
> supposed to support old userspace basically forever, this isn't going
> to be something that we can just remove in a few months. But since the
> hardware is intended to be used in I2S mode, we don't want this quirk
> to be there forever. So we're basically left with adding
> CONFIG_ACPI_WORKAROUND_BROKEN_DELLS which enables the quirk, default
> it to Y and then let distributions set it to N when they've got
> sufficiently new userspace. Unless someone has a better plan?

That makes sense to me given that the firmware doesn't seem to do
anything problematic in Linux mode - hopefully we won't have too many
more of these systems to contend with.

--jt0yj30bxbg11sci
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVUjlBAAoJECTWi3JdVIfQJWsH/1bCl0sX1B2r7uTlZ2rJq+OW
KRdOxTqNfd1wIFcTf1WnYs0MO02ZQtxlvMvmRqSL9tQzgK4NKYkl+pAym9iEZb8f
wsrp6nGlC1euYY9GF27xJkVNp8lpJeHkYw34JGHTYLx59ZOAMDIM8TS6ZJsDCRjg
nFW5saTXVz9M+qSLR/TyY7374Ah+A47U+u0NZRyofW8GJF97+Uyk8aPuKTb6kbO2
RvNk1EJoWuBMiiwIUIj8kGhLQnS1dVTOjfEucftXJe+TMCvWneqWoEPfrxKodkKF
9iEAIEdMACr/6egvBO1wAgLKJ/BBJKkFcNh1DzFv0dxCqP/W0CApfBgPD3XIi1Q=
=xfJ4
-----END PGP SIGNATURE-----

--jt0yj30bxbg11sci--
