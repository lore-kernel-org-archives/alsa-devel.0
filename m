From: Baolin Wang <baolin.wang@linaro.org>
Subject: [RFC PATCH 0/7] Fix year 2038 issue for sound subsystem
Date: Thu, 21 Sep 2017 14:18:02 +0800
Message-ID: <cover.1505973912.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com
Cc: lgirdwood@gmail.com, mingo@kernel.org, o-takashi@sakamocchi.jp, elfring@users.sourceforge.net, dan.carpenter@oracle.com, jeeja.kp@intel.com, vinod.koul@intel.com, dharageswari.r@intel.com, guneshwor.o.singh@intel.com, bhumirks@gmail.com, gudishax.kranthikumar@intel.com, naveen.m@intel.com, hardik.t.shah@intel.com, arvind.yadav.cs@gmail.com, fabf@skynet.be, arnd@arndb.de, broonie@kernel.org, deepa.kernel@gmail.com, baolin.wang@linaro.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Since many structures will use timespec type variables to record time stamp
in uapi/asound.h, which are not year 2038 safe on 32bit system. This patchset
tries to introduce new structures removing timespec type to compatible native
mode and compat mode.

Moreover this patchset also converts the internal structrures to use timespec64
type and related APIs. 

Baolin Wang (7):
  sound: Replace timespec with timespec64
  sound: core: Avoid using timespec for struct snd_pcm_status
  sound: core: Avoid using timespec for struct snd_pcm_sync_ptr
  sound: core: Avoid using timespec for struct snd_rawmidi_status
  sound: core: Avoid using timespec for struct snd_timer_status
  uapi: sound: Avoid using timespec for struct snd_ctl_elem_value
  sound: core: Avoid using timespec for struct snd_timer_tread

 include/sound/pcm.h               |  113 ++++++++-
 include/sound/timer.h             |    4 +-
 include/uapi/sound/asound.h       |   15 +-
 sound/core/pcm.c                  |   14 +-
 sound/core/pcm_compat.c           |  466 +++++++++++++++++++++++++++++--------
 sound/core/pcm_lib.c              |   33 +--
 sound/core/pcm_native.c           |  227 ++++++++++++++----
 sound/core/rawmidi.c              |   74 +++++-
 sound/core/rawmidi_compat.c       |   90 +++++--
 sound/core/timer.c                |  247 ++++++++++++++++----
 sound/core/timer_compat.c         |   25 +-
 sound/pci/hda/hda_controller.c    |   10 +-
 sound/soc/intel/skylake/skl-pcm.c |    4 +-
 13 files changed, 1046 insertions(+), 276 deletions(-)

-- 
1.7.9.5
