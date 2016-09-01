From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 0/6] constify snd_pcm_ops structures
Date: Fri,  2 Sep 2016 00:13:08 +0200
Message-ID: <1472767994-26269-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Constify snd_pcm_ops structures.

---

 sound/firewire/dice/dice-pcm.c          |    4 ++--
 sound/firewire/digi00x/digi00x-pcm.c    |    4 ++--
 sound/firewire/oxfw/oxfw-pcm.c          |    4 ++--
 sound/firewire/tascam/tascam-pcm.c      |    4 ++--
 sound/pci/ad1889.c                      |    4 ++--
 sound/pci/als300.c                      |    4 ++--
 sound/pci/als4000.c                     |    4 ++--
 sound/pci/asihpi/asihpi.c               |    4 ++--
 sound/pci/atiixp.c                      |    6 +++---
 sound/pci/atiixp_modem.c                |    4 ++--
 sound/pci/aw2/aw2-alsa.c                |    4 ++--
 sound/pci/azt3328.c                     |    6 +++---
 sound/pci/bt87x.c                       |    2 +-
 sound/pci/ca0106/ca0106_main.c          |   16 ++++++++--------
 sound/pci/cmipci.c                      |   10 +++++-----
 sound/pci/cs4281.c                      |    4 ++--
 sound/pci/cs5535audio/cs5535audio_pcm.c |    4 ++--
 sound/pci/ctxfi/ctpcm.c                 |    4 ++--
 sound/pci/emu10k1/emu10k1x.c            |    4 ++--
 sound/pci/emu10k1/emupcm.c              |   12 ++++++------
 sound/pci/emu10k1/p16v.c                |    4 ++--
 sound/pci/ens1370.c                     |    6 +++---
 sound/pci/es1938.c                      |    4 ++--
 sound/pci/es1968.c                      |    4 ++--
 sound/pci/fm801.c                       |    4 ++--
 sound/pci/hda/hda_controller.c          |    2 +-
 sound/pci/ice1712/ice1712.c             |   10 +++++-----
 sound/pci/ice1712/ice1724.c             |   10 +++++-----
 sound/pci/korg1212/korg1212.c           |    4 ++--
 sound/pci/lola/lola_pcm.c               |    2 +-
 sound/pci/lx6464es/lx6464es.c           |    4 ++--
 sound/pci/maestro3.c                    |    4 ++--
 sound/pci/mixart/mixart.c               |    4 ++--
 sound/pci/nm256/nm256.c                 |    4 ++--
 sound/pci/oxygen/oxygen_pcm.c           |   12 ++++++------
 sound/pci/pcxhr/pcxhr.c                 |    2 +-
 sound/pci/riptide/riptide.c             |    4 ++--
 sound/pci/rme32.c                       |   16 ++++++++--------
 sound/pci/rme96.c                       |    8 ++++----
 sound/pci/rme9652/hdsp.c                |    4 ++--
 sound/pci/rme9652/hdspm.c               |    2 +-
 sound/pci/rme9652/rme9652.c             |    4 ++--
 sound/pci/sonicvibes.c                  |    4 ++--
 sound/pci/trident/trident_main.c        |   12 ++++++------
 sound/pci/via82xx.c                     |   10 +++++-----
 sound/pci/via82xx_modem.c               |    4 ++--
 sound/pci/ymfpci/ymfpci_main.c          |   10 +++++-----
 47 files changed, 133 insertions(+), 133 deletions(-)
