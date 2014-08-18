From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v2 5/8] ARM: dts: am33xx: Add external clock provider
Date: Tue, 19 Aug 2014 00:46:43 +0300
Message-ID: <9d4974b949b9b3bc1b08d73b1ec2d9cdd7a8e5da.1408397864.git.jsarha@ti.com>
References: <cover.1408397864.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <cover.1408397864.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: dri-devel@lists.freedesktop.org, airlied@linux.ie, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, bcousson@baylibre.com, alsa-devel@alsa-project.org
Cc: tony@atomide.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, peter.ujfalusi@ti.com, detheridge@ti.com, ezequiel.garcia@free-electrons.com, t-kristo@ti.com, Jyri Sarha <jsarha@ti.com>
List-Id: alsa-devel@alsa-project.org

Add external clock provider for am33xx devices.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 3a0a161..d2cc397 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -92,6 +92,16 @@
 		pinctrl-single,function-mask = <0x7f>;
 	};
 
+	ext_clocks {
+		compatible = "ti,external-clocks";
+
+		ext_clocks: clocks {
+		};
+
+		ext_clockdomains: clockdomains {
+		};
+	};
+
 	/*
 	 * XXX: Use a flat representation of the AM33XX interconnect.
 	 * The real AM33XX interconnect network is quite complex. Since
-- 
1.7.9.5

