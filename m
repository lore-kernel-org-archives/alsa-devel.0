From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: move "renesas,rsrc-card" to "simple-scu-audio-card" on Document" to the asoc tree
Date: Wed, 17 May 2017 10:52:38 +0100
Message-ID: <E1dAvdG-0006ut-Tt@debutante>
References: <874lxbsyaz.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <874lxbsyaz.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Geert Uytterhoeven <geert@linux-m68k.org>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: move "renesas,rsrc-card" to "simple-scu-audio-card" on Document

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

>From 0378bb966765e06fdb0e00d592a6fcfbb71afa3c Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 26 Apr 2017 02:26:30 +0000
Subject: [PATCH] ASoC: rsnd: move "renesas,rsrc-card" to
 "simple-scu-audio-card" on Document

"renesas,rsrc-card" is exchanged to "simple-scu-card".
Let's update Document

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/renesas,rsnd.txt     | 30 +++++++++++-----------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
index 15a7316e4c91..3332910a9a11 100644
--- a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
+++ b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
@@ -83,11 +83,11 @@ SRC can convert [xx]Hz to [yy]Hz. Then, it has below 2 modes
 **     Asynchronous mode
 ------------------
 
-You need to use "renesas,rsrc-card" sound card for it.
+You need to use "simple-scu-audio-card" sound card for it.
 example)
 
 	sound {
-		compatible = "renesas,rsrc-card";
+		compatible = "simple-scu-audio-card";
 		...
 		/*
 		 * SRC Asynchronous mode setting
@@ -97,12 +97,12 @@ example)
 		 * Inputed 48kHz data will be converted to
 		 * system specified Hz
 		 */
-		convert-rate = <48000>;
+		simple-audio-card,convert-rate = <48000>;
 		...
-		cpu {
+		simple-audio-card,cpu {
 			sound-dai = <&rcar_sound>;
 		};
-		codec {
+		simple-audio-card,codec {
 			...
 		};
 	};
@@ -141,23 +141,23 @@ For more detail information, see below
 	${LINUX}/sound/soc/sh/rcar/ctu.c
 	 - comment of header
 
-You need to use "renesas,rsrc-card" sound card for it.
+You need to use "simple-scu-audio-card" sound card for it.
 example)
 
 	sound {
-		compatible = "renesas,rsrc-card";
+		compatible = "simple-scu-audio-card";
 		...
 		/*
 		 * CTU setting
 		 * All input data will be converted to 2ch
 		 * as output data
 		 */
-		convert-channels = <2>;
+		simple-audio-card,convert-channels = <2>;
 		...
-		cpu {
+		simple-audio-card,cpu {
 			sound-dai = <&rcar_sound>;
 		};
-		codec {
+		simple-audio-card,codec {
 			...
 		};
 	};
@@ -190,22 +190,22 @@ and these sounds will be merged by MIX.
 	aplay -D plughw:0,0 xxxx.wav &
 	aplay -D plughw:0,1 yyyy.wav
 
-You need to use "renesas,rsrc-card" sound card for it.
+You need to use "simple-scu-audio-card" sound card for it.
 Ex)
 	[MEM] -> [SRC1] -> [CTU02] -+-> [MIX0] -> [DVC0] -> [SSI0]
 	                            |
 	[MEM] -> [SRC2] -> [CTU03] -+
 
 	sound {
-		compatible = "renesas,rsrc-card";
+		compatible = "simple-scu-audio-card";
 		...
-		cpu@0 {
+		simple-audio-card,cpu@0 {
 			sound-dai = <&rcar_sound 0>;
 		};
-		cpu@1 {
+		simple-audio-card,cpu@1 {
 			sound-dai = <&rcar_sound 1>;
 		};
-		codec {
+		simple-audio-card,codec {
 			...
 		};
 	};
-- 
2.11.0
