From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 4/5] ASoC: dapm: Use snd_soc_dapm_add_path() in
	snd_soc_dapm_new_pcm()
Date: Wed,  7 May 2014 15:05:47 +0200
Message-ID: <1399467948-8770-4-git-send-email-lars@metafoo.de>
References: <1399467948-8770-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-016.synserver.de (smtp-out-029.synserver.de
 [212.40.185.29])
 by alsa0.perex.cz (Postfix) with ESMTP id B58BF26531F
 for <alsa-devel@alsa-project.org>; Wed,  7 May 2014 15:05:59 +0200 (CEST)
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

We already know the widgets we want to connect, so use snd_soc_dapm_add_path()
instead of snd_soc_dapm_add_route() in snd_soc_dapm_new_pcm().

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-dapm.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index e28ce91..de48cab 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3247,6 +3247,7 @@ int snd_soc_dapm_new_pcm(struct snd_soc_card *card,
 	struct snd_soc_dapm_widget *w;
 	size_t len;
 	char *link_name;
+	int ret;
 
 	len = strlen(source->name) + strlen(sink->name) + 2;
 	link_name = devm_kzalloc(card->dev, len, GFP_KERNEL);
@@ -3275,13 +3276,10 @@ int snd_soc_dapm_new_pcm(struct snd_soc_card *card,
 
 	memset(&routes, 0, sizeof(routes));
 
-	routes[0].source = source->name;
-	routes[0].sink = link_name;
-	routes[1].source = link_name;
-	routes[1].sink = sink->name;
-
-	return snd_soc_dapm_add_routes(&card->dapm, routes,
-				       ARRAY_SIZE(routes));
+	ret = snd_soc_dapm_add_path(&card->dapm, source, w, NULL, NULL);
+	if (ret)
+		return ret;
+	return snd_soc_dapm_add_path(&card->dapm, w, sink, NULL, NULL);
 }
 
 int snd_soc_dapm_new_dai_widgets(struct snd_soc_dapm_context *dapm,
-- 
1.8.0
