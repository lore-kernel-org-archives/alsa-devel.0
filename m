From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC updates for v4.0
Date: Fri, 6 Mar 2015 13:21:58 +0000
Message-ID: <20150306132158.GN21293@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4731170181461940042=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9A1C3265D98
 for <alsa-devel@alsa-project.org>; Fri,  6 Mar 2015 14:22:04 +0100 (CET)
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


--===============4731170181461940042==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="igkbtpF48MB53PeQ"
Content-Disposition: inline


--igkbtpF48MB53PeQ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit 13a7a6ac0a11197edcd0f756a035f472b42cdf8b:

  Linux 4.0-rc2 (2015-03-03 09:04:59 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc=
-fix-v4.0-rc2

for you to fetch changes up to 3b8f4a70b840cff298010481d39404e9c39030d1:

  Merge remote-tracking branch 'asoc/fix/sta32x' into asoc-linus (2015-03-0=
4 20:42:43 +0000)

----------------------------------------------------------------
ASoC: Fixes for v4.0

A few driver specific fixes here, none of them earth shattering in
themselves, that have accumliated since the opening of the merge window.

----------------------------------------------------------------
Alexandre Belloni (1):
      ASoC: sam9g20_wm8731: drop machine_is_xxx

Arnd Bergmann (2):
      ASoC: Samsung: add missing I2C/SPI dependencies
      ASoC: cirrus: tlv320aic23 needs I2C

Bard Liao (2):
      ASoC: rt5670: Fix the speaker mono output issue
      ASoC: rt5670: Set RT5670_IRQ_CTRL1 non volatile

Guenter Roeck (1):
      ASoC: Fix MAX98357A codec driver dependencies

Kenneth Westfield (1):
      ASoC: max98357a: Add missing header files

Kiran Padwal (1):
      ASoC: omap-hdmi-audio: Add missing error check for devm_kzalloc

Kuninori Morimoto (1):
      ASoC: rsnd: set device data before snd_soc_register_platform/component

Mark Brown (12):
      Merge remote-tracking branch 'asoc/fix/atmel-build' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/cirrus' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/fsl-ssi' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/intel' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/max98357a' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/omap' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/rsnd' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/rt5670' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/rt5677' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/samsung' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/simple' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/sta32x' into asoc-linus

Mengdong Lin (1):
      ASoC: Intel: set initial runtime PM status to active for ACPI-enumera=
ted ADSP

Nicolin Chen (1):
      ASoC: fsl_ssi: Fix the incorrect limitation of the bit clock rate

Oder Chiou (1):
      ASoC: rt5677: Correct the routing paths of that after IF1/2 DACx Mux

Peter Ujfalusi (1):
      ASoC: omap-pcm: Correct dma mask

Thomas Niederpr=FCm (2):
      ASoC: sta32x: fix register range in regmap.
      ASoC: OMAP: mcbsp: Fix CLKX and CLKR pinmux when used as inputs

Vincent Stehl=E9 (1):
      ASoC: max98357a: Fix missing include

Vinod Koul (3):
      ASoC: Intel: update MMX ID to 3
      ASoC: Intel: save and restore the CSR register
      ASoC: Intel: reset the DSP while suspending

Vishal Thanki (1):
      ASoC: simple-card: Add a NULL pointer check in asoc_simple_card_dai_l=
ink_of

 sound/soc/atmel/sam9g20_wm8731.c    | 68 +++++++++++++++++----------------=
----
 sound/soc/cirrus/Kconfig            |  2 +-
 sound/soc/codecs/Kconfig            |  2 +-
 sound/soc/codecs/max98357a.c        | 12 ++++++-
 sound/soc/codecs/rt5670.c           |  7 +++-
 sound/soc/codecs/rt5677.c           | 32 ++++++++---------
 sound/soc/codecs/sta32x.c           |  6 ++--
 sound/soc/fsl/fsl_ssi.c             | 11 +++---
 sound/soc/generic/simple-card.c     |  5 +++
 sound/soc/intel/sst-atom-controls.h |  2 +-
 sound/soc/intel/sst/sst.c           | 10 +++++-
 sound/soc/omap/omap-hdmi-audio.c    |  3 ++
 sound/soc/omap/omap-mcbsp.c         | 11 ++++++
 sound/soc/omap/omap-pcm.c           |  2 +-
 sound/soc/samsung/Kconfig           | 10 +++---
 sound/soc/sh/rcar/core.c            |  4 +--
 16 files changed, 112 insertions(+), 75 deletions(-)

--igkbtpF48MB53PeQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEbBAEBCAAGBQJU+an2AAoJECTWi3JdVIfQByQH+MZkkFgzkotfLSk3JZmEjHuv
4ufVm1yKhXOFjzSiIMiRB65WkKwx9vXfCmAXCeo+1VWA1ELgBSTB9emN4VkCHNlV
zUc/QXH4S/vfhJS43eKuZqxo69WmNy4wpoUkucjEigwxHnnxU21NO7WS3jOILHVS
G2ArxV/qJBEzY/wk7MXt8JSd1xNNszvCwOb6JCjpscGdg17uyD1haqIa9ZskPsGU
4TshG8LOlaM4QDmvFDIxuf/xmjcW/+IPshkIphNuIi0Og8Toi9DiSeyPm9QLIwSi
rddbTFDzXuBEfZbQ/vGDdl4SqLlxgunV3tRNHcWfQB9qCCJ8cXBt7XjiAKtneQ==
=w1dE
-----END PGP SIGNATURE-----

--igkbtpF48MB53PeQ--

--===============4731170181461940042==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4731170181461940042==--
