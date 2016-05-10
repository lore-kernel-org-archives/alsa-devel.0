From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/5] ASoC: da7213: Add checking of SRM lock status before
 enabling DAI
Date: Tue, 10 May 2016 19:21:43 +0100
Message-ID: <20160510182143.GD6261@sirena.org.uk>
References: <cover.1462892732.git.Adam.Thomson.Opensource@diasemi.com>
 <5e2ccd9429829fc8cacf94ee8595efa6d11834f4.1462892732.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8nsIa27JVQLqB7/C"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5e2ccd9429829fc8cacf94ee8595efa6d11834f4.1462892732.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org


--8nsIa27JVQLqB7/C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 10, 2016 at 04:11:05PM +0100, Adam Thomson wrote:

> +		/* Slave mode, if SRM not enabled no need for status checks */
> +		pll_ctrl = snd_soc_read(codec, DA7213_PLL_CTRL);
> +		if (!(pll_ctrl & DA7213_PLL_SRM_EN))
> +			return 0;

This isn't going to work, the driver has no volatile registers but it
does have a cache...

--8nsIa27JVQLqB7/C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXMia1AAoJECTWi3JdVIfQy8sH/1RkSBqqgAWZejmFRydhOQm2
q6MOSXt9hdlfFwmYakhCfLgmkJnDoIpalGvDqKeuz3riR70VOY/QT+52D3oe2Q2c
G4QzuF459VXZSZsaytk5rNM9f/y7al7zgt3H44fS3Xrg9peTt1g4Vgn9bKTicc0l
kr+3yvdE0UuOlf79cEpydorPGV3wSNtZRgMkMuL/GS5XT8ALrS8xvwoftm2ce4FA
mz8UiQsZpQ34luuRWbukk/oOG1/X1Bsr96+gjUMMnx7qZnRyDxtyHp5gDgN9jFgm
pfxeGvCQ2u4iDfsfcjm8nyevqYpwTURuJ3e7ft3Ak+YAcqmyJPKNYK+wPLQ6xEI=
=tx1E
-----END PGP SIGNATURE-----

--8nsIa27JVQLqB7/C--
