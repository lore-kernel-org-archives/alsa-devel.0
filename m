From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 00/18] ALSA: hdac: move hdac helpers to core
Date: Tue,  6 Oct 2015 16:07:37 +0100
Message-ID: <1444144075-28963-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 17C172655A5
 for <alsa-devel@alsa-project.org>; Tue,  6 Oct 2015 17:08:39 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

Here is the second version which updates the users.

This update was done using coccinelle scripts. I also noticed that the
coccinelle is reformaing the change lines, but changes looked good to me so
I have kept them, please do let me know if you would like these to be
removed.

Subhransu S. Prusty (1):
  ALSA: hdac: Copy codec helpers to core

Vinod Koul (17):
  ALSA: hda: move hda beep to use hdac helpers
  ALSA: hda: move hda_eld to use hdac helpers
  ALSA: hda: move hda_generic to use hdac helpers
  ALSA: hda: move hda_hwdep to use hdac helpers
  ALSA: hda: move hda_jack to use hdac helpers
  ALSA: hda: move hda_proc to use hdac helpers
  ALSA: hda: move patch_analog to use hdac helpers
  ALSA: hda: move patch_ca0132.c to use hdac helpers
  ALSA: hda: move patch_cirrus to use hdac helpers
  ALSA: hda: move to use hdac helpers
  ALSA: hda: move patch_hdmi to use hdac helpers
  ALSA: hda: move patch_realtek to use hdac helpers
  ALSA: hda: move patch_si3054 to use hdac helpers
  ALSA: hda: move patch_sigmatel to use hdac helpers
  ALSA: hda: move patch_via to use hdac helpers
  ALSA: hda: move hda_codec to use hdac helpers
  ALSA: hda: remove the old helpers

 include/sound/hdaudio.h        |   6 +
 sound/hda/hdac_device.c        |  81 ++++++++++++
 sound/pci/hda/hda_beep.c       |   4 +-
 sound/pci/hda/hda_codec.c      | 128 +++++++-----------
 sound/pci/hda/hda_codec.h      |   5 -
 sound/pci/hda/hda_eld.c        |  65 +++++++---
 sound/pci/hda/hda_generic.c    |   9 +-
 sound/pci/hda/hda_hwdep.c      |   4 +-
 sound/pci/hda/hda_jack.c       |   8 +-
 sound/pci/hda/hda_local.h      |  13 --
 sound/pci/hda/hda_proc.c       |  80 ++++++------
 sound/pci/hda/patch_analog.c   |  10 +-
 sound/pci/hda/patch_ca0132.c   | 223 ++++++++++++++++----------------
 sound/pci/hda/patch_cirrus.c   |  52 ++++----
 sound/pci/hda/patch_conexant.c |  20 +--
 sound/pci/hda/patch_hdmi.c     | 285 +++++++++++++++++++++--------------------
 sound/pci/hda/patch_realtek.c  | 136 +++++++++++---------
 sound/pci/hda/patch_si3054.c   |  10 +-
 sound/pci/hda/patch_sigmatel.c |  78 +++++------
 sound/pci/hda/patch_via.c      |  14 +-
 20 files changed, 660 insertions(+), 571 deletions(-)

-- 
2.4.3
