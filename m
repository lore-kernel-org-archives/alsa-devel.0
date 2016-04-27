From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: atmel_ssc_dai: note buggy I2S support when the
 codec masters LRCLK
Date: Wed, 27 Apr 2016 17:23:44 +0100
Message-ID: <20160427162344.GA3217@sirena.org.uk>
References: <1461747993-11516-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="exZFuA0xp9ffbpTM"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1461747993-11516-1-git-send-email-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--exZFuA0xp9ffbpTM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 27, 2016 at 11:06:33AM +0200, Peter Rosin wrote:

> While the start condition is correct for the left channel word in the I2S
> case, it is not correct that the right channel word follows immediately
> after the left channel word. The start of the right channel word should
> be triggered by a rising edge on LRCLK in the I2S case, something which
> simply does not happen.

Almost every programmable serial port does this, it's a very common
issue which is why we always try to go for exact clocking where we can -
it greatly improves the interoperability for I2S if there are no dead
clocks.

--exZFuA0xp9ffbpTM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXIOePAAoJECTWi3JdVIfQroEH/iNCF4oV5LeTXOuSvnSQC2gp
UPmE3Nslut1u/L7R3k6DPPWqkrLhxE9K9imVIqBvEFB+vOPEwhodm/E+1dLXS8Vf
zsh1nmmtiVBK7tOpVaPteyt6cKeKJsCkVbwj9RKx2SYTmZGJsNl5uIhqnemKeI71
7AncjhbT3V7QCb57JbCXSd/gPi2v76Otr+zcx+YL5zFIxJjel86ebxImxlB9dwLG
H1EQEoe7YvchM3rByeel8tcth/enD1MI6JFlWhbGX/sI1wbyK8jA6F+x2MsBBKwH
TgtTBqa87Sfajw/TvGUwN/pjNyFQzCgaMq0CDwRrnV+QB/T9iv4/DlYzR+CcbZ8=
=J6Bw
-----END PGP SIGNATURE-----

--exZFuA0xp9ffbpTM--
