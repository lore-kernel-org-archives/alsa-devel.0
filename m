From: <jiada_wang@mentor.com>
Subject: [PATCH linux-next 00/10] ASoC: rsnd: support to set different busif
Date: Thu, 27 Sep 2018 14:03:57 +0900
Message-ID: <20180927050407.17765-1-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, kuninori.morimoto.gx@renesas.com
Cc: jiada_wang@mentor.com, twischer@de.adit-jv.com, dragos_tarcatu@mentor.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Jiada Wang <jiada_wang@mentor.com>

Rcar audio DMA/SSIU already support to use different BUSIF
to transfer data, but busif is fixed at 0.

This patch set adds kctrl interface "SSI Out/In BUSIF", which enables
to configure busif for each dai-stream used in transfer.

device tree files are updated to use extended audio dmac register,
and add dma request number for busif1 ~ busif7 

Jiada Wang (10):
  ASoC: rsnd: ssi: Request dedicated dma channels for busif1 to 7
  arm64: r8a7795: add dma request number for busif1 ~ busif7
  arm64: r8a7796: add dma request number for busif1 ~ busif7
  arm64: r8a774a1: add dma request number for busif1 ~ busif7
  arm64: r8a7795: change to use extended audio dmac register
  arm64: r8a7796: change to use extended audio dmac register
  arm64: r8a774a1: change to use extended audio dmac register
  arm64: r8a77965: change to use extended audio dmac register
  ASoC: rsnd: add busif property to dai stream
  ASoC: rsnd: Add kctrl to configure dai's busif

 arch/arm64/boot/dts/renesas/r8a774a1.dtsi | 139 ++++++++++++++++++----
 arch/arm64/boot/dts/renesas/r8a7795.dtsi  | 132 +++++++++++++++++---
 arch/arm64/boot/dts/renesas/r8a7796.dtsi  | 138 +++++++++++++++++----
 arch/arm64/boot/dts/renesas/r8a77965.dtsi |   2 +-
 sound/soc/sh/rcar/core.c                  |  16 ++-
 sound/soc/sh/rcar/dma.c                   |  32 +++++
 sound/soc/sh/rcar/rsnd.h                  |   5 +
 sound/soc/sh/rcar/ssi.c                   |  56 +++++++--
 8 files changed, 451 insertions(+), 69 deletions(-)

-- 
2.17.0
