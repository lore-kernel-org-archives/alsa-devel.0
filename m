From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/5] ASoC: dapm: Drop always true checks
Date: Sun, 26 Jul 2015 19:04:58 +0200
Message-ID: <1437930302-2789-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-144.synserver.de (smtp-out-144.synserver.de
 [212.40.185.144])
 by alsa0.perex.cz (Postfix) with ESMTP id 7DF8D2606FD
 for <alsa-devel@alsa-project.org>; Sun, 26 Jul 2015 19:05:06 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

list_first_entry() always returns non NULL and since the code previously
checked that list is not empty it will also be a valid pointer. Furthermore
a path has always a sink or a source widget. So both checks are redundant
and can be removed.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-dapm.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 7f834a0..10f7c7c 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3485,11 +3485,6 @@ static int snd_soc_dai_link_event(struct snd_soc_dapm_widget *w,
 	sink_p = list_first_entry(&w->sinks, struct snd_soc_dapm_path,
 				  list_source);
 
-	if (WARN_ON(!source_p || !sink_p) ||
-	    WARN_ON(!sink_p->source || !source_p->sink) ||
-	    WARN_ON(!source_p->source || !sink_p->sink))
-		return -EINVAL;
-
 	source = source_p->source->priv;
 	sink = sink_p->sink->priv;
 
-- 
2.1.4
