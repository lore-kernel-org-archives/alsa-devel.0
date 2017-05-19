From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-scu-card: cleanup documentation" to the asoc tree
Date: Fri, 19 May 2017 18:04:01 +0100
Message-ID: <E1dBlJp-0003fj-7l@debutante>
References: <874lwjosdg.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <874lwjosdg.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: simple-scu-card: cleanup documentation

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

>From 55cfebfede61cedf60289a7bd20e93a1c83a39a9 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 18 May 2017 01:44:27 +0000
Subject: [PATCH] ASoC: simple-scu-card: cleanup documentation

simple-scu-card is almost same as simple-card. This is already explained
in document. But simple-card and simple-scu-card both has same
explanation for same property. This patch forward explantion to
simple-card if possible to avoid duplication.

This patch also cleanup DT binding example which is not good matching
to simple-scu-card.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/simple-scu-card.txt  | 65 ++++++++--------------
 1 file changed, 24 insertions(+), 41 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/simple-scu-card.txt b/Documentation/devicetree/bindings/sound/simple-scu-card.txt
index d6fe47ed09af..e894cef1d314 100644
--- a/Documentation/devicetree/bindings/sound/simple-scu-card.txt
+++ b/Documentation/devicetree/bindings/sound/simple-scu-card.txt
@@ -1,35 +1,29 @@
-ASoC simple SCU Sound Card
+ASoC Simple SCU Sound Card
 
-Simple-Card specifies audio DAI connections of SoC <-> codec.
+Simple SCU Sound Card is "Simple Sound Card" + "ALSA DPCM".
+For example, you can use this driver if you want to exchange sampling rate convert,
+Mixing, etc...
 
 Required properties:
 
 - compatible				: "simple-scu-audio-card"
 					  "renesas,rsrc-card"
-
 Optional properties:
 
-- simple-audio-card,name		: User specified audio sound card name, one string
-					  property.
-- simple-audio-card,cpu			: CPU   sub-node
-- simple-audio-card,codec		: CODEC sub-node
+- simple-audio-card,name		: see simple-audio-card.txt
+- simple-audio-card,cpu			: see simple-audio-card.txt
+- simple-audio-card,codec		: see simple-audio-card.txt
 
 Optional subnode properties:
 
-- simple-audio-card,format		: CPU/CODEC common audio format.
-					  "i2s", "right_j", "left_j" , "dsp_a"
-					  "dsp_b", "ac97", "pdm", "msb", "lsb"
-- simple-audio-card,frame-master	: Indicates dai-link frame master.
-					  phandle to a cpu or codec subnode.
-- simple-audio-card,bitclock-master	: Indicates dai-link bit clock master.
-					  phandle to a cpu or codec subnode.
-- simple-audio-card,bitclock-inversion	: bool property. Add this if the
-					  dai-link uses bit clock inversion.
-- simple-audio-card,frame-inversion	: bool property. Add this if the
-					  dai-link uses frame clock inversion.
+- simple-audio-card,format		: see simple-audio-card.txt
+- simple-audio-card,frame-master	: see simple-audio-card.txt
+- simple-audio-card,bitclock-master	: see simple-audio-card.txt
+- simple-audio-card,bitclock-inversion	: see simple-audio-card.txt
+- simple-audio-card,frame-inversion	: see simple-audio-card.txt
 - simple-audio-card,convert-rate	: platform specified sampling rate convert
 - simple-audio-card,convert-channels	: platform specified converted channel size (2 - 8 ch)
-- simple-audio-card,prefix		: see audio-routing
+- simple-audio-card,prefix		: see routing
 - simple-audio-card,routing		: A list of the connections between audio components.
 					  Each entry is a pair of strings, the first being the connection's sink,
 					  the second being the connection's source. Valid names for sources.
@@ -38,19 +32,11 @@ Optional subnode properties:
 
 Required CPU/CODEC subnodes properties:
 
-- sound-dai				: phandle and port of CPU/CODEC
+- sound-dai				: see simple-audio-card.txt
 
 Optional CPU/CODEC subnodes properties:
 
-- clocks / system-clock-frequency	: specify subnode's clock if needed.
-					  it can be specified via "clocks" if system has
-					  clock node (= common clock), or "system-clock-frequency"
-					  (if system doens't support common clock)
-					  If a clock is specified, it is
-					  enabled with clk_prepare_enable()
-					  in dai startup() and disabled with
-					  clk_disable_unprepare() in dai
-					  shutdown().
+- clocks / system-clock-frequency	: see simple-audio-card.txt
 
 Example 1. Sampling Rate Covert
 
@@ -59,11 +45,10 @@ sound {
 
 	simple-audio-card,name = "rsnd-ak4643";
 	simple-audio-card,format = "left_j";
-	simple-audio-card,format = "left_j";
 	simple-audio-card,bitclock-master = <&sndcodec>;
 	simple-audio-card,frame-master = <&sndcodec>;
 
-	simple-audio-card,convert-rate = <48000>; /* see audio_clk_a */
+	simple-audio-card,convert-rate = <48000>;
 
 	simple-audio-card,prefix = "ak4642";
 	simple-audio-card,routing = "ak4642 Playback", "DAI0 Playback",
@@ -79,20 +64,18 @@ sound {
 	};
 };
 
-Example 2. 2 CPU 1 Codec
+Example 2. 2 CPU 1 Codec (Mixing)
 
 sound {
-	compatible = "renesas,rsrc-card";
-
-	card-name = "rsnd-ak4643";
-	format = "left_j";
-	bitclock-master = <&dpcmcpu>;
-	frame-master = <&dpcmcpu>;
+	compatible = "simple-scu-audio-card";
 
-	convert-rate = <48000>;  /* see audio_clk_a */
+	simple-audio-card,name = "rsnd-ak4643";
+	simple-audio-card,format = "left_j";
+	simple-audio-card,bitclock-master = <&dpcmcpu>;
+	simple-audio-card,frame-master = <&dpcmcpu>;
 
-	audio-prefix = "ak4642";
-	audio-routing = "ak4642 Playback", "DAI0 Playback",
+	simple-audio-card,prefix = "ak4642";
+	simple-audio-card,routing = "ak4642 Playback", "DAI0 Playback",
 			"ak4642 Playback", "DAI1 Playback";
 
 	dpcmcpu: cpu@0 {
-- 
2.11.0
