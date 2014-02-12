From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH v2 5/7] ARM: mvebu: add audio support to Armada
	370 DB
Date: Wed, 12 Feb 2014 18:21:00 +0100
Message-ID: <1392225662-20431-6-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1392225662-20431-1-git-send-email-thomas.petazzoni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.free-electrons.com (top.free-electrons.com [176.31.233.9])
 by alsa0.perex.cz (Postfix) with ESMTP id 1AB9126163C
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2014 18:21:07 +0100 (CET)
In-Reply-To: <1392225662-20431-1-git-send-email-thomas.petazzoni@free-electrons.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jason Cooper <jason@lakedaemon.net>, Gregory Clement <gregory.clement@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Lior Amsalem <alior@marvell.com>, alsa-devel@alsa-project.org, Tawfik Bayouk <tawfik@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

This commit adds the necessary Device Tree informations to enable
audio support on the Armada 370 DB platform. In details it:

 * Instantiates the CS42L51 audio codec on the I2C0 bus, and
   configures this bus with the appropriate pin-muxing configuration.

 * Enables the I2S audio controller, and configures it with the
   appropriate pin-muxing configuration.

 * Through hog pins, ensures that the other pins possibly used for I2S
   are muxed with another function than I2S.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-db.dts | 48 +++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm/boot/dts/armada-370-db.dts b/arch/arm/boot/dts/armada-370-db.dts
index 08a56bc..7df1866 100644
--- a/arch/arm/boot/dts/armada-370-db.dts
+++ b/arch/arm/boot/dts/armada-370-db.dts
@@ -64,6 +64,22 @@
 				phy-mode = "rgmii-id";
 			};
 
+			i2c@11000 {
+				pinctrl-0 = <&i2c0_pins>;
+				pinctrl-names = "default";
+				status = "okay";
+				audio_codec: audio-codec@4a {
+					compatible = "cirrus,cs42l51";
+					reg = <0x4a>;
+				};
+			};
+
+			audio-controller@30000 {
+				pinctrl-0 = <&i2s_pins2>;
+				pinctrl-names = "default";
+				status = "okay";
+			};
+
 			mvsdio@d4000 {
 				pinctrl-0 = <&sdio_pins1>;
 				pinctrl-names = "default";
@@ -80,6 +96,30 @@
 				broken-cd;
 			};
 
+			pinctrl {
+				/*
+				 * These pins might be muxed as I2S by
+				 * the bootloader, but it conflicts
+				 * with the real I2S pins that are
+				 * muxed using i2s_pins. We must mux
+				 * those pins to a function other than
+				 * I2S.
+				 */
+				pinctrl-0 = <&hog_pins1 &hog_pins2>;
+				pinctrl-names = "default";
+
+				hog_pins1: hog-pins1 {
+					marvell,pins = "mpp6",  "mpp8", "mpp10",
+						       "mpp12", "mpp13";
+					marvell,function = "gpio";
+				};
+
+				hog_pins2: hog-pins2 {
+					marvell,pins = "mpp5", "mpp7", "mpp9";
+					marvell,function = "gpo";
+				};
+			};
+
 			usb@50000 {
 				status = "okay";
 			};
@@ -112,10 +152,18 @@
 				/* Port 0, Lane 0 */
 				status = "okay";
 			};
+
 			pcie@2,0 {
 				/* Port 1, Lane 0 */
 				status = "okay";
 			};
 		};
 	};
+
+	sound {
+	      compatible = "marvell,a370db-audio";
+	      marvell,audio-controller = <&audio_controller>;
+	      marvell,audio-codec = <&audio_codec>;
+	      status = "okay";
+	};
 };
-- 
1.8.3.2
