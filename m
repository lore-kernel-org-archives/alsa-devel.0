From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: [PATCH] ALSA: hda/realtek - Keep analog bypass muted
	on ALC892
Date: Thu,  9 Aug 2012 08:47:19 +0200
Message-ID: <1344494839-6942-1-git-send-email-thierry.reding@avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
 [212.227.126.171])
 by alsa0.perex.cz (Postfix) with ESMTP id B476F265291
 for <alsa-devel@alsa-project.org>; Thu,  9 Aug 2012 08:17:37 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Unmuting the analog bypass causes any input to be directly bypassed to
the outputs, which is usually not expected by the user.

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
---
Note that this patch could be generalized to include all codec variants
that have this second channel. As I don't have access to all the data
sheets I'll leave that decision up to somebody with more hardware
available.

 sound/pci/hda/patch_realtek.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 4f81dd4..54d0917 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3752,8 +3752,15 @@ static void alc_auto_set_output_and_unmute(struct hda_codec *codec,
 	if (nid_has_mute(codec, mix, HDA_INPUT)) {
 		snd_hda_codec_write(codec, mix, 0, AC_VERB_SET_AMP_GAIN_MUTE,
 			    AMP_IN_UNMUTE(0));
-		snd_hda_codec_write(codec, mix, 0, AC_VERB_SET_AMP_GAIN_MUTE,
-			    AMP_IN_UNMUTE(1));
+		/*
+		 * On ALC892, the second entry in the connection list is the
+		 * analog bypass. Unmuting it will cause any inputs to be
+		 * directly forwarded to the corresponding outputs.
+		 */
+		if (codec->subsystem_id != 0x10ec0892)
+			snd_hda_codec_write(codec, mix, 0,
+					    AC_VERB_SET_AMP_GAIN_MUTE,
+					    AMP_IN_UNMUTE(1));
 	}
 	/* initialize volume */
 	nid = alc_look_for_out_vol_nid(codec, pin, dac);
-- 
1.7.11.4
