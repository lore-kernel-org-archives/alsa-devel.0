From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Create card DAPM widgets early so they
	can be used in callbacks
Date: Tue, 12 Apr 2011 17:57:22 -0700
Message-ID: <1302656242-12832-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F34C12414A
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Apr 2011 02:57:16 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

This helps with things like setting up the initial state.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-core.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index f75f139..ef0689b 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1868,6 +1868,10 @@ static void snd_soc_instantiate_card(struct snd_soc_card *card)
 	INIT_WORK(&card->deferred_resume_work, soc_resume_deferred);
 #endif
 
+	if (card->dapm_widgets)
+		snd_soc_dapm_new_controls(&card->dapm, card->dapm_widgets,
+					  card->num_dapm_widgets);
+
 	/* initialise the sound card only once */
 	if (card->probe) {
 		ret = card->probe(card);
@@ -1901,9 +1905,6 @@ static void snd_soc_instantiate_card(struct snd_soc_card *card)
 				     card->controls,
 				     card->num_controls);
 
-	if (card->dapm_widgets)
-		snd_soc_dapm_new_controls(&card->dapm, card->dapm_widgets,
-					  card->num_dapm_widgets);
 	if (card->dapm_routes)
 		snd_soc_dapm_add_routes(&card->dapm, card->dapm_routes,
 					card->num_dapm_routes);
-- 
1.7.4.1
