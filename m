From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC:pcm512x: Fix divide by zero issue.
Date: Sun, 22 Mar 2015 16:19:56 +0000
Message-ID: <20150322161956.GF6643@sirena.org.uk>
References: <1426886025-10731-1-git-send-email-hm@hmbedded.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xaMk4Io5JJdpkLEb"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1426886025-10731-1-git-send-email-hm@hmbedded.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Howard Mitchell <hm@hmbedded.co.uk>
Cc: peda@axentia.se, tiwai@suse.de, lgirdwood@gmail.com, perex@perex.cz, corbet@lwn.net, alsa-devel@alsa-project.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--xaMk4Io5JJdpkLEb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 20, 2015 at 09:13:45PM +0000, Howard Mitchell wrote:
> If den=1 and pllin_rate>20MHz then den and num are adjusted to 0
> causing a divide by zero error a few lines further on. Therefore
> this patch correctly scales num and den such that
> pllin_rate/den < 20MHz as required in the device data sheet.

Applied, thanks.

--xaMk4Io5JJdpkLEb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVDuurAAoJECTWi3JdVIfQPCAH/2maoGnETffqZhgJVDf1NiVs
5k4dgrhWbg0WeJ58roJGyFJF2ii8m1sYGKCC2nEcR/GV9XfG/3VcqdwzqcNLUa5k
3K6cIW5umlgs3kHxPnY2hWNdmsYpN0/dYYWvnJMiqi1/2Lwe+/pdU1kFKq64HATZ
K2z8SCNuYwRYIvYIfuTAahnq0Ggz3t1usTqfJCzxGVw5jQg+l63eaFOLxUcrU36+
On7Q47biI3UaHj0aR63i0wpx4rxeZUIjW2U/Zsb7d6ulmfX3fLpyZDkcF0rzq5KS
R/m3Uq3L3Z/iQ19fS3xRXf/J129nvNDdnR3FmM/Q72q5zUP44nAsS84yWnou/hs=
=G++z
-----END PGP SIGNATURE-----

--xaMk4Io5JJdpkLEb--
