From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] AC'97 gpiochip
Date: Thu, 3 Dec 2015 00:12:14 +0000
Message-ID: <20151203001214.GP1929@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ejY4sNDb8HmDJL0E"
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-gpio@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--ejY4sNDb8HmDJL0E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:

  Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-ac97-gpio

for you to fetch changes up to 9bf5c3d11f1fbaf43399d189f05fb20ceb46ee5d:

  ASoC: ac97: add gpio chip (2015-11-18 18:08:54 +0000)

----------------------------------------------------------------
ASoC: Add a GPIO chip for AC'97

GPIOs are part of the AC'97 spec, enable their use on embedded platforms
using AC'97.

----------------------------------------------------------------
Robert Jarzmik (1):
      ASoC: ac97: add gpio chip

 include/sound/ac97_codec.h |   3 ++
 sound/soc/soc-ac97.c       | 125 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 128 insertions(+)

--ejY4sNDb8HmDJL0E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWX4jeAAoJECTWi3JdVIfQvJUH/RPgf2GfIHgX5QKkLKaoX/um
REgVN8t7NSVuhO8LeTN+TAwggFCVeMVQDMcJvCSW4kD5RMI9LhEVGnopPYdWLoQC
JXnhbXqo4dg8g2yeJGAfDy+QoEhk2O6MqoXdeEioTGTaNGaoB2cDqabOiVXFfVUs
EczQtwofetE2aFXKYoGOa6Db3tTndxv+PgNEbZ/JhLEJcy2XyicBCErPjbsXLG3t
PX51h0qcF09DO6GzyGBzvdE17FVi6CoabhvYrQNBP7pyLZLncHdVpLwPBWJQ+DHl
KBtTHzXscOnpZtw8k2pdveTGs4xvi8gpr7sm0NI+ZO0j0i9hsx9UPnjhq7C9Vkc=
=c8n6
-----END PGP SIGNATURE-----

--ejY4sNDb8HmDJL0E--
