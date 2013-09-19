From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v3 09/11] ARM/dts: am33xx: Add mcasp0 and mcasp1 device tree entries
Date: Thu, 19 Sep 2013 14:29:42 +0300
Message-ID: <62baac083e656dd964690999d493ff5489b4c34d.1379590036.git.jsarha@ti.com>
References: <cover.1379590035.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <cover.1379590035.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, devicetree@vger.kernel.org
Cc: linux-omap@vger.kernel.org, peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, grant.likely@linaro.org, rob.herring@calxeda.com, joelf@ti.com, Pantelis Antoniou <panto@antoniou-consulting.com>, Darren Etheridge <detheridge@ti.com>, Jyri Sarha <jsarha@ti.com>
List-Id: alsa-devel@alsa-project.org

From: Pantelis Antoniou <panto@antoniou-consulting.com>

Add missing mcasp entries in the am33xx.dtsi include file.

Signed-off-by: Pantelis Antoniou <panto@antoniou-consulting.com>
Signed-off-by: Darren Etheridge <detheridge@ti.com>
Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 0fdb949..fe53ce0 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -552,5 +552,24 @@
 			#size-cells = <1>;
 			status = "disabled";
 		};
+
+		mcasp0: mcasp@48038000 {
+			compatible = "ti,omap2-mcasp-audio";
+			ti,hwmods = "mcasp0";
+			reg = <0x48038000 0x2000>;
+			interrupts = <80 81>;
+			interrupts-names = "tx", "rx";
+			status = "disabled";
+		};
+
+		mcasp1: mcasp@4803C000 {
+			compatible = "ti,omap2-mcasp-audio";
+			ti,hwmods = "mcasp1";
+			reg = <0x4803C000 0x2000>;
+			interrupts = <82 83>;
+			interrupts-names = "tx", "rx";
+			status = "disabled";
+		};
+
 	};
 };
-- 
1.7.9.5

