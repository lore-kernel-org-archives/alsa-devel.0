From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.38
Date: Fri, 3 Dec 2010 17:46:33 +0000
Message-ID: <20101203174633.GZ859@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A4C3E103B86
	for <alsa-devel@alsa-project.org>; Fri,  3 Dec 2010 18:46:35 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

The following changes since commit 649e5fb033bbadbfa78aba5e2711f1faf2affaf0:

  Merge branch 'for-2.6.37' into for-2.6.38 (2010-11-29 18:33:47 +0000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2=
.6.38

Axel Lin (4):
      ASoC: Fix missing spin_unlock_irqrestore
      ASoC: Simplify pm860x_probe error handling
      ASoC: ak4535: Improve readability for setting mute
      ASoC: Fix inconsistent meaning of default case while checking alc5623=
->id

Daniel Gl=F6ckner (3):
      s6000-i2s: fix compilation
      s6000-pcm: fix compilation
      s6105-ipcam: fix compilation

Dimitris Papastamos (7):
      ASoC: soc-cache: Fix memory overflow in LZO initialization
      ASoC: WM8731: Fix incorrect mask for bypass path disable
      ASoC: Add compress_type as a member to snd_soc_codec
      ASoC: Change the base value of compress_type
      ASoC: soc-core: Generalize snd_soc_prefix_map and rename to snd_soc_c=
odec_conf
      ASoC: soc-cache: Use reg_def_copy instead of reg_cache_default
      ASoC: soc-core: Allow machine drivers to override compress_type

Jarkko Nikula (4):
      ASoC: Add support for optional auxiliary dailess codecs
      ASoC: Fix build failure in soc-core.c
      ASoC: omap: N810: Don't select CONFIG_OMAP_MUX but make it as depende=
ncy
      ASoC: Don't oops in soc_probe_aux_dev in case of missing codec

Jassi Brar (1):
      ASoC: WM8580: Debug interface index

Kuninori Morimoto (8):
      ASoC: sh: fsi-ak4642: Add FSI port and ak464x selection
      ASoC: sh: fsi-ak4642: tidyup unnecessary variables
      ASoC: sh: fsi-ak4642: midify card name
      ASoC: sh: fsi: clean up SPDIF defines
      ASoC: sh: fsi: remove fsi_master_write
      ASoC: sh: fsi: change fsi->mst_ctrl to master->a/b_mclk
      ASoC: sh: fsi: remove runtime register check from fsi_reg_xxx
      ASoC: sh: fsi: remove runtime register check from fsi_master_xxx

Mark Brown (14):
      Merge branch 'for-2.6.37' into for-2.6.38
      Merge branch 'for-2.6.37' into for-2.6.38
      ASoC: Correct event flags for WM8958 AIF DACs
      ASoC: Allow user-specified WM8958 multiband compressor configurations
      ASoC: Provide WM8731 microphone boost TLV information
      ASoC: Split WM8731 enumeration array into individual enums
      ASoC: Automatically manage WM8731 deemphasis
      ASoC: Tune performance of WM8958 revision A
      ASoC: Apostrophe patrol in soc-core.c
      ASoC: Make the DAI ops constant in the DAI structure
      ASoC: Move active copy of CODEC read and write into runtime structure
      ASoC: Constify struct snd_soc_codec_driver
      ASoC: When disabling WM8994 FLL force a source selection
      Merge branch 'for-2.6.37' into for-2.6.38

Takashi Iwai (1):
      Merge branch 'for-2.6.37' of git://git.kernel.org/.../lrg/asoc-2.6 in=
to fix/asoc

 arch/arm/mach-shmobile/board-ap4evb.c |    5 +
 arch/sh/boards/mach-se/7724/setup.c   |    5 +
 include/linux/mfd/wm8994/pdata.h      |   17 ++
 include/linux/mfd/wm8994/registers.h  |   77 +++++++++
 include/sound/soc-dai.h               |    2 +-
 include/sound/soc.h                   |   46 +++++-
 sound/soc/codecs/88pm860x-codec.c     |   12 +-
 sound/soc/codecs/ak4535.c             |   10 +-
 sound/soc/codecs/alc5623.c            |   10 +-
 sound/soc/codecs/wm8580.c             |    8 +-
 sound/soc/codecs/wm8731.c             |   88 ++++++++++-
 sound/soc/codecs/wm8994.c             |  129 ++++++++++++++--
 sound/soc/nuc900/nuc900-pcm.c         |    9 +-
 sound/soc/omap/Kconfig                |    2 +-
 sound/soc/s6000/s6000-i2s.c           |    2 +-
 sound/soc/s6000/s6000-pcm.c           |    2 +-
 sound/soc/s6000/s6105-ipcam.c         |    2 +-
 sound/soc/sh/fsi-ak4642.c             |  140 +++++++++++++++--
 sound/soc/sh/fsi.c                    |  207 +++++++++++--------------
 sound/soc/soc-cache.c                 |   58 ++++---
 sound/soc/soc-core.c                  |  275 +++++++++++++++++++++++++++++=
---
 21 files changed, 867 insertions(+), 239 deletions(-)
