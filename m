From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 4/5] ARM: shmobile: r8a7790 dtsi: Drop "renesas,rcar_sound" compatible value
Date: Mon, 10 Nov 2014 20:00:43 +0100
Message-ID: <1415646044-4168-5-git-send-email-geert+renesas@glider.be>
References: <1415646044-4168-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1415646044-4168-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, linux-sh@vger.kernel.org, devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: alsa-devel@alsa-project.org

The "renesas,rcar_sound" compatible property value was never processed
nor documented.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7790.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 46d6898de290d2d0..2548890925a9f16e 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -1389,7 +1389,7 @@
 
 	rcar_sound: rcar_sound@ec500000 {
 		#sound-dai-cells = <1>;
-		compatible =  "renesas,rcar_sound-r8a7790", "renesas,rcar_sound-gen2", "renesas,rcar_sound";
+		compatible =  "renesas,rcar_sound-r8a7790", "renesas,rcar_sound-gen2";
 		reg =	<0 0xec500000 0 0x1000>, /* SCU */
 			<0 0xec5a0000 0 0x100>,  /* ADG */
 			<0 0xec540000 0 0x1000>, /* SSIU */
-- 
1.9.1

