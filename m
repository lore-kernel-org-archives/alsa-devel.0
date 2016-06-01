From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH 0/4] ASoC: sunxi: Add i2s controller support
Date: Wed,  1 Jun 2016 19:54:26 +0200
Message-ID: <20160601175430.11625-1-maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Andrea Venturi <ennesimamail.av@gmail.com>, Code Kipper <codekipper@gmail.com>, gianfranco@moddevices.com, Maxime Ripard <maxime.ripard@free-electrons.com>
List-Id: alsa-devel@alsa-project.org

Hi everyone,

This is the first version of the I2S support for the controller found
in the Allwinner A10 and later SoCs.

Playback has been tested with an UDA1380 on an A20-Olinuxino. Capture
is not implemented yet, but will come eventually.

Let me know what you think,
Maxime

Emilio L=C3=B3pez (1):
  ARM: sun7i: Add mod1 clock nodes

Maxime Ripard (3):
  dt-bindings: Add A10 I2S controller binding documentation
  ASoC: sunxi: Add Allwinner A10 Digital Audio driver
  ARM: sun7i: Add DAI nodes

 .../devicetree/bindings/sound/sun4i-i2s.txt        |  33 +
 arch/arm/boot/dts/sun7i-a20.dtsi                   |  87 ++-
 sound/soc/sunxi/Kconfig                            |  10 +
 sound/soc/sunxi/Makefile                           |   2 +-
 sound/soc/sunxi/sun4i-i2s.c                        | 714 +++++++++++++=
++++++++
 5 files changed, 843 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/sun4i-i2s.t=
xt
 create mode 100644 sound/soc/sunxi/sun4i-i2s.c

--=20
2.8.3
