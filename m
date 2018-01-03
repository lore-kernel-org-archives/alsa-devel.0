From: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
Subject: [RFC v5 0/9] Enable HDA Codec support on Intel
	Platforms (Series2)
Date: Wed,  3 Jan 2018 10:26:13 +0530
Message-ID: <1514955382-742-1-git-send-email-rakesh.a.ughreja@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 62CF226754A
 for <alsa-devel@alsa-project.org>; Wed,  3 Jan 2018 05:52:52 +0100 (CET)
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
- Playback using legacy drivers is tested.
- More platforms and use cases coverage can be added once we have basic
  agreement in terms of the overall approach.
- With this rebase I observed that if HDMI device is not connected to the
  machine, the iDisp codec is not detected and so the card is not created.
  work around is to make sure that HDMI device is connected at driver loading
  time.

Changes in v5:
- Rebased to Mark's tree, 4.15-rc5
- Fixed issue related to hdac_hda module loading order.

Changes in v4:
- new field bus type is added to distinguish bus type allocated by the
  controller or platform drivers.
- extended routines are provided in hdac_bus which are called by legacy
  codec driver when the bus type is ext.
- hdac_hda driver is converted into a passive library.

Changes in v3:
- snd_hda_codec_new API is split into two, so that it can be used by
  legacy as well as ASoC codec drivers. API is split into two to avoid bus
  registration when called by ASoC drivers.
- Moved the __hda_codec_driver_register and hda_codec_driver_unregister
  APIs into generic driver and it performs registration for ASoC codec
  drivers also. So now there is only one kernel image for ASoC as well as
  legacy codec drivers. Registration functions had to moved to generic
  driver to resolve the circular dependency between hdac_hda and hda_codec
  drivers.
- There is a Kconfig entry added to compile the ASoC version of HDA codec
  driver. For now only the Realtek codec entry is added. Same thing needs
  to be done for rest of the codec drivers also.

Changes in v2:
- Using Topology framework to create DAIs and DAI Links
- Moved most commonly used functions into a separate file for machine
  driver.
- Implemented separate Realtek ASoC HDA Driver driver for Realtek HDA
  codecs. It is just a driver registration wrapper which reuses the legacy
  HDA codec driver. This allows the removes the limitation that was present

Rakesh Ughreja (9):
  ASoC: Intel: Boards: Machine driver for Intel platforms
  ASoC: Intel: Skylake: Add entry in sst_acpi_mach for HDA codecs
  ASoC: Intel: Skylake: add HDA BE DAIs
  ASoC: Intel: Skylake: use hda_bus instead of hdac_bus
  ALSA: hda - split snd_hda_codec_new function
  ALSA: hdac: remove memory allocation from snd_hdac_ext_bus_device_init
  ALSA: hdac: add bus type and extended ops support in hdac_bus
  ASoC: hdac_hda: add asoc extension for legacy HDA codec drivers
  ASoC: Intel: Boards: add support for HDA codecs

 include/sound/hdaudio.h                      |  24 ++
 include/sound/hdaudio_ext.h                  |   6 +-
 sound/hda/ext/hdac_ext_bus.c                 |  14 +-
 sound/hda/hdac_bus.c                         |   1 +
 sound/pci/hda/hda_bind.c                     |  15 +
 sound/pci/hda/hda_codec.c                    |  67 +++-
 sound/pci/hda/hda_codec.h                    |   2 +
 sound/soc/codecs/Kconfig                     |   5 +
 sound/soc/codecs/Makefile                    |   2 +
 sound/soc/codecs/hdac_hda.c                  | 517 +++++++++++++++++++++++++++
 sound/soc/codecs/hdac_hda.h                  |  20 ++
 sound/soc/intel/Kconfig                      |   1 +
 sound/soc/intel/boards/Kconfig               |  10 +
 sound/soc/intel/boards/Makefile              |   2 +
 sound/soc/intel/boards/skl_hda_dsp_common.c  | 163 +++++++++
 sound/soc/intel/boards/skl_hda_dsp_common.h  |  34 ++
 sound/soc/intel/boards/skl_hda_dsp_generic.c | 132 +++++++
 sound/soc/intel/skylake/skl-pcm.c            |  32 +-
 sound/soc/intel/skylake/skl.c                |  87 ++++-
 sound/soc/intel/skylake/skl.h                |  10 +-
 20 files changed, 1101 insertions(+), 43 deletions(-)
 create mode 100644 sound/soc/codecs/hdac_hda.c
 create mode 100644 sound/soc/codecs/hdac_hda.h
 create mode 100644 sound/soc/intel/boards/skl_hda_dsp_common.c
 create mode 100644 sound/soc/intel/boards/skl_hda_dsp_common.h
 create mode 100644 sound/soc/intel/boards/skl_hda_dsp_generic.c

-- 
2.7.4
