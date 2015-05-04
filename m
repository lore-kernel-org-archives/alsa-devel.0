From: Kevin Cernekee <cernekee-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH V3 2/4] ASoC: tas571x: Add DT binding document
Date: Sun,  3 May 2015 17:00:17 -0700
Message-ID: <1430697619-22773-3-git-send-email-cernekee@chromium.org>
References: <1430697619-22773-1-git-send-email-cernekee@chromium.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1430697619-22773-1-git-send-email-cernekee-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, dgreid-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, olofj-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Document the bindings for the soon-to-be-added tas571x driver.

Signed-off-by: Kevin Cernekee <cernekee-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
---
 .../devicetree/bindings/sound/tas571x.txt          | 41 ++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/tas571x.txt

diff --git a/Documentation/devicetree/bindings/sound/tas571x.txt b/Documentation/devicetree/bindings/sound/tas571x.txt
new file mode 100644
index 000000000000..0ac31d8d5ac4
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/tas571x.txt
@@ -0,0 +1,41 @@
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
+- AVDD-supply: regulator phandle for the AVDD supply (all chips)
+- DVDD-supply: regulator phandle for the DVDD supply (all chips)
+- HPVDD-supply: regulator phandle for the HPVDD supply (5717/5719)
+- PVDD_AB-supply: regulator phandle for the PVDD_AB supply (5717/5719)
+- PVDD_CD-supply: regulator phandle for the PVDD_CD supply (5717/5719)
+- PVDD_A-supply: regulator phandle for the PVDD_A supply (5711)
+- PVDD_B-supply: regulator phandle for the PVDD_B supply (5711)
+- PVDD_C-supply: regulator phandle for the PVDD_C supply (5711)
+- PVDD_D-supply: regulator phandle for the PVDD_D supply (5711)
+
+Example:
+
+	tas5717: audio-codec@2a {
+		compatible = "ti,tas5717";
+		reg = <0x2a>;
+		#sound-dai-cells = <0>;
+
+		reset-gpios = <&gpio5 1 GPIO_ACTIVE_LOW>;
+		pdn-gpios = <&gpio5 2 GPIO_ACTIVE_LOW>;
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
