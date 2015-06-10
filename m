From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH v4 3/3] ASoC: rt5645: add device tree support
Date: Wed, 10 Jun 2015 14:27:58 +0800
Message-ID: <1433917678-13166-3-git-send-email-oder_chiou@realtek.com>
References: <1433917678-13166-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 33F602658BA
 for <alsa-devel@alsa-project.org>; Wed, 10 Jun 2015 08:28:07 +0200 (CEST)
In-Reply-To: <1433917678-13166-1-git-send-email-oder_chiou@realtek.com>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, john.lin@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

Modify the RT5645 driver to parse platform data from device tree.
Write a DT binding document to describe those properties.

Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
* Add hp-detect-gpios' property
---
 Documentation/devicetree/bindings/sound/rt5645.txt | 72 ++++++++++++++++++++++
 1 file changed, 72 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/rt5645.txt

diff --git a/Documentation/devicetree/bindings/sound/rt5645.txt b/Documentation/devicetree/bindings/sound/rt5645.txt
new file mode 100644
index 0000000..7cee1f5
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/rt5645.txt
@@ -0,0 +1,72 @@
+RT5650/RT5645 audio CODEC
+
+This device supports I2C only.
+
+Required properties:
+
+- compatible : One of "realtek,rt5645" or "realtek,rt5650".
+
+- reg : The I2C address of the device.
+
+- interrupts : The CODEC's interrupt output.
+
+Optional properties:
+
+- hp-detect-gpios:
+  a GPIO spec for the external headphone detect pin. If jd-mode = 0,
+  we will get the JD status by getting the value of hp-detect-gpios.
+
+- realtek,in2-differential
+  Boolean. Indicate MIC2 input are differential, rather than single-ended.
+
+- realtek,dmic1-data-pin
+  0: dmic1 is not used
+  1: using IN2P pin as dmic1 data pin
+  2: using GPIO6 pin as dmic1 data pin
+  3: using GPIO10 pin as dmic1 data pin
+  4: using GPIO12 pin as dmic1 data pin
+
+- realtek,dmic2-data-pin
+  0: dmic2 is not used
+  1: using IN2N pin as dmic2 data pin
+  2: using GPIO5 pin as dmic2 data pin
+  3: using GPIO11 pin as dmic2 data pin
+
+-- realtek,jd-mode : The JD mode of rt5645/rt5650
+   0 : rt5645/rt5650 JD function is not used
+   1 : Mode-0 (VDD=3.3V), two port jack detection
+   2 : Mode-1 (VDD=3.3V), one port jack detection
+   3 : Mode-2 (VDD=1.8V), one port jack detection
+
+Pins on the device (for linking into audio routes) for RT5645/RT5650:
+
+  * DMIC L1
+  * DMIC R1
+  * DMIC L2
+  * DMIC R2
+  * IN1P
+  * IN1N
+  * IN2P
+  * IN2N
+  * Haptic Generator
+  * HPOL
+  * HPOR
+  * LOUTL
+  * LOUTR
+  * PDM1L
+  * PDM1R
+  * SPOL
+  * SPOR
+
+Example:
+
+codec: rt5650@1a {
+	compatible = "realtek,rt5650";
+	reg = <0x1a>;
+	hp-detect-gpios = <&gpio 19 0>;
+	interrupt-parent = <&gpio>;
+	interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
+	realtek,dmic-en = "true";
+	realtek,en-jd-func = "true";
+	realtek,jd-mode = <3>;
+};
\ No newline at end of file
-- 
1.8.1.1.439.g50a6b54
