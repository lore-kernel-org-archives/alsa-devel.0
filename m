From: Jun Nie <jun.nie@linaro.org>
Subject: [PATCH v3 2/6] dt: Add documentation for the ZTE I2S
	controller
Date: Fri, 29 May 2015 21:31:17 +0800
Message-ID: <1432906281-27698-3-git-send-email-jun.nie@linaro.org>
References: <1432906281-27698-1-git-send-email-jun.nie@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f42.google.com (mail-pa0-f42.google.com
 [209.85.220.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 2AE2F26068F
 for <alsa-devel@alsa-project.org>; Fri, 29 May 2015 15:31:55 +0200 (CEST)
Received: by pabru16 with SMTP id ru16so59685214pab.1
 for <alsa-devel@alsa-project.org>; Fri, 29 May 2015 06:31:53 -0700 (PDT)
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
zx296702 I2S audio controller.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 .../devicetree/bindings/sound/zte,zx-i2s.txt       | 44 ++++++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/zte,zx-i2s.txt

diff --git a/Documentation/devicetree/bindings/sound/zte,zx-i2s.txt b/Documentation/devicetree/bindings/sound/zte,zx-i2s.txt
new file mode 100644
index 0000000..7e5aa6f
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/zte,zx-i2s.txt
@@ -0,0 +1,44 @@
+ZTE ZX296702 I2S controller
+
+Required properties:
+ - compatible : Must be "zte,zx296702-i2s"
+ - reg : Must contain I2S core's registers location and length
+ - clocks : Pairs of phandle and specifier referencing the controller's clocks.
+ - clock-names: "tx" for the clock to the I2S interface.
+ - dmas: Pairs of phandle and specifier for the DMA channel that is used by
+   the core. The core expects two dma channels for transmit.
+ - dma-names : Must be "tx" and "rx"
+
+For more details on the 'dma', 'dma-names', 'clock' and 'clock-names' properties
+please check:
+	* resource-names.txt
+	* clock/clock-bindings.txt
+	* dma/dma.txt
+
+Example:
+	i2s0: i2s0@0b005000 {
+		#sound-dai-cells = <0>;
+		compatible = "zte,zx296702-i2s";
+		reg = <0x0b005000 0x1000>;
+		clocks = <&lsp0clk ZX296702_I2S0_DIV>;
+		clock-names = "tx";
+		interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
+		dmas = <&dma 5>, <&dma 6>;
+		dma-names = "tx", "rx";
+		status = "okay";
+	};
+
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "zx296702_snd";
+		simple-audio-card,format = "left_j";
+		simple-audio-card,bitclock-master = <&sndcodec>;
+		simple-audio-card,frame-master = <&sndcodec>;
+		sndcpu: simple-audio-card,cpu {
+			sound-dai = <&i2s0>;
+		};
+
+		sndcodec: simple-audio-card,codec {
+			sound-dai = <&acodec>;
+		};
+	};
-- 
1.9.1
