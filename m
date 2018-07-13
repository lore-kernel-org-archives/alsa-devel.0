From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 1/2] ASoC: add DT documentation for the sound-name-prefix property
Date: Fri, 13 Jul 2018 14:50:42 +0200
Message-ID: <20180713125043.13242-2-jbrunet@baylibre.com>
References: <20180713125043.13242-1-jbrunet@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180713125043.13242-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../devicetree/bindings/sound/name-prefix.txt      | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/name-prefix.txt

diff --git a/Documentation/devicetree/bindings/sound/name-prefix.txt b/Documentation/devicetree/bindings/sound/name-prefix.txt
new file mode 100644
index 000000000000..645775908657
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/name-prefix.txt
@@ -0,0 +1,24 @@
+Name prefix:
+
+Card implementing the routing property define the connection between
+audio components as list of string pair. Component using the same
+sink/source names may use the name prefix property to prepend the
+name of their sinks/sources with the provided string.
+
+Optional name prefix property:
+- sound-name-prefix : string using as prefix for the sink/source names of
+		      the component.
+
+Example: Two instances of the same component.
+
+amp0: analog-amplifier@0 {
+	compatible = "simple-audio-amplifier";
+	enable-gpios = <&gpio GPIOH_3 0>;
+	sound-name-prefix = "FRONT";
+};
+
+amp1: analog-amplifier@1 {
+	compatible = "simple-audio-amplifier";
+	enable-gpios = <&gpio GPIOH_4 0>;
+	sound-name-prefix = "BACK";
+};
-- 
2.14.4
