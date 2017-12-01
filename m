From: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
Subject: [RFC 00/10] Enable HDA Codec support on Intel
	Platforms (Series2)
Date: Fri,  1 Dec 2017 14:43:58 +0530
Message-ID: <1512119648-2700-1-git-send-email-rakesh.a.ughreja@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id AFAD1267BEA
 for <alsa-devel@alsa-project.org>; Fri,  1 Dec 2017 10:09:52 +0100 (CET)
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

Many Intel platforms (SKL,KBL) etc. in the market supports enahanced 
audio capabilities which also includes DSP processing. This patch carry
forwads the works that is done in the previous series to enable HD Audio
codecs on such platforms.

This patch series adds ASoC HDA codec driver for Intel platforms. It is
written by reusing the legacy HDA ALSA codec driver. Intention is to
maximize the reuse and minimize the changes in the legacy HDA codec driver.

I would like to receive feedback before proceeding further on this
direction.

TODO:

- This series is tested on KBL based product (Dell XPS 13).
- Basic playback is working with headset and speakers.
- Capture operation is not tested.
- More platforms and use cases coverage can be added once we have basic
  agreement in terms of the overall approach.

FIXME:
- KConfig changes does not look right, but I could not think of any proper
  way without making changes into legacy HDA codec driver. So need some
  help on this topic.

Rakesh Ughreja (10):
  ASoC: Intel: Boards: Machine driver for Intel platforms
  ASoC: Intel: Skylake: Add entry in sst_acpi_mach for HDA codecs
  ASoC: Intel: Skylake: add HDA BE DAIs
  ASoC: Intel: Skylake: use hda_bus instead of hdac_bus
  ALSA: hda - make some of the functions externally visible
  ASoC: hdac_hda: add ASoC based HDA codec driver
  ALSA: hda: add new API snd_hda_asoc_codec_new for ASoC codec drivers
  ASoC: hdac_hda: add DAI, widgets and related ops
  ASoC: hdac_hda: add runtime PM support
  ASoC: Intel: Boards: add support for HDA codecs

 include/sound/hdaudio_ext.h              |   3 +-
 sound/hda/ext/hdac_ext_bus.c             |   9 +-
 sound/pci/hda/Kconfig                    |  11 +
 sound/pci/hda/hda_codec.c                | 109 +++++-
 sound/pci/hda/hda_codec.h                |  32 +-
 sound/soc/codecs/Kconfig                 |   6 +
 sound/soc/codecs/Makefile                |   2 +
 sound/soc/codecs/hdac_hda.c              | 633 +++++++++++++++++++++++++++++++
 sound/soc/codecs/hdac_hda.h              |  16 +
 sound/soc/intel/boards/Kconfig           |  11 +
 sound/soc/intel/boards/Makefile          |   2 +
 sound/soc/intel/boards/skl_hda_generic.c | 386 +++++++++++++++++++
 sound/soc/intel/skylake/skl-pcm.c        |  32 +-
 sound/soc/intel/skylake/skl.c            |  79 +++-
 sound/soc/intel/skylake/skl.h            |  10 +-
 15 files changed, 1315 insertions(+), 26 deletions(-)
 create mode 100644 sound/soc/codecs/hdac_hda.c
 create mode 100644 sound/soc/codecs/hdac_hda.h
 create mode 100644 sound/soc/intel/boards/skl_hda_generic.c

-- 
2.7.4
