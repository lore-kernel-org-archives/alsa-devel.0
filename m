From: Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: [PATCH v5 0/9] ASoC: rockchip: Parse dai links from dts
Date: Tue, 22 Aug 2017 15:57:19 +0800
Message-ID: <20170822075729.8438-1-jeffy.chen@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from regular1.263xmail.com (regular1.263xmail.com [211.150.99.139])
 by alsa0.perex.cz (Postfix) with ESMTP id 6D2B4266B2C
 for <alsa-devel@alsa-project.org>; Tue, 22 Aug 2017 09:57:45 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org, dgreid@chromium.org, heiko@sntech.de
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, mengdong.lin@linux.intel.com, lars@metafoo.de, Liam Girdwood <lgirdwood@gmail.com>, briannorris@chromium.org, Mark Brown <broonie@kernel.org>, Jeffy Chen <jeffy.chen@rock-chips.com>, Will Deacon <will.deacon@arm.com>, dianders@chromium.org, Rob Herring <robh+dt@kernel.org>, linux-rockchip@lists.infradead.org, mka@chromium.org, Klaus Goger <klaus.goger@theobroma-systems.com>, Catalin Marinas <catalin.marinas@arm.com>, Takashi Iwai <tiwai@suse.com>, linux-arm-kernel@lists.infradead.org, Caesar Wang <wxt@rock-chips.com>
List-Id: alsa-devel@alsa-project.org


Currently we are using a fixed list of dai links in the driver.
This serial of patches would let the driver parse dai links from
dts, so that we can make some of them optional for future boards.

Tested on my chromebook bob(with cros 4.4 kernel), it still works
after disabled rt5514 codecs in the dts.


Changes in v5:
Allow searching for dai driver name in snd_soc_find_dai, instead of
hacking non-zero device id to avoid legay dai naming.

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
  ASoC: rockchip: Remove obsolete dmic-delay
  ASoC: soc-core: Allow searching dai driver name in snd_soc_find_dai
  ASoC: rockchip: Use codec of_node and dai_name for rt5514 dsp
  arm64: dts: rockchip: Add rt5514 dsp for Gru
  arm64: dts: rockchip: Update rt5514 devices' compatible for Gru
  ASoC: rockchip: Parse dai links from dts
  ASoC: rockchip: Add support for DP codec
  ASoC: rockchip: Add support for DMIC codec
  dt-bindings: ASoC: rockchip: Update description of rockchip,codec

 .../bindings/sound/rockchip,rk3399-gru-sound.txt   |   9 +-
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi       |   7 +-
 sound/soc/rockchip/Kconfig                         |   2 +
 sound/soc/rockchip/rk3399_gru_sound.c              | 263 ++++++++++++++-------
 sound/soc/soc-core.c                               |   5 +-
 5 files changed, 185 insertions(+), 101 deletions(-)

-- 
2.11.0
