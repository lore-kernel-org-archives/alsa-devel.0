From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 4/5] ASoC: Allow card DAPM widgets and routes
	to be set up at registration
Date: Wed,  2 Mar 2011 19:21:10 +0000
Message-ID: <1299093671-12309-4-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1299093671-12309-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3964E1037F3
	for <alsa-devel@alsa-project.org>; Wed,  2 Mar 2011 20:20:54 +0100 (CET)
In-Reply-To: <1299093671-12309-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

These will be added after all devices are registered and allow most DAI
init functions in machine drivers to be replaced by simple data.
Regular controls are not supported as the registration function still
works in terms of CODECs.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc.h  |    8 ++++++++
 sound/soc/soc-core.c |    7 +++++++
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 24a35d6..601c41e 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -719,6 +719,14 @@ struct snd_soc_card {
 	struct snd_soc_pcm_runtime *rtd_aux;
 	int num_aux_rtd;
 
+	/*
+	 * Card-specific routes and widgets.
+	 */
+	struct snd_soc_dapm_widget *dapm_widgets;
+	int num_dapm_widgets;
+	struct snd_soc_dapm_route *dapm_routes;
+	int num_dapm_routes;
+
 	struct work_struct deferred_resume_work;
 
 	/* lists of probed devices belonging to this card */
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 24bfc3ff..6a2839c 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1872,6 +1872,13 @@ static void snd_soc_instantiate_card(struct snd_soc_card *card)
 		}
 	}
 
+	if (card->dapm_widgets)
+		snd_soc_dapm_new_controls(&card->dapm, card->dapm_widgets,
+					  card->num_dapm_widgets);
+	if (card->dapm_routes)
+		snd_soc_dapm_add_routes(&card->dapm, card->dapm_routes,
+					card->num_dapm_routes);
+
 	card->dapm.debugfs_dapm = debugfs_create_dir("dapm",
 						     card->debugfs_card_root);
 	if (!card->dapm.debugfs_dapm)
-- 
1.7.2.3
