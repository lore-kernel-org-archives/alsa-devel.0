From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH 00/17] Add Headphone Detection to TLV320AIC31xx Driver
Date: Wed, 8 Nov 2017 18:27:24 -0600
Message-ID: <20171109002741.10897-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>
List-Id: alsa-devel@alsa-project.org

Hello all,

This series has the end goal of adding headphone detection to
the tlv320aic31xx driver. The first few patches are mostly cleanups.
Then a couple bug fixes I noticed. Followed by adding interrupt
handling and finally headphone detection.

The last two, as their commit name recommends, should not be taken and
are included in-case someone wants to evaluate headphone detection
using the EVM for this device wired to a Beaglebone Black.

This series (or at least patch #5) depend on this DT fix[0].

Thanks,
Andrew

[0]https://www.spinics.net/lists/kernel/msg2644651.html

Andrew F. Davis (17):
  ASoC: tlv320aic31xx: General source formatting cleanup
  ASoC: tlv320aic31xx: Reformat header file using GENMASK and BIT macros
  ASoC: tlv320aic31xx: Fix GPIO1 register definition
  ASoC: tlv320aic31xx: Merge init function into probe
  ASoC: tlv320aic31xx: Switch GPIO handling to use gpiod_* API
  ASoC: tlv320aic31xx: Remove platform data
  ASoC: tlv320aic31xx: Add MICBIAS off setting
  ASoC: tlv320aic31xx: Check clock and divider before division
  ASoC: tlv320aic31xx: Add CODEC clock slave support
  ASoC: tlv320aic31xx: Fix inverted BCLK handling
  ASoC: tlv320aic31xx: Reset registers during probe
  ASoC: tlv320aic31xx: Add short circuit detection support
  ASoC: tlv320aic31xx: Add overflow detection support
  ASoC: tlv320aic31xx: Add headphone/headset detection
  ASoC: tlv320aic31xx: Add button press detection
  NOT FOR MERGING: Add TLV320DAC3101 to BBB for testing
  NOT FOR MERGING: Add demo jack detection policy for testing

 .../devicetree/bindings/sound/tlv320aic31xx.txt    |   1 +
 arch/arm/boot/dts/am335x-boneblack.dts             | 106 +++++
 include/dt-bindings/sound/tlv320aic31xx-micbias.h  |   1 +
 sound/soc/codecs/tlv320aic31xx.c                   | 400 +++++++++++-----
 sound/soc/codecs/tlv320aic31xx.h                   | 504 ++++++++++-----------
 5 files changed, 623 insertions(+), 389 deletions(-)
 rewrite sound/soc/codecs/tlv320aic31xx.h (83%)

-- 
2.15.0
