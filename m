From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Subject: [PATCH 0/2] ASoC: Add support for MikroElektronika PROTO codec
Date: Wed, 29 Aug 2018 17:47:25 +0300
Message-ID: <20180829144727.13757-1-codrin.ciubotariu@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, broonie@kernel.org, robh+dt@kernel.org, alexandre.belloni@bootlin.com, nicolas.ferre@microchip.com
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, florian.meier@koalo.de, cristian.birsan@microchip.com
List-Id: alsa-devel@alsa-project.org

This patchset is based on Florian's initial PROTO driver:
https://lkml.org/lkml/2013/5/22/342

My changes made the driver more generic, so that we could connect other
I2S CPU DAIs, by using device-tree.

Tested with sama5d2 I2S driver.

Codrin Ciubotariu (2):
  ASoC: Add driver for PROTO Audio CODEC (with a WM8731)
  ASoC: mikroe-proto: dt-bindings: add DT bindings for PROTO board

 .../bindings/sound/mikroe,mikroe-proto.txt    |  23 +++
 .../devicetree/bindings/vendor-prefixes.txt   |   1 +
 sound/soc/atmel/Kconfig                       |   7 +
 sound/soc/atmel/Makefile                      |   2 +
 sound/soc/atmel/mikroe-proto.c                | 189 ++++++++++++++++++
 5 files changed, 222 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/mikroe,mikroe-proto.txt
 create mode 100644 sound/soc/atmel/mikroe-proto.c

-- 
2.17.1
