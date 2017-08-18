From: Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: [PATCH v4 0/9] ASoC: rockchip: Parse dai links from dts
Date: Fri, 18 Aug 2017 11:11:38 +0800
Message-ID: <20170818031147.16810-1-jeffy.chen@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, dgreid@chromium.org, heiko@sntech.de
Cc: briannorris@chromium.org, mka@chromium.org, dianders@chromium.org, Jeffy Chen <jeffy.chen@rock-chips.com>, Jaroslav Kysela <perex@perex.cz>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Will Deacon <will.deacon@arm.com>, linux-rockchip@lists.infradead.org, Mark Brown <broonie@kernel.org>, Klaus Goger <klaus.goger@theobroma-systems.com>, Oder Chiou <oder_chiou@realtek.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Bard Liao <bardliao@realtek.com>, Catalin Marinas <catalin.marinas@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


Currently we are using a fixed list of dai links in the driver.
This serial of patches would let the driver parse dai links from
dts, so that we can make some of them optional for future boards.

Tested on my chromebook bob(with cros 4.4 kernel), it still works
after disabled rt5514 codecs in the dts.


Changes in v4:
Use non-zero drv id to avoid legacy dai naming instead of switching to
snd_soc_register_codec.

Changes in v3:
Use compatible to match audio codecs
        -- Suggested-by Matthias Kaehlcke <mka@chromium.org>

Changes in v2:
Let rockchip,codec-names be a required property, because we plan to
add more supported codecs to the fixed dai link list in the driver.

Jeffy Chen (9):
  ASoC: rt5514: Avoid legacy dai naming
  ASoC: rockchip: Remove obsolete dmic-delay
  ASoC: rockchip: Use codec of_node and dai_name for rt5514 dsp
  arm64: dts: rockchip: Add rt5514 dsp for Gru
  arm64: dts: rockchip: Update rt5514 devices' compatible for Gru
  ASoC: rockchip: Parse dai links from dts
  ASoC: rockchip: Add support for DP codec
  ASoC: rockchip: Add support for DMIC codec
  dt-bindings: ASoC: rockchip: Update description of rockchip,codec

 .../bindings/sound/rockchip,rk3399-gru-sound.txt   |   9 +-
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi       |   7 +-
 sound/soc/codecs/rt5514-spi.c                      |   2 +-
 sound/soc/rockchip/Kconfig                         |   2 +
 sound/soc/rockchip/rk3399_gru_sound.c              | 263 ++++++++++++++-------
 5 files changed, 183 insertions(+), 100 deletions(-)

-- 
2.11.0
