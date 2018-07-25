From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 00/12] Fixes for sparse warnings and other misc
	bugs
Date: Wed, 25 Jul 2018 23:00:45 +0200
Message-ID: <20180725210057.18017-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 8366A267759
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 23:01:04 +0200 (CEST)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 5E785B062
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 21:01:03 +0000 (UTC)
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

this is a series of patches to correct bugs spotted by sparse and
manual lookups, applied in a wide range of drivers.


Takashi

===

Takashi Iwai (12):
  ALSA: usb-audio: Fix multiple definitions in AU0828_DEVICE() macro
  ALSA: msnd: Add missing __iomem annotations
  ALSA: msnd: Fix the default sample sizes
  ALSA: hda/ca0132 - Use NULL instead of 0
  ALSA: msnd: Use NULL instead of 0
  ALSA: hda - Fix a sparse warning about snd_ctl_elem_iface_t
  ALSA: opl3: Declare common variables properly
  ALSA: usb-audio: Declare the common variable in header file
  ALSA: pcm: Add __force to cast in snd_pcm_lib_read/write()
  ALSA: pcm: Use standard lower_32_bits() and upper_32_bits()
  ALSA: korg1212: Add __force annotation to cast in user-copy callbacks
  ALSA: emu10k1: Fix missing __force annotation for user/kernel pointer
    cast

 include/sound/pcm.h             |  4 ++--
 sound/core/oss/pcm_plugin.c     |  8 ++++----
 sound/drivers/opl3/opl3_drums.c |  2 --
 sound/drivers/opl3/opl3_lib.c   |  3 +--
 sound/drivers/opl3/opl3_midi.c  |  4 ----
 sound/drivers/opl3/opl3_oss.c   |  2 --
 sound/drivers/opl3/opl3_synth.c |  1 +
 sound/drivers/opl3/opl3_voice.h |  4 ++++
 sound/isa/msnd/msnd.c           | 18 +++++++++---------
 sound/isa/msnd/msnd.h           |  2 +-
 sound/isa/msnd/msnd_midi.c      |  2 +-
 sound/isa/msnd/msnd_pinnacle.c  |  8 ++++----
 sound/pci/emu10k1/emufx.c       | 24 ++++++++++++------------
 sound/pci/hda/hda_codec.c       |  4 ++--
 sound/pci/hda/patch_ca0132.c    |  3 +--
 sound/pci/korg1212/korg1212.c   |  4 ++--
 sound/usb/mixer.h               |  2 ++
 sound/usb/mixer_quirks.c        |  2 --
 sound/usb/quirks-table.h        |  3 ++-
 19 files changed, 48 insertions(+), 52 deletions(-)

-- 
2.18.0
