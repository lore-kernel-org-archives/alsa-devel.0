From: Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [RESENT PATCH v6 0/8] ASoC: rockchip: Parse dai links from dts
Date: Tue, 22 Aug 2017 23:35:47 +0800
Message-ID: <20170822153555.20735-1-jeffy.chen@rock-chips.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dgreid-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org
Cc: briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org


Currently we are using a fixed list of dai links in the driver.
This serial of patches would let the driver parse dai links from
dts, so that we can make some of them optional for future boards.

Tested on my chromebook bob(with cros 4.4 kernel), it still works
after disabled rt5514 codecs in the dts.


Changes in v6:
Add dmic wakeup delay(not used for now).

Changes in v5:
Keep the dmic-delay property, but correct it with the name in
dt-binding.
        -- Suggested-by Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

Changes in v3:
Use compatible to match audio codecs
        -- Suggested-by Matthias Kaehlcke <mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>

Changes in v2:
Let rockchip,codec-names be a required property, because we plan to
add more supported codecs to the fixed dai link list in the driver.

Jeffy Chen (8):
  ASoC: rockchip: Correct 'dmic-delay' property name
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
 sound/soc/rockchip/rk3399_gru_sound.c              | 270 ++++++++++++++-------
 4 files changed, 193 insertions(+), 88 deletions(-)

-- 
2.11.0


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
