From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/9] Allow hot-unplugging hd-audio codec driver
Date: Fri, 27 Feb 2015 23:55:35 +0100
Message-ID: <1425077744-4553-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id BA6E42612CC
 for <alsa-devel@alsa-project.org>; Fri, 27 Feb 2015 23:55:46 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 5F59FAAD1
 for <alsa-devel@alsa-project.org>; Fri, 27 Feb 2015 22:55:46 +0000 (UTC)
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

here is yet another patchset for HD-audio.  This time it's about
robustifying the dynamic unbind of a codec driver.  With these
patches, the codec driver can be freely bound / unbound in run time.
We had a similar feature via hwdep reconfig sysfs entry, but this is a
more generic form.

The patchset is applied on top of the previous one, topic/hda-regmap
branch of sound git tree.  This patchset itself is found in
topic/hda-unbind branch.


Takashi

===

Takashi Iwai (9):
  ALSA: hda - Split snd_hda_build_pcms()
  ALSA: hda - Add card field to hda_codec struct
  ALSA: hda - Remove superfluous memory allocation error messages
  ALSA: hda - Allocate hda_pcm objects dynamically
  ALSA: hda - Don't assume non-NULL PCM ops
  ALSA: core: Re-add snd_device_disconnect()
  ALSA: hda - Implement unbind more safely
  ALSA: hda - Build PCMs and controls at codec driver probe
  ALSA: hda - Drop codec driver module refcounting

 include/sound/core.h           |   3 +-
 sound/core/device.c            |  43 +++--
 sound/core/init.c              |   5 +-
 sound/pci/hda/hda_beep.c       |   4 +-
 sound/pci/hda/hda_bind.c       |  33 ++--
 sound/pci/hda/hda_codec.c      | 363 ++++++++++++++++++++---------------------
 sound/pci/hda/hda_codec.h      |  27 ++-
 sound/pci/hda/hda_controller.c |  53 +++---
 sound/pci/hda/hda_generic.c    |  28 ++--
 sound/pci/hda/hda_generic.h    |   2 +-
 sound/pci/hda/hda_hwdep.c      |   2 +-
 sound/pci/hda/hda_intel.c      |  15 +-
 sound/pci/hda/hda_jack.c       |   8 +-
 sound/pci/hda/hda_local.h      |   1 +
 sound/pci/hda/hda_proc.c       |   8 +-
 sound/pci/hda/hda_sysfs.c      |   2 +-
 sound/pci/hda/hda_tegra.c      |  10 --
 sound/pci/hda/hda_trace.h      |   4 +-
 sound/pci/hda/patch_ca0132.c   |  31 ++--
 sound/pci/hda/patch_hdmi.c     |  36 ++--
 sound/pci/hda/patch_realtek.c  |   2 +-
 sound/pci/hda/patch_si3054.c   |  11 +-
 sound/pci/hda/patch_via.c      |  14 +-
 23 files changed, 349 insertions(+), 356 deletions(-)

-- 
2.3.0
