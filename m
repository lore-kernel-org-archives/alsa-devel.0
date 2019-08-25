From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 0/4] wm8904: adapt driver for use with audio-graph-card
Date: Sun, 25 Aug 2019 14:17:30 +0200
Message-ID: <cover.1566734630.git.mirq-linux@rere.qmqm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, patches@opensource.cirrus.com
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, Allison Randal <allison@lohutok.net>, Anders Roxell <anders.roxell@linaro.org>, Annaliese McDermond <nh6z@nh6z.net>, Charles Keepax <ckeepax@opensource.cirrus.com>, Codrin Ciubotariu <codrin.ciubotariu@microchip.com>, Enrico Weigelt <info@metux.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jaroslav Kysela <perex@perex.cz>, Jerome Brunet <jbrunet@baylibre.com>, Kate Stewart <kstewart@linuxfoundation.org>, Kirill Marinushkin <kmarinushkin@birdec.tech>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, Ludovic Desroches <ludovic.desroches@microchip.com>, Mark Brown <broonie@kernel.org>, Maxime Jourdan <mjourdan@baylibre.com>, Nariman Poushin <npoushin@op>
List-Id: alsa-devel@alsa-project.org

This series allows to use WM8904 codec as audio-graph-card component.
It starts with rework of FLL handling in the codec's driver, and as an
example includes (untested) rework for codec with similar FLL: WM8994.

Series based on tiwai/sound/for-next tree. You can also pull from:
   https://rere.qmqm.pl/git/linux
branch:
   wm8904

(branch includes two fixes already sent to alsa-devel, but not merged yet).

Michał Mirosław (4):
  ASoC: wm_fll: extract common code for Wolfson FLLs
  ASoC: wm8904: use common FLL code
  ASoC: wm8904: automatically choose clock source
  [RFT] ASoC: wm8994: use common FLL code

 sound/soc/atmel/atmel_wm8904.c |  11 +-
 sound/soc/codecs/Kconfig       |   9 +
 sound/soc/codecs/Makefile      |   2 +
 sound/soc/codecs/wm8904.c      | 516 +++++++++++---------------------
 sound/soc/codecs/wm8904.h      |   5 -
 sound/soc/codecs/wm8994.c      | 281 +++++-------------
 sound/soc/codecs/wm8994.h      |   4 +-
 sound/soc/codecs/wm_fll.c      | 518 +++++++++++++++++++++++++++++++++
 sound/soc/codecs/wm_fll.h      |  60 ++++
 9 files changed, 849 insertions(+), 557 deletions(-)
 create mode 100644 sound/soc/codecs/wm_fll.c
 create mode 100644 sound/soc/codecs/wm_fll.h

-- 
2.20.1
