From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH v3 0/2] reducing memory footprint of ALSA
Date: Wed, 27 May 2015 17:10:16 +0800
Message-ID: <1432717818-4685-1-git-send-email-yang.jie@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tiwai@suse.de, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, liam.r.girdwood@intel.com, yang.jie@intel.com, vivian.zhang@intel.com
List-Id: alsa-devel@alsa-project.org

We are planning to work on reducing memory footprint of ALSA,
targeting on small memory embedded devices(e.g. IoT), this
series focuses on disabling procfs, hw/sw params refinement,
mmap, dpcm, dapm, compressed API, compat code APIs...

We plan to enable those reducing items only for EXPERT, and
add knobs in sound/core/Kconfig.

These first two patches is a start, adding SND_PROC_FS to config
disable/enable ALSA proc FS, this disabling can save about 9KB
code size on x86_64 platform.

Changes in v3:
1. drop SND_REDUCED_MEMORY_FOOTPRINT and make configuration
available only for EXPERT;
2. move the configure into sound/core/Kconfig;
3. Add missing Signed-off-by for PATCH 2/2.

Changes in v2:
1. Prompt "Sound Proc FS Support" appears only when
SND_REDUCED_MEMORY_FOOTPRINT is true.

Jie Yang (2):
  ALSA: Kconfig: add config item SND_PROC_FS for expert
  ALSA: replace CONFIG_PROC_FS with CONFIG_SND_PROC_FS

 include/sound/info.h               | 8 ++++----
 sound/core/Kconfig                 | 9 +++++++++
 sound/core/Makefile                | 2 +-
 sound/core/hwdep.c                 | 6 +++---
 sound/core/init.c                  | 8 ++++----
 sound/core/oss/mixer_oss.c         | 6 +++---
 sound/core/pcm.c                   | 6 +++---
 sound/core/seq/oss/seq_oss.c       | 6 +++---
 sound/core/seq/oss/seq_oss_init.c  | 5 ++---
 sound/core/seq/oss/seq_oss_midi.c  | 4 ++--
 sound/core/seq/oss/seq_oss_readq.c | 4 ++--
 sound/core/seq/oss/seq_oss_synth.c | 4 ++--
 sound/core/seq/seq_clientmgr.c     | 4 ++--
 sound/core/seq/seq_device.c        | 2 +-
 sound/core/seq/seq_info.h          | 2 +-
 sound/core/seq/seq_queue.c         | 4 ++--
 sound/core/seq/seq_timer.c         | 4 ++--
 sound/core/sound.c                 | 4 ++--
 sound/core/sound_oss.c             | 4 ++--
 sound/core/timer.c                 | 4 ++--
 sound/pci/hda/Makefile             | 3 ++-
 sound/pci/hda/hda_eld.c            | 4 ++--
 sound/pci/hda/hda_local.h          | 4 ++--
 sound/pci/hda/patch_hdmi.c         | 4 ++--
 sound/pci/hda/patch_sigmatel.c     | 2 +-
 25 files changed, 61 insertions(+), 52 deletions(-)

-- 
1.9.1
