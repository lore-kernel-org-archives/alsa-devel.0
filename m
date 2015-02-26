From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 00/10] Modernization of HD-audio bus and PM
	stuff
Date: Thu, 26 Feb 2015 18:00:15 +0100
Message-ID: <1424970025-8082-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A5FAA2606AB
 for <alsa-devel@alsa-project.org>; Thu, 26 Feb 2015 18:00:31 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 5B64BADBB
 for <alsa-devel@alsa-project.org>; Thu, 26 Feb 2015 17:00:31 +0000 (UTC)
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
List-Id: alsa-devel@alsa-project.org

Hi,

here is yet another patchset for HD-audio modernization.  The device
binding is replaced with the standard bus, and the power-save stuff is
rewritten with the standard runtime PM.  In addition, a few cleanup
patches follow.

There won't (and shouldn't) be big changes from the functionality POV.
This is rather a large restructuring inside.  It should work mostly
without any visible changes.  You can see a bit finer control for
runtime PM in sysfs now, for example, but the original interface via
power_save option is still kept.


Takashi

===

Takashi Iwai (10):
  ALSA: hda - Decouple PCM and hwdep devices from codec object
  ALSA: hda - Bind codecs via standard bus
  ALSA: hda - Move codec suspend/resume to codec driver
  ALSA: hda - Use standard runtime PM for codec power-save control
  ALSA: hda - Drop power_save value indirection in hda_bus
  ALSA: hda - Replace bus pm_notify with the standard runtime PM
    framework
  ALSA: hda - Power down codec automatically at registration
  ALSA: hda - Set parent of input beep devices
  ALSA: hda - Remove channel mode helper functions
  ALSA: hda - Clear pcm pointer assigned to hda_pcm at device removal

 sound/pci/hda/Makefile         |   2 +-
 sound/pci/hda/hda_beep.c       |   2 +-
 sound/pci/hda/hda_bind.c       | 321 ++++++++++++++++++
 sound/pci/hda/hda_codec.c      | 731 ++++++++---------------------------------
 sound/pci/hda/hda_codec.h      | 108 ++----
 sound/pci/hda/hda_controller.c |  62 ++--
 sound/pci/hda/hda_controller.h |   4 +-
 sound/pci/hda/hda_generic.c    |  18 +-
 sound/pci/hda/hda_hwdep.c      |   3 -
 sound/pci/hda/hda_intel.c      |  33 +-
 sound/pci/hda/hda_local.h      |  41 +--
 sound/pci/hda/hda_tegra.c      |  23 +-
 sound/pci/hda/hda_trace.h      |  24 --
 sound/pci/hda/patch_analog.c   |  16 +-
 sound/pci/hda/patch_ca0110.c   |  16 +-
 sound/pci/hda/patch_ca0132.c   |  16 +-
 sound/pci/hda/patch_cirrus.c   |  16 +-
 sound/pci/hda/patch_cmedia.c   |  16 +-
 sound/pci/hda/patch_conexant.c |  16 +-
 sound/pci/hda/patch_hdmi.c     |  27 +-
 sound/pci/hda/patch_realtek.c  |  16 +-
 sound/pci/hda/patch_si3054.c   |  16 +-
 sound/pci/hda/patch_sigmatel.c |  20 +-
 sound/pci/hda/patch_via.c      |  16 +-
 24 files changed, 572 insertions(+), 991 deletions(-)
 create mode 100644 sound/pci/hda/hda_bind.c

-- 
2.3.0
