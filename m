From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH v2 1/2] dt-bindings: ASoC: Add Spreadtrum multi-channel data transfer support
Date: Tue, 23 Apr 2019 10:26:21 +0800
Message-ID: <fd223d1dcf5be1f83863e881fa3db931b5c84601.1555917711.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, robh+dt@kernel.org, mark.rutland@arm.com, tiwai@suse.com
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, baolin.wang@linaro.org, orsonzhai@gmail.com, zhang.lyra@gmail.com, devicetree@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Spreadtrum platform, the audio subsystem will use the multi-channel
data transfer controller to transfer sound stream between audio subsystem
and other AP/CP subsystem.

It can support 10 DAC channel and 10 ADC channel, and each channel has
512 bytes depth data fifo. Moreover each channel can be used DMA mode
or interrupt mode to transfer data.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
Changes from v1:
 - Move the documentation into sound/.
---
 .../devicetree/bindings/sound/sprd-mcdt.txt        |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/sprd-mcdt.txt

diff --git a/Documentation/devicetree/bindings/sound/sprd-mcdt.txt b/Documentation/devicetree/bindings/sound/sprd-mcdt.txt
new file mode 100644
index 0000000..274ba0a
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/sprd-mcdt.txt
@@ -0,0 +1,19 @@
+Spreadtrum Multi-Channel Data Transfer Binding
+
+The Multi-channel data transfer controller is used for sound stream
+transmission between audio subsystem and other AP/CP subsystem. It
+supports 10 DAC channel and 10 ADC channel, and each channel can be
+configured with DMA mode or interrupt mode.
+
+Required properties:
+- compatible: Should be "sprd,sc9860-mcdt".
+- reg: Should contain registers address and length.
+- interrupts: Should contain one interrupt shared by all channel.
+
+Example:
+
+mcdt@41490000 {
+	compatible = "sprd,sc9860-mcdt";
+	reg = <0 0x41490000 0 0x170>;
+	interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
+};
-- 
1.7.9.5
