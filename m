From: <Paul.Handrigan-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 2/3] ASoC: cs35l34: Add device tree bindings file for cs35l34
Date: Wed, 12 Oct 2016 13:53:29 -0500
Message-ID: <9581bbdd-b3b1-4230-8321-46942f3dfd09@EX3.ad.cirrus.com>
References: <1476298410-1157-1-git-send-email-Paul.Handrigan@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1476298410-1157-1-git-send-email-Paul.Handrigan-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Paul Handrigan <Paul.Handrigan-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

From: Paul Handrigan <Paul.Handrigan-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>

Add device tree bindings file for the cs35l34 8V boosted
class D amplifier.

Signed-off-by: Paul Handrigan <Paul.Handrigan-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
---
 .../devicetree/bindings/sound/cs35l34.txt          | 64 ++++++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/cs35l34.txt

diff --git a/Documentation/devicetree/bindings/sound/cs35l34.txt b/Documentation/devicetree/bindings/sound/cs35l34.txt
new file mode 100644
index 0000000..b218ead
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/cs35l34.txt
@@ -0,0 +1,64 @@
+CS35L34 Speaker Amplifier
+
+Required properties:
+
+  - compatible : "cirrus,cs35l34"
+
+  - reg : the I2C address of the device for I2C.
+
+  - VA-supply, VP-supply : power supplies for the device,
+    as covered in
+    Documentation/devicetree/bindings/regulator/regulator.txt.
+
+  - cirrus,boost-vtge-millivolt : Boost Voltage Value.  Configures the boost
+    converter's output voltage in mV. The range is from VP to 8V with
+    increments of 100mV.
+
+  - cirrus,boost-nanohenry: Inductor value for boost converter. The value is
+    in nH and they can be values of 1000nH, 1100nH, 1200nH, 1500nH, and 2200nH.
+
+Optional properties:
+
+  - reset-gpios: GPIO used to reset the amplifier.
+
+  - interrupt-parent : Specifies the phandle of the interrupt controller to
+    which the IRQs from CS35L34 are delivered to.
+  - interrupts : IRQ line info CS35L34.
+    (See Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
+    for further information relating to interrupt properties)
+
+  - cirrus,boost-peak-milliamp : Boost converter peak current limit in mA. The
+    range starts at 1200mA and goes to a maximum of 3840mA with increments of
+    80mA. The default value is 2480mA.
+
+  - cirrus,i2s-sdinloc : ADSP SDIN I2S channel location. Indicates whether the
+    received mono data is in the left or right portion of the I2S frame
+    according to the AD0 pin or directly via this configuration.
+    0x0 (Default) = Selected by AD0 input (if AD0 = LOW, use left channel),
+    0x2 = Left,
+    0x1 = Selected by the inversion of the AD0 input (if AD0 = LOW, use right
+    channel),
+    0x3 = Right.
+
+  - cirrus,gain-zc-disable: Boolean property. If set, the gain change will take
+    effect without waiting for a zero cross.
+
+  - cirrus,tdm-rising-edge: Boolean property. If set, data is on the rising edge of
+    SCLK. Otherwise, data is on the falling edge of SCLK.
+
+
+Example:
+
+cs35l34: cs35l34@40 {
+	compatible = "cirrus,cs35l34";
+	reg = <0x40>;
+
+	interrupt-parent = <&gpio8>;
+	interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
+
+	reset-gpios = <&gpio 10 0>;
+
+	cirrus,boost-vtge-milltvolt = <8000>; /* 8V */
+	cirrus,boost-ind-nanohenry = <1000>; /* 1uH */
+	cirrus,boost-peak-milliamp = <3000>; /* 3A */
+};
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
