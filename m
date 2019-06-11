From: Thomas Preston <thomas.preston@codethink.co.uk>
Subject: [PATCH v1 0/4] ASoC: Codecs: Add TDA7802 codec
Date: Tue, 11 Jun 2019 18:49:05 +0100
Message-ID: <20190611174909.12162-1-thomas.preston@codethink.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Charles Keepax <ckeepax@opensource.cirrus.com>, Jerome Brunet <jbrunet@baylibre.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Marco Felsch <m.felsch@pengutronix.de>, Paul Cercueil <paul@crapouillou.net>, Kirill Marinushkin <kmarinushkin@birdec.tech>, Cheng-Yi Chiang <cychiang@chromium.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Vinod Koul <vkoul@kernel.org>, Annaliese McDermond <nh6z@nh6z.net>, Thomas Preston <thomas.preston@codethink.co.uk>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel
List-Id: alsa-devel@alsa-project.org

This patch series adds a driver for the ST TDA7802 amplifier.

Thanks,
Thomas

Cc: Patrick Glaser <pglaser@tesla.com>
Cc: Rob Duncan <rduncan@tesla.com>
Cc: Nate Case <ncase@tesla.com>

Thomas Preston (4):
  dt-bindings: ASoC: Add TDA7802 amplifier
  ASoC: Add codec driver for ST TDA7802
  ASoC: tda7802: Add enable device attribute
  ASoC: tda7802: Add speaker-test sysfs

 .../devicetree/bindings/sound/tda7802.txt          |  26 +
 sound/soc/codecs/Kconfig                           |   6 +
 sound/soc/codecs/Makefile                          |   2 +
 sound/soc/codecs/tda7802.c                         | 815 +++++++++++++++++++++
 4 files changed, 849 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/tda7802.txt
 create mode 100644 sound/soc/codecs/tda7802.c

-- 
2.11.0
