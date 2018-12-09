From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/7] ALSA: HD-audio display power fixes
Date: Sun,  9 Dec 2018 10:33:11 +0100
Message-ID: <20181209093318.27829-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id AF62E267AA7
 for <alsa-devel@alsa-project.org>; Sun,  9 Dec 2018 10:33:28 +0100 (CET)
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Jie Yang <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Hi,

this patch is about fixing possible HD-audio display power unbalance.
Basically the "fix" is done by refactoring the whole relevant code.
It starts from the Intel HD-audio runtime PM refactoring, followed
by the display PM API change, and lots of code cleanups.

Since it changes the display power API function, it hits both legacy
and ASoC drivers.

The patches are kept in topic/hda-pm-refactor branch of my sound git
tree.  This will be an immutable branch once when merged to for-next,
so that it can be merged to ASoC tree if any conflicting change needs
to be applied.


Takashi

===

Takashi Iwai (7):
  ALSA: hda/intel: Refactoring PM code
  ALSA: hda: Refactor display power management
  ALSA: hda/intel: Drop superfluous AZX_DCAPS_I915_POWERWELL checks
  ALSA: hda/intel: Properly free the display power at error path
  ALSA: hda: Make snd_hdac_display_power() void function
  ASoC: hdac_hdmi: Add missing display power-off at driver removal
  ALSA: hda/hdmi: Always set display_power_control for Intel HSW+ codecs

 include/sound/hda_codec.h      |   1 +
 include/sound/hda_component.h  |   9 +-
 include/sound/hdaudio.h        |   7 +-
 sound/hda/hdac_component.c     |  39 ++++---
 sound/hda/hdac_device.c        |  17 ---
 sound/pci/hda/hda_codec.c      |  16 ++-
 sound/pci/hda/hda_controller.c |  11 --
 sound/pci/hda/hda_intel.c      | 192 +++++++++++++--------------------
 sound/pci/hda/patch_hdmi.c     |   8 +-
 sound/soc/codecs/hdac_hdmi.c   |  22 ++--
 sound/soc/intel/skylake/skl.c  |  40 ++-----
 11 files changed, 134 insertions(+), 228 deletions(-)

-- 
2.19.2
