From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH 0/9] Add audiocodec support for A64 SoC
Date: Sun,  3 Dec 2017 12:41:48 -0800
Message-ID: <20171203204157.20829-1-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f196.google.com (mail-pf0-f196.google.com
 [209.85.192.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 1E7B0266B0F
 for <alsa-devel@alsa-project.org>; Sun,  3 Dec 2017 21:42:03 +0100 (CET)
Received: by mail-pf0-f196.google.com with SMTP id j124so6994424pfc.2
 for <alsa-devel@alsa-project.org>; Sun, 03 Dec 2017 12:42:03 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, Marcus Cooper <codekipper@gmail.com>, =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@free-electrons.com>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
Cc: Vasily Khoruzhick <anarsoul@gmail.com>
List-Id: alsa-devel@alsa-project.org

This series adds A64 audiocodec support into sun4i-i2s, sun8i-codec
and sun8i-codec-analog drivers and enables sound on Pine64 and SoPine
boards.

Marcus Cooper (3):
  ASoC: sun4i-i2s: Add compatibility with A64 codec I2S
  ASoC: sun8i-codec-analog: Use callbacks to add headphones and lineout
    outputs
  ASoC: sun8i-codec-analog: Add support for A64 SoC

Vasily Khoruzhick (6):
  ASoC: sun4i-i2s: Add quirk to handle fixed WSS
  ASoC: sun8i-codec: Add quirk to specify aif1_lrck_div value
  ASoC: sun8i-codec: Add support for A64 SoC
  ASoC: sun8i-codec-analog: Add component driver field to quirks
    structure
  arm64: dts: allwinner: a64: Add nodes necessary for analog sound
    support
  arm64: dts: allwinner: a64: Enable sound on Pine64 and SoPine

 .../devicetree/bindings/sound/sun4i-i2s.txt        |   2 +
 .../bindings/sound/sun8i-codec-analog.txt          |   1 +
 .../sound/{sun8i-a33-codec.txt => sun8i-codec.txt} |   6 +-
 .../arm64/boot/dts/allwinner/sun50i-a64-pine64.dts |  16 ++
 .../dts/allwinner/sun50i-a64-sopine-baseboard.dts  |  16 ++
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi      |  52 ++++
 sound/soc/sunxi/Kconfig                            |   2 +-
 sound/soc/sunxi/sun4i-i2s.c                        |  53 +++-
 sound/soc/sunxi/sun8i-codec-analog.c               | 307 ++++++++++++++++++---
 sound/soc/sunxi/sun8i-codec.c                      |  47 +++-
 10 files changed, 458 insertions(+), 44 deletions(-)
 rename Documentation/devicetree/bindings/sound/{sun8i-a33-codec.txt => sun8i-codec.txt} (91%)

-- 
2.15.0
