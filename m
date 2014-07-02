From: mengdong.lin@intel.com
Subject: [PATCH 0/3] ALSA: hda - restore BCLK from CDCLK for
	Haswell/Broadwell display audio
Date: Wed,  2 Jul 2014 22:43:38 +0800
Message-ID: <cover.1404311751.git.mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 71B692657C7
 for <alsa-devel@alsa-project.org>; Wed,  2 Jul 2014 16:41:33 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de, jani.nikula@intel.com
Cc: Mengdong Lin <mengdong.lin@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@intel.com>

The 3 patches are for Haswell/Broadwell display HD-A controller.

The 1st patch is for i915 display driver, providing a private interface for
the audio driver to query CDCLK.

The other 2 patches are for HD-A driver, will restore BCLK by setting M/N 
values as per CDCLK.

Mengdong Lin (3):
  drm/i915: provide interface for audio driver to query cdclk
  ALSA: hda - define hda_get_display_clk to query CDCLK for
    Haswell/Broadwell
  ALSA: hda - restore BCLK M/N value as per CDCLK for HSW/BDW display
    HDA controller

 drivers/gpu/drm/i915/intel_pm.c | 21 +++++++++++++++
 include/drm/i915_powerwell.h    |  1 +
 sound/pci/hda/hda_i915.c        | 22 +++++++++++++++
 sound/pci/hda/hda_i915.h        |  1 +
 sound/pci/hda/hda_intel.c       | 60 +++++++++++++++++++++++++----------------
 5 files changed, 82 insertions(+), 23 deletions(-)

-- 
1.8.1.2
