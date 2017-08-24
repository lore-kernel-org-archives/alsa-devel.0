From: Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: [RESENT PATCH v7 0/7] ASoC: rockchip: Parse dai links
	from dts
Date: Thu, 24 Aug 2017 12:52:20 +0800
Message-ID: <20170824045227.15504-1-jeffy.chen@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from regular1.263xmail.com (regular1.263xmail.com [211.150.99.131])
 by alsa0.perex.cz (Postfix) with ESMTP id 20E57266BED
 for <alsa-devel@alsa-project.org>; Thu, 24 Aug 2017 06:52:39 +0200 (CEST)
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, briannorris@chromium.org, Liam Girdwood <lgirdwood@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Mark Brown <broonie@kernel.org>, Jeffy Chen <jeffy.chen@rock-chips.com>, Will Deacon <will.deacon@arm.com>, dianders@chromium.org, Rob Herring <robh+dt@kernel.org>, linux-rockchip@lists.infradead.org, mka@chromium.org, Klaus Goger <klaus.goger@theobroma-systems.com>, Takashi Iwai <tiwai@suse.com>, linux-arm-kernel@lists.infradead.org, Caesar Wang <wxt@rock-chips.com>
List-Id: alsa-devel@alsa-project.org


Currently we are using a fixed list of dai links in the driver.
This serial of patches would let the driver parse dai links from
dts, so that we can make some of them optional for future boards.

Tested on my chromebook bob(with cros 4.4 kernel), it still works
after disabled rt5514 codecs in the dts.


Changes in v7:
Rebase on the newest for-next

Changes in v6:
Add dmic wakeup delay(not used for now).

Changes in v3:
Use compatible to match audio codecs
        -- Suggested-by Matthias Kaehlcke <mka@chromium.org>

Changes in v2:
Let rockchip,codec-names be a required property, because we plan to
add more supported codecs to the fixed dai link list in the driver.

Jeffy Chen (7):
  ASoC: rockchip: Use codec of_node and dai_name for rt5514 dsp
  arm64: dts: rockchip: Add rt5514 dsp for Gru
  arm64: dts: rockchip: Update rt5514 devices' compatible for Gru
  ASoC: rockchip: Parse dai links from dts
  ASoC: rockchip: Add support for DP codec
  ASoC: rockchip: Add support for DMIC codec
  dt-bindings: ASoC: rockchip: Update description of rockchip,codec

 .../bindings/sound/rockchip,rk3399-gru-sound.txt   |   2 +-
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi       |   7 +-
 sound/soc/rockchip/Kconfig                         |   2 +
 sound/soc/rockchip/rk3399_gru_sound.c              | 255 +++++++++++++++------
 4 files changed, 186 insertions(+), 80 deletions(-)

-- 
2.11.0
