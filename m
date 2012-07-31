From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 17/19] Documentation: Define the MOP500 Audio Machine Driver Device Tree bindings
Date: Tue, 31 Jul 2012 14:39:11 +0100
Message-ID: <1343741953-17828-18-git-send-email-lee.jones@linaro.org>
References: <1343741953-17828-1-git-send-email-lee.jones@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1343741953-17828-1-git-send-email-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, olalilja@yahoo.se, ola.o.lilja@stericsson.com, alsa-devel@alsa-project.org, lrg@ti.com, broonie@opensource.wolfsonmicro.com
Cc: STEricsson_nomadik_linux@list.st.com, linus.walleij@stericsson.com, arnd@arndb.de, Lee Jones <lee.jones@linaro.org>
List-Id: alsa-devel@alsa-project.org

Here we add the required documentation for the new Device Tree
bindings pertaining to the MOP500 Audio Machine driver.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 .../devicetree/bindings/sound/ux500-mop500.txt     |   39 ++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/ux500-mop500.txt

diff --git a/Documentation/devicetree/bindings/sound/ux500-mop500.txt b/Documentation/devicetree/bindings/sound/ux500-mop500.txt
new file mode 100644
index 0000000..0c57063
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/ux500-mop500.txt
@@ -0,0 +1,39 @@
+* MOP500 Audio Machine Driver
+
+This node is responsible for linking together all ux500 Audio Driver components.
+
+Required properties:
+ - compatible                : "stericsson,snd-soc-mop500"
+
+Non-standard properties:
+ - Machine Driver:
+   - stericsson,cpu-dai      : Phandle to the CPU-side DAI
+   - stericsson,audio-codec  : Phandle to the Audio CODEC
+
+Example:
+
+	sound {
+		compatible = "stericsson,snd-soc-mop500";
+
+		stericsson,cpu-dai = <&msp1 &msp3>;
+		stericsson,audio-codec = <&codec>;
+	};
+
+	msp1: msp@80124000 {
+		compatible = "stericsson,ux500-msp-i2s";
+		reg = <0x80124000 0x1000>;
+		interrupts = <0 62 0x4>;
+		v-ape-supply = <&db8500_vape_reg>;
+	};
+
+	msp3: msp@80125000 {
+		compatible = "stericsson,ux500-msp-i2s";
+		reg = <0x80125000 0x1000>;
+		interrupts = <0 62 0x4>;
+		v-ape-supply = <&db8500_vape_reg>;
+	};
+
+	codec: ab8500-codec {
+		compatible = "stericsson,ab8500-codec";
+		stericsson,earpeice-cmv = <950>; /* Units in mV. */
+	};
-- 
1.7.9.5
