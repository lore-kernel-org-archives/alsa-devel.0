From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 5/7] ASoC: Coalesce power updates for DAPM
	widgets with events
Date: Mon,  8 Jun 2009 15:28:51 +0100
Message-ID: <1244471333-6485-5-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090608142734.GA6137@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A06A724459
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Jun 2009 16:28:58 +0200 (CEST)
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

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-dapm.c |   76 +++++++++++++++++++++++++++++++++++++++----------
 1 files changed, 60 insertions(+), 16 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 9187db1..3fc791c 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -740,7 +740,7 @@ static void dapm_seq_run_coalesced(struct snd_soc_codec *codec,
 				   struct list_head *pending)
 {
 	struct snd_soc_dapm_widget *w;
-	int reg, power;
+	int reg, power, ret;
 	unsigned int value = 0;
 	unsigned int mask = 0;
 	unsigned int cur_mask;
@@ -764,13 +764,62 @@ static void dapm_seq_run_coalesced(struct snd_soc_codec *codec,
 		pop_dbg(codec->pop_time,
 			"pop test : Queue %s: reg=0x%x, 0x%x/0x%x\n",
 			w->name, reg, value, mask);
+
+		/* power up pre event */
+		if (w->power && w->event &&
+		    (w->event_flags & SND_SOC_DAPM_PRE_PMU)) {
+			pop_dbg(codec->pop_time, "pop test : %s PRE_PMU\n",
+				w->name);
+			ret = w->event(w, NULL, SND_SOC_DAPM_PRE_PMU);
+			if (ret < 0)
+				pr_err("%s: pre event failed: %d\n",
+				       w->name, ret);
+		}
+
+		/* power down pre event */
+		if (!w->power && w->event &&
+		    (w->event_flags & SND_SOC_DAPM_PRE_PMD)) {
+			pop_dbg(codec->pop_time, "pop test : %s PRE_PMD\n",
+				w->name);
+			ret = w->event(w, NULL, SND_SOC_DAPM_PRE_PMD);
+			if (ret < 0)
+				pr_err("%s: pre event failed: %d\n",
+				       w->name, ret);
+		}
+	}
+
+	if (reg >= 0) {
+		pop_dbg(codec->pop_time,
+			"pop test : Applying 0x%x/0x%x to %x in %dms\n",
+			value, mask, reg, codec->pop_time);
+		pop_wait(codec->pop_time);
+		snd_soc_update_bits(codec, reg, mask, value);
 	}
 
-	pop_dbg(codec->pop_time,
-		"pop test : Applying 0x%x/0x%x to %x in %dms\n",
-		value, mask, reg, codec->pop_time);
-	pop_wait(codec->pop_time);
-	snd_soc_update_bits(codec, reg, mask, value);
+	list_for_each_entry(w, pending, power_list) {
+		/* power up post event */
+		if (w->power && w->event &&
+		    (w->event_flags & SND_SOC_DAPM_POST_PMU)) {
+			pop_dbg(codec->pop_time, "pop test : %s POST_PMU\n",
+				w->name);
+			ret = w->event(w,
+				       NULL, SND_SOC_DAPM_POST_PMU);
+			if (ret < 0)
+				pr_err("%s: post event failed: %d\n",
+				       w->name, ret);
+		}
+
+		/* power down post event */
+		if (!w->power && w->event &&
+		    (w->event_flags & SND_SOC_DAPM_POST_PMD)) {
+			pop_dbg(codec->pop_time, "pop test : %s POST_PMD\n",
+				w->name);
+			ret = w->event(w, NULL, SND_SOC_DAPM_POST_PMD);
+			if (ret < 0)
+				pr_err("%s: post event failed: %d\n",
+				       w->name, ret);
+		}
+	}
 }
 
 /* Apply a DAPM power sequence.
@@ -843,16 +892,11 @@ static void dapm_seq_run(struct snd_soc_codec *codec, struct list_head *list,
 			break;
 
 		default:
-			/* If there's an event or an invalid register
-			 * then run immediately, otherwise store the
-			 * updates so that we can coalesce. */
-			if (w->reg >= 0 && !w->event) {
-				cur_sort = sort[w->id];
-				cur_reg = w->reg;
-				list_move(&w->power_list, &pending);
-			} else {
-				ret = dapm_generic_apply_power(w);
-			}
+			/* Queue it up for application */
+			cur_sort = sort[w->id];
+			cur_reg = w->reg;
+			list_move(&w->power_list, &pending);
+			break;
 		}
 
 		if (ret < 0)
-- 
1.6.3.1
