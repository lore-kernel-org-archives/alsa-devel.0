From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-scu-card: remove simple-scu-card
	on Doc" to the asoc tree
Date: Fri, 21 Dec 2018 18:15:30 +0000 (GMT)
Message-ID: <20181221181530.6E91F1121B93@debutante.sirena.org.uk>
References: <875zvr36c6.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 1A5C1267AF9
 for <alsa-devel@alsa-project.org>; Fri, 21 Dec 2018 19:15:30 +0100 (CET)
In-Reply-To: <875zvr36c6.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: simple-scu-card: remove simple-scu-card on Doc

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

>From 3f11cffdc9986a5b2f23836d4919d89df812e6e4 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 18 Dec 2018 11:50:37 +0900
Subject: [PATCH] ASoC: simple-scu-card: remove simple-scu-card on Doc

It is already merged into simple-card.
simple-scu-card is no longer needed.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../bindings/sound/simple-scu-card.txt        | 94 -------------------
 1 file changed, 94 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/simple-scu-card.txt

diff --git a/Documentation/devicetree/bindings/sound/simple-scu-card.txt b/Documentation/devicetree/bindings/sound/simple-scu-card.txt
deleted file mode 100644
index 3a2f71616cda..000000000000
--- a/Documentation/devicetree/bindings/sound/simple-scu-card.txt
+++ /dev/null
@@ -1,94 +0,0 @@
-ASoC Simple SCU Sound Card
-
-Simple SCU Sound Card is "Simple Sound Card" + "ALSA DPCM".
-For example, you can use this driver if you want to exchange sampling rate convert,
-Mixing, etc...
-
-Required properties:
-
-- compatible				: "simple-scu-audio-card"
-					  "renesas,rsrc-card"
-Optional properties:
-
-- simple-audio-card,name		: see simple-audio-card.txt
-- simple-audio-card,cpu			: see simple-audio-card.txt
-- simple-audio-card,codec		: see simple-audio-card.txt
-
-Optional subnode properties:
-
-- simple-audio-card,format		: see simple-audio-card.txt
-- simple-audio-card,frame-master	: see simple-audio-card.txt
-- simple-audio-card,bitclock-master	: see simple-audio-card.txt
-- simple-audio-card,bitclock-inversion	: see simple-audio-card.txt
-- simple-audio-card,frame-inversion	: see simple-audio-card.txt
-- simple-audio-card,convert-rate	: platform specified sampling rate convert
-- simple-audio-card,convert-channels	: platform specified converted channel size (2 - 8 ch)
-- simple-audio-card,prefix		: see routing
-- simple-audio-card,widgets		: Please refer to widgets.txt.
-- simple-audio-card,routing		: A list of the connections between audio components.
-					  Each entry is a pair of strings, the first being the connection's sink,
-					  the second being the connection's source. Valid names for sources.
-					  use audio-prefix if some components is using same sink/sources naming.
-					  it can be used if compatible was "renesas,rsrc-card";
-
-Required CPU/CODEC subnodes properties:
-
-- sound-dai				: see simple-audio-card.txt
-
-Optional CPU/CODEC subnodes properties:
-
-- clocks / system-clock-frequency	: see simple-audio-card.txt
-
-Example 1. Sampling Rate Conversion
-
-sound {
-	compatible = "simple-scu-audio-card";
-
-	simple-audio-card,name = "rsnd-ak4643";
-	simple-audio-card,format = "left_j";
-	simple-audio-card,bitclock-master = <&sndcodec>;
-	simple-audio-card,frame-master = <&sndcodec>;
-
-	simple-audio-card,convert-rate = <48000>;
-
-	simple-audio-card,prefix = "ak4642";
-	simple-audio-card,routing = "ak4642 Playback", "DAI0 Playback",
-			"DAI0 Capture", "ak4642 Capture";
-
-	sndcpu: simple-audio-card,cpu {
-		sound-dai = <&rcar_sound>;
-	};
-
-	sndcodec: simple-audio-card,codec {
-		sound-dai = <&ak4643>;
-		system-clock-frequency = <11289600>;
-	};
-};
-
-Example 2. 2 CPU 1 Codec (Mixing)
-
-sound {
-	compatible = "simple-scu-audio-card";
-
-	simple-audio-card,name = "rsnd-ak4643";
-	simple-audio-card,format = "left_j";
-	simple-audio-card,bitclock-master = <&dpcmcpu>;
-	simple-audio-card,frame-master = <&dpcmcpu>;
-
-	simple-audio-card,routing = "ak4642 Playback", "DAI0 Playback",
-			"ak4642 Playback", "DAI1 Playback";
-
-	dpcmcpu: cpu@0 {
-		sound-dai = <&rcar_sound 0>;
-	};
-
-	cpu@1 {
-		sound-dai = <&rcar_sound 1>;
-	};
-
-	codec {
-		prefix = "ak4642";
-		sound-dai = <&ak4643>;
-		clocks = <&audio_clock>;
-	};
-};
-- 
2.20.1
