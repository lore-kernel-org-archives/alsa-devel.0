From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/3] ALSA: PM-related fixes/cleanups
Date: Wed, 27 Jun 2018 11:10:31 +0200
Message-ID: <20180627091034.22724-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id F18D6267950
 for <alsa-devel@alsa-project.org>; Wed, 27 Jun 2018 11:10:39 +0200 (CEST)
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
Cc: =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, Chris Wilson <chris@chris-wilson.co.uk>
List-Id: alsa-devel@alsa-project.org

Hi,

this is a patch set addressing some minor issues found in PM-related
stuff, as well as the Intel HDMI fallback issue.  The first patch
covers the unusual error paths from runtime PM, the second one is a
code refactoring and the last one fixes the superfluous (rather
harmful) binding with the generic HDMI driver as fallback of i915
component binding.


Takashi

===

Takashi Iwai (3):
  ALSA: hda - Handle error from snd_hda_power_up*()
  ALSA: hda - Move in_pm accessors to HDA core
  ALSA: hda/hdmi - Don't fall back to generic when i915 binding fails

 include/sound/hdaudio.h        | 27 +++++++++++++++++
 sound/pci/hda/hda_beep.c       |  3 +-
 sound/pci/hda/hda_codec.c      | 25 ++++++----------
 sound/pci/hda/hda_controller.c |  4 ++-
 sound/pci/hda/hda_proc.c       |  3 +-
 sound/pci/hda/hda_sysfs.c      |  4 ++-
 sound/pci/hda/patch_ca0132.c   | 53 +++++++++++++++++++++++++++-------
 sound/pci/hda/patch_hdmi.c     |  4 ++-
 sound/pci/hda/patch_realtek.c  |  3 +-
 9 files changed, 93 insertions(+), 33 deletions(-)

-- 
2.17.1
