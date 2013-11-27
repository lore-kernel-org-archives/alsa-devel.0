From: Mark Brown <broonie@kernel.org>
Subject: Re: [Patch v2 1/2] ASoC: atmel: sam9x5_wm8731: fix oops when unload
 module
Date: Wed, 27 Nov 2013 15:50:23 +0000
Message-ID: <20131127155023.GB14725@sirena.org.uk>
References: <1385546710-11308-1-git-send-email-voice.shen@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Nu+X7QXugUj78Xnb"
Return-path: <linux-sound-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1385546710-11308-1-git-send-email-voice.shen@atmel.com>
Sender: linux-sound-owner@vger.kernel.org
To: Bo Shen <voice.shen@atmel.com>
Cc: nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, richard.genoud@gmail.com, linux-sound@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--Nu+X7QXugUj78Xnb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 27, 2013 at 06:05:09PM +0800, Bo Shen wrote:
> As the priv is not assigned to card->drvdata, it is NULL, so when
> unload module, it will cause NULL pointer oops.
> Assign priv to card->drvdata to fix this issue.

Applied, thanks.

--Nu+X7QXugUj78Xnb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSlhS8AAoJELSic+t+oim92eEQAJPSHkuM7E5V7N5DOgO7w4va
RJVMuJtgbfiYpCWPcpnWWUFO3+pDsolZU1f1dRMeczi52fFI4O9vrGK+9nqagJJX
64xwrzoephkIxK5l+YBQeA0TBqqQQqGZqHGMRFURjnK3znn6UJx58URc1QM9Z0c3
3fkzFTWaOqdkqFA+1ovihtxC4+1Np0sdgkDWvktNhxKgY8rCWJQg0jshBkXx9Ayq
H6+IaT6tXuds4jca3fvAfo/SMXl7JrDtTaJ9a94ziQUdiCZS86VervjwhTzby3PV
LEmdKVlhBlyPXap2oX3j0sfsVaVpv0pu8Nl58IJeekbt+DZhWb01ToJwfSHCggaP
y3ZfEvMXLE3mByVyrqR0H4lCG3PODB/+Jzdg3zVluPZk4oMMuSh/Y7G+qRezgvwA
ImuBD/dJYQ0ovS7Bd5E6wJNl36XG6tWJb3wgRt8u3rxAaJEilD8vLJQe4DTcF6AO
34eTfqFQaBeV2hvVbevA3BQIUf2xvWFEBhbyMlmSUp2SYZFUiGs9r2+d2BFA9RAS
uu6VrgfnK+MKh47lnH7c5onlsvF7K+ThLIf+sUui6pCMchXal8Nu7e5d4VVSBgIl
a/0U+acIbgS6JyzaBz6kyXUjqX2RESAbfvyXLgW60OSK3gxdieOkwGMon3PQ0qnJ
JiHEyTeuWAUJGhAA/i1T
=vvUF
-----END PGP SIGNATURE-----

--Nu+X7QXugUj78Xnb--
