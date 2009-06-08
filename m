From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 7/7] ASoC: Make DAPM power sequence lists local
	variables
Date: Mon,  8 Jun 2009 15:28:53 +0100
Message-ID: <1244471333-6485-7-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090608142734.GA6137@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D92B52445C
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Jun 2009 16:28:57 +0200 (CEST)
In-Reply-To: <20090608142734.GA6137@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

They are now only accessed within dapm_power_widgets() so can be local
to that function.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc.h  |    2 --
 sound/soc/soc-dapm.c |   19 ++++++++-----------
 2 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index cf6111d..5964dd6 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -369,8 +369,6 @@ struct snd_soc_codec {
 	enum snd_soc_bias_level bias_level;
 	enum snd_soc_bias_level suspend_bias_level;
 	struct delayed_work delayed_work;
-	struct list_head up_list;
-	struct list_head down_list;
 
 	/* codec DAI's */
 	struct snd_soc_dai *dai;
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 7299ce4..1c30da1 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -927,23 +927,22 @@ static int dapm_power_widgets(struct snd_soc_codec *codec, int event)
 {
 	struct snd_soc_device *socdev = codec->socdev;
 	struct snd_soc_dapm_widget *w;
+	LIST_HEAD(up_list);
+	LIST_HEAD(down_list);
 	int ret = 0;
 	int power;
 	int sys_power = 0;
 
-	INIT_LIST_HEAD(&codec->up_list);
-	INIT_LIST_HEAD(&codec->down_list);
-
 	/* Check which widgets we need to power and store them in
 	 * lists indicating if they should be powered up or down.
 	 */
 	list_for_each_entry(w, &codec->dapm_widgets, list) {
 		switch (w->id) {
 		case snd_soc_dapm_pre:
-			dapm_seq_insert(w, &codec->down_list, dapm_down_seq);
+			dapm_seq_insert(w, &down_list, dapm_down_seq);
 			break;
 		case snd_soc_dapm_post:
-			dapm_seq_insert(w, &codec->up_list, dapm_up_seq);
+			dapm_seq_insert(w, &up_list, dapm_up_seq);
 			break;
 
 		default:
@@ -958,11 +957,9 @@ static int dapm_power_widgets(struct snd_soc_codec *codec, int event)
 				continue;
 
 			if (power)
-				dapm_seq_insert(w, &codec->up_list,
-						dapm_up_seq);
+				dapm_seq_insert(w, &up_list, dapm_up_seq);
 			else
-				dapm_seq_insert(w, &codec->down_list,
-						dapm_down_seq);
+				dapm_seq_insert(w, &down_list, dapm_down_seq);
 
 			w->power = power;
 			break;
@@ -979,10 +976,10 @@ static int dapm_power_widgets(struct snd_soc_codec *codec, int event)
 	}
 
 	/* Power down widgets first; try to avoid amplifying pops. */
-	dapm_seq_run(codec, &codec->down_list, event, dapm_down_seq);
+	dapm_seq_run(codec, &down_list, event, dapm_down_seq);
 
 	/* Now power up. */
-	dapm_seq_run(codec, &codec->up_list, event, dapm_up_seq);
+	dapm_seq_run(codec, &up_list, event, dapm_up_seq);
 
 	/* If we just powered the last thing off drop to standby bias */
 	if (codec->bias_level == SND_SOC_BIAS_PREPARE && !sys_power) {
-- 
1.6.3.1
