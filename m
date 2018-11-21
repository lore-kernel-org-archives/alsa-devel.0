From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple_card_utils: remove "option" from
	asoc_simple_card_of_parse_routing()" to the asoc tree
Date: Wed, 21 Nov 2018 13:29:13 +0000 (GMT)
Message-ID: <20181121132913.DC07E11250AE@debutante.sirena.org.uk>
References: <87r2ffp4rs.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 34C5C26770D
 for <alsa-devel@alsa-project.org>; Wed, 21 Nov 2018 14:29:15 +0100 (CET)
In-Reply-To: <87r2ffp4rs.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: simple_card_utils: remove "option" from asoc_simple_card_of_parse_routing()

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

>From 33404f3f10beaf0d69d8765f5804b6fb3b305f0f Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 21 Nov 2018 02:11:13 +0000
Subject: [PATCH] ASoC: simple_card_utils: remove "option" from
 asoc_simple_card_of_parse_routing()

asoc_simple_card_of_parse_routing() had "option" parameter
to consider error handling, but it is very pointless parameter.
Let's remove it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/simple_card_utils.h        |  3 +--
 sound/soc/generic/audio-graph-card.c     |  2 +-
 sound/soc/generic/audio-graph-scu-card.c |  2 +-
 sound/soc/generic/simple-card-utils.c    | 10 +++-------
 sound/soc/generic/simple-card.c          |  2 +-
 sound/soc/generic/simple-scu-card.c      |  2 +-
 6 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/include/sound/simple_card_utils.h b/include/sound/simple_card_utils.h
index d1f17172dce2..6d69ed2bd7b1 100644
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
index 26eb6ff9b9f3..101c7da2df7c 100644
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
index 1f754933ea9f..c46947393f80 100644
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
index a16373193b56..c69ce1e563cd 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -417,8 +417,7 @@ int asoc_simple_card_clean_reference(struct snd_soc_card *card)
 EXPORT_SYMBOL_GPL(asoc_simple_card_clean_reference);
 
 int asoc_simple_card_of_parse_routing(struct snd_soc_card *card,
-				      char *prefix,
-				      int optional)
+				      char *prefix)
 {
 	struct device_node *node = card->dev->of_node;
 	char prop[128];
@@ -428,11 +427,8 @@ int asoc_simple_card_of_parse_routing(struct snd_soc_card *card,
 
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
index 5a3f59aa4ba5..ff3f9fa9ab5a 100644
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
index 2d3ef6ebe863..e650143eb532 100644
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
2.19.0.rc2
