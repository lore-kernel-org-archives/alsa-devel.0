From: Wang Xingchao <xingchao.wang@linux.intel.com>
Subject: [PATCH 0/4 V6] Power-well API implementation for Haswell
Date: Mon, 27 May 2013 17:15:12 +0800
Message-ID: <1369646116-11942-1-git-send-email-xingchao.wang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
Errors-To: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
To: daniel@ffwll.ch, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, jocelyn.li@intel.com, intel-gfx@lists.freedesktop.org, Wang Xingchao <xingchao.wang@linux.intel.com>, liam.r.girdwood@intel.com, david.henningsson@canonical.com
List-Id: alsa-devel@alsa-project.org

Hi all,

   This is V6 and here're some changes notes:

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
 drivers/gpu/drm/i915/i915_drv.h  |   12 +++++
 drivers/gpu/drm/i915/intel_drv.h |    4 ++
 drivers/gpu/drm/i915/intel_pm.c  |   92 +++++++++++++++++++++++++++++++++++---
 include/drm/i915_powerwell.h     |   36 +++++++++++++++
 sound/pci/hda/Kconfig            |   10 +++++
 sound/pci/hda/Makefile           |    2 +
 sound/pci/hda/hda_i915.c         |   75 +++++++++++++++++++++++++++++++
 sound/pci/hda/hda_i915.h         |   35 +++++++++++++++
 sound/pci/hda/hda_intel.c        |   87 ++++++++++++++++++++++++++++-------
 10 files changed, 335 insertions(+), 24 deletions(-)
 create mode 100644 include/drm/i915_powerwell.h
 create mode 100644 sound/pci/hda/hda_i915.c
 create mode 100644 sound/pci/hda/hda_i915.h

-- 
1.7.9.5
