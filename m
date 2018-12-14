From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: audio-graph-card: merge
	audio-graph-scu-card on Doc" to the asoc tree
Date: Fri, 14 Dec 2018 12:37:42 +0000 (GMT)
Message-ID: <20181214123742.F2D5911258A1@debutante.sirena.org.uk>
References: <87k1kc97ae.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id D16E7267C45
 for <alsa-devel@alsa-project.org>; Fri, 14 Dec 2018 13:37:43 +0100 (CET)
In-Reply-To: <87k1kc97ae.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: audio-graph-card: merge audio-graph-scu-card on Doc

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

>From 91a531e48b20677c1f820f3bbd4237abd8144919 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 14 Dec 2018 11:32:06 +0900
Subject: [PATCH] ASoC: audio-graph-card: merge audio-graph-scu-card on Doc

audio-graph-card and audio-graph-scu-card are very similar driver,
but the former is supporting normal sound card,
the latter is supporting DPCM sound card.

We couldn't use normal sound and DPCM sound in same sound card by
audio-graph-card.
This patch merges both feature into it on Documentation.
Now we can use both feature on same driver.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../bindings/sound/audio-graph-card.txt       | 205 ++++++++++++++++++
 1 file changed, 205 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/audio-graph-card.txt b/Documentation/devicetree/bindings/sound/audio-graph-card.txt
index 7e63e53a901c..269682619a70 100644
--- a/Documentation/devicetree/bindings/sound/audio-graph-card.txt
+++ b/Documentation/devicetree/bindings/sound/audio-graph-card.txt
@@ -32,7 +32,9 @@ Required properties:
 Optional properties:
 - pa-gpios: GPIO used to control external amplifier.
 
+-----------------------
 Example: Single DAI case
+-----------------------
 
 	sound_card {
 		compatible = "audio-graph-card";
@@ -61,7 +63,9 @@ Example: Single DAI case
 		};
 	};
 
+-----------------------
 Example: Multi DAI case
+-----------------------
 
 	sound-card {
 		compatible = "audio-graph-card";
@@ -130,3 +134,204 @@ Example: Multi DAI case
 		};
 	};
 
+
+-----------------------
+Example: Sampling Rate Conversion
+-----------------------
+
+	sound_card {
+		compatible = "audio-graph-card";
+
+		label = "sound-card";
+		prefix = "codec";
+		routing = "codec Playback", "DAI0 Playback",
+			  "DAI0 Capture",   "codec Capture";
+		convert-rate = <48000>;
+
+		dais = <&cpu_port>;
+	};
+
+	audio-codec {
+		...
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
+
+-----------------------
+Example: 2 CPU 1 Codec (Mixing)
+-----------------------
+
+	sound_card {
+		compatible = "audio-graph-card";
+
+		label = "sound-card";
+		routing = "codec Playback", "DAI0 Playback",
+			  "codec Playback", "DAI1 Playback",
+			  "DAI0 Capture",   "codec Capture";
+
+		dais = <&cpu_port>;
+	};
+
+	audio-codec {
+		...
+
+		audio-graph-card,prefix = "codec";
+		audio-graph-card,convert-rate = <48000>;
+		port {
+			reg = <0>;
+			codec_endpoint0: endpoint@0 {
+				remote-endpoint = <&cpu_endpoint0>;
+			};
+			codec_endpoint1: endpoint@1 {
+				remote-endpoint = <&cpu_endpoint1>;
+			};
+		};
+	};
+
+	dai-controller {
+		...
+		cpu_port: port {
+			cpu_endpoint0: endpoint@0 {
+				remote-endpoint = <&codec_endpoint0>;
+
+				dai-format = "left_j";
+				...
+			};
+			cpu_endpoint1: endpoint@1 {
+				remote-endpoint = <&codec_endpoint1>;
+
+				dai-format = "left_j";
+				...
+			};
+		};
+	};
+
+-----------------------
+Example: Multi DAI with DPCM
+-----------------------
+
+	CPU0 ------ ak4613
+	CPU1 ------ HDMI
+	CPU2 ------ PCM3168A-p	/* DPCM 1ch/2ch */
+	CPU3 --/		/* DPCM 3ch/4ch */
+	CPU4 --/		/* DPCM 5ch/6ch */
+	CPU5 --/		/* DPCM 7ch/8ch */
+	CPU6 ------ PCM3168A-c
+
+	sound_card: sound {
+		compatible = "audio-graph-card";
+
+		label = "sound-card";
+
+		routing =	"pcm3168a Playback", "DAI2 Playback",
+				"pcm3168a Playback", "DAI3 Playback",
+				"pcm3168a Playback", "DAI4 Playback",
+				"pcm3168a Playback", "DAI5 Playback";
+
+		dais = <&snd_port0	/* ak4613 */
+			&snd_port1	/* HDMI0  */
+			&snd_port2	/* pcm3168a playback */
+			&snd_port3	/* pcm3168a capture  */
+			>;
+	};
+
+	ak4613: codec@10 {
+		...
+		port {
+			ak4613_endpoint: endpoint {
+				remote-endpoint = <&rsnd_endpoint0>;
+			};
+		};
+	};
+
+	pcm3168a: audio-codec@44 {
+		...
+		audio-graph-card,prefix = "pcm3168a";
+		audio-graph-card,convert-channels = <8>; /* TDM Split */
+		ports {
+			port@0 {
+				reg = <0>;
+				pcm3168a_endpoint_p1: endpoint@1 {
+					remote-endpoint = <&rsnd_endpoint2>;
+					...
+				};
+				pcm3168a_endpoint_p2: endpoint@2 {
+					remote-endpoint = <&rsnd_endpoint3>;
+					...
+				};
+				pcm3168a_endpoint_p3: endpoint@3 {
+					remote-endpoint = <&rsnd_endpoint4>;
+					...
+				};
+				pcm3168a_endpoint_p4: endpoint@4 {
+					remote-endpoint = <&rsnd_endpoint5>;
+					...
+				};
+			};
+			port@1 {
+				reg = <1>;
+				pcm3168a_endpoint_c: endpoint {
+					remote-endpoint = <&rsnd_endpoint6>;
+					...
+				};
+			};
+		};
+	};
+
+	&sound {
+		ports {
+			snd_port0: port@0 {
+				rsnd_endpoint0: endpoint {
+					remote-endpoint = <&ak4613_endpoint>;
+					...
+				};
+			};
+			snd_port1: port@1 {
+				rsnd_endpoint1: endpoint {
+					remote-endpoint = <&dw_hdmi0_snd_in>;
+					...
+				};
+			};
+			snd_port2: port@2 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				rsnd_endpoint2: endpoint@2 {
+					remote-endpoint = <&pcm3168a_endpoint_p1>;
+					...
+				};
+				rsnd_endpoint3: endpoint@3 {
+					remote-endpoint = <&pcm3168a_endpoint_p2>;
+					...
+				};
+				rsnd_endpoint4: endpoint@4 {
+					remote-endpoint = <&pcm3168a_endpoint_p3>;
+					...
+				};
+				rsnd_endpoint5: endpoint@5 {
+					remote-endpoint = <&pcm3168a_endpoint_p4>;
+					...
+				};
+			};
+			snd_port3: port@6 {
+				rsnd_endpoint6: endpoint {
+					remote-endpoint = <&pcm3168a_endpoint_c>;
+					...
+				};
+			};
+		};
+	};
-- 
2.19.0.rc2
