From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: tidyup Document for DT binding"
	to the asoc tree
Date: Tue,  6 Nov 2018 17:52:44 +0000 (GMT)
Message-ID: <20181106175244.5F564112266B@debutante.sirena.org.uk>
References: <877ehqx01j.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 31973267AB7
 for <alsa-devel@alsa-project.org>; Tue,  6 Nov 2018 18:52:44 +0100 (CET)
In-Reply-To: <877ehqx01j.wl-kuninori.morimoto.gx@renesas.com>
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
Cc: Jiada Wang <jiada_wang@mentor.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: tidyup Document for DT binding

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

>From bd7ff187fac33c2fd221aa4073215d38d9c6b6ed Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 6 Nov 2018 05:20:25 +0000
Subject: [PATCH] ASoC: rsnd: tidyup Document for DT binding

It has duplicated DT example code on Document.
This patch tidyup these.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../bindings/sound/renesas,rsnd.txt           | 214 ++++++++----------
 1 file changed, 98 insertions(+), 116 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
index d92b705e7917..8986764508db 100644
--- a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
+++ b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
@@ -39,15 +39,7 @@ This is example of
 Playback: [MEM] -> [SRC2] -> [DVC0] -> [SSIU0/SSI0] -> [codec]
 Capture:  [MEM] <- [DVC1] <- [SRC3] <- [SSIU1/SSI1] <- [codec]
 
-	&rcar_sound {
-		...
-		rcar_sound,dai {
-			dai0 {
-				playback = <&ssi0 &src2 &dvc0>;
-				capture  = <&ssi1 &src3 &dvc1>;
-			};
-		};
-	};
+see "Example: simple sound card"
 
 You can use below.
 ${LINUX}/arch/arm/boot/dts/r8a7790.dts can be good example.
@@ -83,29 +75,8 @@ SRC can convert [xx]Hz to [yy]Hz. Then, it has below 2 modes
 **     Asynchronous mode
 ------------------
 
-You need to use "simple-scu-audio-card" sound card for it.
-example)
-
-	sound {
-		compatible = "simple-scu-audio-card";
-		...
-		/*
-		 * SRC Asynchronous mode setting
-		 * Playback:
-		 * All input data will be converted to 48kHz
-		 * Capture:
-		 * Inputed 48kHz data will be converted to
-		 * system specified Hz
-		 */
-		simple-audio-card,convert-rate = <48000>;
-		...
-		simple-audio-card,cpu {
-			sound-dai = <&rcar_sound>;
-		};
-		simple-audio-card,codec {
-			...
-		};
-	};
+You need to use "simple-scu-audio-card" or "audio-graph-scu-card" for it.
+see "Example: simple sound card for Asynchronous mode"
 
 ------------------
 **     Synchronous mode
@@ -141,26 +112,8 @@ For more detail information, see below
 	${LINUX}/sound/soc/sh/rcar/ctu.c
 	 - comment of header
 
-You need to use "simple-scu-audio-card" sound card for it.
-example)
-
-	sound {
-		compatible = "simple-scu-audio-card";
-		...
-		/*
-		 * CTU setting
-		 * All input data will be converted to 2ch
-		 * as output data
-		 */
-		simple-audio-card,convert-channels = <2>;
-		...
-		simple-audio-card,cpu {
-			sound-dai = <&rcar_sound>;
-		};
-		simple-audio-card,codec {
-			...
-		};
-	};
+You need to use "simple-scu-audio-card" or "audio-graph-scu-card" for it.
+see "Example: simple sound card for channel convert"
 
 Ex) Exchange output channel
  Input -> Output
@@ -190,42 +143,13 @@ and these sounds will be merged by MIX.
 	aplay -D plughw:0,0 xxxx.wav &
 	aplay -D plughw:0,1 yyyy.wav
 
-You need to use "simple-scu-audio-card" sound card for it.
+You need to use "simple-scu-audio-card" or "audio-graph-scu-card" for it.
 Ex)
 	[MEM] -> [SRC1] -> [CTU02] -+-> [MIX0] -> [DVC0] -> [SSI0]
 	                            |
 	[MEM] -> [SRC2] -> [CTU03] -+
 
-	sound {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		compatible = "simple-scu-audio-card";
-		...
-		simple-audio-card,cpu@0 {
-			reg = <0>;
-			sound-dai = <&rcar_sound 0>;
-		};
-		simple-audio-card,cpu@1 {
-			reg = <1>;
-			sound-dai = <&rcar_sound 1>;
-		};
-		simple-audio-card,codec {
-			...
-		};
-	};
-
-	&rcar_sound {
-		...
-		rcar_sound,dai {
-			dai0 {
-				playback = <&src1 &ctu02 &mix0 &dvc0 &ssi0>;
-			};
-			dai1 {
-				playback = <&src2 &ctu03 &mix0 &dvc0 &ssi0>;
-			};
-		};
-	};
+see "Example: simple sound card for MIXer"
 
 =============================================
 * DVC (Digital Volume and Mute Function)
