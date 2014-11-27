From: Peter Rosin <peda@lysator.liu.se>
Subject: [PATCH] ASoC: Augment existing card DAPM routes in
	snd_soc_of_parse_audio_routing
Date: Thu, 27 Nov 2014 22:02:42 +0100
Message-ID: <1417122162-8122-1-git-send-email-peda@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 370B1261536
 for <alsa-devel@alsa-project.org>; Thu, 27 Nov 2014 22:03:27 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Peter Rosin <peda@axentia.se>

If a snd_soc_card has any DAPM routes when it calls
snd_soc_of_parse_audio_routing, those are clobbered without this change.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 sound/soc/soc-core.c |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index b60ff56ebc0f..377db486852e 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -4585,7 +4585,7 @@ int snd_soc_of_parse_audio_routing(struct snd_soc_card *card,
 				   const char *propname)
 {
 	struct device_node *np = card->dev->of_node;
-	int num_routes;
+	int num_routes, old_routes;
 	struct snd_soc_dapm_route *routes;
 	int i, ret;
 
@@ -4603,7 +4603,9 @@ int snd_soc_of_parse_audio_routing(struct snd_soc_card *card,
 		return -EINVAL;
 	}
 
-	routes = devm_kzalloc(card->dev, num_routes * sizeof(*routes),
+	old_routes = card->num_dapm_routes;
+	routes = devm_kzalloc(card->dev,
+			      (old_routes + num_routes) * sizeof(*routes),
 			      GFP_KERNEL);
 	if (!routes) {
 		dev_err(card->dev,
@@ -4611,9 +4613,11 @@ int snd_soc_of_parse_audio_routing(struct snd_soc_card *card,
 		return -EINVAL;
 	}
 
+	memcpy(routes, card->dapm_routes, old_routes * sizeof(*routes));
+
 	for (i = 0; i < num_routes; i++) {
 		ret = of_property_read_string_index(np, propname,
-			2 * i, &routes[i].sink);
+			2 * i, &routes[old_routes + i].sink);
 		if (ret) {
 			dev_err(card->dev,
 				"ASoC: Property '%s' index %d could not be read: %d\n",
@@ -4621,7 +4625,7 @@ int snd_soc_of_parse_audio_routing(struct snd_soc_card *card,
 			return -EINVAL;
 		}
 		ret = of_property_read_string_index(np, propname,
-			(2 * i) + 1, &routes[i].source);
+			(2 * i) + 1, &routes[old_routes + i].source);
 		if (ret) {
 			dev_err(card->dev,
 				"ASoC: Property '%s' index %d could not be read: %d\n",
@@ -4630,7 +4634,7 @@ int snd_soc_of_parse_audio_routing(struct snd_soc_card *card,
 		}
 	}
 
-	card->num_dapm_routes = num_routes;
+	card->num_dapm_routes += num_routes;
 	card->dapm_routes = routes;
 
 	return 0;
-- 
1.7.10.4
