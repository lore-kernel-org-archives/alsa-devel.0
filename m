From: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Subject: [PATCH 2/8] ASoC: uniphier: add DT bindings
	documentation for UniPhier EVEA
Date: Wed, 22 Nov 2017 20:43:15 +0900
Message-ID: <20171122114321.29196-3-suzuki.katsuhiro@socionext.com>
References: <20171122114321.29196-1-suzuki.katsuhiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
 by alsa0.perex.cz (Postfix) with ESMTP id EE6F826770C
 for <alsa-devel@alsa-project.org>; Wed, 22 Nov 2017 12:43:07 +0100 (CET)
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

This patch adds DT binding documentation for UniPhier EVEA
that is SoC inner sound codec of UniPhier series.

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
---
 .../devicetree/bindings/sound/uniphier,evea.txt    | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/uniphier,evea.txt

diff --git a/Documentation/devicetree/bindings/sound/uniphier,evea.txt b/Documentation/devicetree/bindings/sound/uniphier,evea.txt
new file mode 100644
index 000000000000..3f31b235f18b
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/uniphier,evea.txt
@@ -0,0 +1,26 @@
+Socionext EVEA - UniPhier SoC internal codec driver
+
+Required properties:
+- compatible      : should be "socionext,uniphier-evea".
+- reg             : offset and length of the register set for the device.
+- clock-names     : should include following entries:
+                    "evea", "exiv"
+- clocks          : a list of phandle, should contain an entry for each
+                    entries in clock-names.
+- reset-names     : should include following entries:
+                    "evea", "exiv", "adamv"
+- resets          : a list of phandle, should contain reset entries of
+                    reset-names.
+- #sound-dai-cells: should be 1.
+
+Example:
+
+	codec {
+		compatible = "socionext,uniphier-evea";
+		reg = <0x57900000 0x1000>;
+		clock-names = "evea", "exiv";
+		clocks = <&sys_clk 41>, <&sys_clk 42>;
+		reset-names = "evea", "exiv", "adamv";
+		resets = <&sys_rst 41>, <&sys_rst 42>, <&adamv_rst 0>;
+		#sound-dai-cells = <1>;
+	};
-- 
2.15.0
