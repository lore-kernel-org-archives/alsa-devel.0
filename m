From: Wang Xingchao <xingchao.wang@linux.intel.com>
Subject: [PATCH 0/4 V7] Power-well API implementation for
	Haswell
Date: Thu, 30 May 2013 22:07:07 +0800
Message-ID: <1369922831-727-1-git-send-email-xingchao.wang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id E01622651CE
 for <alsa-devel@alsa-project.org>; Thu, 30 May 2013 16:34:33 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, daniel.vetter@ffwll.ch
Cc: alsa-devel@alsa-project.org, intel-gfx@lists.freedesktop.org, Wang Xingchao <xingchao.wang@linux.intel.com>, xingchao.wang@intel.com, liam.r.girdwood@intel.com, david.henningsson@canonical.com
List-Id: alsa-devel@alsa-project.org

Hi all,

   This is V7 and here're some changes notes:
   change from V6-->V7:
   - rename variable
   - use HAS_POWER_WELL instead of IS_HASWELL
   - put structure inside drm_i915_private
   - use WARN_ON for global pointer check

   change from V5-->V6:
   - Remove duplication code in new introduced probe work
   - move duplication code in azx_probe_continue
   - remove unused #ifdef
   - replace request_module with symbol_request
   - replace spin_lock_irq with spin_lock_irqsave in gfx side
   - other typo fixes 
   (review by Takashi)

   change from V4-->V5:
   - fix reference count bug
   - new patch on general runtime pm support for audio pci device
   - new patch to avoid request_module() deadlock

   change between V3-->V4:
   - add new structure i915_power_well
   - initialize drm_device pointer at module init time
   - change function name

   change between V2-->V3:
   - make SND_HDA_I915 selectable
   - use snd_printdd to output message
   - add return error code check
   - use symbol_request to replace symbol_get
   - release power_well at azx_free
   - some typo fixes

   changes between V1-->V2:
   - use reference count to track power-well usage
   - remove external module, compiled into snd-hda-intel instead
   - manage symbols and module loading properly
   - remove IS_HSW macro, use flag instead
   - remove audio callback for gfx driver to avoid dependency 
   - split whole patch into two pieces for easy review
   - more typo fixes


Takashi Iwai (1):
  ALSA: hda - Move azx_first_init() into azx_probe_continue()

Wang Xingchao (3):
  ALSA: hda - Fix runtime PM check
  ALSA: hda - Add power-welll support for haswell HDA
  i915/drm: Add private api for power well usage

 drivers/gpu/drm/i915/i915_dma.c  |    6 +++
 drivers/gpu/drm/i915/i915_drv.h  |   12 ++++++
 drivers/gpu/drm/i915/intel_drv.h |    4 ++
 drivers/gpu/drm/i915/intel_pm.c  |   81 ++++++++++++++++++++++++++++++++---
 include/drm/i915_powerwell.h     |   36 ++++++++++++++++
 sound/pci/hda/Kconfig            |   10 +++++
 sound/pci/hda/Makefile           |    2 +
 sound/pci/hda/hda_i915.c         |   75 ++++++++++++++++++++++++++++++++
 sound/pci/hda/hda_i915.h         |   35 +++++++++++++++
 sound/pci/hda/hda_intel.c        |   87 ++++++++++++++++++++++++++++++--------
 10 files changed, 324 insertions(+), 24 deletions(-)
 create mode 100644 include/drm/i915_powerwell.h
 create mode 100644 sound/pci/hda/hda_i915.c
 create mode 100644 sound/pci/hda/hda_i915.h

-- 
1.7.9.5
