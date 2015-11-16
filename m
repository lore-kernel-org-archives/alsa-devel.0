From: Mark Brown <broonie@kernel.org>
Subject: Re: multi-codec support for arizona-ldo1 was Re: System with
 multiple arizona (wm5102) codecs
Date: Mon, 16 Nov 2015 17:33:30 +0000
Message-ID: <20151116173330.GF31303@sirena.org.uk>
References: <20151113225355.GU12392@sirena.org.uk>
 <20151114074400.GA7898@amd>
 <20151114123931.GW12392@sirena.org.uk>
 <20151114175915.GA20429@amd>
 <20151114184940.GY12392@sirena.org.uk>
 <20151114211633.GE20429@amd>
 <20151115001402.GZ12392@sirena.org.uk>
 <20151116074534.GA5606@amd>
 <20151116105035.GA31303@sirena.org.uk>
 <20151116122947.GA9125@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9ADF8FXzFeE7X4jE"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151116122947.GA9125@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: sameo@linux.intel.com, lee.jones@linaro.org, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--9ADF8FXzFeE7X4jE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 16, 2015 at 01:29:47PM +0100, Pavel Machek wrote:

> > > Ok, so you are saying that if I fix mfd initialization, sound will
> > > automagically switch from global regulators to device-specific
> > > regulators and things will start working?

> > Yes.

> Ok, so something like this should be applied?

No, moving the mapping of the aliases after the device has been
instantiated won't help here since it means that we will try to probe
the device without the mappings set up at all which guarantees that
things will go wrong.

--9ADF8FXzFeE7X4jE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWShNpAAoJECTWi3JdVIfQmZUH/in6WotXsziybQb5OznHIkbH
VRtANsvXzf8Fw+C2Y2ltPLPANq68Dymprk3gGPqXsB4IdIOJyTIiBSTLxhQ68hz5
NSneUOVuZm9ffHEMGInV4V0g/AqgQnRZko44mGQtIluAEQB1+Mgbn/eVCxDP0AMg
kl+crS3lOtMrzhuBX4rHXgpgwYY141GD2/e2oAWoq9YGTp8hCs5cVVAUEtOJGhjo
mK6QsdBn3kM8jZVkPnxO3dwSDwZDiM7sTVu5SD28ygLZwkmaQRU78Qw4tDUCOPQc
ZyXMD+bOssTKmV5DvS5AHstz+FVhE92RU+uTcJ401JfmSGRdq7Gn8GtCKDu9vl4=
=gPvB
-----END PGP SIGNATURE-----

--9ADF8FXzFeE7X4jE--
