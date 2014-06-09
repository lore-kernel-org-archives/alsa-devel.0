From: Bo Shen <voice.shen@atmel.com>
Subject: [PATCH v2 0/5] As the sama5d3xek and at91sam9n12ek have switch to CCF,
Date: Mon, 9 Jun 2014 11:31:42 +0800
Message-ID: <1402284707-23354-1-git-send-email-voice.shen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sound-owner@vger.kernel.org>
Sender: linux-sound-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: nicolas.ferre@atmel.com, boris.brezillon@free-electrons.com, alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Bo Shen <voice.shen@atmel.com>
List-Id: alsa-devel@alsa-project.org

in order to support audio, also switch it to CCF.

This patch series based on next-2014-0604 tag.

Changes in v2:
  - wm8904: Remove the mclk checking when try to enable or disable it,
    as it is checked when required.
  - dt: List the clock-names, which need by driver.

Bo Shen (5):
  ASoC: atmel_wm8904: switch to CCF
  ASoC: wm8904: switch to CCF
  dt: wm8904: add device tree binding document
  ARM: atmel: sama5d3xek: switch sound to CCF
  ARM: atmel: at91sam9n12ek: switch sound to CCF

 Documentation/devicetree/bindings/sound/wm8904.txt | 33 ++++++++++++++
 arch/arm/boot/dts/at91sam9n12ek.dts                |  2 +
 arch/arm/boot/dts/sama5d3xmb.dtsi                  |  2 +
 sound/soc/atmel/atmel_wm8904.c                     | 50 ----------------------
 sound/soc/codecs/wm8904.c                          | 11 +++++
 5 files changed, 48 insertions(+), 50 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/wm8904.txt

-- 
1.8.5.2

