From: Stephen Warren <swarren@nvidia.com>
Subject: [PATCH 1/4] ASoC: s/w->kcontrols/w->kcontrol_news/g
Date: Thu, 28 Apr 2011 17:37:58 -0600
Message-ID: <1304033881-1160-2-git-send-email-swarren@nvidia.com>
References: <1304033881-1160-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id DA4CE1039DB
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Apr 2011 01:38:12 +0200 (CEST)
In-Reply-To: <1304033881-1160-1-git-send-email-swarren@nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

A future change will modify struct snd_soc_dapm_widget to store the
actual kcontrol pointers for each kcontrol_new in a field named
kcontrols. Rename the existing kcontrols field to enable this.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 include/sound/soc-dapm.h          |   68 ++++++++++++++++++------------------
 sound/soc/codecs/88pm860x-codec.c |    2 +-
 sound/soc/soc-dapm.c              |   28 ++++++++-------
 3 files changed, 50 insertions(+), 48 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index d5f1b9a..3733e4d 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -39,30 +39,30 @@
 
 /* codec domain */
 #define SND_SOC_DAPM_VMID(wname) \
-{	.id = snd_soc_dapm_vmid, .name = wname, .kcontrols = NULL, \
+{	.id = snd_soc_dapm_vmid, .name = wname, .kcontrol_news = NULL, \
 	.num_kcontrols = 0}
 
 /* platform domain */
 #define SND_SOC_DAPM_INPUT(wname) \
-{	.id = snd_soc_dapm_input, .name = wname, .kcontrols = NULL, \
+{	.id = snd_soc_dapm_input, .name = wname, .kcontrol_news = NULL, \
 	.num_kcontrols = 0, .reg = SND_SOC_NOPM }
 #define SND_SOC_DAPM_OUTPUT(wname) \
-{	.id = snd_soc_dapm_output, .name = wname, .kcontrols = NULL, \
+{	.id = snd_soc_dapm_output, .name = wname, .kcontrol_news = NULL, \
 	.num_kcontrols = 0, .reg = SND_SOC_NOPM }
 #define SND_SOC_DAPM_MIC(wname, wevent) \
-{	.id = snd_soc_dapm_mic, .name = wname, .kcontrols = NULL, \
+{	.id = snd_soc_dapm_mic, .name = wname, .kcontrol_news = NULL, \
 	.num_kcontrols = 0, .reg = SND_SOC_NOPM, .event = wevent, \
 	.event_flags = SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD}
 #define SND_SOC_DAPM_HP(wname, wevent) \
-{	.id = snd_soc_dapm_hp, .name = wname, .kcontrols = NULL, \
+{	.id = snd_soc_dapm_hp, .name = wname, .kcontrol_news = NULL, \
 	.num_kcontrols = 0, .reg = SND_SOC_NOPM, .event = wevent, \
 	.event_flags = SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD}
 #define SND_SOC_DAPM_SPK(wname, wevent) \
-{	.id = snd_soc_dapm_spk, .name = wname, .kcontrols = NULL, \
+{	.id = snd_soc_dapm_spk, .name = wname, .kcontrol_news = NULL, \
 	.num_kcontrols = 0, .reg = SND_SOC_NOPM, .event = wevent, \
 	.event_flags = SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD}
 #define SND_SOC_DAPM_LINE(wname, wevent) \
-{	.id = snd_soc_dapm_line, .name = wname, .kcontrols = NULL, \
+{	.id = snd_soc_dapm_line, .name = wname, .kcontrol_news = NULL, \
 	.num_kcontrols = 0, .reg = SND_SOC_NOPM, .event = wevent, \
 	.event_flags = SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD}
 
@@ -70,91 +70,91 @@
 #define SND_SOC_DAPM_PGA(wname, wreg, wshift, winvert,\
 	 wcontrols, wncontrols) \
 {	.id = snd_soc_dapm_pga, .name = wname, .reg = wreg, .shift = wshift, \
-	.invert = winvert, .kcontrols = wcontrols, .num_kcontrols = wncontrols}
+	.invert = winvert, .kcontrol_news = wcontrols, .num_kcontrols = wncontrols}
 #define SND_SOC_DAPM_OUT_DRV(wname, wreg, wshift, winvert,\
 	 wcontrols, wncontrols) \
 {	.id = snd_soc_dapm_out_drv, .name = wname, .reg = wreg, .shift = wshift, \
-	.invert = winvert, .kcontrols = wcontrols, .num_kcontrols = wncontrols}
+	.invert = winvert, .kcontrol_news = wcontrols, .num_kcontrols = wncontrols}
 #define SND_SOC_DAPM_MIXER(wname, wreg, wshift, winvert, \
 	 wcontrols, wncontrols)\
 {	.id = snd_soc_dapm_mixer, .name = wname, .reg = wreg, .shift = wshift, \
-	.invert = winvert, .kcontrols = wcontrols, .num_kcontrols = wncontrols}
+	.invert = winvert, .kcontrol_news = wcontrols, .num_kcontrols = wncontrols}
 #define SND_SOC_DAPM_MIXER_NAMED_CTL(wname, wreg, wshift, winvert, \
 	 wcontrols, wncontrols)\
 {       .id = snd_soc_dapm_mixer_named_ctl, .name = wname, .reg = wreg, \
-	.shift = wshift, .invert = winvert, .kcontrols = wcontrols, \
+	.shift = wshift, .invert = winvert, .kcontrol_news = wcontrols, \
 	.num_kcontrols = wncontrols}
 #define SND_SOC_DAPM_MICBIAS(wname, wreg, wshift, winvert) \
 {	.id = snd_soc_dapm_micbias, .name = wname, .reg = wreg, .shift = wshift, \
-	.invert = winvert, .kcontrols = NULL, .num_kcontrols = 0}
+	.invert = winvert, .kcontrol_news = NULL, .num_kcontrols = 0}
 #define SND_SOC_DAPM_SWITCH(wname, wreg, wshift, winvert, wcontrols) \
 {	.id = snd_soc_dapm_switch, .name = wname, .reg = wreg, .shift = wshift, \
-	.invert = winvert, .kcontrols = wcontrols, .num_kcontrols = 1}
+	.invert = winvert, .kcontrol_news = wcontrols, .num_kcontrols = 1}
 #define SND_SOC_DAPM_MUX(wname, wreg, wshift, winvert, wcontrols) \
 {	.id = snd_soc_dapm_mux, .name = wname, .reg = wreg, .shift = wshift, \
-	.invert = winvert, .kcontrols = wcontrols, .num_kcontrols = 1}
+	.invert = winvert, .kcontrol_news = wcontrols, .num_kcontrols = 1}
 #define SND_SOC_DAPM_VIRT_MUX(wname, wreg, wshift, winvert, wcontrols) \
 {	.id = snd_soc_dapm_virt_mux, .name = wname, .reg = wreg, .shift = wshift, \
-	.invert = winvert, .kcontrols = wcontrols, .num_kcontrols = 1}
+	.invert = winvert, .kcontrol_news = wcontrols, .num_kcontrols = 1}
 #define SND_SOC_DAPM_VALUE_MUX(wname, wreg, wshift, winvert, wcontrols) \
 {	.id = snd_soc_dapm_value_mux, .name = wname, .reg = wreg, \
-	.shift = wshift, .invert = winvert, .kcontrols = wcontrols, \
+	.shift = wshift, .invert = winvert, .kcontrol_news = wcontrols, \
 	.num_kcontrols = 1}
 
 /* Simplified versions of above macros, assuming wncontrols = ARRAY_SIZE(wcontrols) */
 #define SOC_PGA_ARRAY(wname, wreg, wshift, winvert,\
 	 wcontrols) \
 {	.id = snd_soc_dapm_pga, .name = wname, .reg = wreg, .shift = wshift, \
-	.invert = winvert, .kcontrols = wcontrols, .num_kcontrols = ARRAY_SIZE(wcontrols)}
+	.invert = winvert, .kcontrol_news = wcontrols, .num_kcontrols = ARRAY_SIZE(wcontrols)}
 #define SOC_MIXER_ARRAY(wname, wreg, wshift, winvert, \
 	 wcontrols)\
 {	.id = snd_soc_dapm_mixer, .name = wname, .reg = wreg, .shift = wshift, \
-	.invert = winvert, .kcontrols = wcontrols, .num_kcontrols = ARRAY_SIZE(wcontrols)}
+	.invert = winvert, .kcontrol_news = wcontrols, .num_kcontrols = ARRAY_SIZE(wcontrols)}
 #define SOC_MIXER_NAMED_CTL_ARRAY(wname, wreg, wshift, winvert, \
 	 wcontrols)\
 {       .id = snd_soc_dapm_mixer_named_ctl, .name = wname, .reg = wreg, \
-	.shift = wshift, .invert = winvert, .kcontrols = wcontrols, \
+	.shift = wshift, .invert = winvert, .kcontrol_news = wcontrols, \
 	.num_kcontrols = ARRAY_SIZE(wcontrols)}
 
 /* path domain with event - event handler must return 0 for success */
 #define SND_SOC_DAPM_PGA_E(wname, wreg, wshift, winvert, wcontrols, \
 	wncontrols, wevent, wflags) \
 {	.id = snd_soc_dapm_pga, .name = wname, .reg = wreg, .shift = wshift, \
-	.invert = winvert, .kcontrols = wcontrols, .num_kcontrols = wncontrols, \
+	.invert = winvert, .kcontrol_news = wcontrols, .num_kcontrols = wncontrols, \
 	.event = wevent, .event_flags = wflags}
 #define SND_SOC_DAPM_OUT_DRV_E(wname, wreg, wshift, winvert, wcontrols, \
 	wncontrols, wevent, wflags) \
 {	.id = snd_soc_dapm_out_drv, .name = wname, .reg = wreg, .shift = wshift, \
-	.invert = winvert, .kcontrols = wcontrols, .num_kcontrols = wncontrols, \
+	.invert = winvert, .kcontrol_news = wcontrols, .num_kcontrols = wncontrols, \
 	.event = wevent, .event_flags = wflags}
 #define SND_SOC_DAPM_MIXER_E(wname, wreg, wshift, winvert, wcontrols, \
 	wncontrols, wevent, wflags) \
 {	.id = snd_soc_dapm_mixer, .name = wname, .reg = wreg, .shift = wshift, \
-	.invert = winvert, .kcontrols = wcontrols, .num_kcontrols = wncontrols, \
+	.invert = winvert, .kcontrol_news = wcontrols, .num_kcontrols = wncontrols, \
 	.event = wevent, .event_flags = wflags}
 #define SND_SOC_DAPM_MIXER_NAMED_CTL_E(wname, wreg, wshift, winvert, \
 	wcontrols, wncontrols, wevent, wflags) \
 {       .id = snd_soc_dapm_mixer, .name = wname, .reg = wreg, .shift = wshift, \
-	.invert = winvert, .kcontrols = wcontrols, \
+	.invert = winvert, .kcontrol_news = wcontrols, \
 	.num_kcontrols = wncontrols, .event = wevent, .event_flags = wflags}
 #define SND_SOC_DAPM_MICBIAS_E(wname, wreg, wshift, winvert, wevent, wflags) \
 {	.id = snd_soc_dapm_micbias, .name = wname, .reg = wreg, .shift = wshift, \
-	.invert = winvert, .kcontrols = NULL, .num_kcontrols = 0, \
+	.invert = winvert, .kcontrol_news = NULL, .num_kcontrols = 0, \
 	.event = wevent, .event_flags = wflags}
 #define SND_SOC_DAPM_SWITCH_E(wname, wreg, wshift, winvert, wcontrols, \
 	wevent, wflags) \
 {	.id = snd_soc_dapm_switch, .name = wname, .reg = wreg, .shift = wshift, \
-	.invert = winvert, .kcontrols = wcontrols, .num_kcontrols = 1, \
+	.invert = winvert, .kcontrol_news = wcontrols, .num_kcontrols = 1, \
 	.event = wevent, .event_flags = wflags}
 #define SND_SOC_DAPM_MUX_E(wname, wreg, wshift, winvert, wcontrols, \
 	wevent, wflags) \
 {	.id = snd_soc_dapm_mux, .name = wname, .reg = wreg, .shift = wshift, \
-	.invert = winvert, .kcontrols = wcontrols, .num_kcontrols = 1, \
+	.invert = winvert, .kcontrol_news = wcontrols, .num_kcontrols = 1, \
 	.event = wevent, .event_flags = wflags}
 #define SND_SOC_DAPM_VIRT_MUX_E(wname, wreg, wshift, winvert, wcontrols, \
 	wevent, wflags) \
 {	.id = snd_soc_dapm_virt_mux, .name = wname, .reg = wreg, .shift = wshift, \
-	.invert = winvert, .kcontrols = wcontrols, .num_kcontrols = 1, \
+	.invert = winvert, .kcontrol_news = wcontrols, .num_kcontrols = 1, \
 	.event = wevent, .event_flags = wflags}
 
 /* additional sequencing control within an event type */
