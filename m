From: Wang Xingchao <xingchao.wang@linux.intel.com>
Subject: [PATCH 0/2 V2] Power-well API implementation for Haswell
Date: Tue, 14 May 2013 19:44:17 +0800
Message-ID: <1368531859-1943-1-git-send-email-xingchao.wang@linux.intel.com>
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
To: tiwai@suse.de, daniel@ffwll.ch, liam.r.girdwood@intel.com
Cc: alsa-devel@alsa-project.org, paulo.r.zanoni@intel.com, jocelyn.li@intel.com, mengdong.lin@intel.com, intel-gfx@lists.freedesktop.org, Wang Xingchao <xingchao.wang@linux.intel.com>, jesse.barnes@intel.com, david.henningsson@canonical.com
List-Id: alsa-devel@alsa-project.org

Hi all,

   This is V2 and some fixes after first round review:

   - use reference count to track power-well usage
   - remove external module, compiled into snd-hda-intel instead
   - manage symbols and module loading properly
   - remove IS_HSW macro, use flag instead
   - remove audio callback for gfx driver to avoid dependency 
   - split whole patch into two pieces for easy review
   - more typo fixes

Wang Xingchao (2):
  drm/915: Add private api for power well usage
  ALSA: hda - Add power-welll support for haswell HDA

 drivers/gpu/drm/i915/intel_pm.c |   76 +++++++++++++++++++++++++++++---
 include/drm/i915_powerwell.h    |   36 +++++++++++++++
 sound/pci/hda/Kconfig           |    8 ++++
 sound/pci/hda/Makefile          |    3 ++
 sound/pci/hda/hda_i915.c        |   92 +++++++++++++++++++++++++++++++++++++++
 sound/pci/hda/hda_i915.h        |   35 +++++++++++++++
 sound/pci/hda/hda_intel.c       |   33 ++++++++++++--
 7 files changed, 273 insertions(+), 10 deletions(-)
 create mode 100644 include/drm/i915_powerwell.h
 create mode 100644 sound/pci/hda/hda_i915.c
 create mode 100644 sound/pci/hda/hda_i915.h

-- 
1.7.9.5
