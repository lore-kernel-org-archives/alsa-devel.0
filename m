From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH 0/9] Remove use of "gpio-reset" from DT
Date: Wed, 8 Nov 2017 15:24:56 -0600
Message-ID: <20171108212505.28320-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>
List-Id: alsa-devel@alsa-project.org

Hello all,

I was working on fixing up the tlv320aic31xx driver when I noticed
its gpio reset was not working, it was due to this driver looking
for "gpio-reset" instead of the usual "reset-gpio". A quick check
shows this mistake is rare and only copied by one other audio CODECs:

$ git grep "reset-gpio" | wc -l
630
$ git grep "gpio-reset" | wc -l
6

Luckliy the two effected drivers only use this reset line when power
has been cut to the device, so not only were these optional
properties but they had no real functional effect anyway. Lets
just fix this typo before is spreads to drivers were it matters.

I've also added fixes tags to each patch so it can be individually
back-ported to where this bug was introduced if one wanted to. I'm
hoping this can sit on next for a while to get the most testing,
just in case I'm wrong about this not breaking anything :)

Thanks,
Andrew

Andrew F. Davis (9):
  ASoC: tlv320aic31xx: Fix typo in DT binding documentation
  ASoC: tlv320aic3x: Fix typo in DT binding documentation
  ASoC: cs42l56: bindings: sound: Fix reset GPIO name in example DT
    binding
  ARM: dts: am335x-pepper: Fix the audio CODEC's reset pin
  ARM: dts: imx6: RDU2: Fix the audio CODEC's reset pin
  ARM: dts: imx: Fix the audio CODEC's reset pin
  ARM: dts: omap3-n900: Fix the audio CODEC's reset pin
  ASoC: tlv320aic31xx: Fix the reset GPIO OF name
  ASoC: tlv320aic3x: Fix the reset GPIO OF name

 Documentation/devicetree/bindings/sound/cs42l56.txt       | 2 +-
 Documentation/devicetree/bindings/sound/tlv320aic31xx.txt | 5 ++++-
 Documentation/devicetree/bindings/sound/tlv320aic3x.txt   | 6 +++++-
 arch/arm/boot/dts/am335x-pepper.dts                       | 2 +-
 arch/arm/boot/dts/imx6qdl-gw5903.dtsi                     | 2 +-
 arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi                   | 4 ++--
 arch/arm/boot/dts/omap3-n900.dts                          | 4 ++--
 sound/soc/codecs/tlv320aic31xx.c                          | 2 +-
 sound/soc/codecs/tlv320aic3x.c                            | 2 +-
 9 files changed, 18 insertions(+), 11 deletions(-)

-- 
2.15.0
