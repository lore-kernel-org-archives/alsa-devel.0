From: Songjun Wu <songjun.wu@atmel.com>
Subject: [PATCH 2/2] ASoC: atmel-classd: DT binding for Class D audio amplifier driver
Date: Tue, 1 Sep 2015 13:41:41 +0800
Message-ID: <1441086101-15303-3-git-send-email-songjun.wu@atmel.com>
References: <1441086101-15303-1-git-send-email-songjun.wu@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1441086101-15303-1-git-send-email-songjun.wu@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: nicolas.ferre@atmel.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org
Cc: Songjun Wu <songjun.wu@atmel.com>
List-Id: alsa-devel@alsa-project.org

DT binding documentation for this new ASoC driver.

Signed-off-by: Songjun Wu <songjun.wu@atmel.com>
---
 .../devicetree/bindings/sound/atmel-classd.txt     |   73 ++++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/atmel-classd.txt

diff --git a/Documentation/devicetree/bindings/sound/atmel-classd.txt b/Documentation/devicetree/bindings/sound/atmel-classd.txt
new file mode 100644
index 0000000..29d181a
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/atmel-classd.txt
@@ -0,0 +1,73 @@
+* Atmel ClassD driver under ALSA SoC architecture
+
+* Atmel ClassD driver
+Required properties:
+- compatible
+	Should be "atmel,sama5d2-classd".
+- reg
+	Should contain ClassD registers location and length.
+- interrupts
+	Should contain the IRQ line for the ClassD.
+- dmas
+	One DMA specifiers as described in atmel-dma.txt and dma.txt files.
+- dma-names
+	Must be "tx".
+- clock-names
+	tuple listing input clock names.
+	Required elements: "pclk", "gclk" and "aclk".
+- clocks
+	phandles to input clocks.
+
+Optional properties:
+- pinctrl-names, pinctrl-0
+	Please refer to pinctrl-bindings.txt.
+- atmel,pwm-type
+	PWM modulation type, "single" or "diff".
+- atmel,non-overlap-time
+	Set non-overlapping time, the unit is nanosecond(ns).
+	There are four values,
+	<5>, <10>, <15>, <20>, the default value is <10>.
+	Non-overlapping will be disabled if not specified.
+
+Example:
+classd: classd@fc048000 {
+		compatible = "atmel,sama5d2-classd";
+		reg = <0xfc048000 0x100>;
+		interrupts = <59 IRQ_TYPE_LEVEL_HIGH 7>;
+		dmas = <&dma0
+			(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
+			| AT91_XDMAC_DT_PERID(47))>;
+		dma-names = "tx";
+		clocks = <&classd_clk>, <&classd_gclk>, <&audio_pll_pmc>;
+		clock-names = "pclk", "gclk", "aclk";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_classd_default>;
+		atmel,pwm-type = "diff";
+		atmel,non-overlap-time = <10>;
+};
+
+
+* Atmel ASoC driver with ClassD
+Required properties:
+- compatible
+	Should be "atmel,asoc-classd".
+- atmel,model
+	The user-visible name of this sound complex.
+- atmel,audio-platform
+	Should be <&classd>.
+- atmel,audio-cpu-dai-name
+	The name of the CPU DAI in ALSA SoC architecture.
+	The format is <classd registers location>.classd.
+- atmel,audio-codec
+	Should be <&classd>.
+
+Example:
+sound {
+		compatible = "atmel,asoc-classd";
+
+		atmel,model = "classd @ SAMA5D2-Xplained";
+		atmel,audio-platform = <&classd>;
+		atmel,audio-cpu-dai-name = "fc048000.classd";
+		atmel,audio-codec = <&classd>;
+};
-- 
1.7.9.5
