From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 10/14] ASoC: Factor out application of power
	for generic widgets
Date: Tue, 14 Apr 2009 13:33:09 +0100
Message-ID: <1239712393-6428-11-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090414123220.GA6342@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 82C53103857
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Apr 2009 14:33:16 +0200 (CEST)
In-Reply-To: <20090414123220.GA6342@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

This is simple code motion, intended to support future refactoring of
the DAPM algorithms and (more immediately) the additon of events for
DACs and ADCs.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-dapm.c |  110 +++++++++++++++++++++++++++-----------------------
 1 files changed, 60 insertions(+), 50 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 46485de..713d125 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -522,6 +522,65 @@ int dapm_reg_event(struct snd_soc_dapm_widget *w,
 }
 EXPORT_SYMBOL_GPL(dapm_reg_event);
 
+/* Standard power change method, used to apply power changes to most
+ * widgets.
+ */
+static int dapm_generic_apply_power(struct snd_soc_dapm_widget *w)
+{
+	int ret;
+
+	/* call any power change event handlers */
+	if (w->event)
+		pr_debug("power %s event for %s flags %x\n",
+			 w->power ? "on" : "off",
+			 w->name, w->event_flags);
+
+	/* power up pre event */
+	if (w->power && w->event &&
+	    (w->event_flags & SND_SOC_DAPM_PRE_PMU)) {
+		ret = w->event(w, NULL, SND_SOC_DAPM_PRE_PMU);
+		if (ret < 0)
+			return ret;
+	}
+
+	/* power down pre event */
+	if (!w->power && w->event &&
+	    (w->event_flags & SND_SOC_DAPM_PRE_PMD)) {
+		ret = w->event(w, NULL, SND_SOC_DAPM_PRE_PMD);
+		if (ret < 0)
+			return ret;
+	}
+
+	/* Lower PGA volume to reduce pops */
+	if (w->id == snd_soc_dapm_pga && !w->power)
+		dapm_set_pga(w, w->power);
+
+	dapm_update_bits(w);
+
+	/* Raise PGA volume to reduce pops */
+	if (w->id == snd_soc_dapm_pga && w->power)
+		dapm_set_pga(w, w->power);
+
+	/* power up post event */
+	if (w->power && w->event &&
+	    (w->event_flags & SND_SOC_DAPM_POST_PMU)) {
+		ret = w->event(w,
+			       NULL, SND_SOC_DAPM_POST_PMU);
+		if (ret < 0)
+			return ret;
+	}
+
+	/* power down post event */
+	if (!w->power && w->event &&
+	    (w->event_flags & SND_SOC_DAPM_POST_PMD)) {
+		ret = w->event(w, NULL, SND_SOC_DAPM_POST_PMD);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
 /*
  * Scan a single DAPM widget for a complete audio path and update the
  * power status appropriately.
@@ -601,56 +660,7 @@ static int dapm_power_widget(struct snd_soc_codec *codec, int event,
 	if (!power_change)
 		return 0;
 
-	/* call any power change event handlers */
-	if (w->event)
-		pr_debug("power %s event for %s flags %x\n",
-			 w->power ? "on" : "off",
-			 w->name, w->event_flags);
-
-	/* power up pre event */
-	if (power && w->event &&
-	    (w->event_flags & SND_SOC_DAPM_PRE_PMU)) {
-		ret = w->event(w, NULL, SND_SOC_DAPM_PRE_PMU);
-		if (ret < 0)
-			return ret;
-	}
-
-	/* power down pre event */
-	if (!power && w->event &&
-	    (w->event_flags & SND_SOC_DAPM_PRE_PMD)) {
-		ret = w->event(w, NULL, SND_SOC_DAPM_PRE_PMD);
-		if (ret < 0)
-			return ret;
-	}
-
-	/* Lower PGA volume to reduce pops */
-	if (w->id == snd_soc_dapm_pga && !power)
-		dapm_set_pga(w, power);
-
-	dapm_update_bits(w);
-
-	/* Raise PGA volume to reduce pops */
-	if (w->id == snd_soc_dapm_pga && power)
-		dapm_set_pga(w, power);
-
-	/* power up post event */
-	if (power && w->event &&
-	    (w->event_flags & SND_SOC_DAPM_POST_PMU)) {
-		ret = w->event(w,
-			       NULL, SND_SOC_DAPM_POST_PMU);
-		if (ret < 0)
-			return ret;
-	}
-
-	/* power down post event */
-	if (!power && w->event &&
-	    (w->event_flags & SND_SOC_DAPM_POST_PMD)) {
-		ret = w->event(w, NULL, SND_SOC_DAPM_POST_PMD);
-		if (ret < 0)
-			return ret;
-	}
-
-	return 0;
+	return dapm_generic_apply_power(w);
 }
 
 /*
-- 
1.6.2.2