@@ -304,14 +228,7 @@ This is example if SSI1 want to share WS pin with SSI0
 You can use Multi-SSI.
 This is example of SSI0/SSI1/SSI2 (= for 6ch)
 
-	&rcar_sound {
-		...
-		rcar_sound,dai {
-			dai0 {
-				playback = <&ssi0 &ssi1 &ssi2 &src0 &dvc0>;
-			};
-		};
-	};
+see "Example: simple sound card for Multi channel"
 
 ** TDM-SSI
 
@@ -319,19 +236,7 @@ You can use TDM with SSI.
 This is example of TDM 6ch.
 Driver can automatically switches TDM <-> stereo mode in this case.
 
-	rsnd_tdm: sound {
-		compatible = "simple-audio-card";
-		...
-		simple-audio-card,cpu {
-			/* system can use TDM 6ch */
-			dai-tdm-slot-num = <6>;
-			sound-dai = <&rcar_sound>;
-		};
-		simple-audio-card,codec {
-			...
-		};
-	};
-
+see "Example: simple sound card for TDM"
 
 =============================================
 Required properties:
@@ -647,25 +552,102 @@ Example: simple sound card
 };
 
 =============================================
-Example: simple sound card for TDM
+Example: simple sound card for Asynchronous mode
 =============================================
 
-	rsnd_tdm: sound {
-		compatible = "simple-audio-card";
+sound {
+	compatible = "simple-scu-audio-card";
+	...
+	/*
+	 * SRC Asynchronous mode setting
+	 * Playback:
+	 * All input data will be converted to 48kHz
+	 * Capture:
+	 * Inputed 48kHz data will be converted to
+	 * system specified Hz
+	 */
+	simple-audio-card,convert-rate = <48000>;
+	...
+	simple-audio-card,cpu {
+		sound-dai = <&rcar_sound>;
+	};
+	simple-audio-card,codec {
+		...
+	};
+};
 
-		simple-audio-card,format = "left_j";
-		simple-audio-card,bitclock-master = <&sndcodec>;
-		simple-audio-card,frame-master = <&sndcodec>;
+=============================================
+Example: simple sound card for channel convert
+=============================================
 
-		sndcpu: simple-audio-card,cpu {
-			sound-dai = <&rcar_sound>;
-			dai-tdm-slot-num = <6>;
-		};
+sound {
+	compatible = "simple-scu-audio-card";
+	...
+	/*
+	 * CTU setting
+	 * All input data will be converted to 2ch
+	 * as output data
+	 */
+	simple-audio-card,convert-channels = <2>;
+	...
+	simple-audio-card,cpu {
+		sound-dai = <&rcar_sound>;
+	};
+	simple-audio-card,codec {
+		...
+	};
+};
 
-		sndcodec: simple-audio-card,codec {
-			sound-dai = <&xxx>;
+=============================================
+Example: simple sound card for MIXer
+=============================================
+
+sound {
+	compatible = "simple-scu-audio-card";
+	...
+	simple-audio-card,cpu@0 {
+		sound-dai = <&rcar_sound 0>;
+	};
+	simple-audio-card,cpu@1 {
+		sound-dai = <&rcar_sound 1>;
+	};
+	simple-audio-card,codec {
+		...
+	};
+};
+
+&rcar_sound {
+	...
+	rcar_sound,dai {
+		dai0 {
+			playback = <&src1 &ctu02 &mix0 &dvc0 &ssi0>;
+		};
+		dai1 {
+			playback = <&src2 &ctu03 &mix0 &dvc0 &ssi0>;
 		};
 	};
+};
+
+=============================================
+Example: simple sound card for TDM
+=============================================
+
+rsnd_tdm: sound {
+	compatible = "simple-audio-card";
+
+	simple-audio-card,format = "left_j";
+	simple-audio-card,bitclock-master = <&sndcodec>;
+	simple-audio-card,frame-master = <&sndcodec>;
+
+	sndcpu: simple-audio-card,cpu {
+		sound-dai = <&rcar_sound>;
+		dai-tdm-slot-num = <6>;
+	};
+
+	sndcodec: simple-audio-card,codec {
+		sound-dai = <&xxx>;
+	};
+};
 
 =============================================
 Example: simple sound card for Multi channel
-- 
2.19.0.rc2
