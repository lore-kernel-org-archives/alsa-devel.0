From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH 3/9] ASoC: cs42l56: bindings: sound: Fix reset GPIO name in example DT binding
Date: Wed, 8 Nov 2017 15:24:59 -0600
Message-ID: <20171108212505.28320-4-afd@ti.com>
References: <20171108212505.28320-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171108212505.28320-1-afd@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>
List-Id: alsa-devel@alsa-project.org

The binding states the reset GPIO property shall be named
"cirrus,gpio-nreset" and this is what the driver looks for,
but the example uses "gpio-reset". Fix this here.

Fixes: 3bb40619aca8 ("ASoC: cs42l56: bindings: sound: Add bindings for CS42L56 CODEC")

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 Documentation/devicetree/bindings/sound/cs42l56.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/cs42l56.txt b/Documentation/devicetree/bindings/sound/cs42l56.txt
index 4feb0eb27ea4..4ba520a28ae8 100644
--- a/Documentation/devicetree/bindings/sound/cs42l56.txt
+++ b/Documentation/devicetree/bindings/sound/cs42l56.txt
@@ -55,7 +55,7 @@ Example:
 codec: codec@4b {
 	compatible = "cirrus,cs42l56";
 	reg = <0x4b>;
-	gpio-reset = <&gpio 10 0>;
+	cirrus,gpio-nreset = <&gpio 10 0>;
 	cirrus,chgfreq-divisor = <0x05>;
 	cirrus.ain1_ref_cfg;
 	cirrus,micbias-lvl = <5>;
-- 
2.15.0
