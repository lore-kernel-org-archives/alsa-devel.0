From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: pcm: allow changing the playback/capture rates for
 symmetric links
Date: Thu, 28 Apr 2016 12:41:50 +0100
Message-ID: <20160428114150.GM3217@sirena.org.uk>
References: <1461746959-11443-1-git-send-email-peda@axentia.se>
 <20160427161504.GZ3217@sirena.org.uk>
 <122ca84a-230e-654e-425f-3adb0ca00ec7@axentia.se>
 <20160428103822.GJ3217@sirena.org.uk>
 <s5h8tzyuhad.wl-tiwai@suse.de>
 <20160428111001.GK3217@sirena.org.uk>
 <s5h1t5qug7a.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fwe/mf09/KM5EodX"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5h1t5qug7a.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Peter Rosin <peda@axentia.se>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--fwe/mf09/KM5EodX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 28, 2016 at 01:26:49PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > We've had the code for years without anyone reporting issues so...  the
> > idiomatic ALSA thing is to set everything in one call which helps a lot.

> Yes, most of such problems come from the inconsistent hw constraints,
> and one-shot configuration helps indeed.  But, in this case, it
> appears more like an overlooked case to me.

If there's a useful report with the ALSA API then let's look into that -
if people can only see this with the OSS API and can't articulate an
actual ALSA API level problem then I'm struggling to care.  Drivers that
do parameter validation tend to fail with OSS anyway as it tries to set
partially configured hw_params with invalid values in them and it's not
clear to me that this isn't the same thing happening again.

> BTW, this reminds me of another question: don't we have a dummy ASoC
> driver like snd-dummy?  It would be convenient for a casual API
> testing.

No, someone would need to write a series of dummy drivers that exercised
the various API features (almost all of which are kernel internal) and
then instantiated them but nobody stepped up and did that yet.

--fwe/mf09/KM5EodX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXIfb8AAoJECTWi3JdVIfQFVcH/1jkmlZ5iINv3nnTkWJzT/a3
Y6Lnhgo6aKyi7a48Qh6mrd6Bd2qMXy8gMQr36r9Inp9vZK2nSO/aEFGeDtKqjW1T
9gnRSgNewBRe824aXDanCoI3GhfPSiP/aZvcq6LeiKiFhbshfcfHcTSeMKdmJyqW
QYcZwKNsiTDWP8y2Tl6ngf+tOS9AuEEO62WwAIm2tegTRPjn4TS0G/PXM3+SzNnM
uPvMDs5/2rlevFWlJAID8jjPYWVGVBDAa3d7hvd4CfM7kzQEJe4M1w86oAIKw2kz
lA1IZtML8Nj+X+KFO7XZK9hHBBZBZsy1RueK8ZzstZQHjs8BUagW1WIUtFE1CsI=
=I/EW
-----END PGP SIGNATURE-----

--fwe/mf09/KM5EodX--
