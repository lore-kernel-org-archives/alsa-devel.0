From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC fixes for v5.0
Date: Fri, 18 Jan 2019 12:54:53 +0000
Message-ID: <20190118125453.GB6260@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2049960650604749242=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 31FB72667E7
 for <alsa-devel@alsa-project.org>; Fri, 18 Jan 2019 13:54:55 +0100 (CET)
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


--===============2049960650604749242==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tsOsTdHNUZQcU9Ye"
Content-Disposition: inline


--tsOsTdHNUZQcU9Ye
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit a7a850dba82498a1e050d8d153cae67ce0edb3b2:

  Merge branch 'asoc-4.21' into asoc-next (2018-12-18 12:23:59 +0000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v5.0-rc2

for you to fetch changes up to 4cb79ef9c6c4413427cd70afbb1f3bc01e9b7abf:

  ASoC: amd: Fix potential NULL pointer dereference (2019-01-15 19:06:23 +0000)

----------------------------------------------------------------
ASoC: Fixes for v5.0

Quite a big batch of fixes here.  There's a couple of things going on,
the main one is that we found some issues with not deferring probe when
we should, causing us to skip some driver initialization.  The fixes for
this then in turn exposed some issues with how we were searching for
components which had previously gone unnoticed due to the original
issue.

There's also been the normal driver specific stuff and there's been what
looks like several batches of automated scanning for issues which have
generated quite a large set of smaller fixes for potential crashes and
missed error handling.

----------------------------------------------------------------

Should probably have pointed out that the DaVinci runtime PM fix here is
a big diff but mostly code motion, it fixes problems where the device
would stop working after runtime PM.

Ajit Pandey (1):
      ASoC: soc-core: defer card probe until all component is added to list

Curtis Malainey (1):
      ASoC: soc-core: fix init platform memory handling

Dan Carpenter (6):
      ASoC: dma-sh7760: cleanup a debug printk
      ASoC: pcm512x: Fix a double unlock in pcm512x_digital_mute()
      ASoC: qdsp6: q6asm-dai: Off by one in of_q6asm_parse_dai_data()
      ASoC: qdsp6: q6asm-dai: Fix a NULL vs IS_ERR() bug
      ASoC: qdsp6: q6asm-dai: Fix a small memory leak
      ALSA: compress: prevent potential divide by zero bugs

Geert Uytterhoeven (1):
      ASoC: xlnx: Grammar s/the the/the/

Gustavo A. R. Silva (2):
      ASoC: rt5514-spi: Fix potential NULL pointer dereference
      ASoC: amd: Fix potential NULL pointer dereference

Kangjie Lu (1):
      ASoC: atom: fix a missing check of snd_pcm_lib_malloc_pages

Mac Chiang (1):
      ASoC: Intel: Boards: move the codec PLL configuration to _init

Mark Brown (1):
      ASoC: core: Make snd_soc_find_component() more robust

Maruthi Srinivas Bayyavarapu (1):
      ASoC: xlnx: change license header format style

Matthias Reichl (1):
      ASoC: core: Don't defer probe on optional, NULL components

Peter Ujfalusi (1):
      ASoC: ti: davinci-mcasp: Move context save/restore to runtime_pm callbacks

Rander Wang (1):
      ASoC: Intel: Haswell/Broadwell: fix setting for .dynamic field

Rohit kumar (2):
      ASoC: sdm845: set jack only for a specific backend
      ASoC: soc-core: Hold client_mutex around soc_init_dai_link()

Shuming Fan (2):
      ASoC: rt5682: Fix recording no sound issue
      ASoC: rt5682: Fix PLL source register definitions

Silvio Cesare (2):
      ASoC: dapm: change snprintf to scnprintf for possible overflow
      ASoC: imx-audmux: change snprintf to scnprintf for possible overflow

Sinan Kaya (1):
      ASoC: Intel: atom: Make PCI dependency explicit

Yizhuo (1):
      ASoC: Variable "val" in function rt274_i2c_probe() could be uninitialized

b-ak (1):
      ASoC: tlv320aic32x4: Kernel OOPS while entering DAPM standby mode

 include/sound/soc.h                           |   6 ++
 sound/core/compress_offload.c                 |   3 +-
 sound/soc/amd/raven/acp3x-pcm-dma.c           |   6 +-
 sound/soc/codecs/pcm512x.c                    |  11 +--
 sound/soc/codecs/rt274.c                      |   5 +-
 sound/soc/codecs/rt5514-spi.c                 |   2 +
 sound/soc/codecs/rt5682.c                     |   1 +
 sound/soc/codecs/rt5682.h                     |  24 ++---
 sound/soc/codecs/tlv320aic32x4.c              |   4 +
 sound/soc/fsl/imx-audmux.c                    |  24 ++---
 sound/soc/intel/Kconfig                       |   2 +-
 sound/soc/intel/atom/sst-mfld-platform-pcm.c  |   8 +-
 sound/soc/intel/boards/broadwell.c            |   2 +-
 sound/soc/intel/boards/glk_rt5682_max98357a.c |  45 ++-------
 sound/soc/intel/boards/haswell.c              |   2 +-
 sound/soc/qcom/qdsp6/q6asm-dai.c              |  17 +++-
 sound/soc/qcom/sdm845.c                       |  31 ++++--
 sound/soc/sh/dma-sh7760.c                     |   2 +-
 sound/soc/soc-core.c                          |  34 +++++--
 sound/soc/soc-dapm.c                          |  10 +-
 sound/soc/ti/davinci-mcasp.c                  | 136 ++++++++++++--------------
 sound/soc/xilinx/Kconfig                      |   2 +-
 sound/soc/xilinx/xlnx_i2s.c                   |  15 ++-
 23 files changed, 208 insertions(+), 184 deletions(-)

--tsOsTdHNUZQcU9Ye
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxBzJ0ACgkQJNaLcl1U
h9BIWAf+JjyRP5A/88jzVj7jUPJ816z0GDXIqT21UB/di4oxZuLDrfDWFpl5lLB8
u87GVE91jwHrizwaNqzLJSfx95JcL5xAQXz7tGOWmao/mSbntY0+cO6cv+QxPv5E
PD0psrwUeP4ZSM2SXpuL2r5/gHyk6alH3nilCvyu4W833EvoP08NTG3DQOEjS7sJ
uJ9TT0J4lF3D81GrzX87Yp43mEloTsI0WfSwt2SxAOGjuSIxFpBeGwth05Ui5j6q
l1a1Fd5PDCqfV8N/M+fP8ohk2l3QFIMxCR09M4x8xvUG/FC+jRuoo9fpsRDednph
02URkeuoTF9ZHC8WQMOmPPvOX0x4SQ==
=dO5J
-----END PGP SIGNATURE-----

--tsOsTdHNUZQcU9Ye--

--===============2049960650604749242==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2049960650604749242==--
