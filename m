From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: codecs-ac97: make selectable in config
Date: Tue, 12 May 2015 18:58:07 +0100
Message-ID: <20150512175807.GL3066@sirena.org.uk>
References: <554E8634.2010008@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="m0XfRaZG5aslkcJX"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <554E8634.2010008@maciej.szmigiero.name>
Sender: linux-kernel-owner@vger.kernel.org
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Lars-Peter Clausen <lars@metafoo.de>, Brian Austin <brian.austin@cirrus.com>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org


--m0XfRaZG5aslkcJX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, May 10, 2015 at 12:12:04AM +0200, Maciej S. Szmigiero wrote:

> @@ -16,7 +16,7 @@ config SND_SOC_ALL_CODECS
>  	select SND_SOC_88PM860X if MFD_88PM860X
>  	select SND_SOC_L3
>  	select SND_SOC_AB8500_CODEC if ABX500_CORE
> -	select SND_SOC_AC97_CODEC if SND_SOC_AC97_BUS
> +	select SND_SOC_AC97_CODEC
>  	select SND_SOC_AD1836 if SPI_MASTER
>  	select SND_SOC_AD193X_SPI if SPI_MASTER
>  	select SND_SOC_AD193X_I2C if I2C

No, you're missing the point of what _ALL_CODECS does - it builds
everything possible.  This will break the build for systems without
AC'97 support.

--m0XfRaZG5aslkcJX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVUj8uAAoJECTWi3JdVIfQwNoH/2rU5hTbyt2dJiDGNua9H86x
wQtgds4TxS9UbIJ/Z+sbU+gBDy9jxj0l9bWkCb+ZW51lbpOVTXNesZAAEP4d2oqu
jtROEPPV1h0LSS+j3C7/BSNpiocjaZaolSDW5XcSJ78/QolnxJRHeEQWOhoQCnKV
Hz+ypHJE1KHBrjfSFIrwStdI01OHZS2C2nkEjSwbn6JlOQwmQiTGSZ69HeEx91x6
HLQ1QqHi+wZSJRsu07LCaS6xSKTldvdaAX6oSyGW5osJiOPSwZBXa2WSnbLUTh0o
0Y9ikr5nM/VgNoosCJrE2qW+7Df7+FXpnHC4kIISLvKgHVmUDbOtuUzzDHGzJnw=
=r586
-----END PGP SIGNATURE-----

--m0XfRaZG5aslkcJX--
