From: Kevin Cernekee <cernekee-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 1/3] ASoC: tas571x: Add DT binding document
Date: Wed, 15 Apr 2015 14:42:19 -0700
Message-ID: <1429134141-17924-1-git-send-email-cernekee@chromium.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: dgreid-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, olofj-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Document the bindings for the soon-to-be-added tas571x driver.

Signed-off-by: Kevin Cernekee <cernekee-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
---
 .../devicetree/bindings/sound/tas571x.txt          | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/tas571x.txt

diff --git a/Documentation/devicetree/bindings/sound/tas571x.txt b/Documentation/devicetree/bindings/sound/tas571x.txt
new file mode 100644
index 000000000000..ac704c1f143d
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/tas571x.txt
@@ -0,0 +1,34 @@
+Texas Instruments TAS5711/TAS5717/TAS5719 stereo power amplifiers
+
+The codec is controlled through an I2C interface.  It also has two other
+signals that can be wired up to GPIOs: reset (strongly recommended), and
+powerdown (optional).
+
+Required properties:
+
+- compatible: "ti,tas5711", "ti,tas5717", or "ti,tas5719"
+- reg: The I2C address of the device
+- #sound-dai-cells: must be equal to 0
+
+Optional properties:
+
+- reset-gpios: GPIO specifier for the TAS571x's active low reset line
+- pdn-gpios: GPIO specifier for the TAS571x's active low powerdown line
+- clocks: clock phandle for the MCLK input
+- clock-names: should be "mclk"
+- VDD-supply: regulator phandle for the AVDD/DVDD/HP_VDD supply
+- PVDD-supply: regulator phandle for the PVDD supply
+
+Example:
+
+	tas5717: audio-codec@2a {
+		compatible = "ti,tas5717";
+		reg = <0x2a>;
+		#sound-dai-cells = <0>;
+
+		reset-gpios = <&gpio5 1 GPIO_ACTIVE_HIGH>;
+		pdn-gpios = <&gpio5 2 GPIO_ACTIVE_HIGH>;
+
+		clocks = <&clk_core CLK_I2S>;
+		clock-names = "mclk";
+	};
-- 
2.2.0.rc0.207.ga3a616c

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
