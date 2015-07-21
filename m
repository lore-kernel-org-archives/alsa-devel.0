From: Mark Brown <broonie@kernel.org>
Subject: Re: [patch] ASoC: max98925: reading beyond the end of the array
Date: Tue, 21 Jul 2015 11:43:50 +0100
Message-ID: <20150721104350.GP11162@sirena.org.uk>
References: <20150721085527.GA22070@mwanda>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zBuBUmsEsxAzMXHf"
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150721085527.GA22070@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Anish Kumar <yesanishhere@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Axel Lin <axel.lin@ingics.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Lars-Peter Clausen <lars@metafoo.de>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--zBuBUmsEsxAzMXHf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 21, 2015 at 11:55:27AM +0300, Dan Carpenter wrote:
> Debug prints are seldom useful and this one has an annoying thing where
> it reads one space beyond the end of the array on error.

It's a pretty big stretch to say that debug prints are rarely useful...

--zBuBUmsEsxAzMXHf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVriJlAAoJECTWi3JdVIfQfCwH/3GhgM2wmuUQOa15IF/s8cMV
FPYGMylmynoVvCeSNw5++SFh3xFT/MIA7JerswroE0OOn76pVfmakvu1vLTA+JFc
oCjLXflMIWIow0FLZpvJydA5iZLEe7gzLtw9XaHJnks6J/oo9b3lFjpcK4Ne4gQD
v4/JxL+W7dhC4mPHzKtfpRYHrXoDOu258dli87kWrj5/0pIxoUJZ1cW3nQ1w6BxB
6NCCSGHyenOizhrjSm1dxMElIz9AqMXW931B75nuNzPyAwB9R5kh0+CeWczE7S2R
d0b8+6nEXT9qBH2mdqm55oPqwrNaXD//9r6I4cNPlHG1VLMoxFNobvGR5SvUbxs=
=kplz
-----END PGP SIGNATURE-----

--zBuBUmsEsxAzMXHf--
