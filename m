From: =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
        <amadeuszx.slawinski@linux.intel.com>
Subject: [PATCH 00/14] Fix driver reload issues
Date: Wed,  5 Jun 2019 15:45:42 +0200
Message-ID: <20190605134556.10322-1-amadeuszx.slawinski@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Jie Yang <yang.jie@linux.intel.com>, Cezary Rojewski <cezary.rojewski@intel.com>, linux-kernel@vger.kernel.org, =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= <amadeuszx.slawinski@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Hi,

This series of patches introduces fixes to various issues found while
trying to unload all snd* modules and then loading them again. This
allows for modules to be really _modules_ and be unloaded and loaded on
demand, making it easier to develop and test them without constant
system reboots.

There are some fixes in flow, either we don't initialize things before
cleaning them up, clean up in wrong places or don't clean up at all.
Other patches fix memory management problems, mostly things are not
being freed. And finally there is few miscellaneous patches, please
refer to specific patches to see what they do.

This series was tested on SKL, BXT, GLK & KBL.

Small note:
Patch 2 in this series was already send to this list along with SOF
counterpart, however it seems that there is some problem:
https://mailman.alsa-project.org/pipermail/alsa-devel/2019-May/149638.html
and related patch on SOF side (with discussion):
https://mailman.alsa-project.org/pipermail/alsa-devel/2019-May/149640.html
It is included in this patchset for completeness.

Amadeusz Sławiński (14):
  ASoC: Intel: Skylake: Initialize lists before access so they are safe
    to use
  ALSA: hdac: fix memory release for SST and SOF drivers
  ALSA: hdac: Fix codec name after machine driver is unloaded and
    reloaded
  ASoC: compress: Fix memory leak from snd_soc_new_compress
  ASoC: Intel: Skylake: Don't return failure on machine driver reload
  ASoC: Intel: Skylake: Remove static table index when parsing topology
  ASoC: Intel: Skylake: Add function to cleanup debugfs interface
  ASoC: Intel: Skylake: Properly cleanup on component removal
  ASoC: Intel: Skylake: Fix NULL ptr dereference when unloading clk dev
  SoC: rt274: Fix internal jack assignment in set_jack callback
  ASoC: core: Tell codec that jack is being removed
  ASoC: Intel: hdac_hdmi: Set ops to NULL on remove
  ASoC: topology: Consolidate how dtexts and dvalues are freed
  ASoC: topology: Consolidate and fix asoc_tplg_dapm_widget_*_create
    flow

 sound/hda/ext/hdac_ext_bus.c           |  12 ++-
 sound/soc/codecs/hdac_hdmi.c           |   6 ++
 sound/soc/codecs/rt274.c               |   3 +-
 sound/soc/intel/skylake/skl-debug.c    |   9 ++
 sound/soc/intel/skylake/skl-pcm.c      |  16 ++--
 sound/soc/intel/skylake/skl-ssp-clk.c  |  16 ++--
 sound/soc/intel/skylake/skl-topology.c |  50 ++++++-----
 sound/soc/intel/skylake/skl-topology.h |   2 +
 sound/soc/intel/skylake/skl.c          |   7 +-
 sound/soc/intel/skylake/skl.h          |   5 ++
 sound/soc/soc-compress.c               |  17 ++--
 sound/soc/soc-core.c                   |   1 +
 sound/soc/soc-topology.c               | 114 ++++++++++++-------------
 13 files changed, 143 insertions(+), 115 deletions(-)

-- 
2.17.1
