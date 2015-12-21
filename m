From: Caesar Wang <wxt@rock-chips.com>
Subject: [PATCH 2/2] dt-bindings: sound: add devicetree document for rt5616
Date: Mon, 21 Dec 2015 21:18:14 +0800
Message-ID: <1450703894-32623-2-git-send-email-wxt@rock-chips.com>
References: <1450703894-32623-1-git-send-email-wxt@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1450703894-32623-1-git-send-email-wxt@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, broonie@kernel.org
Cc: devicetree@vger.kernel.org, wxt@rock-chips.com, linux-kernel@vger.kernel.org, bardliao@realtek.com, alsa-devel@alsa-project.org, heiko@sntech.de
List-Id: alsa-devel@alsa-project.org

Add the description for rt5616 codec.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
---

 Documentation/devicetree/bindings/sound/rt5616.txt | 38 ++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/rt5616.txt

diff --git a/Documentation/devicetree/bindings/sound/rt5616.txt b/Documentation/devicetree/bindings/sound/rt5616.txt
new file mode 100644
index 0000000..af96207
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/rt5616.txt
@@ -0,0 +1,38 @@
+RT5616 audio CODEC
+
+This device supports I2C only.
+
+Required properties:
+
+- compatible : "realtek,rt5616".
+
+- reg : The I2C address of the device.
+
+Optional properties:
+
+Pins on the device (for linking into audio routes) for RT5616:
+
+  * IN1P
+  * IN2P
+  * IN2N
+  * LOUTL
+  * LOUTR
+  * CPN2
+  * CPP2
+  * CPN1
+  * CPP1
+  * HPO_R
+  * HPO_L
+  * ADCDAT1
+  * DACDAT1
+  * LRCK1
+  * BCLK1
+  * MCLK
+  * GPIO1
+
+Example:
+
+rt5616 {
+	compatible = "realtek,rt5616";
+	reg = <0x1b>;
+};
-- 
1.9.1
