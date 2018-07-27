From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v5 0/8] Enable HDA Codec support on Intel
	Platforms
Date: Fri, 27 Jul 2018 18:05:46 -0500
Message-ID: <20180727230554.31027-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id B323E2675D4
 for <alsa-devel@alsa-project.org>; Sat, 28 Jul 2018 01:06:19 +0200 (CEST)
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
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Many Intel platforms (SKL, KBL) etc. in the market supports enhanced
audio capabilities which also includes DSP processing. The default
HDaudio legacy driver does not allow for the use of the DSP, this
patch set makes it possible while reusing existing code for HDAudio
codecs and without significant changes to the legacy driver.

This v5 is based on Takashi's topic/drm_audio_component merged on top
on Marks' for-next branch - the merge is not included here.

Tests were run successfully on multiple platforms (Dell XPS13, KBL
NUC, APL NUC and LeafHill reference board). Both the HDaudio and HDMI
outputs were tested.

Credits: all the initial code was written by Rakesh Ughreja, the
rebase to broonie/for-next, cleanups and additional tests were done by
Pierre Bossart.

TODO in future update: fix the HDMI jack detection which only works
after the mixer values are set, which isn't practical for headless
devices always connected (this is a problem in the hdac_hdmi codec
that was present before this series was submitted)

Changes v5 (comments from Vinod)
- fix SPDIF style across patches
- patch 1: update commit message to remove reference to "fix"
- patch 3: remove platform name assignment and Xmas tree style
- patch 7: simplify error handling, add missing _put() on errors,
  	   remove tests on ops, add switch statement, fix alignment
- patch 8: fix indentation issues, use bool instead of tristate

Changes v4:
- rebase/update on Takashi's topic/drm_audio_component branch
- changes in the HDaudio detection to avoid adding a fake ACPI ID
- new Kconfigs to control HDaudio detection

Changes v3:
- port to component model
- additional tests on ApolloLake and KabyLake NUC devices
- cleanups (alignment, typos, etc)

Changes v2:
- Resolved review comments and rebased to latest kernel.
- added module load support for codec drivers.

Pierre-Louis Bossart (2):
  ASoC: Intel: common: add table for HDA-based platforms
  ASoC: Intel: Skylake: add option to control HDAudio + DSP usage

Rakesh Ughreja (6):
  ASoC: Intel: Skylake: extend widget handling
  ASoC: Intel: Boards: Machine driver for SKL+ w/ HDAudio codecs
  ASoC: Intel: Skylake: use HDAudio if ACPI enumeration fails
  ASoC: Intel: Skylake: add HDA BE DAIs
  ASoC: Intel: Skylake: use hda_bus instead of hdac_bus
  ASoC: hdac_hda: add asoc extension for legacy HDA codec drivers

 include/sound/soc-acpi-intel-match.h              |   6 +
 sound/pci/hda/hda_bind.c                          |  12 +
 sound/soc/codecs/Kconfig                          |   5 +
 sound/soc/codecs/Makefile                         |   2 +
 sound/soc/codecs/hdac_hda.c                       | 487 ++++++++++++++++++++++
 sound/soc/codecs/hdac_hda.h                       |  24 ++
 sound/soc/intel/Kconfig                           |  19 +
 sound/soc/intel/boards/Kconfig                    |   9 +
 sound/soc/intel/boards/Makefile                   |   2 +
 sound/soc/intel/boards/skl_hda_dsp_common.c       | 130 ++++++
 sound/soc/intel/boards/skl_hda_dsp_common.h       |  37 ++
 sound/soc/intel/boards/skl_hda_dsp_generic.c      | 176 ++++++++
 sound/soc/intel/common/Makefile                   |   3 +-
 sound/soc/intel/common/soc-acpi-intel-hda-match.c |  40 ++
 sound/soc/intel/skylake/skl-pcm.c                 |  70 +++-
 sound/soc/intel/skylake/skl-topology.c            |   3 +
 sound/soc/intel/skylake/skl.c                     | 100 ++++-
 sound/soc/intel/skylake/skl.h                     |  12 +-
 18 files changed, 1111 insertions(+), 26 deletions(-)
 create mode 100644 sound/soc/codecs/hdac_hda.c
 create mode 100644 sound/soc/codecs/hdac_hda.h
 create mode 100644 sound/soc/intel/boards/skl_hda_dsp_common.c
 create mode 100644 sound/soc/intel/boards/skl_hda_dsp_common.h
 create mode 100644 sound/soc/intel/boards/skl_hda_dsp_generic.c
 create mode 100644 sound/soc/intel/common/soc-acpi-intel-hda-match.c

-- 
2.14.1
