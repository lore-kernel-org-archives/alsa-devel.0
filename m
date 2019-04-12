From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] regmap: soundwire: fix Kconfig select/depend issue
Date: Fri, 12 Apr 2019 09:46:16 +0100
Message-ID: <20190412084616.GC6909@sirena.org.uk>
References: <20190411192814.10663-1-pierre-louis.bossart@linux.intel.com>
 <20190411192814.10663-2-pierre-louis.bossart@linux.intel.com>
 <s5ho95bpqis.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bKyqfOwhbdpXa4YI"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5ho95bpqis.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com, srinivas.kandagatla@linaro.org, "Rafael J. Wysocki" <rafael@kernel.org>
List-Id: alsa-devel@alsa-project.org


--bKyqfOwhbdpXa4YI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 12, 2019 at 10:38:19AM +0200, Takashi Iwai wrote:
> Pierre-Louis Bossart wrote:

> > config REGMAP_SOUNDWIRE
> >        depends on SOUNDWIRE
> >        select SOUNDWIRE_BUS

> To be noted, in general you can't do put both depends-on and select.
> The select always wins.  So the depends-on in REGMAP_SOUNDWIRE is more
> or less moot.

To be clear the issue is that the dependencies of selected symbols just
get ignored (IIRC their selects too).  It can be useful for
documentation but it does get a bit confusing sometimes.

--bKyqfOwhbdpXa4YI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlywUFgACgkQJNaLcl1U
h9BhBAf/Vz9R/jt81fkpRirW2SlRm2rHMFwV/hX24VjBGcUokQpxGIJ3RzKH0KBw
YaNjW312cdqR6kQXEEbLdojwUvqZ+Wsnm1w6AG6IqSa83UctFNj0rsyyRjbeEBpE
WYxe16pFGohXUmjVEQI5Q3dJsq/khsZII1i3SUHLE7k6TTUBhlIWz8RM1LlhBOQ/
h49w8UEcWxv+SI+eI4Z8u1FuJvl7WoHU0AWf0B/bCO8+XOBOi8ccEhFxrGKzvXSU
Wq0F+10JVNATJMsidR/6yVGW2ckIWmAJPDszKw9eQpJ9+MVjNUXI72/2UZQJtQ+R
7uCLTGEpZcBKyU6phoR68LfKpDjOKA==
=yo9F
-----END PGP SIGNATURE-----

--bKyqfOwhbdpXa4YI--
