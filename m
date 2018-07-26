From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 2/3] ASoC: meson: update axg sound card bindings
Date: Thu, 26 Jul 2018 14:45:43 +0200
Message-ID: <20180726124544.14740-3-jbrunet@baylibre.com>
References: <20180726124544.14740-1-jbrunet@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180726124544.14740-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>, Rob Herring <robh@kernel.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Remove the amlogic prefix in front of the generic properties and change
the card 'name' property to 'model'

Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../bindings/sound/amlogic,axg-sound-card.txt | 68 +++++++++----------
 1 file changed, 34 insertions(+), 34 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-sound-card.txt b/Documentation/devicetree/bindings/sound/amlogic,axg-sound-card.txt
index 39e005da0407..80b411296480 100644
--- a/Documentation/devicetree/bindings/sound/amlogic,axg-sound-card.txt
+++ b/Documentation/devicetree/bindings/sound/amlogic,axg-sound-card.txt
@@ -3,19 +3,19 @@ Amlogic AXG sound card:
 Required properties:
 
 - compatible: "amlogic,axg-sound-card"
-- amlogic,name : User specified audio sound card name, one string
+- model : User specified audio sound card name, one string
 
 Optional properties:
 
-- amlogic,aux-devs : List of phandles pointing to auxiliary devices
-- amlogic,widgets : Please refer to widgets.txt.
-- amlogic,routing : A list of the connections between audio components.
+- audio-aux-devs : List of phandles pointing to auxiliary devices
+- audio-widgets : Please refer to widgets.txt.
+- audio-routing : A list of the connections between audio components.
 
 Subnodes:
 
-- amlogic,dai-link: Container for dai-link level properties and the
-		    CODEC sub-nodes. There should be at least one (and
-		    probably) subnode of this type.
+- dai-link: Container for dai-link level properties and the CODEC
+	    sub-nodes. There should be at least one (and probably more)
+	    subnode of this type.
 
 Required dai-link properties:
 
@@ -57,38 +57,38 @@ Example:
 
 sound {
 	compatible = "amlogic,axg-sound-card";
-	amlogic,name = "AXG-S420";
-	amlogic,aux-devs = <&tdmin_a>, <&tdmout_c>;
-	amlogic,widgets = "Line", "Lineout",
-			  "Line", "Linein",
-			  "Speaker", "Speaker1 Left",
-			  "Speaker", "Speaker1 Right";
-			  "Speaker", "Speaker2 Left",
-			  "Speaker", "Speaker2 Right";
-	amlogic,routing = "TDMOUT_C IN 0", "FRDDR_A OUT 2",
-			  "SPDIFOUT IN 0", "FRDDR_A OUT 3",
-			  "TDM_C Playback", "TDMOUT_C OUT",
-			  "TDMIN_A IN 2", "TDM_C Capture",
-			  "TDMIN_A IN 5", "TDM_C Loopback",
-			  "TODDR_A IN 0", "TDMIN_A OUT",
-			  "Lineout", "Lineout AOUTL",
-			  "Lineout", "Lineout AOUTR",
-			  "Speaker1 Left", "SPK1 OUT_A",
-			  "Speaker2 Left", "SPK2 OUT_A",
-			  "Speaker1 Right", "SPK1 OUT_B",
-			  "Speaker2 Right", "SPK2 OUT_B",
-			  "Linein AINL", "Linein",
-			  "Linein AINR", "Linein";
-
-	amlogic,dai-link@0 {
+	model = "AXG-S420";
+	audio-aux-devs = <&tdmin_a>, <&tdmout_c>;
+	audio-widgets = "Line", "Lineout",
+			"Line", "Linein",
+			"Speaker", "Speaker1 Left",
+			"Speaker", "Speaker1 Right";
+			"Speaker", "Speaker2 Left",
+			"Speaker", "Speaker2 Right";
+	audio-routing = "TDMOUT_C IN 0", "FRDDR_A OUT 2",
+			"SPDIFOUT IN 0", "FRDDR_A OUT 3",
+			"TDM_C Playback", "TDMOUT_C OUT",
+			"TDMIN_A IN 2", "TDM_C Capture",
+			"TDMIN_A IN 5", "TDM_C Loopback",
+			"TODDR_A IN 0", "TDMIN_A OUT",
+			"Lineout", "Lineout AOUTL",
+			"Lineout", "Lineout AOUTR",
+			"Speaker1 Left", "SPK1 OUT_A",
+			"Speaker2 Left", "SPK2 OUT_A",
+			"Speaker1 Right", "SPK1 OUT_B",
+			"Speaker2 Right", "SPK2 OUT_B",
+			"Linein AINL", "Linein",
+			"Linein AINR", "Linein";
+
+	dai-link@0 {
 		sound-dai = <&frddr_a>;
 	};
 
-	amlogic,dai-link@1 {
+	dai-link@1 {
 		sound-dai = <&toddr_a>;
 	};
 
-	amlogic,dai-link@2 {
+	dai-link@2 {
 		sound-dai = <&tdmif_c>;
 		dai-format = "i2s";
 		dai-tdm-slot-tx-mask-2 = <1 1>;
@@ -114,7 +114,7 @@ sound {
 
 	};
 
-	amlogic,dai-link@4 {
+	dai-link@3 {
 		sound-dai = <&spdifout>;
 
 		codec {
-- 
2.17.1
