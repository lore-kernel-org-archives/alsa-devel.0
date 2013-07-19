From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Add snd_hda_jack_detect_state()
	helper function
Date: Fri, 19 Jul 2013 17:06:37 +0200
Message-ID: <1374246397-14167-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 1A7BB2652E4
 for <alsa-devel@alsa-project.org>; Fri, 19 Jul 2013 17:05:24 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id D6655A52D9
 for <alsa-devel@alsa-project.org>; Fri, 19 Jul 2013 17:05:23 +0200 (CEST)
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

snd_hda_jack_detect() function returns a boolean value for a jack
plugged in or not, but it also returns always true when the
corresponding pin is phantom (i.e. fixed).  This is OK in most cases,
but it makes the generic parser misbehaving about the auto-mute or
auto-mic switching, e.g. when one of headphone pins is a fixed.
Namely, the driver decides whether to mute the speaker or not, just
depending on the headphone plug state: if one of the headphone jacks
is seen as active, then the speaker is muted.  Thus this will result
always in the muted speaker output.

So, the problem is the function returns a boolean, after all, although
we need to think of "phantom" jack.  Now a new function,
snd_hda_jack_detect_state() is introduced to return these tristates.
The generic parser uses this function for checking the headphone or
mic jack states.

Meanwhile, the behavior of snd_hda_jack_detect() is kept as is, for
keeping compatibility in other driver codes.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c |  8 +++++---
 sound/pci/hda/hda_jack.c    | 18 ++++++++++++------
 sound/pci/hda/hda_jack.h    | 13 ++++++++++++-
 3 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 8e77cbb..f5c2d1f 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -3724,7 +3724,8 @@ static int mux_select(struct hda_codec *codec, unsigned int adc_idx,
 /* check each pin in the given array; returns true if any of them is plugged */
 static bool detect_jacks(struct hda_codec *codec, int num_pins, hda_nid_t *pins)
 {
-	int i, present = 0;
+	int i;
+	bool present = false;
 
 	for (i = 0; i < num_pins; i++) {
 		hda_nid_t nid = pins[i];
@@ -3733,7 +3734,8 @@ static bool detect_jacks(struct hda_codec *codec, int num_pins, hda_nid_t *pins)
 		/* don't detect pins retasked as inputs */
 		if (snd_hda_codec_get_pin_target(codec, nid) & AC_PINCTL_IN_EN)
 			continue;
-		present |= snd_hda_jack_detect(codec, nid);
+		if (snd_hda_jack_detect_state(codec, nid) == HDA_JACK_PRESENT)
+			present = true;
 	}
 	return present;
 }
@@ -3887,7 +3889,7 @@ void snd_hda_gen_mic_autoswitch(struct hda_codec *codec, struct hda_jack_tbl *ja
 		/* don't detect pins retasked as outputs */
 		if (snd_hda_codec_get_pin_target(codec, pin) & AC_PINCTL_OUT_EN)
 			continue;
-		if (snd_hda_jack_detect(codec, pin)) {
+		if (snd_hda_jack_detect_state(codec, pin) == HDA_JACK_PRESENT) {
 			mux_select(codec, 0, spec->am_entry[i].idx);
 			return;
 		}
diff --git a/sound/pci/hda/hda_jack.c b/sound/pci/hda/hda_jack.c
index 3fd2973..dc93761 100644
--- a/sound/pci/hda/hda_jack.c
+++ b/sound/pci/hda/hda_jack.c
@@ -194,18 +194,24 @@ u32 snd_hda_pin_sense(struct hda_codec *codec, hda_nid_t nid)
 EXPORT_SYMBOL_HDA(snd_hda_pin_sense);
 
 /**
- * snd_hda_jack_detect - query pin Presence Detect status
+ * snd_hda_jack_detect_state - query pin Presence Detect status
  * @codec: the CODEC to sense
  * @nid: the pin NID to sense
  *
- * Query and return the pin's Presence Detect status.
+ * Query and return the pin's Presence Detect status, as either
+ * HDA_JACK_NOT_PRESENT, HDA_JACK_PRESENT or HDA_JACK_PHANTOM.
  */
-int snd_hda_jack_detect(struct hda_codec *codec, hda_nid_t nid)
+int snd_hda_jack_detect_state(struct hda_codec *codec, hda_nid_t nid)
 {
-	u32 sense = snd_hda_pin_sense(codec, nid);
-	return get_jack_plug_state(sense);
+	struct hda_jack_tbl *jack = snd_hda_jack_tbl_get(codec, nid);
+	if (jack && jack->phantom_jack)
+		return HDA_JACK_PHANTOM;
+	else if (snd_hda_pin_sense(codec, nid) & AC_PINSENSE_PRESENCE)
+		return HDA_JACK_PRESENT;
+	else
+		return HDA_JACK_NOT_PRESENT;
 }
-EXPORT_SYMBOL_HDA(snd_hda_jack_detect);
+EXPORT_SYMBOL_HDA(snd_hda_jack_detect_state);
 
 /**
  * snd_hda_jack_detect_enable - enable the jack-detection
diff --git a/sound/pci/hda/hda_jack.h b/sound/pci/hda/hda_jack.h
index ec12abd..379420c 100644
--- a/sound/pci/hda/hda_jack.h
+++ b/sound/pci/hda/hda_jack.h
@@ -75,7 +75,18 @@ int snd_hda_jack_set_gating_jack(struct hda_codec *codec, hda_nid_t gated_nid,
 				 hda_nid_t gating_nid);
 
 u32 snd_hda_pin_sense(struct hda_codec *codec, hda_nid_t nid);
-int snd_hda_jack_detect(struct hda_codec *codec, hda_nid_t nid);
+
+/* the jack state returned from snd_hda_jack_detect_state() */
+enum {
+	HDA_JACK_NOT_PRESENT, HDA_JACK_PRESENT, HDA_JACK_PHANTOM,
+};
+
+int snd_hda_jack_detect_state(struct hda_codec *codec, hda_nid_t nid);
+
+static inline bool snd_hda_jack_detect(struct hda_codec *codec, hda_nid_t nid)
+{
+	return snd_hda_jack_detect_state(codec, nid) != HDA_JACK_NOT_PRESENT;
+}
 
 bool is_jack_detectable(struct hda_codec *codec, hda_nid_t nid);
 
-- 
1.8.3.1
