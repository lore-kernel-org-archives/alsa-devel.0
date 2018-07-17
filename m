From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 07/15] ASoC: meson: add axg tdm formatters DT bindings documentation
Date: Tue, 17 Jul 2018 17:36:33 +0200
Message-ID: <20180717153643.8806-10-jbrunet@baylibre.com>
References: <20180717153643.8806-1-jbrunet@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180717153643.8806-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Add the DT bindings documentation for axg's TDM formatters: TDMIN
and TDMOUT.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../bindings/sound/amlogic,axg-tdm-formatters.txt  | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-tdm-formatters.txt

diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-formatters.txt b/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-formatters.txt
new file mode 100644
index 000000000000..1c1b7490554e
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-formatters.txt
@@ -0,0 +1,28 @@
+* Amlogic Audio TDM formatters
+
+Required properties:
+- compatible: 'amlogic,axg-tdmin' or
+	      'amlogic,axg-tdmout'
+- reg: physical base address of the controller and length of memory
+       mapped region.
+- clocks: list of clock phandle, one for each entry clock-names.
+- clock-names: should contain the following:
+  * "pclk"     : peripheral clock.
+  * "sclk"     : bit clock.
+  * "sclk_sel" : bit clock input multiplexer.
+  * "lrclk"    : sample clock
+  * "lrclk_sel": sample clock input multiplexer
+
+Example of TDMOUT_A on the A113 SoC:
+
+tdmout_a: audio-controller@500 {
+	compatible = "amlogic,axg-tdmout";
+	reg = <0x0 0x500 0x0 0x40>;
+	clocks = <&clkc_audio AUD_CLKID_TDMOUT_A>,
+		 <&clkc_audio AUD_CLKID_TDMOUT_A_SCLK>,
+		 <&clkc_audio AUD_CLKID_TDMOUT_A_SCLK_SEL>,
+		 <&clkc_audio AUD_CLKID_TDMOUT_A_LRCLK>,
+		 <&clkc_audio AUD_CLKID_TDMOUT_A_LRCLK>;
+	clock-names = "pclk", "sclk", "sclk_sel",
+		      "lrclk", "lrclk_sel";
+};
-- 
2.14.4
