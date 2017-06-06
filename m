From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: audio-graph-scu-card: add missing MIX binding example" to the asoc tree
Date: Tue, 06 Jun 2017 20:06:20 +0100
Message-ID: <E1dIJo4-0007Is-Dp@debutante>
References: <87h8ztzw10.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87h8ztzw10.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: audio-graph-scu-card: add missing MIX binding example

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

>From 08862251476f899c4c4528e922df5854076b8661 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 6 Jun 2017 02:37:07 +0000
Subject: [PATCH] ASoC: audio-graph-scu-card: add missing MIX binding example

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../bindings/sound/audio-graph-scu-card.txt        | 47 +++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/audio-graph-scu-card.txt b/Documentation/devicetree/bindings/sound/audio-graph-scu-card.txt
index b2dd23fd2135..b63c5594bbb3 100644
--- a/Documentation/devicetree/bindings/sound/audio-graph-scu-card.txt
+++ b/Documentation/devicetree/bindings/sound/audio-graph-scu-card.txt
@@ -35,7 +35,7 @@ Required properties:
 - compatible				: "audio-graph-scu-card";
 - dais					: list of CPU DAI port{s}
 
-Example
+Example 1. Sampling Rate Conversion
 
 	sound_card {
 		compatible = "audio-graph-scu-card";
@@ -70,3 +70,48 @@ Example
 			};
 		};
 	};
+
+Example 2. 2 CPU 1 Codec (Mixing)
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
+		dais = <&cpu_port0
+			&cpu_port1>;
+	};
+
+	audio-codec {
+		...
+
+		port {
+			codec_endpoint: endpoint {
+				remote-endpoint = <&cpu_endpoint0>;
+			};
+		};
+	};
+
+	dai-controller {
+		...
+		ports {
+			cpu_port0: port {
+				cpu_endpoint0: endpoint {
+					remote-endpoint = <&codec_endpoint>;
+
+					dai-format = "left_j";
+					...
+				};
+			};
+			cpu_port1: port {
+				cpu_endpoint1: endpoint {
+					dai-format = "left_j";
+					...
+				};
+			};
+		};
+	};
-- 
2.11.0
