From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 01/10] ASoC: soc-core: add
	snd_soc_of_parse_node_prefix()
Date: Thu, 22 Nov 2018 00:55:09 +0000
Message-ID: <87zhu2lz26.wl-kuninori.morimoto.gx@renesas.com>
References: <871s7endnu.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from JPN01-OS2-obe.outbound.protection.outlook.com
 (mail-eopbgr1410129.outbound.protection.outlook.com [40.107.141.129])
 by alsa0.perex.cz (Postfix) with ESMTP id 534D426770D
 for <alsa-devel@alsa-project.org>; Thu, 22 Nov 2018 01:55:12 +0100 (CET)
In-Reply-To: <871s7endnu.wl-kuninori.morimoto.gx@renesas.com>
Content-Language: en-US
Content-ID: <C06AE878FCEEBB4AB73DE95C9868BD89@jpnprd01.prod.outlook.com>
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

Current ASoC has snd_soc_of_parse_audio_prefix() to get codec_conf
settings from DT which is used to avoid DAI naming conflict when
CPU/Codec matching.

Currently, it is parsing from "top node",
but, we want to parse from "each sub node" if sound card had multi
cpus/codecs.

This patch adds new snd_soc_of_parse_node_prefix() to allow parsing
settings from selected node.
It is keeping existing snd_soc_of_parse_audio_prefix() by using macro.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 include/sound/soc.h  |  6 +++++-
 sound/soc/soc-core.c | 11 +++++------
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 5a8b841..93b7510 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1477,10 +1477,14 @@ int snd_soc_of_parse_tdm_slot(struct device_node *np,
 			      unsigned int *rx_mask,
 			      unsigned int *slots,
 			      unsigned int *slot_width);
-void snd_soc_of_parse_audio_prefix(struct snd_soc_card *card,
+void snd_soc_of_parse_node_prefix(struct device_node *np,
 				   struct snd_soc_codec_conf *codec_conf,
 				   struct device_node *of_node,
 				   const char *propname);
+#define snd_soc_of_parse_audio_prefix(card, conf, node, name) \
+	snd_soc_of_parse_node_prefix((card)->dev->of_node,    \
+				     (conf), (node), (name))
+
 int snd_soc_of_parse_audio_routing(struct snd_soc_card *card,
 				   const char *propname);
 unsigned int snd_soc_of_parse_daifmt(struct device_node *np,
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 6ddcf12..012000d 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3484,12 +3484,11 @@ int snd_soc_of_parse_tdm_slot(struct device_node *np,
 }
 EXPORT_SYMBOL_GPL(snd_soc_of_parse_tdm_slot);
 
-void snd_soc_of_parse_audio_prefix(struct snd_soc_card *card,
-				   struct snd_soc_codec_conf *codec_conf,
-				   struct device_node *of_node,
-				   const char *propname)
+void snd_soc_of_parse_node_prefix(struct device_node *np,
+				  struct snd_soc_codec_conf *codec_conf,
+				  struct device_node *of_node,
+				  const char *propname)
 {
-	struct device_node *np = card->dev->of_node;
 	const char *str;
 	int ret;
 
@@ -3502,7 +3501,7 @@ void snd_soc_of_parse_audio_prefix(struct snd_soc_card *card,
 	codec_conf->of_node	= of_node;
 	codec_conf->name_prefix	= str;
 }
-EXPORT_SYMBOL_GPL(snd_soc_of_parse_audio_prefix);
+EXPORT_SYMBOL_GPL(snd_soc_of_parse_node_prefix);
 
 int snd_soc_of_parse_audio_routing(struct snd_soc_card *card,
 				   const char *propname)
-- 
2.7.4
