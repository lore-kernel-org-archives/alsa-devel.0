From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: soc-dapm: Introduce the new
	snd_soc_dapm_virt_mux type
Date: Thu, 16 Dec 2010 15:53:39 +0000
Message-ID: <1292514819-4254-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8CE71244CD
	for <alsa-devel@alsa-project.org>; Thu, 16 Dec 2010 16:53:45 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

This new type is a virtual version of snd_soc_dapm_mux.  It is used
when a backing register value is not necessary for deciding which
input path to connect.  A simple virtual enumeration control e.g.
SOC_DAPM_ENUM_VIRT() can be exposed to userspace which will be used
to choose which path to connect.

The snd_soc_dapm_virt_mux type ensures that during the initial
path setup, the first (which is also the default) input path will
be connected.

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 include/sound/soc-dapm.h |    9 +++++++++
 sound/soc/soc-dapm.c     |   19 +++++++++++++++++++
 2 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 2f76a51..57aab55 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -93,6 +93,9 @@
 #define SND_SOC_DAPM_MUX(wname, wreg, wshift, winvert, wcontrols) \
 {	.id = snd_soc_dapm_mux, .name = wname, .reg = wreg, .shift = wshift, \
 	.invert = winvert, .kcontrols = wcontrols, .num_kcontrols = 1}
+#define SND_SOC_DAPM_VIRT_MUX(wname, wreg, wshift, winvert, wcontrols) \
+{	.id = snd_soc_dapm_virt_mux, .name = wname, .reg = wreg, .shift = wshift, \
+	.invert = winvert, .kcontrols = wcontrols, .num_kcontrols = 1}
 #define SND_SOC_DAPM_VALUE_MUX(wname, wreg, wshift, winvert, wcontrols) \
 {	.id = snd_soc_dapm_value_mux, .name = wname, .reg = wreg, \
 	.shift = wshift, .invert = winvert, .kcontrols = wcontrols, \
@@ -148,6 +151,11 @@
 {	.id = snd_soc_dapm_mux, .name = wname, .reg = wreg, .shift = wshift, \
 	.invert = winvert, .kcontrols = wcontrols, .num_kcontrols = 1, \
 	.event = wevent, .event_flags = wflags}
+#define SND_SOC_DAPM_VIRT_MUX_E(wname, wreg, wshift, winvert, wcontrols, \
+	wevent, wflags) \
+{	.id = snd_soc_dapm_virt_mux, .name = wname, .reg = wreg, .shift = wshift, \
+	.invert = winvert, .kcontrols = wcontrols, .num_kcontrols = 1, \
+	.event = wevent, .event_flags = wflags}
 
 /* Simplified versions of above macros, assuming wncontrols = ARRAY_SIZE(wcontrols) */
 #define SOC_PGA_E_ARRAY(wname, wreg, wshift, winvert, wcontrols, \
@@ -373,6 +381,7 @@ enum snd_soc_dapm_type {
 	snd_soc_dapm_input = 0,		/* input pin */
 	snd_soc_dapm_output,		/* output pin */
 	snd_soc_dapm_mux,			/* selects 1 analog signal from many inputs */
+	snd_soc_dapm_virt_mux,			/* virtual version of snd_soc_dapm_mux */
 	snd_soc_dapm_value_mux,			/* selects 1 analog signal from many inputs */
 	snd_soc_dapm_mixer,			/* mixes several analog signals together */
 	snd_soc_dapm_mixer_named_ctl,		/* mixer with named controls */
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 3d310af..035cdf4 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -56,6 +56,7 @@ static int dapm_up_seq[] = {
 	[snd_soc_dapm_aif_out] = 3,
 	[snd_soc_dapm_mic] = 4,
 	[snd_soc_dapm_mux] = 5,
+	[snd_soc_dapm_virt_mux] = 5,
 	[snd_soc_dapm_value_mux] = 5,
 	[snd_soc_dapm_dac] = 6,
 	[snd_soc_dapm_mixer] = 7,
@@ -81,6 +82,7 @@ static int dapm_down_seq[] = {
 	[snd_soc_dapm_mic] = 7,
 	[snd_soc_dapm_micbias] = 8,
 	[snd_soc_dapm_mux] = 9,
+	[snd_soc_dapm_virt_mux] = 9,
 	[snd_soc_dapm_value_mux] = 9,
 	[snd_soc_dapm_aif_in] = 10,
 	[snd_soc_dapm_aif_out] = 10,
@@ -216,6 +218,20 @@ static void dapm_set_path_status(struct snd_soc_dapm_widget *w,
 		}
 	}
 	break;
+	case snd_soc_dapm_virt_mux: {
+		struct soc_enum *e = (struct soc_enum *)w->kcontrols[i].private_value;
+
+		p->connect = 0;
+		/* since a virtual mux has no backing registers to
+		 * decide which path to connect, it will try to match
+		 * with the first enumeration.  This is to ensure
+		 * that the default mux choice (the first) will be
+		 * correctly powered up during initialization.
+		 */
+		if (!strcmp(p->name, e->texts[0]))
+			p->connect = 1;
+	}
+	break;
 	case snd_soc_dapm_value_mux: {
 		struct soc_enum *e = (struct soc_enum *)
 			w->kcontrols[i].private_value;
@@ -1173,6 +1189,7 @@ static int dapm_mux_update_power(struct snd_soc_dapm_widget *widget,
 	int found = 0;
 
 	if (widget->id != snd_soc_dapm_mux &&
+	    widget->id != snd_soc_dapm_virt_mux &&
 	    widget->id != snd_soc_dapm_value_mux)
 		return -ENODEV;
 
@@ -1448,6 +1465,7 @@ static int snd_soc_dapm_add_route(struct snd_soc_dapm_context *dapm,
 		path->connect = 1;
 		return 0;
 	case snd_soc_dapm_mux:
+	case snd_soc_dapm_virt_mux:
 	case snd_soc_dapm_value_mux:
 		ret = dapm_connect_mux(dapm, wsource, wsink, path, control,
 			&wsink->kcontrols[0]);
@@ -1537,6 +1555,7 @@ int snd_soc_dapm_new_widgets(struct snd_soc_dapm_context *dapm)
 			dapm_new_mixer(dapm, w);
 			break;
 		case snd_soc_dapm_mux:
+		case snd_soc_dapm_virt_mux:
 		case snd_soc_dapm_value_mux:
 			w->power_check = dapm_generic_check_power;
 			dapm_new_mux(dapm, w);
-- 
1.7.3.3
