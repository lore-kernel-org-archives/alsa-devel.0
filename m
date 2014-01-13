From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Apply codec power_filter to FG
	nodes
Date: Mon, 13 Jan 2014 16:29:46 +0100
Message-ID: <1389626986-16207-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id AC5E4264FDF
 for <alsa-devel@alsa-project.org>; Mon, 13 Jan 2014 16:29:46 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 9A1DCAC44
 for <alsa-devel@alsa-project.org>; Mon, 13 Jan 2014 15:29:46 +0000 (UTC)
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

Apply the codec->power_filter to the FG nodes in general for reducing
hackish set_power_state ops override in patch_sigmatel.c.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.c      | 12 +++++++++---
 sound/pci/hda/hda_generic.c    |  5 +++--
 sound/pci/hda/hda_generic.h    |  3 +++
 sound/pci/hda/patch_sigmatel.c | 36 ++++++++++++------------------------
 4 files changed, 27 insertions(+), 29 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index ab2a991d916f..ec4536c8d8d4 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -3927,6 +3927,8 @@ unsigned int snd_hda_codec_eapd_power_filter(struct hda_codec *codec,
 					     hda_nid_t nid,
 					     unsigned int power_state)
 {
+	if (nid == codec->afg || nid == codec->mfg)
+		return power_state;
 	if (power_state == AC_PWRST_D3 &&
 	    get_wcaps_type(get_wcaps(codec, nid)) == AC_WID_PIN &&
 	    (snd_hda_query_pin_caps(codec, nid) & AC_PINCAP_EAPD)) {
@@ -3965,9 +3967,13 @@ static unsigned int hda_set_power_state(struct hda_codec *codec,
 			codec->patch_ops.set_power_state(codec, fg,
 							 power_state);
 		else {
-			snd_hda_codec_read(codec, fg, flags,
-					   AC_VERB_SET_POWER_STATE,
-					   power_state);
+			state = power_state;
+			if (codec->power_filter)
+				state = codec->power_filter(codec, fg, state);
+			if (state == power_state || power_state != AC_PWRST_D3)
+				snd_hda_codec_read(codec, fg, flags,
+						   AC_VERB_SET_POWER_STATE,
+						   state);
 			snd_hda_codec_set_power_to_all(codec, fg, power_state);
 		}
 		state = hda_sync_power_state(codec, fg, power_state);
diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 7513089c8985..8321a97d5c05 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -4312,11 +4312,11 @@ static int check_auto_mic_availability(struct hda_codec *codec)
 }
 
 /* power_filter hook; make inactive widgets into power down */
-static unsigned int snd_hda_gen_path_power_filter(struct hda_codec *codec,
+unsigned int snd_hda_gen_path_power_filter(struct hda_codec *codec,
 						  hda_nid_t nid,
 						  unsigned int power_state)
 {
-	if (power_state != AC_PWRST_D0)
+	if (power_state != AC_PWRST_D0 || nid == codec->afg)
 		return power_state;
 	if (get_wcaps_type(get_wcaps(codec, nid)) >= AC_WID_POWER)
 		return power_state;
@@ -4324,6 +4324,7 @@ static unsigned int snd_hda_gen_path_power_filter(struct hda_codec *codec,
 		return power_state;
 	return AC_PWRST_D3;
 }
+EXPORT_SYMBOL_GPL(snd_hda_gen_path_power_filter);
 
 /* mute all aamix inputs initially; parse up to the first leaves */
 static void mute_all_mixer_nid(struct hda_codec *codec, hda_nid_t mix)
diff --git a/sound/pci/hda/hda_generic.h b/sound/pci/hda/hda_generic.h
index 0929a06df812..07f767231c9f 100644
--- a/sound/pci/hda/hda_generic.h
+++ b/sound/pci/hda/hda_generic.h
@@ -335,5 +335,8 @@ void snd_hda_gen_update_outputs(struct hda_codec *codec);
 #ifdef CONFIG_PM
 int snd_hda_gen_check_power_status(struct hda_codec *codec, hda_nid_t nid);
 #endif
+unsigned int snd_hda_gen_path_power_filter(struct hda_codec *codec,
+					   hda_nid_t nid,
+					   unsigned int power_state);
 
 #endif /* __SOUND_HDA_GENERIC_H */
diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index 088a5afbd1b9..6998cf29b9bc 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -368,6 +368,17 @@ static int stac_vrefout_set(struct hda_codec *codec,
 	return 1;
 }
 
+/* prevent codec AFG to D3 state when vref-out pin is used for mute LED */
+/* this hook is set in stac_setup_gpio() */
+static unsigned int stac_vref_led_power_filter(struct hda_codec *codec,
+					       hda_nid_t nid,
+					       unsigned int power_state)
+{
+	if (nid == codec->afg && power_state == AC_PWRST_D3)
+		return AC_PWRST_D1;
+	return snd_hda_gen_path_power_filter(codec, nid, power_state);
+}
+
 /* update mute-LED accoring to the master switch */
 static void stac_update_led_status(struct hda_codec *codec, int enabled)
 {
@@ -4260,30 +4271,8 @@ static int stac_suspend(struct hda_codec *codec)
 	stac_shutup(codec);
 	return 0;
 }
-
-static void stac_set_power_state(struct hda_codec *codec, hda_nid_t fg,
-				 unsigned int power_state)
-{
-	unsigned int afg_power_state = power_state;
-	struct sigmatel_spec *spec = codec->spec;
-
-	if (power_state == AC_PWRST_D3) {
-		if (spec->vref_mute_led_nid) {
-			/* with vref-out pin used for mute led control
-			 * codec AFG is prevented from D3 state
-			 */
-			afg_power_state = AC_PWRST_D1;
-		}
-		/* this delay seems necessary to avoid click noise at power-down */
-		msleep(100);
-	}
-	snd_hda_codec_read(codec, fg, 0, AC_VERB_SET_POWER_STATE,
-			afg_power_state);
-	snd_hda_codec_set_power_to_all(codec, fg, power_state);
-}
 #else
 #define stac_suspend		NULL
-#define stac_set_power_state	NULL
 #endif /* CONFIG_PM */
 
 static const struct hda_codec_ops stac_patch_ops = {
@@ -4466,8 +4455,7 @@ static void stac_setup_gpio(struct hda_codec *codec)
 			spec->gpio_dir |= spec->gpio_led;
 			spec->gpio_data |= spec->gpio_led;
 		} else {
-			codec->patch_ops.set_power_state =
-					stac_set_power_state;
+			codec->power_filter = stac_vref_led_power_filter;
 		}
 	}
 
-- 
1.8.5.2
