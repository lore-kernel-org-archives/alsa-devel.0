From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 032/112] ALSA: hda/realtek - Allow different
	pins for shared hp/mic vref check
Date: Tue,  8 Jan 2013 12:38:25 +0100
Message-ID: <1357645185-7645-33-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 1C6882651B2
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:25 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id A393DA522C
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

Add a new field to indicate the possible pin NID for alternative vref
setup for the shared hp/mic.  Although 0x18 is valid for all Realtek
codecs, it'll be different on other vendor's codecs.

Also, drop the sanity check in update_shared_mic_hp() since the
reference pin is set explicitly in the caller side.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 60cc1b5..5c5197b 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -187,6 +187,7 @@ struct alc_spec {
 	unsigned int dyn_adc_idx[HDA_MAX_NUM_INPUTS];
 	int int_mic_idx, ext_mic_idx, dock_mic_idx; /* for auto-mic */
 	hda_nid_t inv_dmic_pin;
+	hda_nid_t shared_mic_vref_pin;
 
 	/* DAC list */
 	int num_all_dacs;
@@ -343,15 +344,11 @@ static void update_shared_mic_hp(struct hda_codec *codec, bool set_as_mic)
 
 	/* This pin does not have vref caps - let's enable vref on pin 0x18
 	   instead, as suggested by Realtek */
-	if (val == AC_PINCTL_VREF_HIZ) {
-		const hda_nid_t vref_pin = 0x18;
-		/* Sanity check pin 0x18 */
-		if (get_wcaps_type(get_wcaps(codec, vref_pin)) == AC_WID_PIN &&
-		    get_defcfg_connect(snd_hda_codec_get_pincfg(codec, vref_pin)) == AC_JACK_PORT_NONE) {
-			unsigned int vref_val = snd_hda_get_default_vref(codec, vref_pin);
-			if (vref_val != AC_PINCTL_VREF_HIZ)
-				snd_hda_set_pin_ctl(codec, vref_pin, PIN_IN | (set_as_mic ? vref_val : 0));
-		}
+	if (val == AC_PINCTL_VREF_HIZ && spec->shared_mic_vref_pin) {
+		const hda_nid_t vref_pin = spec->shared_mic_vref_pin;
+		unsigned int vref_val = snd_hda_get_default_vref(codec, vref_pin);
+		if (vref_val != AC_PINCTL_VREF_HIZ)
+			snd_hda_set_pin_ctl(codec, vref_pin, PIN_IN | (set_as_mic ? vref_val : 0));
 	}
 
 	val = set_as_mic ? val | PIN_IN : PIN_HP;
@@ -5642,6 +5639,7 @@ static int patch_alc262(struct hda_codec *codec)
 		return err;
 
 	spec = codec->spec;
+	spec->shared_mic_vref_pin = 0x18;
 
 #if 0
 	/* pshou 07/11/05  set a zero PCM sample to DAC when FIFO is
@@ -6425,6 +6423,7 @@ static int patch_alc269(struct hda_codec *codec)
 		return err;
 
 	spec = codec->spec;
+	spec->shared_mic_vref_pin = 0x18;
 
 	alc_pick_fixup(codec, alc269_fixup_models,
 		       alc269_fixup_tbl, alc269_fixups);
-- 
1.8.0.1
