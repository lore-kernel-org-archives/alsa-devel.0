From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tse850: document axentia,tse850-pcm5142 bindings" to the asoc tree
Date: Fri, 18 Nov 2016 12:01:43 +0000
Message-ID: <E1c7hrT-0005Ev-6V@debutante>
References: <1479235095-13441-3-git-send-email-peda@axentia.se>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1479235095-13441-3-git-send-email-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tse850: document axentia,tse850-pcm5142 bindings

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From c821d30148caab01f2559980ed322667e2919b99 Mon Sep 17 00:00:00 2001
From: Peter Rosin <peda@axentia.se>
Date: Tue, 15 Nov 2016 19:38:14 +0100
Subject: [PATCH] ASoC: tse850: document axentia,tse850-pcm5142 bindings

The TSE-850 is an FM Transmitter Station Equipment, designed to generate
baseband signals for FM, mainly the DARC subcarrier, but other signals
are also possible.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Peter Rosin <peda@axentia.se>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
index 1cd38a7e0064..35485fd86e73 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2317,6 +2317,12 @@ F:	include/uapi/linux/ax25.h
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
2.10.2
