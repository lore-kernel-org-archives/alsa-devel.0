From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH] ASoC: Fix freeing of incompletely initialized
 snd_soc_dapm_context
Date: Fri, 07 Jun 2019 16:17:45 +0200
Message-ID: <20190607141745.759-1-s.nawrocki@samsung.com>
References: <CGME20190607141821epcas2p120786c8cc5a1f1b71dbd1828b0a9d837@epcas2p1.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C1CC2F896CE
 for <alsa-devel@alsa-project.org>; Fri,  7 Jun 2019 16:18:27 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, b.zolnierkie@samsung.com, lgirdwood@gmail.com, krzk@kernel.org, tzungbi@google.com, Sylwester Nawrocki <s.nawrocki@samsung.com>, m.szyprowski@samsung.com
List-Id: alsa-devel@alsa-project.org

When soc_init_dai_link() call at the beginning of snd_soc_instantiate_card
function fails soc_cleanup_card_resources() and then snd_soc_dapm_free()
gets called with an incompletely initialized card->dapm. In particular
card->dapm.card is NULL and it gets dereferenced in dapm_free_widgets().
Also dapm->list is invalid and there is an invalid pointer dereference
from list_del().

The function call stack (deferred probing) on Chromebook Snow where this
issue has shown up in todays -next:

 snd_soc_dapm_free
 soc_cleanup_card_resources
 snd_soc_instantiate_card
 snd_soc_register_card
 devm_snd_soc_register_card
 snow_probe

Fix this by testing dapm->card before attempting to free dapm widgets.

Fixes: 70fc53734e71 ("ASoC: core: move DAI pre-links initiation to snd_soc_instantiate_card")
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 sound/soc/soc-dapm.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 6b44b4a78b8e..5774cbd393fe 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -4658,8 +4658,11 @@ EXPORT_SYMBOL_GPL(snd_soc_dapm_ignore_suspend);
 void snd_soc_dapm_free(struct snd_soc_dapm_context *dapm)
 {
 	dapm_debugfs_cleanup(dapm);
-	dapm_free_widgets(dapm);
-	list_del(&dapm->list);
+
+	if (dapm->card) {
+		dapm_free_widgets(dapm);
+		list_del(&dapm->list);
+	}
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_free);

--
2.17.1
