From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Fix forgotten HDMI monitor_present
	update
Date: Fri, 18 Mar 2016 18:04:12 +0100
Message-ID: <1458320652-16861-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 962CE264FF6
 for <alsa-devel@alsa-project.org>; Fri, 18 Mar 2016 18:04:13 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 76A42AB5D
 for <alsa-devel@alsa-project.org>; Fri, 18 Mar 2016 17:04:12 +0000 (UTC)
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

We forgot to copy monitor_present value when updating the ELD
information.  This won't change the ELD retrieval and the jack
notification behavior, but appears only in the proc output.   In that
sense, it's no fatal error, but a bug is a bug is a bug.

Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_hdmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 8cdb804aa9cf..e7d9453ecd10 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1358,6 +1358,7 @@ static void update_eld(struct hda_codec *codec,
 			   eld->eld_size) != 0)
 			eld_changed = true;
 
+	pin_eld->monitor_present = eld->monitor_present;
 	pin_eld->eld_valid = eld->eld_valid;
 	pin_eld->eld_size = eld->eld_size;
 	if (eld->eld_valid)
-- 
2.7.4
