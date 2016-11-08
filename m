From: Peter Rosin <peda@axentia.se>
Subject: [PATCH 1/2] dt-bindings: sound: document axentia,tse850-pcm5142 bindings
Date: Tue, 8 Nov 2016 17:20:56 +0100
Message-ID: <1478622057-12426-2-git-send-email-peda@axentia.se>
References: <1478622057-12426-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1478622057-12426-1-git-send-email-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The TSE-850 is an FM Transmitter Station Equipment, designed to generate
baseband signals for FM, mainly the DARC subcarrier, but other signals
are also possible.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 .../bindings/sound/axentia,tse850-pcm5142.txt      | 88 ++++++++++++++++++++++
 MAINTAINERS                                        |  6 ++
 2 files changed, 94 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/axentia,tse850-pcm5142.txt

diff --git a/Documentation/devicetree/bindings/sound/axentia,tse850-pcm5142.txt b/Documentation/devicetree/bindings/sound/axentia,tse850-pcm5142.txt
new file mode 100644
index 000000000000..0c2d44fda17e
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/axentia,tse850-pcm5142.txt
@@ -0,0 +1,88 @@
+ASoC driver for the Axentia TSE-850 with a PCM5142 codec
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
index 539b20baf791..4f2ebf3ab51a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2318,6 +2318,12 @@ F:	include/uapi/linux/ax25.h
 F:	include/net/ax25.h
 F:	net/ax25/
 
+AXENTIA ASOC DRIVERS
+M:	Peter Rosin <peda@axentia.se>
+L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+S:	Maintained
+F:	Documentation/devicetree/bindings/sound/axentia,*
+
 AZ6007 DVB DRIVER
 M:	Mauro Carvalho Chehab <mchehab@s-opensource.com>
 M:	Mauro Carvalho Chehab <mchehab@kernel.org>
-- 
2.1.4
