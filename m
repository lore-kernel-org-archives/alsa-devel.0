From: Mark Brown <broonie@kernel.org>
Subject: Applied "dt-bindings: ASoC: Add Spreadtrum multi-channel data transfer support" to the asoc tree
Date: Thu, 25 Apr 2019 20:24:34 +0100 (BST)
Message-ID: <20190425192434.368FD441D3C@finisterre.ee.mobilebroadband>
References: <fd223d1dcf5be1f83863e881fa3db931b5c84601.1555917711.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <fd223d1dcf5be1f83863e881fa3db931b5c84601.1555917711.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: alsa-devel@alsa-project.org, baolin.wang@linaro.org, broonie@kernel.org, devicetree@vger.kernel.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.orgMark Brown <broonie@kernel.org>, mark.rutland@arm.com, orsonzhai@gmail.com, perex@perex.cz, robh+dt@kernel.org, tiwai@suse.com, zhang.lyra@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   dt-bindings: ASoC: Add Spreadtrum multi-channel data transfer support

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.2

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From c634d3ffc6b2c3b15ea79ffe0a761ce08b4da71a Mon Sep 17 00:00:00 2001
From: Baolin Wang <baolin.wang@linaro.org>
Date: Tue, 23 Apr 2019 10:26:21 +0800
Subject: [PATCH] dt-bindings: ASoC: Add Spreadtrum multi-channel data transfer
 support

On Spreadtrum platform, the audio subsystem will use the multi-channel
data transfer controller to transfer sound stream between audio subsystem
and other AP/CP subsystem.

It can support 10 DAC channel and 10 ADC channel, and each channel has
512 bytes depth data fifo. Moreover each channel can be used DMA mode
or interrupt mode to transfer data.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/sprd-mcdt.txt   | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/sprd-mcdt.txt

diff --git a/Documentation/devicetree/bindings/sound/sprd-mcdt.txt b/Documentation/devicetree/bindings/sound/sprd-mcdt.txt
new file mode 100644
index 000000000000..274ba0acbfd6
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
2.20.1
