From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "ASoC: simple-card: Pass 'reg' property in the examples" to the asoc tree
Date: Thu, 04 Jan 2018 17:42:37 +0000
Message-ID: <E1eX9XJ-00061f-2W@debutante>
References: <1515086697-25900-1-git-send-email-festevam@gmail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1515086697-25900-1-git-send-email-festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.orgalsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: simple-card: Pass 'reg' property in the examples

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

>From ef42e3557f66bd236bfc157c1f02de5abfd01236 Mon Sep 17 00:00:00 2001
From: Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>
Date: Thu, 4 Jan 2018 15:24:57 -0200
Subject: [PATCH] ASoC: simple-card: Pass 'reg' property in the examples

Since unit addresses are passed to simple-audio-card,dai-link a
corresponding 'reg' property is needed, otherwise dtc complains
(when building with W=1) in case someone copies the bindings example
into a real dts file:

Warning (unit_address_vs_reg): Node /sound-digital/simple-audio-card,dai-link@0 has a unit name, but no reg property

Improve the example by passing the correct 'reg' properties.

Signed-off-by: Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 Documentation/devicetree/bindings/sound/simple-card.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/simple-card.txt b/Documentation/devicetree/bindings/sound/simple-card.txt
index 166f2290233b..17c13e74667d 100644
--- a/Documentation/devicetree/bindings/sound/simple-card.txt
+++ b/Documentation/devicetree/bindings/sound/simple-card.txt
@@ -140,6 +140,7 @@ sound {
 	simple-audio-card,name = "Cubox Audio";
 
 	simple-audio-card,dai-link@0 {		/* I2S - HDMI */
+		reg = <0>;
 		format = "i2s";
 		cpu {
 			sound-dai = <&audio1 0>;
@@ -150,6 +151,7 @@ sound {
 	};
 
 	simple-audio-card,dai-link@1 {		/* S/PDIF - HDMI */
+		reg = <1>;
 		cpu {
 			sound-dai = <&audio1 1>;
 		};
@@ -159,6 +161,7 @@ sound {
 	};
 
 	simple-audio-card,dai-link@2 {		/* S/PDIF - S/PDIF */
+		reg = <2>;
 		cpu {
 			sound-dai = <&audio1 1>;
 		};
-- 
2.15.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
