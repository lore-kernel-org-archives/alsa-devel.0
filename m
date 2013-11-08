From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda/realtek - Make fixup regs persist
	after resume
Date: Fri,  8 Nov 2013 08:11:00 +0100
Message-ID: <1383894660-13460-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 6C58E26560F
 for <alsa-devel@alsa-project.org>; Fri,  8 Nov 2013 08:11:01 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id F0212A6772
 for <alsa-devel@alsa-project.org>; Fri,  8 Nov 2013 08:11:00 +0100 (CET)
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

From: Kailang Yang <kailang@realtek.com>

Upon suspend / resume, the fixup register settings are lost because
sending HDA_FIXUP_ACT_PRE_PROBE is not part of the resume path. Instead,
write our registers in response to the HDA_FIXUP_ACT_INIT, which happens
after initial probe and upon resume.

Signed-off-by: Kailang Yang <kailang@realtek.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index daf720502385..6a214662700e 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3503,6 +3503,8 @@ static void alc283_fixup_chromebook(struct hda_codec *codec,
 		/* Disable AA-loopback as it causes white noise */
 		spec->gen.mixer_nid = 0;
 		spec->gen.hp_automute_hook = alc283_hp_automute_hook;
+		break;
+	case HDA_FIXUP_ACT_INIT:
 		/* MIC2-VREF control */
 		/* Set to manual mode */
 		val = alc_read_coef_idx(codec, 0x06);
-- 
1.8.4.2
