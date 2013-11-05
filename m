From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 21/31] ASoC: dapm: Use WARN_ON() instead of
	BUG_ON()
Date: Tue,  5 Nov 2013 18:40:08 +0100
Message-ID: <1383673218-18405-22-git-send-email-tiwai@suse.de>
References: <1383673218-18405-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 3B1A626520A
 for <alsa-devel@alsa-project.org>; Tue,  5 Nov 2013 18:40:42 +0100 (CET)
In-Reply-To: <1383673218-18405-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

BUG_ON() is rather useless for debugging as it leads to panic().
Use WARN_ON() and handle the error cases accordingly.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/soc-dapm.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index cc36caaf6443..c89bbe5a65e7 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1460,7 +1460,8 @@ static void dapm_seq_run_coalesced(struct snd_soc_card *card,
 			       power_list)->reg;
 
 	list_for_each_entry(w, pending, power_list) {
-		BUG_ON(reg != w->reg);
+		if (WARN_ON(reg != w->reg))
+			return;
 		w->power = w->new_power;
 
 		mask |= w->mask << w->shift;
@@ -3359,8 +3360,10 @@ static int snd_soc_dai_link_event(struct snd_soc_dapm_widget *w,
 	u64 fmt;
 	int ret;
 
-	BUG_ON(!config);
-	BUG_ON(list_empty(&w->sources) || list_empty(&w->sinks));
+	if (WARN_ON(!config))
+		return -EINVAL;
+	if (WARN_ON(list_empty(&w->sources) || list_empty(&w->sinks)))
+		return -EINVAL;
 
 	/* We only support a single source and sink, pick the first */
 	source_p = list_first_entry(&w->sources, struct snd_soc_dapm_path,
@@ -3368,9 +3371,12 @@ static int snd_soc_dai_link_event(struct snd_soc_dapm_widget *w,
 	sink_p = list_first_entry(&w->sinks, struct snd_soc_dapm_path,
 				  list_source);
 
-	BUG_ON(!source_p || !sink_p);
-	BUG_ON(!sink_p->source || !source_p->sink);
-	BUG_ON(!source_p->source || !sink_p->sink);
+	if (WARN_ON(!source_p || !sink_p))
+		return -EINVAL;
+	if (WARN_ON(!sink_p->source || !source_p->sink))
+		return -EINVAL;
+	if (WARN_ON(!source_p->source || !sink_p->sink))
+		return -EINVAL;
 
 	source = source_p->source->priv;
 	sink = sink_p->sink->priv;
-- 
1.8.4.2
