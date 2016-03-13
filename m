From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: add simplified module
	explanation" to the asoc tree
Date: Sun, 13 Mar 2016 15:14:54 +0700
Message-ID: <E1af1As-0004Fb-On@finisterre>
References: <87oaamvrae.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1CE27260504
 for <alsa-devel@alsa-project.org>; Sun, 13 Mar 2016 09:15:11 +0100 (CET)
In-Reply-To: <87oaamvrae.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: add simplified module explanation

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

>From f1511a14a4a94d063cf8f8f12f36cf2ebb0cc8a8 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 10 Mar 2016 05:29:21 +0000
Subject: [PATCH] ASoC: rsnd: add simplified module explanation

Renesas sound driver user needs to read its datasheet when create DT.
But it is difficult to understand, because it has many modules
(SRC/CTU/MIX/DVC/SSIU/SSI/AudioDMAC/AudioDMACperiperi),
and many features (Asynchronous/Synchronous mode on SRC, CTU matrix,
DVC volume settings feature, Multi-SSI/TDM-SSI, etc).
This patch adds simplified explanation to help setting/understanding.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/renesas,rsnd.txt     | 340 +++++++++++++++++++++
 sound/soc/sh/rcar/dvc.c                            |  23 ++
 2 files changed, 363 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
index 8ee0fa91e4a0..c7b29df4a963 100644
--- a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
+++ b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
@@ -1,6 +1,337 @@
 Renesas R-Car sound
 
