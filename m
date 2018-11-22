From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 06/10] ASoC: audio-graph-scu-card: tidyup
 "convert-rate/channels" parsing on Doc
Date: Thu, 22 Nov 2018 00:56:41 +0000
Message-ID: <87sgzulyzm.wl-kuninori.morimoto.gx@renesas.com>
References: <871s7endnu.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from JPN01-TY1-obe.outbound.protection.outlook.com
 (mail-eopbgr1400104.outbound.protection.outlook.com [40.107.140.104])
 by alsa0.perex.cz (Postfix) with ESMTP id 147B7267961
 for <alsa-devel@alsa-project.org>; Thu, 22 Nov 2018 01:56:43 +0100 (CET)
In-Reply-To: <871s7endnu.wl-kuninori.morimoto.gx@renesas.com>
Content-Language: en-US
Content-ID: <F6123503FEB3474DBCB7FCE92FDC6F6A@jpnprd01.prod.outlook.com>
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

audio-graph-scu-card.c is supporting "convert-rate/channels" which is
used for DPCM.
But, sound card might have multi codecs, and each codec might need
each convert-rate/channels.

This patch supports each codec's convert-rate/channles support.
top node convert-rate/channels will overwrite settings if exist.

It can't support each codec's convert-rate/channels if sound card had
multi codecs without this patch.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 Documentation/devicetree/bindings/sound/audio-graph-scu-card.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/audio-graph-scu-card.txt b/Documentation/devicetree/bindings/sound/audio-graph-scu-card.txt
index a361088..62d4276 100644
--- a/Documentation/devicetree/bindings/sound/audio-graph-scu-card.txt
+++ b/Documentation/devicetree/bindings/sound/audio-graph-scu-card.txt
@@ -80,7 +80,6 @@ Example 2. 2 CPU 1 Codec (Mixing)
 		routing = "codec Playback", "DAI0 Playback",
 			  "codec Playback", "DAI1 Playback",
 			  "DAI0 Capture",   "codec Capture";
-		convert-rate = <48000>;
 
 		dais = <&cpu_port0
 			&cpu_port1>;
@@ -90,6 +89,7 @@ Example 2. 2 CPU 1 Codec (Mixing)
 		...
 
 		audio-graph-card,prefix = "codec";
+		audio-graph-card,convert-rate = <48000>;
 		port {
 			codec_endpoint0: endpoint {
 				remote-endpoint = <&cpu_endpoint0>;
-- 
2.7.4
