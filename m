From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4/6] ALSA: hda/realtek - Use
	alc_write_coef_idx() in alc269_quanta_automake()
Date: Mon, 18 Aug 2014 17:30:31 +0200
Message-ID: <1408375833-22957-5-git-send-email-tiwai@suse.de>
References: <1408375833-22957-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 3FD80265768
 for <alsa-devel@alsa-project.org>; Mon, 18 Aug 2014 17:30:36 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id E9C78AD62
 for <alsa-devel@alsa-project.org>; Mon, 18 Aug 2014 15:30:35 +0000 (UTC)
In-Reply-To: <1408375833-22957-1-git-send-email-tiwai@suse.de>
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

Just a refactoring.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 35f5012fc419..b4e7175dcb1b 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3346,15 +3346,8 @@ static void alc269_quanta_automute(struct hda_codec *codec)
 {
 	snd_hda_gen_update_outputs(codec);
 
-	snd_hda_codec_write(codec, 0x20, 0,
-			AC_VERB_SET_COEF_INDEX, 0x0c);
-	snd_hda_codec_write(codec, 0x20, 0,
-			AC_VERB_SET_PROC_COEF, 0x680);
-
-	snd_hda_codec_write(codec, 0x20, 0,
-			AC_VERB_SET_COEF_INDEX, 0x0c);
-	snd_hda_codec_write(codec, 0x20, 0,
-			AC_VERB_SET_PROC_COEF, 0x480);
+	alc_write_coef_idx(codec, 0x0c, 0x680);
+	alc_write_coef_idx(codec, 0x0c, 0x480);
 }
 
 static void alc269_fixup_quanta_mute(struct hda_codec *codec,
-- 
2.0.4
