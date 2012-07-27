From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 13/18] ARM: ux500: Add ux500 PCM to DB8500 Device Tree
Date: Fri, 27 Jul 2012 13:45:57 +0100
Message-ID: <1343393162-11938-14-git-send-email-lee.jones@linaro.org>
References: <1343393162-11938-1-git-send-email-lee.jones@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1343393162-11938-1-git-send-email-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: STEricsson_nomadik_linux@list.st.com, linus.walleij@stericsson.com, arnd@arndb.de, olalilja@yahoo.se, ola.o.lilja@stericsson.com, alsa-devel@alsa-project.org, lrg@ti.com, broonie@opensource.wolfsonmicro.com, Lee Jones <lee.jones@linaro.org>
List-Id: alsa-devel@alsa-project.org

Nothing special here. We're only providing a compatible string
to ensure the driver is probed using a Device Tree boot.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/db8500.dtsi |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/db8500.dtsi b/arch/arm/boot/dts/db8500.dtsi
index a3bee0a..a3fb05f 100644
--- a/arch/arm/boot/dts/db8500.dtsi
+++ b/arch/arm/boot/dts/db8500.dtsi
@@ -591,6 +591,10 @@
 			status = "disabled";
 		};
 
+		pcm: ux500-pcm {
+			compatible = "stericsson,ux500-pcm";
+		};
+
 		external-bus@50000000 {
 			compatible = "simple-bus";
 			reg = <0x50000000 0x4000000>;
-- 
1.7.9.5
