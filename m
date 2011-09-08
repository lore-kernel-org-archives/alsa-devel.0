From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 3.2
Date: Thu, 8 Sep 2011 11:23:35 -0700
Message-ID: <20110908182334.GG3591@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 36CF324C59
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Sep 2011 20:23:38 +0200 (CEST)
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

The following changes since commit b42af319f26bcb7d84b42b4bd0ca3b84ba94b160:

  Merge branch 'for-3.1' into for-3.2 (2011-08-24 20:22:43 +0100)

are available in the git repository at:

  git://opensource.wolfsonmicro.com/linux-2.6-asoc.git for-3.2

Axel Lin (3):
      ASoC: sn95031: Fix the logic to find free channel
      ASoC: Add missing platform_device_put in raumfeld_audio_init error path
      ASoC: alc5623: Remove unused mutex

Ben Gardiner (1):
      ASoC: davinci-mcasp: add support for unsigned PCM formats

Fabio Estevam (1):
      ASoC: imx: Fix build warning of unused 'card' variable

Lars-Peter Clausen (4):
      ASoC: snd_soc_codec_{readable,writable}_register change default to true
      ASoC: Fix register cache sync register_writable WARN_ONs
      ASoC: soc_codec_reg_show use snd_soc_codec_readable_register
      ASoC: Blackfin: bf5xx-ad193x: Fix codec device name

Mark Brown (13):
      MAINTAINERS: Add some missed Wolfson files
      Merge branch 'for-3.1' into for-3.2
      ASoC: Allow register defaults to be larger than unsigned short
      ASoC: Remove unused mutex from WM9090 driver
      ASoC: Remove redundant -codec from WM8776 driver name
      ASoC: Add device tree binding for WM8770
      ASoC: Add device tree binding for WM8776
      ASoC: Add device tree binding for WM8804
      ASoC: Allow source specification for CODEC level sysclk
      Merge branch 'for-3.1' into for-3.2
      ASoC: Fix reporting of partial jack updates
      Merge branch 'for-3.1' into for-3.2
      ASoC: Check that WM8996 FLL started even if we don't have the IRQ

Peter Ujfalusi (1):
      ASoC: soc-dapm: Fix parameter comment for snd_soc_dapm_free

Wolfram Sang (2):
      ASoC: imx-ssi: use dma_writecombine consistently
      ASoC: imx: use more robust checking of available streams

susan gao (1):
      ASoC: Add 3D stereo support for wm8996

 Documentation/devicetree/bindings/sound/wm8770.txt |   16 +++++++++
 Documentation/devicetree/bindings/sound/wm8776.txt |   18 ++++++++++
 Documentation/devicetree/bindings/sound/wm8804.txt |   18 ++++++++++
 MAINTAINERS                                        |    4 ++
 include/sound/soc.h                                |    6 ++--
 sound/soc/blackfin/bf5xx-ad193x.c                  |    4 +-
 sound/soc/codecs/adav80x.c                         |    3 +-
 sound/soc/codecs/alc5623.c                         |    2 -
 sound/soc/codecs/sn95031.c                         |    8 ++---
 sound/soc/codecs/wm8770.c                          |    8 ++++
 sound/soc/codecs/wm8776.c                          |   13 ++++++-
 sound/soc/codecs/wm8804.c                          |    9 +++++
 sound/soc/codecs/wm8996.c                          |   35 ++++++++++++++++----
 sound/soc/codecs/wm9081.c                          |    4 +-
 sound/soc/codecs/wm9090.c                          |    2 -
 sound/soc/davinci/davinci-mcasp.c                  |   20 +++++++----
 sound/soc/fsl/p1022_ds.c                           |    2 +-
 sound/soc/imx/imx-pcm-fiq.c                        |   12 +++----
 sound/soc/imx/imx-ssi.c                            |    8 ++--
 sound/soc/pxa/raumfeld.c                           |    4 ++-
 sound/soc/samsung/speyside.c                       |    2 +-
 sound/soc/soc-cache.c                              |   12 +++---
 sound/soc/soc-core.c                               |   14 ++++---
 sound/soc/soc-dapm.c                               |    2 +-
 sound/soc/soc-jack.c                               |    2 +-
 25 files changed, 167 insertions(+), 61 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/wm8770.txt
 create mode 100644 Documentation/devicetree/bindings/sound/wm8776.txt
 create mode 100644 Documentation/devicetree/bindings/sound/wm8804.txt
