From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 0/6] ] ASoC: atmel: extend SSC support
Date: Sat, 24 Aug 2019 22:26:49 +0200
Message-ID: <cover.1566677788.git.mirq-linux@rere.qmqm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, devicetree@vger.kernel.org
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, Arnd Bergmann <arnd@arndb.de>, Chas Williams <3chas3@gmail.com>, Codrin Ciubotariu <codrin.ciubotariu@microchip.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Ludovic Desroches <ludovic.desroches@microchip.com>, Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, Rob Herring <robh-dt@kernel.org>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This series improves support for various configurations using SSC module
as implemented in Atmel SAMA5Dx SoCs. Patches are:

1. enable SSC in Kconfig for audio-graph-card support
2. DRY mode setting code
3. implement left-justified data mode
4-6. enable shared FSYNC source for slave mode

Patches against tiwai/sound/for-next tree. You can also pull from
   https://rere.qmqm.pl/git/linux
branch:
   atmel-ssc


Michał Mirosław (6):
  ASoC: atmel: enable SOC_SSC_PDC and SOC_SSC_DMA in Kconfig
  ASoC: atmel_ssc_dai: rework DAI format configuration
  ASoC: atmel_ssc_dai: implement left-justified data mode
  dt-bindings: misc: atmel-ssc: LRCLK from TF/RF pin option
  misc: atmel-ssc: get LRCLK pin selection from DT
  ASoC: atmel_ssc_dai: Enable shared FSYNC source in frame-slave mode

 .../devicetree/bindings/misc/atmel-ssc.txt    |   5 +
 drivers/misc/atmel-ssc.c                      |   9 +
 include/linux/atmel-ssc.h                     |   2 +
 sound/soc/atmel/Kconfig                       |  30 +-
 sound/soc/atmel/atmel_ssc_dai.c               | 305 ++++++------------
 5 files changed, 137 insertions(+), 214 deletions(-)

-- 
2.20.1
