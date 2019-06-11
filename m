From: Thomas Preston <thomas.preston@codethink.co.uk>
Subject: [PATCH v1 1/4] dt-bindings: ASoC: Add TDA7802 amplifier
Date: Tue, 11 Jun 2019 18:49:06 +0100
Message-ID: <20190611174909.12162-2-thomas.preston@codethink.co.uk>
References: <20190611174909.12162-1-thomas.preston@codethink.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190611174909.12162-1-thomas.preston@codethink.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Charles Keepax <ckeepax@opensource.cirrus.com>, Jerome Brunet <jbrunet@baylibre.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Marco Felsch <m.felsch@pengutronix.de>, Paul Cercueil <paul@crapouillou.net>, Kirill Marinushkin <kmarinushkin@birdec.tech>, Cheng-Yi Chiang <cychiang@chromium.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Vinod Koul <vkoul@kernel.org>, Annaliese McDermond <nh6z@nh6z.net>, Thomas Preston <thomas.preston@codethink.co.uk>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Thomas Preston <thomas.preston@codethink.co.uk>
Cc: Patrick Glaser <pglaser@tesla.com>
Cc: Rob Duncan <rduncan@tesla.com>
Cc: Nate Case <ncase@tesla.com>
---
 .../devicetree/bindings/sound/tda7802.txt          | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/tda7802.txt

diff --git a/Documentation/devicetree/bindings/sound/tda7802.txt b/Documentation/devicetree/bindings/sound/tda7802.txt
new file mode 100644
index 000000000000..f80aaf4f1ba0
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/tda7802.txt
@@ -0,0 +1,26 @@
+ST TDA7802 audio processor
+
+This device supports I2C only.
+
+Required properties:
+
+- compatible : "st,tda7802"
+- reg : the I2C address of the device
+- enable-supply : a regulator spec for the PLLen pin
+
+Optional properties:
+
+- st,gain-ch13 : gain for channels 1 and 3 (range: 1-4)
+- st,gain-ch24 : gain for channels 2 and 3 (range: 1-4)
+- st,diagnostic-mode-ch13 : diagnotic mode for channels 1 and 3
+                            values: "Speaker" (default), "Booster"
+- st,diagnostic-mode-ch24 : diagnotic mode for channels 2 and 4
+                            values: "Speaker" (default), "Booster"
+
+Example:
+
+amp: tda7802@6c {
+	compatible = "st,tda7802";
+	reg = <0x6c>;
+	enable-supply = <&amp_enable_reg>;
+};
-- 
2.11.0
