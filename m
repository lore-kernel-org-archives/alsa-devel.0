From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: dapm: Remove
	snd_soc_of_parse_audio_routing() due to deferred probe
Date: Thu, 18 Dec 2014 11:52:28 +0000
Message-ID: <1418903548-20935-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A50B726054F
 for <alsa-devel@alsa-project.org>; Thu, 18 Dec 2014 12:52:42 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Liam Girdwood <lgirdwood@gmail.com>, Peter Rosin <peda@axentia.se>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

This reverts commit f8781db8aeb18d (ASoC: dapm: Augment existing card
DAPM routes in snd_soc_of_parse_audio_routing) since it is broken for
deferred probing as it ends up storing data allocated with devm_ over
multiple instantiations of the device.

Reported-by: Russell King - ARM Linux <linux@arm.linux.org.uk>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 935721062c21..d7595465cfbc 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3231,7 +3231,7 @@ int snd_soc_of_parse_audio_routing(struct snd_soc_card *card,
 				   const char *propname)
 {
 	struct device_node *np = card->dev->of_node;
-	int num_routes, old_routes;
+	int num_routes;
 	struct snd_soc_dapm_route *routes;
 	int i, ret;
 
@@ -3249,9 +3249,7 @@ int snd_soc_of_parse_audio_routing(struct snd_soc_card *card,
 		return -EINVAL;
 	}
 
-	old_routes = card->num_dapm_routes;
-	routes = devm_kzalloc(card->dev,
-			      (old_routes + num_routes) * sizeof(*routes),
+	routes = devm_kzalloc(card->dev, num_routes * sizeof(*routes),
 			      GFP_KERNEL);
 	if (!routes) {
 		dev_err(card->dev,
@@ -3259,11 +3257,9 @@ int snd_soc_of_parse_audio_routing(struct snd_soc_card *card,
 		return -EINVAL;
 	}
 
-	memcpy(routes, card->dapm_routes, old_routes * sizeof(*routes));
-
 	for (i = 0; i < num_routes; i++) {
 		ret = of_property_read_string_index(np, propname,
-			2 * i, &routes[old_routes + i].sink);
+			2 * i, &routes[i].sink);
 		if (ret) {
 			dev_err(card->dev,
 				"ASoC: Property '%s' index %d could not be read: %d\n",
@@ -3271,7 +3267,7 @@ int snd_soc_of_parse_audio_routing(struct snd_soc_card *card,
 			return -EINVAL;
 		}
 		ret = of_property_read_string_index(np, propname,
-			(2 * i) + 1, &routes[old_routes + i].source);
+			(2 * i) + 1, &routes[i].source);
 		if (ret) {
 			dev_err(card->dev,
 				"ASoC: Property '%s' index %d could not be read: %d\n",
@@ -3280,7 +3276,7 @@ int snd_soc_of_parse_audio_routing(struct snd_soc_card *card,
 		}
 	}
 
-	card->num_dapm_routes += num_routes;
+	card->num_dapm_routes = num_routes;
 	card->dapm_routes = routes;
 
 	return 0;
-- 
2.1.3
