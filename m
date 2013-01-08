From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 016/112] ALSA: hda/realtek - Remove
	non-standard automute mode
Date: Tue,  8 Jan 2013 12:38:09 +0100
Message-ID: <1357645185-7645-17-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id B9C20265191
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:24 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 35DBFA5203
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

We are using only AUTOMUTE_MODE_PIN in patch_realtek.c and all others
have been already dropped.  Let's remove the old superfluous codes.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 46 ++++++++++---------------------------------
 1 file changed, 10 insertions(+), 36 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 981d505..d964c88 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -73,12 +73,6 @@ struct alc_multi_io {
 	unsigned int ctl_in;	/* cached input-pin control value */
 };
 
-enum {
-	ALC_AUTOMUTE_PIN,	/* change the pin control */
-	ALC_AUTOMUTE_AMP,	/* mute/unmute the pin AMP */
-	ALC_AUTOMUTE_MIXER,	/* mute/unmute mixer widget AMP */
-};
-
 #define MAX_VOL_NIDS	0x40
 
 /* make compatible with old code */
@@ -542,7 +536,6 @@ static void do_automute(struct hda_codec *codec, int num_pins, hda_nid_t *pins,
 			bool mute, bool hp_out)
 {
 	struct alc_spec *spec = codec->spec;
-	unsigned int mute_bits = mute ? HDA_AMP_MUTE : 0;
 	unsigned int pin_bits = mute ? 0 : (hp_out ? PIN_HP : PIN_OUT);
 	int i;
 
@@ -551,34 +544,17 @@ static void do_automute(struct hda_codec *codec, int num_pins, hda_nid_t *pins,
 		unsigned int val;
 		if (!nid)
 			break;
-		switch (spec->automute_mode) {
-		case ALC_AUTOMUTE_PIN:
-			/* don't reset VREF value in case it's controlling
-			 * the amp (see alc861_fixup_asus_amp_vref_0f())
-			 */
-			if (spec->keep_vref_in_automute) {
-				val = snd_hda_codec_read(codec, nid, 0,
+		/* don't reset VREF value in case it's controlling
+		 * the amp (see alc861_fixup_asus_amp_vref_0f())
+		 */
+		if (spec->keep_vref_in_automute) {
+			val = snd_hda_codec_read(codec, nid, 0,
 					AC_VERB_GET_PIN_WIDGET_CONTROL, 0);
-				val &= ~PIN_HP;
-			} else
-				val = 0;
-			val |= pin_bits;
-			snd_hda_set_pin_ctl(codec, nid, val);
-			break;
-		case ALC_AUTOMUTE_AMP:
-			snd_hda_codec_amp_stereo(codec, nid, HDA_OUTPUT, 0,
-						 HDA_AMP_MUTE, mute_bits);
-			break;
-		case ALC_AUTOMUTE_MIXER:
-			nid = spec->automute_mixer_nid[i];
-			if (!nid)
-				break;
-			snd_hda_codec_amp_stereo(codec, nid, HDA_INPUT, 0,
-						 HDA_AMP_MUTE, mute_bits);
-			snd_hda_codec_amp_stereo(codec, nid, HDA_INPUT, 1,
-						 HDA_AMP_MUTE, mute_bits);
-			break;
-		}
+			val &= ~PIN_HP;
+		} else
+			val = 0;
+		val |= pin_bits;
+		snd_hda_set_pin_ctl(codec, nid, val);
 	}
 }
 
@@ -979,8 +955,6 @@ static int alc_init_automute(struct hda_codec *codec)
 		cfg->hp_outs = cfg->line_outs;
 	}
 
-	spec->automute_mode = ALC_AUTOMUTE_PIN;
-
 	for (i = 0; i < cfg->hp_outs; i++) {
 		hda_nid_t nid = cfg->hp_pins[i];
 		if (!is_jack_detectable(codec, nid))
-- 
1.8.0.1
