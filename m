From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 3.2
Date: Sun, 21 Aug 2011 13:10:10 +0100
Message-ID: <20110821121010.GB12673@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0518924361
	for <alsa-devel@alsa-project.org>;
	Sun, 21 Aug 2011 14:10:12 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

The following changes since commit c18eee31812d42ecd0aa5c39d21d41c15b30eaab:

  ASoC: Add bitfield definitions for WM8958 MICBIAS registers (2011-08-12 14:23:04 +0900)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-3.2

Axel Lin (10):
      ASoC: soc-jack: Fix checking return value of request_any_context_irq
      ASoC: sta32x: Fix a memory leak if snd_soc_register_codec fails
      ASoC: s6000-pcm: remove unused variable 'dai'
      ASoC: soc-cache: Remove unneeded codec_drv pointer variable in snd_soc_flat_cache_init
      ASoC: soc-cache: Remove unneeded codec_drv pointer variable in snd_soc_lzo_get_blksize
      ASoC: soc-pcm: Remove unused global mutex
      ASoC: nuc900-pcm: remove unused variable 'dai'
      ASoC: sta32x: shortcut the for loop to get ir and mcs
      ASoC: Remove unreachable code in au1xac97c_drvprobe and au1xi2s_drvprobe
      ASoC: sta32x: Move resource allocation and release to the corresponding callback functions

Jarkko Nikula (1):
      ASoC: omap: Fix build errors in ams-delta

Lars-Peter Clausen (3):
      ASoC: DAPM: Allow multiple mixer sources to be routed via the same switch
      ASoC: Add ADAU1373 codec support
      ASoC: Blackfin: ADAU1373 eval board support

Mark Brown (25):
      ASoC: Add device tree binding for WM8510
      ASoC: Add device tree binding for WM8523
      ASoC: Add device tree support for WM8580
      ASoC: Add device tree binding for WM8711
      ASoC: Add device tree binding for WM8728
      ASoC: Add device tree binding for WM8737
      ASoC: Add device tree binding for WM8750
      ASoC: Add device tree binding for WM8753
      ASoC: Add VMID widget for wm_hubs devices
      ASoC: Disable WM8994 VMID for digital only paths
      ASoC: Move WM8962 CLKREG_OVD earlier
      ASoC: Remove redundant -codec from WM8750
      Merge branch 'for-3.1' into for-3.2
      ASoC: Support !CONFIG_REGMAP builds
      Merge branch 'for-3.1' into for-3.2
      Merge branch 'for-3.1' into for-3.2
      ASoC: Add device tree binding for WM8741
      ASoC: Correct revision display for WM1250-EV1 module
      ASoC: Disable pulls on WM8994 AIF2 when starting it
      ASoC: Run Speyside WM8962 at 512fs
      ASoC: Add WM8958 noise gate support
      ASoC: Implement WM8994 thermal warning and shutdown interrupt support
      ASoC: Fix backport of WM8994 thermal warning
      Merge branch 'for-3.1' into for-3.2
      Merge branch 'for-3.1' into for-3.2

Sascha Hauer (1):
      ASoC: Fix check for symmetric rate enforcement

Scott Jiang (5):
      ASoC: ad193x: fix registers definition
      ASoC: ad193x: fix dac word len setting
      ASoC: ad193x: fix system clock
      ASoC: Add spi hw read function for 16 addr 8 data mode for ad193x fix
      ASoC: ad193x: remove cache support

Takashi Iwai (1):
      ASoC: Fix compile warning in wm8750.c

Timur Tabi (2):
      ASoC: claim the IRQ when the fsl_ssi device is probed, not opened
      ASoC: fsl: fix build warning in fsl_dma

