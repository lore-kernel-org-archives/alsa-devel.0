From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] SoC: Fix MAX98357A codec driver dependencies
Date: Thu, 12 Feb 2015 10:55:15 +0800
Message-ID: <20150212025515.GU2593@finisterre.sirena.org.uk>
References: <1423689198-24034-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dXvu6+ixFx2ZffE8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1423689198-24034-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>, Kenneth Westfield <kwestfie@codeaurora.org>
List-Id: alsa-devel@alsa-project.org


--dXvu6+ixFx2ZffE8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 11, 2015 at 01:13:18PM -0800, Guenter Roeck wrote:
> The max98357a driver depends on GPIOLIB. This may cause the following
> build failure.

Applied, thanks.  Please use subject lines matching the style for the
subsystem.

--dXvu6+ixFx2ZffE8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU3BYSAAoJECTWi3JdVIfQjlUH/1krxDjUNfyW9dCdEktAIoYA
LpMvSc8h60bnZWY+9FYoiHbdxeFZ11xO265hvQc/l9ndtj9MScXwlpv5Q/gQv4Kg
pED5gwFf6qHYddbEV733XkGjDSIPhCVXTXZnP60gHD/pz4+Gp1MDozHqP8JdVls4
7RhyZFpgKYZIYdutGf4r+sPWyu30K5jms00nufgHWUnE4iYhHqNZWuS0hu5EXJ4w
jKJgZ/w6WmqiEsDJvAHSeTe+4HAeerEgG/fvrrG24kq2K55OPUhIBVRH5NcNQ0WX
kr+SD/H6QzwfnsNAkc4hLL6dfMMX6SNZE1I+zt8dGPxPkhc2qqJV2ICrW5kM0BU=
=ZVmw
-----END PGP SIGNATURE-----

--dXvu6+ixFx2ZffE8--
