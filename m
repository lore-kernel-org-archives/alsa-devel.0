From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: uniphier: add DT bindings documentation
	for UniPhier EVEA" to the asoc tree
Date: Mon, 04 Dec 2017 18:48:45 +0000
Message-ID: <E1eLvnJ-0000JQ-6S@debutante>
References: <20171122114321.29196-3-suzuki.katsuhiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 0CD372675E9
 for <alsa-devel@alsa-project.org>; Mon,  4 Dec 2017 19:48:49 +0100 (CET)
In-Reply-To: <20171122114321.29196-3-suzuki.katsuhiro@socionext.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Cc: Rob Herring <robh@kernel.org>, alsa-devel@alsa-project.org, Masami Hiramatsu <masami.hiramatsu@linaro.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Mark Brown <broonie@kernel.org>, Jassi Brar <jaswinder.singh@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: uniphier: add DT bindings documentation for UniPhier EVEA

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From e85c8d3e25c09fd9b21ba74e14078ab4c1d977ef Mon Sep 17 00:00:00 2001
From: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Date: Wed, 22 Nov 2017 20:43:15 +0900
Subject: [PATCH] ASoC: uniphier: add DT bindings documentation for UniPhier
 EVEA

This patch adds DT binding documentation for UniPhier EVEA
that is SoC inner sound codec of UniPhier series.

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
