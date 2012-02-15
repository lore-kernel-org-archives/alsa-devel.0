From: Liam Girdwood <lrg@ti.com>
Subject: [PATCH] ASoC: dapm - Make DAPM reset code a separate
	function.
Date: Wed, 15 Feb 2012 15:15:34 +0000
Message-ID: <1329318937-14488-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog125.obsmtp.com (na3sys009aog125.obsmtp.com
	[74.125.149.153])
	by alsa0.perex.cz (Postfix) with ESMTP id E4F8E103E09
	for <alsa-devel@alsa-project.org>; Wed, 15 Feb 2012 16:15:50 +0100 (CET)
Received: by mail-wi0-f181.google.com with SMTP id hi8so715197wib.26
	for <alsa-devel@alsa-project.org>; Wed, 15 Feb 2012 07:15:47 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

It's useful to export the DAPM reset as a static function for future use
by other DAPM functions. e.g. The dynamic PCM query widgets resets the DAPM
graph before working out active paths.

Signed-off-by: Liam Girdwood <lrg@ti.com>
---
 sound/soc/soc-dapm.c |   21 ++++++++++++++-------
 1 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 0c94027..227887e 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -169,6 +169,19 @@ static inline struct snd_soc_card *dapm_get_soc_card(
 	return NULL;
 }
 
+static void dapm_reset(struct snd_soc_card *card)
+{
+	struct snd_soc_dapm_widget *w;
+
+	memset(&card->dapm_stats, 0, sizeof(card->dapm_stats));
+
+	list_for_each_entry(w, &card->widgets, list) {
+		w->power_checked = false;
+		w->inputs = -1;
+		w->outputs = -1;
+	}
+}
+
 static int soc_widget_read(struct snd_soc_dapm_widget *w, int reg)
 {
 	if (w->codec)
@@ -1402,13 +1415,7 @@ static int dapm_power_widgets(struct snd_soc_dapm_context *dapm, int event)
 		}
 	}
 
-	memset(&card->dapm_stats, 0, sizeof(card->dapm_stats));
-
-	list_for_each_entry(w, &card->widgets, list) {
-		w->power_checked = false;
-		w->inputs = -1;
-		w->outputs = -1;
-	}
+	dapm_reset(card);
 
 	/* Check which widgets we need to power and store them in
 	 * lists indicating if they should be powered up or down.  We
-- 
1.7.5.4
