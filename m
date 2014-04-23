From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC updates for v3.15
Date: Wed, 23 Apr 2014 12:16:31 +0100
Message-ID: <20140423111631.GO12304@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7604881531894422180=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C653A261A3B
 for <alsa-devel@alsa-project.org>; Wed, 23 Apr 2014 13:16:46 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7604881531894422180==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qaN/cnoOojZiWuMv"
Content-Disposition: inline


--qaN/cnoOojZiWuMv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit a798c10faf62a505d24e5f6213fbaf904a39623f:

  Linux 3.15-rc2 (2014-04-20 11:08:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-v3.15-rc2

for you to fetch changes up to 98810a6dcf8af768d7b0b71e5075ff9c199f5196:

  Merge remote-tracking branches 'asoc/fix/intel', 'asoc/fix/jz4740', 'asoc/fix/rcar', 'asoc/fix/tlv320aic31xx' and 'asoc/fix/tlv320aic3x' into asoc-linus (2014-04-22 22:01:07 +0100)

----------------------------------------------------------------

ASoC: Fixes for v3.15

A smattering of driver-specific fixes here, nothing generic.  The Cirrus
CODEC conversions to devm_ are leak fixes - the conversion adds missing
error handling code.

----------------------------------------------------------------
Alexandre Belloni (1):
      ASoC: tlv320aic31xx: document that the regulators are mandatory

Andrew Lunn (1):
      ASoC: alc5623: Fix regmap endianness

Axel Lin (2):
      ASoC: cs42l52: Convert to use devm_gpio_request_one
      ASoC: cs42l73: Convert to use devm_gpio_request_one

Ben Dooks (1):
      ASoC: rsnd: fix clock prepare/unprepare

Christian Engelmayer (1):
      ASoC: Intel: Fix incorrect sizeof() in sst_hsw_stream_get_volume()

Dan Carpenter (1):
      ASoC: Intel: some incorrect sizeof() usages

Jarkko Nikula (1):
      ASoC: dapm: Fix widget double free with auto-disable DAPM kcontrol

Lars-Peter Clausen (1):
      ASoC: jz4740: Remove Makefile entry for removed file

Mark Brown (3):
      Merge remote-tracking branch 'asoc/fix/dapm' into asoc-linus
      Merge remote-tracking branches 'asoc/fix/alc5623', 'asoc/fix/cs42l52', 'asoc/fix/cs42l73' and 'asoc/fix/fsl-spdif' into asoc-linus
      Merge remote-tracking branches 'asoc/fix/intel', 'asoc/fix/jz4740', 'asoc/fix/rcar', 'asoc/fix/tlv320aic31xx' and 'asoc/fix/tlv320aic3x' into asoc-linus

Nicolin Chen (1):
      ASoC: fsl_spdif: Fix wrong OFFSET of STC_SYSCLK_DIV

Sebastian Reichel (1):
      ASoC: tlv320aic3x: fix shared reset pin for DT

Wenkai Du (1):
      ASoC: Intel: Fix audio crash due to negative address offset

 Documentation/devicetree/bindings/sound/tlv320aic31xx.txt | 6 +++---
 sound/soc/codecs/alc5623.c                                | 2 +-
 sound/soc/codecs/cs42l52.c                                | 6 ++++--
 sound/soc/codecs/cs42l73.c                                | 6 ++++--
 sound/soc/codecs/tlv320aic3x.c                            | 9 +++++++--
 sound/soc/fsl/fsl_spdif.h                                 | 4 ++--
 sound/soc/intel/sst-dsp-priv.h                            | 2 +-
 sound/soc/intel/sst-haswell-ipc.c                         | 7 ++++---
 sound/soc/jz4740/Makefile                                 | 2 --
 sound/soc/sh/rcar/src.c                                   | 4 ++--
 sound/soc/sh/rcar/ssi.c                                   | 4 ++--
 sound/soc/soc-dapm.c                                      | 1 -
 12 files changed, 30 insertions(+), 23 deletions(-)

--qaN/cnoOojZiWuMv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTV6EMAAoJELSic+t+oim9uU8P/jFWIJq5FJrKm8TONDoOPFDw
taiG9jG4s1QlpiGpjEQlSpJg1pJKCYTDwDTY+th83bgymdkj+AGhslHvyaC0t0cW
dLk6bmq9x3eMx/uA0+oxAM2rV3oKkSxioRx3L23yP791IV1aPsYXxhilAWiI6tKW
6NFwoGUEXtcJKwXTgDODyQiueO7kYYWQMoitl2xK1kI+Tp9RFJ72R3EbeNcvsmY/
yzfJX+HpkfYsRuLoU2sGVqvYHW5w/W+VknoXO0Fcg+eizzg93G/bN4N4y8W3WgBJ
1kyF9FqpIe5GgDhgX/N0KljPV+gmm6VdCT8wjVUbVLYT5Mt7CTbEcCGwl6GKjIzw
by8Yscuhhd1Rr1Mg7fCJWN9ZUgQxyXurq5aTioyyywg67pFn4vFpK5iKfOeJAMEG
o9HdKFlyZJYTGNGT9MA0LKsNM841mEKfVuA2QIjW/kqjtSHDFxdLxg36EhjHZ79a
WgXNErbkSS2HoOCmQgR8Uvn9OQTslof23+JGgBJwkogHWEIH5tqXxZZ/OfF/m6xq
azc+VNoQhCLahTAbb2OkwUc3l6pO39bFeqDnpTK6o0QDfPd4IwQfyePVCvSOXwsL
1aF7IXgZZgzy644skpdsTfqkGkGLYLwxbjcZZPfTggcbeIiOhTzpeQ441flbbl3+
KbTbmKkYPm7VomwDlBkU
=ukJr
-----END PGP SIGNATURE-----

--qaN/cnoOojZiWuMv--

--===============7604881531894422180==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7604881531894422180==--
