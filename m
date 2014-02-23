From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 11/11] ASoC: dapm: Break dapm_set_path_status()
	appart
Date: Sun, 23 Feb 2014 16:10:21 +0100
Message-ID: <1393168221-23018-12-git-send-email-lars@metafoo.de>
References: <1393168221-23018-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-167.synserver.de (smtp-out-249.synserver.de
 [212.40.185.249])
 by alsa0.perex.cz (Postfix) with ESMTP id 8ED45265133
 for <alsa-devel@alsa-project.org>; Sun, 23 Feb 2014 16:10:12 +0100 (CET)
In-Reply-To: <1393168221-23018-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, patches@opensource.wolfsonmicro.com, =?UTF-8?q?Philippe=20R=C3=A9tornaz?= <philippe.retornaz@epfl.ch>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Steffen Trumtrar <s.trumtrar@pengutronix.de>, Jerry Wong <jerry.wong@maximintegrated.com>
List-Id: alsa-devel@alsa-project.org

There are three different completely independent code paths in
dapm_set_path_status(). One of them is never used at all and the other two (one
for mixers, one for MUXs) have their distincive callsites that always go onto
the same path. Breaking the function into two parts allows us to reduce the code
size and in the MUX case also do some optimizations to avoid having to calcualte
the selected item for each item again.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-dapm.c | 133 +++++++++++++++++----------------------------------
 1 file changed, 44 insertions(+), 89 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index c07c7fb..3651a37 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -495,93 +495,6 @@ out:
 	return ret;
 }
 
