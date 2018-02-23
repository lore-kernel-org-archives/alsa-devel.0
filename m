From: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
Subject: [PATCH v1 0/9] Enable HDA Codec support on Intel
	Platforms (Series2)
Date: Fri, 23 Feb 2018 13:42:21 +0530
Message-ID: <1519373550-2545-1-git-send-email-rakesh.a.ughreja@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by alsa0.perex.cz (Postfix) with ESMTP id 2B3A726789E
 for <alsa-devel@alsa-project.org>; Fri, 23 Feb 2018 09:10:09 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@kernel.org, tiwai@suse.de, liam.r.girdwood@linux.intel.com
Cc: vinod.koul@intel.com, patches.audio@intel.com, Rakesh Ughreja <rakesh.a.ughreja@intel.com>, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Many Intel platforms (SKL, KBL) etc. in the market supports enhanced 
audio capabilities which also includes DSP processing. This patch carry
forwards the work that is done in the previous series to enable HD Audio
codecs on such platforms.

This patch series adds ASoC HDA codec driver for Intel platforms. It is
written by reusing the legacy HDA ALSA codec driver. Intention is to
maximize the reuse and minimize the changes in the legacy HDA codec driver.

Rakesh Ughreja (9):
  ASoC: Intel: Boards: Machine driver for Intel platforms
  ASoC: Intel: Skylake: Add entry in sst_acpi_mach for HDA codecs
  ASoC: Intel: Skylake: add HDA BE DAIs
  ASoC: Intel: Skylake: use hda_bus instead of hdac_bus
  ALSA: hda - split snd_hda_codec_new function
  ALSA: hdac: remove memory allocation from snd_hdac_ext_bus_device_init
  ALSA: hdac: add extended ops in the hdac_bus
  ASoC: hdac_hda: add asoc extension for legacy HDA codec drivers
  ASoC: Intel: Boards: add support for HDA codecs

 include/sound/hdaudio.h                      |   9 +
 include/sound/hdaudio_ext.h                  |   6 +-
 sound/hda/ext/hdac_ext_bus.c                 |  12 +-
 sound/pci/hda/hda_bind.c                     |   6 +
 sound/pci/hda/hda_codec.c                    |  67 +++-
 sound/pci/hda/hda_codec.h                    |   2 +
 sound/soc/codecs/Kconfig                     |   5 +
 sound/soc/codecs/Makefile                    |   2 +
 sound/soc/codecs/hdac_hda.c                  | 448 +++++++++++++++++++++++++++
 sound/soc/codecs/hdac_hda.h                  |  23 ++
 sound/soc/intel/Kconfig                      |   1 +
 sound/soc/intel/boards/Kconfig               |  10 +
 sound/soc/intel/boards/Makefile              |   2 +
 sound/soc/intel/boards/skl_hda_dsp_common.c  | 131 ++++++++
 sound/soc/intel/boards/skl_hda_dsp_common.h  |  34 ++
 sound/soc/intel/boards/skl_hda_dsp_generic.c | 143 +++++++++
 sound/soc/intel/skylake/skl-pcm.c            |  50 ++-
 sound/soc/intel/skylake/skl.c                |  98 +++++-
 sound/soc/intel/skylake/skl.h                |  11 +-
 19 files changed, 1011 insertions(+), 49 deletions(-)
 create mode 100644 sound/soc/codecs/hdac_hda.c
 create mode 100644 sound/soc/codecs/hdac_hda.h
 create mode 100644 sound/soc/intel/boards/skl_hda_dsp_common.c
 create mode 100644 sound/soc/intel/boards/skl_hda_dsp_common.h
 create mode 100644 sound/soc/intel/boards/skl_hda_dsp_generic.c

-- 
2.7.4
