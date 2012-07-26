From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 11/21] ARM: ux500: Add all encompassing Sound node to DB8500 Device Tree
Date: Thu, 26 Jul 2012 11:28:44 +0100
Message-ID: <1343298534-13611-12-git-send-email-lee.jones@linaro.org>
References: <1343298534-13611-1-git-send-email-lee.jones@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1343298534-13611-1-git-send-email-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: STEricsson_nomadik_linux@list.st.com, linus.walleij@stericsson.com, arnd@arndb.de, broonie@opensource.wolfsonmicro.com, sameo@linux.intel.com, olalilja@yahoo.se, ola.o.lilja@stericsson.com, alsa-devel@alsa-project.org, lrg@ti.com, Lee Jones <lee.jones@linaro.org>
List-Id: alsa-devel@alsa-project.org

This is the node which links together the platform (PCM), codec (AB8500)
and the CPU side Digital Audio Interface (MCP) with the machine driver.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/db8500.dtsi |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/db8500.dtsi b/arch/arm/boot/dts/db8500.dtsi
index b9d4405..978dd60 100644
--- a/arch/arm/boot/dts/db8500.dtsi
+++ b/arch/arm/boot/dts/db8500.dtsi
@@ -595,6 +595,14 @@
 			compatible = "stericsson,ux500-pcm";
 		};
 
+		sound {
+			compatible = "stericsson,snd-soc-mop500";
+
+			platform-pcm-dma = <&pcm>;
+			cpu-dai = <&msp1 &msp3>;
+			audio-codec = <&codec>;
+		};
+
 		msp0: msp@80123000 {
 			compatible = "stericsson,ux500-msp-i2s";
 			reg = <0x80123000 0x1000>;
-- 
1.7.9.5
