From: Lucas Stach <l.stach@pengutronix.de>
Subject: [PATCH] Revert "ASoC: simple-card-utils: enable
	"label" on asoc_simple_card_parse_card_name"
Date: Tue, 29 Aug 2017 17:36:53 +0200
Message-ID: <20170829153653.11766-1-l.stach@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.4.pengutronix.de (metis.ext.4.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 1A51D266C6D
 for <alsa-devel@alsa-project.org>; Tue, 29 Aug 2017 17:37:06 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, patchwork-lst@pengutronix.de, Takashi Iwai <tiwai@suse.com>, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

This commit breaks existing systems, as snd_soc_of_parse_card_name() doesn't
return an error if the DT name property is missing, which would be required
to hit the fallback path in the offending commit at all.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
This should be fixed properly, but given the timing with the 4.13 release
being really close, I opted for just reverting the offending commit.
---
 sound/soc/generic/simple-card-utils.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index 7d7ab4aee42e..e6f472360cfc 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -125,21 +125,15 @@ EXPORT_SYMBOL_GPL(asoc_simple_card_set_dailink_name);
 int asoc_simple_card_parse_card_name(struct snd_soc_card *card,
 				     char *prefix)
 {
+	char prop[128];
 	int ret;
 
-	if (!prefix)
-		prefix = "";
+	snprintf(prop, sizeof(prop), "%sname", prefix);
 
 	/* Parse the card name from DT */
-	ret = snd_soc_of_parse_card_name(card, "label");
-	if (ret < 0) {
-		char prop[128];
-
-		snprintf(prop, sizeof(prop), "%sname", prefix);
-		ret = snd_soc_of_parse_card_name(card, prop);
-		if (ret < 0)
-			return ret;
-	}
+	ret = snd_soc_of_parse_card_name(card, prop);
+	if (ret < 0)
+		return ret;
 
 	if (!card->name && card->dai_link)
 		card->name = card->dai_link->name;
-- 
2.11.0
