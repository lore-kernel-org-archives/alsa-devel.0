From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 00/12] ALSA: make snd_pcm_hardware const
Date: Thu, 17 Aug 2017 14:45:48 +0530
Message-ID: <1502961360-22063-1-git-send-email-bhumirks@gmail.com>
Return-path: <linux-parisc-owner@vger.kernel.org>
Sender: linux-parisc-owner@vger.kernel.org
To: julia.lawall@lip6.fr, linux@armlinux.org.uk, perex@perex.cz, tiwai@suse.com, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: alsa-devel@alsa-project.org

Make these const.

Bhumika Goyal (12):
  ALSA: arm: make snd_pcm_hardware const
  ALSA: atmel: make snd_pcm_hardware const
  ALSA: drivers: make snd_pcm_hardware const
  ALSA: isa: make snd_pcm_hardware const
  ALSA: mips: make snd_pcm_hardware const
  ALSA: pci: make snd_pcm_hardware const
  ALSA: pcmcia: make snd_pcm_hardware const
  ALSA: ppc: make snd_pcm_hardware const
  ALSA: sh: make snd_pcm_hardware const
  ALSA: sparc: make snd_pcm_hardware const
  ALSA: usb: make snd_pcm_hardware const
  ALSA: parisc: make snd_pcm_hardware const

 sound/arm/aaci.c                       | 2 +-
 sound/atmel/ac97c.c                    | 2 +-
 sound/drivers/aloop.c                  | 2 +-
 sound/drivers/dummy.c                  | 2 +-
 sound/drivers/ml403-ac97cr.c           | 4 ++--
 sound/drivers/pcsp/pcsp_lib.c          | 2 +-
 sound/drivers/vx/vx_pcm.c              | 4 ++--
 sound/isa/ad1816a/ad1816a_lib.c        | 4 ++--
 sound/isa/es1688/es1688_lib.c          | 4 ++--
 sound/isa/es18xx.c                     | 4 ++--
 sound/isa/gus/gus_pcm.c                | 4 ++--
 sound/isa/msnd/msnd.c                  | 4 ++--
 sound/isa/sb/emu8000_pcm.c             | 2 +-
 sound/isa/sb/sb16_main.c               | 4 ++--
 sound/isa/sb/sb8_main.c                | 4 ++--
 sound/isa/wss/wss_lib.c                | 4 ++--
 sound/mips/hal2.c                      | 2 +-
 sound/mips/sgio2audio.c                | 2 +-
 sound/parisc/harmony.c                 | 4 ++--
 sound/pci/au88x0/au88x0_pcm.c          | 8 ++++----
 sound/pcmcia/pdaudiocf/pdaudiocf_pcm.c | 2 +-
 sound/ppc/pmac.c                       | 4 ++--
 sound/sh/aica.c                        | 2 +-
 sound/sh/sh_dac_audio.c                | 2 +-
 sound/sparc/amd7930.c                  | 2 +-
 sound/sparc/cs4231.c                   | 4 ++--
 sound/sparc/dbri.c                     | 2 +-
 sound/usb/pcm.c                        | 2 +-
 28 files changed, 44 insertions(+), 44 deletions(-)

-- 
1.9.1

