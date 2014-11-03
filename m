From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: atmel_ssc_dai: Match the CMR divider only in full
 duplex.
Date: Mon, 3 Nov 2014 12:45:49 +0000
Message-ID: <20141103124549.GL3815@sirena.org.uk>
References: <544A1121.6080900@atmel.com>
 <1414178759-7252-1-git-send-email-peda@axentia.se>
 <1414178759-7252-2-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hTKW8p8tUZ/8vLMe"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1414178759-7252-2-git-send-email-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: Bo Shen <voice.shen@atmel.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--hTKW8p8tUZ/8vLMe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 24, 2014 at 09:25:59PM +0200, Peter Rosin wrote:
> The CMR divider register is shared by playback and capture. The SSC driver
> therefore tries to enforce rules so that the needed register content do
> not conflict during simultaneous playback/capture. However, the
> implementation also prevents changing the register content in
> half-duplex scenarios, which is needed when using the OSS API.

Applied, thanks.

--hTKW8p8tUZ/8vLMe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUV3j8AAoJECTWi3JdVIfQcegH/A8sAVhYsXhlnnPdW08UxLRW
uue4tn1WLmPI0WJd7XUqrFsO2w2ueloPZZrxMSL+8kuNdhd1mFFGuhe51vAlTuhR
7IQkTb4Fy+bxKZJ4c7QqwJjYmKw8IU9qrXJ4B4f33TdA++V+ofAQEpAoaDOCCgKf
9tqiqo6glP8qJYTfEUky2FU02AIu8dSNlPuDtbzbLznuC9Lg4gDPPcZX/K7d/kkS
x/a565WlLqtxAYfpFaO53RY+IygL3L5lGoqAyZSLfvFasz3Q+wbaBXDXfSCGWIbB
fTHYTMq1l9GRV3zhhTchbypys0tgkzajmDLGT1kTAv+GROZkgpiYEH7k6boxUcE=
=z+FE
-----END PGP SIGNATURE-----

--hTKW8p8tUZ/8vLMe--
