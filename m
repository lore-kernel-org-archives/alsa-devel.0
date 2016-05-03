From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 2/7] ALSA: ac97: add an ac97 bus
Date: Tue, 3 May 2016 17:29:38 +0100
Message-ID: <20160503162938.GT6292@sirena.org.uk>
References: <1462050939-27940-1-git-send-email-robert.jarzmik@free.fr>
 <1462050939-27940-3-git-send-email-robert.jarzmik@free.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZXzThk3vFZecBD04"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1462050939-27940-3-git-send-email-robert.jarzmik@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--ZXzThk3vFZecBD04
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 30, 2016 at 11:15:34PM +0200, Robert Jarzmik wrote:
> AC97 is a bus for sound usage. It enables for a AC97 AC-Link to link one
> controller to 0 to 4 AC97 codecs.

> The goal of this new implementation is to implement a device/driver
> model for AC97, with an automatic scan of the bus and automatic
> discovery of AC97 codec devices.

I think this is basically what I was thinking of, yes.  One thing we'll
need to do is work out how to handle systems that need some explicit
action to start clocks for the bus clock, though they were never very
common and it's entirely possible nobody cares any more so perhaps we
just punt and see if anyone notices for now.

> +int ac97_digital_controller_register(const struct ac97_controller_ops *o=
ps,
> +				     struct device *dev);
> +int ac97_digital_controller_unregister(const struct device *dev);

Why "digital"?=20

--ZXzThk3vFZecBD04
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXKNHxAAoJECTWi3JdVIfQ5PEH/ic82+0x5N/Dj0/dhz4pSb+Z
hVIL961FHhY0zM/ppK1DNFz8QLZPF47V5NJpD0hvtGPBRqCK41DFEH8f7xAa/wg1
VSQ2HqD7c5Gm52MvwkVl8A6SfrmqGlEVEOM7T/nRND6S8kUYBK4YleRea5aIKjJf
RV8AzS9VAZD9+9ghklCAcuX4/lL9CJhXoCxBWnsiRxZTIzg9d0nfJ5szHI6VEh5e
4NQ+yOycn3539nOSq8KAGRH2zQ+kkaJ7ssMLp3+ftv/qwTX6PVIeLxzQrMcTieZv
LGhRSEdApYJL7e0H/FN1bdoid2qvthFTX2TM+P/Pfjz9oGB2rPkAih6BJFxi10U=
=VEHO
-----END PGP SIGNATURE-----

--ZXzThk3vFZecBD04--
