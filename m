From: libin.yang@linux.intel.com
Subject: [RFC PATCH v2 0/3] start to support MST
Date: Mon, 21 Mar 2016 16:37:53 +0800
Message-ID: <1458549476-77040-1-git-send-email-libin.yang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 13DC7261A5E
 for <alsa-devel@alsa-project.org>; Mon, 21 Mar 2016 09:39:03 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: libin.yang@intel.com, mengdong.lin@intel.com, Libin Yang <libin.yang@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Libin Yang <libin.yang@linux.intel.com>

These patches are draft patches to support MST. The patches doesn't
work because of lacking support in gfx driver.

Libin Yang (3):
  ALSA: hda - add DP mst verb support
  ALSA - hda: add devid support in acom
  ALSA - hda: add DP MST support

 drivers/gpu/drm/i915/intel_audio.c |   2 +-
 include/drm/i915_component.h       |   2 +-
 include/sound/hda_i915.h           |   6 +-
 sound/hda/hdac_i915.c              |   7 +-
 sound/pci/hda/hda_codec.c          |  86 ++++++++++++++++-
 sound/pci/hda/hda_codec.h          |   3 +
 sound/pci/hda/patch_hdmi.c         | 184 +++++++++++++++++++++++++++----------
 7 files changed, 227 insertions(+), 63 deletions(-)

-- 
1.9.1
