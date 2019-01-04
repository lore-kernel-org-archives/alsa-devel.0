From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: audio-graph-scu-card: remove
	audio-graph-scu-card on Doc" to the asoc tree
Date: Fri,  4 Jan 2019 14:01:40 +0000 (GMT)
Message-ID: <20190104140140.AB64911270A3@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 64201267C89
 for <alsa-devel@alsa-project.org>; Fri,  4 Jan 2019 15:01:41 +0100 (CET)
In-Reply-To: 
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

   ASoC: audio-graph-scu-card: remove audio-graph-scu-card on Doc

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

>From e4f4fdfc57d9c846862ea6109e356b3a4542df5b Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 18 Dec 2018 11:50:27 +0900
Subject: [PATCH] ASoC: audio-graph-scu-card: remove audio-graph-scu-card on
 Doc

It is already merged into audio-graph-card.
audio-graph-scu-card is no longer needed.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../bindings/sound/audio-graph-scu-card.txt   | 123 ------------------
 1 file changed, 123 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/audio-graph-scu-card.txt

diff --git a/Documentation/devicetree/bindings/sound/audio-graph-scu-card.txt b/Documentation/devicetree/bindings/sound/audio-graph-scu-card.txt
deleted file mode 100644
index 62d42768a00b..000000000000
--- a/Documentation/devicetree/bindings/sound/audio-graph-scu-card.txt
+++ /dev/null
@@ -1,123 +0,0 @@
-Audio-Graph-SCU-Card:
-
-Audio-Graph-SCU-Card is "Audio-Graph-Card" + "ALSA DPCM".
-
-It is based on common bindings for device graphs.
-see ${LINUX}/Documentation/devicetree/bindings/graph.txt
-
-Basically, Audio-Graph-SCU-Card property is same as
-Simple-Card / Simple-SCU-Card / Audio-Graph-Card.
-see ${LINUX}/Documentation/devicetree/bindings/sound/simple-card.txt
-    ${LINUX}/Documentation/devicetree/bindings/sound/simple-scu-card.txt
-    ${LINUX}/Documentation/devicetree/bindings/sound/audio-graph-card.txt
-
-Below are same as Simple-Card / Audio-Graph-Card.
-
-- label
-- dai-format
-- frame-master
-- bitclock-master
-- bitclock-inversion
-- frame-inversion
-- dai-tdm-slot-num
-- dai-tdm-slot-width
-- clocks / system-clock-frequency
-
-Below are same as Simple-SCU-Card.
-
-- convert-rate
-- convert-channels
-- prefix
-- routing
-
-Required properties:
-
-- compatible				: "audio-graph-scu-card";
-- dais					: list of CPU DAI port{s}
-
-Example 1. Sampling Rate Conversion
-
-	sound_card {
-		compatible = "audio-graph-scu-card";
-
-		label = "sound-card";
-		prefix = "codec";
-		routing = "codec Playback", "DAI0 Playback",
-			  "DAI0 Capture",   "codec Capture";
-		convert-rate = <48000>;
-
-		dais = <&cpu_port>;
-	};
-
-	audio-codec {
-		...
-
-		port {
-			codec_endpoint: endpoint {
-				remote-endpoint = <&cpu_endpoint>;
-			};
-		};
-	};
-
-	dai-controller {
-		...
-		cpu_port: port {
-			cpu_endpoint: endpoint {
-				remote-endpoint = <&codec_endpoint>;
-
-				dai-format = "left_j";
-				...
-			};
-		};
-	};
-
-Example 2. 2 CPU 1 Codec (Mixing)
-
-	sound_card {
-		compatible = "audio-graph-scu-card";
-
-		label = "sound-card";
-		routing = "codec Playback", "DAI0 Playback",
-			  "codec Playback", "DAI1 Playback",
-			  "DAI0 Capture",   "codec Capture";
-
-		dais = <&cpu_port0
-			&cpu_port1>;
-	};
-
-	audio-codec {
-		...
-
-		audio-graph-card,prefix = "codec";
-		audio-graph-card,convert-rate = <48000>;
-		port {
-			codec_endpoint0: endpoint {
-				remote-endpoint = <&cpu_endpoint0>;
-			};
-			codec_endpoint1: endpoint {
-				remote-endpoint = <&cpu_endpoint1>;
-			};
-		};
-	};
-
-	dai-controller {
-		...
-		ports {
-			cpu_port0: port {
-				cpu_endpoint0: endpoint {
-					remote-endpoint = <&codec_endpoint0>;
-
-					dai-format = "left_j";
-					...
-				};
-			};
-			cpu_port1: port {
-				cpu_endpoint1: endpoint {
-					remote-endpoint = <&codec_endpoint1>;
-
-					dai-format = "left_j";
-					...
-				};
-			};
-		};
-	};
-- 
2.20.1
