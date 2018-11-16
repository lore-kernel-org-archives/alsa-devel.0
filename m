From: Cheng-Yi Chiang <cychiang@chromium.org>
Subject: [PATCH v2] ASoC: rt5663: Add documentation for power supply support
Date: Fri, 16 Nov 2018 10:12:43 +0800
Message-ID: <20181116021243.179183-1-cychiang@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, oder_chiou@realtek.com, alsa-devel@alsa-project.org, dgreid@chromium.org, tzungbi@chromium.org, Cheng-Yi Chiang <cychiang@chromium.org>
List-Id: alsa-devel@alsa-project.org

rt5663 codec driver will support setting CPVDD and AVDD power supply
from device tree.

Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
---
 Moved power supply properties to required properties.

 Documentation/devicetree/bindings/sound/rt5663.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/rt5663.txt b/Documentation/devicetree/bindings/sound/rt5663.txt
index 23386446c63d6..2a55e91334082 100644
--- a/Documentation/devicetree/bindings/sound/rt5663.txt
+++ b/Documentation/devicetree/bindings/sound/rt5663.txt
@@ -10,6 +10,10 @@ Required properties:
 
 - interrupts : The CODEC's interrupt output.
 
+- avdd-supply: Power supply for AVDD, providing 1.8V.
+
+- cpvdd-supply: Power supply for CPVDD, providing 3.5V.
+
 Optional properties:
 
 - "realtek,dc_offset_l_manual"
@@ -51,4 +55,6 @@ rt5663: codec@12 {
 	compatible = "realtek,rt5663";
 	reg = <0x12>;
 	interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
+	avdd-supply = <&pp1800_a_alc5662>;
+	cpvdd-supply = <&pp3500_a_alc5662>;
 };
-- 
2.19.1.1215.g8438c0b245-goog
