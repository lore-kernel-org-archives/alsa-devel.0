From: Marcin Wojtas <mw@semihalf.com>
Subject: [PATCH 2/4] ARM: mvebu: add audio I2S controller to Armada 38x Device
 Tree
Date: Wed, 25 Feb 2015 22:58:00 +0100
Message-ID: <1424901482-3809-3-git-send-email-mw@semihalf.com>
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

This commit adds the description of the I2S controller to the Marvell
Armada 38x SoC's Device Tree, as well as its pin configuration.

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
---
 arch/arm/boot/dts/armada-38x.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
index 1dff30a..fa21cb5 100644
--- a/arch/arm/boot/dts/armada-38x.dtsi
+++ b/arch/arm/boot/dts/armada-38x.dtsi
@@ -314,6 +314,12 @@
 					marvell,pins = "mpp44";
 					marvell,function = "sata3";
 				};
+
+				i2s_pins: i2s_pins {
+					marvell,pins = "mpp48", "mpp49", "mpp50",
+						       "mpp51", "mpp52", "mpp53";
+					marvell,function = "audio";
+				};
 			};
 
 			gpio0: gpio@18100 {
@@ -555,6 +561,17 @@
 				status = "disabled";
 			};
 
+			audio_controller: audio-controller@e8000 {
+				#sound-dai-cells = <1>;
+				compatible = "marvell,armada-380-audio";
+				reg = <0xe8000 0x4000>, <0x18410 0xc>, <0x18204 0x4>;
+				reg-names = "i2s_regs", "pll_regs", "soc_ctrl";
+				interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&gateclk 0>;
+				clock-names = "internal";
+				status = "disabled";
+			};
+
 			usb3@f0000 {
 				compatible = "marvell,armada-380-xhci";
 				reg = <0xf0000 0x4000>,<0xf4000 0x4000>;
-- 
1.8.3.1
