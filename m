From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH][ASoC]Add ability to remove rate constraints from generic
 ASoC AC'97 CODEC driver
Date: Sun, 22 Mar 2015 18:27:44 +0000
Message-ID: <20150322182744.GB6643@sirena.org.uk>
References: <54FF7E13.4060801@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2R+TDOstMAPx/aG/"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <54FF7E13.4060801@maciej.szmigiero.name>
Sender: linux-kernel-owner@vger.kernel.org
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Lars-Peter Clausen <lars@metafoo.de>, Brian Austin <brian.austin@cirrus.com>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--2R+TDOstMAPx/aG/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 11, 2015 at 12:28:19AM +0100, Maciej S. Szmigiero wrote:
> Add ability to remove rate constraints from generic ASoC AC'97 CODEC
> driver via passed platform data, make it selectable in config.

Please use subject lines matching the style for the subsystem.  This is
helpful for identifying relevant patches and not getting your messages
deleted unread...

> This way this driver can be used for platforms which don't need
> specialized AC'97 CODEC drivers while at the same avoiding
> code duplication from implementing equivalent functionality in
> a controller driver.

I'm sorry but this just doesn't explain what this patch is intended to
accomplish.  If we can talk to the AC'97 CODEC at all we can already
identify whatever constraints it has by looking at the ID registers so
it's not clear when or why a platform would need to use this.  It feels
like there is some underlying problem that you're trying to address.

--2R+TDOstMAPx/aG/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVDwmfAAoJECTWi3JdVIfQN84H/18TqDPTkaSBYxKIm+pJPOT5
krsYp23mu1fN+CWxTT5tK2p/WIzunwjkXBRUvXmzCexeTRblhUNoxIQiNrt1ggoS
pybInRCxS9iw1mZ2i0taI6MX+TqOA++lXHdiOOK2Ijf1HqycWf2amk/Rfp6KefgB
7uljKuxo9eCKFHtimFTCFhamTxPf8nuO1YncawiEraEu8AUHhv+rZ4rJRrC8mqxL
tBSE6sz0hc+q0StwckXSlx4c3ln/AlL9e3qx47TZSPhYvWt0EQWKmwaQZ4KLv7MK
+AEyZWeC3T24mXZPEyJgSSe4yBorccafOnkkCeZgniX/7xM1XqGEAr5144jnH2g=
=FuKL
-----END PGP SIGNATURE-----

--2R+TDOstMAPx/aG/--
