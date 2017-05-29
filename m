From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: add audio-graph-scu-card document" to the asoc tree
Date: Mon, 29 May 2017 15:02:50 +0100
Message-ID: <E1dFLFy-0001Of-LL@finisterre>
References: <8737c3oscv.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <8737c3oscv.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: add audio-graph-scu-card document

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

>From be10ee2cd351818738097c782b4493e09c6d14f6 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 18 May 2017 01:44:46 +0000
Subject: [PATCH] ASoC: add audio-graph-scu-card document

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../bindings/sound/audio-graph-scu-card.txt        | 72 ++++++++++++++++++++++
 1 file changed, 72 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/audio-graph-scu-card.txt

diff --git a/Documentation/devicetree/bindings/sound/audio-graph-scu-card.txt b/Documentation/devicetree/bindings/sound/audio-graph-scu-card.txt
new file mode 100644
index 000000000000..b2dd23fd2135
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/audio-graph-scu-card.txt
@@ -0,0 +1,72 @@
+Audio-Graph-SCU-Card:
+
+Audio-Graph-SCU-Card is "Audio-Graph-Card" + "ALSA DPCM".
+
+It is based on common bindings for device graphs.
+see ${LINUX}/Documentation/devicetree/bindings/graph.txt
+
+Basically, Audio-Graph-SCU-Card property is same as
+Simple-Card / Simple-SCU-Card / Audio-Graph-Card.
+see ${LINUX}/Documentation/devicetree/bindings/sound/simple-card.txt
+    ${LINUX}/Documentation/devicetree/bindings/sound/simple-scu-card.txt
+    ${LINUX}/Documentation/devicetree/bindings/sound/audio-graph-card.txt
+
+Below are same as Simple-Card / Audio-Graph-Card.
+
+- label
+- dai-format
+- frame-master
+- bitclock-master
+- bitclock-inversion
+- frame-inversion
+- dai-tdm-slot-num
+- dai-tdm-slot-width
+- clocks / system-clock-frequency
+
+Below are same as Simple-SCU-Card.
+
+- convert-rate
+- convert-channels
+- prefix
+- routing
+
+Required properties:
+
+- compatible				: "audio-graph-scu-card";
+- dais					: list of CPU DAI port{s}
+
+Example
+
+	sound_card {
+		compatible = "audio-graph-scu-card";
+
+		label = "sound-card";
+		prefix = "codec";
+		routing = "codec Playback", "DAI0 Playback",
+			"codec Playback", "DAI1 Playback";
+		convert-rate = <48000>;
+
+		dais = <&cpu_port>;
+	};
+
+	audio-codec {
+		...
+
+		port {
+			codec_endpoint: endpoint {
+				remote-endpoint = <&cpu_endpoint>;
+			};
+		};
+	};
+
+	dai-controller {
+		...
+		cpu_port: port {
+			cpu_endpoint: endpoint {
+				remote-endpoint = <&codec_endpoint>;
+
+				dai-format = "left_j";
+				...
+			};
+		};
+	};
-- 
2.11.0
