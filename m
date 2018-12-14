From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-card: merge simple-scu-card on
	Doc" to the asoc tree
Date: Fri, 14 Dec 2018 12:37:33 +0000 (GMT)
Message-ID: <20181214123733.CA2E711258A1@debutante.sirena.org.uk>
References: <87bm5o975g.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 47E9A267A78
 for <alsa-devel@alsa-project.org>; Fri, 14 Dec 2018 13:37:34 +0100 (CET)
In-Reply-To: <87bm5o975g.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: simple-card: merge simple-scu-card on Doc

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

>From c4e8ebb9f2624da8302b6683ecb5ead7108ccb79 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 14 Dec 2018 11:35:05 +0900
Subject: [PATCH] ASoC: simple-card: merge simple-scu-card on Doc

simple-card and simple-scu-card are very similar driver,
but the former is supporting normal sound card,
the latter is supporting DPCM sound card.

We couldn't use normal sound and DPCM sound in same time by
one sound card. This patch merges both sound card into
simple-card. Now we can use both feature on same driver.

simple-card is now supporting .compatible = "simple-scu-audio-card".

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/simple-card.txt | 137 ++++++++++++++++++
 1 file changed, 137 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/simple-card.txt b/Documentation/devicetree/bindings/sound/simple-card.txt
index a4c72d09cd45..4629c8f8a6b6 100644
--- a/Documentation/devicetree/bindings/sound/simple-card.txt
+++ b/Documentation/devicetree/bindings/sound/simple-card.txt
@@ -95,7 +95,9 @@ Optional CPU/CODEC subnodes properties:
 					  initialization. It is useful for some aCPUs with
 					  fixed clocks.
 
+-------------------------------------------
 Example 1 - single DAI link:
+-------------------------------------------
 
 sound {
 	compatible = "simple-audio-card";
@@ -138,7 +140,9 @@ sh_fsi2: sh_fsi2@ec230000 {
 	interrupts = <0 146 0x4>;
 };
 
+-------------------------------------------
 Example 2 - many DAI links:
+-------------------------------------------
 
 sound {
 	compatible = "simple-audio-card";
@@ -176,8 +180,10 @@ sound {
 	};
 };
 
+-------------------------------------------
 Example 3 - route audio from IMX6 SSI2 through TLV320DAC3100 codec
 through TPA6130A2 amplifier to headphones:
+-------------------------------------------
 
 &i2c0 {
 	codec: tlv320dac3100@18 {
@@ -210,3 +216,134 @@ sound {
 		clocks = ...
 	};
 };
+
+-------------------------------------------
+Example 4. Sampling Rate Conversion
+-------------------------------------------
+
+sound {
+	compatible = "simple-audio-card";
+
+	simple-audio-card,name = "rsnd-ak4643";
+	simple-audio-card,format = "left_j";
+	simple-audio-card,bitclock-master = <&sndcodec>;
+	simple-audio-card,frame-master = <&sndcodec>;
+
+	simple-audio-card,convert-rate = <48000>;
+
+	simple-audio-card,prefix = "ak4642";
+	simple-audio-card,routing = "ak4642 Playback", "DAI0 Playback",
+			"DAI0 Capture", "ak4642 Capture";
+
+	sndcpu: simple-audio-card,cpu {
+		sound-dai = <&rcar_sound>;
+	};
+
+	sndcodec: simple-audio-card,codec {
+		sound-dai = <&ak4643>;
+		system-clock-frequency = <11289600>;
+	};
+};
+
+-------------------------------------------
+Example 5. 2 CPU 1 Codec (Mixing)
+-------------------------------------------
+sound {
+	compatible = "simple-audio-card";
+
+	simple-audio-card,name = "rsnd-ak4643";
+	simple-audio-card,format = "left_j";
+	simple-audio-card,bitclock-master = <&dpcmcpu>;
+	simple-audio-card,frame-master = <&dpcmcpu>;
+
+	simple-audio-card,routing = "ak4642 Playback", "DAI0 Playback",
+			"ak4642 Playback", "DAI1 Playback";
+
+	dpcmcpu: cpu@0 {
+		sound-dai = <&rcar_sound 0>;
+	};
+
+	cpu@1 {
+		sound-dai = <&rcar_sound 1>;
+	};
+
+	codec {
+		prefix = "ak4642";
+		sound-dai = <&ak4643>;
+		clocks = <&audio_clock>;
+	};
+};
+
+-------------------------------------------
+Example 6 - many DAI links with DPCM:
+-------------------------------------------
+
+CPU0 ------ ak4613
+CPU1 ------ PCM3168A-p  /* DPCM 1ch/2ch */
+CPU2 --/                /* DPCM 3ch/4ch */
+CPU3 --/                /* DPCM 5ch/6ch */
+CPU4 --/                /* DPCM 7ch/8ch */
+CPU5 ------ PCM3168A-c
+
+sound {
+	compatible = "simple-audio-card";
+
+	simple-audio-card,routing =
+		  "pcm3168a Playback", "DAI1 Playback",
+		  "pcm3168a Playback", "DAI2 Playback",
+		  "pcm3168a Playback", "DAI3 Playback",
+		  "pcm3168a Playback", "DAI4 Playback";
+
+	simple-audio-card,dai-link@0 {
+		format = "left_j";
+		bitclock-master = <&sndcpu0>;
+		frame-master = <&sndcpu0>;
+
+		sndcpu0: cpu {
+			sound-dai = <&rcar_sound 0>;
+		};
+		codec {
+			sound-dai = <&ak4613>;
+		};
+	};
+	simple-audio-card,dai-link@1 {
+		format = "i2s";
+		bitclock-master = <&sndcpu1>;
+		frame-master = <&sndcpu1>;
+
+		convert-channels = <8>; /* TDM Split */
+
+		sndcpu1: cpu@0 {
+			sound-dai = <&rcar_sound 1>;
+		};
+		cpu@1 {
+			sound-dai = <&rcar_sound 2>;
+		};
+		cpu@2 {
+			sound-dai = <&rcar_sound 3>;
+		};
+		cpu@3 {
+			sound-dai = <&rcar_sound 4>;
+		};
+		codec {
+			mclk-fs = <512>;
+			prefix = "pcm3168a";
+			dai-tdm-slot-num = <8>;
+			sound-dai = <&pcm3168a 0>;
+		};
+	};
+	simple-audio-card,dai-link@2 {
+		format = "i2s";
+		bitclock-master = <&sndcpu2>;
+		frame-master = <&sndcpu2>;
+
+		sndcpu2: cpu {
+			sound-dai = <&rcar_sound 5>;
+		};
+		codec {
+			mclk-fs = <512>;
+			prefix = "pcm3168a";
+			sound-dai = <&pcm3168a 1>;
+		};
+	};
+};
-- 
2.19.0.rc2
