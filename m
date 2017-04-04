From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 0/6] ASoC: Add OF device table to I2C drivers that are missing it
Date: Tue,  4 Apr 2017 15:26:24 -0400
Message-ID: <20170404192630.11408-1-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Jaroslav Kysela <perex@perex.cz>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@kernel.org>, Oder Chiou <oder_chiou@realtek.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Julia Lawall <Julia.Lawall@lip6.fr>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

Hello,

This series add OF device ID tables to ASoC I2C drivers whose devices are
either used in Device Tree source files or are listed in binding docs as
a compatible string.

That's done because the plan is to change the I2C core to report proper OF
modaliases instead of always reporting a MODALIAS=i2c:<foo> regardless if
a device was registered via DT or using the legacy platform data mechanism.

So these patches will make sure that ASoC I2C drivers modules will continue
to be autoloaded once the I2C core is changed to report proper OF modalias.

Best regards,
Javier


Javier Martinez Canillas (6):
  ASoc: rt5645: Add OF device ID table
  ASoC: ssm4567: Add OF device ID table
  ASoC: sta529: Add OF device ID table
  ASoC: uda1380: Add OF device ID table
  ASoC: wm8978: Add OF device ID table
  ASoC: rt5677: Add OF device ID table

 sound/soc/codecs/rt5645.c  | 10 ++++++++++
 sound/soc/codecs/rt5677.c  |  7 +++++++
 sound/soc/codecs/ssm4567.c |  9 +++++++++
 sound/soc/codecs/sta529.c  |  7 +++++++
 sound/soc/codecs/uda1380.c |  7 +++++++
 sound/soc/codecs/wm8978.c  |  7 +++++++
 6 files changed, 47 insertions(+)

-- 
2.9.3
