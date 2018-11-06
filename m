From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: add TDM Split mode support for
	Document" to the asoc tree
Date: Tue,  6 Nov 2018 17:52:17 +0000 (GMT)
Message-ID: <20181106175217.E5875112266B@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id A4FB72678F2
 for <alsa-devel@alsa-project.org>; Tue,  6 Nov 2018 18:52:18 +0100 (CET)
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

   ASoC: rsnd: add TDM Split mode support for Document

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

>From cf704dc83fd6600758e98ac71769eaeb00dfc770 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 6 Nov 2018 05:21:22 +0000
Subject: [PATCH] ASoC: rsnd: add TDM Split mode support for Document

This patch adds TDM Split mode support. rsnd driver is assuming
audio-graph-scu-card is used for Sound Card.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../bindings/sound/renesas,rsnd.txt           | 91 +++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
index 6ed1a3658ffd..453e8ec2ac78 100644
--- a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
+++ b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
@@ -188,6 +188,25 @@ In DMA mode, you can select not to use SSIU by using "no-busif" via SSI.
 SSIU handles BUSIF which will be used for TDM Split mode.
 This driver is assuming that audio-graph card will be used.
 
+TDM Split mode merges 4 sounds. You can see 4 sound interface on system,
+and these sounds will be merged SSIU/SSI.
+
+	aplay -D plughw:0,0 xxxx.wav &
+	aplay -D plughw:0,1 xxxx.wav &
+	aplay -D plughw:0,2 xxxx.wav &
+	aplay -D plughw:0,3 xxxx.wav
+
+	          2ch                     8ch
+	[MEM] -> [SSIU 30] -+-> [SSIU 3] --> [Codec]
+	          2ch       |
+	[MEM] -> [SSIU 31] -+
+	          2ch       |
+	[MEM] -> [SSIU 32] -+
+	          2ch       |
+	[MEM] -> [SSIU 33] -+
+
+see "Example: simple sound card for TDM Split"
+
 =============================================
 * SSI (Serial Sound Interface)
 =============================================
@@ -648,6 +667,78 @@ rsnd_tdm: sound {
 	};
 };
 
+=============================================
+Example: simple sound card for TDM Split
+=============================================
+
+sound_card: sound {
+	compatible = "audio-graph-scu-card";
+	prefix = "xxxx";
+	routing = "xxxx Playback", "DAI0 Playback",
+		  "xxxx Playback", "DAI1 Playback",
+		  "xxxx Playback", "DAI2 Playback",
+		  "xxxx Playback", "DAI3 Playback";
+	convert-channels = <8>; /* TDM Split */
+
+	dais = <&rsnd_port0     /* playback ch1/ch2 */
+		&rsnd_port1     /* playback ch3/ch4 */
+		&rsnd_port2     /* playback ch5/ch6 */
+		&rsnd_port3     /* playback ch7/ch8 */
+		>;
+};
+
+audio-codec {
+	...
+	port {
+		codec_0: endpoint@1 {
+			remote-endpoint = <&rsnd_ep0>;
+		};
+		codec_1: endpoint@2 {
+			remote-endpoint = <&rsnd_ep1>;
+		};
+		codec_2: endpoint@3 {
+			remote-endpoint = <&rsnd_ep2>;
+		};
+		codec_3: endpoint@4 {
+			remote-endpoint = <&rsnd_ep3>;
+		};
+	};
+};
+
+&rcar_sound {
+	...
+	ports {
+		rsnd_port0: port@0 {
+			rsnd_ep0: endpoint {
+				remote-endpoint = <&codec_0>;
+				...
+				playback = <&ssiu30 &ssi3>;
+			};
+		};
+		rsnd_port1: port@1 {
+			rsnd_ep1: endpoint {
+				remote-endpoint = <&codec_1>;
+				...
+				playback = <&ssiu31 &ssi3>;
+			};
+		};
+		rsnd_port2: port@2 {
+			rsnd_ep2: endpoint {
+				remote-endpoint = <&codec_2>;
+				...
+				playback = <&ssiu32 &ssi3>;
+			};
+		};
+		rsnd_port3: port@3 {
+			rsnd_ep3: endpoint {
+				remote-endpoint = <&codec_3>;
+				...
+				playback = <&ssiu33 &ssi3>;
+			};
+		};
+	};
+};
+
 =============================================
 Example: simple sound card for Multi channel
 =============================================
-- 
2.19.0.rc2
