From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH v2 0/8] Remove use of "gpio-reset" from DT
Date: Wed, 29 Nov 2017 11:13:51 -0600
Message-ID: <20171129171359.29382-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lelnx194.ext.ti.com (lelnx194.ext.ti.com [198.47.27.80])
 by alsa0.perex.cz (Postfix) with ESMTP id 0B9E6267442
 for <alsa-devel@alsa-project.org>; Wed, 29 Nov 2017 18:14:01 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>
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
just fix this before is spreads to drivers were it matters.

I've also added fixes tags to each patch so it can be individually
back-ported to where this bug was introduced if one wanted to. I'm
hoping this can sit on next for a while to get the most testing,
just in case I'm wrong about this not breaking anything.

Thanks,
Andrew

Changes from v1:
 - Move old property to "Deprecated properties" section in binding
 - Keep backwards compatibility for now in driver with warning
 - Re-order patches to keep series bisectable
 - Use "reset-gpios" over "reset-gpio"
 - Drop taken patch
 - Rebased on v4.15-rc1

Andrew F. Davis (8):
  ASoC: tlv320aic31xx: Fix typo in DT binding documentation
  ASoC: tlv320aic3x: Fix typo in DT binding documentation
  ASoC: tlv320aic31xx: Fix the reset GPIO OF name
  ASoC: tlv320aic3x: Fix the reset GPIO OF name
  ARM: dts: am335x-pepper: Fix the audio CODEC's reset pin
  ARM: dts: imx6: RDU2: Fix the audio CODEC's reset pin
  ARM: dts: imx: Fix the audio CODEC's reset pin
  ARM: dts: omap3-n900: Fix the audio CODEC's reset pin

 Documentation/devicetree/bindings/sound/tlv320aic31xx.txt |  9 ++++++++-
 Documentation/devicetree/bindings/sound/tlv320aic3x.txt   | 10 +++++++++-
 arch/arm/boot/dts/am335x-pepper.dts                       |  2 +-
 arch/arm/boot/dts/imx6qdl-gw5903.dtsi                     |  2 +-
 arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi                   |  4 ++--
 arch/arm/boot/dts/omap3-n900.dts                          |  4 ++--
 sound/soc/codecs/tlv320aic31xx.c                          | 11 +++++++++--
 sound/soc/codecs/tlv320aic3x.c                            | 15 +++++++++++----
 8 files changed, 43 insertions(+), 14 deletions(-)

-- 
2.15.0
