From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: tfa9879: New driver for NXP Semiconductors
 TFA9879 amplifier.
Date: Fri, 7 Nov 2014 11:17:37 +0000
Message-ID: <20141107111737.GJ8509@sirena.org.uk>
References: <20141106160241.GM8509@sirena.org.uk>
 <1415291985-9784-1-git-send-email-peda@lysator.liu.se>
 <1415291985-9784-2-git-send-email-peda@lysator.liu.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YE/X56qLfGGj1U5i"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1415291985-9784-2-git-send-email-peda@lysator.liu.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@lysator.liu.se>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Peter Rosin <peda@axentia.se>
List-Id: alsa-devel@alsa-project.org


--YE/X56qLfGGj1U5i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 06, 2014 at 05:39:45PM +0100, Peter Rosin wrote:

> +	{ TFA9879_MISC_STATUS,		0x0000 }, /* 0x15, read-only */

The fix here is the wrong way round - if the device is reporting status
here there should be no default and there should be a volatile operation
(though it's not the end of the world to omit that if it's not used).

Otherwise this looks good.

--YE/X56qLfGGj1U5i
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUXKpNAAoJECTWi3JdVIfQOfMH/3Rcmq4rTffISiXF4knH2N7l
T6TJ13rGbzTbQ6dgizwKaiW0Vkd/duqolS89J5AA/0vee5FFmbw86QV23ZI/8aoZ
FN+4tJ4Hr+613W5wiwhnEdYo9W4UZVtpXfVpBzG27sWeM04H7Kl4mTojgxMB8kSp
YJlmryDnzrfeszOBgLIINnPTe+XO/bVUJq4CMKgffMOHaFXWGDyHusvgKncZGLTk
m2asdzvoFWr/Q4wNhy7iGAJxJ/Qo4foyvtUI7GxRqzGfqDKP6UbIdnyE+CpT4T0I
LekWxhuD0r+qK5Adbyxpq89pKej/6i6Axy7UKy6lk/fPd2pIO9FlqwtKcdNCF9E=
=gaUC
-----END PGP SIGNATURE-----

--YE/X56qLfGGj1U5i--
