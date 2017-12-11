From: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
Subject: [RFC v2 00/11] Enable HDA Codec support on Intel
	Platforms (Series2)
Date: Mon, 11 Dec 2017 16:22:52 +0530
Message-ID: <1512989583-10877-1-git-send-email-rakesh.a.ughreja@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id C6FBF26751A
 for <alsa-devel@alsa-project.org>; Mon, 11 Dec 2017 11:48:30 +0100 (CET)
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
forwards the works that is done in the previous series to enable HD Audio
codecs on such platforms.

This patch series adds ASoC HDA codec driver for Intel platforms. It is
written by reusing the legacy HDA ALSA codec driver. Intention is to
maximize the reuse and minimize the changes in the legacy HDA codec driver.

I would like to receive feedback before proceeding further on this
direction.

INFO:
- This series is tested on KBL based product (Dell XPS 13).
- Basic playback is working with headset and speakers.
- HDMI playback is working.
- Capture operation is not tested.
- More platforms and use cases coverage can be added once we have basic
  agreement in terms of the overall approach.

Changes in v2:
- Using Topology framework to create DAIs and DAI Links
- Moved most commonly used functions into a separate file for machine driver
- Implemented separate Realtek ASoC HDA Driver driver for Realtek HDA codecs.
  It is just a driver registration wrapper which reuses the legacy HDA codec
  driver. This allows the removes the limitation that was present in v1.
- Implemented the review feedback.

Rakesh Ughreja (11):
  ASoC: Intel: Boards: Machine driver for Intel platforms
  ASoC: Intel: Skylake: Add entry in sst_acpi_mach for HDA codecs
  ASoC: Intel: Skylake: add HDA BE DAIs
  ASoC: Intel: Skylake: use hda_bus instead of hdac_bus
  ALSA: hda - make some of the functions externally visible
  ASoC: hdac_hda: add ASoC based HDA codec driver
  ALSA: hda: add new API snd_hda_asoc_codec_new for ASoC codec drivers
  ASoC: hdac_hda: add DAI, widgets and related ops
  ASoC: hdac_hda: add runtime PM support
  ASoC: patch_realtek: add ASoC based Realtek HDA codec driver patch
  ASoC: Intel: Boards: add support for HDA codecs

 include/sound/hdaudio_ext.h                  |   3 +-
 sound/hda/ext/hdac_ext_bus.c                 |   9 +-
 sound/pci/hda/hda_codec.c                    | 109 ++++-
 sound/pci/hda/hda_codec.h                    |   4 +
 sound/pci/hda/patch_realtek.c                |   3 +-
 sound/soc/codecs/Kconfig                     |  12 +
 sound/soc/codecs/Makefile                    |   4 +
 sound/soc/codecs/hdac_hda.c                  | 628 +++++++++++++++++++++++++++
 sound/soc/codecs/hdac_hda.h                  |  26 ++
 sound/soc/codecs/patch_realtek.c             |  48 ++
 sound/soc/intel/boards/Kconfig               |  11 +
 sound/soc/intel/boards/Makefile              |   2 +
 sound/soc/intel/boards/skl_hda_dsp_common.c  | 173 ++++++++
 sound/soc/intel/boards/skl_hda_dsp_common.h  |  42 ++
 sound/soc/intel/boards/skl_hda_dsp_generic.c | 141 ++++++
 sound/soc/intel/skylake/skl-pcm.c            |  32 +-
 sound/soc/intel/skylake/skl.c                |  79 +++-
 sound/soc/intel/skylake/skl.h                |  10 +-
 18 files changed, 1311 insertions(+), 25 deletions(-)
 create mode 100644 sound/soc/codecs/hdac_hda.c
 create mode 100644 sound/soc/codecs/hdac_hda.h
 create mode 100644 sound/soc/codecs/patch_realtek.c
 create mode 100644 sound/soc/intel/boards/skl_hda_dsp_common.c
 create mode 100644 sound/soc/intel/boards/skl_hda_dsp_common.h
 create mode 100644 sound/soc/intel/boards/skl_hda_dsp_generic.c

-- 
2.7.4
