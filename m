From: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Subject: [PATCH 0/4] Add SPDIF support for rockchip
Date: Tue, 28 Jul 2015 14:03:27 +0200
Message-ID: <1438085011-16577-1-git-send-email-sjoerd.simons@collabora.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Heiko Stuebner <heiko@sntech.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This patchset adds support for the Rockchip SPDIF transceiver as present on
RK3066, RK3188 and RK3288 boards and enables it on a Radxa rock pro.

Tested on a Radxa Rock Pro board.

Sjoerd Simons (4):
  ASoC: dt-bindings: add rockchip tranceiver bindings
  ASoc: rockchip: Add rockchip SPDIF transceiver driver
  ARM: dts: rockchip: Add SPDIF transceiver for RK3188
  ARM: dts: rockchip: Add SPDIF optical out on Radxa Rock

 .../devicetree/bindings/sound/rockchip-spdif.txt   |  41 +++
 arch/arm/boot/dts/rk3188-radxarock.dts             |  19 ++
 arch/arm/boot/dts/rk3188.dtsi                      |  22 ++
 sound/soc/rockchip/Kconfig                         |   9 +
 sound/soc/rockchip/Makefile                        |   3 +
 sound/soc/rockchip/rockchip_spdif.c                | 375 +++++++++++++++++++++
 sound/soc/rockchip/rockchip_spdif.h                |  63 ++++
 7 files changed, 532 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/rockchip-spdif.txt
 create mode 100644 sound/soc/rockchip/rockchip_spdif.c
 create mode 100644 sound/soc/rockchip/rockchip_spdif.h

-- 
2.4.6
