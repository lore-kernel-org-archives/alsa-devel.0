From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 07/19] ARM: ux500: Add AB8500 CODEC node to DB8500 Device Tree
Date: Tue, 31 Jul 2012 14:39:01 +0100
Message-ID: <1343741953-17828-8-git-send-email-lee.jones@linaro.org>
References: <1343741953-17828-1-git-send-email-lee.jones@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1343741953-17828-1-git-send-email-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, olalilja@yahoo.se, ola.o.lilja@stericsson.com, alsa-devel@alsa-project.org, lrg@ti.com, broonie@opensource.wolfsonmicro.com
Cc: STEricsson_nomadik_linux@list.st.com, linus.walleij@stericsson.com, arnd@arndb.de, Lee Jones <lee.jones@linaro.org>
List-Id: alsa-devel@alsa-project.org

Ensure correct probing and pass though important configuration
options to the AB8500 CODEC driver when DT is enabled

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/db8500.dtsi |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/db8500.dtsi b/arch/arm/boot/dts/db8500.dtsi
index 7279165..a3bee0a 100644
--- a/arch/arm/boot/dts/db8500.dtsi
+++ b/arch/arm/boot/dts/db8500.dtsi
@@ -370,6 +370,12 @@
 					compatible = "stericsson,ab8500-debug";
 				};
 
+				codec: ab8500-codec {
+					compatible = "stericsson,ab8500-codec";
+
+					stericsson,earpeice-cmv = <950>; /* Units in mV. */
+				};
+
 				ab8500-regulators {
 					compatible = "stericsson,ab8500-regulator";
 
-- 
1.7.9.5
