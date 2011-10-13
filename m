From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 3.2
Date: Thu, 13 Oct 2011 11:49:58 +0100
Message-ID: <20111013104958.GA5193@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8EF69103850
	for <alsa-devel@alsa-project.org>;
	Thu, 13 Oct 2011 12:50:00 +0200 (CEST)
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

The following changes since commit 03b5362d2fef02cabbbb440d861d27e40ed3a929:

  ASoC: Convert Jive to table based init (2011-10-10 11:10:44 +0100)

are available in the git repository at:
  git://opensource.wolfsonmicro.com/linux-2.6-asoc.git for-3.2

Ashish Chavan (1):
      ASoC: da7210: Add support for other DAI word lengths, format and mode

Axel Lin (6):
      ASoC: Writing register default value for the reset register
      ASoC: ak4642: convert to soc-cache
      ASoC: Delete ads117x.h
      ASoC: Remove impossible case from wm8994_hw_params
      ASoC: da7210: convert to soc-cache
      ASoC: Make SND_SOC_SAARB and SND_SOC_TAVOREVB3 select MFD_88PM860X

Mark Brown (4):
      ASoC: Convert Goni to data based DAPM init
      ASoC: Add missing default for WM5100 Clocking 1
      ASoC: Implement WM5100 accessory detection support
      ASoC: Instantiate card widgets immediately

Peter Ujfalusi (18):
      ASoC: OMAP machines: Remove soc_dapm_sync() call from init
      ASoC: zoom2: Let core to deal with the DAPM widgets
      ASoC: zoom2: No need to call dapm_pin_enable at init time
      ASoC: sdp4430: Let core to deal with the DAPM widgets
      ASoC: sdp4430: No need to call dapm_pin_enable at init time
      ASoC: am3517evm: Let core to deal with the DAPM widgets
      ASoC: n810: Let the core to register DAPM widgets/routes and controls
      ASoC: osk5912: Let core to deal with the DAPM widgets
      ASoC: sdp3430: Let core to deal with the DAPM widgets
      ASoC: twl6040: Convert to table based init
      ASoC: twl4030: Convert to table based init
      ASoC: tlv320dac33: Convert to table based init
      Input: twl6040: Simplify vibra regsiter definitions
      MFD: twl6040: Cache the vibra control registers
      MFD: twl6040: function to query the vibra status for clients
      Input: twl6040-vibra: Check the selected path for vibra
      ASoC: twl6040: Support for vibra output paths
      ASoC: twl6040: Workaround for headset DC offset caused pop noise

Wolfram Sang (1):
      ASoC: Fix typo in Kconfig symbol for tlv320aic32x4

 drivers/input/misc/twl6040-vibra.c |   19 +++--
 drivers/mfd/twl6040-core.c         |   31 ++++++-
 include/linux/mfd/twl6040.h        |   25 +++---
 sound/soc/codecs/Kconfig           |    4 +-
 sound/soc/codecs/Makefile          |    2 +-
 sound/soc/codecs/ads117x.h         |   13 ---
 sound/soc/codecs/ak4642.c          |   82 +++----------------
 sound/soc/codecs/da7210.c          |  146 +++++++++++++++-----------------
 sound/soc/codecs/tlv320dac33.c     |   23 ++----
 sound/soc/codecs/twl4030.c         |   21 ++---
 sound/soc/codecs/twl6040.c         |  135 ++++++++++++++++++++++++------
 sound/soc/codecs/wm5100-tables.c   |    1 +
 sound/soc/codecs/wm5100.c          |  162 ++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/wm5100.h          |    2 +
 sound/soc/codecs/wm8983.c          |    2 +-
 sound/soc/codecs/wm8994.c          |   10 --
 sound/soc/imx/Kconfig              |    2 +-
 sound/soc/omap/am3517evm.c         |   28 +-----
 sound/soc/omap/ams-delta.c         |    1 -
 sound/soc/omap/n810.c              |   23 ++----
 sound/soc/omap/omap3pandora.c      |    8 +--
 sound/soc/omap/osk5912.c           |   27 +-----
 sound/soc/omap/rx51.c              |    2 -
 sound/soc/omap/sdp3430.c           |   18 +---
 sound/soc/omap/sdp4430.c           |   27 +-----
 sound/soc/omap/zoom2.c             |   26 ++-----
 sound/soc/pxa/Kconfig              |    2 +
 sound/soc/samsung/goni_wm8994.c    |   13 +--
 sound/soc/soc-core.c               |    2 +
 29 files changed, 467 insertions(+), 390 deletions(-)
 delete mode 100644 sound/soc/codecs/ads117x.h
