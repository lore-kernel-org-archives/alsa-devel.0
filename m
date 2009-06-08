From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/7] ASoC: Coalesce register writes for DAPM
	sequences
Date: Mon,  8 Jun 2009 15:28:49 +0100
Message-ID: <1244471333-6485-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090608142734.GA6137@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EBBAB1037F2
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

Reduce the number of register writes we need to set the power state for
a CODEC by coalescing updates to widgets with the same sequence order and
same register into a single write.

This can be a noticable performance improvement with slow or heavily
contended control buses, such as I2C controllers with a low clock
frequency, and is particularly noticable when resuming. It can also
reduce the noticability of and pops and clicks by ensuring that left
and right channels are powered simultaneously if they are in the same
register.

Currently widgets that have events are not coalesced, including PGAs
which may use the volume ramping control.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-dapm.c |  136 ++++++++++++++++++++++++++++++++++++++------------
 1 files changed, 104 insertions(+), 32 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 257d4f1..66f07cd 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -713,6 +713,8 @@ static int dapm_seq_compare(struct snd_soc_dapm_widget *a,
 {
 	if (sort[a->id] != sort[b->id])
 		return sort[a->id] - sort[b->id];
+	if (a->reg != b->reg)
+		return a->reg - b->reg;
 
 	return 0;
 }
@@ -733,63 +735,133 @@ static void dapm_seq_insert(struct snd_soc_dapm_widget *new_widget,
 	list_add_tail(&new_widget->power_list, list);
 }
 
-/* Apply a DAPM power sequence */
-static void dapm_seq_run(struct snd_soc_codec *codec, struct list_head *list,
-			 int event)
+/* Apply the coalesced changes from a DAPM sequence */
+static void dapm_seq_run_coalesced(struct snd_soc_codec *codec,
+				   struct list_head *pending)
 {
 	struct snd_soc_dapm_widget *w;
+	int reg, power;
+	unsigned int value = 0;
+	unsigned int mask = 0;
+	unsigned int cur_mask;
+
+	reg = list_first_entry(pending, struct snd_soc_dapm_widget,
+			       power_list)->reg;
+
+	list_for_each_entry(w, pending, power_list) {
+		cur_mask = 1 << w->shift;
+		BUG_ON(reg != w->reg);
+
+		if (w->invert)
+			power = !w->power;
+		else
+			power = w->power;
+
+		mask |= cur_mask;
+		if (power)
+			value |= cur_mask;
+
+		pop_dbg(codec->pop_time,
+			"pop test : Queue %s: reg=0x%x, 0x%x/0x%x\n",
+			w->name, reg, value, mask);
+	}
+
+	pop_dbg(codec->pop_time,
+		"pop test : Applying 0x%x/0x%x to %x in %dms\n",
+		value, mask, reg, codec->pop_time);
+	pop_wait(codec->pop_time);
+	snd_soc_update_bits(codec, reg, mask, value);
+}
+
+/* Apply a DAPM power sequence.
+ *
+ * We walk over a pre-sorted list of widgets to apply power to.  In
+ * order to minimise the number of writes to the device required
+ * multiple widgets will be updated in a single write where possible.
+ * Currently anything that requires more than a single write is not
+ * handled.
+ */
+static void dapm_seq_run(struct snd_soc_codec *codec, struct list_head *list,
+			 int event, int sort[])
+{
+	struct snd_soc_dapm_widget *w, *n;
+	LIST_HEAD(pending);
+	int cur_sort = -1;
+	int cur_reg = SND_SOC_NOPM;
 	int ret;
 
-	list_for_each_entry(w, list, power_list) {
+	list_for_each_entry_safe(w, n, list, power_list) {
+		ret = 0;
+
+		/* Do we need to apply any queued changes? */
+		if (sort[w->id] != cur_sort || w->reg != cur_reg) {
+			if (!list_empty(&pending))
+				dapm_seq_run_coalesced(codec, &pending);
+
+			INIT_LIST_HEAD(&pending);
+			cur_sort = -1;
+			cur_reg = SND_SOC_NOPM;
+		}
+
 		switch (w->id) {
 		case snd_soc_dapm_pre:
 			if (!w->event)
-				list_for_each_entry_continue(w, list,
-							     power_list);
+				list_for_each_entry_safe_continue(w, n, list,
+								  power_list);
 
-			if (event == SND_SOC_DAPM_STREAM_START) {
+			if (event == SND_SOC_DAPM_STREAM_START)
 				ret = w->event(w,
 					       NULL, SND_SOC_DAPM_PRE_PMU);
-				if (ret < 0)
-					pr_err("PRE widget failed: %d\n",
-					       ret);
-			} else if (event == SND_SOC_DAPM_STREAM_STOP) {
+			else if (event == SND_SOC_DAPM_STREAM_STOP)
 				ret = w->event(w,
 					       NULL, SND_SOC_DAPM_PRE_PMD);
-				if (ret < 0)
-					pr_err("PRE widget failed: %d\n",
-					       ret);
-			}
 			break;
 
 		case snd_soc_dapm_post:
 			if (!w->event)
-				list_for_each_entry_continue(w, list,
-							     power_list);
+				list_for_each_entry_safe_continue(w, n, list,
+								  power_list);
 
-			if (event == SND_SOC_DAPM_STREAM_START) {
+			if (event == SND_SOC_DAPM_STREAM_START)
 				ret = w->event(w,
 					       NULL, SND_SOC_DAPM_POST_PMU);
-				if (ret < 0)
-					pr_err("POST widget failed: %d\n",
-					       ret);
-			} else if (event == SND_SOC_DAPM_STREAM_STOP) {
+			else if (event == SND_SOC_DAPM_STREAM_STOP)
 				ret = w->event(w,
 					       NULL, SND_SOC_DAPM_POST_PMD);
-				if (ret < 0)
-					pr_err("POST widget failed: %d\n",
-					       ret);
-			}
 			break;
 
-		default:
+		case snd_soc_dapm_input:
+		case snd_soc_dapm_output:
+		case snd_soc_dapm_hp:
+		case snd_soc_dapm_mic:
+		case snd_soc_dapm_line:
+		case snd_soc_dapm_spk:
+			/* No register support currently */
+		case snd_soc_dapm_pga:
+			/* Don't coalsece these yet due to gain ramping */
 			ret = dapm_generic_apply_power(w);
-			if (ret < 0)
-				pr_err("Failed to apply widget power: %d\n",
-				       ret);
 			break;
+
+		default:
+			/* If there's an event or an invalid register
+			 * then run immediately, otherwise store the
+			 * updates so that we can coalesce. */
+			if (w->reg >= 0 && !w->event) {
+				cur_sort = sort[w->id];
+				cur_reg = w->reg;
+				list_move(&w->power_list, &pending);
+			} else {
+				ret = dapm_generic_apply_power(w);
+			}
 		}
+
+		if (ret < 0)
+			pr_err("Failed to apply widget power: %d\n",
+			       ret);
 	}
+
+	if (!list_empty(&pending))
+		dapm_seq_run_coalesced(codec, &pending);
 }
 
 /*
@@ -857,10 +929,10 @@ static int dapm_power_widgets(struct snd_soc_codec *codec, int event)
 	}
 
 	/* Power down widgets first; try to avoid amplifying pops. */
-	dapm_seq_run(codec, &codec->down_list, event);
+	dapm_seq_run(codec, &codec->down_list, event, dapm_down_seq);
 
 	/* Now power up. */
-	dapm_seq_run(codec, &codec->up_list, event);
+	dapm_seq_run(codec, &codec->up_list, event, dapm_up_seq);
 
 	/* If we just powered the last thing off drop to standby bias */
 	if (codec->bias_level == SND_SOC_BIAS_PREPARE && !sys_power) {
-- 
1.6.3.1
