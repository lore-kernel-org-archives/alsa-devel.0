From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 00/16] ALSA: PCI: constify snd_pcm_hardware const
Date: Sat, 12 Aug 2017 21:01:12 +0530
Message-ID: <1502551888-30325-1-git-send-email-bhumirks@gmail.com>
Return-path: <linux-parisc-owner@vger.kernel.org>
Sender: linux-parisc-owner@vger.kernel.org
To: julia.lawall@lip6.fr, T-Bone@parisc-linux.org, perex@perex.cz, tiwai@suse.com, clemens@ladisch.de, jayakumar.alsa@gmail.com, linux-parisc@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: alsa-devel@alsa-project.org

Declare snd_pcm_hardware const. 
Done using Coccinelle.

Bhumika Goyal (16):
  ALSA: aw2: make snd_pcm_hardware const
  ALSA: ca0106: make snd_pcm_hardware const
  ALSA: cs46xx: make snd_pcm_hardware const
  ALSA: korg1212: make snd_pcm_hardware const
  ALSA: cs5535audio: make snd_pcm_hardware const
  ALSA: emu10k1: make snd_pcm_hardware const
  ALSA: lola: make snd_pcm_hardware const
  ALSA: lx6464es: make snd_pcm_hardware const
  ALSA: mixart: make snd_pcm_hardware const
  ALSA: ctxfi: make snd_pcm_hardware const
  ALSA: pcxhr: make snd_pcm_hardware const
  ALSA: riptide: make snd_pcm_hardware const
  ALSA: rme9652: make snd_pcm_hardware const
  ALSA: trident: make snd_pcm_hardware const
  ALSA: ymfpci: make snd_pcm_hardware const
  ALSA: pci: make snd_pcm_hardware const

 sound/pci/ad1889.c                      |  4 ++--
 sound/pci/als300.c                      |  4 ++--
 sound/pci/als4000.c                     |  4 ++--
 sound/pci/atiixp.c                      |  2 +-
 sound/pci/atiixp_modem.c                |  2 +-
 sound/pci/aw2/aw2-alsa.c                |  4 ++--
 sound/pci/bt87x.c                       |  4 ++--
 sound/pci/ca0106/ca0106_main.c          |  4 ++--
 sound/pci/cmipci.c                      | 12 ++++++------
 sound/pci/cs4281.c                      |  4 ++--
 sound/pci/cs46xx/cs46xx_lib.c           |  4 ++--
 sound/pci/cs5535audio/cs5535audio_pcm.c |  4 ++--
 sound/pci/ctxfi/ctpcm.c                 |  6 +++---
 sound/pci/emu10k1/emu10k1x.c            |  4 ++--
 sound/pci/emu10k1/emupcm.c              | 10 +++++-----
 sound/pci/emu10k1/p16v.c                |  4 ++--
 sound/pci/ens1370.c                     |  6 +++---
 sound/pci/es1938.c                      |  4 ++--
 sound/pci/es1968.c                      |  4 ++--
 sound/pci/fm801.c                       |  4 ++--
 sound/pci/intel8x0.c                    |  2 +-
 sound/pci/intel8x0m.c                   |  2 +-
 sound/pci/korg1212/korg1212.c           |  4 ++--
 sound/pci/lola/lola_pcm.c               |  2 +-
 sound/pci/lx6464es/lx6464es.c           |  2 +-
 sound/pci/maestro3.c                    |  4 ++--
 sound/pci/mixart/mixart.c               |  4 ++--
 sound/pci/pcxhr/pcxhr.c                 |  2 +-
 sound/pci/riptide/riptide.c             |  4 ++--
 sound/pci/rme32.c                       |  8 ++++----
 sound/pci/rme96.c                       |  8 ++++----
 sound/pci/rme9652/hdsp.c                |  4 ++--
 sound/pci/rme9652/rme9652.c             |  4 ++--
 sound/pci/sis7019.c                     |  4 ++--
 sound/pci/sonicvibes.c                  |  4 ++--
 sound/pci/trident/trident_main.c        | 10 +++++-----
 sound/pci/via82xx.c                     |  2 +-
 sound/pci/via82xx_modem.c               |  2 +-
 sound/pci/ymfpci/ymfpci_main.c          |  4 ++--
 39 files changed, 85 insertions(+), 85 deletions(-)

-- 
1.9.1

