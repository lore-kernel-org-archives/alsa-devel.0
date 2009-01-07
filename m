From: Ian Molton <ian@mnementh.co.uk>
Subject: [PATCH] ASoC: add new DAPM control
Date: Wed, 07 Jan 2009 02:38:00 +0000
Message-ID: <49641588.7050703@mnementh.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_mnementh-26925-1231295887-0001-2"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mnementh.co.uk (mail.mnementh.co.uk [173.45.232.4])
	by alsa0.perex.cz (Postfix) with ESMTP id 104D11037F1
	for <alsa-devel@alsa-project.org>; Wed,  7 Jan 2009 03:38:07 +0100 (CET)
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
List-Id: alsa-devel@alsa-project.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_mnementh-26925-1231295887-0001-2
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi.

The attached patch adds a new mixer control that allows cleaner support
for the wm9705 codec Im working on. I think it probably has wider uses
though.

It saves a few bytes too in shorter names :-)

If you prefer I have it available in:

git://git.mnementh.co.uk/linux-2.6-im.git asoc

and on gitweb at:

http://git.mnementh.co.uk/cgi-bin/gitweb.cgi?p=linux-2.6-im.git;a=shortlog;h=refs/heads/asoc


--=_mnementh-26925-1231295887-0001-2
Content-Type: text/x-patch; name="0001-ASoC-dapm-Allow-explictly-named-mixer-controls.patch"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0001-ASoC-dapm-Allow-explictly-named-mixer-controls.patch"

>From 301ed82738ca0210ec0885554edabe0090ec2f9c Mon Sep 17 00:00:00 2001
From: Ian Molton <ian@mnementh.co.uk>
Date: Tue, 6 Jan 2009 20:11:51 +0000
Subject: [PATCH] ASoC: dapm: Allow explictly named mixer controls

This patch allows you to define the mixer paths as having the same name as the
paths they represent.

This is required to support codecs such as the wm9705 neatly without extra
controls in the alsa mixer.

Signed-off-by: Ian Molton <ian@mnementh.co.uk>
---
 Documentation/sound/alsa/soc/dapm.txt |    3 ++
 include/sound/soc-dapm.h              |   11 ++++++++
 sound/soc/soc-dapm.c                  |   46 +++++++++++++++++++++++++--------
 3 files changed, 49 insertions(+), 11 deletions(-)

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
index ad0d801..38a1fc3 100644
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
@@ -347,15 +349,32 @@ static int dapm_new_mixer(struct snd_soc_codec *codec,
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
+				name_len += 1 + strlen(w->name)
+
 			path->long_name = kmalloc(name_len, GFP_KERNEL);
+
 			if (path->long_name == NULL)
 				return -ENOMEM;
 
-			snprintf(path->long_name, name_len, "%s %s",
-				 w->name, w->kcontrols[i].name);
+			switch (w->id) {
+			case snd_soc_dapm_mixer:
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
@@ -711,6 +730,7 @@ static void dbg_dump_dapm(struct snd_soc_codec* codec, const char *action)
 		case snd_soc_dapm_adc:
 		case snd_soc_dapm_pga:
 		case snd_soc_dapm_mixer:
+		case snd_soc_dapm_mixer_named_ctl:
 			if (w->name) {
 				in = is_connected_input_ep(w);
 				dapm_clear_walk(w->codec);
@@ -822,6 +842,7 @@ static int dapm_mixer_update_power(struct snd_soc_dapm_widget *widget,
 	int found = 0;
 
 	if (widget->id != snd_soc_dapm_mixer &&
+	    widget->id != snd_soc_dapm_mixer_named_ctl &&
 	    widget->id != snd_soc_dapm_switch)
 		return -ENODEV;
 
@@ -875,6 +896,7 @@ static ssize_t dapm_widget_show(struct device *dev,
 		case snd_soc_dapm_adc:
 		case snd_soc_dapm_pga:
 		case snd_soc_dapm_mixer:
+		case snd_soc_dapm_mixer_named_ctl:
 			if (w->name)
 				count += sprintf(buf + count, "%s: %s\n",
 					w->name, w->power ? "On":"Off");
@@ -1058,6 +1080,7 @@ static int snd_soc_dapm_add_route(struct snd_soc_codec *codec,
 		break;
 	case snd_soc_dapm_switch:
 	case snd_soc_dapm_mixer:
+	case snd_soc_dapm_mixer_named_ctl:
 		ret = dapm_connect_mixer(codec, wsource, wsink, path, control);
 		if (ret != 0)
 			goto err;
@@ -1135,6 +1158,7 @@ int snd_soc_dapm_new_widgets(struct snd_soc_codec *codec)
 		switch(w->id) {
 		case snd_soc_dapm_switch:
 		case snd_soc_dapm_mixer:
+		case snd_soc_dapm_mixer_named_ctl:
 			dapm_new_mixer(codec, w);
 			break;
 		case snd_soc_dapm_mux:
-- 
1.5.6.5



--=_mnementh-26925-1231295887-0001-2
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=_mnementh-26925-1231295887-0001-2--
