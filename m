From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Fix bad dereference of jack object
Date: Tue,  9 Feb 2016 10:23:52 +0100
Message-ID: <1455009832-19607-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 3848A261687
 for <alsa-devel@alsa-project.org>; Tue,  9 Feb 2016 10:23:54 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id CE6D8AC07
 for <alsa-devel@alsa-project.org>; Tue,  9 Feb 2016 09:23:53 +0000 (UTC)
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

The hda_jack_tbl entries are managed by snd_array for allowing
multiple jacks.  It's good per se, but the problem is that struct
hda_jack_callback keeps the hda_jack_tbl pointer.  Since snd_array
doesn't preserve each pointer at resizing the array, we can't keep the
original pointer but have to deduce the pointer at each time via
snd_array_entry() instead.  Actually, this resulted in the deference
to the wrong pointer on codecs that have many pins such as CS4208.

This patch replaces the pointer to the NID value as the search key.
As an unexpected good side effect, this even simplifies the code, as
only NID is needed in most cases.

Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c    | 4 ++--
 sound/pci/hda/hda_jack.c       | 2 +-
 sound/pci/hda/hda_jack.h       | 2 +-
 sound/pci/hda/patch_ca0132.c   | 5 ++++-
 sound/pci/hda/patch_hdmi.c     | 2 +-
 sound/pci/hda/patch_realtek.c  | 2 +-
 sound/pci/hda/patch_sigmatel.c | 6 +++---
 7 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 30c8efe0f80a..7ca5b89f088a 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -4028,9 +4028,9 @@ static void pin_power_callback(struct hda_codec *codec,
 			       struct hda_jack_callback *jack,
 			       bool on)
 {
-	if (jack && jack->tbl->nid)
+	if (jack && jack->nid)
 		sync_power_state_change(codec,
-					set_pin_power_jack(codec, jack->tbl->nid, on));
+					set_pin_power_jack(codec, jack->nid, on));
 }
 
 /* callback only doing power up -- called at first */
diff --git a/sound/pci/hda/hda_jack.c b/sound/pci/hda/hda_jack.c
index c945e257d368..a33234e04d4f 100644
--- a/sound/pci/hda/hda_jack.c
+++ b/sound/pci/hda/hda_jack.c
@@ -259,7 +259,7 @@ snd_hda_jack_detect_enable_callback(struct hda_codec *codec, hda_nid_t nid,
 		if (!callback)
 			return ERR_PTR(-ENOMEM);
 		callback->func = func;
-		callback->tbl = jack;
+		callback->nid = jack->nid;
 		callback->next = jack->callback;
 		jack->callback = callback;
 	}
diff --git a/sound/pci/hda/hda_jack.h b/sound/pci/hda/hda_jack.h
index 858708a044f5..e9814c0168ea 100644
--- a/sound/pci/hda/hda_jack.h
+++ b/sound/pci/hda/hda_jack.h
@@ -21,7 +21,7 @@ struct hda_jack_callback;
 typedef void (*hda_jack_callback_fn) (struct hda_codec *, struct hda_jack_callback *);
 
 struct hda_jack_callback {
-	struct hda_jack_tbl *tbl;
+	hda_nid_t nid;
 	hda_jack_callback_fn func;
 	unsigned int private_data;	/* arbitrary data */
 	struct hda_jack_callback *next;
diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 4ef2259f88ca..9ceb2bc36e68 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -4427,13 +4427,16 @@ static void ca0132_process_dsp_response(struct hda_codec *codec,
 static void hp_callback(struct hda_codec *codec, struct hda_jack_callback *cb)
 {
 	struct ca0132_spec *spec = codec->spec;
+	struct hda_jack_tbl *tbl;
 
 	/* Delay enabling the HP amp, to let the mic-detection
 	 * state machine run.
 	 */
 	cancel_delayed_work_sync(&spec->unsol_hp_work);
 	schedule_delayed_work(&spec->unsol_hp_work, msecs_to_jiffies(500));
-	cb->tbl->block_report = 1;
+	tbl = snd_hda_jack_tbl_get(codec, cb->nid);
+	if (tbl)
+		tbl->block_report = 1;
 }
 
 static void amic_callback(struct hda_codec *codec, struct hda_jack_callback *cb)
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 2191e2359315..8ee78dbd4c60 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1194,7 +1194,7 @@ static void check_presence_and_report(struct hda_codec *codec, hda_nid_t nid)
 static void jack_callback(struct hda_codec *codec,
 			  struct hda_jack_callback *jack)
 {
-	check_presence_and_report(codec, jack->tbl->nid);
+	check_presence_and_report(codec, jack->nid);
 }
 
 static void hdmi_intrinsic_event(struct hda_codec *codec, unsigned int res)
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index b43c0f7994eb..efd4980cffb8 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -282,7 +282,7 @@ static void alc_update_knob_master(struct hda_codec *codec,
 	uctl = kzalloc(sizeof(*uctl), GFP_KERNEL);
 	if (!uctl)
 		return;
-	val = snd_hda_codec_read(codec, jack->tbl->nid, 0,
+	val = snd_hda_codec_read(codec, jack->nid, 0,
 				 AC_VERB_GET_VOLUME_KNOB_CONTROL, 0);
 	val &= HDA_AMP_VOLMASK;
 	uctl->value.integer.value[0] = val;
diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index 2c7c5eb8b1e9..37b70f8e878f 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -493,9 +493,9 @@ static void jack_update_power(struct hda_codec *codec,
 	if (!spec->num_pwrs)
 		return;
 
-	if (jack && jack->tbl->nid) {
-		stac_toggle_power_map(codec, jack->tbl->nid,
-				      snd_hda_jack_detect(codec, jack->tbl->nid),
+	if (jack && jack->nid) {
+		stac_toggle_power_map(codec, jack->nid,
+				      snd_hda_jack_detect(codec, jack->nid),
 				      true);
 		return;
 	}
-- 
2.7.1
