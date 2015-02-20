From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/6] Minor HD-audio cleanups
Date: Fri, 20 Feb 2015 08:08:21 +0100
Message-ID: <1424416107-32470-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 132512605DD
 for <alsa-devel@alsa-project.org>; Fri, 20 Feb 2015 08:08:30 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 599B1AC47
 for <alsa-devel@alsa-project.org>; Fri, 20 Feb 2015 07:08:30 +0000 (UTC)
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

this is a series of minor cleanups for HD-audio codes.  No functional
changes but just code refactoring for the further works.

The patches are found in topic/hda-cleanup branch of sound git tree,
too.


Takashi

===

Takashi Iwai (6):
  ALSA: hda - Drop hda_bus_template for snd_hda_bus_new()
  ALSA: hda - Embed struct hda_bus_unsolicited into struct hda_bus
  ALSA: hda - Introduce azx_has_pm_runtime() macro
  ALSA: hda - Fold hda_priv.h into hda_controller.h
  ALSA: hda - Drop azx_mixer_create()
  ALSA: hda - Split azx_codec_create() to two phases

 sound/pci/hda/hda_codec.c      |  54 +-----
 sound/pci/hda/hda_codec.h      |  22 +--
 sound/pci/hda/hda_controller.c |  96 +++++-----
 sound/pci/hda/hda_controller.h | 397 +++++++++++++++++++++++++++++++++++++++-
 sound/pci/hda/hda_i915.c       |   2 +-
 sound/pci/hda/hda_intel.c      |  23 ++-
 sound/pci/hda/hda_intel.h      |   2 +-
 sound/pci/hda/hda_local.h      |  17 --
 sound/pci/hda/hda_priv.h       | 406 -----------------------------------------
 sound/pci/hda/hda_tegra.c      |   9 +-
 10 files changed, 477 insertions(+), 551 deletions(-)
 delete mode 100644 sound/pci/hda/hda_priv.h

-- 
2.3.0
