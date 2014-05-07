From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/5] ASoC: Revert "ASoC: dapm: Fix double
	prefix addition"
Date: Wed,  7 May 2014 15:05:45 +0200
Message-ID: <1399467948-8770-2-git-send-email-lars@metafoo.de>
References: <1399467948-8770-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-016.synserver.de (smtp-out-029.synserver.de
 [212.40.185.29])
 by alsa0.perex.cz (Postfix) with ESMTP id EF6BE265314
 for <alsa-devel@alsa-project.org>; Wed,  7 May 2014 15:05:58 +0200 (CEST)
In-Reply-To: <1399467948-8770-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Songhee Baek <sbaek@nvidia.com>, Arun Shamanna Lakshmi <aruns@nvidia.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

This reverts commit bd23c5b661858446267f4d6b2fb4edd8eb710dda.

The patch claims that the patch is necessary to avoid double prefix addition
when calling snd_soc_dapm_add_route() from snd_soc_dapm_connect_dai_link_widgets().
But snd_soc_dapm_add_route() is called with the card's DAPM context, which does
not have a prefix, which means there is no prefix that could be added a second
time.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
I might be missing something. My best guess is that this was needed in some
vendor tree, but not in upstream.
---
 sound/soc/soc-dapm.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 142a738..08d869c 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2381,8 +2381,7 @@ err:
 }
 
 static int snd_soc_dapm_add_route(struct snd_soc_dapm_context *dapm,
-				  const struct snd_soc_dapm_route *route,
-				  unsigned int is_prefixed)
+				  const struct snd_soc_dapm_route *route)
 {
 	struct snd_soc_dapm_widget *wsource = NULL, *wsink = NULL, *w;
 	struct snd_soc_dapm_widget *wtsource = NULL, *wtsink = NULL;
@@ -2392,7 +2391,7 @@ static int snd_soc_dapm_add_route(struct snd_soc_dapm_context *dapm,
 	char prefixed_source[80];
 	int ret;
 
-	if (dapm->codec && dapm->codec->name_prefix && !is_prefixed) {
+	if (dapm->codec && dapm->codec->name_prefix) {
 		snprintf(prefixed_sink, sizeof(prefixed_sink), "%s %s",
 			 dapm->codec->name_prefix, route->sink);
 		sink = prefixed_sink;
@@ -2520,7 +2519,7 @@ int snd_soc_dapm_add_routes(struct snd_soc_dapm_context *dapm,
 
 	mutex_lock_nested(&dapm->card->dapm_mutex, SND_SOC_DAPM_CLASS_INIT);
 	for (i = 0; i < num; i++) {
-		r = snd_soc_dapm_add_route(dapm, route, false);
+		r = snd_soc_dapm_add_route(dapm, route);
 		if (r < 0) {
 			dev_err(dapm->dev, "ASoC: Failed to add route %s -> %s -> %s\n",
 				route->source,
@@ -3430,7 +3429,7 @@ void snd_soc_dapm_connect_dai_link_widgets(struct snd_soc_card *card)
 				cpu_dai->codec->name, r.source,
 				codec_dai->platform->name, r.sink);
 
-			snd_soc_dapm_add_route(&card->dapm, &r, true);
+			snd_soc_dapm_add_route(&card->dapm, &r);
 		}
 
 		/* connect BE DAI capture if widgets are valid */
@@ -3441,7 +3440,7 @@ void snd_soc_dapm_connect_dai_link_widgets(struct snd_soc_card *card)
 				codec_dai->codec->name, r.source,
 				cpu_dai->platform->name, r.sink);
 
-			snd_soc_dapm_add_route(&card->dapm, &r, true);
+			snd_soc_dapm_add_route(&card->dapm, &r);
 		}
 
 	}
-- 
1.8.0
