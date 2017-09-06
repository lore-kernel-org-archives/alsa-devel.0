From: Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: [PATCH v9 1/2] ASoC: rt5514: Add devicetree bindings
	for rt5514-spi
Date: Wed,  6 Sep 2017 10:41:08 +0800
Message-ID: <20170906024109.9978-1-jeffy.chen@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from regular1.263xmail.com (regular1.263xmail.com [211.150.99.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 40B3B26734C
 for <alsa-devel@alsa-project.org>; Wed,  6 Sep 2017 04:41:39 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org, dgreid@chromium.org, heiko@sntech.de
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, briannorris@chromium.org, Mark Brown <broonie@kernel.org>, Jeffy Chen <jeffy.chen@rock-chips.com>, dianders@chromium.org, Rob Herring <robh+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, mka@chromium.org
List-Id: alsa-devel@alsa-project.org

Add devicetree bindings documentation file for rt5514 spi dsp codec.

Also update rt5514 i2c dt-binding's compatible to distinguish it from
rt5514 spi.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v9:
Address comments from Brian.

 .../devicetree/bindings/sound/rt5514-spi.txt       | 29 ++++++++++++++++++++++
 Documentation/devicetree/bindings/sound/rt5514.txt |  4 +--
 2 files changed, 31 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/rt5514-spi.txt

diff --git a/Documentation/devicetree/bindings/sound/rt5514-spi.txt b/Documentation/devicetree/bindings/sound/rt5514-spi.txt
new file mode 100644
index 000000000000..7911d1adbd29
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/rt5514-spi.txt
@@ -0,0 +1,29 @@
+RT5514 SPI audio CODEC
+
+This device supports SPI only.
+
+Required properties:
+
+- compatible : "realtek,rt5514" or "realtek,rt5514", "realtek,rt5514-spi".
+
+- reg : The SPI address of the device.
+
+Optional properties:
+
+- interrupt-parent: Should be the phandle for the interrupt controller
+- interrupts: The interrupt number to the cpu. The interrupt specifier format
+	      depends on the interrupt controller.
+
+Example:
+
+codec: rt5514-spi@0 {
+	compatible = "realtek,rt5514", "realtek,rt5514-spi";
+	reg = <0>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&mic_int>;
+
+	interrupt-parent = <&gpio1>;
+	interrupts = <13 IRQ_TYPE_LEVEL_HIGH>;
+	wakeup-source;
+};
diff --git a/Documentation/devicetree/bindings/sound/rt5514.txt b/Documentation/devicetree/bindings/sound/rt5514.txt
index 929ca6756b02..841a1159e234 100644
--- a/Documentation/devicetree/bindings/sound/rt5514.txt
+++ b/Documentation/devicetree/bindings/sound/rt5514.txt
@@ -4,7 +4,7 @@ This device supports I2C only.
 
 Required properties:
 
-- compatible : "realtek,rt5514".
+- compatible : "realtek,rt5514" or "realtek,rt5514", "realtek,rt5514-i2c".
 
 - reg : The I2C address of the device.
 
@@ -28,6 +28,6 @@ Pins on the device (for linking into audio routes) for RT5514:
 Example:
 
 codec: rt5514@57 {
-	compatible = "realtek,rt5514";
+	compatible = "realtek,rt5514", "realtek,rt5514-i2c";
 	reg = <0x57>;
 };
-- 
2.11.0
