From: Jun Nie <jun.nie@linaro.org>
Subject: [PATCH v3 1/6] dt: Add documentation for the ZTE SPDIF
	controller
Date: Fri, 29 May 2015 21:31:16 +0800
Message-ID: <1432906281-27698-2-git-send-email-jun.nie@linaro.org>
References: <1432906281-27698-1-git-send-email-jun.nie@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f44.google.com (mail-pa0-f44.google.com
 [209.85.220.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 5B30D2606B2
 for <alsa-devel@alsa-project.org>; Fri, 29 May 2015 15:31:48 +0200 (CEST)
Received: by pacrp13 with SMTP id rp13so13091639pac.2
 for <alsa-devel@alsa-project.org>; Fri, 29 May 2015 06:31:47 -0700 (PDT)
In-Reply-To: <1432906281-27698-1-git-send-email-jun.nie@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, shawn.guo@linaro.org, wan.zhijun@zte.com.cn, Jun Nie <jun.nie@linaro.org>
List-Id: alsa-devel@alsa-project.org

This patch adds the devicetree documentation for the ZTE
zx296702 SPDIF audio controller.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 .../devicetree/bindings/sound/zte,zx-spdif.txt     | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/zte,zx-spdif.txt

diff --git a/Documentation/devicetree/bindings/sound/zte,zx-spdif.txt b/Documentation/devicetree/bindings/sound/zte,zx-spdif.txt
new file mode 100644
index 0000000..989544e
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/zte,zx-spdif.txt
@@ -0,0 +1,28 @@
+ZTE ZX296702 SPDIF controller
+
+Required properties:
+ - compatible : Must be "zte,zx296702-spdif"
+ - reg : Must contain SPDIF core's registers location and length
+ - clocks : Pairs of phandle and specifier referencing the controller's clocks.
+ - clock-names: "tx" for the clock to the SPDIF interface.
+ - dmas: Pairs of phandle and specifier for the DMA channel that is used by
+   the core. The core expects one dma channel for transmit.
+ - dma-names : Must be "tx"
+
+For more details on the 'dma', 'dma-names', 'clock' and 'clock-names' properties
+please check:
+	* resource-names.txt
+	* clock/clock-bindings.txt
+	* dma/dma.txt
+
+Example:
+	spdif0: spdif0@0b004000 {
+		compatible = "zte,zx296702-spdif";
+		reg = <0x0b004000 0x1000>;
+		clocks = <&lsp0clk ZX296702_SPDIF0_DIV>;
+		clock-names = "tx";
+		interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
+		dmas = <&dma 4>;
+		dma-names = "tx";
+		status = "okay";
+	};
-- 
1.9.1
