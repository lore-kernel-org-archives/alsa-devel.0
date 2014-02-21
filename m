From: Jean-Francois Moine <moinejf@free.fr>
Subject: [PATCH 4/4] ASoC: simple-card: add DT documentation for multi-DAI
 links
Date: Fri, 21 Feb 2014 12:43:17 +0100
Message-ID: <c8340c624ab7ec38700523ce4c70b54db92d21e9.1392995566.git.moinejf@free.fr>
References: <cover.1392995566.git.moinejf@free.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1392995566.git.moinejf@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-kernel@vger.kernel.org, Xiubo Li <Li.Xiubo@freescale.com>, devicetree@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

There may be many couples of CPU/CODEC DAI links.
The example 2 is extracted from the Cubox DT.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 .../devicetree/bindings/sound/simple-card.txt      | 34 +++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/simple-card.txt b/Documentation/devicetree/bindings/sound/simple-card.txt
index 0527358..60306bf 100644
--- a/Documentation/devicetree/bindings/sound/simple-card.txt
+++ b/Documentation/devicetree/bindings/sound/simple-card.txt
@@ -24,6 +24,9 @@ Required subnodes:
 - simple-audio-card,cpu			: CPU   sub-node
 - simple-audio-card,codec		: CODEC sub-node
 
+  There may be one or many couples (simple-audio-card,cpu, simple-audio-card,codec)
+  (see example 2).
+
 Required CPU/CODEC subnodes properties:
 
 - sound-dai				: phandle and port of CPU/CODEC
@@ -41,7 +44,7 @@ Optional CPU/CODEC subnodes properties:
 					  clock node (= common clock), or "system-clock-frequency"
 					  (if system doens't support common clock)
 
-Example:
+Example 1:
 
 sound {
 	compatible = "simple-audio-card";
@@ -83,3 +86,32 @@ sh_fsi2: sh_fsi2@ec230000 {
 	interrupt-parent = <&gic>;
 	interrupts = <0 146 0x4>;
 };
+
+Example 2:
+
+sound {
+	compatible = "simple-audio-card";
+	simple-audio-card,name = "Cubox Audio";
+
+	simple-audio-card,cpu@0 {		/* I2S - HDMI */
+		sound-dai = <&audio1 0>;
+		format = "i2s";
+	};
+	simple-audio-card,codec@0 {
+		sound-dai = <&tda998x 0>;
+	};
+
+	simple-audio-card,cpu@1 {		/* S/PDIF - HDMI */
+		sound-dai = <&audio1 1>;
+	};
+	simple-audio-card,codec@1 {
+		sound-dai = <&tda998x 1>;
+	};
+
+	simple-audio-card,cpu@2 {		/* S/PDIF - S/PDIF */
+		sound-dai = <&audio1 1>;
+	};
+	simple-audio-card,codec@2 {
+		sound-dai = <&spdif_codec>;
+	};
+};
-- 
1.9.0
