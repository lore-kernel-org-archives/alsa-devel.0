From: Mark Brown <broonie@kernel.org>
Subject: Re: commit b1ef29725865 (ACPI _REV=2) causes sound regression on
 Dell XPS 13 [Was: Discussion around quirking the _REV behavior for the XPS
 13 (2015) until 4.2]
Date: Tue, 12 May 2015 18:40:36 +0100
Message-ID: <20150512174036.GI3066@sirena.org.uk>
References: <55401602.5050907@dell.com>
 <55480021.1090402@dell.com>
 <20150511182658.GA8516@isilmar-3.linta.de>
 <20150512101258.GL2761@sirena.org.uk>
 <55521BA0.3030606@dell.com>
 <20150512161849.GD3066@sirena.org.uk>
 <CAPeXnHtdU=9bMjHh8NSArYngxDC1wSp3ZDiN96e5gHB_LQjr5g@mail.gmail.com>
 <5552388C.9000500@dell.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QDIl5R72YNOeCxaP"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5552388C.9000500@dell.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Mario Limonciello <mario_limonciello@dell.com>
Cc: Matthew Garrett <matthew.garrett@coreos.com>, Dominik Brodowski <linux@dominikbrodowski.net>, "robert.moore@intel.com" <robert.moore@intel.com>, "lv.zheng@intel.com" <lv.zheng@intel.com>, "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "han.lu@intel.com" <han.lu@intel.com>, "yang.jie@intel.com" <yang.jie@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Matthew Garrett <mjg59@coreos.com>, "liam.r.girdwood@intel.com" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org


--QDIl5R72YNOeCxaP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 12, 2015 at 12:29:48PM -0500, Mario Limonciello wrote:
> On 05/12/2015 12:21 PM, Matthew Garrett wrote:

> >to be there forever. So we're basically left with adding
> >CONFIG_ACPI_WORKAROUND_BROKEN_DELLS which enables the quirk, default
> >it to Y and then let distributions set it to N when they've got
> >sufficiently new userspace. Unless someone has a better plan?
> Just to be clear, from the Dell side only the XPS 13 9343 has this _REV
> behavior.

> What's wrong with a DMI quirk until I2S is mature on the kernel side and
> userspace is new enough in distros?  Is it too early in boot for DMI quirks?

If we're waiting for distros to have new enough userspace we're looking
at waiting several years at least, especially when you start looking at
distros like Debian (which two of the users in this thread are, though
I'm not on stable).

> That would enforce that no other machines can use _REV value of 5 to detect
> Linux without breaking the 9343.

What Matthew suggested was making the quirk a compile time option.

--QDIl5R72YNOeCxaP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVUjsTAAoJECTWi3JdVIfQST4H/A36TwDVBgrMCQCIaK5n8y8g
uC8s+PGFiCevpIEVNYfKu+TdVs44Keuowbx7gq17tK/CYiPY7PNFqtKHLDQeGPZs
L6PGPaAGm0e6QsIGXUEosOssyHfHsyzjFUqzoYvHipurSO/2n0i0lnXWJIJnAJQD
ZxB0WALrhqaIXL+ppr9w1okCn71f0txbV2hLcZaY8Pm5LK1Q+dWsJDP4MAhy66qk
SoC9UXPJokE+U6hKxgCTlvJrtQZ/JXveT+J6ZiPZKPv89y/Bh+pepdAJY3Sjp4CW
Pm9jLGzBAMhV3oeKK+H4nlGuEjgHNm7VBRWk+SvVtEuelPlUydKknOKb12ytYg8=
=473q
-----END PGP SIGNATURE-----

--QDIl5R72YNOeCxaP--
