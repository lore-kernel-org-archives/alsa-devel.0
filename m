From: olivier moysan <olivier.moysan@st.com>
Subject: [PATCH v2 1/2] ASoC: stm32: Add DT bindings for
	SPDIFRX interface
Date: Tue, 20 Jun 2017 11:58:46 +0200
Message-ID: <1497952727-16720-2-git-send-email-olivier.moysan@st.com>
References: <1497952727-16720-1-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id A9A912672B2
 for <alsa-devel@alsa-project.org>; Tue, 20 Jun 2017 11:58:55 +0200 (CEST)
In-Reply-To: <1497952727-16720-1-git-send-email-olivier.moysan@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, olivier.moysan@st.com
Cc: arnaud.pouliquen@st.com, benjamin.gaignard@st.com
List-Id: alsa-devel@alsa-project.org

Add documentation of device tree bindings for the
STM32 SPDIFRX interface.

Signed-off-by: olivier moysan <olivier.moysan@st.com>
---
 .../devicetree/bindings/sound/st,stm32-spdifrx.txt | 56 ++++++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/st,stm32-spdifrx.txt

diff --git a/Documentation/devicetree/bindings/sound/st,stm32-spdifrx.txt b/Documentation/devicetree/bindings/sound/st,stm32-spdifrx.txt
new file mode 100644
index 0000000..33826f2
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/st,stm32-spdifrx.txt
@@ -0,0 +1,56 @@
+STMicroelectronics STM32 S/PDIF receiver (SPDIFRX).
+
+The SPDIFRX peripheral, is designed to receive an S/PDIF flow compliant with
+IEC-60958 and IEC-61937.
+
+Required properties:
+  - compatible: should be "st,stm32h7-spdifrx"
+  - reg: cpu DAI IP base address and size
+  - clocks: must contain an entry for kclk (used as S/PDIF signal reference)
+  - clock-names: must contain "kclk"
+  - interrupts: cpu DAI interrupt line
+  - dmas: DMA specifiers for audio data DMA and iec control flow DMA
+    See STM32 DMA bindings, Documentation/devicetree/bindings/dma/stm32-dma.txt
+  - dma-names: two dmas have to be defined, "rx" and "rx-ctrl"
+
+Optional properties:
+  - resets: Reference to a reset controller asserting the SPDIFRX
+
+The device node should contain one 'port' child node with one child 'endpoint'
+node, according to the bindings defined in Documentation/devicetree/bindings/
+graph.txt.
+
+Example:
+spdifrx: spdifrx@40004000 {
+	compatible = "st,stm32h7-spdifrx";
+	reg = <0x40004000 0x400>;
+	clocks = <&rcc SPDIFRX_CK>;
+	clock-names = "kclk";
+	interrupts = <97>;
+	dmas = <&dmamux1 2 93 0x400 0x0>,
+	       <&dmamux1 3 94 0x400 0x0>;
+	dma-names = "rx", "rx-ctrl";
+	pinctrl-0 = <&spdifrx_pins>;
+	pinctrl-names = "default";
+
+	spdifrx_port: port {
+		cpu_endpoint: endpoint {
+			remote-endpoint = <&codec_endpoint>;
+		};
+	};
+};
+
+spdif_in: spdif-in {
+	compatible = "linux,spdif-dir";
+
+	codec_port: port {
+		codec_endpoint: endpoint {
+			remote-endpoint = <&cpu_endpoint>;
+		};
+	};
+};
+
+soundcard {
+	compatible = "audio-graph-card";
+	dais = <&spdifrx_port>;
+};
-- 
1.9.1
