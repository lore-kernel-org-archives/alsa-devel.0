From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 020/112] ALSA: hda/realtek - Use path-based
	parser for digital outputs
Date: Tue,  8 Jan 2013 12:38:13 +0100
Message-ID: <1357645185-7645-21-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id C54512651A1
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:24 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 5E663A5208
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

Similar like analog output paths, use the path list for parsing and
initializing digital outputs as well.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 42 ++++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 20 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 47f5c4f..206b983 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -1424,6 +1424,14 @@ static unsigned int alc_get_coef0(struct hda_codec *codec)
 	return spec->coef0;
 }
 
+static void alc_auto_set_output_and_unmute(struct hda_codec *codec,
+					   hda_nid_t pin, int pin_type,
+					   hda_nid_t dac);
+static hda_nid_t alc_auto_look_for_dac(struct hda_codec *codec, hda_nid_t pin,
+				       bool is_digital);
+static bool add_new_out_path(struct hda_codec *codec, hda_nid_t pin,
+			     hda_nid_t dac);
+
 /*
  * Digital I/O handling
  */
@@ -1433,22 +1441,13 @@ static void alc_auto_init_digital(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
 	int i;
-	hda_nid_t pin, dac;
+	hda_nid_t pin;
 
 	for (i = 0; i < spec->autocfg.dig_outs; i++) {
 		pin = spec->autocfg.dig_out_pins[i];
 		if (!pin)
 			continue;
-		snd_hda_set_pin_ctl(codec, pin, PIN_OUT);
-		if (!i)
-			dac = spec->multiout.dig_out_nid;
-		else
-			dac = spec->slave_dig_outs[i - 1];
-		if (!dac || !(get_wcaps(codec, dac) & AC_WCAP_OUT_AMP))
-			continue;
-		snd_hda_codec_write(codec, dac, 0,
-				    AC_VERB_SET_AMP_GAIN_MUTE,
-				    AMP_OUT_UNMUTE);
+		alc_auto_set_output_and_unmute(codec, pin, PIN_OUT, 0);
 	}
 	pin = spec->autocfg.dig_in_pin;
 	if (pin)
@@ -1465,13 +1464,10 @@ static void alc_auto_parse_digital(struct hda_codec *codec)
 	/* support multiple SPDIFs; the secondary is set up as a slave */
 	nums = 0;
 	for (i = 0; i < spec->autocfg.dig_outs; i++) {
-		hda_nid_t conn[4];
-		err = snd_hda_get_connections(codec,
-					      spec->autocfg.dig_out_pins[i],
-					      conn, ARRAY_SIZE(conn));
-		if (err <= 0)
+		hda_nid_t pin = spec->autocfg.dig_out_pins[i];
+		dig_nid = alc_auto_look_for_dac(codec, pin, true);
+		if (!dig_nid)
 			continue;
-		dig_nid = conn[0]; /* assume the first element is audio-out */
 		if (!nums) {
 			spec->multiout.dig_out_nid = dig_nid;
 			spec->dig_out_type = spec->autocfg.dig_out_type[0];
@@ -1481,6 +1477,7 @@ static void alc_auto_parse_digital(struct hda_codec *codec)
 				break;
 			spec->slave_dig_outs[nums - 1] = dig_nid;
 		}
+		add_new_out_path(codec, pin, dig_nid);
 		nums++;
 	}
 
@@ -2895,15 +2892,20 @@ static bool alc_is_dac_already_used(struct hda_codec *codec, hda_nid_t nid)
 }
 
 /* look for an empty DAC slot */
-static hda_nid_t alc_auto_look_for_dac(struct hda_codec *codec, hda_nid_t pin)
+static hda_nid_t alc_auto_look_for_dac(struct hda_codec *codec, hda_nid_t pin,
+				       bool is_digital)
 {
 	struct alc_spec *spec = codec->spec;
+	bool cap_digital;
 	int i;
 
 	for (i = 0; i < spec->num_all_dacs; i++) {
 		hda_nid_t nid = spec->all_dacs[i];
 		if (!nid || alc_is_dac_already_used(codec, nid))
 			continue;
+		cap_digital = !!(get_wcaps(codec, nid) & AC_WCAP_DIGITAL);
+		if (is_digital != cap_digital)
+			continue;
 		if (is_reachable_path(codec, nid, pin))
 			return nid;
 	}
@@ -3169,7 +3171,7 @@ static int alc_auto_fill_dacs(struct hda_codec *codec, int num_outs,
 	for (i = 0; i < num_outs; i++) {
 		hda_nid_t pin = pins[i];
 		if (!dacs[i])
-			dacs[i] = alc_auto_look_for_dac(codec, pin);
+			dacs[i] = alc_auto_look_for_dac(codec, pin, false);
 		if (!dacs[i] && !i) {
 			for (j = 1; j < num_outs; j++) {
 				if (is_reachable_path(codec, dacs[j], pin)) {
@@ -4110,7 +4112,7 @@ static int alc_auto_fill_multi_ios(struct hda_codec *codec,
 			if (hardwired)
 				dac = get_dac_if_single(codec, nid);
 			else if (!dac)
-				dac = alc_auto_look_for_dac(codec, nid);
+				dac = alc_auto_look_for_dac(codec, nid, false);
 			if (!dac) {
 				badness++;
 				continue;
-- 
1.8.0.1
