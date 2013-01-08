From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 023/112] ALSA: hda/realtek - Add missing
	initialization of multi-io routes
Date: Tue,  8 Jan 2013 12:38:16 +0100
Message-ID: <1357645185-7645-24-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id D464F2651AA
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:24 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 6033AA520D
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:22 +0100 (CET)
In-Reply-To: <1357645185-7645-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The paths used for multi-io haven't been initialized properly, so
far.  It's usually no big matter because the pins are set to input as
default, but it's still cleaner to initialize the paths properly.

Now with the path active/inactive check, we can do it easily.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 3f39ba5..398b25b 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3952,9 +3952,6 @@ static void activate_path(struct hda_codec *codec, struct nid_path *path,
 {
 	int i;
 
-	if (path->active == enable)
-		return;
-
 	if (!enable)
 		path->active = false;
 
@@ -3984,6 +3981,8 @@ static void alc_auto_set_output_and_unmute(struct hda_codec *codec,
 	path = get_nid_path(codec, dac, pin);
 	if (!path)
 		return;
+	if (path->active)
+		return;
 	activate_path(codec, path, true);
 }
 
@@ -4193,10 +4192,8 @@ static int alc_set_multi_io(struct hda_codec *codec, int idx, bool output)
 	if (!path)
 		return -EINVAL;
 
-	if (!spec->multi_io[idx].ctl_in)
-		spec->multi_io[idx].ctl_in =
-			snd_hda_codec_update_cache(codec, nid, 0,
-					   AC_VERB_GET_PIN_WIDGET_CONTROL, 0);
+	if (path->active == output)
+		return 0;
 
 	if (output) {
 		snd_hda_set_pin_ctl_cache(codec, nid, PIN_OUT);
@@ -4251,6 +4248,25 @@ static int alc_auto_add_multi_channel_mode(struct hda_codec *codec)
 	return 0;
 }
 
+static void alc_auto_init_multi_io(struct hda_codec *codec)
+{
+	struct alc_spec *spec = codec->spec;
+	int i;
+
+	for (i = 0; i < spec->multi_ios; i++) {
+		hda_nid_t pin = spec->multi_io[i].pin;
+		struct nid_path *path;
+		path = get_nid_path(codec, spec->multi_io[i].dac, pin);
+		if (!path)
+			continue;
+		if (!spec->multi_io[i].ctl_in)
+			spec->multi_io[i].ctl_in =
+				snd_hda_codec_update_cache(codec, pin, 0,
+					   AC_VERB_GET_PIN_WIDGET_CONTROL, 0);
+		activate_path(codec, path, path->active);
+	}
+}
+
 /* filter out invalid adc_nids (and capsrc_nids) that don't give all
  * active input pins
  */
@@ -4489,6 +4505,7 @@ static void alc_auto_init_std(struct hda_codec *codec)
 {
 	alc_auto_init_multi_out(codec);
 	alc_auto_init_extra_out(codec);
+	alc_auto_init_multi_io(codec);
 	alc_auto_init_analog_input(codec);
 	alc_auto_init_input_src(codec);
 	alc_auto_init_digital(codec);
-- 
1.8.0.1
