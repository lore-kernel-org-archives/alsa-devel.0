From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 0/4] ASoC; davinci-mcasp: Pin handling updates
Date: Fri, 16 Nov 2018 15:41:37 +0200
Message-ID: <20181116134141.17396-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, misael.lopez@ti.com, jsarha@ti.com, robh+dt@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi,

The series will improve the McASP pin handling:
- To avoid non configured clocks leaking out from McASP
- make sure that the AXR pin (TX) state is correct in all scenarios
- Allow user configurable DISMOD for the tx pin instead of hardwiring it in the
  code to low

The DISMOD configuration is needed when the codec requires the TX line to be
high during inactive slots (mu-law codecs for example).

Regards,
Peter
---
Peter Ujfalusi (4):
  ASoC: davinci-mcasp: Clear TXSTAT register before activating
    serializers
  ASoC: davinci-mcasp: Update PDIR (pin direction) register handling
  bindings: sound: davinci-mcasp: Document dismod optional property
  ASoC: davinci-mcasp: Implement configurable dismod handling

 .../bindings/sound/davinci-mcasp-audio.txt    |   5 +
 include/linux/platform_data/davinci_asp.h     |   1 +
 sound/soc/davinci/davinci-mcasp.c             | 109 +++++++++++++++---
 sound/soc/davinci/davinci-mcasp.h             |  30 ++---
 4 files changed, 112 insertions(+), 33 deletions(-)

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
