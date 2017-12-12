From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "ASoC: tfa9879: clean up bindings" to the asoc tree
Date: Tue, 12 Dec 2017 11:16:47 +0000
Message-ID: <E1eOiYJ-0007rX-45@debutante>
References: <20171211142615.11440-2-peda@axentia.se>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171211142615.11440-2-peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tfa9879: clean up bindings

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From d61f9982c2a395407a75a4f7057c4a3f55bda462 Mon Sep 17 00:00:00 2001
From: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Date: Mon, 11 Dec 2017 15:26:14 +0100
Subject: [PATCH] ASoC: tfa9879: clean up bindings

Fix a couple of nitpicks:

- list #sound-dai-cells as a required property.
- The chip supports full speed I2C; don't indicate standard mode only.
- status = "okay" is just noise.
- The chip is an amplifier, not a codec.
- consistently indent with tabs.

Signed-off-by: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 Documentation/devicetree/bindings/sound/tfa9879.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/tfa9879.txt b/Documentation/devicetree/bindings/sound/tfa9879.txt
index 23ba522d9e2b..1620e6848436 100644
--- a/Documentation/devicetree/bindings/sound/tfa9879.txt
+++ b/Documentation/devicetree/bindings/sound/tfa9879.txt
@@ -6,18 +6,18 @@ Required properties:
 
 - reg : the I2C address of the device
 
+- #sound-dai-cells : must be 0.
+
 Example:
 
 &i2c1 {
-	clock-frequency = <100000>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_i2c1>;
-	status = "okay";
 
-	codec: tfa9879@6c {
+	amp: amp@6c {
 		#sound-dai-cells = <0>;
 		compatible = "nxp,tfa9879";
 		reg = <0x6c>;
-        };
+	};
 };
 
-- 
2.15.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
