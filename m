From: Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH v9 3/8] ASoC: dt-bindings: add regulator property to simple amplifier
Date: Thu, 22 Nov 2018 18:23:20 +0800
Message-ID: <20181122102325.29495-4-wens@csie.org>
References: <20181122102325.29495-1-wens@csie.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181122102325.29495-1-wens@csie.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Vasily Khoruzhick <anarsoul@gmail.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com, Chen-Yu Tsai <wens@csie.org>
List-Id: alsa-devel@alsa-project.org

From: Vasily Khoruzhick <anarsoul@gmail.com>

Amplifier may have associated regulator, so add a property for it.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 Documentation/devicetree/bindings/sound/simple-amplifier.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/simple-amplifier.txt b/Documentation/devicetree/bindings/sound/simple-amplifier.txt
index 8647edae7af0..7182ac4f1e65 100644
--- a/Documentation/devicetree/bindings/sound/simple-amplifier.txt
+++ b/Documentation/devicetree/bindings/sound/simple-amplifier.txt
@@ -4,9 +4,14 @@ Required properties:
 - compatible : "dioo,dio2125" or "simple-audio-amplifier"
 - enable-gpios : the gpio connected to the enable pin of the simple amplifier
 
+Optional properties:
+- VCC-supply   : power supply for the device, as covered
+                 in Documentation/devicetree/bindings/regulator/regulator.txt
+
 Example:
 
 amp: analog-amplifier {
 	compatible = "simple-audio-amplifier";
+	VCC-supply = <&regulator>;
 	enable-gpios = <&gpio GPIOH_3 0>;
 };
-- 
2.19.1
