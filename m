From: Luis de Bethencourt <luis@debethencourt.com>
Subject: [PATCH 00/12] ASoC: Fix module autoload for OF platform drivers
Date: Thu, 3 Sep 2015 12:54:27 +0200
Message-ID: <20150903105427.GA16658@goodgumbo.baconseed.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Lars-Peter Clausen <lars@metafoo.de>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Javier Martinez Canillas <javier@osg.samsung.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hello,

This series adds the missing MODULE_DEVICE_TABLE() for OF to eport
that information so modules have the correct aliases built-in and
autoloading works correctly.

A longer explanation by Javier Canillas can be found here:
https://lkml.org/lkml/2015/7/30/519

Thanks,
Luis

Luis de Bethencourt (12):
  ASoC: atmel_wm8904: Fix module autoload for OF platform driver
  ASoC: da9055: Fix module autoload for OF platform driver
  ASoC: wm8510: Fix module autoload for OF platform driver
  ASoC: wm8580: Fix module autoload for OF platform driver
  ASoC: wm8523: Fix module autoload for OF platform driver
  ASoC: fsl-asoc-card: Fix module autoload for OF platform driver
  ASoC: fsl_sai: Fix module autoload for OF platform driver
  ASoC: jz4740: Fix module autoload for OF platform driver
  ASoC: kirkwood: Fix module autoload for OF platform driver
  ASoC: pxa: Fix module autoload for OF platform drivers
  ASoC: mop500: Fix module autoload for OF platform driver
  ASoC: ux500: Fix module autoload for OF platform driver

 sound/soc/atmel/atmel_wm8904.c     | 1 +
 sound/soc/codecs/da9055.c          | 1 +
 sound/soc/codecs/wm8510.c          | 1 +
 sound/soc/codecs/wm8523.c          | 1 +
 sound/soc/codecs/wm8580.c          | 1 +
 sound/soc/fsl/fsl-asoc-card.c      | 1 +
 sound/soc/fsl/fsl_sai.c            | 1 +
 sound/soc/jz4740/jz4740-i2s.c      | 1 +
 sound/soc/kirkwood/armada-370-db.c | 1 +
 sound/soc/pxa/pxa-ssp.c            | 1 +
 sound/soc/pxa/pxa2xx-pcm.c         | 1 +
 sound/soc/ux500/mop500.c           | 1 +
 sound/soc/ux500/ux500_msp_dai.c    | 1 +
 13 files changed, 13 insertions(+)

-- 
2.4.6
