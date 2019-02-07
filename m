From: Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 2/6] dt-bindings: sound: Document jz4725b-codec bindings
Date: Thu,  7 Feb 2019 10:31:39 -0300
Message-ID: <20190207133143.5232-2-paul@crapouillou.net>
References: <20190207133143.5232-1-paul@crapouillou.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190207133143.5232-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
List-Id: alsa-devel@alsa-project.org

Add documentation about how to probe the jz4725b-codec driver from
devicetree.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Changes:

v2: No change

 .../bindings/sound/ingenic,jz4725b-codec.txt         | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/ingenic,jz4725b-codec.txt

diff --git a/Documentation/devicetree/bindings/sound/ingenic,jz4725b-codec.txt b/Documentation/devicetree/bindings/sound/ingenic,jz4725b-codec.txt
new file mode 100644
index 000000000000..05adc0d47b13
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/ingenic,jz4725b-codec.txt
@@ -0,0 +1,20 @@
+Ingenic JZ4725B codec controller
+
+Required properties:
+- compatible : "ingenic,jz4725b-codec"
+- reg : codec registers location and length
+- clocks : phandle to the AIC clock.
+- clock-names: must be set to "aic".
+- #sound-dai-cells: Must be set to 0.
+
+Example:
+
+codec: audio-codec@100200a4 {
+	compatible = "ingenic,jz4725b-codec";
+	reg = <0x100200a4 0x8>;
+
+	#sound-dai-cells = <0>;
+
+	clocks = <&cgu JZ4725B_CLK_AIC>;
+	clock-names = "aic";
+};
-- 
2.11.0
