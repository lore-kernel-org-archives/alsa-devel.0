From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 029/112] ALSA: hda/realtek - Remove superfluous
	input amp init
Date: Tue,  8 Jan 2013 12:38:22 +0100
Message-ID: <1357645185-7645-30-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 126602651AF
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:25 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 97575A5215
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

The amps will be initialized via activate_path(), thus it's
superfluous to set in alc_auto_init_analog_input().

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 77045e9..b1222cc 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -2755,13 +2755,8 @@ static void alc_auto_init_analog_input(struct hda_codec *codec)
 
 	for (i = 0; i < cfg->num_inputs; i++) {
 		hda_nid_t nid = cfg->inputs[i].pin;
-		if (alc_is_input_pin(codec, nid)) {
+		if (alc_is_input_pin(codec, nid))
 			alc_set_input_pin(codec, nid, cfg->inputs[i].type);
-			if (get_wcaps(codec, nid) & AC_WCAP_OUT_AMP)
-				snd_hda_codec_write(codec, nid, 0,
-						    AC_VERB_SET_AMP_GAIN_MUTE,
-						    AMP_OUT_MUTE);
-		}
 
 		/* mute loopback inputs */
 		if (spec->mixer_nid) {
-- 
1.8.0.1
