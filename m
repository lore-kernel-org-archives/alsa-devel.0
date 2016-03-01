From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 2/2] ASoC: sh: rcar: rsrc-card: don't open code of_device_get_match_data()
Date: Tue,  1 Mar 2016 17:39:20 +0100
Message-ID: <1456850381-8621-2-git-send-email-wsa@the-dreams.de>
References: <1456850381-8621-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1456850381-8621-1-git-send-email-wsa@the-dreams.de>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

This change will also make Coverity happy by avoiding a theoretical NULL
pointer dereference; yet another reason is to use the above helper function
to tighten the code and make it more readable.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Compile tested only. I am on the road and can't test the multimedia drivers
because of no cables :( If someone could test it, that would be much
appreciated. Or I'll do it next week. The pattern worked for other drivers
I could actually test, though.

 sound/soc/sh/rcar/rsrc-card.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sh/rcar/rsrc-card.c b/sound/soc/sh/rcar/rsrc-card.c
index 8a357fdf1077c9..545e94245e62c9 100644
--- a/sound/soc/sh/rcar/rsrc-card.c
+++ b/sound/soc/sh/rcar/rsrc-card.c
@@ -71,7 +71,6 @@ struct rsrc_card_priv {
 #define rsrc_priv_to_dev(priv) ((priv)->snd_card.dev)
 #define rsrc_priv_to_link(priv, i) ((priv)->snd_card.dai_link + (i))
 #define rsrc_priv_to_props(priv, i) ((priv)->dai_props + (i))
-#define rsrc_dev_to_of_data(dev) (of_match_device(rsrc_card_of_match, (dev))->data)
 
 static int rsrc_card_startup(struct snd_pcm_substream *substream)
 {
@@ -246,7 +245,7 @@ static int rsrc_card_parse_links(struct device_node *np,
 		struct device *dev = rsrc_priv_to_dev(priv);
 		const struct rsrc_card_of_data *of_data;
 
-		of_data = rsrc_dev_to_of_data(dev);
+		of_data = of_device_get_match_data(dev);
 
 		/* FE is dummy */
 		dai_link->cpu_of_node		= NULL;
@@ -396,7 +395,7 @@ static int rsrc_card_parse_of(struct device_node *node,
 			      struct rsrc_card_priv *priv,
 			      struct device *dev)
 {
-	const struct rsrc_card_of_data *of_data = rsrc_dev_to_of_data(dev);
+	const struct rsrc_card_of_data *of_data = of_device_get_match_data(dev);
 	struct rsrc_card_dai *props;
 	struct snd_soc_dai_link *links;
 	int ret;
-- 
2.7.0
