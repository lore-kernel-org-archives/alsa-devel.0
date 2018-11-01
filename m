From: Cheng-Yi Chiang <cychiang@chromium.org>
Subject: [PATCH 1/2] CHROMIUM: ASoC: rt5663: Add documentation for power supply support
Date: Thu,  1 Nov 2018 20:40:06 +0800
Message-ID: <20181101124007.243258-1-cychiang@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, oder_chiou@realtek.com, alsa-devel@alsa-project.org, dgreid@chromium.org, Cheng-Yi Chiang <cychiang@chromium.org>
List-Id: alsa-devel@alsa-project.org

rt5663 codec driver will support setting CPVDD and AVDD power supply
from device tree.

Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
---
 Documentation/devicetree/bindings/sound/rt5663.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/rt5663.txt b/Documentation/devicetree/bindings/sound/rt5663.txt
index 23386446c63d6..d4058dfde0392 100644
--- a/Documentation/devicetree/bindings/sound/rt5663.txt
+++ b/Documentation/devicetree/bindings/sound/rt5663.txt
@@ -36,6 +36,9 @@ Optional properties:
   "realtek,impedance_sensing_num" is 2. It means that there are 2 ranges of
   impedance in the impedance sensing function.
 
+- avdd-supply: Power supply for AVDD, providing 1.8V.
+- cpvdd-supply: Power supply for CPVDD, providing 3.5V.
+
 Pins on the device (for linking into audio routes) for RT5663:
 
   * IN1P
@@ -51,4 +54,6 @@ rt5663: codec@12 {
 	compatible = "realtek,rt5663";
 	reg = <0x12>;
 	interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
+	avdd-supply = <&pp1800_a_alc5662>;
+	cpvdd-supply = <&pp3500_a_alc5662>;
 };
-- 
2.19.1.568.g152ad8e336-goog
