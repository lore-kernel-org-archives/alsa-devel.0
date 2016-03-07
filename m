From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC fixes for v4.5
Date: Mon, 7 Mar 2016 09:47:51 +0700
Message-ID: <20160307024751.GQ18327@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2511868251793606895=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CED992605C3
 for <alsa-devel@alsa-project.org>; Mon,  7 Mar 2016 03:47:57 +0100 (CET)
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


--===============2511868251793606895==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vF2tWILZsT7mvGY4"
Content-Disposition: inline


--vF2tWILZsT7mvGY4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit fc77dbd34c5c99bce46d40a2491937c3bcbd10af:

  Linux 4.5-rc6 (2016-02-28 08:41:20 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc=
-fix-v4.5-rc6

for you to fetch changes up to 02db17ff376893f65f45974b0897e70e6695034e:

  Merge remote-tracking branches 'asoc/fix/wm8985', 'asoc/fix/wm8994', 'aso=
c/fix/wm8996', 'asoc/fix/wm9081' and 'asoc/fix/wm9713' into asoc-linus (201=
6-03-05 21:27:13 +0900)

----------------------------------------------------------------
ASoC: Fixes for v4.5

This is far too big a set of fixes for this late in the release cycle
but the overwhelming bulk is essentially the same simple fix from
Takashi for a cut'n'pasted 64 bit cleanliness issue in the userspace
interface where drivers were accessing things using the wrong element in
a union which worked OK on 32 bit platforms as the correct element
happened to be aligned the same way but with 64 bit platforms ABIs are
different and the two members of the union are laid out in different
places.  They aren't all tagged to stable since some of these chips have
vanishingly little chance of being used in 64 bit systems.

The other changes are:
 - A fix for Qualcomm devices to work on big endian systems.  The
   original change is actually correct but triggered a bug in regmap
   which is too invasive to fix for this cycle and can be worked around
   by just letting regmap pick the default.
 - A fix for the Samsung I2S driver locking which wasn't using IRQ safe
   spinlocks when it needed to.
 - A fix for the new Intel Sky Lake driver forgetting that C pointer
   arithmetic takes the type of the pointer into consideration.
 - A revert of a change to the FSL SSI driver that broke some systems.
 - A fix for the cleanup path of the wm9713 driver.
 - A fix for some incorrect register definitions in the ADAU17x1 driver
   that caused misclocking in some configurations.
 - A fix for the tracepoints for jack detection to avoid using an
   internal field of the core jack structure which is no longer present
   in all configurations.
 - A fix for another of the new Intel drivers which tried to write to a
   string literal.

----------------------------------------------------------------
Alan (1):
      ASoC: Intel: Skylake: fix pointer scaling

Andreas Irest=E5l (1):
      ASoC: adau17x1: Fix incorrect BCLK ratio definitions

Arnd Bergmann (1):
      ASoC: trace: fix printing jack name

Carlo Caione (1):
      ASoC: cht_bsw_rt5645: Fix writing to string literal

Charles Keepax (1):
      ASoC: samsung: Use IRQ safe spin lock calls

Fabio Estevam (1):
      ASoC: fsl_ssi: Go back to explicit register defaults

Mark Brown (6):
      Merge remote-tracking branch 'asoc/fix/dapm' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/intel' into asoc-linus
      Merge remote-tracking branches 'asoc/fix/ab8500', 'asoc/fix/adau17x1'=
, 'asoc/fix/adsp', 'asoc/fix/cs42l51', 'asoc/fix/da732x' and 'asoc/fix/fsl-=
ssi' into asoc-linus
      Merge remote-tracking branches 'asoc/fix/jack', 'asoc/fix/max98088', =
'asoc/fix/max98095', 'asoc/fix/omap', 'asoc/fix/pxa' and 'asoc/fix/qcom-be'=
 into asoc-linus
      Merge remote-tracking branches 'asoc/fix/samsung', 'asoc/fix/tlv320da=
c33', 'asoc/fix/wl1273', 'asoc/fix/wm8753', 'asoc/fix/wm8904', 'asoc/fix/wm=
8958' and 'asoc/fix/wm8983' into asoc-linus
      Merge remote-tracking branches 'asoc/fix/wm8985', 'asoc/fix/wm8994', =
'asoc/fix/wm8996', 'asoc/fix/wm9081' and 'asoc/fix/wm9713' into asoc-linus

Robert Jarzmik (1):
      ASoC: wm9713: fix regmap free path

Stephen Boyd (1):
      ASoC: qcom: Don't specify LE device endianness

