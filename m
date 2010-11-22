From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.37
Date: Mon, 22 Nov 2010 11:06:13 +0000
Message-ID: <20101122110612.GA16504@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 32E63103892
	for <alsa-devel@alsa-project.org>; Mon, 22 Nov 2010 12:06:16 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

The following changes since commit 75e3f3137cb570661c2ad3035a139dda671fbb63:

  ASoC: tpa6130a2: Get rid of compile warning from tpa6130a2_power (2010-11-03 15:50:46 +0100)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.37

Mostly small fixes - a lot of them due to your holiday (hope you had a
good time!).  The big changes are the i.MX DMA update which was
postponed until after the i.MX tree had been merged into mainline.

The new support for the Maxim chip is just a new device ID, no
functional code changes.

Axel Lin (3):
      ASoC: Fix snd_soc_register_dais error handling
      ASoC: Return proper error if snd_soc_register_dais fails in psc_i2s_of_probe
      ASoC: uda134x - set reg_cache_default to uda134x_reg

Chris Paulson-Ellis (1):
      ASoC: davinci: fixes for multi-component

Dimitris Papastamos (1):
      ASoC: WM8776: Removed unneeded struct member

Jesse Marroquin (1):
      ASoC: Add support for MAX98089 CODEC

Marek Belisko (1):
      ASoC: s3c24xx: Fix compilation problem for mini2440

Mark Brown (7):
      Merge remote branch 'takashi/fix/asoc' into for-2.6.37
      ASoC: Check return value of strict_strtoul() in WM8962
      ASoC: Lock the CODEC in PXA external jack controls
      ASoC: Remove broken WM8350 direction constants
      ASoC: Ensure sane WM835x AIF configuration by default
      ASoC: Fix dapm_seq_compare() for multi-component
      ASoC: Fix register cache setup WM8994 for multi-component

Ryan Mallon (1):
      Fix Atmel soc audio boards Kconfig dependency

Sascha Hauer (5):
      ASoC i.MX eukrea tlv320: Fix for multicomponent
      ASoC i.MX phycore ac97: remove unnecessary includes
      ASoC i.MX: register dma audio device
      ASoC i.MX: switch to new DMA api
      phycore-ac97: add ac97 to cardname

Vasily Khoruzhick (1):
      ASoC: RX1950: Fix hw_params function

 arch/arm/mach-davinci/dm355.c      |    6 +-
 arch/arm/mach-davinci/dm365.c      |    6 +-
 arch/arm/mach-davinci/dm644x.c     |    4 +-
 include/linux/mfd/wm8350/audio.h   |    3 -
 sound/soc/atmel/Kconfig            |    5 +-
 sound/soc/codecs/max98088.c        |   11 ++-
 sound/soc/codecs/uda134x.c         |    1 +
 sound/soc/codecs/wm8350.c          |    9 ++-
 sound/soc/codecs/wm8776.c          |    1 -
 sound/soc/codecs/wm8962.c          |    5 +-
 sound/soc/codecs/wm8994.c          |    2 +
 sound/soc/davinci/davinci-evm.c    |   40 +++++--
 sound/soc/davinci/davinci-i2s.c    |   15 ++-
 sound/soc/davinci/davinci-mcasp.c  |   13 ++-
 sound/soc/davinci/davinci-sffsdr.c |    2 +-
 sound/soc/davinci/davinci-vcif.c   |   13 ++-
 sound/soc/fsl/mpc5200_psc_i2s.c    |    2 +-
 sound/soc/imx/eukrea-tlv320.c      |    8 +-
 sound/soc/imx/imx-pcm-dma-mx2.c    |  221 ++++++++++++++++--------------------
 sound/soc/imx/imx-ssi.c            |   44 +++++---
 sound/soc/imx/imx-ssi.h            |    4 +
 sound/soc/imx/phycore-ac97.c       |    5 +-
 sound/soc/pxa/corgi.c              |    5 +
 sound/soc/pxa/magician.c           |    4 +
 sound/soc/pxa/poodle.c             |    5 +
 sound/soc/pxa/spitz.c              |    5 +
 sound/soc/pxa/tosa.c               |    5 +
 sound/soc/s3c24xx/Kconfig          |    1 +
 sound/soc/s3c24xx/rx1950_uda1380.c |   20 +---
 sound/soc/soc-core.c               |    9 +-
 sound/soc/soc-dapm.c               |    4 +-
 31 files changed, 268 insertions(+), 210 deletions(-)
