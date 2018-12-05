From: Jiada Wang <jiada_wang@mentor.com>
Subject: [PATCH linux-next v3 7/7] clk: renesas: Add binding document for ADG
Date: Wed, 5 Dec 2018 16:49:47 +0900
Message-ID: <20181205074947.28151-1-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, kuninori.morimoto.gx@renesas.com, vladimir_zapolskiy@mentor.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, jiada_wang@mentor.com
List-Id: alsa-devel@alsa-project.org

Add device tree bindings for Audio Clock Generator (ADG)
of R-Car Socs.

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 .../clock/renesas,rcar-adg-clocks.txt         | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,rcar-adg-clocks.txt

diff --git a/Documentation/devicetree/bindings/clock/renesas,rcar-adg-clocks.txt b/Documentation/devicetree/bindings/clock/renesas,rcar-adg-clocks.txt
new file mode 100644
index 000000000000..76fc4f8964e9
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/renesas,rcar-adg-clocks.txt
@@ -0,0 +1,24 @@
+* Renesas R-Car Audio Clock Generator (ADG)
+
+The Audio Clock Generator (ADG) is part of R-Car Audio module, it
+selects and supplies the necessary clock for the SSIU, EAVB-IF, SCU,
+ADSP or DTCP module. It also divides the frequency of the selected
+clock and sends it outside the chip.
+
+Required Properties:
+
+  - compatible: Must be one of
+    - "renesas,rcar_sound-gen1" for the R-Car GEN1 SoCs
+    - "renesas,rcar_sound-gen2" for the R-Car GEN2 SoCs
+    - "renesas,rcar_sound-gen3" for the R-Car GEN3 SoCs
+
+  - reg: Base address and length of the memory resource used by the ADG
+
+  - clocks: References to the parent clock S0D1.
+  - clock-names: ADG refer to its parent clock by name "adg".
+  - #clock-cells: Can be 0, 1 or 2
+    - When clock-cells = 0, ADG registers one fixed clock out
+    - When clock-cells = 1, ADG registers 3 fixed clock out
+    - When clock-cells = 2, ADG registers 3 fixed clock out and 8 AVB clocks
+      second clock specifier need to be 0 to refer to fixed clock out, need
+      to be 1 to refer to AVB clocks
-- 
2.19.2
