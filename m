From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v3 1/7] dt-bindings: sound: sun4i-spdif: Add Allwinner H6 compatible
Date: Sat, 25 May 2019 18:23:17 +0200
Message-ID: <20190525162323.20216-2-peron.clem@gmail.com>
References: <20190525162323.20216-1-peron.clem@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190525162323.20216-1-peron.clem@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Jagan Teki <jagan@amarulasolutions.com>
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>, Rob Herring <robh@kernel.org>
List-Id: alsa-devel@alsa-project.org

Allwinner H6 has a SPDIF controller with an increase of the fifo
size and a sligher difference in memory mapping compare to H3/A64.

This make it not compatible with the previous generation.

Introduce a specific bindings for H6 SoC.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 Documentation/devicetree/bindings/sound/sunxi,sun4i-spdif.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/sunxi,sun4i-spdif.txt b/Documentation/devicetree/bindings/sound/sunxi,sun4i-spdif.txt
index 0c64a209c2e9..c0fbb50a4df9 100644
--- a/Documentation/devicetree/bindings/sound/sunxi,sun4i-spdif.txt
+++ b/Documentation/devicetree/bindings/sound/sunxi,sun4i-spdif.txt
@@ -7,10 +7,11 @@ For now only playback is supported.
 
 Required properties:
 
-  - compatible		: should be one of the following:
+  - compatible		: Should be one of the following:
     - "allwinner,sun4i-a10-spdif": for the Allwinner A10 SoC
     - "allwinner,sun6i-a31-spdif": for the Allwinner A31 SoC
     - "allwinner,sun8i-h3-spdif": for the Allwinner H3 SoC
+    - "allwinner,sun50i-h6-spdif": for the allwinner H6 SoC
 
   - reg			: Offset and length of the register set for the device.
 
-- 
2.20.1
