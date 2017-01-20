From: Jerome Anand <jerome.anand@intel.com>
Subject: [PATCH v4 0/5] Add support for Legacy HDMI audio
	drivers
Date: Sat, 21 Jan 2017 03:52:27 +0530
Message-ID: <20170120222232.27791-1-jerome.anand@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id E34012666EA
 for <alsa-devel@alsa-project.org>; Fri, 20 Jan 2017 11:20:48 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: intel-gfx@lists.freedesktop.org, alsa-devel@alsa-project.org
Cc: tiwai@suse.de, pierre-louis.bossart@linux.intel.com, broonie@kernel.org, rakesh.a.ughreja@intel.com, jerome.anand@intel.com, ville.syrjala@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Legacy (CherryTrail/ Baytrail) HDMI audio drivers added
Legacy hdmi audio-Gfx interaction/ interfacing is updated to use 
irq chip framework

This patch series has only been tested on hardware with 
a single HDMI connector/pipe and additional work may be needed for newer 
machines with 2 connectors

Jerome Anand (5):
  drm/i915: setup bridge for HDMI LPE audio driver
  drm/i915: Add support for audio driver notifications
  ALSA: add Intel HDMI LPE audio driver for BYT/CHT-T
  ALSA: x86: hdmi: Add audio support for BYT and CHT
  ALSA: x86: hdmi: continue playback even when display resolution
    changes

 Documentation/gpu/i915.rst             |    9 +
 drivers/gpu/drm/i915/Makefile          |    3 +
 drivers/gpu/drm/i915/i915_drv.c        |    8 +-
 drivers/gpu/drm/i915/i915_drv.h        |   17 +
 drivers/gpu/drm/i915/i915_irq.c        |   16 +
 drivers/gpu/drm/i915/i915_reg.h        |    3 +
 drivers/gpu/drm/i915/intel_audio.c     |    8 +
 drivers/gpu/drm/i915/intel_hdmi.c      |    1 +
 drivers/gpu/drm/i915/intel_lpe_audio.c |  388 +++++++
 include/drm/intel_lpe_audio.h          |   46 +
 sound/Kconfig                          |    2 +
 sound/Makefile                         |    2 +-
 sound/x86/Kconfig                      |   15 +
 sound/x86/Makefile                     |    6 +
 sound/x86/intel_hdmi_audio.c           | 1870 ++++++++++++++++++++++++++++++++
 sound/x86/intel_hdmi_audio.h           |  197 ++++
 sound/x86/intel_hdmi_audio_if.c        |  551 ++++++++++
 sound/x86/intel_hdmi_lpe_audio.c       |  617 +++++++++++
 sound/x86/intel_hdmi_lpe_audio.h       |  683 ++++++++++++
 19 files changed, 4439 insertions(+), 3 deletions(-)
 create mode 100644 drivers/gpu/drm/i915/intel_lpe_audio.c
 create mode 100644 include/drm/intel_lpe_audio.h
 create mode 100644 sound/x86/Kconfig
 create mode 100644 sound/x86/Makefile
 create mode 100644 sound/x86/intel_hdmi_audio.c
 create mode 100644 sound/x86/intel_hdmi_audio.h
 create mode 100644 sound/x86/intel_hdmi_audio_if.c
 create mode 100644 sound/x86/intel_hdmi_lpe_audio.c
 create mode 100644 sound/x86/intel_hdmi_lpe_audio.h

-- 
2.9.3

base-commit: eb5c556a1e5eff388e48e4b7cf61e95783019e83
