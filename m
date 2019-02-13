From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: [PATCH 2/2] arm64: dts: allwinner: a64: Rename
 hpvcc-supply to cpvdd-supply
Date: Wed, 13 Feb 2019 15:04:57 +0800
Message-ID: <20190213070457.26049-3-wens@csie.org>
References: <20190213070457.26049-1-wens@csie.org>
Reply-To: wens-jdAy2FN1RRM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBCMILY6JWQBBBIUDR7RQKGQEY4SIY5A-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20190213070457.26049-1-wens-jdAy2FN1RRM@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

The A64 datasheet lists the supply rail for the headphone amp's charge
pump as "CPVDD". cpvdd-supply is the name of the property for this power
rail specified in the device tree bindings. "HPVCC" was the name used in
the A33 datasheet for the same function.

Rename the supply so it matches the datasheet and bindings.

Fixes: c56689e6f2fb ("arm64: dts: allwinner: a64: bananapi-m64: Enable audio codec")
Fixes: 6de8e717848f ("arm64: dts: allwinner: a64: enable sound on Pinebook")
Fixes: 498c21f233ed ("arm64: dts: allwinner: a64: enable sound on Pine64 and SoPine")
Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts | 2 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts       | 2 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts     | 2 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi      | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
index 7793ebb5d2b8..0a56c0c23ba1 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
@@ -104,7 +104,7 @@
 };
 
 &codec_analog {
-	hpvcc-supply = <&reg_eldo1>;
+	cpvdd-supply = <&reg_eldo1>;
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
index c0b9cc7a6b3a..b7ac6374b178 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
@@ -80,7 +80,7 @@
 };
 
 &codec_analog {
-	hpvcc-supply = <&reg_eldo1>;
+	cpvdd-supply = <&reg_eldo1>;
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
index d22736a62481..78c82a665c84 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
@@ -94,7 +94,7 @@
 };
 
 &codec_analog {
-	hpvcc-supply = <&reg_eldo1>;
+	cpvdd-supply = <&reg_eldo1>;
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi
index d2651f284aa0..9d20e13f0c02 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi
@@ -48,7 +48,7 @@
 #include <dt-bindings/gpio/gpio.h>
 
 &codec_analog {
-	hpvcc-supply = <&reg_eldo1>;
+	cpvdd-supply = <&reg_eldo1>;
 };
 
 &mmc0 {
-- 
2.20.1
