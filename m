From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/7] ASoC: dapm: Allow explictly named mixer
	controls
Date: Thu,  8 Jan 2009 19:37:55 +0000
Message-ID: <1231443481-29352-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090108193718.GA29183@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 8C7D32438F
	for <alsa-devel@alsa-project.org>; Thu,  8 Jan 2009 20:38:11 +0100 (CET)
In-Reply-To: <20090108193718.GA29183@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Ian Molton <ian@mnementh.co.uk>
List-Id: alsa-devel@alsa-project.org

From: Ian Molton <ian@mnementh.co.uk>

This patch allows you to define the mixer paths as having the same name as the
paths they represent.

This is required to support codecs such as the wm9705 neatly without extra
controls in the alsa mixer.

Signed-off-by: Ian Molton <ian@mnementh.co.uk>
---
 Documentation/sound/alsa/soc/dapm.txt |    3 ++
 include/sound/soc-dapm.h              |   11 +++++++
 sound/soc/soc-dapm.c                  |   47 +++++++++++++++++++++++++-------
 3 files changed, 50 insertions(+), 11 deletions(-)

diff --git a/Documentation/sound/alsa/soc/dapm.txt b/Documentation/sound/alsa/soc/dapm.txt
index 46f9684..9e67632 100644
--- a/Documentation/sound/alsa/soc/dapm.txt
+++ b/Documentation/sound/alsa/soc/dapm.txt
@@ -116,6 +116,9 @@ SOC_DAPM_SINGLE("HiFi Playback Switch", WM8731_APANA, 4, 1, 0),
 SND_SOC_DAPM_MIXER("Output Mixer", WM8731_PWR, 4, 1, wm8731_output_mixer_controls,
 	ARRAY_SIZE(wm8731_output_mixer_controls)),
 
+If you dont want the mixer elements prefixed with the name of the mixer widget,
+you can use SND_SOC_DAPM_MIXER_NAMED_CTL instead. the parameters are the same
+as for SND_SOC_DAPM_MIXER.
 
 2.3 Platform/Machine domain Widgets
 -----------------------------------
diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 4af1083..cc99dd4 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -76,6 +76,11 @@
 	 wcontrols, wncontrols)\
 {	.id = snd_soc_dapm_mixer, .name = wname, .reg = wreg, .shift = wshift, \
 	.invert = winvert, .kcontrols = wcontrols, .num_kcontrols = wncontrols}
+#define SND_SOC_DAPM_MIXER_NAMED_CTL(wname, wreg, wshift, winvert, \
+	 wcontrols, wncontrols)\
+{       .id = snd_soc_dapm_mixer_named_ctl, .name = wname, .reg = wreg, \
+	.shift = wshift, .invert = winvert, .kcontrols = wcontrols, \
+	.num_kcontrols = wncontrols}
 #define SND_SOC_DAPM_MICBIAS(wname, wreg, wshift, winvert) \
 {	.id = snd_soc_dapm_micbias, .name = wname, .reg = wreg, .shift = wshift, \
 	.invert = winvert, .kcontrols = NULL, .num_kcontrols = 0}
@@ -101,6 +106,11 @@
 {	.id = snd_soc_dapm_mixer, .name = wname, .reg = wreg, .shift = wshift, \
 	.invert = winvert, .kcontrols = wcontrols, .num_kcontrols = wncontrols, \
 	.event = wevent, .event_flags = wflags}
