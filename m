From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: codecs: dmic: Fix check of return value from read
 of 'num-channels'
Date: Mon, 22 Jan 2018 12:21:03 +0000
Message-ID: <20180122122103.GA9952@sirena.org.uk>
References: <20180119233650.100472-1-mka@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180119233650.100472-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Kaehlcke <mka@chromium.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 19, 2018 at 03:36:50PM -0800, Matthias Kaehlcke wrote:
> Commit 7fb59e940f62 ("ASoC: codecs: dmic: Make number of channels
>  configurable") introduces an optional property to the device tree
> to specify the number of DMIC channels. dmic_codec_probe() uses

Please submit patches using subject lines reflecting the style for the
subsystem.  This makes it easier for people to identify relevant
patches.  Look at what existing commits in the area you're changing are
doing and make sure your subject lines visually resemble what they're
doing.

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlpl1y4ACgkQJNaLcl1U
h9BXoAf/emoRMv7miqNH91ax46LBTb9Xz2m60uWOV/SLjenCy/sNc6z6ro6OPlfM
SskBvQWGm7BrUC/OllCwrnOSAPNKuB5I75VVLXpeM9EWHTknrKZw26+Ca6tBpHXf
6ASEWHzwUMBbsH6HYEdFv423cx8PIH2kgeNSdwtntf2sRX+yqnaFElq10WTNN2g1
4/9pQtA3jkNp4asKlXonm4t+9Gkc+J5bx/6cS2K+r6ohV+F+anexTRBcGvMCseQt
FrVxROdTp/qdSW6+qHfK8DzjYak3AVRXNDM6gwBDYGWNml0V4nsiv4xILrQFfXtv
as+8SEd+F0Mxr2RDFTSzEvedpdy+2Q==
=3zM/
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
