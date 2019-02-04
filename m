From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 00/11] ALSA: procfs cleanups
Date: Mon,  4 Feb 2019 16:20:25 +0100
Message-ID: <20190204152036.14102-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id B6AD9267558
 for <alsa-devel@alsa-project.org>; Mon,  4 Feb 2019 16:20:39 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 30060ACBC
 for <alsa-devel@alsa-project.org>; Mon,  4 Feb 2019 15:20:39 +0000 (UTC)
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

this is a patchset for cleaning up the procfs handling.

The first three patches are to remove the superfluous
snd_info_register() calls (which are done eventually at the card
creation time), and the rest patches are for introducing new helpers
and cleaning up with them.  The latter has no functional changes but
only reducing lots of codes.


thanks,

Takashi

===

Takashi Iwai (11):
  ALSA: pcm: Remove superfluous snd_info_register() calls
  ALSA: compress: Remove superfluous snd_info_register() calls
  ALSA: pci: Remove superfluous snd_info_register() calls
  ALSA: info: Add standard helpers for card proc file entries
  ALSA: drivers: Clean up with new procfs helpers
  ALSA: isa: Clean up with new procfs helpers
  ALSA: i2c: Clean up with new procfs helpers
  ALSA: pci: Clean up with new procfs helpers
  ALSA: pcmcia: Clean up with new procfs helpers
  ALSA: sparc: Clean up with new procfs helpers
  ALSA: usb: Clean up with new procfs helpers

 include/sound/info.h                    | 35 ++++++++++++++
 sound/core/compress_offload.c           | 11 +----
 sound/core/info.c                       | 31 +++++++++++++
 sound/core/pcm.c                        | 79 +++++++++++---------------------
 sound/drivers/aloop.c                   | 10 +---
 sound/drivers/dummy.c                   | 10 +---
 sound/drivers/vx/vx_core.c              |  5 +-
 sound/i2c/other/ak4113.c                |  5 +-
 sound/i2c/other/ak4114.c                |  5 +-
 sound/i2c/other/ak4xxx-adda.c           |  8 +---
 sound/isa/gus/gus_irq.c                 |  5 +-
 sound/isa/gus/gus_mem.c                 |  6 +--
 sound/isa/opti9xx/miro.c                |  5 +-
 sound/isa/sb/sb16_csp.c                 |  5 +-
 sound/pci/ac97/ac97_proc.c              | 26 ++++-------
 sound/pci/ad1889.c                      |  6 +--
 sound/pci/ak4531_codec.c                |  5 +-
 sound/pci/ali5451/ali5451.c             |  4 +-
 sound/pci/asihpi/asihpi.c               |  6 +--
 sound/pci/atiixp.c                      |  5 +-
 sound/pci/atiixp_modem.c                |  6 +--
 sound/pci/ca0106/ca0106_proc.c          | 40 ++++++----------
 sound/pci/cmipci.c                      |  5 +-
 sound/pci/cs4281.c                      |  3 +-
 sound/pci/cs46xx/dsp_spos.c             | 16 ++-----
 sound/pci/emu10k1/emu10k1x.c            | 12 ++---
 sound/pci/emu10k1/emuproc.c             | 81 +++++++++++++--------------------
 sound/pci/ens1370.c                     |  6 +--
 sound/pci/hda/hda_proc.c                |  9 +---
 sound/pci/ice1712/ice1712.c             |  5 +-
 sound/pci/ice1712/ice1724.c             |  5 +-
 sound/pci/ice1712/pontis.c              | 12 ++---
 sound/pci/ice1712/prodigy192.c          |  5 +-
 sound/pci/ice1712/prodigy_hifi.c        |  8 +---
 sound/pci/ice1712/quartet.c             |  4 +-
 sound/pci/intel8x0.c                    |  6 +--
 sound/pci/intel8x0m.c                   |  6 +--
 sound/pci/korg1212/korg1212.c           |  6 +--
 sound/pci/lola/lola_proc.c              | 16 ++-----
 sound/pci/lx6464es/lx6464es.c           |  8 +---
 sound/pci/mixart/mixart.c               |  6 +--
 sound/pci/oxygen/oxygen_lib.c           |  5 +-
 sound/pci/pcxhr/pcxhr.c                 | 21 +++------
 sound/pci/riptide/riptide.c             |  6 +--
 sound/pci/rme32.c                       |  5 +-
 sound/pci/rme96.c                       |  5 +-
 sound/pci/rme9652/hdsp.c                |  5 +-
 sound/pci/rme9652/hdspm.c               | 55 ++++++++++------------
 sound/pci/rme9652/rme9652.c             |  6 +--
 sound/pci/sonicvibes.c                  |  6 +--
 sound/pci/trident/trident_main.c        |  4 +-
 sound/pci/via82xx.c                     |  6 +--
 sound/pci/via82xx_modem.c               |  6 +--
 sound/pci/ymfpci/ymfpci_main.c          |  6 +--
 sound/pcmcia/pdaudiocf/pdaudiocf_core.c |  5 +-
 sound/sparc/dbri.c                      | 10 +---
 sound/usb/mixer.c                       |  7 ++-
 sound/usb/mixer_quirks.c                |  6 +--
 sound/usb/proc.c                        | 13 ++----
 59 files changed, 268 insertions(+), 446 deletions(-)

-- 
2.16.4
