From: Marcin Wojtas <mw@semihalf.com>
Subject: [PATCH 3/4] ARM: mvebu: add audio support to Armada 385 DB
Date: Wed, 25 Feb 2015 22:58:01 +0100
Message-ID: <1424901482-3809-4-git-send-email-mw@semihalf.com>
References: <y>
 <1424901482-3809-1-git-send-email-mw@semihalf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1424901482-3809-1-git-send-email-mw@semihalf.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: lgirdwood@gmail.com, broonie@kernel.org, jason@lakedaemon.net, andrew@lunn.ch, gregory.clement@free-electrons.com, sebastian.hesselbarth@gmail.com
Cc: thomas.petazzoni@free-electrons.com, alior@marvell.com, alsa-devel@alsa-project.org, tawfik@marvell.com, jaz@semihalf.com, ezequiel.garcia@free-electrons.com, mw@semihalf.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

This commit adds the necessary Device Tree information to enable
audio support on the Armada 385 DB platform. In details it:

 * Instantiates the CS42L51 audio codec on the I2C0 bus

 * Adds simple-card DT binding for audio on Armada 385 DB

 * Adds description for both analog I2S and S/PDIF I/O

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
---
 arch/arm/boot/dts/armada-388-db.dts | 69 +++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/arch/arm/boot/dts/armada-388-db.dts b/arch/arm/boot/dts/armada-388-db.dts
index 16512ef..bf5d9a7 100644
--- a/arch/arm/boot/dts/armada-388-db.dts
+++ b/arch/arm/boot/dts/armada-388-db.dts
@@ -82,6 +82,11 @@
 			i2c@11000 {
 				status = "okay";
 				clock-frequency = <100000>;
+				audio_codec: audio-codec@4a {
+					#sound-dai-cells = <0>;
+					compatible = "cirrus,cs42l51";
+					reg = <0x4a>;
+				};
 			};
 
 			i2c@11100 {
@@ -158,6 +163,12 @@
 				no-1-8-v;
 			};
 
+			audio-controller@e8000 {
+				pinctrl-0 = <&i2s_pins>;
+				pinctrl-names = "default";
+				status = "okay";
+			};
+
 			usb3@f0000 {
 				status = "okay";
 			};
@@ -183,4 +194,62 @@
 			};
 		};
 	};
+
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "Armada 385 DB Audio";
+		simple-audio-card,mclk-fs = <256>;
+		simple-audio-card,widgets =
+			"Headphone", "Out Jack",
+			"Line", "In Jack";
+		simple-audio-card,routing =
+			"Out Jack", "HPL",
+			"Out Jack", "HPR",
+			"AIN1L", "In Jack",
+			"AIN1R", "In Jack";
+		status = "okay";
+
+		simple-audio-card,dai-link@0 {
+			format = "i2s";
+			cpu {
+				sound-dai = <&audio_controller 0>;
+			};
+
+			codec {
+				sound-dai = <&audio_codec>;
+			};
+		};
+
+		simple-audio-card,dai-link@1 {
+			format = "i2s";
+			cpu {
+				sound-dai = <&audio_controller 1>;
+			};
+
+			codec {
+				sound-dai = <&spdif_out>;
+			};
+		};
+
+		simple-audio-card,dai-link@2 {
+			format = "i2s";
+			cpu {
+				sound-dai = <&audio_controller 1>;
+			};
+
+			codec {
+				sound-dai = <&spdif_in>;
+			};
+		};
+	};
+
+	spdif_out: spdif-out {
+		#sound-dai-cells = <0>;
+		compatible = "linux,spdif-dit";
+	};
+
+	spdif_in: spdif-in {
+		#sound-dai-cells = <0>;
+		compatible = "linux,spdif-dir";
+	};
 };
-- 
1.8.3.1
