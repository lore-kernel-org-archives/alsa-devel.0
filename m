From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC fixes for v4.4
Date: Fri, 27 Nov 2015 12:35:44 +0000
Message-ID: <20151127123544.GP1929@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6332443168548289574=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D99972608ED
 for <alsa-devel@alsa-project.org>; Fri, 27 Nov 2015 13:35:49 +0100 (CET)
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


--===============6332443168548289574==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6kpOI20Kt7FNSDww"
Content-Disposition: inline


--6kpOI20Kt7FNSDww
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 1ec218373b8ebda821aec00bb156a9c94fad9cd4:

  Linux 4.4-rc2 (2015-11-22 16:45:59 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v4.4-rc2

for you to fetch changes up to 923f1cbf2e45f6292a01de959031a8efeabede78:

  Merge remote-tracking branches 'asoc/fix/rt5677', 'asoc/fix/st', 'asoc/fix/sun4i-codec', 'asoc/fix/topology', 'asoc/fix/wm8960' and 'asoc/fix/wm8962' into asoc-linus (2015-11-25 17:57:54 +0000)

----------------------------------------------------------------
ASoC: Fixes for v4.4

Quite a large batch of fixes have come in since the merge window, mainly
driver specific ones but there's a couple of core ones:

 - A fix for DAPM resume on active streams to ensure everything ends up
   cleanly in the right state.
 - Reset the DAPM cache when freeing widgets to fix a crash on driver
   remove and reload.

The PM functions for nau8825 are new code which fix crashes on resume.

----------------------------------------------------------------

Also the rt5677 changes look big but are very mechanical (making two
simple changes repeatedly).

Adam Sampson (1):
      ASoC: sun4i-codec: use consistent names for PA controls

Andreas Dannenberg (1):
      ASoC: davinci-mcasp: Fix TDM slot rx/tx mask associations

Arnd Bergmann (2):
      ASoC: fix rockchip 64-bit build warning
      ASoC: fsl: clarify ac97 dependency

Bard Liao (4):
      ASoC: rl6231: avoid using divisible by 3 for DMIC clk
      ASoC: rt5670: fix wrong bit def for pll src
      ASoC: rt5645: Add dmi_system_id "Google Wizpig"
      ASoC: rt5645: Add dmi_system_id "Google Terra"

Jeeja KP (1):
      ASoC: core: Change power state before rechecking endpoint

John Keeping (1):
      ASoC: es8328: Fix shifts for mixer switches

John Lin (3):
      ASoC: rl6231: fix range of DMIC clock
      ASoC: rt5645: Increase the delay time to imporve the HP pop noise
      ASoC: rt5645: Add struct dmi_system_id "Google Edgar" for Chrome OS

JongHo Kim (1):
      ASoC: wm8960: Fix the Input PGA Mute switch

Jyri Sarha (1):
      ASoC: dapm: Reset dapm wcache after freeing damp widgets

Kuninori Morimoto (2):
      ASoC: rsnd: fixup SCU_SYS_INT_EN1 address
      ASoC: rsnd: make sure SRC In Rate feature enablement

Mark Brown (7):
      Merge tag 'asoc-v4.3-rc6' into asoc-fix-rcar
      Merge remote-tracking branch 'asoc/fix/arizona' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/dapm' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/rt5645' into asoc-linus
      Merge remote-tracking branches 'asoc/fix/davinci', 'asoc/fix/es8328', 'asoc/fix/fsl', 'asoc/fix/fsl-sai' and 'asoc/fix/intel' into asoc-linus
      Merge remote-tracking branches 'asoc/fix/nau8825', 'asoc/fix/ops', 'asoc/fix/rcar', 'asoc/fix/rl6231', 'asoc/fix/rockchip' and 'asoc/fix/rt5670' into asoc-linus
      Merge remote-tracking branches 'asoc/fix/rt5677', 'asoc/fix/st', 'asoc/fix/sun4i-codec', 'asoc/fix/topology', 'asoc/fix/wm8960' and 'asoc/fix/wm8962' into asoc-linus

Moise Gergaud (3):
      ASoC: sti: remove wrong error message
      ASoC: sti: rename ST proprietary DT properties
      ASoC: sti: set player private data

Oder Chiou (2):
      ASoC: rt5645: Power up the RC clock to make sure the speaker volume adjust properly
      ASoC: rt5677: Avoid the pop sound that comes from the filter power

Omair M Abdullah (1):
      ASoC: topology: fix info callback for TLV byte control

Peter Ujfalusi (1):
      ASoC: davinci-mcasp: Fix master capture only mode

Randy Dunlap (1):
      ASoC: fix kernel-doc warnings in sound/soc/soc-ops.c

Richard Fitzgerald (1):
      ASoC: arizona: fix range of OPCLK_REF

Sachin Pandhare (1):
      ASoC: wm8962: correct addresses for HPF_C_0/1

Sjoerd Simons (1):
      ASoC: rockchip: Fix incorrect VDW value for 24 bit

Stefan Agner (1):
      ASoC: fsl_sai: fix Rx synchrounous mode

Sudip Mukherjee (1):
      ASoC: Intel: Skylake: fix memory leak

Vinod Koul (1):
      ASoC: Intel: Skylake: Add I2C depends for SKL machine

Yong Zhi (1):
      ASoC: nau8825: add pm function

 include/sound/soc-dapm.h               |   1 +
 sound/soc/codecs/arizona.c             |  16 ++----
 sound/soc/codecs/es8328.c              |  16 +++---
 sound/soc/codecs/nau8825.c             |  31 ++++++++++
 sound/soc/codecs/rl6231.c              |   6 +-
 sound/soc/codecs/rt5645.c              |  61 ++++++++++++++++++--
 sound/soc/codecs/rt5670.h              |  12 ++--
 sound/soc/codecs/rt5677.c              | 100 ++++++++++++++++++++-------------
 sound/soc/codecs/wm8960.c              |   2 +-
 sound/soc/codecs/wm8962.c              |   4 +-
 sound/soc/davinci/davinci-mcasp.c      |  12 +++-
 sound/soc/fsl/Kconfig                  |   2 +
 sound/soc/fsl/fsl_sai.c                |   3 +-
 sound/soc/intel/Kconfig                |   2 +-
 sound/soc/intel/skylake/skl-topology.c |   1 +
 sound/soc/rockchip/rockchip_spdif.c    |   2 +-
 sound/soc/rockchip/rockchip_spdif.h    |   6 +-
 sound/soc/sh/rcar/gen.c                |   2 +-
 sound/soc/sh/rcar/src.c                |   7 +++
 sound/soc/soc-core.c                   |   6 +-
 sound/soc/soc-dapm.c                   |   7 +++
 sound/soc/soc-ops.c                    |   2 +-
 sound/soc/soc-topology.c               |   3 +-
 sound/soc/sti/uniperif_player.c        |   9 ++-
 sound/soc/sti/uniperif_reader.c        |   3 +-
 sound/soc/sunxi/sun4i-codec.c          |  27 ++++-----
 26 files changed, 238 insertions(+), 105 deletions(-)

--6kpOI20Kt7FNSDww
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWWE4fAAoJECTWi3JdVIfQ9bUH/2Dk6mUt7CPEOMeqswTlrmcy
MMxrLwzBDtYXhivEr1PkVt3LaoOEHb+CBAZrc0XKlij6d+2rf7bI6D1TIS3vuEZ5
nIuGtkdAOwdCiMRsT8JM4YXJasvdZOneW9z+EgASrsCZB+RasdtGflnb7X+A20Uf
1E6yEIYQOnG9pIG+GnWWZHM3IllZqs/4aeyPbDKCiMy+Zz/YbP2l2bvY0PQkY49Y
yhH4Q8GvWq+fQWqiLmxfY9d0cnm4kYnnJPNDW09NyYt32a6mDhAtqUYBbP7wbsi/
01hWv/FTDVvHg+Prasq03gSLXeJojx++N8denIpGEoPEZeDpVwKA1ktjtCnlTFg=
=NOS3
-----END PGP SIGNATURE-----

--6kpOI20Kt7FNSDww--

--===============6332443168548289574==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6332443168548289574==--
