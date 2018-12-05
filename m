From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 1/6] ASoC: audio-graph-card: merge
	audio-graph-scu-card on Doc
Date: Wed, 5 Dec 2018 01:30:31 +0000
Message-ID: <87zhtkdb0q.wl-kuninori.morimoto.gx@renesas.com>
References: <871s6wepmp.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from JPN01-TY1-obe.outbound.protection.outlook.com
 (mail-eopbgr1400137.outbound.protection.outlook.com [40.107.140.137])
 by alsa0.perex.cz (Postfix) with ESMTP id 12FAF267B8A
 for <alsa-devel@alsa-project.org>; Wed,  5 Dec 2018 02:30:36 +0100 (CET)
In-Reply-To: <871s6wepmp.wl-kuninori.morimoto.gx@renesas.com>
Content-Language: en-US
Content-ID: <4A933D0846F4B0468892A381FBF6DBA8@jpnprd01.prod.outlook.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

audio-graph-card and audio-graph-scu-card are very similar driver,
but the former is supporting normal sound card,
the latter is supporting DPCM sound card.

We couldn't use normal sound and DPCM sound in same sound card by
audio-graph-card.
This patch merges both feature into it on Documentation.
Now we can use both feature on same driver.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 .../devicetree/bindings/sound/audio-graph-card.txt | 222 +++++++++++++++++++++
 1 file changed, 222 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/audio-graph-card.txt b/Documentation/devicetree/bindings/sound/audio-graph-card.txt
index 7e63e53..3d19c9b 100644
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
@@ -130,3 +134,221 @@ Example: Multi DAI case
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
+		dais = <&cpu_port0
+			&cpu_port1>;
+	};
+
+	audio-codec {
+		...
+
+		audio-graph-card,prefix = "codec";
+		audio-graph-card,convert-rate = <48000>;
+		port {
+			codec_endpoint0: endpoint {
+				remote-endpoint = <&cpu_endpoint0>;
+			};
+			codec_endpoint1: endpoint {
+				remote-endpoint = <&cpu_endpoint1>;
+			};
+		};
+	};
+
+	dai-controller {
+		...
+		ports {
+			cpu_port0: port {
+				cpu_endpoint0: endpoint {
+					remote-endpoint = <&codec_endpoint0>;
+
+					dai-format = "left_j";
+					...
+				};
+			};
+			cpu_port1: port {
+				cpu_endpoint1: endpoint {
+					remote-endpoint = <&codec_endpoint1>;
+
+					dai-format = "left_j";
+					...
+				};
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
+			&snd_port2	/* pcm3168a playback 1ch/2ch */
+			&snd_port3	/* pcm3168a playback 3ch/4ch */
+			&snd_port4	/* pcm3168a playback 5ch/6ch */
+			&snd_port5	/* pcm3168a playback 7ch/8ch */
+			&snd_port6	/* pcm3168a capture  */
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
+			rsnd_port0: port@0 {
+				reg = <0>;
+				rsnd_endpoint0: endpoint {
+					remote-endpoint = <&ak4613_endpoint>;
+					...
+				};
+			};
+			rsnd_port1: port@1 {
+				reg = <1>;
+				rsnd_endpoint1: endpoint {
+					remote-endpoint = <&dw_hdmi0_snd_in>;
+					...
+				};
+			};
+			rsnd_port2: port@2 {
+				reg = <2>;
+				rsnd_endpoint2: endpoint {
+					remote-endpoint = <&pcm3168a_endpoint_p1>;
+					...
+				};
+			};
+			rsnd_port3: port@3 {
+				reg = <3>;
+				rsnd_endpoint3: endpoint {
+					remote-endpoint = <&pcm3168a_endpoint_p2>;
+					...
+				};
+			};
+			rsnd_port4: port@4 {
+				reg = <4>;
+				rsnd_endpoint4: endpoint {
+					remote-endpoint = <&pcm3168a_endpoint_p3>;
+					...
+				};
+			};
+			rsnd_port5: port@5 {
+				reg = <5>;
+				rsnd_endpoint5: endpoint {
+					remote-endpoint = <&pcm3168a_endpoint_p4>;
+					...
+			};
+			rsnd_port6: port@6 {
+				reg = <6>;
+				rsnd_endpoint6: endpoint {
+					remote-endpoint = <&pcm3168a_endpoint_c>;
+					...
+				};
+			};
+		};
+	};
-- 
2.7.4
