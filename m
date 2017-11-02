From: Baolin Wang <baolin.wang@linaro.org>
Subject: [RFC PATCH v2 0/7] Fix year 2038 issue for sound subsystem
Date: Thu,  2 Nov 2017 19:06:50 +0800
Message-ID: <cover.1509612175.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, arnd@arndb.de
Cc: lgirdwood@gmail.com, broonie@kernel.org, o-takashi@sakamocchi.jp, mingo@kernel.org, elfring@users.sourceforge.net, dan.carpenter@oracle.com, jeeja.kp@intel.com, vinod.koul@intel.com, guneshwor.o.singh@intel.com, subhransu.s.prusty@intel.com, bhumirks@gmail.com, gudishax.kranthikumar@intel.com, naveen.m@intel.com, hardik.t.shah@intel.com, arvind.yadav.cs@gmail.com, fabf@skynet.be, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, baolin.wang@linaro.org
List-Id: alsa-devel@alsa-project.org

Since many structures will use timespec type variables to record time stamp
in uapi/asound.h, which are not year 2038 safe on 32bit system. This patchset
tries to introduce new structures removing timespec type to compatible native
mode and compat mode.

Moreover this patchset also converts the internal structrures to use timespec64
type and related APIs.

Changes since v1:
 - Flat all structues to make them more clear.
 - Re-modify the convertion for struct snd_timer_tread.
 - Use same coding style when converting struct snd_rawmidi_status.
 - Use struct snd_timer_user_status64 in compat mode directly when converting
 struct snd_timer_status.
 - Add #ifdef __KERNEL__ when converting struct snd_ctl_elem_value.
 - Re-modify the convertion for struct snd_pcm_sync_ptr.
 - Fix some building errors.

Appreciated for any comments, especially for patch6 which I am not sure if it
is correct.

Baolin Wang (7):
  sound: Replace timespec with timespec64
  sound: core: Avoid using timespec for struct snd_pcm_status
  sound: core: Avoid using timespec for struct snd_rawmidi_status
  sound: core: Avoid using timespec for struct snd_timer_status
  uapi: sound: Avoid using timespec for struct snd_ctl_elem_value
  sound: core: Avoid using timespec for struct snd_pcm_sync_ptr
  sound: core: Avoid using timespec for struct snd_timer_tread

 include/sound/pcm.h               |  126 +++++++++-
 include/sound/timer.h             |    4 +-
 include/uapi/sound/asound.h       |   19 +-
 sound/core/pcm.c                  |   20 +-
 sound/core/pcm_compat.c           |  469 ++++++++++++++++++++++++++++---------
 sound/core/pcm_lib.c              |   33 ++-
 sound/core/pcm_native.c           |  220 +++++++++++++----
 sound/core/rawmidi.c              |   81 ++++++-
 sound/core/rawmidi_compat.c       |  121 +++++++---
 sound/core/timer.c                |  253 ++++++++++++++++----
 sound/core/timer_compat.c         |   67 ++----
 sound/pci/hda/hda_controller.c    |   10 +-
 sound/soc/intel/skylake/skl-pcm.c |    4 +-
 13 files changed, 1090 insertions(+), 337 deletions(-)

-- 
1.7.9.5
