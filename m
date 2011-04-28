From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/7] ASoC: Drop unused parameter from
	dapm_seq_run
Date: Thu, 28 Apr 2011 18:46:09 +0200
Message-ID: <1304009173-5786-3-git-send-email-lars@metafoo.de>
References: <1304009173-5786-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-161.synserver.de (smtp-out-163.synserver.de
	[212.40.185.163])
	by alsa0.perex.cz (Postfix) with SMTP id D44831039A7
	for <alsa-devel@alsa-project.org>;
	Thu, 28 Apr 2011 18:46:27 +0200 (CEST)
In-Reply-To: <1304009173-5786-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Drop the dapm_context parameter from dapm_seq_run. It is not used anymore since
commit 7be31be8(ASoC: Extend DAPM to handle power changes on cross-device paths)

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-dapm.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index b51882e..2801c6a 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -823,8 +823,7 @@ static void dapm_seq_run_coalesced(struct snd_soc_dapm_context *dapm,
  * Currently anything that requires more than a single write is not
  * handled.
  */
-static void dapm_seq_run(struct snd_soc_dapm_context *dapm,
-			 struct list_head *list, int event, bool power_up)
+static void dapm_seq_run(struct list_head *list, int event, bool power_up)
 {
 	struct snd_soc_dapm_widget *w, *n;
 	LIST_HEAD(pending);
@@ -1094,12 +1093,12 @@ static int dapm_power_widgets(struct snd_soc_dapm_context *dapm, int event,
 	async_synchronize_full_domain(&async_domain);
 
 	/* Power down widgets first; try to avoid amplifying pops. */
-	dapm_seq_run(dapm, &down_list, event, false);
+	dapm_seq_run(&down_list, event, false);
 
 	dapm_widget_update(update);
 
 	/* Now power up. */
-	dapm_seq_run(dapm, &up_list, event, true);
+	dapm_seq_run(&up_list, event, true);
 
 	/* Run all the bias changes in parallel */
 	list_for_each_entry(d, &dapm->card->dapm_list, list)
@@ -2425,7 +2424,7 @@ static void soc_dapm_shutdown_codec(struct snd_soc_dapm_context *dapm)
 	 */
 	if (powerdown) {
 		snd_soc_dapm_set_bias_level(dapm, SND_SOC_BIAS_PREPARE);
-		dapm_seq_run(dapm, &down_list, 0, false);
+		dapm_seq_run(&down_list, 0, false);
 		snd_soc_dapm_set_bias_level(dapm, SND_SOC_BIAS_STANDBY);
 	}
 }
-- 
1.7.2.5
