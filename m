From: Xiang Xiao <xiaoxiang@xiaomi.com>
Subject: [PATCH 2/2] ASoC: dapm: Reorder the bias update
	sequence
Date: Sun, 2 Mar 2014 00:04:03 +0800
Message-ID: <1393689843-22916-2-git-send-email-xiaoxiang@xiaomi.com>
References: <1393689843-22916-1-git-send-email-xiaoxiang@xiaomi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.mxmail.xiaomi.com (mx1.mxmail.xiaomi.com [58.68.235.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 5BEB3261A88
 for <alsa-devel@alsa-project.org>; Sat,  1 Mar 2014 17:04:40 +0100 (CET)
In-Reply-To: <1393689843-22916-1-git-send-email-xiaoxiang@xiaomi.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, xiaoxiang@xiaomi.com
List-Id: alsa-devel@alsa-project.org

The new sequence ensure that dapm_pre_sequence_async work on
the card before all codecs and dapm_post_sequence_async work
on the card after all codecs.
So the machine driver could utilize the determinate sequence
to do the gloabl setup and teardown in the right place.

Signed-off-by: Xiang Xiao <xiaoxiang@xiaomi.com>
---
 sound/soc/soc-dapm.c | 37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 00ed0e9..0d8ba30 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1825,10 +1825,14 @@ static int dapm_power_widgets(struct snd_soc_card *card, int event)
 
 	trace_snd_soc_dapm_walk_done(card);
 
-	/* Run all the bias changes in parallel */
-	list_for_each_entry(d, &card->dapm_list, list)
-		async_schedule_domain(dapm_pre_sequence_async, d,
-					&async_domain);
+	/* Run card bias changes at first */
+	dapm_pre_sequence_async(&card->dapm, 0);
+	/* Run other bias changes in parallel */
+	list_for_each_entry(d, &card->dapm_list, list) {
+		if (d != &card->dapm)
+			async_schedule_domain(dapm_pre_sequence_async, d,
+						&async_domain);
+	}
 	async_synchronize_full_domain(&async_domain);
 
 	list_for_each_entry(w, &down_list, power_list) {
@@ -1848,10 +1852,14 @@ static int dapm_power_widgets(struct snd_soc_card *card, int event)
 	dapm_seq_run(card, &up_list, event, true);
 
 	/* Run all the bias changes in parallel */
-	list_for_each_entry(d, &card->dapm_list, list)
-		async_schedule_domain(dapm_post_sequence_async, d,
-					&async_domain);
+	list_for_each_entry(d, &card->dapm_list, list) {
+		if (d != &card->dapm)
+			async_schedule_domain(dapm_post_sequence_async, d,
+						&async_domain);
+	}
 	async_synchronize_full_domain(&async_domain);
+	/* Run card bias changes at last */
+	dapm_post_sequence_async(&card->dapm, 0);
 
 	/* do we need to notify any clients that DAPM event is complete */
 	list_for_each_entry(d, &card->dapm_list, list) {
@@ -3942,11 +3950,18 @@ void snd_soc_dapm_shutdown(struct snd_soc_card *card)
 	struct snd_soc_dapm_context *dapm;
 
 	list_for_each_entry(dapm, &card->dapm_list, list) {
-		soc_dapm_shutdown_dapm(dapm);
-		if (dapm->bias_level == SND_SOC_BIAS_STANDBY)
-			snd_soc_dapm_set_bias_level(dapm,
-						    SND_SOC_BIAS_OFF);
+		if (dapm != &card->dapm) {
+			soc_dapm_shutdown_dapm(dapm);
+			if (dapm->bias_level == SND_SOC_BIAS_STANDBY)
+				snd_soc_dapm_set_bias_level(dapm,
+							    SND_SOC_BIAS_OFF);
+		}
 	}
+
+	soc_dapm_shutdown_dapm(&card->dapm);
+	if (card->dapm.bias_level == SND_SOC_BIAS_STANDBY)
+		snd_soc_dapm_set_bias_level(&card->dapm,
+					    SND_SOC_BIAS_OFF);
 }
 
 /* Module information */
-- 
1.8.1.2
