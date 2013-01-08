From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 033/112] ALSA: hda/realtek - Drop
	auto_mic_valid_imux flag
Date: Tue,  8 Jan 2013 12:38:26 +0100
Message-ID: <1357645185-7645-34-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 1DCCD2651B3
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:25 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id A4B24A522E
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

This flag is superfluous now and it's always as same as
spec->auto_mic.  Let's drop.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 5c5197b..d55db33 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -209,7 +209,6 @@ struct alc_spec {
 	unsigned int line_jack_present:1;
 	unsigned int master_mute:1;
 	unsigned int auto_mic:1;
-	unsigned int auto_mic_valid_imux:1;	/* valid imux for auto-mic */
 	unsigned int automute_speaker:1; /* automute speaker outputs */
 	unsigned int automute_lo:1; /* automute LO outputs */
 	unsigned int detect_hp:1;	/* Headphone detection enabled */
@@ -622,7 +621,7 @@ static void alc_mic_automute(struct hda_codec *codec, struct hda_jack_tbl *jack)
 	struct alc_spec *spec = codec->spec;
 	hda_nid_t *pins = spec->imux_pins;
 
-	if (!spec->auto_mic || !spec->auto_mic_valid_imux)
+	if (!spec->auto_mic)
 		return;
 	if (snd_BUG_ON(spec->int_mic_idx < 0 || spec->ext_mic_idx < 0))
 		return;
@@ -1004,8 +1003,6 @@ static bool alc_auto_mic_check_imux(struct hda_codec *codec)
 		snd_hda_jack_detect_enable_callback(codec, spec->dock_mic_pin,
 						    ALC_MIC_EVENT,
 						    alc_mic_automute);
-
-	spec->auto_mic_valid_imux = 1;
 	return true;
 }
 
-- 
1.8.0.1
