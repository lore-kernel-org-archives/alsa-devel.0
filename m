From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.40
Date: Mon, 18 Apr 2011 21:50:41 +0100
Message-ID: <20110418205040.GF13808@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 893F924438
	for <alsa-devel@alsa-project.org>;
	Mon, 18 Apr 2011 22:50:31 +0200 (CEST)
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

The following changes since commit 09f68072b32089f2e3b4749161eb3ce954faf8d4:

  Merge branch 'for-2.6.40' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6 into topic/asoc (2011-04-05 09:12:41 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.40

along with some others for Tegra which don't show up here as I faffed
around with the request to mask the merge up of 2.6.39-rc3 which
dominated it but resolves the conflict that had existed between mainline
and -next.

Dilan Lee (1):
      ASoC: WM8903: HP and Line out PGA/mixer DAPM fixes

Jassi Brar (1):
      MAINTAINERS: Update Samsung ASoC maintainer's id

Kuninori Morimoto (4):
      ASoC: fsi: take care in failing case of dai register
      ASoC: fsi: modify vague PM control on probe
      ASoC: fsi: driver safely remove for against irq
      ASoC: Add soc_remove_dai_links

Lars-Peter Clausen (7):
      ASoC: codecs: JZ4740: Fix OOPS
      ASoC: Make struct snd_soc_card's dapm_widgets and dapm_routes const
      ASoC: JZ4740: Convert qi_lb60 codec to table based DAPM setup
      ASoC: JZ4740: qi_lb60: Use gpio_request_array to request and setup gpios
      ASoC: JZ4740: qi_lb60: Use the SND_SOC_DAPM_EVENT_OFF for the speakers status
      ASoC: codecs: JZ4740: Convert to table based controls and DAPM setup
      ARM: s3c2440: gta02; Register dfbmcs320 device for BT audio interface

Lu Guanqun (9):
      ASoC: sst_platform: initialize module_name properly
      ASoC: sst_platform: free the resources on fail path
      sst: make register_sst_card more self-contained
      ASoC: sst_platform: unregister sst card when being closed
      ASoC: check channel mismatch between cpu_dai and codec_dai
      ASoC: fix config error path
      sst: fix compile error
      ASoC: sst_platform: Fix lock acquring
      ASoC: sn95031: decorate function with __devexit_p()

Mark Brown (26):
      Merge branch 'for-2.6.39' into for-2.6.40
      ASoC: Set left channel volume update bits for WM8994
      Merge branch 'for-2.6.39' into for-2.6.40
      ASoC: Add data based control initialisation for CODECs and cards
      Merge branch 'for-2.6.39' into for-2.6.40
      ASoC: Remove special casing for registerless widgets
      ASoC: Force all DAPM contexts into the same bias state
      ASoC: Allow DAPM pin operations to match any context
      Merge branch 'for-2.6.39' into for-2.6.40
      ASoC: Fix output PGA enabling in wm_hubs CODECs
      Merge branch 'for-2.6.39' into for-2.6.40
      ASoC: Add WM8915 CODEC driver
      ASoC: Add initial WM1250-EV1 Springbank audio I/O module driver
      ASoC: Fix mis cherry-pick of wm1250-ev1 driver
      ASoC: Move WM8915 FLL operations onto the CODEC
      ASoC: Create card DAPM widgets early so they can be used in callbacks
      ASoC: Initial audio support for Speyside on Cragganmore 6410
      ASoC: Add basic widgets for WM8915 Speyside
      ASoC: Optimise clock management for WM8915 Speyside
      ASoC: Support the sub speaker driver on Speyside
      ASoC: Add Speyside headset jack detection support
      ASoC: Add pin switches for fixed analogue inputs and outputs on Speyside
      ASoC: Add stub baseband link on Speyside
      ASoC: Mark Speyside widgets as ignoring suspend
      Merge branch 'for-2.6.39' into for-2.6.40
      Merge branch 'for-2.6.39' into for-2.6.40

Mike Frysinger (1):
      ASoC: SSM2602: add SPI support

Peter Hsiang (1):
      ASoC: Add max98095 CODEC driver

Sangbeom Kim (2):
      ASoC: SAMSUNG: Fix the inverted clocks handling for pcm driver
      ASoC: SAMSUNG: Add WM8580 PCM Machine driver

Stephen Warren (1):
      ASoC: Tegra: Suspend/resume support

 MAINTAINERS                                        |    2 +-
 arch/arm/mach-s3c2440/mach-gta02.c                 |    5 +
 .../staging/intel_sst/intel_sst_drv_interface.c    |    1 -
 drivers/staging/intel_sst/intelmid.c               |    4 +
 include/sound/max98095.h                           |   26 +
 include/sound/soc.h                                |   11 +-
 include/sound/wm8915.h                             |   55 +
 sound/soc/codecs/Kconfig                           |   14 +-
 sound/soc/codecs/Makefile                          |    6 +
 sound/soc/codecs/jz4740.c                          |   20 +-
 sound/soc/codecs/max98095.c                        | 2009 +++++++++++
 sound/soc/codecs/max98095.h                        |  284 ++
 sound/soc/codecs/sn95031.c                         |    2 +-
 sound/soc/codecs/ssm2602.c                         |   56 +-
 sound/soc/codecs/wm1250-ev1.c                      |  108 +
 sound/soc/codecs/wm8903.c                          |   38 +-
 sound/soc/codecs/wm8915.c                          | 2924 +++++++++++++++
 sound/soc/codecs/wm8915.h                          | 3717 ++++++++++++++++++++
 sound/soc/codecs/wm8994.c                          |   16 +
 sound/soc/codecs/wm_hubs.c                         |    8 +-
 sound/soc/jz4740/qi_lb60.c                         |   46 +-
 sound/soc/mid-x86/sst_platform.c                   |   14 +-
 sound/soc/samsung/Kconfig                          |   15 +
 sound/soc/samsung/Makefile                         |    4 +
 sound/soc/samsung/pcm.c                            |    4 +-
 sound/soc/samsung/smdk_wm8580pcm.c                 |  206 ++
 sound/soc/samsung/speyside.c                       |  333 ++
 sound/soc/sh/fsi.c                                 |   21 +-
 sound/soc/soc-core.c                               |   39 +-
 sound/soc/soc-dapm.c                               |  133 +-
 sound/soc/tegra/harmony.c                          |    1 +
 31 files changed, 9929 insertions(+), 193 deletions(-)
 create mode 100644 include/sound/max98095.h
 create mode 100644 include/sound/wm8915.h
 create mode 100644 sound/soc/codecs/max98095.c
 create mode 100644 sound/soc/codecs/max98095.h
 create mode 100644 sound/soc/codecs/wm1250-ev1.c
 create mode 100644 sound/soc/codecs/wm8915.c
 create mode 100644 sound/soc/codecs/wm8915.h
 create mode 100644 sound/soc/samsung/smdk_wm8580pcm.c
 create mode 100644 sound/soc/samsung/speyside.c
