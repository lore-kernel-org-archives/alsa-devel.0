From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 6/8] ASoC: Call snd_soc_dapm_new_widgets() only
	once during card initialization
Date: Tue, 27 Aug 2013 15:50:59 +0200
Message-ID: <1377611461-3638-6-git-send-email-lars@metafoo.de>
References: <1377611461-3638-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-185.synserver.de (smtp-out-185.synserver.de
 [212.40.185.185])
 by alsa0.perex.cz (Postfix) with ESMTP id C5DEB260863
 for <alsa-devel@alsa-project.org>; Tue, 27 Aug 2013 15:49:38 +0200 (CEST)
In-Reply-To: <1377611461-3638-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Each time snd_soc_dapm_new_widgets() is called it will instantiate all the
widgets and routes that have been added so far and then power them. Doing this
multiple times before the card is fully initialized and all widgets have been
added can cause unnecessary and even invalid power state transitions which can
result in extra register writes and and also might cause clicks and pops.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-core.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 528f870..aef5e8c 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1243,9 +1243,6 @@ static int soc_post_component_init(struct snd_soc_card *card,
 	}
 	rtd->card = card;
 
-	/* Make sure all DAPM widgets are instantiated */
-	snd_soc_dapm_new_widgets(&codec->dapm);
-
 	/* machine controls, routes and widgets are not prefixed */
 	temp = codec->name_prefix;
 	codec->name_prefix = NULL;
@@ -1741,8 +1738,6 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 		snd_soc_dapm_add_routes(&card->dapm, card->dapm_routes,
 					card->num_dapm_routes);
 
-	snd_soc_dapm_new_widgets(&card->dapm);
-
 	for (i = 0; i < card->num_links; i++) {
 		dai_link = &card->dai_link[i];
 		dai_fmt = dai_link->dai_fmt;
-- 
1.8.0
