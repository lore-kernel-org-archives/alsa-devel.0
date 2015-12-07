From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] [RFC] ARM: shmobile: bockw dts: Override #sound-dai-cells to zero
Date: Mon,  7 Dec 2015 17:25:37 +0100
Message-ID: <1449505537-15428-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: alsa-devel@alsa-project.org

The default value of #sound-dai-cells in r8a7778.dtsi is one, while
the /sound/simple-audio-card,cpu device node in r8a7778-bockw.dts uses a
phandle without any extra cells ("<&rcar_sound>"), causing:

    /sound/simple-audio-card,cpu: arguments longer than property
    asoc-simple-card sound: parse error -22
    asoc-simple-card: probe of sound failed with error -22

Override #sound-dai-cells to zero to fix this.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
The rcar_sound node is still disabled. So why is this needed?!?
---
 arch/arm/boot/dts/r8a7778-bockw.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7778-bockw.dts b/arch/arm/boot/dts/r8a7778-bockw.dts
index 3c03e6b8261e9348..158ad94fd4d187a7 100644
--- a/arch/arm/boot/dts/r8a7778-bockw.dts
+++ b/arch/arm/boot/dts/r8a7778-bockw.dts
@@ -172,6 +172,11 @@
 	};
 };
 
+&rcar_sound {
+	/* Single DAI */
+	#sound-dai-cells = <0>;
+};
+
 &sdhi0 {
 	pinctrl-0 = <&sdhi0_pins>, <&sdhi0_pup_pins>;
 	pinctrl-names = "default";
-- 
1.9.1

