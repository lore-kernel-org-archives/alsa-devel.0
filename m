From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/5] ASoC: Remove unused 'list' field form card
Date: Tue,  6 May 2014 09:39:38 +0200
Message-ID: <1399361981-18518-3-git-send-email-lars@metafoo.de>
References: <1399361981-18518-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-167.synserver.de (smtp-out-016.synserver.de
 [212.40.185.16])
 by alsa0.perex.cz (Postfix) with ESMTP id 7AC8B26072A
 for <alsa-devel@alsa-project.org>; Tue,  6 May 2014 09:39:50 +0200 (CEST)
In-Reply-To: <1399361981-18518-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Bo Shen <voice.shen@atmel.com>
List-Id: alsa-devel@alsa-project.org

The global card list was removed in commit b19e6e7b7 ("ASoC: core: Use driver
core probe deferral"). The 'list' field of the snd_soc_card struct has been
unused since then. This patch removes the field.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc.h  | 1 -
 sound/soc/soc-core.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 30c068f..5603020 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -949,7 +949,6 @@ struct snd_soc_card {
 	struct snd_card *snd_card;
 	struct module *owner;
 
-	struct list_head list;
 	struct mutex mutex;
 	struct mutex dapm_mutex;
 
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 24c1fc2..cc62526 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3733,7 +3733,6 @@ int snd_soc_register_card(struct snd_soc_card *card)
 	for (i = 0; i < card->num_links; i++)
 		card->rtd[i].dai_link = &card->dai_link[i];
 
-	INIT_LIST_HEAD(&card->list);
 	INIT_LIST_HEAD(&card->dapm_dirty);
 	card->instantiated = 0;
 	mutex_init(&card->mutex);
-- 
1.8.0
