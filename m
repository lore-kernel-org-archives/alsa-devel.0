From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH RFC 00/26] Kill set_fs() in ALSA codes
Date: Thu, 11 May 2017 23:08:59 +0200
Message-ID: <20170511210925.18208-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9D168266FCC
 for <alsa-devel@alsa-project.org>; Thu, 11 May 2017 23:09:30 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 44317AEAF
 for <alsa-devel@alsa-project.org>; Thu, 11 May 2017 21:09:30 +0000 (UTC)
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

this is a slightly lengthy patchset, basically targeted for 4.13, thus
it's still in RFC.  The main purpose of this patchset is to get rid of
get_fs() / set_fs() usages in ALSA codes.

The patchset starts from a patch that looks fairly irrelevant with the
goal (the conversion of HD-audio bind-mute code), but it's a step for
the long trail.  The biggest change in the patchset is the conversion
of copy & silence PCM ops into the new copy_silence ops.  It helped
for reducing the code size and for handling the in-kernel buffer
copies.

The current patches are found in topic/kill-set_fs branch of my
sound.git tree.


thanks,

Takashi

===

Takashi Iwai (26):
  ALSA: hda - Simplify bound-beep mute control for ALC268
  ALSA: hda - Move bind-mixer switch codes to generic parser
  ALSA: hda - Remove the generic bind ctl helpers
  ALSA: hda - Remove the use of set_fs()
  ALSA: hda - Fix a typo in comment
  ALSA: hda - Remove superfluous header inclusions
  ALSA: opl3: Kill unused set_fs()
  ALSA: emu10k1: Get rid of set_fs() usage
  ALSA: pcm: Remove set_fs() in PCM core code
  ALSA: pcm: Introduce copy_silence PCM ops
  ALSA: Update document about copy_silence PCM ops
  ALSA: dummy: Convert to copy_silence ops
  ALSA: es1938: Convert to copy_silence ops
  ALSA: korg1212: Convert to copy_silence ops
  ALSA: nm256: Convert to copy_silence ops
  ALSA: rme32: Convert to copy_silence ops
  ALSA: rme96: Convert to copy_silence ops
  ALSA: rme9652: Convert to copy_silence ops
  ALSA: hdsp: Convert to copy_silence ops
  ALSA: gus: Convert to copy_silence ops
  ALSA: sb: Convert to copy_silence ops
  ALSA: sh: Convert to copy_silence ops
  ASoC: blackfin: Convert to copy_silence ops
  [media] solo6x10: Convert to copy_silence ops
  ALSA: pcm: Drop the old copy and silence ops
  ALSA: pcm: Kill set_fs() usage in OSS layer and USB gadget

 .../sound/kernel-api/writing-an-alsa-driver.rst    | 110 +++++----
 drivers/media/pci/solo6x10/solo6x10-g723.c         |  11 +-
 drivers/usb/gadget/function/u_uac1.c               |   8 +-
 include/sound/pcm.h                                |  19 +-
 sound/core/oss/pcm_oss.c                           |  62 ++---
 sound/core/pcm_compat.c                            |  22 +-
 sound/core/pcm_lib.c                               | 174 +++++++++-----
 sound/core/pcm_native.c                            | 122 ++++++----
 sound/drivers/dummy.c                              |  13 +-
 sound/drivers/opl3/opl3_oss.c                      |  14 --
 sound/isa/gus/gus_pcm.c                            |  43 +---
 sound/isa/sb/emu8000_pcm.c                         |  99 +++-----
 sound/pci/emu10k1/emufx.c                          | 127 ++++++-----
 sound/pci/es1938.c                                 |  11 +-
 sound/pci/hda/hda_codec.c                          | 251 +++------------------
 sound/pci/hda/hda_generic.c                        |  46 +++-
 sound/pci/hda/hda_local.h                          |  61 -----
 sound/pci/hda/patch_realtek.c                      |  37 ++-
 sound/pci/korg1212/korg1212.c                      | 128 +++--------
 sound/pci/nm256/nm256.c                            |  35 ++-
 sound/pci/rme32.c                                  |  49 ++--
 sound/pci/rme96.c                                  |  52 ++---
 sound/pci/rme9652/hdsp.c                           |  44 ++--
 sound/pci/rme9652/rme9652.c                        |  46 ++--
 sound/sh/sh_dac_audio.c                            |  40 +---
 sound/soc/blackfin/bf5xx-ac97-pcm.c                |   6 +-
 sound/soc/blackfin/bf5xx-ac97.c                    |  18 +-
 sound/soc/blackfin/bf5xx-i2s-pcm.c                 |  46 ++--
 sound/soc/soc-pcm.c                                |   3 +-
 29 files changed, 696 insertions(+), 1001 deletions(-)

-- 
2.12.2
