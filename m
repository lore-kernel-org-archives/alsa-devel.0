From: Wang Xingchao <xingchao.wang@linux.intel.com>
Subject: [PATCH 0/2 V4] Power-well API implementation for
	Haswell
Date: Mon, 20 May 2013 19:26:56 +0800
Message-ID: <1369049218-2850-1-git-send-email-xingchao.wang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id E2DF32610A8
 for <alsa-devel@alsa-project.org>; Mon, 20 May 2013 13:30:00 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, daniel@ffwll.ch, liam.r.girdwood@intel.com
Cc: alsa-devel@alsa-project.org, paulo.r.zanoni@intel.com, jocelyn.li@intel.com, mengdong.lin@intel.com, intel-gfx@lists.freedesktop.org, Wang Xingchao <xingchao.wang@linux.intel.com>, xingchao.wang@intel.com, jesse.barnes@intel.com, david.henningsson@canonical.com
List-Id: alsa-devel@alsa-project.org

Hi all,

   This is V4 and here're some changes notes:

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

Wang Xingchao (2):
  i915/drm: Add private api for power well usage
  ALSA: hda - Add power-welll support for haswell HDA

 drivers/gpu/drm/i915/i915_dma.c  |    6 +++
 drivers/gpu/drm/i915/i915_drv.h  |   12 +++++
 drivers/gpu/drm/i915/intel_drv.h |    4 ++
 drivers/gpu/drm/i915/intel_pm.c  |   98 +++++++++++++++++++++++++++++++++++---
 include/drm/i915_powerwell.h     |   36 ++++++++++++++
 sound/pci/hda/Kconfig            |   10 ++++
 sound/pci/hda/Makefile           |    3 ++
 sound/pci/hda/hda_i915.c         |   75 +++++++++++++++++++++++++++++
 sound/pci/hda/hda_i915.h         |   35 ++++++++++++++
 sound/pci/hda/hda_intel.c        |   41 ++++++++++++++--
 10 files changed, 310 insertions(+), 10 deletions(-)
 create mode 100644 include/drm/i915_powerwell.h
 create mode 100644 sound/pci/hda/hda_i915.c
 create mode 100644 sound/pci/hda/hda_i915.h

-- 
1.7.9.5
