From: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Subject: [PATCH v2 1/2] ASoC: add DT bindings documentation for
	ROHM BD28623 codec
Date: Fri, 23 Feb 2018 10:17:16 +0900
Message-ID: <20180223011717.2799-2-suzuki.katsuhiro@socionext.com>
References: <20180223011717.2799-1-suzuki.katsuhiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
 by alsa0.perex.cz (Postfix) with ESMTP id 2002E267845
 for <alsa-devel@alsa-project.org>; Fri, 23 Feb 2018 02:17:25 +0100 (CET)
In-Reply-To: <20180223011717.2799-1-suzuki.katsuhiro@socionext.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>, Jassi Brar <jaswinder.singh@linaro.org>, linux-arm-kernel@lists.infradead.org, Masami Hiramatsu <masami.hiramatsu@linaro.org>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patch adds DT bindings documentation for ROHM BD28623MUV
class D speaker amplifier.

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>

---

Changes in v2:
  - Change gpio properties to optional
  - Change VCCA, VCCP-supply to mandatory
---
 .../devicetree/bindings/sound/rohm,bd28623.txt     | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/rohm,bd28623.txt

diff --git a/Documentation/devicetree/bindings/sound/rohm,bd28623.txt b/Documentation/devicetree/bindings/sound/rohm,bd28623.txt
new file mode 100644
index 000000000000..d84557c2686e
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/rohm,bd28623.txt
@@ -0,0 +1,29 @@
+ROHM BD28623MUV Class D speaker amplifier for digital input
+
+This codec does not have any control buses such as I2C, it detect format and
+rate of I2S signal automatically. It has two signals that can be connected
+to GPIOs: reset and mute.
+
+Required properties:
+- compatible      : should be "rohm,bd28623"
+- #sound-dai-cells: should be 0.
+- VCCA-supply     : regulator phandle for the VCCA supply
+- VCCP1-supply    : regulator phandle for the VCCP1 supply
+- VCCP2-supply    : regulator phandle for the VCCP2 supply
+
+Optional properties:
+- reset-gpios     : GPIO specifier for the active low reset line
+- mute-gpios      : GPIO specifier for the active low mute line
+
+Example:
+
+	codec {
+		compatible = "rohm,bd28623";
+		#sound-dai-cells = <0>;
+
+		VCCA-supply = <&vcc_reg>;
+		VCCP1-supply = <&vcc_reg>;
+		VCCP2-supply = <&vcc_reg>;
+		reset-gpios = <&gpio 0 GPIO_ACTIVE_LOW>;
+		mute-gpios = <&gpio 1 GPIO_ACTIVE_LOW>;
+	};
-- 
2.16.1
