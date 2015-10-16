From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/6] HD-audio modalias support patchset
Date: Fri, 16 Oct 2015 18:20:52 +0200
Message-ID: <1445012458-3337-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 8506F26671C
 for <alsa-devel@alsa-project.org>; Fri, 16 Oct 2015 18:21:07 +0200 (CEST)
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
Cc: Vinod Koul <vinod.koul@intel.com>, Jeeja Kp <jeeja.kp@intel.com>, Subhransu S Prusty <subhransu.s.prusty@intel.com>, Liam Girdwood <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

Hi,

this is a patchset to add the support of automatic modalias creation
for HD-audio codec drivers like other standard drivers.  Currently,
the HDA codec driver has put module alias manually due to ugly
historical reasons.  This patch finally moves to the saner way.

Also it adds the udev modalias support so that it can be autoloaded in
udev.

The patchset was initiated by Intel people for SKL ASoC drivers.  Now
I brushed up and made it working for legacy drivers.

The current patchset is found in topic/hda-modalias branch of sound
git tree, too.


thanks,

Takashi

===

Subhransu S. Prusty (2):
  ALSA: hda - Add hduadio support to DEVTABLE
  ALSA: hda - Add hdaudio bus modalias support

Takashi Iwai (3):
  ALSA: hda - Add api_version to hda_device_id struct
  ALSA: hda - Add a common helper to give the codec modalias string
  ALSA: hda - convert to hda_device_id

Thierry Reding (1):
  ALSA: hda - Advertise MODALIAS in uevent

 include/linux/mod_devicetable.h   |   8 ++
 include/sound/hdaudio.h           |  12 +--
 scripts/mod/devicetable-offsets.c |   5 +
 scripts/mod/file2alias.c          |  17 +++
 sound/hda/hda_bus_type.c          |  13 +++
 sound/hda/hdac_device.c           |  15 +++
 sound/hda/hdac_sysfs.c            |   8 ++
 sound/pci/hda/hda_bind.c          |  32 +++---
 sound/pci/hda/hda_codec.h         |  19 ++--
 sound/pci/hda/hda_generic.c       |   7 +-
 sound/pci/hda/patch_analog.c      |  37 ++++---
 sound/pci/hda/patch_ca0110.c      |  15 ++-
 sound/pci/hda/patch_ca0132.c      |   9 +-
 sound/pci/hda/patch_cirrus.c      |  21 ++--
 sound/pci/hda/patch_cmedia.c      |  15 ++-
 sound/pci/hda/patch_conexant.c    | 118 ++++++---------------
 sound/pci/hda/patch_hdmi.c        | 201 +++++++++++++----------------------
 sound/pci/hda/patch_realtek.c     | 122 ++++++++++------------
 sound/pci/hda/patch_si3054.c      |  39 +++----
 sound/pci/hda/patch_sigmatel.c    | 214 +++++++++++++++++++-------------------
 sound/pci/hda/patch_via.c         | 153 ++++++++++-----------------
 21 files changed, 475 insertions(+), 605 deletions(-)

-- 
2.6.1
