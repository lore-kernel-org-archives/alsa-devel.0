From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH 2/2] ASoC: Intel: boards: Add Baytrail
 RT5660 machine driver
Date: Mon, 19 Dec 2016 16:44:02 +0000
Message-ID: <20161219164402.g4knszgpgowfxelb@sirena.org.uk>
References: <20161219135147.24208-1-shrirang.bagul@canonical.com>
 <20161219135147.24208-3-shrirang.bagul@canonical.com>
 <20161219155509.qs7o5tdnz5z6ksuw@sirena.org.uk>
 <a712abe0-4fc0-8b7f-b819-2903564b88c6@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6tw4wmiktqcimfiw"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <a712abe0-4fc0-8b7f-b819-2903564b88c6@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Shrirang Bagul <shrirang.bagul@canonical.com>, alsa-devel@alsa-project.org, Jorge Fernandez Monteagudo <jorgefm@cirsa.com>, Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>, Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Ramesh Babu <ramesh.babu@intel.com>, Ben Zhang <benzh@chromium.org>, John Keeping <john@metanate.com>, Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>, Colin Ian King <colin.king@canonical.com>, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org


--6tw4wmiktqcimfiw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 19, 2016 at 10:30:09AM -0600, Pierre-Louis Bossart wrote:

> All this code seems to be largely a copy-paste of the bytcr_rt5640 machine
> driver and the same comments would apply there. This patch did miss the last

Yes, there's a lot of room for cleanups in the existing code too (and of
course if there's such a large amount of cut'n'paste that implies that
there should be some code reuse going on).

> correction merged by Mark to deal with errors "ASoC: Intel: bytcr_rt5640:
> fallback mechanism if MCLK is not enabled" and the same error handling would
> be needed.

There was a cut back version of it I thought?

--6tw4wmiktqcimfiw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlhYDlIACgkQJNaLcl1U
h9CoRQf/evGBJqjxUXVvtQ9GgVpLi/SzYlV8+HNAhW+yw0rUimDRSp+9GOIdzh+H
sF9M0VormDDNtFYeMVRPoA4plhCPHuQa27pyzVdsYIwoscEW2t45jhIFhr2oZXyC
hb0hCPGqbUBJ0Ilq61tHzKLI5slerFI1HFt1nrZiUX9hNBhPSrxArEbzC+UzPqHb
yyJcdJIHcQy+8yy1Q2e7W1fgx/rgAzqJsx5fs1NuM4fQJZc4Fm1ZE1Gc6CQOJC6z
9f1RSkvZqPmiETluyxtFSznDD3byN7NOxqBBnrpPWyHVML2Qyh94tSgkocLwo2cz
4jpfy1/B4CdI1+aupm/7Lc2sJI40OQ==
=g3k7
-----END PGP SIGNATURE-----

--6tw4wmiktqcimfiw--
