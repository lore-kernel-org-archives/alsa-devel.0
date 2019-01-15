From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 00/14] ALSA: PCM suspend cleanup
Date: Tue, 15 Jan 2019 17:21:41 +0100
Message-ID: <20190115162155.6308-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 24F992667E7
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2019 17:21:56 +0100 (CET)
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
Cc: Libin Yang <libin.yang@intel.com>, Mengdong Lin <mengdong.lin@intel.com>, Keyon Jie <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

Hi,

this is a patch set to clean up the PCM suspend calls by introducing
the PCM device PM ops.  This won't change much for ASoC but reduce
lots of snd_pcm_suspend*() calls in other sound drivers.

Note that this patch series itself won't fix anything about the recent
PM issue reported for Intel ASoC, but it was inspired through the
discussion there.


thanks,

Takashi

===

Takashi Iwai (14):
  ALSA: pcm: Suspend streams globally via device type PM ops
  ALSA: atiixp: Move PCM suspend/resume code into trigger callback
  ALSA: isa: Remove superfluous snd_pcm_suspend*() calls
  ALSA: drivers: Remove superfluous snd_pcm_suspend*() calls
  ALSA: pci: Remove superfluous snd_pcm_suspend*() calls
  ALSA: usb: Remove superfluous snd_pcm_suspend*() calls
  ALSA: x86: Remove superfluous snd_pcm_suspend*() calls
  ALSA: ppc: Remove superfluous snd_pcm_suspend*() calls
  ALSA: aoa: Remove superfluous snd_pcm_suspend*() calls
  ALSA: arm: Remove superfluous snd_pcm_suspend*() calls
  ALSA: pcmcia: Remove superfluous snd_pcm_suspend*() calls
  drm: bridge: dw-hdmi: Remove superfluous snd_pcm_suspend*() calls
  ALSA: doc: Update the description about PCM suspend procedure
  ALSA: pcm: Make snd_pcm_suspend() local static

 .../kernel-api/writing-an-alsa-driver.rst     | 25 ++++++------------
 .../drm/bridge/synopsys/dw-hdmi-ahb-audio.c   |  1 -
 include/sound/pcm.h                           |  6 +----
 sound/aoa/soundbus/i2sbus/core.c              |  4 ---
 sound/arm/aaci.c                              |  1 -
 sound/arm/pxa2xx-ac97.c                       |  1 -
 sound/core/pcm.c                              | 26 +++++++++++++++++++
 sound/core/pcm_native.c                       | 11 +++-----
 sound/drivers/aloop.c                         |  4 ---
 sound/drivers/dummy.c                         |  2 --
 sound/drivers/pcsp/pcsp.c                     |  1 -
 sound/drivers/vx/vx_core.c                    |  4 ---
 sound/isa/ad1816a/ad1816a_lib.c               |  1 -
 sound/isa/als100.c                            |  1 -
 sound/isa/cmi8328.c                           |  1 -
 sound/isa/cmi8330.c                           |  1 -
 sound/isa/es1688/es1688.c                     |  2 --
 sound/isa/es18xx.c                            |  2 --
 sound/isa/sb/jazz16.c                         |  1 -
 sound/isa/sb/sb16.c                           |  1 -
 sound/isa/sb/sb8.c                            |  1 -
 sound/isa/wss/wss_lib.c                       |  1 -
 sound/pci/ali5451/ali5451.c                   |  4 +--
 sound/pci/als300.c                            |  1 -
 sound/pci/als4000.c                           |  1 -
 sound/pci/atiixp.c                            | 19 ++++++--------
 sound/pci/atiixp_modem.c                      |  2 --
 sound/pci/azt3328.c                           |  4 ---
 sound/pci/ca0106/ca0106_main.c                |  3 ---
 sound/pci/cmipci.c                            |  4 ---
 sound/pci/cs4281.c                            |  2 --
 sound/pci/cs46xx/cs46xx_lib.c                 |  6 -----
 sound/pci/cs5535audio/cs5535audio_pm.c        |  1 -
 sound/pci/ctxfi/ctatc.c                       |  8 ------
 sound/pci/echoaudio/echoaudio.c               |  3 ---
 sound/pci/emu10k1/emu10k1.c                   |  6 -----
 sound/pci/ens1370.c                           |  3 ---
 sound/pci/es1938.c                            |  1 -
 sound/pci/es1968.c                            |  1 -
 sound/pci/fm801.c                             |  1 -
 sound/pci/hda/hda_codec.c                     |  2 --
 sound/pci/ice1712/ice1712.c                   |  3 ---
 sound/pci/ice1712/ice1724.c                   |  3 ---
 sound/pci/intel8x0.c                          |  2 --
 sound/pci/intel8x0m.c                         |  3 ---
 sound/pci/maestro3.c                          |  1 -
 sound/pci/nm256/nm256.c                       |  1 -
 sound/pci/oxygen/oxygen_lib.c                 |  5 +---
 sound/pci/riptide/riptide.c                   |  1 -
 sound/pci/rme96.c                             |  2 --
 sound/pci/sis7019.c                           |  1 -
 sound/pci/trident/trident_main.c              |  4 ---
 sound/pci/via82xx.c                           |  2 --
 sound/pci/via82xx_modem.c                     |  2 --
 sound/pci/ymfpci/ymfpci_main.c                |  4 ---
 sound/pcmcia/pdaudiocf/pdaudiocf_core.c       |  1 -
 sound/ppc/pmac.c                              |  1 -
 sound/soc/soc-pcm.c                           |  1 +
 sound/usb/card.c                              |  1 -
 sound/usb/line6/driver.c                      |  4 +--
 sound/x86/intel_hdmi_audio.c                  | 12 ---------
 61 files changed, 50 insertions(+), 174 deletions(-)

-- 
2.20.1
