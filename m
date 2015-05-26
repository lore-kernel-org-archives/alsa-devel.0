From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH 0/2] reducing memory footprint of ALSA
Date: Tue, 26 May 2015 19:04:23 +0800
Message-ID: <1432638265-16646-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 3270826510B
 for <alsa-devel@alsa-project.org>; Tue, 26 May 2015 13:00:45 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, broonie@kernel.org
Cc: vivian.zhang@intel.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

We are planning to work on reducing memory footprint of ALSA,
targeting on small memory embedded devices(e.g. IoT), this
series focuses on disabling procfs, hw/sw params refinement,
mmap, dpcm, dapm, compressed API, compat code APIs...

These first two patches is a start, add config menu in Kconfig,
and disable ALSA proc FS once reducing memory footprint is
selected, which can save about 9KB code size on x86_64 platform.

Comments are welcomed.

~Keyon

Jie Yang (2):
  ALSA: Kconfig: add config menu for reduced memory footprint
  ALSA: set no sound proc fs for reduced memory footprint

 include/sound/info.h               |  8 ++++----
 sound/Kconfig                      | 16 ++++++++++++++++
 sound/core/Makefile                |  2 +-
 sound/core/hwdep.c                 |  6 +++---
 sound/core/init.c                  |  8 ++++----
 sound/core/oss/mixer_oss.c         |  6 +++---
 sound/core/pcm.c                   |  6 +++---
 sound/core/seq/oss/seq_oss.c       |  6 +++---
 sound/core/seq/oss/seq_oss_init.c  |  5 ++---
 sound/core/seq/oss/seq_oss_midi.c  |  4 ++--
 sound/core/seq/oss/seq_oss_readq.c |  4 ++--
 sound/core/seq/oss/seq_oss_synth.c |  4 ++--
 sound/core/seq/seq_clientmgr.c     |  4 ++--
 sound/core/seq/seq_device.c        |  2 +-
 sound/core/seq/seq_info.h          |  2 +-
 sound/core/seq/seq_queue.c         |  4 ++--
 sound/core/seq/seq_timer.c         |  4 ++--
 sound/core/sound.c                 |  4 ++--
 sound/core/sound_oss.c             |  4 ++--
 sound/core/timer.c                 |  4 ++--
 sound/pci/hda/Makefile             |  3 ++-
 sound/pci/hda/hda_eld.c            |  4 ++--
 sound/pci/hda/hda_local.h          |  4 ++--
 sound/pci/hda/patch_hdmi.c         |  4 ++--
 sound/pci/hda/patch_sigmatel.c     |  2 +-
 25 files changed, 68 insertions(+), 52 deletions(-)

-- 
1.9.1