@@ -173,26 +173,26 @@
 #define SOC_PGA_E_ARRAY(wname, wreg, wshift, winvert, wcontrols, \
 	wevent, wflags) \
 {	.id = snd_soc_dapm_pga, .name = wname, .reg = wreg, .shift = wshift, \
-	.invert = winvert, .kcontrols = wcontrols, .num_kcontrols = ARRAY_SIZE(wcontrols), \
+	.invert = winvert, .kcontrol_news = wcontrols, .num_kcontrols = ARRAY_SIZE(wcontrols), \
 	.event = wevent, .event_flags = wflags}
 #define SOC_MIXER_E_ARRAY(wname, wreg, wshift, winvert, wcontrols, \
 	wevent, wflags) \
 {	.id = snd_soc_dapm_mixer, .name = wname, .reg = wreg, .shift = wshift, \
-	.invert = winvert, .kcontrols = wcontrols, .num_kcontrols = ARRAY_SIZE(wcontrols), \
+	.invert = winvert, .kcontrol_news = wcontrols, .num_kcontrols = ARRAY_SIZE(wcontrols), \
 	.event = wevent, .event_flags = wflags}
 #define SOC_MIXER_NAMED_CTL_E_ARRAY(wname, wreg, wshift, winvert, \
 	wcontrols, wevent, wflags) \
 {       .id = snd_soc_dapm_mixer, .name = wname, .reg = wreg, .shift = wshift, \
-	.invert = winvert, .kcontrols = wcontrols, \
+	.invert = winvert, .kcontrol_news = wcontrols, \
 	.num_kcontrols = ARRAY_SIZE(wcontrols), .event = wevent, .event_flags = wflags}
 
 /* events that are pre and post DAPM */
 #define SND_SOC_DAPM_PRE(wname, wevent) \
