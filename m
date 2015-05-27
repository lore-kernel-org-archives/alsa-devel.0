From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Disable power_save_node for
	IDT92HD71bxx
Date: Wed, 27 May 2015 21:23:10 +0200
Message-ID: <1432754590-3026-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 5808F2602AD
 for <alsa-devel@alsa-project.org>; Wed, 27 May 2015 21:23:12 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 26971ABB1
 for <alsa-devel@alsa-project.org>; Wed, 27 May 2015 19:23:12 +0000 (UTC)
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

We've got a regression report that 4.1-rc causes noises on a Dell
laptop.  Similar like Realtek codec, this seems also triggered by the
recent power_save_node feature.  As this kind of issue is quite hard
to debug without actual hardware, disable the power_save_node flag for
this codec as a workaround.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=98971
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_sigmatel.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index 0de0fd95144a..6833c74ed6ff 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -4696,7 +4696,8 @@ static int patch_stac92hd71bxx(struct hda_codec *codec)
 		return err;
 
 	spec = codec->spec;
-	codec->power_save_node = 1;
+	/* disabled power_save_node since it causes noises on a Dell machine */
+	/* codec->power_save_node = 1; */
 	spec->linear_tone_beep = 0;
 	spec->gen.own_eapd_ctl = 1;
 	spec->gen.power_down_unused = 1;
-- 
2.4.1
