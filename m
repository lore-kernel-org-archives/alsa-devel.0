From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: mxs-saif: check BUSY bit in hw_params() only if
 not mclk_in_use
Date: Fri, 5 Feb 2016 13:19:44 +0000
Message-ID: <20160205131944.GB12311@sirena.org.uk>
References: <1454505500-30384-1-git-send-email-mans@mansr.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NMuMz9nt05w80d4+"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1454505500-30384-1-git-send-email-mans@mansr.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mans Rullgard <mans@mansr.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--NMuMz9nt05w80d4+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 03, 2016 at 01:18:20PM +0000, Mans Rullgard wrote:
> If something else, typically a codec, has enabled mclk, the BUSY
> bit may be set when hw_params() is called without this being an
> error.  This check thus causes intermittent failures to configure
> the sound device when used in such a manner.  Fix this by making
> the test conditional on !saif->mclk_in_use.

Please remember to CC the maintainers for the driver when sending
patches. =20

--NMuMz9nt05w80d4+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWtKFuAAoJECTWi3JdVIfQQCYH/i0AQQ/AV4WkbpoLkwgF9cua
jxk3F8g74QwbqVZo2sOFJLaeYB6P+bul696qYx4B8PHh97tLMqi/KIAjiJbAw2oR
GCvQ47ht+WELK2CKaCe2Q7pCD+T5Z4OV4JClf0nnFhACpXIxzSaJJXLlQQWQ/kid
Gee0r7QvoubSwy6oYrHG72jMEaX/q0TrT2Exv3Tvht7Lrt8hx40c/wEAp+HDqqTM
OyPazpFxSKBbyuIADUcWmo1LRDyZmS+3FcU5EBovV9sTnKCPGWPwf2SxYK9bFmxy
vqnLE9O1v7NnNmY9MuEG0Uyp3G6GpS3u5meWr6Qr8zd6WHF6X12SiiOmP6CSUmA=
=D5VU
-----END PGP SIGNATURE-----

--NMuMz9nt05w80d4+--
