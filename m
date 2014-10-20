From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 04/12] ASoC: dapm: Do not add un-muxed paths to
	MUX control
Date: Mon, 20 Oct 2014 19:36:36 +0200
Message-ID: <1413826604-3212-5-git-send-email-lars@metafoo.de>
References: <1413826604-3212-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-205.synserver.de (smtp-out-205.synserver.de
 [212.40.185.205])
 by alsa0.perex.cz (Postfix) with ESMTP id 1265C2658BA
 for <alsa-devel@alsa-project.org>; Mon, 20 Oct 2014 19:36:49 +0200 (CEST)
In-Reply-To: <1413826604-3212-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Paths that are directly connected to a MUX widget are not affected by
changes to the MUX's control. Rather than checking if a path is directly
connected each time the MUX is updated do it only once when MUX is created.

We can also remove the check for e->texts[mux] != NULL, since if that
condition was true the code would have had already crashed much earlier (And
generally speaking if a enum's 'texts' entry is NULL it's a bug in the
driver).

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-dapm.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 518c532..bc8329b 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -738,8 +738,10 @@ static int dapm_new_mux(struct snd_soc_dapm_widget *w)
 	if (ret < 0)
 		return ret;
 
-	list_for_each_entry(path, &w->sources, list_sink)
-		dapm_kcontrol_add_path(w->kcontrols[0], path);
+	list_for_each_entry(path, &w->sources, list_sink) {
+		if (path->name)
+			dapm_kcontrol_add_path(w->kcontrols[0], path);
+	}
 
 	return 0;
 }
@@ -2036,9 +2038,6 @@ static int soc_dapm_mux_update_power(struct snd_soc_card *card,
 
 	/* find dapm widget path assoc with kcontrol */
 	dapm_kcontrol_for_each_path(path, kcontrol) {
-		if (!path->name || !e->texts[mux])
-			continue;
-
 		found = 1;
 		/* we now need to match the string in the enum to the path */
 		if (!(strcmp(path->name, e->texts[mux])))
-- 
1.8.0
