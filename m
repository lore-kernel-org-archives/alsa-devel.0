From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/5] ASoC: Add a per-card DAPM context
Date: Wed,  2 Mar 2011 19:21:09 +0000
Message-ID: <1299093671-12309-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1299093671-12309-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3F88F10383E
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

This means that rather than adding the board specific DAPM widgets to a
random CODEC DAPM context they can be added to the card itself which is
a bit cleaner. Previously there only was one DAPM context and it was
tied to the single supported CODEC.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc.h  |    3 +++
 sound/soc/soc-core.c |   13 +++++++++++++
 2 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 120fd19..24a35d6 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -730,6 +730,9 @@ struct snd_soc_card {
 	struct list_head paths;
 	struct list_head dapm_list;
 
+	/* Generic DAPM context for the card */
+	struct snd_soc_dapm_context dapm;
+
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *debugfs_card_root;
 	struct dentry *debugfs_pop_time;
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 64befac..24bfc3ff 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1837,6 +1837,11 @@ static void snd_soc_instantiate_card(struct snd_soc_card *card)
 	}
 	card->snd_card->dev = card->dev;
 
+	card->dapm.bias_level = SND_SOC_BIAS_OFF;
+	card->dapm.dev = card->dev;
+	card->dapm.card = card;
+	list_add(&card->dapm.list, &card->dapm_list);
+
 #ifdef CONFIG_PM_SLEEP
 	/* deferred resume work */
 	INIT_WORK(&card->deferred_resume_work, soc_resume_deferred);
@@ -1867,6 +1872,14 @@ static void snd_soc_instantiate_card(struct snd_soc_card *card)
 		}
 	}
 
+	card->dapm.debugfs_dapm = debugfs_create_dir("dapm",
+						     card->debugfs_card_root);
+	if (!card->dapm.debugfs_dapm)
+		printk(KERN_WARNING
+		       "Failed to create card DAPM debugfs directory\n");
+
+	snd_soc_dapm_debugfs_init(&card->dapm);
+
 	snprintf(card->snd_card->shortname, sizeof(card->snd_card->shortname),
 		 "%s",  card->name);
 	snprintf(card->snd_card->longname, sizeof(card->snd_card->longname),
-- 
1.7.2.3
