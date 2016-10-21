From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 3/6] arm64: dts: lg1313: DT fix s/#interrupts-cells/#interrupt-cells/
Date: Fri, 21 Oct 2016 10:51:14 +0200
Message-ID: <1477039877-20227-4-git-send-email-geert+renesas@glider.be>
References: <1477039877-20227-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1477039877-20227-1-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Patrice Chotard <patrice.chotard@st.com>, Chanho Min <chanho.min@lge.com>, Michael Ellerman <mpe@ellerman.id.au>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, kernel@stlinux.com, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - New.
---
 arch/arm64/boot/dts/lg/lg1313.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/lg/lg1313.dtsi b/arch/arm64/boot/dts/lg/lg1313.dtsi
index e703e1149c757082..abb2162228e82d39 100644
--- a/arch/arm64/boot/dts/lg/lg1313.dtsi
+++ b/arch/arm64/boot/dts/lg/lg1313.dtsi
@@ -123,7 +123,7 @@
 	amba {
 		#address-cells = <2>;
 		#size-cells = <1>;
-		#interrupts-cells = <3>;
+		#interrupt-cells = <3>;
 
 		compatible = "simple-bus";
 		interrupt-parent = <&gic>;
-- 
1.9.1