+=============================================
+* Modules
+=============================================
+
+Renesas R-Car sound is constructed from below modules
+(for Gen2 or later)
+
+ SCU		: Sampling Rate Converter Unit
+  - SRC		: Sampling Rate Converter
+  - CMD
+   - CTU	: Channel Transfer Unit
+   - MIX	: Mixer
+   - DVC	: Digital Volume and Mute Function
+ SSIU		: Serial Sound Interface Unit
+ SSI		: Serial Sound Interface
+
+See detail of each module's channels, connection, limitation on datasheet
+
+=============================================
+* Multi channel
+=============================================
+
+Multi channel is supported by Multi-SSI, or TDM-SSI.
+
+ Multi-SSI	: 6ch case, you can use stereo x 3 SSI
+ TDM-SSI	: 6ch case, you can use TDM
+
+=============================================
+* Enable/Disable each modules
+=============================================
+
+See datasheet to check SRC/CTU/MIX/DVC connect-limitation.
+DT controls enabling/disabling module.
+${LINUX}/arch/arm/boot/dts/r8a7790-lager.dts can be good example.
+This is example of
+
+Playback: [MEM] -> [SRC2] -> [DVC0] -> [SSIU0/SSI0] -> [codec]
+Capture:  [MEM] <- [DVC1] <- [SRC3] <- [SSIU1/SSI1] <- [codec]
+
+	&rcar_sound {
+		...
+		rcar_sound,dai {
+			dai0 {
+				playback = <&ssi0 &src2 &dvc0>;
+				capture  = <&ssi1 &src3 &dvc1>;
+			};
+		};
+	};
+
+You can use below.
+${LINUX}/arch/arm/boot/dts/r8a7790.dts can be good example.
+
+	&src0	&ctu00	&mix0	&dvc0	&ssi0
+	&src1	&ctu01	&mix1	&dvc1	&ssi1
+	&src2	&ctu02			&ssi2
+	&src3	&ctu03			&ssi3
+	&src4				&ssi4
+	&src5	&ctu10			&ssi5
+	&src6	&ctu11			&ssi6
+	&src7	&ctu12			&ssi7
+	&src8	&ctu13			&ssi8
+	&src9				&ssi9
+
+=============================================
+* SRC (Sampling Rate Converter)
+=============================================
+
+ [xx]Hz        [yy]Hz
+ ------> [SRC] ------>
+
+SRC can convert [xx]Hz to [yy]Hz. Then, it has below 2 modes
+
+ Asynchronous mode:	input data / output data are based on different clocks.
+			you can use this mode on Playback / Capture
+ Synchronous mode:	input data / output data are based on same clocks.
+			This mode will be used if system doesn't have its input clock,
+			for example digital TV case.
+			you can use this mode on Playback
+
+------------------
+**     Asynchronous mode
+------------------
+
+You need to use "renesas,rsrc-card" sound card for it.
+example)
+
+	sound {
+		compatible = "renesas,rsrc-card";
+		...
+		/*
+		 * SRC Asynchronous mode setting
+		 * Playback:
+		 * All input data will be converted to 48kHz
+		 * Capture:
+		 * Inputed 48kHz data will be converted to
+		 * system specified Hz
+		 */
+		convert-rate = <48000>;
+		...
+		cpu {
+			sound-dai = <&rcar_sound>;
+		};
+		codec {
+			...
+		};
+	};
+
+------------------
+**     Synchronous mode
+------------------
+
+	> amixer set "SRC Out Rate" on
+	> aplay xxxx.wav
+	> amixer set "SRC Out Rate" 48000
+	> amixer set "SRC Out Rate" 44100
+
+=============================================
+* CTU (Channel Transfer Unit)
+=============================================
+
+ [xx]ch        [yy]ch
+ ------> [CTU] -------->
+
+CTU can convert [xx]ch to [yy]ch, or exchange outputed channel.
+CTU conversion needs matrix settings.
+For more detail information, see below
+
+	Renesas R-Car datasheet
+	 - Sampling Rate Converter Unit (SCU)
+	  - SCU Operation
+	   - CMD Block
+	    - Functional Blocks in CMD
+
+	Renesas R-Car datasheet
+	 - Sampling Rate Converter Unit (SCU)
+	  - Register Description
+	   - CTUn Scale Value exx Register (CTUn_SVxxR)
+
+	${LINUX}/sound/soc/sh/rcar/ctu.c
+	 - comment of header
+
+You need to use "renesas,rsrc-card" sound card for it.
+example)
+
+	sound {
+		compatible = "renesas,rsrc-card";
+		...
+		/*
+		 * CTU setting
+		 * All input data will be converted to 2ch
+		 * as output data
+		 */
+		convert-channels = <2>;
+		...
+		cpu {
+			sound-dai = <&rcar_sound>;
+		};
+		codec {
+			...
+		};
+	};
+
+Ex) Exchange output channel
+ Input -> Output
+  1ch  ->  0ch
+  0ch  ->  1ch
+
+  example of using matrix
+	output 0ch = (input 0ch x 0) + (input 1ch x 1)
+	output 1ch = (input 0ch x 1) + (input 1ch x 0)
+
+	amixer set "CTU Reset" on
+	amixer set "CTU Pass" 9,10
+	amixer set "CTU SV0" 0,4194304
+	amixer set "CTU SV1" 4194304,0
+
+ example of changing connection
+	amixer set "CTU Reset" on
+	amixer set "CTU Pass" 2,1
+
+=============================================
+* MIX (Mixer)
+=============================================
+
+MIX merges 2 sounds path. You can see 2 sound interface on system,
+and these sounds will be merged by MIX.
+
+	aplay -D plughw:0,0 xxxx.wav &
+	aplay -D plughw:0,1 yyyy.wav
+
+You need to use "renesas,rsrc-card" sound card for it.
+Ex)
+	[MEM] -> [SRC1] -> [CTU02] -+-> [MIX0] -> [DVC0] -> [SSI0]
+	                            |
+	[MEM] -> [SRC2] -> [CTU03] -+
+
+	sound {
+		compatible = "renesas,rsrc-card";
+		...
+		cpu@0 {
+			sound-dai = <&rcar_sound 0>;
+		};
+		cpu@1 {
+			sound-dai = <&rcar_sound 1>;
+		};
+		codec {
+			...
+		};
+	};
+
+	&rcar_sound {
+		...
+		rcar_sound,dai {
+			dai0 {
+				playback = <&src1 &ctu02 &mix0 &dvc0 &ssi0>;
+			};
+			dai1 {
+				playback = <&src2 &ctu03 &mix0 &dvc0 &ssi0>;
+			};
+		};
+	};
+
+=============================================
+* DVC (Digital Volume and Mute Function)
+=============================================
+
+DVC controls Playback/Capture volume.
+
+Playback Volume
+	amixer set "DVC Out" 100%
+
+Capture Volume
+	amixer set "DVC In" 100%
+
+Playback Mute
+	amixer set "DVC Out Mute" on
+
+Capture Mute
+	amixer set "DVC In Mute" on
+
+Volume Ramp
+	amixer set "DVC Out Ramp Up Rate"   "0.125 dB/64 steps"
+	amixer set "DVC Out Ramp Down Rate" "0.125 dB/512 steps"
+	amixer set "DVC Out Ramp" on
+	aplay xxx.wav &
+	amixer set "DVC Out"  80%  // Volume Down
+	amixer set "DVC Out" 100%  // Volume Up
+
+=============================================
+* SSIU (Serial Sound Interface Unit)
+=============================================
+
+There is no DT settings for SSIU, because SSIU will be automatically
+selected via SSI.
+SSIU can avoid some under/over run error, because it has some buffer.
+But you can't use it if SSI was PIO mode.
+In DMA mode, you can select not to use SSIU by using "no-busif" on DT.
+
+	&ssi0 {
+		no-busif;
+	};
+
+=============================================
+* SSI (Serial Sound Interface)
+=============================================
+
+**  PIO mode
+
+You can use PIO mode which is for connection check by using.
+Note: The system will drop non-SSI modules in PIO mode
+even though if DT is selecting other modules.
+
+	&ssi0 {
+		pio-transfer
+	};
+
+** DMA mode without SSIU
+
+You can use DMA without SSIU.
+Note: under/over run, or noise are likely to occur
+
+	&ssi0 {
+		no-busif;
+	};
+
+** PIN sharing
+
+Each SSI can share WS pin. It is based on platform.
+This is example if SSI1 want to share WS pin with SSI0
+
+	&ssi1 {
+		shared-pin;
+	};
+
+** Multi-SSI
+
+You can use Multi-SSI.
+This is example of SSI0/SSI1/SSI2 (= for 6ch)
+
+	&rcar_sound {
+		...
+		rcar_sound,dai {
+			dai0 {
+				playback = <&ssi0 &ssi1 &ssi2 &src0 &dvc0>;
+			};
+		};
+	};
+
+** TDM-SSI
+
+You can use TDM with SSI.
+This is example of TDM 6ch.
+Driver can automatically switches TDM <-> stereo mode in this case.
+
+	rsnd_tdm: sound {
+		compatible = "simple-audio-card";
+		...
+		simple-audio-card,cpu {
+			/* system can use TDM 6ch */
+			dai-tdm-slot-num = <6>;
+			sound-dai = <&rcar_sound>;
+		};
+		simple-audio-card,codec {
+			...
+		};
+	};
+
+
+=============================================
 Required properties:
