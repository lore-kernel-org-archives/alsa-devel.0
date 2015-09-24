From: Adam Thomson <Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v2 3/4] ASoC: da7219: Add bindings documentation for DA7219 audio
 codec
Date: Thu, 24 Sep 2015 18:19:54 +0100
Message-ID: <4565872dd2854a249ff2e93f126f2b8b9faf848a.1443113192.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1443113192.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1443113192.git.Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Support Opensource <support.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Jason Coughlan <jason.coughlan-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
---
 Documentation/devicetree/bindings/sound/da7219.txt | 106 +++++++++++++++++++++
 1 file changed, 106 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/da7219.txt

diff --git a/Documentation/devicetree/bindings/sound/da7219.txt b/Documentation/devicetree/bindings/sound/da7219.txt
new file mode 100644
index 0000000..1b70309
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/da7219.txt
@@ -0,0 +1,106 @@
+Dialog Semiconductor DA7219 Audio Codec bindings
+
+DA7219 is an audio codec with advanced accessory detect features.
+
+======
+
+Required properties:
+- compatible : Should be "dlg,da7219"
+- reg: Specifies the I2C slave address
+
+- interrupt-parent : Specifies the phandle of the interrupt controller to which
+  the IRQs from DA7219 are delivered to.
+- interrupts : IRQ line info for DA7219.
+  (See Documentation/devicetree/bindings/interrupt-controller/interrupts.txt for
+   further information relating to interrupt properties)
+
+- VDD-supply: VDD power supply for the device
+- VDDMIC-supply: VDDMIC power supply for the device
+- VDDIO-supply: VDDIO power supply for the device
+  (See Documentation/devicetree/bindings/regulator/regulator.txt for further
+   information relating to regulators)
+
+Optional properties:
+- interrupt-names : Name associated with interrupt line. Should be "wakeup" if
+  interrupt is to be used to wake system, otherwise "irq" should be used.
+- wakeup-source: Flag to indicate this device can wake system (suspend/resume).
+
+- clocks : phandle and clock specifier for codec MCLK.
+- clock-names : Clock name string for 'clocks' attribute, should be "mclk".
+
+- dlg,ldo-lvl : Required internal LDO voltage (mV) level for digital engine
+	[<1050>, <1100>, <1200>, <1400>]
+- dlg,micbias-lvl : Voltage (mV) for Mic Bias
+	[<1800>, <2000>, <2200>, <2400>, <2600>]
+- dlg,mic-amp-in-sel : Mic input source type
+	["diff", "se_p", "se_n"]
+
+======
+
+Child node - 'da7219_aad':
+
+Optional properties:
+- dlg,micbias-pulse-lvl : Mic bias higher voltage pulse level (mV).
+	[<2800>, <2900>]
+- dlg,micbias-pulse-time : Mic bias higher voltage pulse duration (ms)
+- dlg,btn-cfg : Periodic button press measurements for 4-pole jack (ms)
+	[<2>, <5>, <10>, <50>, <100>, <200>, <500>]
+- dlg,mic-det-thr : Impedance threshold for mic detection measurement (Ohms)
+	[<200>, <500>, <750>, <1000>]
+- dlg,jack-ins-deb : Debounce time for jack insertion (ms)
+	[<5>, <10>, <20>, <50>, <100>, <200>, <500>, <1000>]
+- dlg,jack-det-rate: Jack type detection latency (3/4 pole)
+	["32ms_64ms", "64ms_128ms", "128ms_256ms", "256ms_512ms"]
+- dlg,jack-rem-deb : Debounce time for jack removal (ms)
+	[<1>, <5>, <10>, <20>]
+- dlg,a-d-btn-thr : Impedance threshold between buttons A and D
+	[0x0 - 0xFF]
+- dlg,d-b-btn-thr : Impedance threshold between buttons D and B
+	[0x0 - 0xFF]
+- dlg,b-c-btn-thr : Impedance threshold between buttons B and C
+	[0x0 - 0xFF]
+- dlg,c-mic-btn-thr : Impedance threshold between button C and Mic
+	[0x0 - 0xFF]
+- dlg,btn-avg : Number of 8-bit readings for averaged button measurement
+	[<1>, <2>, <4>, <8>]
+- dlg,adc-1bit-rpt : Repeat count for 1-bit button measurement
+	[<1>, <2>, <4>, <8>]
+
+======
+
+Example:
+
+	codec: da7219@1a {
+		compatible = "dlg,da7219";
+		reg = <0x1a>;
+
+		interrupt-parent = <&gpio6>;
+		interrupts = <11 IRQ_TYPE_LEVEL_HIGH>;
+
+		VDD-supply = <&reg_audio>;
+		VDDMIC-supply = <&reg_audio>;
+		VDDIO-supply = <&reg_audio>;
+
+		clocks = <&clks 201>;
+		clock-names = "mclk";
+
+		dlg,ldo-lvl = <1200>;
+		dlg,micbias-lvl = <2600>;
+		dlg,mic-amp-in-sel = "diff";
+
+		da7219_aad {
+			dlg,btn-cfg = <50>;
+			dlg,mic-det-thr = <500>;
+			dlg,jack-ins-deb = <20>;
+			dlg,jack-det-rate = "32ms_64ms";
+			dlg,jack-rem-deb = <1>;
+
+			dlg,a-d-btn-thr = <0xa>;
+			dlg,d-b-btn-thr = <0x16>;
+			dlg,b-c-btn-thr = <0x21>;
+			dlg,c-mic-btn-thr = <0x3E>;
+
+			dlg,btn-avg = <4>;
+			dlg,adc-1bit-rpt = <1>;
+		};
+	};
--
1.9.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
