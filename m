From: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Subject: [PATCH v4 2/3] ASoC: tse850: document axentia,tse850-pcm5142 bindings
Date: Tue, 15 Nov 2016 19:38:14 +0100
Message-ID: <1479235095-13441-3-git-send-email-peda@axentia.se>
References: <1479235095-13441-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1479235095-13441-1-git-send-email-peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

The TSE-850 is an FM Transmitter Station Equipment, designed to generate
baseband signals for FM, mainly the DARC subcarrier, but other signals
are also possible.

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
---
 .../bindings/sound/axentia,tse850-pcm5142.txt      | 88 ++++++++++++++++++++++
 MAINTAINERS                                        |  6 ++
 2 files changed, 94 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/axentia,tse850-pcm5142.txt

diff --git a/Documentation/devicetree/bindings/sound/axentia,tse850-pcm5142.txt b/Documentation/devicetree/bindings/sound/axentia,tse850-pcm5142.txt
new file mode 100644
index 000000000000..5b9b38f578bb
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/axentia,tse850-pcm5142.txt
@@ -0,0 +1,88 @@
+Devicetree bindings for the Axentia TSE-850 audio complex
+
+Required properties:
+  - compatible: "axentia,tse850-pcm5142"
+  - axentia,ssc-controller: The phandle of the atmel SSC controller used as
+    cpu dai.
+  - axentia,audio-codec: The phandle of the PCM5142 codec.
+  - axentia,add-gpios: gpio specifier that controls the mixer.
+  - axentia,loop1-gpios: gpio specifier that controls loop relays on channel 1.
+  - axentia,loop2-gpios: gpio specifier that controls loop relays on channel 2.
+  - axentia,ana-supply: Regulator that supplies the output amplifier. Must
+    support voltages in the 2V - 20V range, in 1V steps.
+
+The schematics explaining the gpios are as follows:
+
+               loop1 relays
+   IN1 +---o  +------------+  o---+ OUT1
+            \                /
+             +              +
+             |   /          |
+             +--o  +--.     |
+             |  add   |     |
+             |        V     |
+             |      .---.   |
+   DAC +----------->|Sum|---+
+             |      '---'   |
+             |              |
+             +              +
+
+   IN2 +---o--+------------+--o---+ OUT2
+               loop2 relays
+
+The 'loop1' gpio pin controlls two relays, which are either in loop position,
+meaning that input and output are directly connected, or they are in mixer
+position, meaning that the signal is passed through the 'Sum' mixer. Similarly
+for 'loop2'.
+
+In the above, the 'loop1' relays are inactive, thus feeding IN1 to the mixer
+(if 'add' is active) and feeding the mixer output to OUT1. The 'loop2' relays
+are active, short-cutting the TSE-850 from channel 2. IN1, IN2, OUT1 and OUT2
+are TSE-850 connectors and DAC is the PCB name of the (filtered) output from
+the PCM5142 codec.
+
+Example:
+
+	&i2c {
+		codec: pcm5142@4c {
+			compatible = "ti,pcm5142";
+
+			reg = <0x4c>;
+
+			AVDD-supply = <&reg_3v3>;
+			DVDD-supply = <&reg_3v3>;
+			CPVDD-supply = <&reg_3v3>;
+
+			clocks = <&sck>;
+
+			pll-in = <3>;
+			pll-out = <6>;
+		};
+	};
+
+	ana: ana-reg {
+		compatible = "pwm-regulator";
+
+		regulator-name = "ANA";
+
+		pwms = <&pwm0 2 1000 PWM_POLARITY_INVERTED>;
+		pwm-dutycycle-unit = <1000>;
+		pwm-dutycycle-range = <100 1000>;
+
+		regulator-min-microvolt = <2000000>;
+		regulator-max-microvolt = <20000000>;
+		regulator-ramp-delay = <1000>;
+	};
+
+	sound {
+		compatible = "axentia,tse850-pcm5142";
+
+		axentia,ssc-controller = <&ssc0>;
+		axentia,audio-codec = <&codec>;
+
+		axentia,add-gpios = <&pioA 8 GPIO_ACTIVE_LOW>;
+		axentia,loop1-gpios = <&pioA 10 GPIO_ACTIVE_LOW>;
+		axentia,loop2-gpios = <&pioA 11 GPIO_ACTIVE_LOW>;
+
+		axentia,ana-supply = <&ana>;
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index 851b89b9edcb..e6bf00e53bf3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2318,6 +2318,12 @@ F:	include/uapi/linux/ax25.h
 F:	include/net/ax25.h
 F:	net/ax25/
 
+AXENTIA ASOC DRIVERS
+M:	Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
+L:	alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org (moderated for non-subscribers)
+S:	Maintained
+F:	Documentation/devicetree/bindings/sound/axentia,*
+
 AZ6007 DVB DRIVER
 M:	Mauro Carvalho Chehab <mchehab-JsYNTwtnfakRB7SZvlqPiA@public.gmane.org>
 M:	Mauro Carvalho Chehab <mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
