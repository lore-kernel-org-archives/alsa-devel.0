From: Liam Girdwood <lrg@ti.com>
Subject: [PATCH] ASoC: dapm - Refactor widget IO functions in
	preparation for platform widgets.
Date: Thu, 9 Jun 2011 19:10:49 +0100
Message-ID: <1307643049-3819-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id B1ACB103BE1
	for <alsa-devel@alsa-project.org>;
	Thu,  9 Jun 2011 20:11:03 +0200 (CEST)
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

Currently widget IO is tightly coupled to the CODEC drivers. Future platform DSP
devices have mixer components that can alter power usage and hence require full
DAPM support.

This provides a generic widget IO operation wrapper in preparation for
future patches that implement platform driver DAPM.

Signed-off-by: Liam Girdwood <lrg@ti.com>
---
 sound/soc/soc-dapm.c |   55 ++++++++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 49 insertions(+), 6 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 34106bc..7b7af9f 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -124,6 +124,49 @@ static inline struct snd_soc_dapm_widget *dapm_cnew_widget(
 	return kmemdup(_widget, sizeof(*_widget), GFP_KERNEL);
 }
 
+static int soc_widget_read(struct snd_soc_dapm_widget *w, int reg)
+{
+	if (w->codec)
+		return snd_soc_read(w->codec, reg);
+	return 0;
+}
+
+static int soc_widget_write(struct snd_soc_dapm_widget *w,int reg, int val)
+{
+	if (w->codec)
+		return snd_soc_write(w->codec, reg, val);
+	return 0;
+}
+
+int soc_widget_update_bits(struct snd_soc_dapm_widget *w, unsigned short reg,
+				unsigned int mask, unsigned int value)
+{
+	int change;
+	unsigned int old, new;
+
+	old = soc_widget_read(w, reg);
+	new = (old & ~mask) | value;
+	change = old != new;
+	if (change)
+		soc_widget_write(w, reg, new);
+
+	return change;
+}
+
+int soc_widget_test_bits(struct snd_soc_dapm_widget *w, unsigned short reg,
+				unsigned int mask, unsigned int value)
+{
+	int change;
+	unsigned int old, new;
+
+	old = soc_widget_read(w, reg);
+	new = (old & ~mask) | value;
+	change = old != new;
+
+	return change;
+}
+
+
 /**
  * snd_soc_dapm_set_bias_level - set the bias level for the system
  * @dapm: DAPM context
@@ -181,7 +224,7 @@ static void dapm_set_path_status(struct snd_soc_dapm_widget *w,
 		unsigned int mask = (1 << fls(max)) - 1;
 		unsigned int invert = mc->invert;
 
-		val = snd_soc_read(w->codec, reg);
+		val = soc_widget_read(w, reg);
 		val = (val >> shift) & mask;
 
 		if ((invert && !val) || (!invert && val))
@@ -197,7 +240,7 @@ static void dapm_set_path_status(struct snd_soc_dapm_widget *w,
 
 		for (bitmask = 1; bitmask < e->max; bitmask <<= 1)
 			;
-		val = snd_soc_read(w->codec, e->reg);
+		val = soc_widget_read(w, e->reg);
 		item = (val >> e->shift_l) & (bitmask - 1);
 
 		p->connect = 0;
@@ -227,7 +270,7 @@ static void dapm_set_path_status(struct snd_soc_dapm_widget *w,
 			w->kcontrol_news[i].private_value;
 		int val, item;
 
-		val = snd_soc_read(w->codec, e->reg);
+		val = soc_widget_read(w, e->reg);
 		val = (val >> e->shift_l) & e->mask;
 		for (item = 0; item < e->max; item++) {
 			if (val == e->values[item])
@@ -669,7 +712,7 @@ int dapm_reg_event(struct snd_soc_dapm_widget *w,
 	else
 		val = w->off_val;
 
-	snd_soc_update_bits(w->codec, -(w->reg + 1),
+	soc_widget_update_bits(w, -(w->reg + 1),
 			    w->mask << w->shift, val << w->shift);
 
 	return 0;
@@ -877,7 +920,7 @@ static void dapm_seq_run_coalesced(struct snd_soc_dapm_context *dapm,
 			"pop test : Applying 0x%x/0x%x to %x in %dms\n",
 			value, mask, reg, card->pop_time);
 		pop_wait(card->pop_time);
-		snd_soc_update_bits(dapm->codec, reg, mask, value);
+		soc_widget_update_bits(w, reg, mask, value);
 	}
 
 	list_for_each_entry(w, pending, power_list) {
@@ -1878,7 +1921,7 @@ int snd_soc_dapm_new_widgets(struct snd_soc_dapm_context *dapm)
 
 		/* Read the initial power state from the device */
 		if (w->reg >= 0) {
-			val = snd_soc_read(w->codec, w->reg);
+			val = soc_widget_read(w, w->reg);
 			val &= 1 << w->shift;
 			if (w->invert)
 				val = !val;
-- 
1.7.4.1
