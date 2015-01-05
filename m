From: Inha Song <ideal.song@samsung.com>
Subject: [alsa-devel] [PATCH 0/3] Sound support for Exynos4412 Trats2 board
Date: Mon, 05 Jan 2015 20:25:14 +0900
Message-ID: <1420457117-11030-1-git-send-email-ideal.song@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, s.nawrocki@samsung.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, kgene@kernel.org, sbkim73@samsung.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.de, grant.likely@linaro.org, ideal.song@samsung.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patch-set adds basic sound support for the Trats2 boards.
It just support primary I2s and external speaker playback.

Inha Song (3):
  ASoC: samsung: Add machine driver for Trats2
  ASoC: samsung: Document Trats2 audio subsystem bindings
  ARM: dts: Add sound nodes for exynos4412-trats2

 .../bindings/sound/samsung,trats2-wm1811.txt       |  31 +++
 arch/arm/boot/dts/exynos4412-trats2.dts            |  38 ++++
 sound/soc/samsung/Kconfig                          |   8 +
 sound/soc/samsung/Makefile                         |   2 +
 sound/soc/samsung/trats2_wm1811.c                  | 216 +++++++++++++++++++++
 5 files changed, 295 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/samsung,trats2-wm1811.txt
 create mode 100644 sound/soc/samsung/trats2_wm1811.c

-- 
2.0.0.390.gcb682f8
