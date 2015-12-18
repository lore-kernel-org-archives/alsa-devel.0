From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 00/19] Baytrail/Cherrytrail cleanups and fixes
Date: Thu, 17 Dec 2015 20:35:37 -0600
Message-ID: <1450406156-22246-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id E8BDA26153F
 for <alsa-devel@alsa-project.org>; Fri, 18 Dec 2015 03:37:05 +0100 (CET)
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
Cc: bardliao@realtek.com, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, jack.yu@realtek.com
List-Id: alsa-devel@alsa-project.org

Set of patches to provide better upstream support for BYT/CHT 
platforms (24 bit, Deep-buffer, DPCM). This was tested on Asus T100 and 
Minnowboard.
A set of UCM files is available at https://github.com/plbossart/UCM.git for 
better integration with Ubuntu/pulseaudio
(no need for asound.state or asound.conf)

Acknowledgements:
Keyon Jie for his MinnowBoard validation
Sebastien Guiriec for pointing out the switch logic issue and fixing SSP configs
Vinod Koul for providing codec/mixer configurations
Francisco Mendez for his help with the MCLK and jack detection
Jack Yu and Bard Liao for their codec support

Known issues: 
noise on startup when using speakers

Once this batch is merged, the following updates will be provided:
MCLK support to fix noise issues
BYT-CR fixes
jack detection

Jack Yu (1):
  ASoC: rt5640: add ASRC support

Jorge Fernandez Monteagudo (1):
  ASoC: Intel: Atom: Add support for HP ElitePad 1000 G2

Pierre-Louis Bossart (16):
  ASoC: Intel: fix ACPI probe regression with Atom DPCM driver
  ASoC: Intel: boards: align pin names between byt-rt5640 drivers
  ASoC: Intel: boards: start merging byt-rt5640 drivers
  ASoC: Intel: boards: merge DMI-based quirks in bytcr-rt5640 driver
  ASoC: Intel: tag byt-rt5640 machine driver as deprecated
  ASoc: Intel: Atom: add deep buffer definitions for atom platforms
  ASoC: Intel: boards: add DEEP_BUFFER support for BYT/CHT/BSW
  ASoC: Intel: Atom: add 24-bit support for media playback and capture
  ASoC: Intel: Atom: clean-up compressed DAI definition
  ASoC: Intel: Atom: flip logic for gain Switch
  ASoC: codec: rt5651: add ACPI and OF support
  ASoC: Intel: add bytct-rt5651 machine driver
  ASoC: intel: boards: add card for MinnowBoard I2S access
  ASoC: Intel: bytcr-rt5640: enable ASRC
  ASoC: Intel: bytcr_rt5640: fixup DAI codec_name with HID
  ASoC: Intel: Atom: add support for RT5642

Sebastien Guiriec (1):
  ASoC: Intel: bytcr_rt5640: set SSP to I2S mode 2ch

 arch/x86/include/asm/platform_sst_audio.h    |   1 +
 sound/soc/codecs/rt5640.c                    | 103 ++++++++
 sound/soc/codecs/rt5640.h                    |  17 ++
 sound/soc/codecs/rt5651.c                    |  19 ++
 sound/soc/intel/Kconfig                      |  35 ++-
 sound/soc/intel/atom/sst-atom-controls.c     |   5 +-
 sound/soc/intel/atom/sst-atom-controls.h     |   1 +
 sound/soc/intel/atom/sst-mfld-platform-pcm.c |  20 +-
 sound/soc/intel/atom/sst/sst_acpi.c          |  25 +-
 sound/soc/intel/boards/Makefile              |   4 +
 sound/soc/intel/boards/bytcr_nocodec.c       | 233 ++++++++++++++++++
 sound/soc/intel/boards/bytcr_rt5640.c        | 266 ++++++++++++++++-----
 sound/soc/intel/boards/bytcr_rt5651.c        | 338 +++++++++++++++++++++++++++
 sound/soc/intel/boards/cht_bsw_max98090_ti.c |  12 +
 sound/soc/intel/boards/cht_bsw_rt5645.c      |  12 +
 sound/soc/intel/boards/cht_bsw_rt5672.c      |  12 +
 sound/soc/intel/common/Makefile              |   5 +
 17 files changed, 1036 insertions(+), 72 deletions(-)
 create mode 100644 sound/soc/intel/boards/bytcr_nocodec.c
 create mode 100644 sound/soc/intel/boards/bytcr_rt5651.c

-- 
1.9.1
