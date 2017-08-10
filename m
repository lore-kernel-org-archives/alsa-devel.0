From: Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: [PATCH v5 2/7] dt-bindings: clk: at91: add audio plls to the compatible list
Date: Thu, 10 Aug 2017 08:34:02 +0200
Message-ID: <09230b9714c7d8fee053d1b014ef6af43c1bebbc.1502346448.git-series.quentin.schulz@free-electrons.com>
References: <cover.ada7bc60e0b3a0f7429afc6ea9e4869131d1b757.1502346448.git-series.quentin.schulz@free-electrons.com>
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <cover.ada7bc60e0b3a0f7429afc6ea9e4869131d1b757.1502346448.git-series.quentin.schulz@free-electrons.com>
In-Reply-To: <cover.ada7bc60e0b3a0f7429afc6ea9e4869131d1b757.1502346448.git-series.quentin.schulz@free-electrons.com>
References: <cover.ada7bc60e0b3a0f7429afc6ea9e4869131d1b757.1502346448.git-series.quentin.schulz@free-electrons.com>
Sender: linux-clk-owner@vger.kernel.org
To: mturquette@baylibre.com, sboyd@codeaurora.org, robh+dt@kernel.org, mark.rutland@arm.com, lgirdwood@gmail.com, broonie@kernel.org, nicolas.ferre@microchip.com, alexandre.belloni@free-electrons.com, linux@armlinux.org.uk, boris.brezillon@free-electrons.com, perex@perex.cz, tiwai@suse.com
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, cyrille.pitchen@wedev4u.fr, thomas.petazzoni@free-electrons.com, Quentin Schulz <quentin.schulz@free-electrons.com>
List-Id: alsa-devel@alsa-project.org

This new clock driver set allows to have a fractional divided clock that
would generate a precise clock particularly suitable for audio
applications.

The main audio pll clock has two children clocks: one that is connected
to the PMC, the other that can directly drive a pad. As these two routes
have different enable bits and different dividers and divider formulas,
they are handled by two different drivers.

This adds the audio plls (frac, pad and pmc) to the compatible list of
at91 clocks in DT binding.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 Documentation/devicetree/bindings/clock/at91-clock.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/at91-clock.txt b/Documentation/devicetree/bindings/clock/at91-clock.txt
index 5f3ad65..51c259a 100644
--- a/Documentation/devicetree/bindings/clock/at91-clock.txt
+++ b/Documentation/devicetree/bindings/clock/at91-clock.txt
@@ -81,6 +81,16 @@ Required properties:
 	"atmel,sama5d2-clk-generated":
 		at91 generated clock
 
+	"atmel,sama5d2-clk-audio-pll-frac":
+		at91 audio fractional pll
+
+	"atmel,sama5d2-clk-audio-pll-pad":
+		at91 audio pll CLK_AUDIO output pin
+
+	"atmel,sama5d2-clk-audio-pll-pmc"
+		at91 audio pll output on AUDIOPLLCLK that feeds the PMC
+		and can be used by peripheral clock or generic clock
+
 Required properties for SCKC node:
 - reg : defines the IO memory reserved for the SCKC.
 - #size-cells : shall be 0 (reg is used to encode clk id).
-- 
git-series 0.9.1
