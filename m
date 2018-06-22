From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH v2 1/2] ALSA: ac97: add bus binding for codecs
Date: Fri, 22 Jun 2018 21:28:33 +0200
Message-ID: <20180622192834.7797-1-robert.jarzmik@free.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Robert Jarzmik <robert.jarzmik@free.fr>
List-Id: alsa-devel@alsa-project.org

Add the generic ac97 bus binding, especially for ac97 codecs discovered
by ac97 hardware probing.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 .../devicetree/bindings/sound/ac97-bus.txt         | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/ac97-bus.txt

diff --git a/Documentation/devicetree/bindings/sound/ac97-bus.txt b/Documentation/devicetree/bindings/sound/ac97-bus.txt
new file mode 100644
index 000000000000..103c428f2595
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/ac97-bus.txt
@@ -0,0 +1,32 @@
+Generic AC97 Device Properties
+
+This documents describes the devicetree bindings for an ac97 controller child
+node describing ac97 codecs.
+
+Required properties:
+-compatible : Must be "ac97,vendor_id1,vendor_id2
+	      The ids shall be the 4 characters hexadecimal encoding, such as
+	      given by "%04x" formatting of printf
+-reg	    : Must be the ac97 codec number, between 0 and 3
+
+Example:
+ac97: sound@40500000 {
+	compatible = "marvell,pxa270-ac97";
+	reg = < 0x40500000 0x1000 >;
+	interrupts = <14>;
+	reset-gpios = <&gpio 95 GPIO_ACTIVE_HIGH>;
+	#sound-dai-cells = <1>;
+	pinctrl-names = "default";
+	pinctrl-0 = < &pinctrl_ac97_default >;
+	clocks = <&clks CLK_AC97>, <&clks CLK_AC97CONF>;
+	clock-names = "AC97CLK", "AC97CONFCLK";
+
+	#address-cells = <1>;
+	#size-cells = <0>;
+	audio-codec@0 {
+		reg = <0>;
+		compatible = "ac97,574d,4c13";
+		clocks = <&fixed_wm9713_clock>;
+		clock-names = "ac97_clk";
+	}
+};
-- 
2.11.0
