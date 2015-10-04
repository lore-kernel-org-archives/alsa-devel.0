From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Disable power_save_node for IDT
	92HD73xx chips
Date: Sun,  4 Oct 2015 22:50:11 +0200
Message-ID: <1443991811-16715-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 1EB65265262
 for <alsa-devel@alsa-project.org>; Sun,  4 Oct 2015 22:50:09 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id D4931AAD1
 for <alsa-devel@alsa-project.org>; Sun,  4 Oct 2015 20:50:07 +0000 (UTC)
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

The recent widget power saving introduced some unavoidable click
noises on old IDT 92HD73xx chips while it still seems working on the
compatible new chips.  In the bugzilla, we tried lots of tests and
workarounds, but they didn't help much.  So, let's disable the feature
for these specific chips as the least (but safest) fix.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=104981
Cc: <stable@vger.kernel.org> # v4.1+
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_sigmatel.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index 9d947aef2c8b..def5cc8dff02 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -4520,7 +4520,11 @@ static int patch_stac92hd73xx(struct hda_codec *codec)
 		return err;
 
 	spec = codec->spec;
-	codec->power_save_node = 1;
+	/* enable power_save_node only for new 92HD89xx chips, as it causes
+	 * click noises on old 92HD73xx chips.
+	 */
+	if ((codec->core.vendor_id & 0xfffffff0) != 0x111d7670)
+		codec->power_save_node = 1;
 	spec->linear_tone_beep = 0;
 	spec->gen.mixer_nid = 0x1d;
 	spec->have_spdif_mux = 1;
-- 
2.5.3
