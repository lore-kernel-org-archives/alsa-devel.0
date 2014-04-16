From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 00/20] ASoC: omap: Bind the omap-pcm
	platform driver to dai device
Date: Wed, 16 Apr 2014 15:46:10 +0300
Message-ID: <1397652390-852-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 99D6F26527F
 for <alsa-devel@alsa-project.org>; Wed, 16 Apr 2014 14:46:37 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, Jyri Sarha <jsarha@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, notasas@gmail.com
List-Id: alsa-devel@alsa-project.org

Hi,

Changes since v1:
- Add resource managed snd_soc_register_platform()
- Use snd_soc_dai_init_dma_data()
- omap-pcm is using the devm_snd_soc_register_platform()
- Patch for davinci-mcasp since Version4 is using omap-pcm

Cover letter from v1:

This should have been done a long time ago...
Add support for binding the omap-pcm platform to a dai device. IN this way we
can remove the 'omap-pcm-audio' platform device/driver need.
The change will also going to simplify cases when we boot with DT and we can use
the same node for cpu_dai and platform.

Regards,
Peter
---
Peter Ujfalusi (20):
  ASoC: Add resource managed snd_soc_register_platform()
  ASoC: omap-pcm: Support for binding the platform driver to dai devices
  ASoC: omap-mcpdm: Assign the dai DMA data at earlier time
  ASoC: omap-mcpdm: Bind the platform driver to the dai driver when
    loading
  ASoC: omap-mcbsp: Assign the dai DMA data at earlier time
  ASoC: omap-mcbsp: Bind the platform driver to the dai driver when
    loading
  ASoC: omap-dmic: Assign the dai DMA data at earlier time
  ASoC: omap-dmic: Bind the platform driver to the dai driver when
    loading
  ASoC: omap-hdmi: Bind the platform driver to the dai driver when
    loading
  ASoC: davinci-mcasp: Update MCASP_VERSION_4 platform driver
    registration
  ASoC: omap-abe-twl6040: Use the cpu_dai node to specify the platform
    driver
  ASoC: omap-twl4030: Use the same name/node for platform as the cpu_dai
  ASoC: am3517evm: Use the same name for platform as the cpu_dai
  ASoC: ams-delta: Use the same name for platform as the cpu_dai
  ASoC: n810: Use the same name for platform as the cpu_dai
  ASoC: omap3pandora: Use the same name for platform as the cpu_dai
  ASoC: osk5912: Use the same name for platform as the cpu_dai
  ASoC: rx51: Use the same name for platform as the cpu_dai
  ASoC: omap-hdmi-card: Use the same name for platform as the cpu_dai
  ASoC: omap-pcm: Drop the platform driver init code

 include/sound/soc.h               |  2 ++
 sound/soc/davinci/davinci-mcasp.c | 37 +++++++++++++++++++++++++++++++------
 sound/soc/omap/am3517evm.c        |  2 +-
 sound/soc/omap/ams-delta.c        |  2 +-
 sound/soc/omap/n810.c             |  2 +-
 sound/soc/omap/omap-abe-twl6040.c |  8 ++------
 sound/soc/omap/omap-dmic.c        |  9 ++++++++-
 sound/soc/omap/omap-hdmi-card.c   |  2 +-
 sound/soc/omap/omap-hdmi.c        |  7 ++++++-
 sound/soc/omap/omap-mcbsp.c       | 20 +++++++++++++-------
 sound/soc/omap/omap-mcpdm.c       | 16 ++++++++++++----
 sound/soc/omap/omap-pcm.c         | 25 +++----------------------
 sound/soc/omap/omap-pcm.h         | 30 ++++++++++++++++++++++++++++++
 sound/soc/omap/omap-twl4030.c     | 10 ++++++++--
 sound/soc/omap/omap3pandora.c     |  4 ++--
 sound/soc/omap/osk5912.c          |  2 +-
 sound/soc/omap/rx51.c             |  2 +-
 sound/soc/soc-devres.c            | 34 ++++++++++++++++++++++++++++++++++
 18 files changed, 157 insertions(+), 57 deletions(-)
 create mode 100644 sound/soc/omap/omap-pcm.h

-- 
1.9.2
