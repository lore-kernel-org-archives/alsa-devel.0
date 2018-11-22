From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 04/10] ASoC: audio-graph-scu-card: tidyup
 "prefix" parsing on Doc
Date: Thu, 22 Nov 2018 00:55:54 +0000
Message-ID: <87va4qlz0w.wl-kuninori.morimoto.gx@renesas.com>
References: <871s7endnu.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from JPN01-TY1-obe.outbound.protection.outlook.com
 (mail-eopbgr1400112.outbound.protection.outlook.com [40.107.140.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 0C704267A7F
 for <alsa-devel@alsa-project.org>; Thu, 22 Nov 2018 01:55:57 +0100 (CET)
In-Reply-To: <871s7endnu.wl-kuninori.morimoto.gx@renesas.com>
Content-Language: en-US
Content-ID: <B8429D2DC2FFE14CAC48D7EB6BC135CA@jpnprd01.prod.outlook.com>
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

audio-graph-scu-card.c is supporting "prefix" which is used to avoid
DAI naming conflict when CPU/Codec matching.
But, sound card might have multi sub-devices, and each codec might need
each prefix.

Now, ASoC is supporting snd_soc_of_parse_node_prefix(), let's support
it on audio-graph-scu-card, too. It is keeping existing DT style.

It can't support each codec's prefix if sound card had multi sub-devices
without this patch.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 Documentation/devicetree/bindings/sound/audio-graph-scu-card.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/audio-graph-scu-card.txt b/Documentation/devicetree/bindings/sound/audio-graph-scu-card.txt
index 441dd6f..a361088 100644
--- a/Documentation/devicetree/bindings/sound/audio-graph-scu-card.txt
+++ b/Documentation/devicetree/bindings/sound/audio-graph-scu-card.txt
@@ -77,7 +77,6 @@ Example 2. 2 CPU 1 Codec (Mixing)
 		compatible = "audio-graph-scu-card";
 
 		label = "sound-card";
-		prefix = "codec";
 		routing = "codec Playback", "DAI0 Playback",
 			  "codec Playback", "DAI1 Playback",
 			  "DAI0 Capture",   "codec Capture";
@@ -90,6 +89,7 @@ Example 2. 2 CPU 1 Codec (Mixing)
 	audio-codec {
 		...
 
+		audio-graph-card,prefix = "codec";
 		port {
 			codec_endpoint0: endpoint {
 				remote-endpoint = <&cpu_endpoint0>;
-- 
2.7.4