-/* set up initial codec paths */
-static void dapm_set_path_status(struct snd_soc_dapm_widget *w,
-	struct snd_soc_dapm_path *p, int i)
-{
-	switch (w->id) {
-	case snd_soc_dapm_switch:
-	case snd_soc_dapm_mixer:
-	case snd_soc_dapm_mixer_named_ctl: {
-		unsigned int val;
-		struct soc_mixer_control *mc = (struct soc_mixer_control *)
-			w->kcontrol_news[i].private_value;
-		int reg = mc->reg;
-		unsigned int shift = mc->shift;
-		int max = mc->max;
-		unsigned int mask = (1 << fls(max)) - 1;
-		unsigned int invert = mc->invert;
-
-		if (reg != SND_SOC_NOPM) {
-			soc_widget_read(w, reg, &val);
-			val = (val >> shift) & mask;
-			if (invert)
-				val = max - val;
-			p->connect = !!val;
-		} else {
-			p->connect = 0;
-		}
-
-	}
-	break;
-	case snd_soc_dapm_mux: {
-		struct soc_enum *e = (struct soc_enum *)
-			w->kcontrol_news[i].private_value;
-		unsigned int val, item;
-
-		if (e->reg != SND_SOC_NOPM) {
-			soc_widget_read(w, e->reg, &val);
-			val = (val >> e->shift_l) & e->mask;
-			item = snd_soc_enum_val_to_item(e, val);
-		} else {
-			/* since a virtual mux has no backing registers to
-			 * decide which path to connect, it will try to match
-			 * with the first enumeration.  This is to ensure
-			 * that the default mux choice (the first) will be
-			 * correctly powered up during initialization.
-			 */
-			item = 0;
-		}
-
-		if (item < e->items && !strcmp(p->name, e->texts[item]))
-			p->connect = 1;
-		else
-			p->connect = 0;
-	}
-	break;
-	/* does not affect routing - always connected */
-	case snd_soc_dapm_pga:
-	case snd_soc_dapm_out_drv:
-	case snd_soc_dapm_output:
-	case snd_soc_dapm_adc:
-	case snd_soc_dapm_input:
-	case snd_soc_dapm_siggen:
-	case snd_soc_dapm_dac:
-	case snd_soc_dapm_micbias:
-	case snd_soc_dapm_vmid:
-	case snd_soc_dapm_supply:
-	case snd_soc_dapm_regulator_supply:
-	case snd_soc_dapm_clock_supply:
-	case snd_soc_dapm_aif_in:
-	case snd_soc_dapm_aif_out:
-	case snd_soc_dapm_dai_in:
-	case snd_soc_dapm_dai_out:
-	case snd_soc_dapm_hp:
-	case snd_soc_dapm_mic:
-	case snd_soc_dapm_spk:
-	case snd_soc_dapm_line:
-	case snd_soc_dapm_dai_link:
-	case snd_soc_dapm_kcontrol:
-		p->connect = 1;
-	break;
-	/* does affect routing - dynamically connected */
-	case snd_soc_dapm_pre:
-	case snd_soc_dapm_post:
-		p->connect = 0;
-	break;
-	}
-}
-
 /* connect mux widget to its interconnecting audio paths */
 static int dapm_connect_mux(struct snd_soc_dapm_context *dapm,
 	struct snd_soc_dapm_widget *src, struct snd_soc_dapm_widget *dest,
@@ -589,15 +502,33 @@ static int dapm_connect_mux(struct snd_soc_dapm_context *dapm,
 	const struct snd_kcontrol_new *kcontrol)
 {
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
+	unsigned int val, item;
 	int i;
 
+	if (e->reg != SND_SOC_NOPM) {
+		soc_widget_read(dest, e->reg, &val);
+		val = (val >> e->shift_l) & e->mask;
+		item = snd_soc_enum_val_to_item(e, val);
+	} else {
+		/* since a virtual mux has no backing registers to
+		 * decide which path to connect, it will try to match
+		 * with the first enumeration.  This is to ensure
+		 * that the default mux choice (the first) will be
+		 * correctly powered up during initialization.
+		 */
+		item = 0;
+	}
+
 	for (i = 0; i < e->items; i++) {
 		if (!(strcmp(control_name, e->texts[i]))) {
 			list_add(&path->list, &dapm->card->paths);
 			list_add(&path->list_sink, &dest->sources);
 			list_add(&path->list_source, &src->sinks);
 			path->name = (char*)e->texts[i];
-			dapm_set_path_status(dest, path, 0);
+			if (i == item)
+				path->connect = 1;
+			else
+				path->connect = 0;
 			return 0;
 		}
 	}
@@ -605,6 +536,30 @@ static int dapm_connect_mux(struct snd_soc_dapm_context *dapm,
 	return -ENODEV;
 }
 
+/* set up initial codec paths */
+static void dapm_set_mixer_path_status(struct snd_soc_dapm_widget *w,
+	struct snd_soc_dapm_path *p, int i)
+{
+	struct soc_mixer_control *mc = (struct soc_mixer_control *)
+		w->kcontrol_news[i].private_value;
+	unsigned int reg = mc->reg;
+	unsigned int shift = mc->shift;
+	unsigned int max = mc->max;
+	unsigned int mask = (1 << fls(max)) - 1;
+	unsigned int invert = mc->invert;
+	unsigned int val;
+
+	if (reg != SND_SOC_NOPM) {
+		soc_widget_read(w, reg, &val);
+		val = (val >> shift) & mask;
+		if (invert)
+			val = max - val;
+		p->connect = !!val;
+	} else {
+		p->connect = 0;
+	}
+}
+
 /* connect mixer widget to its interconnecting audio paths */
 static int dapm_connect_mixer(struct snd_soc_dapm_context *dapm,
 	struct snd_soc_dapm_widget *src, struct snd_soc_dapm_widget *dest,
@@ -619,7 +574,7 @@ static int dapm_connect_mixer(struct snd_soc_dapm_context *dapm,
 			list_add(&path->list_sink, &dest->sources);
 			list_add(&path->list_source, &src->sinks);
 			path->name = dest->kcontrol_news[i].name;
-			dapm_set_path_status(dest, path, i);
+			dapm_set_mixer_path_status(dest, path, i);
 			return 0;
 		}
 	}
-- 
1.8.0
