From: Matt Porter <mporter@konsulko.com>
Subject: [PATCH 1/2] ASoC: add tda7419 audio processor binding
Date: Tue, 27 Feb 2018 17:51:27 -0500
Message-ID: <20180227225128.17815-2-mporter@konsulko.com>
References: <20180227225128.17815-1-mporter@konsulko.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180227225128.17815-1-mporter@konsulko.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

DeviceTree binding for the tda7419 audio processor.

Signed-off-by: Matt Porter <mporter@konsulko.com>
---
 Documentation/devicetree/bindings/sound/tda7419.txt | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/tda7419.txt

diff --git a/Documentation/devicetree/bindings/sound/tda7419.txt b/Documentation/devicetree/bindings/sound/tda7419.txt
new file mode 100644
index 000000000000..919318315600
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/tda7419.txt
@@ -0,0 +1,15 @@
+TDA7419 audio processor
+
+This device supports I2C only.
+
+Required properties:
+
+- compatible : "st,tda7419"
+- reg : the I2C address of the device.
+
+Example:
+
+ap: tda7419@44 {
+	compatible = "st,tda7419";
+	reg = <0x44>;
+};
-- 
2.11.0
