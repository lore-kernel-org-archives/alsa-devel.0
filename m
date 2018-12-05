From: Jiada Wang <jiada_wang@mentor.com>
Subject: [PATCH linux-next v3 0/7] clk: renesas: adg: add AVB Clock
Date: Wed, 5 Dec 2018 16:48:12 +0900
Message-ID: <20181205074819.27944-1-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, kuninori.morimoto.gx@renesas.com, vladimir_zapolskiy@mentor.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, jiada_wang@mentor.com
List-Id: alsa-devel@alsa-project.org

on R-Car SoCs there are AVB Counter Clocks, each clock has 12bits integral
and 8 bits fractional dividers which operates with S0D1ϕ clock.

This patch-set adds 'adg' clock to R-Car Soc, and changes adg driver to
register avb clocks when clock-cells of rcar_sound node is 2.

---
v3:
- Removed clock id header file, added device tree bindings documentation
  instead to describe clock id
- Instead of hardcode parent clock name in adg driver,
  refer to parent clock via clock specifier in device tree with 'adg' name
- Added patch to add ADG in r8a77965
- Some other fixes

v2:
- expends adg register size and register avb clocks instead of
  add new clk-avb driver
- Add adg clock 

v1: initial version

Jiada Wang (2):
  ASoC: rsnd: add avb clocks
  clk: renesas: Add binding document for ADG

Takeshi Kihara (5):
  clk: renesas: r8a7795: Add ADG clock
  clk: renesas: r8a7796: Add ADG clock
  clk: renesas: r8a77990: Add ADG clock
  clk: renesas: r8a77995: Add ADG clock
  clk: renesas: r8a77965: Add ADG clock

 .../clock/renesas,rcar-adg-clocks.txt         |  24 ++
 drivers/clk/renesas/r8a7795-cpg-mssr.c        |   1 +
 drivers/clk/renesas/r8a7796-cpg-mssr.c        |   1 +
 drivers/clk/renesas/r8a77965-cpg-mssr.c       |   1 +
 drivers/clk/renesas/r8a77990-cpg-mssr.c       |   1 +
 drivers/clk/renesas/r8a77995-cpg-mssr.c       |   1 +
 sound/soc/sh/rcar/adg.c                       | 316 +++++++++++++++++-
 sound/soc/sh/rcar/gen.c                       |   9 +
 sound/soc/sh/rcar/rsnd.h                      |   9 +
 9 files changed, 354 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,rcar-adg-clocks.txt

-- 
2.19.2
