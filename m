From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 00/18] ASoC: omap: Bind the omap-pcm platform
	driver to dai device
Date: Wed, 16 Apr 2014 12:23:13 +0300
Message-ID: <1397640211-15447-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 88E34261A2F
 for <alsa-devel@alsa-project.org>; Wed, 16 Apr 2014 11:23:38 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Jyri Sarha <jsarha@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, notasas@gmail.com
List-Id: alsa-devel@alsa-project.org

Hi,

This should have been done a long time ago...
Add support for binding the omap-pcm platform to a dai device. IN this way we
can remove the 'omap-pcm-audio' platform device/driver need.
The change will also going to simplify cases when we boot with DT and we can use
the same node for cpu_dai and platform.

Regards,
Peter
---
Peter Ujfalusi (18):
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

 sound/soc/omap/am3517evm.c        |  2 +-
 sound/soc/omap/ams-delta.c        |  2 +-
 sound/soc/omap/n810.c             |  2 +-
 sound/soc/omap/omap-abe-twl6040.c |  8 ++------
 sound/soc/omap/omap-dmic.c        | 10 +++++++++-
 sound/soc/omap/omap-hdmi-card.c   |  2 +-
 sound/soc/omap/omap-hdmi.c        |  7 ++++++-
 sound/soc/omap/omap-mcbsp.c       | 19 ++++++++++++-------
 sound/soc/omap/omap-mcpdm.c       | 15 +++++++++++----
 sound/soc/omap/omap-pcm.c         | 25 ++++++-------------------
 sound/soc/omap/omap-pcm.h         | 35 +++++++++++++++++++++++++++++++++++
 sound/soc/omap/omap-twl4030.c     | 10 ++++++++--
 sound/soc/omap/omap3pandora.c     |  4 ++--
 sound/soc/omap/osk5912.c          |  2 +-
 sound/soc/omap/rx51.c             |  2 +-
 15 files changed, 97 insertions(+), 48 deletions(-)
 create mode 100644 sound/soc/omap/omap-pcm.h

-- 
1.9.2
