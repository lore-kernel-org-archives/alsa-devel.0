From: Katsuhiro Suzuki <katsuhiro@katsuster.net>
Subject: [PATCH v2 3/3] ASoC: es8316: add DT-bindings
Date: Sun,  1 Sep 2019 01:26:50 +0900
Message-ID: <20190831162650.19822-3-katsuhiro@katsuster.net>
References: <20190831162650.19822-1-katsuhiro@katsuster.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190831162650.19822-1-katsuhiro@katsuster.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, David Yang <yangxiaohua@everest-semi.com>, Daniel Drake <drake@endlessm.com>, Hans de Goede <hdegoede@redhat.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Katsuhiro Suzuki <katsuhiro@katsuster.net>
List-Id: alsa-devel@alsa-project.org

This patch adds missing DT-bindings document for Everest ES8316.

Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
---
 .../bindings/sound/everest,es8316.txt         | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/everest,es8316.txt

diff --git a/Documentation/devicetree/bindings/sound/everest,es8316.txt b/Documentation/devicetree/bindings/sound/everest,es8316.txt
new file mode 100644
index 000000000000..aefcff9c48a2
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/everest,es8316.txt
@@ -0,0 +1,20 @@
+Everest ES8316 audio CODEC
+
+This device supports both I2C and SPI.
+
+Required properties:
+
+  - compatible  : should be "everest,es8316"
+  - reg : the I2C address of the device for I2C
+  - clocks : a list of phandle, should contain entries for clock-names
+  - clock-names : should include as follows:
+         "mclk" : master clock (MCLK) of the device
+
+Example:
+
+es8316: codec@11 {
+	compatible = "everest,es8316";
+	reg = <0x11>;
+	clocks = <&clks 10>;
+	clock-names = "mclk";
+};
-- 
2.23.0.rc1
