From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: rockchip: Add machine driver for max98090 codec
Date: Thu, 16 Jul 2015 13:55:29 +0100
Message-ID: <20150716125529.GG4039@sirena.org.uk>
References: <1436930143-31361-1-git-send-email-zhengxing@rock-chips.com>
 <1436930143-31361-2-git-send-email-zhengxing@rock-chips.com>
 <1437033944.27428.11.camel@tiscali.nl>
 <20150716110032.GU11162@sirena.org.uk>
 <1437047261.28351.6.camel@tiscali.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Zrag5V6pnZGjLKiw"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1437047261.28351.6.camel@tiscali.nl>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Bolle <pebolle@tiscali.nl>
Cc: Xing Zheng <zhengxing@rock-chips.com>, dgreid@chromium.org, dianders@chromium.org, heiko@sntech.de, sonnyrao@chromium.org, linux-rockchip@lists.infradead.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--Zrag5V6pnZGjLKiw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 16, 2015 at 01:47:41PM +0200, Paul Bolle wrote:
> On do, 2015-07-16 at 12:00 +0100, Mark Brown wrote:

> > You've got platform_device and platform_driver confused I think.

> I did? You mean that creating a platform_DRIVER triggers that
> MODALIAS=platform:{...] uevent?

No, in that case you've not understood what the MODULE_ALIAS is
for.  It's there so that userspace knows which module to load if it gets
a device with no driver, it goes in the driver not in the code
registering the device.

--Zrag5V6pnZGjLKiw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVp6nAAAoJECTWi3JdVIfQhdgH/1bYUkQU+sCM2DZsgjxlsowY
mc5TLoJkqDpeyNUSHcF8ltRsGW13+W4VotmUx3XcUPfhr4xZiGjH3F8UhpwqnFpY
Ve76xG3q5u427T3osp6KItDbNAe6Agu3o7fZ8qQLyzjLvD0vbwXdWF8gao7eCpkr
ryr/N9Tt/cZ+LzBB8l/OV6GxMNyd8+1Cz+0pos2CZIxyxKB8+y58zof0cD+ycFro
V5BR46wsne9IUE+l0o0JpgeUGsWcpQYo9yYkMT1M7V9YDYZp2PQlgTZzRnVerFLR
GlhJ9zM/tFrXDrSPa+Hu0YD2HAqAxWTSvNtsVIn7jpdqC9KNdBEg64rA1I5cnv0=
=p02f
-----END PGP SIGNATURE-----

--Zrag5V6pnZGjLKiw--
