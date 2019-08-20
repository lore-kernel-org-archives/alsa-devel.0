From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Subject: [PATCH 0/3] ASoC: mchp-i2s-mcc: Several fixes
Date: Tue, 20 Aug 2019 19:24:08 +0300
Message-ID: <20190820162411.24836-1-codrin.ciubotariu@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: broonie@kernel.org, perex@perex.cz, tiwai@suse.com, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com, Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
List-Id: alsa-devel@alsa-project.org

This pathset fixes some issues detected while testing some more the
Microchip I2S multichannel controller. The first two patches fix some
issues that appear mostly when hw_free() and hw_params() callbacks
are called multiple times. The third patch fixes a problem caused
when the controller is in master mode and both capture and playback 
are played at the same time.

All three patches have a "Fixes" tag. Although they are independent,
some conflicts might appear if they are not applied in the order
presented in this patchset. If so, please let me know so I can rebase
them.

Codrin Ciubotariu (3):
  ASoC: mchp-i2s-mcc: Wait for RX/TX RDY only if controller is running
  ASoC: mchp-i2s-mcc: Fix unprepare of GCLK
  ASoC: mchp-i2s-mcc: Fix simultaneous capture and playback in master
    mode

 sound/soc/atmel/mchp-i2s-mcc.c | 111 +++++++++++++++++++--------------
 1 file changed, 64 insertions(+), 47 deletions(-)

-- 
2.20.1
