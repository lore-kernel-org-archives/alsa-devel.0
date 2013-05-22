From: Wang Xingchao <xingchao.wang@linux.intel.com>
Subject: [PATCH 0/4 V5] Power-well API implementation for
	Haswell
Date: Thu, 23 May 2013 01:04:12 +0800
Message-ID: <1369242256-32112-1-git-send-email-xingchao.wang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 0DD85260899
 for <alsa-devel@alsa-project.org>; Wed, 22 May 2013 19:31:11 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: daniel@ffwll.ch, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, jocelyn.li@intel.com, intel-gfx@lists.freedesktop.org, Wang Xingchao <xingchao.wang@linux.intel.com>, xingchao.wang@intel.com, liam.r.girdwood@intel.com, david.henningsson@canonical.com
List-Id: alsa-devel@alsa-project.org

Hi all,

   This is V5 and here're some changes notes:

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

Wang Xingchao (4):
  i915/drm: Add private api for power well usage
  ALSA: hda - Add power-welll support for haswell HDA
  ALSA: hda - Fix runtime PM check
  ALSA: hda - Continue probe in work context to avoid request_module
    deadlock

 drivers/gpu/drm/i915/i915_dma.c  |   6 ++
 drivers/gpu/drm/i915/i915_drv.h  |  12 ++++
 drivers/gpu/drm/i915/intel_drv.h |   4 ++
 drivers/gpu/drm/i915/intel_pm.c  |  92 ++++++++++++++++++++++++---
 include/drm/i915_powerwell.h     |  36 +++++++++++
 sound/pci/hda/Kconfig            |  10 +++
 sound/pci/hda/Makefile           |   3 +
 sound/pci/hda/hda_i915.c         |  75 ++++++++++++++++++++++
 sound/pci/hda/hda_i915.h         |  35 +++++++++++
 sound/pci/hda/hda_intel.c        | 132 ++++++++++++++++++++++++++++-----------
 10 files changed, 360 insertions(+), 45 deletions(-)
 create mode 100644 include/drm/i915_powerwell.h
 create mode 100644 sound/pci/hda/hda_i915.c
 create mode 100644 sound/pci/hda/hda_i915.h

-- 
1.8.1.2
