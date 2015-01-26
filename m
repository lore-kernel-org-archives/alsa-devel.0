From: Mark Brown <broonie@kernel.org>
Subject: ASoC fixes for v3.19
Date: Mon, 26 Jan 2015 11:44:00 +0000
Message-ID: <20150126114400.GY21293@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3259819799040364736=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BF0532604C7
 for <alsa-devel@Alsa-project.org>; Mon, 26 Jan 2015 12:44:07 +0100 (CET)
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
Cc: alsa-devel@Alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3259819799040364736==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/qNnUp0NPtZJWkzn"
Content-Disposition: inline


--/qNnUp0NPtZJWkzn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 26bc420b59a38e4e6685a73345a0def461136dce:

  Linux 3.19-rc6 (2015-01-25 20:04:41 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-v3.19-rc6

for you to fetch changes up to 88343ee38d7ae55e39cda74c5d137cb2c454e66c:

  Merge remote-tracking branches 'asoc/fix/rt5677', 'asoc/fix/simple', 'asoc/fix/ts3a227e', 'asoc/fix/wm8904' and 'asoc/fix/wm8960' into asoc-linus (2015-01-26 11:29:58 +0000)

----------------------------------------------------------------
ASoC: Fixes for v3.19

There's a lot more fixes here than I'd like since I've been lax in
sending things throughout the release cycle but there's only two in
generic code and they've had quite some time to cook in -next so
hopefully on balance are OK.

The two generic fixes are a fix for crashes on capture DAIs in the
compress code and a fix for error handling on probe failures which would
have been harmless in the past but now oopses with the new dynamic probe
code.

----------------------------------------------------------------
Andrew Jackson (1):
      ASoC: adi: Add missing return statement.

Aurelien BOUIN (1):
      ASoC: fsl_esai: Fix incorrect xDC field width of xCCR registers

Bard Liao (1):
      ASoC: rt286: set the same format for dac and adc

Bo Shen (1):
      ASoC: wm8904: fix runtime warning

Cheng-Yi Chiang (1):
      ASoC: ts3a227e: Check and report jack status at probe

Fabio Estevam (2):
      ASoC: fsl_ssi: Fix irq error check
      ASoC: fsl: imx-wm8962: Set the card owner field

Geert Uytterhoeven (1):
      ASoC: simple-card: Fix crash in asoc_simple_card_unref()

Jianqun Xu (1):
      ASoC: rockchip: i2s: applys rate symmetry for CPU DAI

Jie Yang (2):
      ASoC: Intel: Don't change offset of block allocator during fixed allocate
      ASoC: Intel: Add NULL checks for the stream pointer

Mark Brown (4):
      Merge remote-tracking branch 'asoc/fix/fsl-esai' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/pcm512x' into asoc-linus
      Merge remote-tracking branches 'asoc/fix/adi', 'asoc/fix/compress', 'asoc/fix/fsl-ssi', 'asoc/fix/imx', 'asoc/fix/intel', 'asoc/fix/omap', 'asoc/fix/rockchip' and 'asoc/fix/rt286' into asoc-linus
      Merge remote-tracking branches 'asoc/fix/rt5677', 'asoc/fix/simple', 'asoc/fix/ts3a227e', 'asoc/fix/wm8904' and 'asoc/fix/wm8960' into asoc-linus

Oder Chiou (1):
      ASoC: rt5677: Modify the behavior that updates the PLL parameter.

Peter Rosin (1):
      ASoC: pcm512x: Fix DSP program selection

Peter Ujfalusi (1):
      ASoC: omap-mcbsp: Correct CBM_CFS dai format configuration

Qais Yousef (1):
      ASoC: soc-compress.c: fix NULL dereference

Zidan Wang (1):
      ASoC: wm8960: Fix capture sample rate from 11250 to 11025

 sound/soc/adi/axi-i2s.c           |  2 ++
 sound/soc/codecs/pcm512x.c        |  2 +-
 sound/soc/codecs/rt286.c          |  6 ++----
 sound/soc/codecs/rt5677.c         | 18 ++++++++++++++----
 sound/soc/codecs/ts3a227e.c       |  6 ++++++
 sound/soc/codecs/wm8904.c         | 23 +++++++++++++++--------
 sound/soc/codecs/wm8960.c         |  2 +-
 sound/soc/fsl/fsl_esai.h          |  2 +-
 sound/soc/fsl/fsl_ssi.c           |  4 ++--
 sound/soc/fsl/imx-wm8962.c        |  1 +
 sound/soc/generic/simple-card.c   |  7 +++----
 sound/soc/intel/sst-firmware.c    | 13 +++++++------
 sound/soc/intel/sst-haswell-ipc.c | 30 ++++++++++++++++++++++++++++++
 sound/soc/omap/omap-mcbsp.c       |  2 +-
 sound/soc/rockchip/rockchip_i2s.c |  1 +
 sound/soc/soc-compress.c          |  9 ++++++---
 16 files changed, 93 insertions(+), 35 deletions(-)

--/qNnUp0NPtZJWkzn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUxih/AAoJECTWi3JdVIfQVPIH/3GH10GfV908A2ZxwYZPvp1z
NxgIXkNeY3ag0gkmF/PhdEXVEbsFdFGW44B1iDYjzBnhnjhF8uh/VDZ5IYGMPqY0
e+YzHArzcxPuHZ7ajDWe4dzbgesqt45g/Z3FuI5xHBeYr5/9c+syDVQ5hzwF1X0Z
GJSMlJ5xuHQIQAumwFwKuRG14augR6a8A9xCVuMR2Ogu6pJEXyvzaqFZshieBZst
EfB138DvjSirIqbW0BQvNFrrqfow03RuppdPvFOeiHmnu7rh5XHFfyH5Ome9l76W
JMvwM9WjrMevvRRruffJwR1oeQmAFiOPeLlQmWXqJaQDk1qFcMaEf195qvqvYIY=
=sm2W
-----END PGP SIGNATURE-----

--/qNnUp0NPtZJWkzn--

--===============3259819799040364736==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3259819799040364736==--
