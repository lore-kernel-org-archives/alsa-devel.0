From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 00/20] ALSA: Drop superfluous PCM preallocation
	error checks
Date: Tue,  5 Feb 2019 20:42:01 +0100
Message-ID: <20190205194221.25924-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 22E7E2666B3
 for <alsa-devel@alsa-project.org>; Tue,  5 Feb 2019 20:42:26 +0100 (CET)
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
Cc: Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi,

this is yet another patchset for trivial cleanups.
At this time, it's about the superfluous error check from
snd_pcm_lib_preallocate_pages() and co.  They always succeed and never
return a failure although many codes do the error check.  The patches
simply remove the error checks and finally change the function to be
void function.

The patches are applied on top of my previous NULL device fix patches,
so not applicable to ASoC tree, I guess.  As all these are trivial,
applying through my tree altogether would be simpler.

So, Mark, please give your ACK if the changes to ASoC drivers are OK.


thanks,

Takashi

===

Takashi Iwai (20):
  ALSA: atmel: Drop superfluous PCM preallocation error checks
  ALSA: parisc: Drop superfluous PCM preallocation error checks
  ALSA: pci: Drop superfluous PCM preallocation error checks
  ALSA: ppc: Drop superfluous PCM preallocation error checks
  ALSA: sh: Drop superfluous PCM preallocation error checks
  ALSA: sparc: Drop superfluous PCM preallocation error checks
  ALSA: spi: Drop superfluous PCM preallocation error checks
  ALSA: usb: Drop superfluous PCM preallocation error checks
  ASoC: amd: Drop superfluous PCM preallocation error checks
  ASoC: dwc: Drop superfluous PCM preallocation error checks
  ASoC: intel: Drop superfluous PCM preallocation error checks
  ASoC: mediatek: Drop superfluous PCM preallocation error checks
  ASoC: meson: Drop superfluous PCM preallocation error checks
  ASoC: sh: Drop superfluous PCM preallocation error checks
  ASoC: stm: Drop superfluous PCM preallocation error checks
  ASoC: txx9: Drop superfluous PCM preallocation error checks
  ASoC: uniphier: Drop superfluous PCM preallocation error checks
  ASoC: xtensa: Drop superfluous PCM preallocation error checks
  ASoC: dmaengine: Drop superfluous PCM preallocation error checks
  ALSA: pcm: Define snd_pcm_lib_preallocate_*() as returning void

 include/sound/pcm.h                                |  8 ++---
 sound/atmel/ac97c.c                                |  4 +--
 sound/core/pcm_memory.c                            | 29 +++++-----------
 sound/parisc/harmony.c                             | 10 ++----
 sound/pci/ad1889.c                                 |  7 +---
 sound/pci/aw2/aw2-alsa.c                           | 40 +++++++---------------
 sound/pci/bt87x.c                                  | 10 +++---
 sound/pci/ca0106/ca0106_main.c                     | 16 ++++-----
 sound/pci/echoaudio/echoaudio.c                    | 16 ++++-----
 sound/pci/emu10k1/emupcm.c                         | 22 ++++++++----
 sound/pci/emu10k1/p16v.c                           | 17 ++++-----
 sound/pci/lx6464es/lx6464es.c                      |  8 ++---
 sound/pci/rme9652/hdspm.c                          | 20 +++--------
 sound/pci/via82xx_modem.c                          |  8 ++---
 sound/ppc/snd_ps3.c                                |  6 +---
 sound/sh/aica.c                                    | 14 ++++----
 sound/soc/amd/acp-pcm-dma.c                        | 26 ++++++--------
 sound/soc/amd/raven/acp3x-pcm-dma.c                |  9 +++--
 sound/soc/dwc/dwc-pcm.c                            |  3 +-
 sound/soc/intel/atom/sst-mfld-platform-pcm.c       |  9 ++---
 sound/soc/intel/baytrail/sst-baytrail-pcm.c        | 15 +++-----
 sound/soc/intel/haswell/sst-haswell-pcm.c          | 10 ++----
 sound/soc/intel/skylake/skl-pcm.c                  |  9 ++---
 .../soc/mediatek/common/mtk-afe-platform-driver.c  |  6 ++--
 sound/soc/meson/axg-fifo.c                         |  7 ++--
 sound/soc/sh/fsi.c                                 |  3 +-
 sound/soc/sh/rcar/core.c                           |  5 +--
 sound/soc/sh/siu_pcm.c                             | 13 +------
 sound/soc/soc-generic-dmaengine-pcm.c              |  5 +--
 sound/soc/stm/stm32_adfsdm.c                       |  5 +--
 sound/soc/txx9/txx9aclc.c                          |  4 ++-
 sound/soc/uniphier/aio-dma.c                       |  3 +-
 sound/soc/xtensa/xtfpga-i2s.c                      |  6 ++--
 sound/sparc/dbri.c                                 |  9 ++---
 sound/spi/at73c213.c                               |  2 +-
 sound/usb/usx2y/usbusx2yaudio.c                    | 21 ++++++------
 sound/usb/usx2y/usx2yhwdeppcm.c                    | 19 +++++-----
 37 files changed, 157 insertions(+), 267 deletions(-)

-- 
2.16.4
