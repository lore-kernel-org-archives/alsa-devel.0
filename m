From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH 2/2] ASoC: Convert pop_dbg to use dev_info
Date: Tue,  9 Nov 2010 14:40:28 +0200
Message-ID: <1289306428-1067-2-git-send-email-jhnikula@gmail.com>
References: <1289306428-1067-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 7E8ED10386C
	for <alsa-devel@alsa-project.org>; Tue,  9 Nov 2010 13:40:08 +0100 (CET)
Received: by mail-ew0-f51.google.com with SMTP id 26so681797ewy.38
	for <alsa-devel@alsa-project.org>; Tue, 09 Nov 2010 04:40:08 -0800 (PST)
In-Reply-To: <1289306428-1067-1-git-send-email-jhnikula@gmail.com>
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Prints from pop_dbg are enabled when dapm_pop_time != 0. Convert it to
use dev_info so that parent device of DAPM context is printed.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 sound/soc/soc-dapm.c |   44 ++++++++++++++++++++++++++------------------
 1 files changed, 26 insertions(+), 18 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index e8997bb..450307c 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -91,17 +91,24 @@ static void pop_wait(u32 pop_time)
 		schedule_timeout_uninterruptible(msecs_to_jiffies(pop_time));
 }
 
-static void pop_dbg(u32 pop_time, const char *fmt, ...)
+static void pop_dbg(struct device *dev, u32 pop_time, const char *fmt, ...)
 {
 	va_list args;
+	char *buf;
 
-	va_start(args, fmt);
+	if (!pop_time)
+		return;
 
-	if (pop_time) {
-		vprintk(fmt, args);
-	}
+	buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	if (buf == NULL)
+		return;
 
+	va_start(args, fmt);
+	vsnprintf(buf, PAGE_SIZE, fmt, args);
+	dev_info(dev, buf);
 	va_end(args);
+
+	kfree(buf);
 }
 
 /* create a new dapm widget */
@@ -313,7 +320,8 @@ static int dapm_update_bits(struct snd_soc_dapm_widget *widget)
 
 	change = old != new;
 	if (change) {
-		pop_dbg(card->pop_time, "pop test %s : %s in %d ms\n",
+		pop_dbg(dapm->dev, card->pop_time,
+			"pop test %s : %s in %d ms\n",
 			widget->name, widget->power ? "on" : "off",
 			card->pop_time);
 		pop_wait(card->pop_time);
@@ -745,15 +753,15 @@ static void dapm_seq_run_coalesced(struct snd_soc_dapm_context *dapm,
 		if (power)
 			value |= cur_mask;
 
-		pop_dbg(card->pop_time,
+		pop_dbg(dapm->dev, card->pop_time,
 			"pop test : Queue %s: reg=0x%x, 0x%x/0x%x\n",
 			w->name, reg, value, mask);
 
 		/* power up pre event */
 		if (w->power && w->event &&
 		    (w->event_flags & SND_SOC_DAPM_PRE_PMU)) {
-			pop_dbg(card->pop_time, "pop test : %s PRE_PMU\n",
-				w->name);
+			pop_dbg(dapm->dev, card->pop_time,
+				"pop test : %s PRE_PMU\n", w->name);
 			ret = w->event(w, NULL, SND_SOC_DAPM_PRE_PMU);
 			if (ret < 0)
 				dev_err(dapm->dev,
@@ -764,8 +772,8 @@ static void dapm_seq_run_coalesced(struct snd_soc_dapm_context *dapm,
 		/* power down pre event */
 		if (!w->power && w->event &&
 		    (w->event_flags & SND_SOC_DAPM_PRE_PMD)) {
-			pop_dbg(card->pop_time, "pop test : %s PRE_PMD\n",
-				w->name);
+			pop_dbg(dapm->dev, card->pop_time,
+				"pop test : %s PRE_PMD\n", w->name);
 			ret = w->event(w, NULL, SND_SOC_DAPM_PRE_PMD);
 			if (ret < 0)
 				dev_err(dapm->dev,
@@ -775,7 +783,7 @@ static void dapm_seq_run_coalesced(struct snd_soc_dapm_context *dapm,
 	}
 
 	if (reg >= 0) {
-		pop_dbg(card->pop_time,
+		pop_dbg(dapm->dev, card->pop_time,
 			"pop test : Applying 0x%x/0x%x to %x in %dms\n",
 			value, mask, reg, card->pop_time);
 		pop_wait(card->pop_time);
@@ -786,8 +794,8 @@ static void dapm_seq_run_coalesced(struct snd_soc_dapm_context *dapm,
 		/* power up post event */
 		if (w->power && w->event &&
 		    (w->event_flags & SND_SOC_DAPM_POST_PMU)) {
-			pop_dbg(card->pop_time, "pop test : %s POST_PMU\n",
-				w->name);
+			pop_dbg(dapm->dev, card->pop_time,
+				"pop test : %s POST_PMU\n", w->name);
 			ret = w->event(w,
 				       NULL, SND_SOC_DAPM_POST_PMU);
 			if (ret < 0)
@@ -799,8 +807,8 @@ static void dapm_seq_run_coalesced(struct snd_soc_dapm_context *dapm,
 		/* power down post event */
 		if (!w->power && w->event &&
 		    (w->event_flags & SND_SOC_DAPM_POST_PMD)) {
-			pop_dbg(card->pop_time, "pop test : %s POST_PMD\n",
-				w->name);
+			pop_dbg(dapm->dev, card->pop_time,
+				"pop test : %s POST_PMD\n", w->name);
 			ret = w->event(w, NULL, SND_SOC_DAPM_POST_PMD);
 			if (ret < 0)
 				dev_err(dapm->dev,
@@ -1025,8 +1033,8 @@ static int dapm_power_widgets(struct snd_soc_dapm_context *dapm, int event)
 				"Failed to apply active bias: %d\n", ret);
 	}
 
-	pop_dbg(card->pop_time, "DAPM sequencing finished, waiting %dms\n",
-		card->pop_time);
+	pop_dbg(dapm->dev, card->pop_time,
+		"DAPM sequencing finished, waiting %dms\n", card->pop_time);
 	pop_wait(card->pop_time);
 
 	return 0;
-- 
1.7.2.3
