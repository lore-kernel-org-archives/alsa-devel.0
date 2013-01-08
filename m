From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 034/112] ALSA: hda/realtek - Remove unused
	fields and macro definitions
Date: Tue,  8 Jan 2013 12:38:27 +0100
Message-ID: <1357645185-7645-35-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 7233B2651B7
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:25 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id AA125A522F
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

Also arranged alc_spec definitions to optimize bit fields.
Use a bit field for spec->need_dac_fix, too.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index d55db33..f5696ab 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -73,8 +73,6 @@ struct alc_multi_io {
 	unsigned int ctl_in;	/* cached input-pin control value */
 };
 
-#define MAX_VOL_NIDS	0x40
-
 /* make compatible with old code */
 #define alc_apply_pincfgs	snd_hda_apply_pincfgs
 #define alc_apply_fixup		snd_hda_apply_fixup
@@ -161,7 +159,6 @@ struct alc_spec {
 	unsigned int cur_adc_format;
 
 	/* capture source */
-	unsigned int num_mux_defs;
 	struct hda_input_mux input_mux;
 	unsigned int cur_mux[3];
 	hda_nid_t ext_mic_pin;
@@ -171,7 +168,6 @@ struct alc_spec {
 	/* channel model */
 	const struct hda_channel_mode *channel_mode;
 	int num_channel_mode;
-	int need_dac_fix;
 	int const_channel_count;	/* min. channel count (for speakers) */
 	int ext_channel_count;		/* current channel count for multi-io */
 
@@ -218,19 +214,15 @@ struct alc_spec {
 	unsigned int keep_vref_in_automute:1; /* Don't clear VREF in automute */
 
 	/* other flags */
+	unsigned int need_dac_fix:1; /* need to limit DACs for multi channels */
 	unsigned int no_analog :1; /* digital I/O only */
 	unsigned int dyn_adc_switch:1; /* switch ADCs (for ALC275) */
-	unsigned int single_input_src:1;
-	unsigned int vol_in_capsrc:1; /* use capsrc volume (ADC has no vol) */
-	unsigned int parse_flags; /* passed to snd_hda_parse_pin_defcfg() */
 	unsigned int shared_mic_hp:1; /* HP/Mic-in sharing */
 	unsigned int inv_dmic_fixup:1; /* has inverted digital-mic workaround */
 	unsigned int inv_dmic_muted:1; /* R-ch of inv d-mic is muted? */
 	unsigned int no_primary_hp:1; /* Don't prefer HP pins to speaker pins */
 
-	/* auto-mute control */
-	int automute_mode;
-	hda_nid_t automute_mixer_nid[AUTO_CFG_MAX_OUTS];
+	unsigned int parse_flags; /* passed to snd_hda_parse_pin_defcfg() */
 
 	int init_amp;
 	int codec_variant;	/* flag for other variants */
@@ -612,9 +604,6 @@ static void alc_line_automute(struct hda_codec *codec, struct hda_jack_tbl *jack
 	call_update_outputs(codec);
 }
 
-#define get_connection_index(codec, mux, nid) \
-	snd_hda_get_conn_index(codec, mux, nid, 0)
-
 /* standard mic auto-switch helper */
 static void alc_mic_automute(struct hda_codec *codec, struct hda_jack_tbl *jack)
 {
@@ -1619,8 +1608,6 @@ static const char * const alc_slave_pfxs[] = {
  * build control elements
  */
 
-#define NID_MAPPING		(-1)
-
 static void alc_free_kctls(struct hda_codec *codec);
 
 #ifdef CONFIG_SND_HDA_INPUT_BEEP
-- 
1.8.0.1