+=============================================
+
 - compatible			: "renesas,rcar_sound-<soctype>", fallbacks
 				  "renesas,rcar_sound-gen1" if generation1, and
 				  "renesas,rcar_sound-gen2" if generation2
@@ -64,7 +395,10 @@ DAI subnode properties:
 - playback			: list of playback modules
 - capture			: list of capture  modules
 
+
+=============================================
 Example:
+=============================================
 
 rcar_sound: sound@ec500000 {
 	#sound-dai-cells = <1>;
@@ -250,7 +584,9 @@ rcar_sound: sound@ec500000 {
 	};
 };
 
+=============================================
 Example: simple sound card
+=============================================
 
 	rsnd_ak4643: sound {
 		compatible = "simple-audio-card";
@@ -290,7 +626,9 @@ Example: simple sound card
 	shared-pin;
 };
 
+=============================================
 Example: simple sound card for TDM
+=============================================
 
 	rsnd_tdm: sound {
 		compatible = "simple-audio-card";
@@ -309,7 +647,9 @@ Example: simple sound card for TDM
 		};
 	};
 
+=============================================
 Example: simple sound card for Multi channel
+=============================================
 
 &rcar_sound {
 	pinctrl-0 = <&sound_pins &sound_clk_pins>;
diff --git a/sound/soc/sh/rcar/dvc.c b/sound/soc/sh/rcar/dvc.c
index 93b11e1c5d7f..02d971f69eff 100644
--- a/sound/soc/sh/rcar/dvc.c
+++ b/sound/soc/sh/rcar/dvc.c
@@ -8,6 +8,29 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+
+/*
+ * Playback Volume
+ *	amixer set "DVC Out" 100%
+ *
+ * Capture Volume
+ *	amixer set "DVC In" 100%
+ *
+ * Playback Mute
+ *	amixer set "DVC Out Mute" on
+ *
+ * Capture Mute
+ *	amixer set "DVC In Mute" on
+ *
+ * Volume Ramp
+ *	amixer set "DVC Out Ramp Up Rate"   "0.125 dB/64 steps"
+ *	amixer set "DVC Out Ramp Down Rate" "0.125 dB/512 steps"
+ *	amixer set "DVC Out Ramp" on
+ *	aplay xxx.wav &
+ *	amixer set "DVC Out"  80%  // Volume Down
+ *	amixer set "DVC Out" 100%  // Volume Up
+ */
+
 #include "rsnd.h"
 
 #define RSND_DVC_NAME_SIZE	16
-- 
2.7.0
