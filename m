From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: Add missing debugfs conditionals
Date: Mon,  7 Mar 2011 11:11:05 +0000
Message-ID: <1299496265-8090-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1299496265-8090-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 05C7510387F
	for <alsa-devel@alsa-project.org>; Mon,  7 Mar 2011 12:11:13 +0100 (CET)
In-Reply-To: <1299496265-8090-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-core.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 8926d38..be34f6b 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1879,6 +1879,7 @@ static void snd_soc_instantiate_card(struct snd_soc_card *card)
 		snd_soc_dapm_add_routes(&card->dapm, card->dapm_routes,
 					card->num_dapm_routes);
 
+#ifdef CONFIG_DEBUG_FS
 	card->dapm.debugfs_dapm = debugfs_create_dir("dapm",
 						     card->debugfs_card_root);
 	if (!card->dapm.debugfs_dapm)
@@ -1886,6 +1887,7 @@ static void snd_soc_instantiate_card(struct snd_soc_card *card)
 		       "Failed to create card DAPM debugfs directory\n");
 
 	snd_soc_dapm_debugfs_init(&card->dapm);
+#endif
 
 	snprintf(card->snd_card->shortname, sizeof(card->snd_card->shortname),
 		 "%s",  card->name);
-- 
1.7.2.3
