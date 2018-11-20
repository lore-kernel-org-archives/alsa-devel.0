From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [RFC PATCH 0/6] ASoC:Intel:Skylake: Enable HDaudio legacy fallback
Date: Tue, 20 Nov 2018 15:36:38 -0600
Message-ID: <20181120213644.19103-1-pierre-louis.bossart@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, liam.r.girdwood@linux.intel.com, andriy.shevchenko@linux.intel.com, arnd@arndb.de, linux-kernel@vger.kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

This patchset is provided as an RFC and should not be merged as is
(Turkey break in the USA and more validation needed). This is however
a good time to gather comments. This work is the result of multiple
email discussions to finally provide more flexibility for
distributions to chose whether to stick with the legacy HDaudio driver
or to enable the SST/Skylake driver for newer platforms (required
e.g. for digital microphone support)

The patches add support for CoffeeLake, simplify the probe for the
Skylake driver, introduce more compile-time granularity so that
platforms can be selected individually and last provide a dynamic
fallback mechanism when two drivers are registered for the same PCI
ID.

When the SOF driver is released, the same mechanism will be used to
enable the SOF-legacy fallback. There will be no plans to enable an
SOF->SST falback.

Pierre-Louis Bossart (4):
  ASoC: Intel: Skylake: stop init/probe if DSP is not present
  ASoC: Intel: Skylake: remove useless tests on DSP presence
  ASoC: Intel: Skylake: Add more platform granularity
  ALSA: hda: add fallback capabilities for SKL+ platforms

Takashi Iwai (2):
  ASoC: Intel: Skylake: Add CFL-S support
  ALSA: hda: Allow fallback binding with legacy HD-audio for Intel SKL+

 include/sound/hdaudio.h                |   6 +
 sound/pci/hda/Kconfig                  |  40 +++++++
 sound/pci/hda/hda_controller.h         |   2 +-
 sound/pci/hda/hda_intel.c              |  51 ++++++--
 sound/soc/intel/Kconfig                |  86 ++++++++++++--
 sound/soc/intel/boards/Kconfig         |  16 ++-
 sound/soc/intel/skylake/skl-messages.c |   8 ++
 sound/soc/intel/skylake/skl.c          | 154 +++++++++++++++++++------
 8 files changed, 311 insertions(+), 52 deletions(-)

-- 
2.17.1
