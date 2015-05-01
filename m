From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/4] ASoC: dapm: Add new widgets to the end of
	the widget list
Date: Fri,  1 May 2015 18:02:42 +0200
Message-ID: <1430496165-13917-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-014.synserver.de (smtp-out-017.synserver.de
 [212.40.185.17])
 by alsa0.perex.cz (Postfix) with ESMTP id 0DAC92605F3
 for <alsa-devel@alsa-project.org>; Fri,  1 May 2015 19:15:53 +0200 (CEST)
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
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Lars-Peter Clausen <lars@metafoo.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Currently new widgets are appended to the beginning of the cards widget
list. This has the effect that widgets that are created while iterating
over the widget list in snd_soc_dapm_new_widgets() (like e.g. the
auto-disable widgets) are not covered during that invocation of the
function. If no further invocations of snd_soc_dapm_new_widgets() happen
these widgets will not be fully initialized and e.g. no debugfs entries are
created for them.

By adding new widgets to the end of the widget list we make sure that
widgets that are created in snd_soc_dapm_new_widgets() will still be
handled during the same snd_soc_dapm_new_widgets() invocation and are
always fully initialized.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
This series depends on Charles' mux auto-disable series.
---
 sound/soc/soc-dapm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 79e6cf4..5c159f4 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3252,7 +3252,7 @@ snd_soc_dapm_new_control(struct snd_soc_dapm_context *dapm,
 	INIT_LIST_HEAD(&w->sinks);
 	INIT_LIST_HEAD(&w->list);
 	INIT_LIST_HEAD(&w->dirty);
-	list_add(&w->list, &dapm->card->widgets);
+	list_add_tail(&w->list, &dapm->card->widgets);
 
 	w->inputs = -1;
 	w->outputs = -1;
-- 
1.8.0
