From: Icenowy Zheng <icenowy@aosc.xyz>
Subject: [PATCH 9/9] ARM: dts: sun8i: enable audio on Lichee Pi
	Zero Dock
Date: Sat, 25 Feb 2017 20:30:29 +0800
Message-ID: <20170225123029.55939-9-icenowy@aosc.xyz>
References: <20170225123029.55939-1-icenowy@aosc.xyz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from forward6o.cmail.yandex.net (forward6o.cmail.yandex.net
 [37.9.109.52]) by alsa0.perex.cz (Postfix) with ESMTP id 664E92670FA
 for <alsa-devel@alsa-project.org>; Sat, 25 Feb 2017 13:34:06 +0100 (CET)
In-Reply-To: <20170225123029.55939-1-icenowy@aosc.xyz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>, Rob Herring <robh+dt@kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Icenowy Zheng <icenowy@aosc.xyz>, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

The Dock board of Lichee Pi Zero features a 3.5mm Headphone Jack and an
onboard MIC.

Add support for them.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts b/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts
index 68c114d6b939..d0f17bcaeaab 100644
--- a/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts
+++ b/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts
@@ -47,3 +47,12 @@
 	compatible = "licheepi,licheepi-zero-dock", "licheepi,licheepi-zero",
 		     "allwinner,sun8i-v3s";
 };
+
+&codec {
+	allwinner,audio-routing =
+		"Headphone", "HP",
+		"Headphone", "HPCOM",
+		"MIC1", "Mic",
+		"Mic",  "MBIAS";
+	status = "okay";
+};
-- 
2.11.1
