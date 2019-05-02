From: Fabien Parent <fparent@baylibre.com>
Subject: [PATCH 2/5] dt-bindings: sound: Add MT8516 AFE PCM bindings
Date: Thu,  2 May 2019 14:10:38 +0200
Message-ID: <20190502121041.8045-3-fparent@baylibre.com>
References: <20190502121041.8045-1-fparent@baylibre.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190502121041.8045-1-fparent@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, matthias.bgg@gmail.com, perex@perex.cz, tiwai@suse.com, kaichieh.chuang@mediatek.com, shunli.wang@mediatek.com
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, Fabien Parent <fparent@baylibre.com>
List-Id: alsa-devel@alsa-project.org

Add documentation for the bindings of the MT8516 AFE PCM driver.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 .../bindings/sound/mt8516-afe-pcm.txt         | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/mt8516-afe-pcm.txt

diff --git a/Documentation/devicetree/bindings/sound/mt8516-afe-pcm.txt b/Documentation/devicetree/bindings/sound/mt8516-afe-pcm.txt
new file mode 100644
index 000000000000..c5fb3c55a7f4
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/mt8516-afe-pcm.txt
@@ -0,0 +1,28 @@
+Mediatek AFE PCM controller for mt8516
+
+Required properties:
+- compatible:  "mediatek,mt8516-audio"
+- interrupts: should contain AFE interrupt
+- clocks: Must contain an entry for each entry in clock-names
+- clock-names: should have these clock names:
+		"top_pdn_audio",
+		"aud_dac_clk",
+		"aud_dac_predis_clk",
+		"aud_adc_clk";
+
+Example:
+
+
+	afe: mt8516-afe-pcm@11140000  {
+		compatible = "mediatek,mt8516-audio";
+		reg = <0 0x11140000 0 0x1000>;
+		interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&topckgen CLK_TOP_AUDIO>,
+			 <&audiotop CLK_AUD_DAC>,
+			 <&audiotop CLK_AUD_DAC_PREDIS>,
+			 <&audiotop CLK_AUD_ADC>;
+		clock-names = "top_pdn_audio",
+			      "aud_dac_clk",
+			      "aud_dac_predis_clk",
+			      "aud_adc_clk";
+	};
-- 
2.20.1
