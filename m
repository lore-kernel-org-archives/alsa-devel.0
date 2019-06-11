From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 0/2] ASoC: ti: davinci-mcasp: Master AUXCLK FS ration support
Date: Tue, 11 Jun 2019 15:29:39 +0300
Message-ID: <20190611122941.10708-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, misael.lopez@ti.com, jsarha@ti.com, devicetree@vger.kernel.org, robh+dt@kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi,

The AUXCLK of McASP which is used as the master clock for I2S signal generation
usually is a static clock.
The driver (and bindings) assumes this setup, however if the AUXCLK can change
with the stream's FS then this assumption breaks the audio support as it sets
constraint rules in startup, these rules run pre hw_params and in hw_params we
are going to be notified of the new reference clock (which is some multiple of
the FS).

Regards,
Peter
---
Peter Ujfalusi (2):
  bindings: sound: davinci-mcasp: Add support for optional
    auxclk-fs-ratio
  ASoC: ti: davinci-mcasp: Support for auxclk-fs-ratio

 .../bindings/sound/davinci-mcasp-audio.txt    |  3 ++
 sound/soc/ti/davinci-mcasp.c                  | 52 ++++++++++++++++---
 2 files changed, 47 insertions(+), 8 deletions(-)

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