-{	.id = snd_soc_dapm_pre, .name = wname, .kcontrols = NULL, \
+{	.id = snd_soc_dapm_pre, .name = wname, .kcontrol_news = NULL, \
 	.num_kcontrols = 0, .reg = SND_SOC_NOPM, .event = wevent, \
 	.event_flags = SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_PRE_PMD}
 #define SND_SOC_DAPM_POST(wname, wevent) \
-{	.id = snd_soc_dapm_post, .name = wname, .kcontrols = NULL, \
+{	.id = snd_soc_dapm_post, .name = wname, .kcontrol_news = NULL, \
 	.num_kcontrols = 0, .reg = SND_SOC_NOPM, .event = wevent, \
 	.event_flags = SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD}
 
@@ -232,7 +232,7 @@
 
 /* generic widgets */
 #define SND_SOC_DAPM_REG(wid, wname, wreg, wshift, wmask, won_val, woff_val) \
-{	.id = wid, .name = wname, .kcontrols = NULL, .num_kcontrols = 0, \
+{	.id = wid, .name = wname, .kcontrol_news = NULL, .num_kcontrols = 0, \
 	.reg = -((wreg) + 1), .shift = wshift, .mask = wmask, \
 	.on_val = won_val, .off_val = woff_val, .event = dapm_reg_event, \
 	.event_flags = SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD}
@@ -472,7 +472,7 @@ struct snd_soc_dapm_widget {
 
 	/* kcontrols that relate to this widget */
 	int num_kcontrols;
-	const struct snd_kcontrol_new *kcontrols;
+	const struct snd_kcontrol_new *kcontrol_news;
 
 	/* widget input and outputs */
 	struct list_head sources;
diff --git a/sound/soc/codecs/88pm860x-codec.c b/sound/soc/codecs/88pm860x-codec.c
index 06b6981..1924157 100644
--- a/sound/soc/codecs/88pm860x-codec.c
+++ b/sound/soc/codecs/88pm860x-codec.c
@@ -120,7 +120,7 @@
  */
 #define PM860X_DAPM_OUTPUT(wname, wevent)	\
 {	.id = snd_soc_dapm_pga, .name = wname, .reg = SND_SOC_NOPM, \
-	.shift = 0, .invert = 0, .kcontrols = NULL, \
+	.shift = 0, .invert = 0, .kcontrol_news = NULL, \
 	.num_kcontrols = 0, .event = wevent, \
 	.event_flags = SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD, }
 
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 378f08a..401bb0f 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -187,7 +187,7 @@ static void dapm_set_path_status(struct snd_soc_dapm_widget *w,
 	case snd_soc_dapm_mixer_named_ctl: {
 		int val;
 		struct soc_mixer_control *mc = (struct soc_mixer_control *)
-			w->kcontrols[i].private_value;
+			w->kcontrol_news[i].private_value;
 		unsigned int reg = mc->reg;
 		unsigned int shift = mc->shift;
 		int max = mc->max;
@@ -204,7 +204,8 @@ static void dapm_set_path_status(struct snd_soc_dapm_widget *w,
 	}
 	break;
 	case snd_soc_dapm_mux: {
-		struct soc_enum *e = (struct soc_enum *)w->kcontrols[i].private_value;
+		struct soc_enum *e = (struct soc_enum *)
+			w->kcontrol_news[i].private_value;
 		int val, item, bitmask;
 
 		for (bitmask = 1; bitmask < e->max; bitmask <<= 1)
@@ -220,7 +221,8 @@ static void dapm_set_path_status(struct snd_soc_dapm_widget *w,
 	}
 	break;
 	case snd_soc_dapm_virt_mux: {
-		struct soc_enum *e = (struct soc_enum *)w->kcontrols[i].private_value;
+		struct soc_enum *e = (struct soc_enum *)
+			w->kcontrol_news[i].private_value;
 
 		p->connect = 0;
 		/* since a virtual mux has no backing registers to
@@ -235,7 +237,7 @@ static void dapm_set_path_status(struct snd_soc_dapm_widget *w,
 	break;
 	case snd_soc_dapm_value_mux: {
 		struct soc_enum *e = (struct soc_enum *)
-			w->kcontrols[i].private_value;
+			w->kcontrol_news[i].private_value;
 		int val, item;
 
 		val = snd_soc_read(w->codec, e->reg);
@@ -310,11 +312,11 @@ static int dapm_connect_mixer(struct snd_soc_dapm_context *dapm,
 
 	/* search for mixer kcontrol */
 	for (i = 0; i < dest->num_kcontrols; i++) {
-		if (!strcmp(control_name, dest->kcontrols[i].name)) {
+		if (!strcmp(control_name, dest->kcontrol_news[i].name)) {
 			list_add(&path->list, &dapm->card->paths);
 			list_add(&path->list_sink, &dest->sources);
 			list_add(&path->list_source, &src->sinks);
-			path->name = dest->kcontrols[i].name;
+			path->name = dest->kcontrol_news[i].name;
 			dapm_set_path_status(dest, path, i);
 			return 0;
 		}
@@ -349,7 +351,7 @@ static int dapm_new_mixer(struct snd_soc_dapm_context *dapm,
 		list_for_each_entry(path, &w->sources, list_sink) {
 
 			/* mixer/mux paths name must match control name */
-			if (path->name != (char*)w->kcontrols[i].name)
+			if (path->name != (char *)w->kcontrol_news[i].name)
 				continue;
 
 			/* add dapm control with long name.
@@ -358,7 +360,7 @@ static int dapm_new_mixer(struct snd_soc_dapm_context *dapm,
 			 * for dapm_mixer_named_ctl this is simply the
 			 * kcontrol name.
 			 */
-			name_len = strlen(w->kcontrols[i].name) + 1;
+			name_len = strlen(w->kcontrol_news[i].name) + 1;
 			if (w->id != snd_soc_dapm_mixer_named_ctl)
 				name_len += 1 + strlen(w->name);
 
@@ -377,17 +379,17 @@ static int dapm_new_mixer(struct snd_soc_dapm_context *dapm,
 				 */
 				snprintf(path->long_name, name_len, "%s %s",
 					 w->name + prefix_len,
-					 w->kcontrols[i].name);
+					 w->kcontrol_news[i].name);
 				break;
 			case snd_soc_dapm_mixer_named_ctl:
 				snprintf(path->long_name, name_len, "%s",
-					 w->kcontrols[i].name);
+					 w->kcontrol_news[i].name);
 				break;
 			}
 
 			path->long_name[name_len - 1] = '\0';
 
-			path->kcontrol = snd_soc_cnew(&w->kcontrols[i], w,
+			path->kcontrol = snd_soc_cnew(&w->kcontrol_news[i], w,
 						      path->long_name, prefix);
 			ret = snd_ctl_add(card, path->kcontrol);
 			if (ret < 0) {
@@ -433,7 +435,7 @@ static int dapm_new_mux(struct snd_soc_dapm_context *dapm,
 	 * process but we're also using the same prefix for widgets so
 	 * cut the prefix off the front of the widget name.
 	 */
-	kcontrol = snd_soc_cnew(&w->kcontrols[0], w, w->name + prefix_len,
+	kcontrol = snd_soc_cnew(&w->kcontrol_news[0], w, w->name + prefix_len,
 				prefix);
 	ret = snd_ctl_add(card, kcontrol);
 
@@ -1623,7 +1625,7 @@ static int snd_soc_dapm_add_route(struct snd_soc_dapm_context *dapm,
 	case snd_soc_dapm_virt_mux:
 	case snd_soc_dapm_value_mux:
 		ret = dapm_connect_mux(dapm, wsource, wsink, path, control,
-			&wsink->kcontrols[0]);
+			&wsink->kcontrol_news[0]);
 		if (ret != 0)
 			goto err;
 		break;
-- 
1.7.0.4
