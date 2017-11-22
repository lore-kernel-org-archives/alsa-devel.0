From: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Subject: [PATCH 3/8] ASoC: uniphier: add DT bindings
	documentation for UniPhier AIO
Date: Wed, 22 Nov 2017 20:43:16 +0900
Message-ID: <20171122114321.29196-4-suzuki.katsuhiro@socionext.com>
References: <20171122114321.29196-1-suzuki.katsuhiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
 by alsa0.perex.cz (Postfix) with ESMTP id 097FA26770D
 for <alsa-devel@alsa-project.org>; Wed, 22 Nov 2017 12:43:08 +0100 (CET)
In-Reply-To: <20171122114321.29196-1-suzuki.katsuhiro@socionext.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>, Jassi Brar <jaswinder.singh@linaro.org>, linux-arm-kernel@lists.infradead.org, Masami Hiramatsu <masami.hiramatsu@linaro.org>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patch adds DT binding documentation for UniPhier
AIO audio subsystem.

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
---
 .../devicetree/bindings/sound/uniphier,aio.txt     | 36 ++++++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/uniphier,aio.txt

diff --git a/Documentation/devicetree/bindings/sound/uniphier,aio.txt b/Documentation/devicetree/bindings/sound/uniphier,aio.txt
new file mode 100644
index 000000000000..73f6c27ae4f7
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/uniphier,aio.txt
@@ -0,0 +1,36 @@
+Socionext UniPhier SoC audio driver
+
+The Socionext UniPhier audio subsystem consists of I2S and S/PDIF blocks in
+the same register space.
+
+Required properties:
+- compatible      : should be one of the following:
+		    "socionext,uniphier-ld11-aio"
+		    "socionext,uniphier-ld20-aio"
+- reg             : offset and length of the register set for the device.
+- interrupts      : should contain I2S or S/PDIF interrupt.
+- pinctrl-names   : should be "default".
+- pinctrl-0       : defined I2S signal pins for an external codec chip.
+- clock-names     : should include following entries:
+                    "aio"
+- clocks          : a list of phandle, should contain an entry for each
+                    entry in clock-names.
+- reset-names     : should include following entries:
+                    "aio"
+- resets          : a list of phandle, should contain an entry for each
+                    entry in reset-names.
+- #sound-dai-cells: should be 1.
+
+Example:
+	audio {
+		compatible = "socionext,uniphier-ld20-aio";
+		reg = <0x56000000 0x80000>;
+		interrupts = <0 144 4>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_aout>;
+		clock-names = "aio";
+		clocks = <&sys_clk 40>;
+		reset-names = "aio";
+		resets = <&sys_rst 40>;
+		#sound-dai-cells = <1>;
+	};
-- 
2.15.0
