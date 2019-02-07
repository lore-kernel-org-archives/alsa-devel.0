From: Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 1/6] dt-bindings: sound: Document jz4740-codec bindings
Date: Thu,  7 Feb 2019 10:31:38 -0300
Message-ID: <20190207133143.5232-1-paul@crapouillou.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
List-Id: alsa-devel@alsa-project.org

Add documentation about how to probe the jz4740-codec driver from
devicetree.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Changes:

v2: No change

 .../bindings/sound/ingenic,jz4740-codec.txt          | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/ingenic,jz4740-codec.txt

diff --git a/Documentation/devicetree/bindings/sound/ingenic,jz4740-codec.txt b/Documentation/devicetree/bindings/sound/ingenic,jz4740-codec.txt
new file mode 100644
index 000000000000..1ffcade87e7b
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/ingenic,jz4740-codec.txt
@@ -0,0 +1,20 @@
+Ingenic JZ4740 codec controller
+
+Required properties:
+- compatible : "ingenic,jz4740-codec"
+- reg : codec registers location and length
+- clocks : phandle to the AIC clock.
+- clock-names: must be set to "aic".
+- #sound-dai-cells: Must be set to 0.
+
+Example:
+
+codec: audio-codec@10020080 {
+	compatible = "ingenic,jz4740-codec";
+	reg = <0x10020080 0x8>;
+
+	#sound-dai-cells = <0>;
+
+	clocks = <&cgu JZ4740_CLK_AIC>;
+	clock-names = "aic";
+};
-- 
2.11.0
