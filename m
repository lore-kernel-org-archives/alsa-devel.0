From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 071/112] ALSA: hda - Dynamically turn on/off
	EAPD in generic codec driver
Date: Tue,  8 Jan 2013 12:39:04 +0100
Message-ID: <1357645185-7645-72-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 5B190265206
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:26 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 7306CA51B8
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:23 +0100 (CET)
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

When spec->own_eapd_ctl isn't set, try to turn on/off EAPD on demand
for each pin.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index a133fcf..46b00e0 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -523,6 +523,18 @@ void snd_hda_activate_path(struct hda_codec *codec, struct nid_path *path,
 }
 EXPORT_SYMBOL_HDA(snd_hda_activate_path);
 
+/* turn on/off EAPD on the given pin */
+static void set_pin_eapd(struct hda_codec *codec, hda_nid_t pin, bool enable)
+{
+	struct hda_gen_spec *spec = codec->spec;
+	if (spec->own_eapd_ctl ||
+	    !(snd_hda_query_pin_caps(codec, pin) & AC_PINCAP_EAPD))
+		return;
+	snd_hda_codec_update_cache(codec, pin, 0,
+				   AC_VERB_SET_EAPD_BTLENABLE,
+				   enable ? 0x02 : 0x00);
+}
+
 
 /*
  * Helper functions for creating mixer ctl elements
@@ -1485,7 +1497,9 @@ static int set_multi_io(struct hda_codec *codec, int idx, bool output)
 	if (output) {
 		snd_hda_set_pin_ctl_cache(codec, nid, PIN_OUT);
 		snd_hda_activate_path(codec, path, true, true);
+		set_pin_eapd(codec, nid, true);
 	} else {
+		set_pin_eapd(codec, nid, false);
 		snd_hda_activate_path(codec, path, false, true);
 		snd_hda_set_pin_ctl_cache(codec, nid,
 					  spec->multi_io[idx].ctl_in);
@@ -2418,6 +2432,7 @@ static void do_automute(struct hda_codec *codec, int num_pins, hda_nid_t *pins,
 			val = 0;
 		val |= pin_bits;
 		snd_hda_set_pin_ctl(codec, nid, val);
+		set_pin_eapd(codec, nid, !mute);
 	}
 }
 
@@ -3351,7 +3366,6 @@ EXPORT_SYMBOL_HDA(snd_hda_gen_build_pcms);
 static void set_output_and_unmute(struct hda_codec *codec, hda_nid_t pin,
 				  int pin_type, hda_nid_t dac)
 {
-	struct hda_gen_spec *spec = codec->spec;
 	struct nid_path *path;
 
 	snd_hda_set_pin_ctl_cache(codec, pin, pin_type);
@@ -3361,11 +3375,7 @@ static void set_output_and_unmute(struct hda_codec *codec, hda_nid_t pin,
 	if (path->active)
 		return;
 	snd_hda_activate_path(codec, path, true, true);
-
-	if (!spec->own_eapd_ctl &&
-	    (snd_hda_query_pin_caps(codec, pin) & AC_PINCAP_EAPD))
-		snd_hda_codec_update_cache(codec, pin, 0,
-					   AC_VERB_SET_EAPD_BTLENABLE, 0x02);
+	set_pin_eapd(codec, pin, true);
 }
 
 /* initialize primary output paths */
-- 
1.8.0.1
