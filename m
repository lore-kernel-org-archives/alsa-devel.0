From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH 1/2] dt-bindings: ASoC: Add Spreadtrum DMA platform documentation
Date: Tue, 29 Jan 2019 16:04:44 +0800
Message-ID: <15c562bcfd488fbf1979a69f96ddbd8df57f7e69.1548747137.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, perex@perex.cz, tiwai@suse.com
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, baolin.wang@linaro.org
List-Id: alsa-devel@alsa-project.org

Add documentation for Spreadtrum DMA platform driver.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 .../devicetree/bindings/sound/sprd-pcm.txt         |   23 ++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/sprd-pcm.txt

diff --git a/Documentation/devicetree/bindings/sound/sprd-pcm.txt b/Documentation/devicetree/bindings/sound/sprd-pcm.txt
new file mode 100644
index 0000000..4b23e84
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/sprd-pcm.txt
@@ -0,0 +1,23 @@
+* Spreadtrum DMA platfrom bindings
+
+Required properties:
+- compatible: Should be "sprd,pcm-platform".
+- dmas: Specify the list of DMA controller phandle and DMA request line ordered pairs.
+- dma-names: Identifier string for each DMA request line in the dmas property.
+  These strings correspond 1:1 with the ordered pairs in dmas.
+
+Example:
+
+	audio_platform:platform@0 {
+		compatible = "sprd,pcm-platform";
+		dmas = <&agcp_dma 1 1>, <&agcp_dma 2 2>,
+		     <&agcp_dma 3 3>, <&agcp_dma 4 4>,
+		     <&agcp_dma 5 5>, <&agcp_dma 6 6>,
+		     <&agcp_dma 7 7>, <&agcp_dma 8 8>,
+		     <&agcp_dma 9 9>, <&agcp_dma 10 10>;
+		dma-names = "normal_p_l", "normal_p_r",
+			"normal_c_l", "normal_c_r",
+			"voice_c", "fast_p",
+			"loop_c", "loop_p",
+			"voip_c", "voip_p";
+	};
-- 
1.7.9.5
