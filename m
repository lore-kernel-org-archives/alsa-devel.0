From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/4] Misc cleanup for 3.20 kernel
Date: Wed, 28 Jan 2015 17:37:42 +0100
Message-ID: <1422463066-18969-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9FE4C261B28
 for <alsa-devel@alsa-project.org>; Wed, 28 Jan 2015 17:37:48 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 1F54FADE2
 for <alsa-devel@alsa-project.org>; Wed, 28 Jan 2015 16:37:48 +0000 (UTC)
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

here is a few trivial cleanup patches, targeted for 3.20.
All these shouldn't result in any functional change.


Takashi

=== 

Takashi Iwai (4):
  ALSA: Include linux/io.h instead of asm/io.h
  ALSA: Include linux/uaccess.h and linux/bitopts.h instead of asm/*
  ALSA: au88x0: Remove superfluous ifdef __KERNEL__
  ALSA: usx2y: Move UAPI definition into include/uapi/sound/usb_stream.h

 include/sound/emu10k1.h               |  2 +-
 include/sound/gus.h                   |  2 +-
 include/sound/sb.h                    |  2 +-
 include/uapi/sound/usb_stream.h       | 76 ++++++++++++++++++++++++++++++++++
 sound/aoa/soundbus/i2sbus/control.c   |  2 +-
 sound/aoa/soundbus/i2sbus/pcm.c       |  2 +-
 sound/core/memory.c                   |  4 +-
 sound/core/pcm_memory.c               |  2 +-
 sound/core/pcm_native.c               |  2 +-
 sound/drivers/mpu401/mpu401_uart.c    |  2 +-
 sound/drivers/opl3/opl3_lib.c         |  2 +-
 sound/drivers/opl4/opl4_lib.c         |  2 +-
 sound/drivers/opl4/opl4_synth.c       |  2 +-
 sound/drivers/pcsp/pcsp.c             |  2 +-
 sound/drivers/pcsp/pcsp_input.c       |  2 +-
 sound/drivers/pcsp/pcsp_lib.c         |  2 +-
 sound/drivers/serial-u16550.c         |  3 +-
 sound/drivers/vx/vx_core.c            |  2 +-
 sound/i2c/other/ak4xxx-adda.c         |  2 +-
 sound/isa/ad1816a/ad1816a_lib.c       |  2 +-
 sound/isa/azt2320.c                   |  2 +-
 sound/isa/cs423x/cs4236_lib.c         |  2 +-
 sound/isa/es1688/es1688_lib.c         |  2 +-
 sound/isa/es18xx.c                    |  2 +-
 sound/isa/opl3sa2.c                   |  3 +-
 sound/isa/opti9xx/miro.c              |  2 +-
 sound/isa/opti9xx/opti92x-ad1848.c    |  2 +-
 sound/isa/sb/emu8000.c                |  4 +-
 sound/isa/sb/emu8000_patch.c          |  2 +-
 sound/isa/sb/sb16_main.c              |  2 +-
 sound/isa/sb/sb8_main.c               |  2 +-
 sound/isa/sb/sb8_midi.c               |  2 +-
 sound/isa/sb/sb_common.c              |  2 +-
 sound/isa/sb/sb_mixer.c               |  2 +-
 sound/isa/wavefront/wavefront_fx.c    |  2 +-
 sound/isa/wavefront/wavefront_midi.c  |  2 +-
 sound/isa/wavefront/wavefront_synth.c |  2 +-
 sound/isa/wss/wss_lib.c               |  2 +-
 sound/parisc/harmony.c                |  2 +-
 sound/pci/ad1889.c                    |  3 +-
 sound/pci/ali5451/ali5451.c           |  2 +-
 sound/pci/als300.c                    |  3 +-
 sound/pci/als4000.c                   |  2 +-
 sound/pci/asihpi/hpioctl.c            |  2 +-
 sound/pci/atiixp.c                    |  2 +-
 sound/pci/atiixp_modem.c              |  2 +-
 sound/pci/au88x0/au88x0.h             |  4 +-
 sound/pci/aw2/aw2-saa7146.c           |  2 +-
 sound/pci/azt3328.c                   |  2 +-
 sound/pci/bt87x.c                     |  2 +-
 sound/pci/ca0106/ca0106_mixer.c       |  2 +-
 sound/pci/ca0106/ca0106_proc.c        |  2 +-
 sound/pci/cmipci.c                    |  2 +-
 sound/pci/cs4281.c                    |  2 +-
 sound/pci/cs46xx/cs46xx_lib.c         |  3 +-
 sound/pci/cs46xx/dsp_spos.c           |  2 +-
 sound/pci/cs46xx/dsp_spos_scb_lib.c   |  2 +-
 sound/pci/cs5535audio/cs5535audio.c   |  2 +-
 sound/pci/echoaudio/darla20.c         |  2 +-
 sound/pci/echoaudio/darla24.c         |  2 +-
 sound/pci/echoaudio/echo3g.c          |  2 +-
 sound/pci/echoaudio/gina20.c          |  2 +-
 sound/pci/echoaudio/gina24.c          |  2 +-
 sound/pci/echoaudio/indigo.c          |  2 +-
 sound/pci/echoaudio/indigodj.c        |  2 +-
 sound/pci/echoaudio/indigoio.c        |  2 +-
 sound/pci/echoaudio/layla20.c         |  2 +-
 sound/pci/echoaudio/layla24.c         |  2 +-
 sound/pci/echoaudio/mia.c             |  2 +-
 sound/pci/echoaudio/mona.c            |  2 +-
 sound/pci/ens1370.c                   |  2 +-
 sound/pci/es1938.c                    |  3 +-
 sound/pci/es1968.c                    |  2 +-
 sound/pci/ice1712/ak4xxx.c            |  2 +-
 sound/pci/intel8x0.c                  |  2 +-
 sound/pci/intel8x0m.c                 |  2 +-
 sound/pci/korg1212/korg1212.c         |  3 +-
 sound/pci/maestro3.c                  |  2 +-
 sound/pci/mixart/mixart_core.c        |  2 +-
 sound/pci/mixart/mixart_hwdep.c       |  2 +-
 sound/pci/nm256/nm256.c               |  2 +-
 sound/pci/oxygen/oxygen_io.c          |  2 +-
 sound/pci/pcxhr/pcxhr_core.c          |  2 +-
 sound/pci/pcxhr/pcxhr_hwdep.c         |  2 +-
 sound/pci/riptide/riptide.c           |  2 +-
 sound/pci/rme32.c                     |  3 +-
 sound/pci/rme96.c                     |  3 +-
 sound/pci/rme9652/hdsp.c              |  2 +-
 sound/pci/rme9652/hdspm.c             |  2 +-
 sound/pci/rme9652/rme9652.c           |  2 +-
 sound/pci/sonicvibes.c                |  3 +-
 sound/pci/trident/trident_main.c      |  3 +-
 sound/pci/trident/trident_memory.c    |  2 +-
 sound/pci/via82xx.c                   |  2 +-
 sound/pci/via82xx_modem.c             |  2 +-
 sound/pci/vx222/vx222_ops.c           |  2 +-
 sound/pci/ymfpci/ymfpci_main.c        |  2 +-
 sound/ppc/awacs.c                     |  2 +-
 sound/ppc/beep.c                      |  2 +-
 sound/ppc/burgundy.c                  |  2 +-
 sound/ppc/pmac.c                      |  2 +-
 sound/ppc/tumbler.c                   |  2 +-
 sound/sh/aica.c                       |  2 +-
 sound/sparc/amd7930.c                 |  2 +-
 sound/synth/emux/emux_hwdep.c         |  2 +-
 sound/synth/emux/emux_oss.c           |  2 +-
 sound/synth/emux/soundfont.c          |  2 +-
 sound/usb/usx2y/usb_stream.h          | 78 ++---------------------------------
 108 files changed, 188 insertions(+), 195 deletions(-)
 create mode 100644 include/uapi/sound/usb_stream.h

-- 
2.2.2
