From: Liam Girdwood <lrg@ti.com>
Subject: [PATCH 2/2] ASoC: DAPM - Make sure DAPM widget IO ops
	hold the component mutex.
Date: Tue,  6 Mar 2012 18:16:19 +0000
Message-ID: <1331057779-4630-2-git-send-email-lrg@ti.com>
References: <1331057779-4630-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog105.obsmtp.com (na3sys009aog105.obsmtp.com
	[74.125.149.75]) by alsa0.perex.cz (Postfix) with ESMTP id 8145824398
	for <alsa-devel@alsa-project.org>; Tue,  6 Mar 2012 19:16:32 +0100 (CET)
Received: by wibhq7 with SMTP id hq7so3163164wib.21
	for <alsa-devel@alsa-project.org>; Tue, 06 Mar 2012 10:16:29 -0800 (PST)
In-Reply-To: <1331057779-4630-1-git-send-email-lrg@ti.com>
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

Currently not all DAPM widget IO ops are holding their component mutex 
(codec or platform). Make sure this is now held for DAPM widget IO operations.

Signed-off-by: Liam Girdwood <lrg@ti.com>
---
 sound/soc/soc-dapm.c |   34 ++++++++++++++++++++++++++++------
 1 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index dcd1160..a837977 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -206,7 +206,23 @@ static int soc_widget_write(struct snd_soc_dapm_widget *w, int reg, int val)
 	return -1;
 }
 
-static int soc_widget_update_bits(struct snd_soc_dapm_widget *w,
+static inline void soc_widget_lock(struct snd_soc_dapm_widget *w)
+{
+	if (w->codec)
+		mutex_lock(&w->codec->mutex);
+	else if (w->platform)
+		mutex_lock(&w->platform->mutex);
+}
+
+static inline void soc_widget_unlock(struct snd_soc_dapm_widget *w)
+{
+	if (w->codec)
+		mutex_unlock(&w->codec->mutex);
+	else if (w->platform)
+		mutex_unlock(&w->platform->mutex);
+}
+
+static int soc_widget_update_bits_locked(struct snd_soc_dapm_widget *w,
 	unsigned short reg, unsigned int mask, unsigned int value)
 {
 	bool change;
@@ -219,18 +235,24 @@ static int soc_widget_update_bits(struct snd_soc_dapm_widget *w,
 		if (ret != 0)
 			return ret;
 	} else {
+		soc_widget_lock(w);
 		ret = soc_widget_read(w, reg);
-		if (ret < 0)
+		if (ret < 0) {
+			soc_widget_unlock(w);
 			return ret;
+		}
 
 		old = ret;
 		new = (old & ~mask) | (value & mask);
 		change = old != new;
 		if (change) {
 			ret = soc_widget_write(w, reg, new);
-			if (ret < 0)
+			if (ret < 0) {
+				soc_widget_unlock(w);
 				return ret;
+			}
 		}
+		soc_widget_unlock(w);
 	}
 
 	return change;
@@ -847,7 +869,7 @@ int dapm_reg_event(struct snd_soc_dapm_widget *w,
 	else
 		val = w->off_val;
 
-	soc_widget_update_bits(w, -(w->reg + 1),
+	soc_widget_update_bits_locked(w, -(w->reg + 1),
 			    w->mask << w->shift, val << w->shift);
 
 	return 0;
@@ -1105,7 +1127,7 @@ static void dapm_seq_run_coalesced(struct snd_soc_dapm_context *dapm,
 			"pop test : Applying 0x%x/0x%x to %x in %dms\n",
 			value, mask, reg, card->pop_time);
 		pop_wait(card->pop_time);
-		soc_widget_update_bits(w, reg, mask, value);
+		soc_widget_update_bits_locked(w, reg, mask, value);
 	}
 
 	list_for_each_entry(w, pending, power_list) {
@@ -1235,7 +1257,7 @@ static void dapm_widget_update(struct snd_soc_dapm_context *dapm)
 			       w->name, ret);
 	}
 
-	ret = snd_soc_update_bits(w->codec, update->reg, update->mask,
+	ret = soc_widget_update_bits_locked(w, update->reg, update->mask,
 				  update->val);
 	if (ret < 0)
 		pr_err("%s DAPM update failed: %d\n", w->name, ret);
-- 
1.7.5.4