Takashi Iwai (25):
      ASoC: dapm: Fix ctl value accesses in a wrong type
      ASoC: pxa: corgi: Fix enum ctl accesses in a wrong type
      ASoC: pxa: magician: Fix enum ctl accesses in a wrong type
      ASoC: pxa: poodle: Fix enum ctl accesses in a wrong type
      ASoC: pxa: spitz: Fix enum ctl accesses in a wrong type
      ASoC: pxa: tosa: Fix enum ctl accesses in a wrong type
      ASoC: omap: n810: Fix enum ctl accesses in a wrong type
      ASoC: omap: rx51: Fix enum ctl accesses in a wrong type
      ASoC: intel: mfld: Fix enum ctl accesses in a wrong type
      ASoC: cs42l51: Fix enum ctl accesses in a wrong type
      ASoC: da732x: Fix enum ctl accesses in a wrong type
      ASoC: ab8500: Fix enum ctl accesses in a wrong type
      ASoC: max98088: Fix enum ctl accesses in a wrong type
      ASoC: max98095: Fix enum ctl accesses in a wrong type
      ASoC: tlv320dac33: Fix enum ctl accesses in a wrong type
      ASoC: wl1273: Fix enum ctl accesses in a wrong type
      ASoC: wm8753: Fix enum ctl accesses in a wrong type
      ASoC: wm8904: Fix enum ctl accesses in a wrong type
      ASoC: wm8958: Fix enum ctl accesses in a wrong type
      ASoC: wm8983: Fix enum ctl accesses in a wrong type
      ASoC: wm8985: Fix enum ctl accesses in a wrong type
      ASoC: wm8994: Fix enum ctl accesses in a wrong type
      ASoC: wm8996: Fix enum ctl accesses in a wrong type
      ASoC: wm9081: Fix enum ctl accesses in a wrong type
      ASoC: wm_adsp: Fix enum ctl accesses in a wrong type

 include/trace/events/asoc.h             |  8 +++----
 sound/soc/codecs/ab8500-codec.c         |  8 +++----
 sound/soc/codecs/adau17x1.h             |  6 ++---
 sound/soc/codecs/cs42l51.c              |  8 +++----
 sound/soc/codecs/da732x.c               |  8 +++----
 sound/soc/codecs/max98088.c             |  2 +-
 sound/soc/codecs/max98095.c             |  4 ++--
 sound/soc/codecs/tlv320dac33.c          |  9 ++++---
 sound/soc/codecs/wl1273.c               | 13 +++++-----
 sound/soc/codecs/wm8753.c               |  6 ++---
 sound/soc/codecs/wm8904.c               |  4 ++--
 sound/soc/codecs/wm8958-dsp2.c          |  8 +++----
 sound/soc/codecs/wm8983.c               | 14 +++++------
 sound/soc/codecs/wm8985.c               | 14 +++++------
 sound/soc/codecs/wm8994.c               |  4 ++--
 sound/soc/codecs/wm8996.c               |  2 +-
 sound/soc/codecs/wm9081.c               |  8 +++----
 sound/soc/codecs/wm9713.c               |  2 +-
 sound/soc/codecs/wm_adsp.c              |  8 +++----
 sound/soc/fsl/fsl_ssi.c                 | 42 ++++++++++++++++-------------=
----
 sound/soc/intel/boards/cht_bsw_rt5645.c |  6 ++++-
 sound/soc/intel/boards/mfld_machine.c   | 16 ++++++-------
 sound/soc/intel/skylake/skl-topology.c  |  2 +-
 sound/soc/omap/n810.c                   | 18 +++++++-------
 sound/soc/omap/rx51.c                   | 18 +++++++-------
 sound/soc/pxa/corgi.c                   | 12 +++++-----
 sound/soc/pxa/magician.c                |  6 ++---
 sound/soc/pxa/poodle.c                  | 12 +++++-----
 sound/soc/pxa/spitz.c                   | 12 +++++-----
 sound/soc/pxa/tosa.c                    | 12 +++++-----
 sound/soc/qcom/lpass-cpu.c              |  1 -
 sound/soc/samsung/i2s.c                 | 21 ++++++++++-------
 sound/soc/soc-dapm.c                    |  8 +++----
 33 files changed, 162 insertions(+), 160 deletions(-)

--vF2tWILZsT7mvGY4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW3OvWAAoJECTWi3JdVIfQ9k8H/0dkTeQU8pjr8Nup/q+H6egN
B6KmoTHV8jjMzTMa+2LkSsKKIawqcPi+Ct4+lxbNFaH1VJlsvlPnQ+7qQO3glW3T
2hBUm+J5CErUf19qUh9TwVCGoiDCJEAR3PEtNEQ6fKnssVPQQ0tCGEKQRfOQox33
CeLoG9RiCazH0oYsiWwzj6HrirTaxq1dsN/kgUKWr6U5YkVZBLlT8kiItl3zdvM2
Qc2v5iswaREJW5oH2qUJzCVP00fAuNUz98E/HeqXvmdVGM7Uun9QkWHn74Q46Wzy
MOCY6ctv99XXbWrAU/Db69UdpKB2BaRIAKKmf0ZxCucV3Kv5BR/ydi9DKiod0zg=
=2Fg4
-----END PGP SIGNATURE-----

--vF2tWILZsT7mvGY4--

--===============2511868251793606895==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2511868251793606895==--
