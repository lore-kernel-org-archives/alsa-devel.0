From: Matt Porter <mporter@konsulko.com>
Subject: [PATCH 0/2] TDA7419 audio processor driver
Date: Tue, 27 Feb 2018 17:51:26 -0500
Message-ID: <20180227225128.17815-1-mporter@konsulko.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This series adds an ASoC component driver for the ST TDA7419 audio
processor which is commonly used in automotive audio applications.
The datasheet can be found at
http://www.st.com/resource/en/datasheet/tda7419.pdf

Matt Porter (2):
  ASoC: add tda7419 audio processor binding
  ASoC: add tda7419 audio processor driver

 .../devicetree/bindings/sound/tda7419.txt          |  15 +
 sound/soc/codecs/Kconfig                           |   6 +
 sound/soc/codecs/Makefile                          |   2 +
 sound/soc/codecs/tda7419.c                         | 571 +++++++++++++++++++++
 4 files changed, 594 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/tda7419.txt
 create mode 100644 sound/soc/codecs/tda7419.c

-- 
2.11.0