Vasily Khoruzhick (2):
      ASoC: h1940: Fix compilation error due to missing header
      ASoC: rx1950: Fix compilation error due to missing header

 Documentation/devicetree/bindings/sound/wm8510.txt |   18 +
 Documentation/devicetree/bindings/sound/wm8523.txt |   16 +
 Documentation/devicetree/bindings/sound/wm8580.txt |   16 +
 Documentation/devicetree/bindings/sound/wm8711.txt |   18 +
 Documentation/devicetree/bindings/sound/wm8728.txt |   18 +
 Documentation/devicetree/bindings/sound/wm8737.txt |   18 +
 Documentation/devicetree/bindings/sound/wm8741.txt |   18 +
 Documentation/devicetree/bindings/sound/wm8750.txt |   18 +
 Documentation/devicetree/bindings/sound/wm8753.txt |   18 +
 include/linux/mfd/wm8994/registers.h               |   45 +
 include/sound/adau1373.h                           |   34 +
 sound/soc/au1x/ac97c.c                             |    2 -
 sound/soc/au1x/i2sc.c                              |    1 -
 sound/soc/blackfin/Kconfig                         |   13 +
 sound/soc/blackfin/Makefile                        |    2 +
 sound/soc/blackfin/bf5xx-ad193x.c                  |    2 +-
 sound/soc/blackfin/bfin-eval-adau1373.c            |  202 +++
 sound/soc/codecs/Kconfig                           |    4 +
 sound/soc/codecs/Makefile                          |    2 +
 sound/soc/codecs/ad193x.c                          |   11 +-
 sound/soc/codecs/ad193x.h                          |    5 +-
 sound/soc/codecs/adau1373.c                        | 1414 ++++++++++++++++++++
 sound/soc/codecs/adau1373.h                        |   29 +
 sound/soc/codecs/sta32x.c                          |   22 +-
 sound/soc/codecs/wm1250-ev1.c                      |    2 +-
 sound/soc/codecs/wm8510.c                          |    8 +
 sound/soc/codecs/wm8523.c                          |    7 +
 sound/soc/codecs/wm8580.c                          |    7 +
 sound/soc/codecs/wm8711.c                          |    9 +
 sound/soc/codecs/wm8728.c                          |    9 +
 sound/soc/codecs/wm8737.c                          |   10 +
 sound/soc/codecs/wm8741.c                          |    9 +
 sound/soc/codecs/wm8750.c                          |   16 +-
 sound/soc/codecs/wm8753.c                          |    9 +
 sound/soc/codecs/wm8962.c                          |    8 +-
 sound/soc/codecs/wm8993.c                          |    4 +
 sound/soc/codecs/wm8994-tables.c                   |   12 +-
 sound/soc/codecs/wm8994.c                          |  264 +++-
 sound/soc/codecs/wm8994.h                          |    2 +
 sound/soc/codecs/wm_hubs.c                         |   16 +
 sound/soc/fsl/fsl_dma.c                            |    1 -
 sound/soc/fsl/fsl_ssi.c                            |   61 +-
 sound/soc/nuc900/nuc900-pcm.c                      |    1 -
 sound/soc/omap/ams-delta.c                         |    6 +-
 sound/soc/pxa/spitz.c                              |    2 +-
 sound/soc/pxa/z2.c                                 |    2 +-
 sound/soc/s6000/s6000-pcm.c                        |    1 -
 sound/soc/samsung/h1940_uda1380.c                  |    1 +
 sound/soc/samsung/jive_wm8750.c                    |    2 +-
 sound/soc/samsung/rx1950_uda1380.c                 |    1 +
 sound/soc/samsung/smartq_wm8987.c                  |    2 +-
 sound/soc/samsung/speyside_wm8962.c                |    4 +-
 sound/soc/soc-cache.c                              |    7 -
 sound/soc/soc-dapm.c                               |    6 +-
 sound/soc/soc-io.c                                 |   11 +-
 sound/soc/soc-jack.c                               |    2 +-
 sound/soc/soc-pcm.c                                |    5 +-
 57 files changed, 2309 insertions(+), 144 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/wm8510.txt
 create mode 100644 Documentation/devicetree/bindings/sound/wm8523.txt
 create mode 100644 Documentation/devicetree/bindings/sound/wm8580.txt
 create mode 100644 Documentation/devicetree/bindings/sound/wm8711.txt
 create mode 100644 Documentation/devicetree/bindings/sound/wm8728.txt
 create mode 100644 Documentation/devicetree/bindings/sound/wm8737.txt
 create mode 100644 Documentation/devicetree/bindings/sound/wm8741.txt
 create mode 100644 Documentation/devicetree/bindings/sound/wm8750.txt
 create mode 100644 Documentation/devicetree/bindings/sound/wm8753.txt
 create mode 100644 include/sound/adau1373.h
 create mode 100644 sound/soc/blackfin/bfin-eval-adau1373.c
 create mode 100644 sound/soc/codecs/adau1373.c
 create mode 100644 sound/soc/codecs/adau1373.h
