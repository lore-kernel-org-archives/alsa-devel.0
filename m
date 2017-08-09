From: Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: [PATCH 0/3] ASoC: rockchip: Parse dai links from dts
Date: Wed,  9 Aug 2017 20:19:36 +0800
Message-ID: <1502281179-15916-1-git-send-email-jeffy.chen@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, dgreid@chromium.org, heiko@sntech.de
Cc: briannorris@chromium.org, dianders@chromium.org, Jeffy Chen <jeffy.chen@rock-chips.com>, Jaroslav Kysela <perex@perex.cz>, Matthias Kaehlcke <mka@chromium.org>, alsa-devel@alsa-project.org, Will Deacon <will.deacon@arm.com>, linux-rockchip@lists.infradead.org, Mark Brown <broonie@kernel.org>, Klaus Goger <klaus.goger@theobroma-systems.com>, Takashi Iwai <tiwai@suse.com>, devicetree@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Caesar Wang <wxt@rock-chips.com>, Catalin Marinas <catalin.marinas@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


Currently we are using a fixed list of dai links in the driver.
This serial of patches would let the driver parse dai links from
dts, so that we can reorder/disable them in the dts.

Tested on my chromebook bob(with cros 4.4 kernel), it still works
after disabled rt5514 codec in the dts.



Jeffy Chen (3):
  ASoC: rockchip: Parse dai links from dts
  arm64: dts: rockchip: Add rockchip,codec-names property
  dt-bindings: ASoC: rockchip: Add rockchip,codec-names property

 .../bindings/sound/rockchip,rk3399-gru-sound.txt   |   2 +
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi       |   1 +
 sound/soc/rockchip/rk3399_gru_sound.c              | 129 ++++++++++++++-------
 3 files changed, 89 insertions(+), 43 deletions(-)

-- 
2.1.4
