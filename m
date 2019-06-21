From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 1/2] ASoC: core: Adapt for debugfs API change
Date: Fri, 21 Jun 2019 12:33:56 +0100
Message-ID: <20190621113357.8264-1-broonie@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Back in ff9fb72bc07705c (debugfs: return error values, not NULL) the
debugfs APIs were changed to return error pointers rather than NULL
pointers on error, breaking the error checking in ASoC. Update the
code to use IS_ERR() and log the codes that are returned as part of
the error messages.

Fixes: ff9fb72bc07705c (debugfs: return error values, not NULL)
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 sound/soc/soc-core.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index c510da2d4af6..6d5c09493f4b 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -165,9 +165,10 @@ static void soc_init_component_debugfs(struct snd_soc_component *component)
 				component->card->debugfs_card_root);
 	}
 
-	if (!component->debugfs_root) {
+	if (IS_ERR(component->debugfs_root)) {
 		dev_warn(component->dev,
-			"ASoC: Failed to create component debugfs directory\n");
+			"ASoC: Failed to create component debugfs directory: %ld\n",
+			PTR_ERR(component->debugfs_root));
 		return;
 	}
 
@@ -219,18 +220,21 @@ static void soc_init_card_debugfs(struct snd_soc_card *card)
 
 	card->debugfs_card_root = debugfs_create_dir(card->name,
 						     snd_soc_debugfs_root);
-	if (!card->debugfs_card_root) {
+	if (IS_ERR(card->debugfs_card_root)) {
 		dev_warn(card->dev,
-			 "ASoC: Failed to create card debugfs directory\n");
+			 "ASoC: Failed to create card debugfs directory: %ld\n",
+			 PTR_ERR(card->debugfs_card_root));
+		card->debugfs_card_root = NULL;
 		return;
 	}
 
 	card->debugfs_pop_time = debugfs_create_u32("dapm_pop_time", 0644,
 						    card->debugfs_card_root,
 						    &card->pop_time);
-	if (!card->debugfs_pop_time)
+	if (IS_ERR(card->debugfs_pop_time))
 		dev_warn(card->dev,
-			 "ASoC: Failed to create pop time debugfs file\n");
+			 "ASoC: Failed to create pop time debugfs file: %ld\n",
+			 PTR_ERR(card->debugfs_pop_time));
 }
 
 static void soc_cleanup_card_debugfs(struct snd_soc_card *card)
-- 
2.20.1
