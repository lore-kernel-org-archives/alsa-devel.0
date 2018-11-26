From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH] ASoC: soc.h: makes
	snd_soc_of_parse_audio_prefix() inline
Date: Mon, 26 Nov 2018 01:21:22 +0000
Message-ID: <87h8g43an3.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from JPN01-TY1-obe.outbound.protection.outlook.com
 (mail-eopbgr1400094.outbound.protection.outlook.com [40.107.140.94])
 by alsa0.perex.cz (Postfix) with ESMTP id 85F162679A7
 for <alsa-devel@alsa-project.org>; Mon, 26 Nov 2018 02:21:26 +0100 (CET)
Content-Language: en-US
Content-ID: <B597A0055E8845418DD264459BE49CE6@jpnprd01.prod.outlook.com>
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

commit 3b7103562c03c ("ASoC: soc-core: add
snd_soc_of_parse_node_prefix()") maked snd_soc_of_parse_audio_prefix()
as #define. But it'd be better to make this a static inline rather than
a #define. It helps with error messages and type safety.
This patch makes it inline.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 include/sound/soc.h | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 37155f9..8ec1de8 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1481,9 +1481,15 @@ void snd_soc_of_parse_node_prefix(struct device_node *np,
 				   struct snd_soc_codec_conf *codec_conf,
 				   struct device_node *of_node,
 				   const char *propname);
-#define snd_soc_of_parse_audio_prefix(card, conf, node, name) \
-	snd_soc_of_parse_node_prefix((card)->dev->of_node,    \
-				     (conf), (node), (name))
+static inline
+void snd_soc_of_parse_audio_prefix(struct snd_soc_card *card,
+				   struct snd_soc_codec_conf *codec_conf,
+				   struct device_node *of_node,
+				   const char *propname)
+{
+	snd_soc_of_parse_node_prefix(card->dev->of_node,
+				     codec_conf, of_node, propname);
+}
 
 int snd_soc_of_parse_audio_routing(struct snd_soc_card *card,
 				   const char *propname);
-- 
2.7.4
