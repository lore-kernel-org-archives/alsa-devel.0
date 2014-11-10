From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 00/11] ASoC: Untangle AC'97 support form the
	core
Date: Mon, 10 Nov 2014 22:41:42 +0100
Message-ID: <1415655713-29842-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-111.synserver.de (smtp-out-111.synserver.de
 [212.40.185.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 9A2C4261AC1
 for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2014 22:42:15 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Stephen Warren <swarren@wwwdotorg.org>, Sangbeom Kim <sbkim73@samsung.com>, patches@opensource.wolfsonmicro.com, Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Li.Xiubo@freescale.com>, Markus Pargmann <mpa@pengutronix.de>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The AC'97 support has had a special role within the ASoC framework with it
being (in contrast to other audio buses) tightly integrated into the core.
This patch series creates a clean separation between the core and the AC'97
support making AC'97 from the point of view of the core just another bus.
Some of the changes in this series are required for the upcoming conversion
of the AC'97 drivers to regmap, the other changes just fit nicely with the
idea of componentization and having a generic ASoC core.

The series starts with moving AC'97 support to its own file and doing a few
general cleanups. After that it drops support of two features which were
mainly responsible for the tight integration but are seemingly unused.
This is
a) Delaying the initialization and registration of the AC'97 device until
   after the card has been registered. There doesn't seem to be a good
   reason to delay to registration, all the information we need to register
   the device is available at the time when the device is created.
   Furthermore this will be needed for regmap.
b) Setting platform data for the AC'97 via the CPU DAI. This hasn't been
   used in the last 5 years and doesn't seem to be that useful in general.

If we should ever have a need for those features again they can still be
implemented on top of the current code while keeping the clean separation.
But for the time being it is simpler to just drop unused code rather than
restructuring it.

Finally the series pushes the pointer to the AC'97 device from the
snd_soc_codec struct out to the driver private structs.

Depends on asoc/topic/ad1980, asoc/topic/wm9705 and asoc/topic/wm971x

- Lars

Lars-Peter Clausen (11):
  ASoC: mpc5200_psc_ac97: Remove unused on-stack snd_ac97 device
  ASoC: mpc5200_dma: Don't overwrite ac97 device private_data
  ASoC: Properly handle AC'97 device lifetime management
  ASoC: Move AC'97 support to its own file
  ASoC: ac97: Use static ac97_bus
  ASoC: ac97: Merge
    soc_ac97_dev_{un,}register()/soc_{un,}register_ac97_codec()
  ASoC: ac97: Drop support for setting platform data via the CPU DAI
  ASoC: ac97: Drop delayed device registration
  ASoC: Drop ac97_control initialization from CODEC driver DAIs
  ASoC: Rename snd_soc_dai_driver struct ac97_control field to
    bus_control
  ASoC: ac97: Push snd_ac97 pointer to the driver level

 include/sound/soc-dai.h          |   4 +-
 include/sound/soc.h              |  25 ++-
 sound/soc/Makefile               |   4 +
 sound/soc/au1x/ac97c.c           |   2 +-
 sound/soc/au1x/psc-ac97.c        |   2 +-
 sound/soc/blackfin/bf5xx-ac97.c  |   2 +-
 sound/soc/cirrus/ep93xx-ac97.c   |   2 +-
 sound/soc/codecs/ac97.c          |  18 +-
 sound/soc/codecs/ad1980.c        |  28 +--
 sound/soc/codecs/stac9766.c      |  40 +++--
 sound/soc/codecs/wm9705.c        |  32 ++--
 sound/soc/codecs/wm9712.c        |  33 ++--
 sound/soc/codecs/wm9713.c        |  32 ++--
 sound/soc/fsl/fsl_ssi.c          |   2 +-
 sound/soc/fsl/imx-ssi.c          |   2 +-
 sound/soc/fsl/mpc5200_dma.c      |   3 -
 sound/soc/fsl/mpc5200_psc_ac97.c |   6 +-
 sound/soc/nuc900/nuc900-ac97.c   |   2 +-
 sound/soc/pxa/pxa2xx-ac97.c      |   6 +-
 sound/soc/samsung/ac97.c         |   4 +-
 sound/soc/sh/hac.c               |   2 +-
 sound/soc/soc-ac97.c             | 256 +++++++++++++++++++++++++++
 sound/soc/soc-core.c             | 372 ++-------------------------------------
 sound/soc/tegra/tegra20_ac97.c   |   2 +-
 sound/soc/txx9/txx9aclc-ac97.c   |   2 +-
 25 files changed, 428 insertions(+), 455 deletions(-)
 create mode 100644 sound/soc/soc-ac97.c

-- 
1.8.0
