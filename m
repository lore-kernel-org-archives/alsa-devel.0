From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: MAX9860: new driver
Date: Wed, 11 May 2016 16:09:37 +0100
Message-ID: <20160511150937.GK6261@sirena.org.uk>
References: <1462892797-1147-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="F55Y67F01HNW3AgB"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1462892797-1147-1-git-send-email-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--F55Y67F01HNW3AgB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 10, 2016 at 05:06:37PM +0200, Peter Rosin wrote:

> This driver does not support sidetone since the DVST register field is
> backwards with the mute near the maximum level instead of the minimum.

Why would that be an issue?  We support volume controls in either
direction.

--F55Y67F01HNW3AgB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXM0swAAoJECTWi3JdVIfQZYUH/jpIE5iKaQ/bUt3p03+nBYTr
eRkpdb2t4MMRSZP+jwNnF0enjQIPSCsUFwg5cij8k8qVvKexyJ4gwoj70/77QLDF
tAXOOvBWxdOLeaGyDgVp4nzlNXeyrEuVoKsUuVfv8GLobcUdyJCGUwiZ54CgjUVj
FyAwXV1THI8BcJbaTA4oZM5QWTcAY2cVehQM8i5qAdxH9DOAuz5M03wJdVG7Tbrv
KFnzEc7KakwmuksF3WjVaGTkOMxDw60AT979X7dYgw+Ot0fGpc2UMTQEXotGmJq9
yNu53PCt6b9ohU+MQ+hkj3+ETD/siO5B0D/gBHxTOO8Zt4T/G9adxvECdzQ+l4k=
=4p8j
-----END PGP SIGNATURE-----

--F55Y67F01HNW3AgB--
