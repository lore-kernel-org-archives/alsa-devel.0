From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH v2 1/7] ASoC: Intel: Fix Kconfig with top-level
 selector
Date: Wed, 29 Nov 2017 10:59:17 +0000
Message-ID: <20171129105917.rgnptzbyp4ammahb@sirena.org.uk>
References: <20171129014551.30552-1-pierre-louis.bossart@linux.intel.com>
 <20171129014551.30552-2-pierre-louis.bossart@linux.intel.com>
 <20171129102734.GA32417@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xyserliakqg6wkeb"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171129102734.GA32417@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org, tiwai@suse.de, torvalds@linux-foundation.org, liam.r.girdwood@linux.intel.com, andriy.shevchenko@linux.intel.com, arnd@arndb.de, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--xyserliakqg6wkeb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 29, 2017 at 03:57:34PM +0530, Vinod Koul wrote:
> On Tue, Nov 28, 2017 at 07:45:45PM -0600, Pierre-Louis Bossart wrote:

> I am not sure about top level being default to Y...

This is the same as the handling of the vendor configuration options for
ethernet drivers - it doesn't enable any actual code itself, it just
makes the configuration options below it visible by default so that
people running make oldconfig don't get their drivers turned off.

--xyserliakqg6wkeb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAloekwQACgkQJNaLcl1U
h9ApyAf+Ljg5FnLzYlev5c0Tpkx6gAf2nYBCKX2rNRlaK2EdwuAuiABBB7DUb+WH
lnVs+7ADmXKooBLTkvdXCZaoQRFDy15qZtBRRt09H0NtYcrngmGNTRSmlxBo+DtX
GHNHGMwPv3yknxj6LQXw62Gb5Yi8iy9gWg80ZPVU1uGOq2Vg/f7p5IboHNNj05a/
ck8JdtJYnqvPCQ4Uqtxh8EG3boXlbkY5SoUipnpsIp3wTwqvnjCF7jMCAuwvMKRI
vsSebpodRQFPPYmeQeSw2Axr1MdY1qINIow6qMg5PC3QB11yn5FtVTLqWPMlF+Tf
UhKd+J9F7bmTkRZuBtzMM7qS33ONWA==
=REy7
-----END PGP SIGNATURE-----

--xyserliakqg6wkeb--
