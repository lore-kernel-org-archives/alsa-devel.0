From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 4/4] ASoC: simple_card_utils: remove "option"
 from asoc_simple_card_of_parse_routing()
Date: Wed, 21 Nov 2018 02:11:13 +0000
Message-ID: <87r2ffp4rs.wl-kuninori.morimoto.gx@renesas.com>
References: <87wop7p4wk.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from JPN01-TY1-obe.outbound.protection.outlook.com
 (mail-eopbgr1400117.outbound.protection.outlook.com [40.107.140.117])
 by alsa0.perex.cz (Postfix) with ESMTP id A07AB267A75
 for <alsa-devel@alsa-project.org>; Wed, 21 Nov 2018 03:11:16 +0100 (CET)
In-Reply-To: <87wop7p4wk.wl-kuninori.morimoto.gx@renesas.com>
Content-Language: en-US
Content-ID: <53B2C8F69279E047A51822556C4D96A9@jpnprd01.prod.outlook.com>
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

asoc_simple_card_of_parse_routing() had "option" parameter
to consider error handling, but it is very pointless parameter.
Let's remove it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 include/sound/simple_card_utils.h        |  3 +--
 sound/soc/generic/audio-graph-card.c     |  2 +-
 sound/soc/generic/audio-graph-scu-card.c |  2 +-
 sound/soc/generic/simple-card-utils.c    | 10 +++-------
 sound/soc/generic/simple-card.c          |  2 +-
 sound/soc/generic/simple-scu-card.c      |  2 +-
 6 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/include/sound/simple_card_utils.h b/include/sound/simple_card_utils.h
index d1f1717..6d69ed2 100644
--- a/include/sound/simple_card_utils.h
+++ b/include/sound/simple_card_utils.h
@@ -121,8 +121,7 @@ void asoc_simple_card_parse_convert(struct device *dev,
 				    struct asoc_simple_card_data *data);
 
 int asoc_simple_card_of_parse_routing(struct snd_soc_card *card,
-				      char *prefix,
-				      int optional);
+				      char *prefix);
 int asoc_simple_card_of_parse_widgets(struct snd_soc_card *card,
 				      char *prefix);
 
diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
index 26eb6ff..101c7da 100644
--- a/sound/soc/generic/audio-graph-card.c
+++ b/sound/soc/generic/audio-graph-card.c
@@ -238,7 +238,7 @@ static int asoc_graph_card_parse_of(struct graph_card_data *priv)
 	if (ret < 0)
 		return ret;
 
-	ret = asoc_simple_card_of_parse_routing(card, NULL, 1);
+	ret = asoc_simple_card_of_parse_routing(card, NULL);
 	if (ret < 0)
 		return ret;
 
diff --git a/sound/soc/generic/audio-graph-scu-card.c b/sound/soc/generic/audio-graph-scu-card.c
index 1f75493..c469473 100644
--- a/sound/soc/generic/audio-graph-scu-card.c
+++ b/sound/soc/generic/audio-graph-scu-card.c
@@ -200,7 +200,7 @@ static int asoc_graph_card_parse_of(struct graph_card_data *priv)
 	 * see simple-card
 	 */
 
-	ret = asoc_simple_card_of_parse_routing(card, NULL, 0);
+	ret = asoc_simple_card_of_parse_routing(card, NULL);
 	if (ret < 0)
 		return ret;
 
diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index f588c93..119f831 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -420,8 +420,7 @@ int asoc_simple_card_clean_reference(struct snd_soc_card *card)
 EXPORT_SYMBOL_GPL(asoc_simple_card_clean_reference);
 
 int asoc_simple_card_of_parse_routing(struct snd_soc_card *card,
-				      char *prefix,
-				      int optional)
+				      char *prefix)
 {
 	struct device_node *node = card->dev->of_node;
 	char prop[128];
@@ -431,11 +430,8 @@ int asoc_simple_card_of_parse_routing(struct snd_soc_card *card,
 
 	snprintf(prop, sizeof(prop), "%s%s", prefix, "routing");
 
-	if (!of_property_read_bool(node, prop)) {
-		if (optional)
-			return 0;
-		return -EINVAL;
-	}
+	if (!of_property_read_bool(node, prop))
+		return 0;
 
 	return snd_soc_of_parse_audio_routing(card, prop);
 }
diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 5a3f59a..ff3f9fa 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -300,7 +300,7 @@ static int asoc_simple_card_parse_of(struct simple_card_data *priv)
 	if (ret < 0)
 		goto card_parse_end;
 
-	ret = asoc_simple_card_of_parse_routing(card, PREFIX, 1);
+	ret = asoc_simple_card_of_parse_routing(card, PREFIX);
 	if (ret < 0)
 		goto card_parse_end;
 
diff --git a/sound/soc/generic/simple-scu-card.c b/sound/soc/generic/simple-scu-card.c
index 2d3ef6e..e650143 100644
--- a/sound/soc/generic/simple-scu-card.c
+++ b/sound/soc/generic/simple-scu-card.c
@@ -198,7 +198,7 @@ static int asoc_simple_card_parse_of(struct simple_card_data *priv)
 	if (ret < 0)
 		return ret;
 
-	ret = asoc_simple_card_of_parse_routing(card, PREFIX, 0);
+	ret = asoc_simple_card_of_parse_routing(card, PREFIX);
 	if (ret < 0)
 		return ret;
 
-- 
2.7.4
