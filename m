From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl: select SND_SOC_FSL_SAI or SND_SOC_FSL_SSI
 depending on SoC type
Date: Thu, 28 Jan 2016 23:33:52 +0100
Message-ID: <20160128223352.GB4130@sirena.org.uk>
References: <1453293038-16032-1-git-send-email-LW@KARO-electronics.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qcHopEYAB45HaUaB"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1453293038-16032-1-git-send-email-LW@KARO-electronics.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Fabio Estevam <fabio.estevam@freescale.com>, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--qcHopEYAB45HaUaB
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 20, 2016 at 01:30:38PM +0100, Lothar Wa=DFmann wrote:

> -	select SND_SOC_FSL_SSI
> +	select SND_SOC_FSL_SAI if SOC_IMX6UL
> +	select SND_SOC_FSL_SSI if SOC_IMX6Q || SOC_IMX6SL || SOC_IMX6SX

Does this card not work for older i.MXs (which had the same SSI/AUDMUX
combination as the majority of the i.MX6 family) as well?

--qcHopEYAB45HaUaB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWqpdOAAoJECTWi3JdVIfQyjcH/1InIXzjMgK8vQ09mvuSgivS
lLjPGbIU9hQrVGqgyCfv87dJ9u6upmUKUszCQWND3C3R5DRKjiHOb9HTkRTUbdUD
AmwSH9hiW2WKYoD60zVupv+Jg3alLgQg0M1Hy6XxbFJ0grmh8q5SRi1Ez1H4ARi0
GGYez7GZhkrpNXz7Ot0bNFuULpL6z4zVr4ANkpuDgryzkRZALZGiYp8bpSXA5Aiy
qqX2mz7KMaIiIglPsArljZh8uQGb9Jk5f2d1e/QYywS1WKSEVT3b9QLDJGtx4FXC
a/3VGd7p51R7EpzDxEe/OX8cF5dRKrKTf5FaN163MLwbA3hxODV4N22bhohRFWM=
=E860
-----END PGP SIGNATURE-----

--qcHopEYAB45HaUaB--
