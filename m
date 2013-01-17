From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4/9] ALSA: hda - Give more comments to
	hda_gen_spec flags
Date: Thu, 17 Jan 2013 17:54:49 +0100
Message-ID: <1358441694-32004-5-git-send-email-tiwai@suse.de>
References: <1358441694-32004-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 1D6F0265255
 for <alsa-devel@alsa-project.org>; Thu, 17 Jan 2013 17:55:00 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id D2E9CA4F28
 for <alsa-devel@alsa-project.org>; Thu, 17 Jan 2013 17:54:59 +0100 (CET)
In-Reply-To: <1358441694-32004-1-git-send-email-tiwai@suse.de>
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

Since we have many bit flags in hda_gen_spec, rearrange in sections
and give more comments there.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.h | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/sound/pci/hda/hda_generic.h b/sound/pci/hda/hda_generic.h
index 59d08c6..dd0818b 100644
--- a/sound/pci/hda/hda_generic.h
+++ b/sound/pci/hda/hda_generic.h
@@ -164,27 +164,34 @@ struct hda_gen_spec {
 	struct automic_entry am_entry[MAX_AUTO_MIC_PINS];
 
 	/* for pin sensing */
+	/* current status; set in hda_geneic.c */
 	unsigned int hp_jack_present:1;
 	unsigned int line_jack_present:1;
-	unsigned int master_mute:1;
+	unsigned int speaker_muted:1; /* current status of speaker mute */
+	unsigned int line_out_muted:1; /* current status of LO mute */
+
+	/* internal states of automute / autoswitch behavior */
 	unsigned int auto_mic:1;
 	unsigned int automute_speaker:1; /* automute speaker outputs */
 	unsigned int automute_lo:1; /* automute LO outputs */
-	unsigned int speaker_muted:1; /* current status of speaker mute */
-	unsigned int line_out_muted:1; /* current status of LO mute */
+
+	/* capabilities detected by parser */
 	unsigned int detect_hp:1;	/* Headphone detection enabled */
 	unsigned int detect_lo:1;	/* Line-out detection enabled */
 	unsigned int automute_speaker_possible:1; /* there are speakers and either LO or HP */
 	unsigned int automute_lo_possible:1;	  /* there are line outs and HP */
+
+	/* additional parameters set by codec drivers */
+	unsigned int master_mute:1;	/* master mute over all */
 	unsigned int keep_vref_in_automute:1; /* Don't clear VREF in automute */
+	unsigned int line_in_auto_switch:1; /* allow line-in auto switch */
+
+	/* parser behavior flags; set before snd_hda_gen_parse_auto_config() */
 	unsigned int suppress_auto_mute:1; /* suppress input jack auto mute */
 	unsigned int suppress_auto_mic:1; /* suppress input jack auto switch */
-	unsigned int line_in_auto_switch:1; /* allow line-in auto switch */
 
-	/* other flags */
+	/* other parse behavior flags */
 	unsigned int need_dac_fix:1; /* need to limit DACs for multi channels */
-	unsigned int no_analog:1; /* digital I/O only */
-	unsigned int dyn_adc_switch:1; /* switch ADCs (for ALC275) */
 	unsigned int shared_mic_hp:1; /* HP/Mic-in sharing */
 	unsigned int no_primary_hp:1; /* Don't prefer HP pins to speaker pins */
 	unsigned int multi_cap_vol:1; /* allow multiple capture xxx volumes */
@@ -192,11 +199,15 @@ struct hda_gen_spec {
 	unsigned int own_eapd_ctl:1; /* set EAPD by own function */
 	unsigned int vmaster_mute_enum:1; /* add vmaster mute mode enum */
 	unsigned int indep_hp:1; /* independent HP supported */
-	unsigned int indep_hp_enabled:1; /* independent HP enabled */
 	unsigned int prefer_hp_amp:1; /* enable HP amp for speaker if any */
 	unsigned int add_stereo_mix_input:1; /* add aamix as a capture src */
 	unsigned int add_out_jack_modes:1; /* add output jack mode enum ctls */
 
+	/* other internal flags */
+	unsigned int no_analog:1; /* digital I/O only */
+	unsigned int dyn_adc_switch:1; /* switch ADCs (for ALC275) */
+	unsigned int indep_hp_enabled:1; /* independent HP enabled */
+
 	/* loopback mixing mode */
 	bool aamix_mode;
 
-- 
1.8.1
