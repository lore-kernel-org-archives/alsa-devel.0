From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/4] ASoC: Only run power_check() on a widget
	once per run
Date: Tue,  4 Oct 2011 23:01:23 +0100
Message-ID: <1317765685-8683-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1317765685-8683-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 62000103998
	for <alsa-devel@alsa-project.org>;
	Wed,  5 Oct 2011 00:01:30 +0200 (CEST)
In-Reply-To: <1317765685-8683-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Some widgets will get power_check() run on them more than once during a
DAPM run, most commonly due to supply widgets checking to see if their
consumers are powered up. It's wasteful to do this so cache the result
of power_check() during a run. For one system I tested this on I got an
improvement of:

           Power    Path   Neighbour
Before:    106      970    1186
After:     69       727    905

from this.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc-dapm.h |    2 ++
 sound/soc/soc-dapm.c     |   15 +++++++++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index c080635..e2853da 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -473,6 +473,8 @@ struct snd_soc_dapm_widget {
 	unsigned char ext:1;			/* has external widgets */
 	unsigned char force:1;			/* force state */
 	unsigned char ignore_suspend:1;         /* kept enabled over suspend */
+	unsigned char new_power:1;		/* power from this run */
+	unsigned char power_checked:1;		/* power checked this run */
 	int subseq;				/* sort within widget type */
 
 	int (*power_check)(struct snd_soc_dapm_widget *w);
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index e6a0882..c39146d 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -787,10 +787,17 @@ EXPORT_SYMBOL_GPL(dapm_reg_event);
 
 static int dapm_widget_power_check(struct snd_soc_dapm_widget *w)
 {
+	if (w->power_checked)
+		return w->new_power;
+
 	if (w->force)
-		return 1;
+		w->new_power = 1;
 	else
-		return w->power_check(w);
+		w->new_power = w->power_check(w);
+
+	w->power_checked = true;
+
+	return w->new_power;
 }
 
 /* Generic check to see if a widget should be powered.
@@ -1322,6 +1329,10 @@ static int dapm_power_widgets(struct snd_soc_dapm_context *dapm, int event)
 
 	memset(&card->dapm_stats, 0, sizeof(card->dapm_stats));
 
+	list_for_each_entry(w, &card->widgets, list) {
+		w->power_checked = false;
+	}
+
 	/* Check which widgets we need to power and store them in
 	 * lists indicating if they should be powered up or down.  We
 	 * only check widgets that have been flagged as dirty but note
-- 
1.7.6.3
