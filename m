From: Jean-Francois Moine <moinejf@free.fr>
Subject: [PARTIAL PATCH 2/3] ASoC: simple-card: Add DT
 documentation for multi-DAI links
Date: Thu, 20 Mar 2014 11:04:16 +0100
Message-ID: <0168bdcc3dac2e6b4c907cec7fb6ddf0f02e1eac.1395312925.git.moinejf@free.fr>
References: <cover.1395312925.git.moinejf@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
 by alsa0.perex.cz (Postfix) with ESMTP id D7FF1265232
 for <alsa-devel@alsa-project.org>; Thu, 20 Mar 2014 12:06:27 +0100 (CET)
In-Reply-To: <cover.1395312925.git.moinejf@free.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jyri Sarha <jsarha@ti.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Many couples of CPU/CODEC DAI links may be described in the DT
thanks to 'simple-audio-card,dai-link' containers.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 .../devicetree/bindings/sound/simple-card.txt      | 42 +++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/simple-card.txt b/Documentation/devicetree/bindings/sound/simple-card.txt
index 881914b1..131aa2a 100644
--- a/Documentation/devicetree/bindings/sound/simple-card.txt
+++ b/Documentation/devicetree/bindings/sound/simple-card.txt
@@ -23,6 +23,11 @@ Optional properties:
 
 Required subnodes:
 
+- simple-audio-card,dai-link		: container for the CPU and CODEC sub-nodes
+					  This container may be omitted when the
+					  card has only one DAI link.
+					  See the examples.
+
 - simple-audio-card,cpu			: CPU   sub-node
 - simple-audio-card,codec		: CODEC sub-node
 
@@ -49,7 +54,7 @@ Note:
    CPU and CODEC sides as we need to keep the settings identical for both ends
    of the link.
 
-Example:
+Example 1 - single DAI link:
 
 sound {
 	compatible = "simple-audio-card";
@@ -94,3 +99,38 @@ sh_fsi2: sh_fsi2@ec230000 {
 	interrupt-parent = <&gic>;
 	interrupts = <0 146 0x4>;
 };
+
+Example 2 - many DAI links:
+
+sound {
+	compatible = "simple-audio-card";
+	simple-audio-card,name = "Cubox Audio";
+	simple-audio-card,format = "i2s";
+
+	simple-audio-card,dai-link@0 {		/* I2S - HDMI */
+		simple-audio-card,cpu {
+			sound-dai = <&audio1 0>;
+		};
+		simple-audio-card,codec {
+			sound-dai = <&tda998x 0>;
+		};
+	};
+
+	simple-audio-card,dai-link@1 {		/* S/PDIF - HDMI */
+		simple-audio-card,cpu {
+			sound-dai = <&audio1 1>;
+		};
+		simple-audio-card,codec {
+			sound-dai = <&tda998x 1>;
+		};
+	};
+
+	simple-audio-card,dai-link@2 {		/* S/PDIF - S/PDIF */
+		simple-audio-card,cpu {
+			sound-dai = <&audio1 1>;
+		};
+		simple-audio-card,codec {
+			sound-dai = <&spdif_codec>;
+		};
+	};
+};
-- 
1.9.1
