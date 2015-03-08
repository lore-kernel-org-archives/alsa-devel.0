From: Vinod Koul <vinod.koul@intel.com>
Subject: [RFC 0/5] Create hdalib for common hda code
Date: Sun,  8 Mar 2015 20:07:54 +0530
Message-ID: <1425825479-28780-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 49A0026044F
 for <alsa-devel@alsa-project.org>; Sun,  8 Mar 2015 15:41:25 +0100 (CET)
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
Cc: tiwai@suse.de, Jeeja KP <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

This patch series attempts to split existing HDA code to create common hda
library. This is done in order to make HDA code available to other users like
upcoming Intel platforms which sport a HDA controller along with an I2S
link.  This series is 1st patch series which will try to refactor HDA by
splitting it up and then adding ASoC HDA controller driver for these
platforms.

This series moves code to sound/hda, renames the files mostly. The second
series will do API changes and subsequent ones will be using HDA bus patches
which Takashi posted recently

Comments welcome...

~Vinod

Jeeja KP (5):
  ALSA: hda: move hdaudio header files to global include
  ALSA: HDA: create HDA common lib
  ALSA: hdalib - fix existing checkpatch issues
  ALSA: hda: rename sound/hda/hda* as sound/hda/hdalib
  ALSA: hdalib: rename common header files as hdalib_*

 .../hda/hda_priv.h => include/sound/hda_register.h |   10 +--
 .../sound/hdalib_auto_parser.h                     |    6 +-
 .../hda/hda_beep.h => include/sound/hdalib_beep.h  |    6 +-
 .../hda_codec.h => include/sound/hdalib_codec.h    |   23 +++---
 .../sound/hdalib_controller.h                      |   11 +--
 .../hda_local.h => include/sound/hdalib_controls.h |   20 ++---
 .../sound/hdalib_generic.h                         |    6 +-
 include/sound/{hda_hwdep.h => hdalib_hwdep.h}      |    4 +-
 .../hda/hda_jack.h => include/sound/hdalib_jack.h  |    6 +-
 sound/Kconfig                                      |    2 +
 sound/Makefile                                     |    2 +-
 sound/hda/Kconfig                                  |   85 ++++++++++++++++++++
 sound/hda/Makefile                                 |   21 +++++
 sound/{pci => }/hda/hda_intel_trace.h              |    0
 sound/{pci => }/hda/hda_trace.h                    |    0
 .../hda_auto_parser.c => hda/hdalib_auto_parser.c} |    7 +-
 sound/{pci/hda/hda_beep.c => hda/hdalib_beep.c}    |    8 +-
 sound/{pci/hda/hda_codec.c => hda/hdalib_codec.c}  |   21 +++--
 .../hda_controller.c => hda/hdalib_controller.c}   |   10 ++-
 sound/{pci/hda/hda_eld.c => hda/hdalib_eld.c}      |    4 +-
 .../hda/hda_generic.c => hda/hdalib_generic.c}     |   13 +--
 sound/{pci/hda/hda_hwdep.c => hda/hdalib_hwdep.c}  |    6 +-
 sound/{pci/hda/hda_jack.c => hda/hdalib_jack.c}    |    8 +-
 sound/{pci/hda/hda_proc.c => hda/hdalib_proc.c}    |   13 +--
 sound/{pci/hda/hda_sysfs.c => hda/hdalib_sysfs.c}  |    6 +-
 sound/pci/hda/Kconfig                              |   44 ----------
 sound/pci/hda/Makefile                             |   14 +---
 sound/pci/hda/hda_i915.c                           |    3 +-
 sound/pci/hda/hda_intel.c                          |    7 +-
 sound/pci/hda/patch_hdmi.c                         |   10 ++-
 sound/pci/hda/patch_realtek.c                      |   10 ++-
 31 files changed, 229 insertions(+), 157 deletions(-)
 rename sound/pci/hda/hda_priv.h => include/sound/hda_register.h (98%)
 rename sound/pci/hda/hda_auto_parser.h => include/sound/hdalib_auto_parser.h (96%)
 rename sound/pci/hda/hda_beep.h => include/sound/hdalib_beep.h (95%)
 rename sound/pci/hda/hda_codec.h => include/sound/hdalib_codec.h (97%)
 rename sound/pci/hda/hda_controller.h => include/sound/hdalib_controller.h (90%)
 rename sound/pci/hda/hda_local.h => include/sound/hdalib_controls.h (98%)
 rename sound/pci/hda/hda_generic.h => include/sound/hdalib_generic.h (99%)
 rename include/sound/{hda_hwdep.h => hdalib_hwdep.h} (95%)
 rename sound/pci/hda/hda_jack.h => include/sound/hdalib_jack.h (96%)
 create mode 100644 sound/hda/Kconfig
 create mode 100644 sound/hda/Makefile
 rename sound/{pci => }/hda/hda_intel_trace.h (100%)
 rename sound/{pci => }/hda/hda_trace.h (100%)
 rename sound/{pci/hda/hda_auto_parser.c => hda/hdalib_auto_parser.c} (99%)
 rename sound/{pci/hda/hda_beep.c => hda/hdalib_beep.c} (98%)
 rename sound/{pci/hda/hda_codec.c => hda/hdalib_codec.c} (99%)
 rename sound/{pci/hda/hda_controller.c => hda/hdalib_controller.c} (99%)
 rename sound/{pci/hda/hda_eld.c => hda/hdalib_eld.c} (99%)
 rename sound/{pci/hda/hda_generic.c => hda/hdalib_generic.c} (99%)
 rename sound/{pci/hda/hda_hwdep.c => hda/hdalib_hwdep.c} (96%)
 rename sound/{pci/hda/hda_jack.c => hda/hdalib_jack.c} (99%)
 rename sound/{pci/hda/hda_proc.c => hda/hdalib_proc.c} (99%)
 rename sound/{pci/hda/hda_sysfs.c => hda/hdalib_sysfs.c} (99%)

-- 
1.7.9.5
