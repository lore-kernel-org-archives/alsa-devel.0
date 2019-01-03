From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 0/3] ASoC: ti: davinci-mcasp: GPIO mode support for pins
Date: Thu, 3 Jan 2019 16:05:49 +0200
Message-ID: <20190103140552.29809-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, misael.lopez@ti.com, jsarha@ti.com, devicetree@vger.kernel.org, robh+dt@kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi,

Each McASP pins can be configured individually to be used as McASP or GPIO pin.

This series will allow client drivers to use pins as GPIO (optional) in case the
board wired up them to be used in this mode.

Regards,
Peter
---
Peter Ujfalusi (3):
  ASoC: ti: davinci-mcasp: Move context save/restore to runtime_pm
    callbacks
  bindings: sound: davinci-mcasp: Document GPIO support
  ASoC: ti: davinci-mcasp: Add support for GPIO mode of the pins

 .../bindings/sound/davinci-mcasp-audio.txt    |  17 +
 sound/soc/ti/davinci-mcasp.c                  | 295 +++++++++++++-----
 2 files changed, 237 insertions(+), 75 deletions(-)

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
