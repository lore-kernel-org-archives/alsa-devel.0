From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v3 00/13] Enable HDA Codec support on Intel
	Platforms
Date: Fri,  1 Jun 2018 22:53:48 -0500
Message-ID: <20180602035401.26934-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id A55B326783D
 for <alsa-devel@alsa-project.org>; Sat,  2 Jun 2018 05:54:11 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, rakesh.a.ughreja@intel.com
List-Id: alsa-devel@alsa-project.org

Many Intel platforms (SKL, KBL) etc. in the market supports enhanced
audio capabilities which also includes DSP processing. The default
HDaudio legacy driver does not allow for the use of the DSP, this
patch set makes it possible while reusing existing code for HDAudio
codecs and without significant changes to the legacy driver.

This v3 is not split into two batches as done for v1 and v2, but keeps
the same logical progression. The first three patches are mostly data
structure changes, the DSP support capability is added then with an
ASoC HDA driver and the last patches are fixes required for
Skylake+. The changes to the HDAudio legacy driver are minimal.

Tests were run successfully on multiple platforms (Dell XPS13, KBL
NUC, APL NUC and LeafHill reference board).

Credits: all the initial code was written by Rakesh Ughreja, the
rebase to broonie/for-next, cleanups and additional tests were done by
Pierre Bossart.

Changes v3:
- port to component model
- additional tests on ApolloLake and KabyLake NUC devices
- cleanups (alignment, typos, etc)

Changes v2:
- Resolved review comments and rebased to latest kernel.
- added module load support for codec drivers.

Rakesh Ughreja (13):
  ALSA: hdac: Remove usage of struct hdac_ext_device and use hdac_device
    instead
  ALSA: hdac: Remove usage of struct hdac_ext_bus and use hdac_bus
    instead
  ALSA: hdac: Remove usage of struct hdac_ext_driver, use hdac_driver
    instead
  ASoC: Intel: Boards: Machine driver for SKL+ w/ HDAudio codecs
  ASoC: Intel: Skylake: Add entry in sst_acpi_mach for HDA codecs
  ASoC: Intel: Skylake: add HDA BE DAIs
  ASoC: Intel: Skylake: use hda_bus instead of hdac_bus
  ALSA: hda: split snd_hda_codec_new function
  ALSA: hdac: remove memory allocation from snd_hdac_ext_bus_device_init
  ALSA: hdac: add extended ops in the hdac_bus
  ASoC: hdac_hda: add asoc extension for legacy HDA codec drivers
  ALSA: hdac: ext: add wait for codec to respond after link reset
  ASoC: Intel: Skylake: fix widget handling

 include/sound/hdaudio.h                      |  29 ++
 include/sound/hdaudio_ext.h                  | 123 ++-----
 sound/hda/ext/hdac_ext_bus.c                 |  80 ++---
 sound/hda/ext/hdac_ext_controller.c          |  64 ++--
 sound/hda/ext/hdac_ext_stream.c              | 104 +++---
 sound/pci/hda/hda_bind.c                     |  12 +
 sound/pci/hda/hda_codec.c                    |  68 +++-
 sound/pci/hda/hda_codec.h                    |   2 +
 sound/soc/codecs/Kconfig                     |   5 +
 sound/soc/codecs/Makefile                    |   2 +
 sound/soc/codecs/hdac_hda.c                  | 469 +++++++++++++++++++++++++++
 sound/soc/codecs/hdac_hda.h                  |  24 ++
 sound/soc/codecs/hdac_hdmi.c                 | 416 +++++++++++-------------
 sound/soc/intel/boards/Kconfig               |   9 +
 sound/soc/intel/boards/Makefile              |   2 +
 sound/soc/intel/boards/skl_hda_dsp_common.c  | 133 ++++++++
 sound/soc/intel/boards/skl_hda_dsp_common.h  |  37 +++
 sound/soc/intel/boards/skl_hda_dsp_generic.c | 174 ++++++++++
 sound/soc/intel/skylake/skl-messages.c       |  50 ++-
 sound/soc/intel/skylake/skl-nhlt.c           |   8 +-
 sound/soc/intel/skylake/skl-pcm.c            | 182 +++++++----
 sound/soc/intel/skylake/skl-topology.c       |  23 +-
 sound/soc/intel/skylake/skl-topology.h       |   6 +-
 sound/soc/intel/skylake/skl.c                | 296 +++++++++++------
 sound/soc/intel/skylake/skl.h                |  13 +-
 25 files changed, 1640 insertions(+), 691 deletions(-)
 create mode 100644 sound/soc/codecs/hdac_hda.c
 create mode 100644 sound/soc/codecs/hdac_hda.h
 create mode 100644 sound/soc/intel/boards/skl_hda_dsp_common.c
 create mode 100644 sound/soc/intel/boards/skl_hda_dsp_common.h
 create mode 100644 sound/soc/intel/boards/skl_hda_dsp_generic.c

-- 
2.14.1
