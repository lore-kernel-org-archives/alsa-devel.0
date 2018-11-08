From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH 2/2] ASoC: dt-bindings: add bindings for AK4118 transceiver
Date: Thu,  8 Nov 2018 13:49:34 +0100
Message-ID: <20181108124934.32381-2-peron.clem@gmail.com>
References: <20181108124934.32381-1-peron.clem@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181108124934.32381-1-peron.clem@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
List-Id: alsa-devel@alsa-project.org

Document the bindings for AK4118 S/PDIF transceiver

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 .../devicetree/bindings/sound/ak4118.txt      | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/ak4118.txt

diff --git a/Documentation/devicetree/bindings/sound/ak4118.txt b/Documentation/devicetree/bindings/sound/ak4118.txt
new file mode 100644
index 000000000000..6e11a2f7404c
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/ak4118.txt
@@ -0,0 +1,22 @@
+AK4118 S/PDIF transceiver
+
+This device supports I2C mode.
+
+Required properties:
+
+- compatible : "asahi-kasei,ak4118"
+- reg : The I2C address of the device for I2C
+- reset-gpios: A GPIO specifier for the reset pin
+- irq-gpios: A GPIO specifier for the IRQ pin
+
+Example:
+
+&i2c {
+	ak4118: ak4118@13 {
+		#sound-dai-cells = <0>;
+		compatible = "asahi-kasei,ak4118";
+		reg = <0x13>;
+		reset-gpios = <&gpio 0 GPIO_ACTIVE_LOW>
+		irq-gpios = <&gpio 1 GPIO_ACTIVE_HIGH>;
+	};
+};
-- 
2.19.1
