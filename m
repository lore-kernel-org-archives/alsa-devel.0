From: Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH v9 1/8] ASoC: dt-bindings: sun50i-codec-analog: Add headphone amp regulator supply
Date: Thu, 22 Nov 2018 18:23:18 +0800
Message-ID: <20181122102325.29495-2-wens@csie.org>
References: <20181122102325.29495-1-wens@csie.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181122102325.29495-1-wens@csie.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com, Vasily Khoruzhick <anarsoul@gmail.com>
List-Id: alsa-devel@alsa-project.org

On the Allwinner A64 SoC, the audio codec has a built-in headphone
amplifier. This amplifier has a power supply separate from the rest of
the analog audio circuitry.

Add a regulator supply property to handle this.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 Documentation/devicetree/bindings/sound/sun50i-codec-analog.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/sun50i-codec-analog.txt b/Documentation/devicetree/bindings/sound/sun50i-codec-analog.txt
index 4f8ad0e04d20..056a098495cc 100644
--- a/Documentation/devicetree/bindings/sound/sun50i-codec-analog.txt
+++ b/Documentation/devicetree/bindings/sound/sun50i-codec-analog.txt
@@ -4,9 +4,11 @@ Required properties:
 - compatible: must be one of the following compatibles:
 		- "allwinner,sun50i-a64-codec-analog"
 - reg: must contain the registers location and length
+- cpvdd-supply: Regulator supply for the headphone amplifier
 
 Example:
 	codec_analog: codec-analog@1f015c0 {
 		compatible = "allwinner,sun50i-a64-codec-analog";
 		reg = <0x01f015c0 0x4>;
+		cpvdd-supply = <&reg_eldo1>;
 	};
-- 
2.19.1
