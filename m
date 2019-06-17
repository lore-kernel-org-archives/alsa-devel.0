From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] dt-bindings: Add missing newline at end of file
Date: Mon, 17 Jun 2019 16:33:22 +0200
Message-ID: <20190617143322.4332-1-geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: openbmc@lists.ozlabs.org, openipmi-developer@lists.sourceforge.net, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: alsa-devel@alsa-project.org

"git diff" says:

    \ No newline at end of file

after modifying the files.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/ipmi/npcm7xx-kcs-bmc.txt      | 2 +-
 .../devicetree/bindings/pinctrl/nuvoton,npcm7xx-pinctrl.txt     | 2 +-
 Documentation/devicetree/bindings/regulator/pv88060.txt         | 2 +-
 Documentation/devicetree/bindings/sound/cs42l73.txt             | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/ipmi/npcm7xx-kcs-bmc.txt b/Documentation/devicetree/bindings/ipmi/npcm7xx-kcs-bmc.txt
index 3538a214fff156d4..352f5e9c759bc3f5 100644
--- a/Documentation/devicetree/bindings/ipmi/npcm7xx-kcs-bmc.txt
+++ b/Documentation/devicetree/bindings/ipmi/npcm7xx-kcs-bmc.txt
@@ -36,4 +36,4 @@ Example:
             kcs_chan = <2>;
             status = "disabled";
         };
-    };
\ No newline at end of file
+    };
diff --git a/Documentation/devicetree/bindings/pinctrl/nuvoton,npcm7xx-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/nuvoton,npcm7xx-pinctrl.txt
index 83f4bbac94bb19db..a1264cc8660dcd59 100644
--- a/Documentation/devicetree/bindings/pinctrl/nuvoton,npcm7xx-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/nuvoton,npcm7xx-pinctrl.txt
@@ -213,4 +213,4 @@ pinctrl: pinctrl@f0800000 {
 		groups = "clkreq";
 		function = "clkreq";
 	};
-};
\ No newline at end of file
+};
diff --git a/Documentation/devicetree/bindings/regulator/pv88060.txt b/Documentation/devicetree/bindings/regulator/pv88060.txt
index 10a6dadc008eb38d..6a7c8a92fdb0bf1c 100644
--- a/Documentation/devicetree/bindings/regulator/pv88060.txt
+++ b/Documentation/devicetree/bindings/regulator/pv88060.txt
@@ -121,4 +121,4 @@ Example
 				regulator-max-microvolt = <5000000>;
 			};
 		};
-	};
\ No newline at end of file
+	};
diff --git a/Documentation/devicetree/bindings/sound/cs42l73.txt b/Documentation/devicetree/bindings/sound/cs42l73.txt
index 80ae910dbf6c3880..47b868b5ab011470 100644
--- a/Documentation/devicetree/bindings/sound/cs42l73.txt
+++ b/Documentation/devicetree/bindings/sound/cs42l73.txt
@@ -19,4 +19,4 @@ codec: cs42l73@4a {
 	reg = <0x4a>;
 	reset_gpio = <&gpio 10 0>;
 	chgfreq = <0x05>;
-};
\ No newline at end of file
+};
-- 
2.17.1
