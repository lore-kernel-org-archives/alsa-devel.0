From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 09/20] ALSA: hda - Avoid auto-mute or auto-mic
	of retasked jacks
Date: Tue, 15 Jan 2013 12:05:36 +0100
Message-ID: <1358247947-13992-10-git-send-email-tiwai@suse.de>
References: <1358247947-13992-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id BB94A265327
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2013 12:05:50 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 90B4FA522B
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2013 12:05:48 +0100 (CET)
In-Reply-To: <1358247947-13992-1-git-send-email-tiwai@suse.de>
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

When a jack is retasked as a different direction (e.g. a mic jack is
used as a CLFE output), such a jack shouldn't be counted as the target
for the automatic jack switching.  Skip the automute or the autoswitch
when the current pinctl direction is different from what we suppose.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index e786f10..2020faf 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -2773,6 +2773,9 @@ static bool detect_jacks(struct hda_codec *codec, int num_pins, hda_nid_t *pins)
 		hda_nid_t nid = pins[i];
 		if (!nid)
 			break;
+		/* don't detect pins retasked as inputs */
+		if (snd_hda_codec_get_pin_target(codec, nid) & AC_PINCTL_IN_EN)
+			continue;
 		present |= snd_hda_jack_detect(codec, nid);
 	}
 	return present;
@@ -2899,7 +2902,11 @@ void snd_hda_gen_mic_autoswitch(struct hda_codec *codec, struct hda_jack_tbl *ja
 		return;
 
 	for (i = spec->am_num_entries - 1; i > 0; i--) {
-		if (snd_hda_jack_detect(codec, spec->am_entry[i].pin)) {
+		hda_nid_t pin = spec->am_entry[i].pin;
+		/* don't detect pins retasked as outputs */
+		if (snd_hda_codec_get_pin_target(codec, pin) & AC_PINCTL_OUT_EN)
+			continue;
+		if (snd_hda_jack_detect(codec, pin)) {
 			mux_select(codec, 0, spec->am_entry[i].idx);
 			return;
 		}
-- 
1.8.1
