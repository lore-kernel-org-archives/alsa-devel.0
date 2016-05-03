From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 1/7] ALSA: ac97: split out the generic ac97 registers
Date: Tue, 3 May 2016 12:51:59 +0100
Message-ID: <20160503115159.GP6292@sirena.org.uk>
References: <1462050939-27940-1-git-send-email-robert.jarzmik@free.fr>
 <1462050939-27940-2-git-send-email-robert.jarzmik@free.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ftQmbtOmUf2cr8rB"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1462050939-27940-2-git-send-email-robert.jarzmik@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--ftQmbtOmUf2cr8rB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Apr 30, 2016 at 11:15:33PM +0200, Robert Jarzmik wrote:
> Split out from the ac97_codec.h the ac97 generic registers, which can be
> used by a codec, typically a generic ac97 codec, and by the ac97 bus, to
> scan an ac97 AC-Link.

I don't entirely see the value in this one but equally it does no harm.

--ftQmbtOmUf2cr8rB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXKJDeAAoJECTWi3JdVIfQsWsH/2pFLFCEUao4jTVreft9FDAt
KzjNeP4n6ygYKx3JFB+7QLfLRQxqUCEriLoexsknwvtf1JgxEDBDKyVTk7NAPFq9
QQJBMzsVPG4lC9NsbYoc3EBsnQYE6dEPxbqZjPFdoZUjXOy/srUm+i8HZZlvWaxG
/1FFQ+Hx6QIRkqFiikYVXoIknfg8KeGt9TcxVeQwIbd8wEHJKeRFFb+GAVSLYGBE
Ivo1iyRTAW9vrzlFiETCEAwuORaVUkLEv5RDZv62f/FxaavV3fMsO3FrYz831vHl
M3TMYRocCnDAO1whQd1UHuTQ5iZCVG07rqUQGDwq4Q+R2lWSV6MG1pv061yZ6dU=
=1gJ9
-----END PGP SIGNATURE-----

--ftQmbtOmUf2cr8rB--
