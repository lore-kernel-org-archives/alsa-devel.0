From: Jiada Wang <jiada_wang@mentor.com>
Subject: [PATCH v2 0/5] use extended audio dmac register
Date: Wed, 13 Mar 2019 14:57:15 +0900
Message-ID: <20190313055720.26082-1-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: horms@verge.net.au, magnus.damm@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, kuninori.morimoto.gx@renesas.com, geert@linux-m68k.org
Cc: linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, jiada_wang@mentor.com
List-Id: alsa-devel@alsa-project.org

According to user reference manual for R-CAR H3, M3-W and M3-N SoCs,
in order to access busif4 ~ busif7, extended audio dmac registers
(PDMASAREn, PDMADAREn, PDMACHCREn)
need to be used, rather than basic audio dmac registers
(PDMASARn, PDMADARn, PDMACHCRn)

This patch set updates H3 (= r8a7795), M3-W (= r8a7796) and M3-N (=r8a77965)
to use extended audio dmac registers

R-CAR E3 only has extended register set and is already using it,
rename register set name to indicate this.

---
v2: update rsnd driver to use extended register set when available
    rename R-CAR E3 audio dmac regisetr

v1: initial version

Jiada Wang (5):
  arm64: dts: renesas: r8a7795: add extended audio dmac register
  arm64: dts: renesas: r8a7796: add extended audio dmac register
  arm64: dts: renesas: r8a77965: add extended audio dmac register
  arm64: dts: renesas: r8a77990: rename audio dmac register
  ASoC: rsnd: dma: use extended audio dmac registers when available

 arch/arm64/boot/dts/renesas/r8a7795.dtsi  | 5 +++--
 arch/arm64/boot/dts/renesas/r8a7796.dtsi  | 5 +++--
 arch/arm64/boot/dts/renesas/r8a77965.dtsi | 5 +++--
 arch/arm64/boot/dts/renesas/r8a77990.dtsi | 4 ++--
 sound/soc/sh/rcar/dma.c                   | 5 ++++-
 5 files changed, 15 insertions(+), 9 deletions(-)

-- 
2.19.2
