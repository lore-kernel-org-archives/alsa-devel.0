From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "ASoC: sti: suppress inappropriate fields for sti sound card" to the asoc tree
Date: Wed, 14 Sep 2016 18:15:27 +0100
Message-ID: <E1bkDmR-0001bU-6b@debutante>
References: <1473753504-20179-3-git-send-email-arnaud.pouliquen@st.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1473753504-20179-3-git-send-email-arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnaud Pouliquen <arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, peter.griffin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.orgbroonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sti: suppress inappropriate fields for sti sound card

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 04adc0842f5accf99e9757930fc429bf7788cfb3 Mon Sep 17 00:00:00 2001
From: Arnaud Pouliquen <arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>
Date: Tue, 13 Sep 2016 09:58:24 +0200
Subject: [PATCH] ASoC: sti: suppress inappropriate fields for sti sound card

Suppress fields that can be handled in driver using compatible string.
Rename compatibility strings accordingly.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 .../devicetree/bindings/sound/st,sti-asoc-card.txt | 52 +++++++---------------
 1 file changed, 16 insertions(+), 36 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/st,sti-asoc-card.txt b/Documentation/devicetree/bindings/sound/st,sti-asoc-card.txt
index 16bcdfb6760e..745dc62f76ea 100644
--- a/Documentation/devicetree/bindings/sound/st,sti-asoc-card.txt
+++ b/Documentation/devicetree/bindings/sound/st,sti-asoc-card.txt
@@ -11,7 +11,9 @@ Documentation/devicetree/bindings/sound/simple-card.txt.
 ---------------------------------------
 
 Required properties:
-  - compatible: "st,sti-uni-player" or "st,sti-uni-reader"
+  - compatible: "st,stih407-uni-player-hdmi", "st,stih407-uni-player-pcm-out",
+		"st,stih407-uni-player-dac", "st,stih407-uni-player-spdif",
+		"st,stih407-uni-reader-pcm_in", "st,stih407-uni-reader-hdmi",
 
   - st,syscfg: phandle to boot-device system configuration registers
 
@@ -33,32 +35,24 @@ Required properties:
 	"tx" for "st,sti-uni-player" compatibility
 	"rx" for "st,sti-uni-reader" compatibility
 
-  - st,version: IP version integrated in SOC.
-
-  - dai-name: DAI name that describes the IP.
-
-  - st,mode: IP working mode depending on associated codec.
-	"HDMI" connected to HDMI codec and support IEC HDMI formats (player only).
-	"SPDIF" connected to SPDIF codec and support SPDIF formats (player only).
-	"PCM" PCM standard mode for I2S or TDM bus.
-	"TDM" TDM mode for TDM bus.
-
 Required properties ("st,sti-uni-player" compatibility only):
   - clocks: CPU_DAI IP clock source, listed in the same order than the
 	    CPU_DAI properties.
 
-  - st,uniperiph-id: internal SOC IP instance ID.
-
 Optional properties:
   - pinctrl-0: defined for CPU_DAI@1 and CPU_DAI@4 to describe I2S PIOs for
 	       external codecs connection.
 
   - pinctrl-names: should contain only one value - "default".
 
+  - st,tdm-mode: to declare to set TDM mode for unireader and uniplayer IPs.
+	Only compartible with IPs in charge of the external I2S/TDM bus.
+	Should be declared depending on associated codec.
+
 Example:
 
-	sti_uni_player1: sti-uni-player@1 {
-		compatible = "st,sti-uni-player";
+	sti_uni_player1: sti-uni-player@0x8D81000 {
+		compatible = "st,stih407-uni-player-hdmi";
 		status = "okay";
 		#sound-dai-cells = <0>;
 		st,syscfg = <&syscfg_core>;
@@ -66,15 +60,12 @@ Example:
 		reg = <0x8D81000 0x158>;
 		interrupts = <GIC_SPI 85 IRQ_TYPE_NONE>;
 		dmas = <&fdma0 3 0 1>;
-		st,dai-name = "Uni Player #1 (I2S)";
 		dma-names = "tx";
-		st,uniperiph-id = <1>;
-		st,version = <5>;
-		st,mode = "TDM";
+		st,tdm-mode = <1>;
 	};
 
-	sti_uni_player2: sti-uni-player@2 {
-		compatible = "st,sti-uni-player";
+	sti_uni_player2: sti-uni-player@0x8D82000 {
+		compatible = "st,stih407-uni-player-pcm-out";
 		status = "okay";
 		#sound-dai-cells = <0>;
 		st,syscfg = <&syscfg_core>;
@@ -82,15 +73,11 @@ Example:
 		reg = <0x8D82000 0x158>;
 		interrupts = <GIC_SPI 86 IRQ_TYPE_NONE>;
 		dmas = <&fdma0 4 0 1>;
-		dai-name = "Uni Player #2 (DAC)";
 		dma-names = "tx";
-		st,uniperiph-id = <2>;
-		st,version = <5>;
-		st,mode = "PCM";
 	};
 
-	sti_uni_player3: sti-uni-player@3 {
-		compatible = "st,sti-uni-player";
+	sti_uni_player3: sti-uni-player@0x8D85000 {
+		compatible = "st,stih407-uni-player-spdif";
 		status = "okay";
 		#sound-dai-cells = <0>;
 		st,syscfg = <&syscfg_core>;
@@ -99,14 +86,10 @@ Example:
 		interrupts = <GIC_SPI 89 IRQ_TYPE_NONE>;
 		dmas = <&fdma0 7 0 1>;
 		dma-names = "tx";
-		dai-name = "Uni Player #3 (SPDIF)";
-		st,uniperiph-id = <3>;
-		st,version = <5>;
-		st,mode = "SPDIF";
 	};
 
-	sti_uni_reader1: sti-uni-reader@1 {
-		compatible = "st,sti-uni-reader";
+	sti_uni_reader1: sti-uni-reader@0x8D84000 {
+		compatible = "st,stih407-uni-reader-hdmi";
 		status = "disabled";
 		#sound-dai-cells = <0>;
 		st,syscfg = <&syscfg_core>;
@@ -114,9 +97,6 @@ Example:
 		interrupts = <GIC_SPI 88 IRQ_TYPE_NONE>;
 		dmas = <&fdma0 6 0 1>;
 		dma-names = "rx";
-		dai-name = "Uni Reader #1 (HDMI RX)";
-		st,version = <3>;
-		st,mode = "PCM";
 	};
 
 2) sti-sas-codec: internal audio codec IPs driver
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
