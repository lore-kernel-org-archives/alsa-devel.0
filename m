From: Mark Brown <broonie@kernel.org>
Subject: Re: commit b1ef29725865 (ACPI _REV=2) causes sound regression on
 Dell XPS 13 [Was: Discussion around quirking the _REV behavior for the XPS
 13 (2015) until 4.2]
Date: Tue, 12 May 2015 18:35:02 +0100
Message-ID: <20150512173502.GH3066@sirena.org.uk>
References: <55401602.5050907@dell.com>
 <55480021.1090402@dell.com>
 <20150511182658.GA8516@isilmar-3.linta.de>
 <20150512101258.GL2761@sirena.org.uk>
 <55521BA0.3030606@dell.com>
 <20150512161849.GD3066@sirena.org.uk>
 <55522E34.80702@dell.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lrvsYIebpInmECXG"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55522E34.80702@dell.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Mario Limonciello <mario_limonciello@dell.com>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>, "robert.moore@intel.com" <robert.moore@intel.com>, "lv.zheng@intel.com" <lv.zheng@intel.com>, "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "han.lu@intel.com" <han.lu@intel.com>, "yang.jie@intel.com" <yang.jie@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Matthew Garrett <mjg59@coreos.com>, "liam.r.girdwood@intel.com" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org


--lrvsYIebpInmECXG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 12, 2015 at 11:45:40AM -0500, Mario Limonciello wrote:

> >I'm not seeing any of the hw_params() issues with v4.1 - are you perhaps
> >using an old linux-firmware?  I don't know how up to date Ubuntu is
> >there.

> linux-firmware ubuntu 15.04 version: 1.143.
> This is based off upstream cef33368c4d3425f11306496f0250f8ef1cf3c1f, updated
> on March 4 2015.

That's the same firmware I have.  Weird, I don't know if the Intel guys
have any bright ideas here?

--lrvsYIebpInmECXG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVUjnFAAoJECTWi3JdVIfQNCAH/ikY5x3LrHf/cwkIY1JRn2xE
g+FnjEBbSnyLs3FOeWy+pk0h3+TDlAvFx9DMarTwdM5JQAdoqxk4xQFXfDwrk0zg
iyyTmcw4X+56Be7jxx5bNuSjLLIddVI7eqyBf0N2dUt6H5KV5LXnpVMOUwMIsmKc
uSsgLJB12zpU/PI7KaG2MHOxjKH27yw5N/HPnE1DOlxpE4hWtUbeb1twL+9NNOv5
ENm57yQZ9nbTXhuG2dc1dyxnKI0W9xJSILFhlVgYRZHCBC7/tU5qE93pERCzyqxd
F/AJd2k3qhkqD75wojm1HXQxM8khj5ZeF+7/duVOv/nx3ilQaXV3DLylstRa8to=
=6BWc
-----END PGP SIGNATURE-----

--lrvsYIebpInmECXG--
