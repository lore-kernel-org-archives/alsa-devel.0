From: libin.yang@linux.intel.com
Subject: [RFC PATCH 0/4] MST DP audio support
Date: Mon,  7 Mar 2016 22:57:42 +0800
Message-ID: <1457362666-53937-1-git-send-email-libin.yang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 3BF26261504
 for <alsa-devel@alsa-project.org>; Mon,  7 Mar 2016 16:02:42 +0100 (CET)
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

The patchset are tmp patches. The API between audio and gfx is
still in discussion.

Libin Yang (4):
  ALSA: hda - codec add DP MST support for connection list
  ALSA: hda - add DP mst verb support
  ALSA - hda: add devid support in acom
  ALSA - hda: add DP MST support

 drivers/gpu/drm/i915/intel_audio.c |   2 +-
 include/drm/i915_component.h       |   2 +-
 include/sound/hda_i915.h           |   6 +-
 sound/hda/hdac_i915.c              |   7 +-
 sound/pci/hda/hda_codec.c          | 217 ++++++++++++++++++++++++++++++++++---
 sound/pci/hda/hda_codec.h          |   8 ++
 sound/pci/hda/patch_hdmi.c         | 172 ++++++++++++++++++++---------
 7 files changed, 340 insertions(+), 74 deletions(-)

-- 
1.9.1
