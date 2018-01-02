From: Ryder Lee <ryder.lee-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 00/12] mediatek: rework audio subsystem driver
Date: Tue, 2 Jan 2018 19:47:09 +0800
Message-ID: <cover.1514881870.git.ryder.lee@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Garlic Tseng <garlic.tseng-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Ryder Lee <ryder.lee-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Hi all,

This patch series mainly adds a common driver [5][6] for the top block of
the MediaTek audio subsystem, which includes clock part and audio components.
This is a minimal driver that manages shared resources like shared registers,
and expose a regmap to its sub-nodes. It was tested on the bananapi-r2 and
the MT2701 EVB.

Also, this driver can be reused by other subsystems (e.g. MMSYS, ETHSYS) in
future patch.

Patch[1]-[4]: rework for audio enable/disable sequences and update some part of
			  code to make them more generic.
Patch[7]~[12]: modify both drivers, audio and clock to adapt the new subsystem.

Ryder Lee (12):
  ASoC: mediatek: fix error handling in mt2701_afe_pcm_dev_probe()
  ASoC: mediatek: rework clock functions for MT2701
  ASoC: mediatek: cleanup audio driver for MT2701
  ASoC: mediatek: update clock related properties of MT2701 AFE
  mfd: mtk-audsys: add MediaTek audio subsystem driver
  mfd: add DT bindings for MedaiTek audio subsystem
  ASoC: mediatek: modify MT2701 AFE driver to adapt subsystem wrapper
  ASoC: mediatek: modify documentation to adapt subsystem wrapper
  clk: mediatek: move part of mtk_clk_register_gates() to the new
    function
  clk: mediatek: switch to use dev_get_regmap() for MT7622 audsys
  clk: mediatek: add audsys support for MT2701
  dt-bindings: clock: mediatek: update audsys bindings to adapt the
    wrapper

 .../bindings/arm/mediatek/mediatek,audsys.txt      |  19 +-
 .../devicetree/bindings/mfd/mtk-audsys.txt         | 109 +++++
 .../devicetree/bindings/sound/mt2701-afe-pcm.txt   | 257 +++++-----
 drivers/clk/mediatek/Kconfig                       |   6 +
 drivers/clk/mediatek/Makefile                      |   1 +
 drivers/clk/mediatek/clk-mt2701-aud.c              | 180 +++++++
 drivers/clk/mediatek/clk-mt7622-aud.c              |  11 +-
 drivers/clk/mediatek/clk-mtk.c                     |  26 +-
 drivers/clk/mediatek/clk-mtk.h                     |   4 +
 drivers/mfd/Kconfig                                |   9 +
 drivers/mfd/Makefile                               |   2 +
 drivers/mfd/mtk-audsys.c                           | 138 ++++++
 include/dt-bindings/clock/mt7622-clk.h             |   3 +-
 sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.c  | 526 +++++++--------------
 sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.h  |  15 +-
 sound/soc/mediatek/mt2701/mt2701-afe-common.h      |  84 +---
 sound/soc/mediatek/mt2701/mt2701-afe-pcm.c         | 212 +++------
 sound/soc/mediatek/mt2701/mt2701-reg.h             |  42 +-
 18 files changed, 860 insertions(+), 784 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/mtk-audsys.txt
 create mode 100644 drivers/clk/mediatek/clk-mt2701-aud.c
 create mode 100644 drivers/mfd/mtk-audsys.c

-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