+#define SND_SOC_DAPM_MIXER_NAMED_CTL_E(wname, wreg, wshift, winvert, \
+	wcontrols, wncontrols, wevent, wflags) \
+{       .id = snd_soc_dapm_mixer, .name = wname, .reg = wreg, .shift = wshift, \
+	.invert = winvert, .kcontrols = wcontrols, \
+	.num_kcontrols = wncontrols, .event = wevent, .event_flags = wflags}
 #define SND_SOC_DAPM_MICBIAS_E(wname, wreg, wshift, winvert, wevent, wflags) \
 {	.id = snd_soc_dapm_micbias, .name = wname, .reg = wreg, .shift = wshift, \
 	.invert = winvert, .kcontrols = NULL, .num_kcontrols = 0, \
@@ -263,6 +273,7 @@ enum snd_soc_dapm_type {
 	snd_soc_dapm_mux,			/* selects 1 analog signal from many inputs */
 	snd_soc_dapm_value_mux,			/* selects 1 analog signal from many inputs */
 	snd_soc_dapm_mixer,			/* mixes several analog signals together */
+	snd_soc_dapm_mixer_named_ctl,		/* mixer with named controls */
 	snd_soc_dapm_pga,			/* programmable gain/attenuation (volume) */
 	snd_soc_dapm_adc,			/* analog to digital converter */
 	snd_soc_dapm_dac,			/* digital to analog converter */
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index ad0d801..6362c76 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -54,14 +54,15 @@
 static int dapm_up_seq[] = {
 	snd_soc_dapm_pre, snd_soc_dapm_micbias, snd_soc_dapm_mic,
 	snd_soc_dapm_mux, snd_soc_dapm_value_mux, snd_soc_dapm_dac,
-	snd_soc_dapm_mixer, snd_soc_dapm_pga, snd_soc_dapm_adc, snd_soc_dapm_hp,
-	snd_soc_dapm_spk, snd_soc_dapm_post
+	snd_soc_dapm_mixer, snd_soc_dapm_mixer_named_ctl, snd_soc_dapm_pga,
+	snd_soc_dapm_adc, snd_soc_dapm_hp, snd_soc_dapm_spk, snd_soc_dapm_post
 };
+
 static int dapm_down_seq[] = {
 	snd_soc_dapm_pre, snd_soc_dapm_adc, snd_soc_dapm_hp, snd_soc_dapm_spk,
-	snd_soc_dapm_pga, snd_soc_dapm_mixer, snd_soc_dapm_dac, snd_soc_dapm_mic,
-	snd_soc_dapm_micbias, snd_soc_dapm_mux, snd_soc_dapm_value_mux,
-	snd_soc_dapm_post
+	snd_soc_dapm_pga, snd_soc_dapm_mixer_named_ctl, snd_soc_dapm_mixer,
+	snd_soc_dapm_dac, snd_soc_dapm_mic, snd_soc_dapm_micbias,
+	snd_soc_dapm_mux, snd_soc_dapm_value_mux, snd_soc_dapm_post
 };
 
 static int dapm_status = 1;
@@ -101,7 +102,8 @@ static void dapm_set_path_status(struct snd_soc_dapm_widget *w,
 {
 	switch (w->id) {
 	case snd_soc_dapm_switch:
-	case snd_soc_dapm_mixer: {
+	case snd_soc_dapm_mixer:
+	case snd_soc_dapm_mixer_named_ctl: {
 		int val;
 		struct soc_mixer_control *mc = (struct soc_mixer_control *)
 			w->kcontrols[i].private_value;
@@ -347,15 +349,33 @@ static int dapm_new_mixer(struct snd_soc_codec *codec,
 			if (path->name != (char*)w->kcontrols[i].name)
 				continue;
 
-			/* add dapm control with long name */
-			name_len = 2 + strlen(w->name)
-				+ strlen(w->kcontrols[i].name);
+			/* add dapm control with long name.
+			 * for dapm_mixer this is the concatenation of the
+			 * mixer and kcontrol name.
+			 * for dapm_mixer_named_ctl this is simply the
+			 * kcontrol name.
+			 */
+			name_len = strlen(w->kcontrols[i].name) + 1;
+			if (w->id == snd_soc_dapm_mixer)
+				name_len += 1 + strlen(w->name);
+
 			path->long_name = kmalloc(name_len, GFP_KERNEL);
+
 			if (path->long_name == NULL)
 				return -ENOMEM;
 
-			snprintf(path->long_name, name_len, "%s %s",
-				 w->name, w->kcontrols[i].name);
+			switch (w->id) {
+			case snd_soc_dapm_mixer:
+			default:
+				snprintf(path->long_name, name_len, "%s %s",
+					 w->name, w->kcontrols[i].name);
+			break;
+			case snd_soc_dapm_mixer_named_ctl:
+				snprintf(path->long_name, name_len, "%s",
+					 w->kcontrols[i].name);
+			break;
+			}
+
 			path->long_name[name_len - 1] = '\0';
 
 			path->kcontrol = snd_soc_cnew(&w->kcontrols[i], w,
@@ -711,6 +731,7 @@ static void dbg_dump_dapm(struct snd_soc_codec* codec, const char *action)
 		case snd_soc_dapm_adc:
 		case snd_soc_dapm_pga:
 		case snd_soc_dapm_mixer:
+		case snd_soc_dapm_mixer_named_ctl:
 			if (w->name) {
 				in = is_connected_input_ep(w);
 				dapm_clear_walk(w->codec);
@@ -822,6 +843,7 @@ static int dapm_mixer_update_power(struct snd_soc_dapm_widget *widget,
 	int found = 0;
 
 	if (widget->id != snd_soc_dapm_mixer &&
+	    widget->id != snd_soc_dapm_mixer_named_ctl &&
 	    widget->id != snd_soc_dapm_switch)
 		return -ENODEV;
 
@@ -875,6 +897,7 @@ static ssize_t dapm_widget_show(struct device *dev,
 		case snd_soc_dapm_adc:
 		case snd_soc_dapm_pga:
 		case snd_soc_dapm_mixer:
+		case snd_soc_dapm_mixer_named_ctl:
 			if (w->name)
 				count += sprintf(buf + count, "%s: %s\n",
 					w->name, w->power ? "On":"Off");
@@ -1058,6 +1081,7 @@ static int snd_soc_dapm_add_route(struct snd_soc_codec *codec,
 		break;
 	case snd_soc_dapm_switch:
 	case snd_soc_dapm_mixer:
+	case snd_soc_dapm_mixer_named_ctl:
 		ret = dapm_connect_mixer(codec, wsource, wsink, path, control);
 		if (ret != 0)
 			goto err;
@@ -1135,6 +1159,7 @@ int snd_soc_dapm_new_widgets(struct snd_soc_codec *codec)
 		switch(w->id) {
 		case snd_soc_dapm_switch:
 		case snd_soc_dapm_mixer:
+		case snd_soc_dapm_mixer_named_ctl:
 			dapm_new_mixer(codec, w);
 			break;
 		case snd_soc_dapm_mux:
-- 
1.5.6.5
