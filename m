From: Andra Danciu <andradanciu1997@gmail.com>
Subject: [PATCH 1/2] dt-bindings: sound: Add bindings for UDA1334 codec
Date: Wed, 31 Jul 2019 14:19:29 +0300
Message-ID: <20190731111930.20230-2-andradanciu1997@gmail.com>
References: <20190731111930.20230-1-andradanciu1997@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190731111930.20230-1-andradanciu1997@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: lgirdwood@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, perex@perex.cz, tiwai@suse.com, ckeepax@opensource.cirrus.com, rf@opensource.wolfsonmicro.com, srinivas.kandagatla@linaro.org, piotrs@opensource.cirrus.com, paul@crapouillou.net, kmarinushkin@birdec.tech, anders.roxell@linaro.org, jbrunet@baylibre.com, m.felsch@pengutronix.de, vkoul@kernel.org, nh6z@nh6z.net, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, daniel.baluta@nxp.com
List-Id: alsa-devel@alsa-project.org

The UDA1334 is an NXP audio codec, supports the I2S-bus data format
and has basic features such as de-emphasis (at 44.1 kHz sampling
rate) and mute. Product information can be found at:
https://www.nxp.com/pages/low-power-audio-dac-with-pll:UDA1334

Cc: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Andra Danciu <andradanciu1997@gmail.com>
---
 Documentation/devicetree/bindings/sound/uda1334.txt | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/uda1334.txt

diff --git a/Documentation/devicetree/bindings/sound/uda1334.txt b/Documentation/devicetree/bindings/sound/uda1334.txt
new file mode 100644
index 000000000000..f64071b25e8d
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/uda1334.txt
@@ -0,0 +1,17 @@
+UDA1334 audio CODEC
+
+This device uses simple GPIO pins for controlling codec settings.
+
+Required properties:
+
+  - compatible : "nxp,uda1334"
+  - nxp,mute-gpios: a GPIO spec for the MUTE pin.
+  - nxp,deemph-gpios: a GPIO spec for the De-emphasis pin
+
+Example:
+
+uda1334: audio-codec {
+	compatible = "nxp,uda1334";
+	nxp,mute-gpios = <&gpio1 8 GPIO_ACTIVE_LOW>;
+	nxp,deemph-gpios = <&gpio3 3 GPIO_ACTIVE_LOW>;
+};
-- 
2.11.0
