From: Marek Belisko <marek@goldelico.com>
Subject: [PATCH 0/3] ASoC: Add gtm601 simple codec
Date: Thu, 30 Apr 2015 23:28:00 +0200
Message-ID: <1430429283-27907-1-git-send-email-marek@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.de
Cc: broonie@kernel.org, hns@goldelico.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Marek Belisko <marek@goldelico.com>
List-Id: alsa-devel@alsa-project.org

Following patch series add support for gtm601 PCM audio.
gtm601 is UMTS modem which provide I2S interface for rx/tx data.
Codec is connected to cpu in master mode (rate is determined by Master and
Bit clocks).

Marek Belisko (3):
  ASoC: Add gtm601 codec driver
  Documentation: devicetree: sound: Add documentation for gtm601 codec
  Documentation: vendor-prefixes: Add option prefix

 Documentation/devicetree/bindings/sound/gtm601.txt |  14 +++
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 sound/soc/codecs/Kconfig                           |   4 +
 sound/soc/codecs/Makefile                          |   2 +
 sound/soc/codecs/gtm601.c                          | 106 +++++++++++++++++++++
 5 files changed, 127 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/gtm601.txt
 create mode 100644 sound/soc/codecs/gtm601.c

-- 
1.9.1
