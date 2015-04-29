From: mengdong.lin@intel.com
Subject: [PATCH v3 0/5] ALSA: hda - remove unnecessary
	controller dependency on i915 gfx power
Date: Wed, 29 Apr 2015 17:43:03 +0800
Message-ID: <cover.1430300071.git.mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 1A7452604AF
 for <alsa-devel@alsa-project.org>; Wed, 29 Apr 2015 11:32:18 +0200 (CEST)
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
Cc: Mengdong Lin <mengdong.lin@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@intel.com>

Mengdong Lin (5):
  ALSA: hda - implement a refcount for i915 power well switch
  ALSA: hda - allow a codec to control the link power
  ALSA: hda - implement link_power ops for i915 display power control
  ALSA: hda - divide controller and codec dependency on i915 gfx power
    well
  ALSA: hda - remove controller dependency on i915 power well for
    Baytrail/Braswell

 include/sound/hdaudio.h        |  4 ++++
 sound/hda/hdac_device.c        | 15 ++++++++++++++
 sound/pci/hda/hda_codec.c      |  4 ++++
 sound/pci/hda/hda_controller.c | 11 ++++++++++
 sound/pci/hda/hda_controller.h |  2 ++
 sound/pci/hda/hda_i915.c       | 18 +++++++++++++----
 sound/pci/hda/hda_intel.c      | 46 ++++++++++++++++++++++++++++++++++--------
 sound/pci/hda/hda_intel.h      |  2 ++
 sound/pci/hda/patch_hdmi.c     |  9 +++++++++
 9 files changed, 99 insertions(+), 12 deletions(-)

-- 
1.9.1
