From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 11/20] ALSA: hda/realtek - Read the cached
	pinctl value in fixups
Date: Tue, 15 Jan 2013 12:05:38 +0100
Message-ID: <1358247947-13992-12-git-send-email-tiwai@suse.de>
References: <1358247947-13992-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id B7D76265325
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2013 12:05:50 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 9887CA522F
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

... instead of reading the value from the codec at each time.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 183b951..7a4b783 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -1737,8 +1737,7 @@ static void alc889_fixup_mbp_vref(struct hda_codec *codec,
 		unsigned int val = snd_hda_codec_get_pincfg(codec, nids[i]);
 		if (get_defcfg_device(val) != AC_JACK_HP_OUT)
 			continue;
-		val = snd_hda_codec_read(codec, nids[i], 0,
-					 AC_VERB_GET_PIN_WIDGET_CONTROL, 0);
+		val = snd_hda_codec_get_pin_target(codec, nids[i]);
 		val |= AC_PINCTL_VREF_80;
 		snd_hda_set_pin_ctl(codec, nids[i], val);
 		spec->gen.keep_vref_in_automute = 1;
@@ -1758,8 +1757,7 @@ static void alc889_fixup_imac91_vref(struct hda_codec *codec,
 		return;
 	for (i = 0; i < ARRAY_SIZE(nids); i++) {
 		unsigned int val;
-		val = snd_hda_codec_read(codec, nids[i], 0,
-					 AC_VERB_GET_PIN_WIDGET_CONTROL, 0);
+		val = snd_hda_codec_get_pin_target(codec, nids[i]);
 		val |= AC_PINCTL_VREF_50;
 		snd_hda_set_pin_ctl(codec, nids[i], val);
 	}
@@ -3137,8 +3135,7 @@ static void alc861_fixup_asus_amp_vref_0f(struct hda_codec *codec,
 
 	if (action != HDA_FIXUP_ACT_INIT)
 		return;
-	val = snd_hda_codec_read(codec, 0x0f, 0,
-				 AC_VERB_GET_PIN_WIDGET_CONTROL, 0);
+	val = snd_hda_codec_get_pin_target(codec, 0x0f);
 	if (!(val & (AC_PINCTL_IN_EN | AC_PINCTL_OUT_EN)))
 		val |= AC_PINCTL_IN_EN;
 	val |= AC_PINCTL_VREF_50;
-- 
1.8.1
