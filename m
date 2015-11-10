From: Sugar Zhang <sugar.zhang-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH 3/3] ARM: dts: rockchip: add channels properties for i2s
Date: Tue, 10 Nov 2015 15:32:09 +0800
Message-ID: <1447140729-18267-4-git-send-email-sugar.zhang@rock-chips.com>
References: <1447140729-18267-1-git-send-email-sugar.zhang@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1447140729-18267-1-git-send-email-sugar.zhang-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org
Cc: Sugar Zhang <sugar.zhang-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org

add playback and capture properties to compatible various chips.

Signed-off-by: Sugar Zhang <sugar.zhang-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
---
 arch/arm/boot/dts/rk3066a.dtsi | 6 ++++++
 arch/arm/boot/dts/rk3188.dtsi  | 2 ++
 arch/arm/boot/dts/rk3288.dtsi  | 2 ++
 3 files changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/rk3066a.dtsi b/arch/arm/boot/dts/rk3066a.dtsi
index 946f187..1003f9c 100644
--- a/arch/arm/boot/dts/rk3066a.dtsi
+++ b/arch/arm/boot/dts/rk3066a.dtsi
@@ -103,6 +103,8 @@
 		dma-names = "tx", "rx";
 		clock-names = "i2s_hclk", "i2s_clk";
 		clocks = <&cru HCLK_I2S0>, <&cru SCLK_I2S0>;
+		rockchip,playback-channels = <8>;
+		rockchip,capture-channels = <2>;
 		status = "disabled";
 	};
 
@@ -118,6 +120,8 @@
 		dma-names = "tx", "rx";
 		clock-names = "i2s_hclk", "i2s_clk";
 		clocks = <&cru HCLK_I2S1>, <&cru SCLK_I2S1>;
+		rockchip,playback-channels = <2>;
+		rockchip,capture-channels = <2>;
 		status = "disabled";
 	};
 
@@ -133,6 +137,8 @@
 		dma-names = "tx", "rx";
 		clock-names = "i2s_hclk", "i2s_clk";
 		clocks = <&cru HCLK_I2S2>, <&cru SCLK_I2S2>;
+		rockchip,playback-channels = <2>;
+		rockchip,capture-channels = <2>;
 		status = "disabled";
 	};
 
diff --git a/arch/arm/boot/dts/rk3188.dtsi b/arch/arm/boot/dts/rk3188.dtsi
index 3163042..b9b6b3a 100644
--- a/arch/arm/boot/dts/rk3188.dtsi
+++ b/arch/arm/boot/dts/rk3188.dtsi
@@ -118,6 +118,8 @@
 		dma-names = "tx", "rx";
 		clock-names = "i2s_hclk", "i2s_clk";
 		clocks = <&cru HCLK_I2S0>, <&cru SCLK_I2S0>;
+		rockchip,playback-channels = <2>;
+		rockchip,capture-channels = <2>;
 		status = "disabled";
 	};
 
diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 4e7c6b7..e7ce9f1 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -669,6 +669,8 @@
 		clocks = <&cru HCLK_I2S0>, <&cru SCLK_I2S0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2s0_bus>;
+		rockchip,playback-channels = <8>;
+		rockchip,capture-channels = <2>;
 		status = "disabled";
 	};
 
-- 
2.3.6
