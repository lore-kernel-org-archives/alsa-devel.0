From: Fabien Parent <fparent@baylibre.com>
Subject: [PATCH 0/5] ASoC: mediatek: Add basic PCM driver for MT8516
Date: Thu,  2 May 2019 14:10:36 +0200
Message-ID: <20190502121041.8045-1-fparent@baylibre.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, matthias.bgg@gmail.com, perex@perex.cz, tiwai@suse.com, kaichieh.chuang@mediatek.com, shunli.wang@mediatek.com
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, Fabien Parent <fparent@baylibre.com>
List-Id: alsa-devel@alsa-project.org

This patch series add a basic PCM driver for MediaTek MT8516 with only
support for ADDA Playback & Recording for now.

Fabien Parent (5):
  ASoC: mediatek: make agent_disable, msb & hd fields optional
  dt-bindings: sound: Add MT8516 AFE PCM bindings
  ASoC: mediatek: Add MT8516 PCM driver
  ASoC: mediatek: mt8516: Add ADDA DAI driver
  ASoC: mediatek: mt8516: register ADDA DAI

 .../bindings/sound/mt8516-afe-pcm.txt         |  28 +
 sound/soc/mediatek/Kconfig                    |  10 +
 sound/soc/mediatek/Makefile                   |   1 +
 sound/soc/mediatek/common/mtk-afe-fe-dai.c    |  23 +-
 sound/soc/mediatek/mt8516/Makefile            |   7 +
 sound/soc/mediatek/mt8516/mt8516-afe-common.h |  18 +
 sound/soc/mediatek/mt8516/mt8516-afe-pcm.c    | 794 ++++++++++++++++++
 sound/soc/mediatek/mt8516/mt8516-afe-regs.h   | 218 +++++
 sound/soc/mediatek/mt8516/mt8516-dai-adda.c   | 316 +++++++
 9 files changed, 1406 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/mt8516-afe-pcm.txt
 create mode 100644 sound/soc/mediatek/mt8516/Makefile
 create mode 100644 sound/soc/mediatek/mt8516/mt8516-afe-common.h
 create mode 100644 sound/soc/mediatek/mt8516/mt8516-afe-pcm.c
 create mode 100644 sound/soc/mediatek/mt8516/mt8516-afe-regs.h
 create mode 100644 sound/soc/mediatek/mt8516/mt8516-dai-adda.c

-- 
2.20.1
