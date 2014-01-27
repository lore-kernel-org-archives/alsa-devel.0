From: Bo Shen <voice.shen@atmel.com>
Subject: [PATCH v2 0/3] ASoC: atmel_ssc_dai: add option to choose clock
Date: Mon, 27 Jan 2014 14:55:23 +0800
Message-ID: <1390805726-1841-1-git-send-email-voice.shen@atmel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, linux-sound@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, Bo Shen <voice.shen@atmel.com>, Jaroslav Kysela <perex@perex.cz>, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, linux-doc@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, Wolfram Sang <wsa@the-dreams.de>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Mark Brown <broonie@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>
List-Id: alsa-devel@alsa-project.org

When SSC work in slave mode, the clock can come from TK pin and also
can come from RK pin, this is hardware design decided. So, make it
available to choose where the clock from.

Changes in v2:
  - using "-" replace "_" in binding document

Bo Shen (3):
  ASoC: atmel_ssc_dai: make option to choose clock
  ASoC: atmel_wm8904: make it available to choose clock
  Binding: atmel-wm8904: add option to choose clock

 Documentation/devicetree/bindings/sound/atmel-wm8904.txt |  6 ++++++
 sound/soc/atmel/atmel_ssc_dai.c                          | 16 ++++++++++++----
 sound/soc/atmel/atmel_ssc_dai.h                          |  1 +
 sound/soc/atmel/atmel_wm8904.c                           | 10 ++++++++++
 4 files changed, 29 insertions(+), 4 deletions(-)

-- 
1.8.5.2
