From: <jiada_wang@mentor.com>
Subject: [PATCH linux-next v2 0/9] ASoC: rsnd: support to use different BUSIF for GEN3
Date: Wed, 3 Oct 2018 17:58:46 +0900
Message-ID: <20181003085855.4305-1-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, kuninori.morimoto.gx@renesas.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Jiada Wang <jiada_wang@mentor.com>

Rcar audio DMA/SSIU already support to use different BUSIF to transfer data,
but BUSIF is fixed at 0. This patchset adds busif property to dai stream,
GEN3 series can automatically select BUSIF to transfer data,
based on channel and SSI mode (currently only BUSIF0 is selected).

Device tree files are updated to use extended audio dmac register,
and add dma request number for busif0 ~ busif7 for GEN3.

---
v2:
- Instead of configure BUSIF by kctl interface "SSI Out/In BUSIF",
  use rsnd_ssi_select_busif() to automatically select BUSIF.
- Keep 'rxu/txu' dma request, to keep compatibility with GEN2 series
- Re-order patch-set to satisfy git bisect  

v1: initial version

Jiada Wang (9):
  arm64: r8a7795: add dma request number for busif0 ~ busif7
  arm64: r8a7796: add dma request number for busif0 ~ busif7
  arm64: r8a774a1: add dma request number for busif0 ~ busif7
  arm64: r8a7795: change to use extended audio dmac register
  arm64: r8a7796: change to use extended audio dmac register
  arm64: r8a774a1: change to use extended audio dmac register
  arm64: r8a77965: change to use extended audio dmac register
  ASoC: rsnd: ssi: Request dedicated dma channels for busif0 to 7
  ASoC: rsnd: add busif property to dai stream

 arch/arm64/boot/dts/renesas/r8a774a1.dtsi | 166 +++++++++++++++++++---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi  | 166 +++++++++++++++++++---
 arch/arm64/boot/dts/renesas/r8a7796.dtsi  | 166 +++++++++++++++++++---
 arch/arm64/boot/dts/renesas/r8a77965.dtsi |   2 +-
 sound/soc/sh/rcar/core.c                  |   3 +
 sound/soc/sh/rcar/dma.c                   |  31 ++++
 sound/soc/sh/rcar/rsnd.h                  |   3 +
 sound/soc/sh/rcar/ssi.c                   |  58 +++++++-
 8 files changed, 525 insertions(+), 70 deletions(-)

-- 
2.17.0
