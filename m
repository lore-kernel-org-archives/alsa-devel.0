From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: ASoC updates for 2.6.30
Date: Fri, 6 Mar 2009 13:41:22 +0000
Message-ID: <20090306134121.GB4327@sirena.org.uk>
References: <20090306124504.GH6493@sirena.org.uk>
	<s5hiqmm236z.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 6EDC724487
	for <alsa-devel@alsa-project.org>; Fri,  6 Mar 2009 14:41:33 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hiqmm236z.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 06, 2009 at 02:25:40PM +0100, Takashi Iwai wrote:

> I'm asking this because these are put in a line of the whole patches,
> so you can't pull them individually to another (e.g. ARM) tree.

Gah, git rebase ate my merge (unsurprising, I just forgot I had a merge
commit in there).  I've redone the branch with the merge commit
reinstated and repushed - the resulting code is identical, it's just the
git history that changed.  Thanks for noticing.

The following changes since commit 5f2a9384a9291d898b4bf85c4fbf497eef582977:
  Philipp Zabel (1):
        ASoC: UDA1380: DATAI is slave only

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.30

Ben Dooks (6):
      S3C24XX: Move and update IIS headers
      S3C: Move <mach/audio.h> to <plat/audio.h>
      ASoC: Add JIVE audio support
      ASoC: Split s3c2412-i2s.c into core and SoC specific parts
      ASoC: Add s3c64xx-i2s support
      ASoC: Select DMA if I2S is configured

Daniel Mack (2):
      ASoC: Fix name of register bit in pxa-ssp
      ASoC: add two more bitfields for PXA SSP

Jonas Andersson (1):
      ASoC: wm8510 pll settings

Lopez Cruz, Misael (3):
      ASoC: Add GPIO support for jack reporting interface
      ASoC: Add DAPM machine widgets to SDP3430 driver
      ASoC: Add headset jack detection for SDP3430 machine driver

Mark Brown (6):
      Merge commit 's3c-iis-header' into HEAD
      ASoC: Refresh JIVE driver
      ASoC: Factor out DAPM widget power check into separate function
      ASoC: Fix memory allocation for snd_soc_dapm_switch names
      ASoC: Update Kconfig for Samsung CPUs to reflect S3C64xx support
      ASoC: Staticise workqueue function for GPIO jack detection

Mike Frysinger (2):
      ASoC: Blackfin: move gpio_err behind the define that is only user of it
      ASoC: Blackfin: fix typo in MUTE definition

Peter Ujfalusi (1):
      ASoC: TWL4030: Make the HS ramp delay configurable

Timur Tabi (1):
      ASoC: add support for SSI asynchronous mode to the Freescale SSI drivers

 arch/arm/mach-pxa/include/mach/regs-ssp.h          |    7 +-
 arch/arm/mach-s3c2410/dma.c                        |    2 +-
 arch/arm/mach-s3c2410/include/mach/hardware.h      |    3 -
 arch/arm/mach-s3c2410/include/mach/io.h            |    2 +-
 arch/arm/mach-s3c2412/dma.c                        |    4 +-
 arch/arm/mach-s3c2440/dma.c                        |    2 +-
 arch/arm/mach-s3c2443/dma.c                        |    2 +-
 arch/arm/mach-shark/include/mach/io.h              |    2 +-
 .../include/mach => plat-s3c/include/plat}/audio.h |    0 
 .../arm/plat-s3c/include/plat}/regs-s3c2412-iis.h  |    3 +
 arch/arm/plat-s3c24xx/clock-dclk.c                 |    1 +
 .../arm/plat-s3c24xx/include/plat}/regs-iis.h      |    0 
 include/sound/soc.h                                |   32 +
 sound/soc/atmel/playpaq_wm8510.c                   |   24 +-
 sound/soc/blackfin/bf5xx-ac97.c                    |    2 +-
 sound/soc/codecs/ad73311.h                         |    2 +-
 sound/soc/codecs/twl4030.c                         |   18 +-
 sound/soc/codecs/wm8510.c                          |    4 +-
 sound/soc/fsl/fsl_ssi.c                            |   42 +-
 sound/soc/fsl/fsl_ssi.h                            |    2 +
 sound/soc/fsl/mpc8610_hpcd.c                       |    5 +
 sound/soc/omap/sdp3430.c                           |  105 ++++-
 sound/soc/pxa/pxa-ssp.c                            |    6 +-
 sound/soc/s3c24xx/Kconfig                          |   29 +-
 sound/soc/s3c24xx/Makefile                         |    6 +
 sound/soc/s3c24xx/jive_wm8750.c                    |  201 ++++++
 sound/soc/s3c24xx/neo1973_wm8753.c                 |    4 +-
 sound/soc/s3c24xx/s3c-i2s-v2.c                     |  645 ++++++++++++++++++++
 sound/soc/s3c24xx/s3c-i2s-v2.h                     |   90 +++
 sound/soc/s3c24xx/s3c2412-i2s.c                    |  604 +------------------
 sound/soc/s3c24xx/s3c2412-i2s.h                    |   17 +-
 sound/soc/s3c24xx/s3c2443-ac97.c                   |    2 +-
 sound/soc/s3c24xx/s3c24xx-i2s.c                    |    4 +-
 sound/soc/s3c24xx/s3c24xx-pcm.c                    |    2 +-
 sound/soc/s3c24xx/s3c24xx_uda134x.c                |    2 +-
 sound/soc/s3c24xx/s3c64xx-i2s.c                    |  220 +++++++
 sound/soc/s3c24xx/s3c64xx-i2s.h                    |   31 +
 sound/soc/soc-dapm.c                               |  265 +++++----
 sound/soc/soc-jack.c                               |  129 ++++
 39 files changed, 1745 insertions(+), 776 deletions(-)
 rename arch/arm/{mach-s3c2410/include/mach => plat-s3c/include/plat}/audio.h (100%)
 rename {include/asm-arm/plat-s3c24xx => arch/arm/plat-s3c/include/plat}/regs-s3c2412-iis.h (96%)
 rename {include/asm-arm/plat-s3c24xx => arch/arm/plat-s3c24xx/include/plat}/regs-iis.h (100%)
 create mode 100644 sound/soc/s3c24xx/jive_wm8750.c
 create mode 100644 sound/soc/s3c24xx/s3c-i2s-v2.c
 create mode 100644 sound/soc/s3c24xx/s3c-i2s-v2.h
 create mode 100644 sound/soc/s3c24xx/s3c64xx-i2s.c
 create mode 100644 sound/soc/s3c24xx/s3c64xx-i2s.h
