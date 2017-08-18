From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 00/13] constify alsa snd_pcm_ops structures
Date: Fri, 18 Aug 2017 13:15:08 +0530
Message-ID: <1503042321-26758-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, johannes@sipsolutions.net, linux@armlinux.org.uk, daniel@zonque.org, clemens@ladisch.de
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

snd_pcm_ops are not supposed to change at runtime. All functions
working with snd_pcm_ops provided by <sound/pcm.h> work with
const snd_pcm_ops. So mark the non-const structs as const.

Arvind Yadav (13):
  [PATCH 01/13] ALSA: aoa: constify snd_pcm_ops structures
  [PATCH 02/13] ALSA: arm: constify snd_pcm_ops structures
  [PATCH 03/13] ALSA: atmel: constify snd_pcm_ops structures
  [PATCH 04/13] ALSA: drivers: constify snd_pcm_ops structures
  [PATCH 05/13] ALSA: firewire: constify snd_pcm_ops structures
  [PATCH 06/13] ALSA: mips: constify snd_pcm_ops structures
  [PATCH 07/13] ALSA: parisc: constify snd_pcm_ops structures
  [PATCH 08/13] ALSA: pcmcia: constify snd_pcm_ops structures
  [PATCH 09/13] ALSA: ppc: constify snd_pcm_ops structures
  [PATCH 10/13] ALSA: sh: constify snd_pcm_ops structures
  [PATCH 11/13] ALSA: sparc: constify snd_pcm_ops structures
  [PATCH 12/13] ALSA: spi: constify snd_pcm_ops structures
  [PATCH 13/13] ALSA: usb: constify snd_pcm_ops structures

 sound/aoa/soundbus/i2sbus/pcm.c        |   4 +-
 sound/arm/aaci.c                       |   4 +-
 sound/arm/pxa2xx-pcm.c                 |   2 +-
 sound/atmel/ac97c.c                    |   4 +-
 sound/drivers/aloop.c                  |   4 +-
 sound/drivers/ml403-ac97cr.c           |   4 +-
 sound/firewire/isight.c                |   2 +-
 sound/firewire/motu/motu-pcm.c         |   4 +-
 sound/mips/hal2.c                      |   4 +-
 sound/mips/sgio2audio.c                |   6 +-
 sound/parisc/harmony.c                 |   4 +-
 sound/pcmcia/pdaudiocf/pdaudiocf_pcm.c |   2 +-
 sound/ppc/pmac.c                       |   4 +-
 sound/ppc/snd_ps3.c                    |   2 +-
 sound/sh/aica.c                        |   2 +-
 sound/sh/sh_dac_audio.c                |   2 +-
 sound/sparc/amd7930.c                  |   4 +-
 sound/sparc/cs4231.c                   |   4 +-
 sound/sparc/dbri.c                     |   2 +-
 sound/spi/at73c213.c                   |   2 +-
 sound/usb/6fire/pcm.c                  |   2 +-
 sound/usb/caiaq/audio.c                |   2 +-
 sound/usb/hiface/pcm.c                 |   2 +-
 sound/usb/misc/ua101.c                 |   4 +-
 sound/usb/pcm.c                        |   4 +-
 sound/usb/usx2y/usbusx2yaudio.c        |   2 +-
 sound/usb/usx2y/usx2yhwdeppcm.c        |   2 +-
 27 files changed, 42 insertions(+), 42 deletions(-)

-- 
1.9.1
