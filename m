From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Apply reboot D3 fix for CX20724
	codec, too
Date: Thu, 10 Mar 2016 11:38:07 +0100
Message-ID: <1457606287-26919-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 31249261293
 for <alsa-devel@alsa-project.org>; Thu, 10 Mar 2016 11:38:10 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 61830ABE7
 for <alsa-devel@alsa-project.org>; Thu, 10 Mar 2016 10:38:09 +0000 (UTC)
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

Just like CX20722, CX7024 codec also requires the power down at reboot
in order to reduce the noise at reboot/shutdown.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=113511
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_conexant.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 6122b8ca872f..56fefbd85782 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -204,8 +204,13 @@ static void cx_auto_reboot_notify(struct hda_codec *codec)
 {
 	struct conexant_spec *spec = codec->spec;
 
-	if (codec->core.vendor_id != 0x14f150f2)
+	switch (codec->core.vendor_id) {
+	case 0x14f150f2: /* CX20722 */
+	case 0x14f150f4: /* CX20724 */
+		break;
+	default:
 		return;
+	}
 
 	/* Turn the CX20722 codec into D3 to avoid spurious noises
 	   from the internal speaker during (and after) reboot */
-- 
2.7.2
