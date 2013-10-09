From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: dapm: Use async I/O for DAPM sequences
Date: Wed,  9 Oct 2013 14:01:44 +0100
Message-ID: <1381323704-11448-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 09C072654CA
 for <alsa-devel@alsa-project.org>; Wed,  9 Oct 2013 15:01:56 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

Within a DAPM sequence we normally don't care about when exactly a register
write has completed so long as they happen in the order we requested. This
means that we can issue most of the writes we do asynchronously which
should maximise the ability of the underlying frameworks to keep the
hardware busy, providing a small performance improvement on some systems.

We currently ensure that all writes are completed both when changing to a
different device and when calling into the regulator and clock frameworks.
This should ensure that the previous ordering is maintained.

We also ensure that writes are completed prior to calling into widget
event functions since some event functions implement delays.  This
should be improved in future so that widgets can disable this sync in
order to add extra writes.

Signed-off-by: Mark Brown <broonie@linaro.org>

xvdfvsd
---
 sound/soc/soc-dapm.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 25b9554..905e4c5 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -409,6 +409,12 @@ static inline void soc_widget_unlock(struct snd_soc_dapm_widget *w)
 		mutex_unlock(&w->platform->mutex);
 }
 
+static void soc_dapm_async_complete(struct snd_soc_dapm_context *dapm)
+{
+	if (dapm->codec && dapm->codec->using_regmap)
+		regmap_async_complete(dapm->codec->control_data);
+}
+
 static int soc_widget_update_bits_locked(struct snd_soc_dapm_widget *w,
 	unsigned short reg, unsigned int mask, unsigned int value)
 {
@@ -417,8 +423,9 @@ static int soc_widget_update_bits_locked(struct snd_soc_dapm_widget *w,
 	int ret;
 
 	if (w->codec && w->codec->using_regmap) {
-		ret = regmap_update_bits_check(w->codec->control_data,
-					       reg, mask, value, &change);
+		ret = regmap_update_bits_check_async(w->codec->control_data,
+						     reg, mask, value,
+						     &change);
 		if (ret != 0)
 			return ret;
 	} else {
@@ -1201,6 +1208,8 @@ int dapm_regulator_event(struct snd_soc_dapm_widget *w,
 {
 	int ret;
 
+	soc_dapm_async_complete(w->dapm);
+
 	if (SND_SOC_DAPM_EVENT_ON(event)) {
 		if (w->on_val & SND_SOC_DAPM_REGULATOR_BYPASS) {
 			ret = regulator_allow_bypass(w->regulator, false);
@@ -1234,6 +1243,8 @@ int dapm_clock_event(struct snd_soc_dapm_widget *w,
 	if (!w->clk)
 		return -EIO;
 
+	soc_dapm_async_complete(w->dapm);
+
 #ifdef CONFIG_HAVE_CLK
 	if (SND_SOC_DAPM_EVENT_ON(event)) {
 		return clk_prepare_enable(w->clk);
@@ -1426,6 +1437,7 @@ static void dapm_seq_check_event(struct snd_soc_card *card,
 	if (w->event && (w->event_flags & event)) {
 		pop_dbg(w->dapm->dev, card->pop_time, "pop test : %s %s\n",
 			w->name, ev_name);
+		soc_dapm_async_complete(w->dapm);
 		trace_snd_soc_dapm_widget_event_start(w, event);
 		ret = w->event(w, NULL, event);
 		trace_snd_soc_dapm_widget_event_done(w, event);
@@ -1498,6 +1510,7 @@ static void dapm_seq_run(struct snd_soc_card *card,
 	struct list_head *list, int event, bool power_up)
 {
 	struct snd_soc_dapm_widget *w, *n;
+	struct snd_soc_dapm_context *d;
 	LIST_HEAD(pending);
 	int cur_sort = -1;
 	int cur_subseq = -1;
@@ -1528,6 +1541,9 @@ static void dapm_seq_run(struct snd_soc_card *card,
 								       cur_subseq);
 			}
 
+			if (cur_dapm && w->dapm != cur_dapm)
+				soc_dapm_async_complete(cur_dapm);
+
 			INIT_LIST_HEAD(&pending);
 			cur_sort = -1;
 			cur_subseq = INT_MIN;
@@ -1586,6 +1602,10 @@ static void dapm_seq_run(struct snd_soc_card *card,
 				cur_dapm->seq_notifier(cur_dapm,
 						       i, cur_subseq);
 	}
+
+	list_for_each_entry(d, &card->dapm_list, list) {
+		soc_dapm_async_complete(d);
+	}
 }
 
 static void dapm_widget_update(struct snd_soc_card *card)
-- 
1.8.4.rc3
