From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 02/10] ASoC: simple-scu-card: tidyup "prefix"
	parsing on Doc
Date: Thu, 22 Nov 2018 00:55:24 +0000
Message-ID: <87y39mlz1s.wl-kuninori.morimoto.gx@renesas.com>
References: <871s7endnu.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from JPN01-TY1-obe.outbound.protection.outlook.com
 (mail-eopbgr1400091.outbound.protection.outlook.com [40.107.140.91])
 by alsa0.perex.cz (Postfix) with ESMTP id 3F2AF26770D
 for <alsa-devel@alsa-project.org>; Thu, 22 Nov 2018 01:55:27 +0100 (CET)
In-Reply-To: <871s7endnu.wl-kuninori.morimoto.gx@renesas.com>
Content-Language: en-US
Content-ID: <093E637C8F22E140BE4300C1F299DF37@jpnprd01.prod.outlook.com>
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

simple-scu-card.c is supporting "prefix" which is used to avoid
DAI naming conflict when CPU/Codec matching.
But, sound card might have multi sub-devices, and each codec might need
each prefix.

Now, ASoC is supporting snd_soc_of_parse_node_prefix(), let's support
it on audio-graph-scu-card, too. It is keeping existing DT style.

It can't support each codec's prefix if sound card had multi sub-devices
without this patch.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 Documentation/devicetree/bindings/sound/simple-scu-card.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/simple-scu-card.txt b/Documentation/devicetree/bindings/sound/simple-scu-card.txt
index 32f8dbc..3a2f716 100644
--- a/Documentation/devicetree/bindings/sound/simple-scu-card.txt
+++ b/Documentation/devicetree/bindings/sound/simple-scu-card.txt
@@ -75,7 +75,6 @@ sound {
 	simple-audio-card,bitclock-master = <&dpcmcpu>;
 	simple-audio-card,frame-master = <&dpcmcpu>;
 
-	simple-audio-card,prefix = "ak4642";
 	simple-audio-card,routing = "ak4642 Playback", "DAI0 Playback",
 			"ak4642 Playback", "DAI1 Playback";
 
@@ -88,6 +87,7 @@ sound {
 	};
 
 	codec {
+		prefix = "ak4642";
 		sound-dai = <&ak4643>;
 		clocks = <&audio_clock>;
 	};
-- 
2.7.4
