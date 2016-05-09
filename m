From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH v2 5/5] ARM: dts: rockchip: veyron: Add analog audio codecs.
Date: Mon,  9 May 2016 12:46:35 +0200
Message-ID: <1462790795-25345-6-git-send-email-enric.balletbo@collabora.com>
References: <1462790795-25345-1-git-send-email-enric.balletbo@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462790795-25345-1-git-send-email-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@kernel.org>, Heiko Stuebner <heiko@sntech.de>
List-Id: alsa-devel@alsa-project.org

Add analog-audio functionality for Veyron devices.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
Changes since v1:
 - None

 arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi b/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi
index 610769d..e25bb1a 100644
--- a/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi
+++ b/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi
@@ -46,6 +46,7 @@
 #include <dt-bindings/clock/rockchip,rk808.h>
 #include <dt-bindings/input/input.h>
 #include "rk3288-veyron.dtsi"
+#include "rk3288-veyron-analog-audio.dtsi"
 #include "rk3288-veyron-sdmmc.dtsi"
 
 / {
-- 
2.1.0
