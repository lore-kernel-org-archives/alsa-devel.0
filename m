From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH 00/10] Add support for audiocodec in Allwinner
	A64
Date: Fri, 12 Oct 2018 20:32:20 -0700
Message-ID: <20181013033230.6506-1-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com
 [209.85.215.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 986DA2678CA
 for <alsa-devel@alsa-project.org>; Sat, 13 Oct 2018 05:32:45 +0200 (CEST)
Received: by mail-pg1-f193.google.com with SMTP id 80-v6so6676986pgh.10
 for <alsa-devel@alsa-project.org>; Fri, 12 Oct 2018 20:32:45 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Marcus Cooper <codekipper@gmail.com>, Mylene JOSSERAND <mylene.josserand@free-electrons.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Vasily Khoruzhick <anarsoul@gmail.com>
List-Id: alsa-devel@alsa-project.org

This series adds Allwinner A64 audiocodec support into sun4i-i2s,
sun8i-codec drivers, introduces new sun50i-codec-analog driver and enables
sound on Pine64, SoPine boards and Pinebook.

I2S for audiocodec in A64 is different from other 3 I2S modules but
similar to one in A10, digital part of codec is compatible with A33 and
analog controls part is completely different from other SoCs - it shares
only few bits in few registers, so adding support for it into existing
sun8i-codec-analog would mean duplicating all the widgets, controls and
some routes and making it hard to read. Therefore it makes sense to
introduce new driver.

Marcus Cooper (1):
  ASoC: sun4i-i2s: Add compatibility with A64 codec I2S

Vasily Khoruzhick (9):
  ASoC: sun8i-codec: Don't hardcode BCLK / LRCK ratio
  ASoC: sun8i-codec: add support for speaker amp GPIO
  ASoC: sun8i-codec-analog: split regmap code into separate driver
  ASoC: sunxi: Add bindings for A64 codec's analog path controls
  ASoC: sunxi: Add support for Allwinner A64 codec's analog path
    controls
  ASoC: sunxi: allow the sun8i-codec driver to be built on ARM64
  arm64: dts: allwinner: a64: add nodes necessary for analog sound
    support
  arm64: dts: allwinner: a64: enable sound on Pine64 and SoPine
  arm64: dts: allwinner: a64: enable sound on Pinebook

 .../devicetree/bindings/sound/sun4i-i2s.txt   |   2 +
 .../bindings/sound/sun50i-codec-analog.txt    |  14 +
 .../boot/dts/allwinner/sun50i-a64-pine64.dts  |  30 ++
 .../dts/allwinner/sun50i-a64-pinebook.dts     |  33 ++
 .../allwinner/sun50i-a64-sopine-baseboard.dts |  30 ++
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi |  58 +++
 sound/soc/sunxi/Kconfig                       |  17 +-
 sound/soc/sunxi/Makefile                      |   2 +
 sound/soc/sunxi/sun4i-i2s.c                   |  21 +
 sound/soc/sunxi/sun50i-codec-analog.c         | 451 ++++++++++++++++++
 sound/soc/sunxi/sun8i-codec-analog.c          |  79 +--
 sound/soc/sunxi/sun8i-codec.c                 |  61 ++-
 sound/soc/sunxi/sunxi-adda-pr-regmap.c        | 102 ++++
 sound/soc/sunxi/sunxi-adda-pr-regmap.h        |   7 +
 14 files changed, 824 insertions(+), 83 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/sun50i-codec-analog.txt
 create mode 100644 sound/soc/sunxi/sun50i-codec-analog.c
 create mode 100644 sound/soc/sunxi/sunxi-adda-pr-regmap.c
 create mode 100644 sound/soc/sunxi/sunxi-adda-pr-regmap.h

-- 
2.19.0
