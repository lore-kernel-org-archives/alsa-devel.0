From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v3 0/7] Allwinner H6 SPDIF support
Date: Sat, 25 May 2019 18:23:16 +0200
Message-ID: <20190525162323.20216-1-peron.clem@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Jagan Teki <jagan@amarulasolutions.com>
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
List-Id: alsa-devel@alsa-project.org

*H6 DMA support IS REQUIRED*

Allwinner H6 SoC has a SPDIF controller called One Wire Audio (OWA) which
is different from the previous H3 generation and not compatible.

Difference are an increase of fifo sizes, some memory mapping are different
and there is now the possibility to output the master clock on a pin.

Actually all these features are unused and only a bit for flushing the TX
fifo is required.

Also this series requires the DMA working on H6, a first version has been
submitted by Jernej Škrabec[1] but has not been accepted yet.

[1] https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=89011

Changes since v2:
 - Split quirks and H6 support patch
 - Add specific section for quirks comment

Changes since v1:
 - Remove H3 compatible
 - Add TX fifo bit flush quirks
 - Add H6 bindings in SPDIF driver

Clément Péron (7):
  dt-bindings: sound: sun4i-spdif: Add Allwinner H6 compatible
  ASoC: sun4i-spdif: Move quirks to the top
  ASoC: sun4i-spdif: Add TX fifo bit flush quirks
  ASoC: sun4i-spdif: Add support for H6 SoC
  arm64: dts: allwinner: Add SPDIF node for Allwinner H6
  arm64: dts: allwinner: h6: Enable SPDIF for Beelink GS1
  arm64: defconfig: Enable Sun4i SPDIF module

 .../bindings/sound/sunxi,sun4i-spdif.txt      |  3 +-
 .../dts/allwinner/sun50i-h6-beelink-gs1.dts   |  4 ++
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  | 38 ++++++++++++++
 arch/arm64/configs/defconfig                  |  1 +
 sound/soc/sunxi/sun4i-spdif.c                 | 49 ++++++++++++++++---
 5 files changed, 88 insertions(+), 7 deletions(-)

-- 
2.20.1
