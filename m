From: Mark Brown <broonie@kernel.org>
Subject: Re: [RESEND PATCH 1/1] ASoC: dwc: correct irq clear method
Date: Wed, 30 Sep 2015 19:17:51 +0100
Message-ID: <20150930181751.GT15635@sirena.org.uk>
References: <006301d0fac4$94eb5890$bec209b0$@tangramtek.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tqSMaTz1cCSspCQ4"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <006301d0fac4$94eb5890$bec209b0$@tangramtek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: yitian <yitian.bu@tangramtek.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, Andrew.Jackson@arm.com, wsa@the-dreams.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--tqSMaTz1cCSspCQ4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 29, 2015 at 10:39:00PM +0800, yitian wrote:
> from Designware I2S datasheet, irq is cleared by reading from
> TOR/ROR registers, rather than by writing into them.

This doesn't apply against current code, please check and resend.

--tqSMaTz1cCSspCQ4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWDCdPAAoJECTWi3JdVIfQ4wMH/jz7vNLAfNUKtxAY/+Q7bGs9
UzvF94rELa564f9NJZydfAKox0DEx4RSPBtOtZRVGmn+cDteSdczTly2nx86EqHH
LZi9w4UbaJYIFERo9RENrb8zOELxL7QRgJwTGbUdtXAaaVl6ciI4vxXJ9SbFos9v
Q0JcYB8c669Q0rPbyTCStuduEtk2LuHNuhDHZavVze1g+zhRvJYQc+L4pzIoAd9P
Kvpy8nWimQbGagpr17k+JqyABtui3SdYtYr/fnyAV8xdgRpsC5e96RAB+yStlpUI
L1c8zMyQcG4NYuKm2bDAqlyd9QybSOl4Bz0v8TnsUbppivZ34G3IfdrMUAHwTnU=
=SVY6
-----END PGP SIGNATURE-----

--tqSMaTz1cCSspCQ4--
